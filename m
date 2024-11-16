Return-Path: <linux-pci+bounces-16970-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC759CFF4B
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 15:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF0A4B23B31
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 14:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D5E11713;
	Sat, 16 Nov 2024 14:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z58OAdVb"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013052.outbound.protection.outlook.com [52.101.67.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A2617C61;
	Sat, 16 Nov 2024 14:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731768071; cv=fail; b=lKTg4q96nNWYgxAgB3BXaNRDuRq2sArjrPPtxzO4D0dJ2ZCfdaF1apSIrNt3VV+3Krgd64vELG8OFZJnpcZ3FHQ2my5/bz+6okahWXyeM0vG7Ovy6J9wTj88MTZ+ohxDyE4sLaKYu7iAQP069DoJXcgXEe0mOTTCHnOEF9mIuPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731768071; c=relaxed/simple;
	bh=ddQJGOgVqT+GFgYeTaZpLu0yEfEdWMMFBmUhAfO/2D0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VH9LjnWMlyjIJeBL1Fw7hL64VOYfOwTCNHfC3mf1R/YxS4txysRvRZNnAa1dphMbzm5PJ21EXZp2MSar9ewfRG5R5DUtNGe4PVC9H6bAozYmJg1DvaLFK2T+iuLYnsxNDIA18ibCkGCPPU67G/LCCujjdOsNBgEZ4Xoy5dy55gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z58OAdVb; arc=fail smtp.client-ip=52.101.67.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s2expSynKsyytdb4fzV5R6TB15t+hBvwSnaNC0om07ZalP90VWum1MgCW3VYz1Z7h9r5JV48UA+Y8Nn0u75lDEnd/oSc6haQ/Dbfkg8dc+qGsXSHW5XV3w2Hs6/CmcJIDJKXxPv4GwGu8lqFcyjRLQyHky00a5giAKvynRSleGRcc3SCVs3UirGh3TrsYbqz0tdqqGmzS9Mbuuq+HF3tX72aQm8x1RlDUu1hJ3YCZ2PfHLZw5dcHE2/gbnRCoZ28lPCF8DXUgDyQV+44EFykN9hcwEwgYYk7Evt4rubW/GNjTeESs33KXHi2tuuwEUf247e/reMPnqx3Nic/MzTRtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uuDh6IPej+1IZb3dyW/IgKJh0HGNgajYdvzA9re1UFo=;
 b=ZN+ErnvkayKuYasKjNFcO8kI2DEhDu4k0sZQghaTL8gXCw1uB/T7v7e4YfqFZx74xdxrWpzAckEi5T/wYHrs5A0sOuawhUiu0LSFG9WjKD2jahej723VT3F/sJkNDZ9R79cY7P989g99nQuPKCX3UFvL2Ljz3P50Kc/LsnR1DjCSvVW3lFYHyZDH/91vl6EfFKdyVUhmXlkNjFsy8jP5XIvHjEsDJHcoWcRsQsfKHqFWgUDjMNojyuhghLbHZD04fCVcFxxUdnl5G7UHsNadgsTpy221YqRXWRd409rxtnzqAn44LI/5BS/ihXJBLQww4rjxB1WMjJQjBWZcM0r73Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuDh6IPej+1IZb3dyW/IgKJh0HGNgajYdvzA9re1UFo=;
 b=Z58OAdVbyeK8UF+6CkzovPGv0cxJ4q+AWg5wxJZ6aJ7pzj2tqlqOIQfDbdJ5wwsi3zZ2H0l91PStt8pQBM4krq3povx1pQdhSfeJFt+5DoCtspCGZCRIJ2yRkPOlDK9U/ivWwxuLCZKvrP91IjDOMEYoSu7wOqoCDVqRMk9NKiS2R8VGMu8PF+4IbE9xMeMsw2VU1sIE7/p77L6YAcONi2tMpj+1q+PKyjl9RrNI3MXOj2bafDaHpG83qsshJJ9jsIj/jFlGXIwj4ifJ3+5J7re8Gxeruzd7XkGRhbQDAPwKuda4qUykWze34J3vf2eDvhALqaPAGf4UNSqVXy7/Lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7265.eurprd04.prod.outlook.com (2603:10a6:20b:1d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Sat, 16 Nov
 2024 14:41:05 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.017; Sat, 16 Nov 2024
 14:41:05 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Sat, 16 Nov 2024 09:40:41 -0500
Subject: [PATCH v8 1/6] PCI: endpoint: Add pci_epc_get_fn() API for
 customizable filtering
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241116-ep-msi-v8-1-6f1f68ffd1bb@nxp.com>
References: <20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com>
In-Reply-To: <20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, 
 maz@kernel.org, tglx@linutronix.de, jdmason@kudzu.us, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731768057; l=3147;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ddQJGOgVqT+GFgYeTaZpLu0yEfEdWMMFBmUhAfO/2D0=;
 b=dXe9DHNGqYLK+qXJ2TN3yOPspSfJDJxkPRLRNRLERHxH8JKxDZSImzBlBlcstbyHCxB/ouU5p
 zH+un8sDzAvBfsES4zxwH9bSQbt1JkFhgWGdEwcasiQtoECyDcdeMHD
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0210.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7265:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f56f913-096f-4c86-7a71-08dd064cb31d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlNTTkxVR0hLdnRueG52V3N4V2ZZTDVycERXSThKZ2EzVEtOajR2aG1SY0tz?=
 =?utf-8?B?d2RlUGcweXMrZkpZOGxYQllJT0UzMU0xOXdMWHJXT1ZHb2FyeTZUMGNqdngy?=
 =?utf-8?B?SzhoTklxYXZqdUZsWnNHQ1pMQmJKb014dHBadkRrQW1xOEpKNXIxcTVnUGJr?=
 =?utf-8?B?MkVTZlZkN0tXTy84UkdwYkxGejlyak04WHN3QkhEeFJsd2NJT2w0RVJ5SGVT?=
 =?utf-8?B?S3lYUmtDZG5jamFWMzIwdkdTc3dCemJXV0lHYjJmc1hYNHFHZHVuSXpzczI0?=
 =?utf-8?B?ZGNvbTY5dm1MU1dyZEdwMk9QQ3BPWFNDTkpqS3VwVFhYYVdLRWpsTUttUjJZ?=
 =?utf-8?B?UE80ZHd4TlFHaXBRenpzOUFENmppUzNhTlRrR3RCNjdabHEzU3pPOUZEekt4?=
 =?utf-8?B?NnEzUUNhRmcvTklaZTk4eHdzQXEwM0FFTHdPSG9helRZM292MzMwaUJPKzFO?=
 =?utf-8?B?em1SaHhPNWlNNzBRQklrNGwwdlpjRHZKTXl6VHg1Z25HaGFWdjI1dm5NSll3?=
 =?utf-8?B?MlZrd0F3NVFnKzhKVVhqSEdEZll6U2paRHB1aElCeVpRTnZ2TFU5TnZhdGNq?=
 =?utf-8?B?VzdITnBvT24vbnRLUVNRMFdNQm55cStFQnZOT1JNLzRoNjdUZG5xK25lOGxJ?=
 =?utf-8?B?MHF4czNBeDVRSnBXcE1tWlI3Y3hUcmZJMHcvMmhpZWdLVlVuSHUvckttMWJM?=
 =?utf-8?B?SXRveHZhb2VoMmpIN0VqSnBaZ0IrS3RCRk4vMTlkQnJWK01JdFF6dnhVYXU3?=
 =?utf-8?B?RWpMMHh0NSsxNVRNbFR0V05NSUFBaDFuZml5aENpZHdQZEsraVFNcWtqQjZG?=
 =?utf-8?B?VzJrZmtyNjVuVTF5ZDdvWTY5Rk92QjFMb01PSVhxTERyRXp0enlBTjZoM0tG?=
 =?utf-8?B?a2c4bkltUlZ4S2tGUUJ3YTZjZ3NLTTRzVUJpcHRFcHArZGtoSU5GdFVMM0pi?=
 =?utf-8?B?UVBFVm9yNDVURHJweXdXWmpPejFLTkEzSWJ2bGJFNjA1azZVUXJlR0RsSXYz?=
 =?utf-8?B?Mi9xZ3grRGtML3FudVlReGhwdGhUSlZjNkJjTVVkNHFIS3JxZmxqc0JhMXRl?=
 =?utf-8?B?Qm9lT09VNkFnK05LNDR6U3dIUTU0ZUZLTW0rZVA0RkYreVNlcUx3ZWZmRWhm?=
 =?utf-8?B?bERJZXR2WVpVZ09XU3RIV1NJNmNsRzFtYi9pelNXQS9HNjgrbno4bGd1OERt?=
 =?utf-8?B?bm1oM1JXejM0UG5oVTRudGRKWlBNV21TeXRhYzlQWll1UmZKTC9KV21MUFd1?=
 =?utf-8?B?cjg0TmlndkJYTWVONTdqTWJqb3diNndscFp2ZjhhYkhTRDgxU3RlUmVOTW5E?=
 =?utf-8?B?Ri8zcWdSU0dBRmk0dWx3aGs2aEJoTmJJUUM5czBmWFBTOUZNQkVrNzc3S2V6?=
 =?utf-8?B?NXNST3lQcjZtdFk3aFkwVnV0ejF2cTI5VHdmTGs5dG1pemVjajhFUUF3QTll?=
 =?utf-8?B?SjBYS09keDVaUElCcDRiUnE2QmVHQjF4YUpUOUxDU1JRM2JaNitHeXhVSkNp?=
 =?utf-8?B?MFVqQnZsR21sM2lZa0pFQ3kxMHpmcVAvTXZpeDUyYUxqRi8vYWh6K3NpNDEv?=
 =?utf-8?B?YkxtMjhacVNVVmFHMlRLTzJPNlduUFFReThGM1c0dm45Q1FHYVJLeUhGc09C?=
 =?utf-8?B?cWYvbzNmZ0ZrUERENUt2bzZPUUl0Wm1SYlpFMWhpTW93aGxrUVJwQkVLZU9K?=
 =?utf-8?B?cHFjMTROR1ZtL3A2K2NOcGowdlFTRzB4c0JUQUl6WmZVMkFFYWlFbG1uK2U0?=
 =?utf-8?B?VlFhQ1dkdHpza2ZPNEVHTHArNlRSUDRDczFLMnV5dUh6TWtmK3M4SnpXbDQ1?=
 =?utf-8?Q?Riz8ynxCVAZssPDo3RF3cy3YU/6wI6KG84H1I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TE1rSDV5ME5MdTZ1K2RkMlZxdlFRRUtwSkUycXloVzhhandkSWZUSjFpVXdD?=
 =?utf-8?B?aTcrRGdYZVpDVVFKajU4dVQ3cXNoZXR1azlKY0tHVWF6QXVWRzdrNjBHa3NT?=
 =?utf-8?B?c2ZNOTRnZTJQNVIwb0ZQeHlidStlcmo0d3V6TVpQY0tHbTdxTS9pTCtNRDM1?=
 =?utf-8?B?amdHNFJhWmxZL1pmamVhQmNUUDFLK0Z6V0lBRkVia1ZEdXo3dHNzY2pUZ01v?=
 =?utf-8?B?cW4vazJPOE1tbGFyWUxudmVzcWNJeFNJOTdjek1uRkRJcjVISmZBY0V0c3F2?=
 =?utf-8?B?ekxoUWsxUHBFY0NNNjdkVWo1ZVAvY0k1RWQ3UFpNVGxvVVZ5MVVlbnVQWWNN?=
 =?utf-8?B?Z0Fkd2d6U3MrM1pubXVlOVZ1WlpuVjltTUFQTTVTdUR2OU03UUdTOVN1SEpT?=
 =?utf-8?B?VC9RdFlEM3luNjgxeENDOEh2NHM0K0NYSWlrSThhQ1Y1SlJ1Mk14eFpMdzQ1?=
 =?utf-8?B?eU90ZUtTZmtPcFhPdWQ3N1ZyMEs5SFNrY1hyd3Q4UWxvanhETkVVQ0JsRy9y?=
 =?utf-8?B?NXUzMS9KNnlyenk4QXkwMGdFTSsrU2lvR3JpOURhbVZPc05pMTlMN1k4RkhZ?=
 =?utf-8?B?YVVBT2ljL0ZtdGpHNkU3Q3FEOGdDa3lab0xLQ0lpektQZDUyNjZ6NjYvOXpt?=
 =?utf-8?B?MXhkQmFMd2VTMDcrNlQ2YnhNTWVXOUIxaW5UN3gzZlU2QUZHQlk0ZlRHMU5R?=
 =?utf-8?B?STRaQlFOS3FmK2duQnlOMEUwTzh6L0JWc0FEQTNPWVJIMVBWMjFDV01uQVow?=
 =?utf-8?B?SUxydEpLM0JPelJ5R1FHRkxQWXFtanZNanF4SDN0YTVObklpTGdBcW4xWUJl?=
 =?utf-8?B?blhWQWpZN0dJR042Mnp0UnB3cnF5N0g0NjlSQW84SG4vODJWcll1cERKR0Np?=
 =?utf-8?B?UFZRM0Rmcmc1a3NzTk43R1BMU3MzaW1Bd3JZdVRoR0diREMveUJSdzhCejNF?=
 =?utf-8?B?NmdrbFVVWmhMT2cvT2d1dEI0QmVCbThHU3NpRWhQNUpxaGp2MmJadTM4VXI1?=
 =?utf-8?B?eENSaHFnY0VZVFRJa2NWcnZ2LzVzVmZJS1VLTEFGNEgvQk1WQk9hc3pVOVdR?=
 =?utf-8?B?YzRJSVNGdytZTkZnOGU4SkVHZ1owUlU0S2JXeU96Q0E0bmVxOTNReXNKamxR?=
 =?utf-8?B?VDNWWFUyeWdhSng4dmhUTkE4NlZRN1FTSWpnN1JQdW8vQTEzZDczcm5rRkJk?=
 =?utf-8?B?Q3E3anNGbEdzNmZ2WExMejB5cFpvbnRIT2JHOHViMU1oc0xOMFVPaXlTRURh?=
 =?utf-8?B?aHNINnhraFowYUM0WTlHTGh2VWswY1IwSENjZlRXaGFuL2RtSVNzdlY4V2xF?=
 =?utf-8?B?WUNsOUUraklzWENqWlVUMElxcUtpL2ZXcXVESjhtbGZZTUpTVmRjTlRQSjVa?=
 =?utf-8?B?bHI1eHNZTlVadlZwK0xaOVhzOXVkSDdOTGxaUEs0QkVXREhMSm1MY3p3V0VL?=
 =?utf-8?B?OVlGNy8wRFlDOXExTzVaV2tZMGtNcmVrYkZCZklnRHhUQVRvREtMalJ0ckZy?=
 =?utf-8?B?cytldFVYQW9SbHo2TVVnK0E5Y0szaUg0NVZmMkF1MFJSREFncjdMS3ZpMjUw?=
 =?utf-8?B?cGhDcU1uRFRjQ09WUzZ5R2V3VkFUbUt5eVZ3ODFQZ3p6cys1OENCeDYveEUv?=
 =?utf-8?B?aFhuQlJkcWIyL2VnVGl3VjVqTDYrU0M0cEhMbHlHVit2cHpjcm9icmYrV1FG?=
 =?utf-8?B?NDlLR2htcEFiK09iQUp3ZHRpRG9mZjQ1bkRZTFpsK0MrSFJqQlI5WC9TQ3oy?=
 =?utf-8?B?OXA3dkpSUUZFZGNaTzBIYTRPVTRPL0IyMnBEZUsyWHZTd2pkT0hhdVNGazZU?=
 =?utf-8?B?c0RTZUlMeUtWLzZRZ0pFRUZEUWNFYmlVS0JiVUd5YnZaenplcnF1bzZna3Zs?=
 =?utf-8?B?eGJqRnk5a3hGa1lJaG00R1krZlBXSmFhR0dBQmd0SVhacWxQK2JWbmFtU3hq?=
 =?utf-8?B?WnVIbHVxcnp2R2h1SFhXcnd1WjZjSyszM1cvMFdHbHhGZXN0N2I2dmh5WmdO?=
 =?utf-8?B?OTN5ZlpuTjF6ek9Bekt4cG5QRUYxUmt1RjZqU24rTnBqb3diZzFXWHNXLzJZ?=
 =?utf-8?B?RSt3NTJEaGlsS052ZXZZZTdldjJTZEF3S0R3OHNzYnFPeVhhMnZxcHBHbFB2?=
 =?utf-8?Q?axnQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f56f913-096f-4c86-7a71-08dd064cb31d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2024 14:41:04.9634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2eBvPdj+gRWFU5d2hJMWl5AILsfRaMWlyXQlR/I3HNLTAe+TMgFrwt7YNg/vlw5kRWtQeu9htdwW2wQATM0m3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7265

Introduce the pci_epc_get_fn() API, allowing a custom filter callback
function to be passed. Reimplement pci_epc_get() using pci_epc_get_fn()
with a match name callback. Prepare the codebase for adding RC-to-EP
doorbell support.

Add DEFINE_FREE(pci_epc_put) to implement scope based auto cleanup.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v3 to v8
- none
---
 drivers/pci/endpoint/pci-epc-core.c | 23 +++++++++++++++++++++--
 include/linux/pci-epc.h             |  2 ++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index bed7c7d1fe3c3..f5538c007678e 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -48,6 +48,11 @@ void pci_epc_put(struct pci_epc *epc)
 }
 EXPORT_SYMBOL_GPL(pci_epc_put);
 
+static bool pci_epc_match_name(struct device *dev, void *name)
+{
+	return strcmp(dev_name(dev), name) == 0;
+}
+
 /**
  * pci_epc_get() - get the PCI endpoint controller
  * @epc_name: device name of the endpoint controller
@@ -56,6 +61,20 @@ EXPORT_SYMBOL_GPL(pci_epc_put);
  * endpoint controller
  */
 struct pci_epc *pci_epc_get(const char *epc_name)
+{
+	return pci_epc_get_fn(pci_epc_match_name, (void *)epc_name);
+}
+EXPORT_SYMBOL_GPL(pci_epc_get);
+
+/**
+ * pci_epc_get_fn() - get the PCI endpoint controller
+ * @fn: callback match filter function, return true when matched
+ * @param: parameter for callback function fn
+ *
+ * Invoke to get struct pci_epc * corresponding to the device name of the
+ * endpoint controller
+ */
+struct pci_epc *pci_epc_get_fn(bool (*fn)(struct device *dev, void *param), void *param)
 {
 	int ret = -EINVAL;
 	struct pci_epc *epc;
@@ -64,7 +83,7 @@ struct pci_epc *pci_epc_get(const char *epc_name)
 
 	class_dev_iter_init(&iter, &pci_epc_class, NULL, NULL);
 	while ((dev = class_dev_iter_next(&iter))) {
-		if (strcmp(epc_name, dev_name(dev)))
+		if (!fn(dev, param))
 			continue;
 
 		epc = to_pci_epc(dev);
@@ -82,7 +101,7 @@ struct pci_epc *pci_epc_get(const char *epc_name)
 	class_dev_iter_exit(&iter);
 	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL_GPL(pci_epc_get);
+EXPORT_SYMBOL_GPL(pci_epc_get_fn);
 
 /**
  * pci_epc_get_first_free_bar() - helper to get first unreserved BAR
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index de8cc3658220b..d3d3b8c914614 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -300,7 +300,9 @@ pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
 enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
 					 *epc_features, enum pci_barno bar);
 struct pci_epc *pci_epc_get(const char *epc_name);
+struct pci_epc *pci_epc_get_fn(bool (*fn)(struct device *dev, void *param), void *param);
 void pci_epc_put(struct pci_epc *epc);
+DEFINE_FREE(pci_epc_put, void *, if (!(_T)) pci_epc_put(_T))
 
 int pci_epc_mem_init(struct pci_epc *epc, phys_addr_t base,
 		     size_t size, size_t page_size);

-- 
2.34.1


