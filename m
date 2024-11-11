Return-Path: <linux-pci+bounces-16453-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D019C4400
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 18:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3FBEB2CE8F
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 17:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D481A1A9B43;
	Mon, 11 Nov 2024 17:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ts5oqJc6"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2044.outbound.protection.outlook.com [40.107.104.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4261A9B45;
	Mon, 11 Nov 2024 17:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731346983; cv=fail; b=go+3nCWX8/n8TPo3PvTB4Ehjgv8MtFWxVndQpyqmDdeFIJp3USPHMuGgxG7FfCgIc8KYuVlc1bKZHUbQ6j/0Nlsow3uqzNcL7ohmwa6Km1QQsKQdzUJYEuFqQKhVZyxHV7U1eyVDNlmuyTpgyqioQNX+xIM+vvY/uTNXBdfq6fI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731346983; c=relaxed/simple;
	bh=1+0Vb4o6csXw0pXLibl6d7yHjiLdMrQJYrwz5hi77z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rCdjMo4+GfQLsmNmrpc0gPVXXZVQqqOWNLIkRout6ICefgmhM06sgwNmblLcxnocyLP+ETbqkGtxIZ42ODepiCjN96uebdckB/379BIkvJUArXu0j9ahOjpdBqF8s6Jc1EQhd+i2obygZklWoSIZRgw5iuqIha7eFJtDbCoNWUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ts5oqJc6; arc=fail smtp.client-ip=40.107.104.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0QECi2VIOKek8tEqSLlyt5zWD9QeCF+Hz7/kbiBbijMy9k0uJrDfDDnq2vxzrlSb4WJ/8/+tuwYdOfe85q/6ST/gmDCNOBKiAIduOFzgj3JI+0hkHfFFCVd+9z7+hu8T1Xj6mIeHP05C/DzjE4pQTshBtc/4BnvlsFQHC269xZKpLdLtzwYN1Uzsfsi3V9Y6LAOnuZQCv+gqVk7xxVETATXzxfv2PMNGj4o3oIk4Lfno20iygDXO5aHIhpsC6vkWLCSi4EIxRJy3TMM/jk19XTgKy89TATp/lYDNn+XRy3ccSPKitBeMlWV/nnkdotVlP1spNmjHK8vmvBFcNc8QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4u5Zl7Zogw2TdkgUBEle1+J4Dxvv9jLsUK/rMLWqHE=;
 b=QloGdtf+RUyUavYHb4ETkbZFcsEw+EdBUZQF6I1v8d9HG52gNQRsvx8jWPvWmZZC6PBZ9/BJmH5qbTMAZ8Ws65AYPMPl3WtinXD6F0Q58Xj27b9OsYFKxHJNIyUutgj7kzm/ePG4QgCE1OQ87kFcy+act8J/n5tPy19yUAbJlHaAZ25599usxQfGAMprUGYorsi0Lo+Qk2A/A7YB+0bSbk4JFB8VP+puokIoE2D7dLqMNIEi0zohrDHkd0E4Uyeli0ITr90SdGBBaTXyRDW0ariw6aEAAzzWi4mZy99jIsHtaRKQ7uEhvn+A65HtAmg2c6TcJ9wtD04M8EMSrNKkOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4u5Zl7Zogw2TdkgUBEle1+J4Dxvv9jLsUK/rMLWqHE=;
 b=Ts5oqJc6s1WpD9vVOYaJVYsyRI7Egi3vlGov3Ff7NFHRdzvUVnJk4l/JaaOvcDFtiGWfUtxsrJhhW/zILZPbsIsn/q6wBala0YBTAsQOJunF/rDaetfO4cedwJtH7DbP+oU20yK1FlL2QSnnK/YhoHkjon4isifVJ+Lxi1gFxHEaDqtpVvsMs4nBBjNNTUXWQcxR/Zyl34c9oZiapijM2HDy2J7w4Aqdk1E10Raq7kETG3ErsEbQAKN7Ez3OcNQRrj7cg6H1xWgbBs5q3K5uNzASy3naqBcofnUbrYTYa9i14LUs8HuReujoEBPOGQpyxLa6hBgMOq7eUP2iqslRXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB7700.eurprd04.prod.outlook.com (2603:10a6:20b:2db::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Mon, 11 Nov
 2024 17:42:58 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 17:42:58 +0000
Date: Mon, 11 Nov 2024 12:42:50 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>,
	jingoohan1@gmail.com, bhelgaas@google.com, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, imx@lists.linux.dev,
	kernel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PCI: dwc: Clean up some unnecessary codes in
 dw_pcie_suspend_noirq()
Message-ID: <ZzJCGkenhxgJxoC4@lizhi-Precision-Tower-5810>
References: <20241107111334.n23ebkbs3uhxivvm@thinkpad>
 <20241108002425.GA1631063@bhelgaas>
 <20241111060902.mdbksegqj5rblqsn@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241111060902.mdbksegqj5rblqsn@thinkpad>
X-ClientProxiedBy: SJ2PR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:a03:505::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: aef898b3-fc59-48d4-c61d-08dd027847ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVlxMzhPamIvb0hFSEdQYlROMmh4TkNvMjVhOVF4bEh3Y1k3MGk2MktmNnBW?=
 =?utf-8?B?YXVxQ2tRN2FjWEVtOUhuVG5qYm1jVEU4Zys0eE1Jbm1yd3paSnJ4Y0VsZHJz?=
 =?utf-8?B?ZGN1eU0yNitHYlhRc3VUeFU3dldvOWlTNXhnU0JKcEtRQ1BHVXR0VDZzWVc1?=
 =?utf-8?B?L042V3c1b1UvYVVvYXdrWXBOUmJZVXdXTWRJSkIySktBQThjTDU4N05ybFFC?=
 =?utf-8?B?Q3NWSm43MnNhKy9DNG1PMDFKSzNxYmpGSjlzdzZpbGM0KzVvcGNGVUJpRTB0?=
 =?utf-8?B?dEd6MFZCNHFqeUxTSEFrM2Zmb3FtaFR3RzYyVlFCZ2JFTUJpUW5ET0xzdUNl?=
 =?utf-8?B?djExVjBSUGNWUEVEcXhTdFErbmR0MGJhdDJiSmM2Tm1sdGJWazliU2p4TmNJ?=
 =?utf-8?B?UTQwNEJYWHBtU1ZRaFcvOEF1eWRodnJ6Q013VVdCRDdlc0d2eXFKUE5tVGd5?=
 =?utf-8?B?TVpha2VFWFppV0swalRIWkwreHA5OUxHVHEvaGZaZ1NDNXA4NVh0SlhwMmo2?=
 =?utf-8?B?R2xQbm1Cd29iWlJ4eEtDb0FIMEpLNDQ0M3BGMmJ6QWtObUJSb1poS25oNnR0?=
 =?utf-8?B?cHRncEg1NW1LZXluYlJONWI3alhpMkJCRktBMmcwb3kvL1dWMEtWVGltQy9u?=
 =?utf-8?B?c0cwYUtxNlVlUUMrZjFPNUNHbDlkc1EzQUJYaHNuanV6c1RKb3dBa2R1T05W?=
 =?utf-8?B?S0NDUmx3SXhhRnVBVStVczNpR3U4aTFVeFVKbmo3OG05WFpGWnp6UUJ6czRT?=
 =?utf-8?B?enk3THVDMkFTbnZuRFYxaG1nSHFkWDk1NUIwTGVXZTNqMllmdDM0ZzJwVmto?=
 =?utf-8?B?U2cyZmNkK20rM1BJQ05QTUVJVXVmS0dpTkkvVG9DMmQ1aEVNSXRIMWRLbWhV?=
 =?utf-8?B?WHZQdkJuQUxxeGhMbWhvc2RMcHcxTnc1VGxhQ0RLQWFTeCt6T2x3VSs3YUFQ?=
 =?utf-8?B?RkpsdjMzTnhkK01XNjhWTmNFdmFpRk9xNFFRTnUzbVQvNXVRUjQzYVYySDE0?=
 =?utf-8?B?WUpzdEI2NUtZWGhrYkhtSHFacVFlcVhZZWpIWm0xVG42UGpaNDd6emRSVlVq?=
 =?utf-8?B?YUhEbDRWSDhJUWQ5K1B6MjNXNklHb0Q4SDU1Tm1CdHBYSDJYUFpjSDh6N0l6?=
 =?utf-8?B?S1lRcDRwRDlQbThvS3pZdWgxd25oRHdiV2JoVDQxbEVPTENFYU9OQ2hKL0dH?=
 =?utf-8?B?Wk9qcWNDTFEvVlE3bFFSN1VnWkR0WkJsQ1M2dzU1OXNLUzUydmo4ZGt6S0ZX?=
 =?utf-8?B?WE05a3Uwa2J5SjJBTjBUSlB2U2lVa21DUzg3MFd5L2FLN1lFQU52aEV6MUJY?=
 =?utf-8?B?VmZURWJoc09ZOGlKL1NHRGJRQ3BHV3AxWVBNL1JqVkFobi85Zm1VWXdEcVdM?=
 =?utf-8?B?UGpsQnRKQWI5NnU0bDh5NDlEWnRSMGVJTmVFYlRGMDIwNmw1YnRTcWRPbmxy?=
 =?utf-8?B?VVFKY01GSTJjUXp3SFhIdFZlTlg4KzZiL1hUbFlUbTA3TFdMcVNHa1ZxRWdH?=
 =?utf-8?B?WE9KSTJ0cDE1aE1pR3k2c1A1LzFjVTNYUWdJdTNwa2JOMTFjY29NM2RxR1BJ?=
 =?utf-8?B?bHNoWVhaRnp2a1N0TGRPdExhVTk4UURtTWNVZE1rQVF6WGlhWjU3ZVVMUGdY?=
 =?utf-8?B?cThudVdNZERaQlNlQnFHNE1tKzBOOWFoVzYzYWZJVmErNDYyV3gyYjQ3d2ky?=
 =?utf-8?B?NFFzeXBOWW9oTzVwd0VMVUJiN0dHV1lnQys4Ym9ialdUeFR1SGhTek1pSlYx?=
 =?utf-8?B?MXBrU01OUlJOMm8zVC9hemVsTDM2enJaNnpiUG9maUZxRGl6Szh5TWorZzUv?=
 =?utf-8?Q?DQ+LEZrDy49xnCZRO9ahjSRKhWF40CjWQrfVg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWZrZEhvNHlnSmJYeFd5UnpsTFIvenZNQytSSHFrTGcyYmdGMkZCU3JEOENa?=
 =?utf-8?B?UDhpV0lvb3ZqNE5EY3E5TmNpWE9zRnRMN3dQMHFDNElxamNUME1nR3ZqY0c4?=
 =?utf-8?B?Nk44SlBHUUIybHoyMmovTTZDRkFyTmJjTGVoYkxYWW5rT2ZwNnZ5a2RhUGtQ?=
 =?utf-8?B?UVBTNnJCWThRdVJuRlR4RWpnemNoYUFqMVdpaEhMNFhCcjBRelJZMEpkTXcz?=
 =?utf-8?B?TXdYRUdtMlE0QVkrMnM0alJPSDRXcndHM3B6S2NVZVg5U1N1VHcxckJNQXNz?=
 =?utf-8?B?c1hHWE1CZFhNUnBIaGh1M3NwQWt1VjU5WmQ0dkRWbEszVXZKMmxDc25oSlVK?=
 =?utf-8?B?RGFPbDFKOUlFTC96VlFhcTNtNXNneFpiNEtFT25TUXFJMG5wVWNDQjJkWGE3?=
 =?utf-8?B?SFBLcUpzcWVYaTBFVTZ5SFdoaEI5cU43VXZNdWFtYzlQNVpCTi9yQTdZRThi?=
 =?utf-8?B?MG9tVzNLYkl5WjVzTHN2dDlSUnh4TDRnMlMxVjJDcXFScER3WXhNRDFjdTN5?=
 =?utf-8?B?Z1VBQ29XSlZuVlZlVEM2MnQrNm9BQmUydWZzSVFIMDFQcitvbVdvNktHUHF0?=
 =?utf-8?B?ZXN6dmdhM3RSRDdzdTVNSlFEK01xaTd3TnR2dGl3aUIyU0p6TGVSeGRRVHR3?=
 =?utf-8?B?ZzZrUk4rZmJqMnhLL3NnelVFWElwSmhWeFFVaGo5SnA4ekZ1bXk0WnM1c29k?=
 =?utf-8?B?SVVPV0lpNUxWd0w0cGdVbDN1YWNYdlVFWkZUbk9lYXdsUmhodDdkbjE5aHg1?=
 =?utf-8?B?R0R3MEw1azllNGpPZ2lFYTE2SXd5d01pTjV4NTNjS1NUWXkvR3ZRRWZuZ08x?=
 =?utf-8?B?RVdIb3pUVVZObmRDbGNEY2ZrUkhzYk0zazU0bDVyZ1VGSDFKVXk2dUdRUStX?=
 =?utf-8?B?cG1tQW9hYmJVeTB2WHNVYXhFWUFtSjl3cWsvVlBZSHg2aVpuOWpzRkZqUWZi?=
 =?utf-8?B?cVg4OXIzdW5oWDdUOHlFNzQwUE9QQlI2MmVHMjUwaTA5Um4xRnM0TXlndGcz?=
 =?utf-8?B?YkFZaHVmc3NoTFdzKy9saXNuanFodkNxWjlSdU5hYUl1TnlURllBVnFqWEpZ?=
 =?utf-8?B?NWpMaEpOWUQzTDlEcUgzeXRuaU9wSXVuY0ZsVG5ZckdSSFc1a1FpNlgrUXFm?=
 =?utf-8?B?aUdBNmFySU9WaGswc09XMURjcU5TSjJrSWRSUm1lYkxxMWJoblJCOUdwdDJG?=
 =?utf-8?B?TElLbStoRVQvb0RsVnV4aS9wNXI3cFhBemgxUWtiZ3liWXBHdEFBdm5Cb0tu?=
 =?utf-8?B?OXE0bkYxOFAreFNqUUFRbUQyNTQ2RFU0cVVDVlFxK1ZmV0FMS2hmdXBPSkdo?=
 =?utf-8?B?Z3NXejB0aXpXSEhxWXR2dGxqOWxPN3NFZXJ5UTZiendOaGtlNXJDUzhBR0JY?=
 =?utf-8?B?dzl5Q3pIYk5BdUx4M3QwbTBRU3FFa0k1bHdYSld5S0RnOGRyenZDZ3JERkhv?=
 =?utf-8?B?WjFBZTMwUEkvckk3dDliay9CSWtWZm5YblIvZEsxZjhTWlgzb1BzazgwNy9D?=
 =?utf-8?B?Z3A0dENnak5WdnJTSXo1c09RemFDSHJMN1lmci90ZzNmZ3JzOXlKcUlNSkVu?=
 =?utf-8?B?N2NXV2NVaVc5SW1OeUQrMmpvTENzYVI0bUxaZVE5Z0pYcWpabjFnQ1VvdzdX?=
 =?utf-8?B?dForR2l2MU5rS1BOQk5scFZ1SU9TbElSVnU0b2NPRUVwSXQ5UlRpclZwRFNY?=
 =?utf-8?B?UE55RHVIQjhHQnMySjJacFl1WTIzR1NWcUZ4aVllNVI2M1pCT0ttNlpMb1k1?=
 =?utf-8?B?bXdZblhUNXNta2hsQS93cm85UExQRi9xNGtMZ2NVQWVkYkpJdVg5b3ZudHVF?=
 =?utf-8?B?eEpzZFRsdnZBcS9lc0xlVE5BbHhlYUlLcXpFRjV6SkozQk5YeGVIOHVxcWs5?=
 =?utf-8?B?WWxGbXpSWmIzd0FCb3IyelN6bG8zMCtMamFXdWdwR3RKOHhxRXpGRStqU25C?=
 =?utf-8?B?bitEbnlQSHV3QkxWVHVRejNMK002bThVRVNER3BXaW04WDdpc281bDJpd1U4?=
 =?utf-8?B?UjlGclNZeE9kbFd0cFZLdU5xdjFOVEtFRWo3c1Roemw2ODZxcGdkcUhWNU9m?=
 =?utf-8?B?TUdzWm9pM0dWUmxMSERqVk9DUFVmZENIZGxIbWxoWnZIQk9DVXVaYVNZTlQ4?=
 =?utf-8?Q?abDc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aef898b3-fc59-48d4-c61d-08dd027847ee
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 17:42:58.4185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V26TjJSkn66fXnwQGTf9ILDAu/SHO94ZX9E9hhinsQDTX/pYJZ6ihTLtdPkBCwjlrmZ/nlEF8uVdY9DcnfVfGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7700

On Mon, Nov 11, 2024 at 11:39:02AM +0530, Manivannan Sadhasivam wrote:
> On Thu, Nov 07, 2024 at 06:24:25PM -0600, Bjorn Helgaas wrote:
> > On Thu, Nov 07, 2024 at 11:13:34AM +0000, Manivannan Sadhasivam wrote:
> > > On Thu, Nov 07, 2024 at 04:44:55PM +0800, Richard Zhu wrote:
> > > > Before sending PME_TURN_OFF, don't test the LTSSM stat. Since it's
> > > > safe to send PME_TURN_OFF message regardless of whether the link
> > > > is up or down. So, there would be no need to test the LTSSM stat
> > > > before sending PME_TURN_OFF message.
> > >
> > > What is the incentive to send PME_Turn_Off when link is not up?
> >
> > There's no need to send PME_Turn_Off when link is not up.
> >
> > But a link-up check is inherently racy because the link may go down
> > between the check and the PME_Turn_Off.  Since it's impossible for
> > software to guarantee the link is up, the Root Port should be able to
> > tolerate attempts to send PME_Turn_Off when the link is down.
> >
> > So IMO there's no need to check whether the link is up, and checking
> > gives the misleading impression that "we know the link is up and
> > therefore sending PME_Turn_Off is safe."
> >
>
> I agree that the check is racy (not sure if there is a better way to avoid
> that), but if you send the PME_Turn_Off unconditionally, then it will result in
> L23 Ready timeout and users will see the error message.
>
> > > > Remove the L2 poll too, after the PME_TURN_OFF message is sent
> > > > out.  Because the re-initialization would be done in
> > > > dw_pcie_resume_noirq().
> > >
> > > As Krishna explained, host needs to wait until the endpoint acks the
> > > message (just to give it some time to do cleanups). Then only the
> > > host can initiate D3Cold. It matters when the device supports L2.
> >
> > The important thing here is to be clear about the *reason* to poll for
> > L2 and the *event* that must wait for L2.
> >
> > I don't have any DesignWare specs, but when dw_pcie_suspend_noirq()
> > waits for DW_PCIE_LTSSM_L2_IDLE, I think what we're doing is waiting
> > for the link to be in the L2/L3 Ready pseudo-state (PCIe r6.0, sec
> > 5.2, fig 5-1).
> >
> > L2 and L3 are states where main power to the downstream component is
> > off, i.e., the component is in D3cold (r6.0, sec 5.3.2), so there is
> > no link in those states.
> >
> > The PME_Turn_Off handshake is part of the process to put the
> > downstream component in D3cold.  I think the reason for this handshake
> > is to allow an orderly shutdown of that component before main power is
> > removed.
> >
> > When the downstream component receives PME_Turn_Off, it will stop
> > scheduling new TLPs, but it may already have TLPs scheduled but not
> > yet sent.  If power were removed immediately, they would be lost.  My
> > understanding is that the link will not enter L2/L3 Ready until the
> > components on both ends have completed whatever needs to be done with
> > those TLPs.  (This is based on the L2/L3 discussion in the Mindshare
> > PCIe book; I haven't found clear spec citations for all of it.)
> >
> > I think waiting for L2/L3 Ready is to keep us from turning off main
> > power when the components are still trying to dispose of those TLPs.
> >
>
> Not just disposing TLPs as per the spec, most endpoints also need to reset their
> state machine as well (if there is a way for the endpoint sw to delay sending
> L23 Ready).
>
> > So I think every controller that turns off main power needs to wait
> > for L2/L3 Ready.
> >
> > There's also a requirement that software wait at least 100 ns after
> > L2/L3 Ready before turning off refclock and main power (sec
> > 5.3.3.2.1).
> >
>
> Right. Usually, the delay after PERST# assert would make sure this, but in
> layerscape driver (user of dw_pcie_suspend_noirq) I don't see power/refclk
> removal.
>
> Richard Zhu/Frank, thoughts?

Generally, power/refclk remove when system enter sleep state. There is
signal "suspend_request_b", which connect to PMIC. After CPU trigger this
signnal, PMIC will turn off (pre fused) some power rail.

Refclk(come from SOC chip), OSC will be shutdown when send out
"suspend_request_b".

Frank


>
> - Mani
>
> --
> மணிவண்ணன் சதாசிவம்

