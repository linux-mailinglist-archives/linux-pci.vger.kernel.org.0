Return-Path: <linux-pci+bounces-15363-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 426E59B116B
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 23:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06C3B284357
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 21:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00E9218946;
	Fri, 25 Oct 2024 21:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ebTBwSEg"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DA2215C52;
	Fri, 25 Oct 2024 21:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729890322; cv=fail; b=kKCGJXOkaX/YOUr/UYwPJ1dvZgK33bQZFxFrcNmm447DxxuosaWw7dBtBLULqFJz9EtfQ0AtPRK9vR0RT3fReE4GwpYu8f9Rs/+O0hHY1cyEHnv2poX0ghXl0CmwW+IpkXTogaKBbE8mCH4EK+PuQRqI9Fhw8peMi7Pts8Zi3W4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729890322; c=relaxed/simple;
	bh=ydwdvFp6vd8L4I1VA3Rk7zCaqzcGvQsYEwd7S8hpBro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=elgLt8+EZ52/vlQZGhfVXdl3LDyr7sdqTYt4t2Xffi3IuTmDrAhwhfXP//Hvi6UPG6+APDk66HUtHLzX9o4BVm8OCMNHiukVo6jhrTy7rc91KK7LTajWCxoUstrOzPP/1FgAUItMKTey52wOxjM21VVHG7aZv9yzuYC5xte8AmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ebTBwSEg; arc=fail smtp.client-ip=40.107.22.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P7oqwrYyltgDOK36r1jO7YXX8ZTGKMuJZjjdrOHsSgurkYpU87mmETtHyutg4TKc3tgCuAJXjvuYlFiSSTEqeePnSBB2u3BlO3ndoJdNfd9BXSmEBgk2HbRjQbX9WjkY7+oODp1IvvxJ+6vQNh8MxKQl2NPnn4342PUloG+TXq71Cuc196oGn9Q/4toa0Lwx7TTIzcqwY55AzXCpEfleGxhBfJtiLF8IKJ6cp5xktxAl87YT/HnCAu5crokR6vJLZYKFKs7+S8BKiWkj7vHyffFVI+cZta6UdQ7RKEkdZx0P1GRxcNKoIHcrvl5Qvii6jG0H+idYJF92+6oGG9bq/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejTsSXODF4Z4HxJfwkbHKbPA09zgjJ+/6I2wKOYn9A0=;
 b=gwmBh5XDaqPj9RJp8clkpcFfA5L8816Jh/zBmZ3NcYtP2g2Lasu7s3DqWFCql2YlgrMNbTzxXLGf/z9o9uHiY20UvZvrvg7YXX1w6A2U9I1p2Wg2O98ktk0+QjVfP6eJ8bTF4XYA3vm381UfzpKI7WuW8lK3/90zZ9LZr0XJ8iSZjW7fuKR0S3/MVIphMNa5lgvFNX32hTNCcIgTOtbbIi0pGVMxs4DNq5RcgFjLVjuv36gQmqNYvI6JTciiwSVw7Tpupb5HSQVwBG7NKzoAfoYuEHte21ACLwhe0wUCVb33UNC2tCL4zeqoaeSe149ruWtgbwIm7DGLB7YXtEMaQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejTsSXODF4Z4HxJfwkbHKbPA09zgjJ+/6I2wKOYn9A0=;
 b=ebTBwSEgiHwRzwazBGBBmKwVDBo3T3gh+BbOqZHVJZsh9mjDd+4LyZMtj1OwJSNlaCAu9/DzuICcujUH+Ps6YvDPnqCB2sKDIIGhTze9k7ucrYBgIQCQaeRyXnTXGKTalEWjVqXeld3ncASL1neKkXcrldf4HqmtTKfP4dnMRdOpYBlGSiMr0RXcnpUaS+B6cbtyrAjtF7Fs1KI3A5hb3vTs9okOPNocuVuMgS84RwG8MSjM9UpG/yhfcdxn987o6bbBH992RmAzVaK9Qfk8pDecSDX3+JvI/SjAFqrRtCnrRRIMyhtDw6Trmun3U6sCmqYgOVOi5jV+zvoSYlIMUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9698.eurprd04.prod.outlook.com (2603:10a6:20b:481::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 21:05:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Fri, 25 Oct 2024
 21:05:15 +0000
Date: Fri, 25 Oct 2024 17:05:03 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@axis.com, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 0/4] PCI: ep: dwc/imx6: Add bus address support for
 PCI endpoint devices
Message-ID: <ZxwH//clayRL2emF@lizhi-Precision-Tower-5810>
References: <20241024-pcie_ep_range-v4-0-08f8dcd4e481@nxp.com>
 <20241025204818.GA1028925@bhelgaas>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241025204818.GA1028925@bhelgaas>
X-ClientProxiedBy: BY1P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9698:EE_
X-MS-Office365-Filtering-Correlation-Id: 89d4e307-0529-4ae5-b02c-08dcf538b935
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXRyTWZYNGZ4TUZwajZ6c21UMjhGbHpPby83Z2p1SXNOeXZBQUZQTHIwdzVU?=
 =?utf-8?B?dWlwcndnb0t5UU0yQnVzN3NPaEdaOXJTVGdaWmk4bEtlcm5EaTNWditBekp5?=
 =?utf-8?B?S1FORTBtb1ptVnVibjhTWVVIR2QwM3Mxd2tDOHFKR05lV3ZVcEU5M1N1VG9o?=
 =?utf-8?B?Zi81YWRUS1g4SFdCMFJ2a1o1UnozY2kyUGMydkdrOE5hSVdjSHpyQXZyV0hD?=
 =?utf-8?B?eG1rVU40dWhoMU53Q3cvYVhEQ3RYRjVrN21BSE9TcmdBWEI5UkxiUXExbWdq?=
 =?utf-8?B?NUk5YW1iMkJzSmVPcVBERXdqZHBpQXVtRUx2ck9mVFRIbHVjZE9mL2k4WjlM?=
 =?utf-8?B?djZ2aDZLb2VYVXpSUGltVEJBTzM0RDZTWjM5RWVJQ00zOXR2OEJnMUFqQ2Jl?=
 =?utf-8?B?RXBKc3pHanB4ZmFlZm4zRWVwL3VtSCtVSmZabXNWRGcvMDlQMDBNcXg5MnAv?=
 =?utf-8?B?Y0IwTzdyZUp2MS9HaGxMZXYvajNCRDIxUHVHaVRXR0hmL2xQVVBGYVY3KzFY?=
 =?utf-8?B?M3ZsNkZVRDY5TTAyT0pRaGFLd2g1NVBwcks5YU9vR2J1Z1dIdDd4ZE1CYml5?=
 =?utf-8?B?V2o3elVIMVpXVEczMkIzRnk2cDNDNmVZSlU0dzNyUWdNS2JPeFQreFJOa1Vk?=
 =?utf-8?B?c3gva2lwSEJuZTdiYUhKMHkwT0s4Z2lqT3NNTitKbDRQRkFoUU1kQUdtTGJ0?=
 =?utf-8?B?Njk3UHF4OHhPWUpCQStTVldlbEliWkdGYzFWV3FuQmJwZmtOSy91Z2s3Q21j?=
 =?utf-8?B?NHVlMVpSdS85aDFUVWxXcXMvdVhTRVVmTENTMit0QjZpV3pvTmVpbXBrU0oy?=
 =?utf-8?B?aDJsZHYyNzBwUy9NeTVHT3dOQVJ5YktMMWtOcjFhc1hXM29SaGpTMUlxOHpl?=
 =?utf-8?B?S2FsOWxjQ2RjcFRBZ3h6N3RCSGJQWS9hOE1xUDh0blRLUnhUclA3Vm1CM3Y3?=
 =?utf-8?B?YzZqUGp4dFU4eU0wSkpjMnlPZm5ZV20vVWwxZzl1L29OaDl4d2VJbHJCSU9D?=
 =?utf-8?B?MHk4ZEFxaEdJZCtGZFlKN3B0d1pUTVN4TGdDWUtBSGtKNEhZb0cwTEczazJk?=
 =?utf-8?B?SkNVNG5CSTJGc1RTQUpiUFQ3R0l0OVkxNWNPVXo4ZlI1Yi9sYnBhWlVTT2FS?=
 =?utf-8?B?V3hPczBBNVYvY2VPeUdrNGZCQ0FUZVRnYjg5N3Z4dWthMFVoVG5sWG9wZnJp?=
 =?utf-8?B?TGt4OTlHWHFCVVo4bXdkS1NsU3VYN0RscDU2UmgzdEEvRzNqTmM4VjlMRGRw?=
 =?utf-8?B?ZVdzRXVnbnVrVTZsSS9qV1dtSXpwSWF5ckNpRDdNaEEzeDNERSs2SVoybElW?=
 =?utf-8?B?a09Xc0M3OEV2MkVQamVFemwvRGV1UzZHZERXNkxybCtUNEEwZGJVS1p0ckRU?=
 =?utf-8?B?MlExRk94djdUQTVuM1VpSUdzaytXTS9LVTV5MCsvaE1mTGtkVmMxeFhwcHlG?=
 =?utf-8?B?eHlQSlVnQlJVbHBRVzRHS3A1RjI1aUd3SUhhTWdLV1l1K3dtQkI2b2ZVeGFO?=
 =?utf-8?B?RkJ4VGtIY3o5WXRNWFZlNHIzdUdmVzE5RnJUZm1EQjMyYTVNQ3dQc2lGS3A0?=
 =?utf-8?B?SnA2VnlMVlZ5MlJBNFFsU01udGRaRk9aR28xV1RqSkRXQkdVQ2I5YXl2SVRh?=
 =?utf-8?B?bTYyblAxNmtmNjRVbm0zRG1XYnhUTXBWc1BSSmhMOTRmd29qSTMrd1Zwb01X?=
 =?utf-8?B?WExMU1JnRlYvdFU0U0hzWFk4WlQ4bmM1L2YzZDdSTS9uRjNpZUtKM1Budm1B?=
 =?utf-8?B?SmRPSk5JaE9Kd2c2cnAyTHdmYUR5RWJDbVBKaXcxaFRQTFJsNjV4Z09tdUUy?=
 =?utf-8?B?RUVTNit3dHRxZU9JQlkxbHhMN3hTeWF0NTRFRFp6Y01FWEJtYnkzUmkwMkVR?=
 =?utf-8?Q?ug34pFY9DuQ8A?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUN5czlRRVg5UUg5ckh6byszazFFakUwUnlHdGEyS0oxbUM4cWRiYlJXQi9G?=
 =?utf-8?B?VTBMVDZwdjZQNmlLVUxBVzVLOEpmK00vZlZLblJhY2VxeUJjdnF1MWVIT2RB?=
 =?utf-8?B?SGxPeWx2VldhNlcyQW1naTJuVkI2Z0hZSlNtWEFwYzNpdUFJMm1TUUtnL1lI?=
 =?utf-8?B?cHpLZ1BUWnMzSkVKRG94VzJJVGxMTzNCTlRFK1c0QjU5OVpCL3p3ajhhZU9G?=
 =?utf-8?B?WnFhbVdPTGZTbEdNWHJPK3EyVklRUmZuaUloemdTRGltK1U4SjNPUzZ2NUlE?=
 =?utf-8?B?amF1YzZ6ZkFjRDArdUt2OVpXNmptdzcrMGpHRlp3elV4M2FkREQ4eFM1SUJX?=
 =?utf-8?B?WCtrdmVSV2xRUjZFbzhZMHpGMjdXRVkzNzE1d2JHR2pGQ01ZMUJ4aldpS0pB?=
 =?utf-8?B?VW9Wek56SnZkOVE2Y2VyZU5PY3Y4OGI0cTJTTGo1TDdnNmtyY3VNOGhuSlFj?=
 =?utf-8?B?SmNsMHplOFNDOFludkR4OG02em56cHdRa1poTFVubGl5UmxJZS9QRkNlU2ZE?=
 =?utf-8?B?Wkd5M044YUs3L3BjUDAxS1ZvVE0rd0NLMktMRTdBL25WdjlOUm0xRThmVjdq?=
 =?utf-8?B?b2dlZjZsd1FkMnhJcnJ5TjVnRlQvUHdZN28xRkJPOThCanNmdm9UOE9QbkF4?=
 =?utf-8?B?R0ZSenB0ckM1RTk2a1RFNzA0VDIxeEp2cVNTQ2Y5M2VKdUN0WEIwOGxqWkRV?=
 =?utf-8?B?Z20zdHBoNjV3ZDZLWEEwSjNCWDhBWTFzbDZ4OE9ESzlyZWozbnBCLzR5b2M4?=
 =?utf-8?B?NEkvdGEzNld5ZTVFa0d4QkdPRkJzemVZZm1zbHpYRWxnR1ZTN2duQTBqS3F2?=
 =?utf-8?B?UVRLbHpReVlVajlIU2dlOEx4TnFwcnA2RXdKRFlDcjNOSnZKMlVHdmlaZW9p?=
 =?utf-8?B?Q0ZBYXZ1THd5Rnc5cms3ZThtUDJoM1YvcU1McE55VlRsVUpuY1FTRkN0WTE4?=
 =?utf-8?B?YlhQVTNDTU9nOGNGZW1CK2ZQazNMaUZQdW5yVDVKVDRUWFJFREtsRzJTTUlv?=
 =?utf-8?B?MEF2YlY3L2FaeTBzcTlpM1ViWkxvT283b1I0cXB1aVZ2RVhDZC81elJqMGNB?=
 =?utf-8?B?bmR3dFgzSmdlRjJac2RRRXRRM0MyeE9Mb002eDZyV01VN0tRdHl5b1NEdktQ?=
 =?utf-8?B?ZHZlQVpnT1R5dzlUVXlFcmpqZnFyNVZyYTlGVUtiakk3YTRYdEhhdWQ5cW5Y?=
 =?utf-8?B?NGxOaUFhUUp3Ym54dG5rTWZzWnFjcGtPYkhyVlIyTStzZGFxK0VtQmtSQ1U1?=
 =?utf-8?B?V0lxbWxjR3JseDZrOE11eUFkMkNEYkY1KzhHTDFSVzN2bm5SSFRMaWVFUnBr?=
 =?utf-8?B?V3JTNHp3c3pjVEM5SXhPVlZiNi9kOGhyWXpwbnNWbjE0RXRDeVY2NkZ0MGdu?=
 =?utf-8?B?ZC9mRHVYbDEzWCtrWW5BenlVNGtHcW5Cc3FQemFmQzNza2I0T0NoNUFsdDR0?=
 =?utf-8?B?V1RFVkp4TSs4a2tNb3NjR1I0WWNLV012VDJUVng3U284a2MxcmQ0Q29MQVBE?=
 =?utf-8?B?SGg1RlI0L2UxK2tyUU56blRqRjZ0d2xSNmhMMFpBR3BzQU5rc3IvOFRMWGJa?=
 =?utf-8?B?b0t0UWNuSFdOYnYzb3Rpc1Bhd0N6dHVzcElzRURNMmZjeUdqL1hvMjE0aWRJ?=
 =?utf-8?B?SXluWjVvY251OEFUNlF1QjBmS1I4ZU4xUWFWUUNBQnhCRHNRbU45ak5nN3lj?=
 =?utf-8?B?NFBka3NVRkRxNVlIeDViTWZrcUJEMFA4N2VOYncxT1cyOG5zYllJb3YyV21v?=
 =?utf-8?B?am9GTjc1VytlNTZnMlJwWFlMd1BZVTVVWmRzNEtPNUtsVVlLNVluMVJ4Wi9K?=
 =?utf-8?B?YmpVT2FSSXN1VGx4emsvQmN2RnB6eHhRQ3NMclBaczdHS3V0YnZpWlIrU1Mr?=
 =?utf-8?B?NS9EeVlJaTZMZzMvV2x4NXNZVG9OQ1l4OWxJU3JLNUJtWHl0RGROOVdibnZN?=
 =?utf-8?B?bklhWjcvT2Q1bjl2cm9QNFFLWkhZd1ErcGFWN05GbUFlV2hMemJUQVN5ZXNw?=
 =?utf-8?B?RVlPSWxScm1qL1l5aWFkdDlHZXBZUzNqbTQyd0FOU3E0K0VnampCN3F4ZDBZ?=
 =?utf-8?B?Q2Vid2YxRkpWUU9IMVduWkFUZFdWd3JuYllJRXZtcEdDNUwwZkRqWGhGTExK?=
 =?utf-8?Q?DySuds3mxq8Xx2+o93CNYO6y3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d4e307-0529-4ae5-b02c-08dcf538b935
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 21:05:15.5513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +5yV6eDEyN1qPBwtkOkifU4o355qD6sOsj1X6PSf4uUVBSRtPhWTF0zRBZZ82JKklAj3B/UV87m3Sv5VQ8SYVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9698

On Fri, Oct 25, 2024 at 03:48:18PM -0500, Bjorn Helgaas wrote:
> On Thu, Oct 24, 2024 at 04:41:42PM -0400, Frank Li wrote:
> > Endpoint          Root complex
> >                              ┌───────┐        ┌─────────┐
> >                ┌─────┐       │ EP    │        │         │      ┌─────┐
> >                │     │       │ Ctrl  │        │         │      │ CPU │
> >                │ DDR │       │       │        │ ┌────┐  │      └──┬──┘
> >                │     │◄──────┼─ATU ◄─┼────────┼─┤BarN│◄─┼─────────┘
> >                │     │       │       │        │ └────┘  │ Outbound Transfer
> >                └─────┘       │       │        │         │
> >                              │       │        │         │
> >                              │       │        │         │
> >                              │       │        │         │ Inbound Transfer
> >                              │       │        │         │      ┌──▼──┐
> >               ┌───────┐      │       │        │ ┌───────┼─────►│DDR  │
> >               │       │ outbound Transfer*    │ │       │      └─────┘
> >    ┌─────┐    │ Bus   ┼─────►│ ATU  ─┬────────┼─┘       │
> >    │     │    │ Fabric│Bus   │       │ PCI Addr         │
> >    │ CPU ├───►│       │Addr  │       │ 0xA000_0000      │
> >    │     │CPU │       │0x8000_0000   │        │         │
> >    └─────┘Addr└───────┘      │       │        │         │
> >           0x7000_0000        └───────┘        └─────────┘
> >
> > Add `bus_addr_base` to configure the outbound window address for CPU write.
> > The BUS fabric generally passes the same address to the PCIe EP controller,
> > but some BUS fabrics convert the address before sending it to the PCIe EP
> > controller.
> >
> > Above diagram, CPU write data to outbound windows address 0x7000_0000,
> > Bus fabric convert it to 0x8000_0000. ATU should use BUS address
> > 0x8000_0000 as input address and convert to PCI address 0xA000_0000.
>
> The above doesn't match what's in patch 1/4, and I think the version
> in 1/4 is better, so I'll comment there.
>
> To avoid confusion, it might be better not to duplicate it in 0/4 and
> 1/4.

Yes, cover letter don't come into git tree. This part is common and
important, It is not good just said ref to patch1 commit message.

Add do you have addition comment about this and
https://lore.kernel.org/imx/20241015-pci_fixup_addr-v5-0-ced556c85270@nxp.com/T/#t

The both are the pave the road to clean up pci_fixup_addr().

Frank

>
> > Previously, `cpu_addr_fixup()` was used to handle address conversion. Now,
> > the device tree provides this information, preferring a common method.
> >
> > bus@5f000000 {
> > 	compatible = "simple-bus";
> > 	ranges = <0x80000000 0x0 0x70000000 0x10000000>;
> >
> > 	pcie-ep@5f010000 {
> > 		reg = <0x5f010000 0x00010000>,
> > 		      <0x80000000 0x10000000>;
> > 		reg-names = "dbi", "addr_space";
> > 		...
> > 	};
> > 	...
> > };
> >
> > 'ranges' in bus@5f000000 descript how address convert from CPU address
> > to BUS address.
> >
> > Use `of_property_read_reg()` to obtain the BUS address and set it to the
> > ATU correctly, eliminating the need for vendor-specific cpu_addr_fixup().
> >
> > The 1st patch implement above method in dwc common driver.
> > The 2nd patch update imx6's binding doc to add fsl,imx8q-pcie-ep.
> > The 3rd patch fix a pci-mx6's a bug
> > The 4th patch enable pci ep function.
> >
> > The imx8q's dts is usptreaming, the pcie-ep part is below.
> >
> > hsio_subsys: bus@5f000000 {
> >         compatible = "simple-bus";
> >         #address-cells = <1>;
> >         #size-cells = <1>;
> >         /* Only supports up to 32bits DMA, map all possible DDR as inbound ranges */
> >         dma-ranges = <0x80000000 0 0x80000000 0x80000000>;
> >         ranges = <0x5f000000 0x0 0x5f000000 0x01000000>,
> >                  <0x80000000 0x0 0x70000000 0x10000000>;
> >
> > 	pcieb_ep: pcie-ep@5f010000 {
> >                 compatible = "fsl,imx8q-pcie-ep";
> >                 reg = <0x5f010000 0x00010000>,
> >                       <0x80000000 0x10000000>;
> >                 reg-names = "dbi", "addr_space";
> >                 num-lanes = <1>;
> >                 interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
> >                 interrupt-names = "dma";
> >                 clocks = <&pcieb_lpcg IMX_LPCG_CLK_6>,
> >                          <&pcieb_lpcg IMX_LPCG_CLK_4>,
> >                          <&pcieb_lpcg IMX_LPCG_CLK_5>;
> >                 clock-names = "dbi", "mstr", "slv";
> >                 power-domains = <&pd IMX_SC_R_PCIE_B>;
> >                 fsl,max-link-speed = <3>;
> >                 num-ib-windows = <6>;
> >                 num-ob-windows = <6>;
> >         };
> > };
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Changes in v4:
> > - Fix 32bit build error
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202410230328.BTHareG1-lkp@intel.com/
> > - Link to v3: https://lore.kernel.org/r/20241021-pcie_ep_range-v3-0-b13526eb0089@nxp.com
> >
> > Changes in v3:
> > - Add mani' review tag for patch 3,4
> > - Add varible using_dtbus_info to control use bus range information instead
> > cpu_address_fixup().
> > - Link to v2: https://lore.kernel.org/r/20240923-pcie_ep_range-v2-0-78d2ea434d9f@nxp.com
> >
> > Changes in v2:
> > - Totally rewrite with difference method. 'range' should in bus node
> > instead pcie-ep node because address convert happen at bus fabric. Needn't
> > add 'range' property at pci-ep node.
> > - Link to v1: https://lore.kernel.org/r/20240919-pcie_ep_range-v1-0-b3e9d62780b7@nxp.com
> >
> > ---
> > Frank Li (4):
> >       PCI: dwc: ep: Add bus_addr_base for outbound window
> >       dt-bindings: PCI: fsl,imx6q-pcie-ep: Add compatible string fsl,imx8q-pcie-ep
> >       PCI: imx6: Pass correct sub mode when calling phy_set_mode_ext()
> >       PCI: imx6: Add i.MX8Q PCIe Endpoint (EP) support
> >
> >  .../devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml | 38 +++++++++++++++++++++-
> >  drivers/pci/controller/dwc/pci-imx6.c              | 26 ++++++++++++++-
> >  drivers/pci/controller/dwc/pcie-designware-ep.c    | 14 +++++++-
> >  drivers/pci/controller/dwc/pcie-designware.h       |  9 +++++
> >  4 files changed, 84 insertions(+), 3 deletions(-)
> > ---
> > base-commit: afb15ca28055352101286046c1f9f01fdaa1ace1
> > change-id: 20240918-pcie_ep_range-4c5c5e300e19
> >
> > Best regards,
> > ---
> > Frank Li <Frank.Li@nxp.com>
> >

