Return-Path: <linux-pci+bounces-17957-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E799E9D73
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 18:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28C8F1603D0
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 17:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E374E1E9B26;
	Mon,  9 Dec 2024 17:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ihcBrur0"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2084.outbound.protection.outlook.com [40.107.249.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AA513775E;
	Mon,  9 Dec 2024 17:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733766536; cv=fail; b=TI6ACqNdhKQWhvLwu7npgGT7JZyPzXIP0aKtqdPDg7iuwG0SZXM06FzOyGcY7pLeFhLDL7wcagNNvbYAqrKntwqmwCNLXsT2O9hzXrFA2jfTaR3WsdwfDu6920kDqJYyzK7/3FeRYtOR77pxWEy3rBpo/dXbdtlwSBKyAZtJTH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733766536; c=relaxed/simple;
	bh=3ddx5i2vZgkRmKAKHbO1+MH+deLur5mXWHjfPbO8T5c=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FX+MhTA0c1hjyhrhV7jZ5st7un+9RhOf2uGBoG7FtGKkHLjdE57qW8A8wvoREVyfMAmkGZWQm40B0kNtIohl+F35dKbn9Rm6Yc/inZ/Y99f27ZP0MjiPsjk2rbBM5zAZ5+rfxIu3rSubh15izRafzWZp9DrCS9Mi/y/HlnBTERY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ihcBrur0; arc=fail smtp.client-ip=40.107.249.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bGMdOGQh3QVAzHZyob+Pd8sv99go5CeZJd97QtEwtX/ByZuHJOvgam44OHmKcATl/O+ep2OuSlevdkrxXLQPfrULFl2NJHMOaSS0Cr+HSjVLYtdnIeJKVQH4TVXkl/Gne3nlgx/2CUCV3C+H26sVC5mz+y0k7bJixIP3tw2CiPofvQ5AYE+E32fPwRzAcIOTQ7Lq7VrlOaixxP7XJVUNj0+MS6jNXyOh1Wv7V1jkPdH3wslJLPjxJQkP+AJQSz/adBDWVbyhp6pTQpnHBy+caLJKwgGSKBydNoMhA6n5LdPuhrm1zU8V2eMe4q1V/BSqehv2ZI9ZsRF+UrtGx68yzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oszU2qojRF6w8uj4Xk3VbRlVoS3ouEiYM+63L8FZlXI=;
 b=cIzrAoJZ9/Y4h8E7qXWQDtLxHUXU5r0FjvngYtRpddwjwn3zkN4VKPiyg1J7pWEZL5UgfvRkZhmFgYEd+scoChgz2pc29mpYtkRBohOXD08KUaFG1S3BVGBebhHn25NjXE9gAd4yObrBH5GH6hOElZ6plQ1U2cosORmzrEwWUVAXsPFhX0+KS3M3d2EtAlYT7qhpCdIVfaaI64Z45oj6iQe8mcnVTSxpogs7Y1Gsv9CwKOsDSNzpmHoJOfeQPgpALjNEShq0IIAvgYZlpCRgStr6Nhll1kqgY/NqOyP/IJcT7kEdxBxK/epPe4HWpaLTDk6Nob+9zMTHrR0deFJejg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oszU2qojRF6w8uj4Xk3VbRlVoS3ouEiYM+63L8FZlXI=;
 b=ihcBrur0Elz0h9YVqXoYt9DBdJ+r7Qv4TwkeVw4R4MUg/CvaA2QPiL8JqXVO1v6OMWzGTKF2WJV7J3VFDpY6/EJNyJOCJ+O3AT/YvZJQXMHfLOLhd7reRLVddokrK+8oHIwkx81gEMaoDAGsS2L4D5bwlmLlaIkwRGW/1Li90mGE8H9RqhpsMj2Maim0e/u8kowEKc4aSYHCif6/T/T8SuATyaC6vcoOT7tCS1M144jLYFbCRYlUxsErO+8WE6lv2AuXVchvUZnJqSZilVoJrAHzKH3qyrzjRCiAJgQ9KK1HDP22tmipetGYeJoC6QzGqzYXwIhAvRtOf7Jnl0qUZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB11017.eurprd04.prod.outlook.com (2603:10a6:150:21c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 17:48:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 17:48:52 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 09 Dec 2024 12:48:17 -0500
Subject: [PATCH v11 4/7] PCI: endpoint: Add pci_epf_align_inbound_addr()
 helper for address alignment
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-ep-msi-v11-4-7434fa8397bd@nxp.com>
References: <20241209-ep-msi-v11-0-7434fa8397bd@nxp.com>
In-Reply-To: <20241209-ep-msi-v11-0-7434fa8397bd@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>, 
 Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, 
 jdmason@kudzu.us, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733766511; l=3395;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=3ddx5i2vZgkRmKAKHbO1+MH+deLur5mXWHjfPbO8T5c=;
 b=tPnkfLpbDfNGLxvDO7/ZFgSOGa8rVpKvB23zBdMz+eSYMSp7n7eemg5kEhPD+dtgDdCiAhIET
 MWuKIl778elCnLROlEm7vDF1f87MX9kDeORbql3et85CqncE7vLePsR
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR17CA0070.namprd17.prod.outlook.com
 (2603:10b6:a03:167::47) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB11017:EE_
X-MS-Office365-Filtering-Correlation-Id: d2097a4b-1a1c-416d-80b2-08dd1879be67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tm9SR1BVMFdGeFFpaHMzcmpFNGpDUWNncjNPMjZ2VU5TNDRLSmRHNW8vdnpT?=
 =?utf-8?B?aFozUzhENG5qU2dqbU14ZmNQczVCaVBRV1owMGFjZ09qc0Y3UlpTcnlWdm9G?=
 =?utf-8?B?RjVHVWwyNkw4YXhlMkJEN3B4eTBOYVVnT05teTltMmdleno4RDBpRnZDZ1dh?=
 =?utf-8?B?cDZnWEdiL2JDMjVJeVo5ai8xUWlzaXZuaDVmQ3FzbVo5eVBGNkNxTG4yWlFJ?=
 =?utf-8?B?UkNqWS9kRmtyRmVaQjN6anhrRGZsR0ZDVStnRHZVUEpBcFNvSHM3L3FjS2NB?=
 =?utf-8?B?aG9kS0EwOC9tZlAvdEkrY0oyOFNyQkp6OGpFQmwyNVZJR3RidW9xUmRYdHFq?=
 =?utf-8?B?UnBBVXVycEJkd0I4a1NRYkJLUDF6aTZvWHZJVytBbGJVZkRac3FXZDIxbENY?=
 =?utf-8?B?eTV5d0hKOGxBanYrYkZZKzZHdXJhZEpPOUNIM0JHY1BXUDhUZnVjMFJoZVd0?=
 =?utf-8?B?YWJmRmpXRTFLeVIzMW11Sk96S3FZTENLZW9mSVdzeUJ4WE9wMFBuc1ZxdlBr?=
 =?utf-8?B?TXFtWVA0RDdGcHdkOEsxQzVIMTdOcDlMaWdhdTVsbUtEZTZzUERaRThsaEd3?=
 =?utf-8?B?N01ab0ZEWGY3RUlva3JiSmcybU9xVzhhelJBYWc3dmFnTEsxNFJ4RHZ3V0VM?=
 =?utf-8?B?ZlU1RmxGVEZwaVFoQkwvMmNhbW9qOWlUT0tyYitEc3ozVnhGdnRJUnlXR1cv?=
 =?utf-8?B?TnlsZ2E3UUl4UFNHcUtoMmpEdkVUekFwUHFzWlJjKzlLYXBTWHdVUFRuYlRT?=
 =?utf-8?B?MCtwcC90dUtXMXFiL2hRQmNpTDJOcVFaa1Yzd1U0YllOamJ6UUFMdzRTL2pL?=
 =?utf-8?B?Mi9nN2Z6YWZPVmswWTBNZTVmYXBxbFQvazRpVHh6dy9VWjBVOEtkajJ6bkVa?=
 =?utf-8?B?UE9oZG9nM2JpVVJmby9QMkNSSUtodVRwRFpNVXZja1VIa1ZpZ3RjUERjQmlM?=
 =?utf-8?B?Nk9PQWpsLzkzQ0plRVRZSmZzRmRUa3MwbnNaVTZZZUZLcWZHSTlMQW1CbFdr?=
 =?utf-8?B?YXpSdE0xUThLbW9qeXVzdGUxdFJ3UEhUMkNUNHZONitaakgraXk5SEhJWGJL?=
 =?utf-8?B?dk1zQ1NXVWpEekFOd1hzdXRCR3A5UkNGOWhLTmZ5c3hFUHJKdzdiZElQVm1T?=
 =?utf-8?B?Wk5nRjMyQlFQVi8rSDZZR3ZPUW1QS3ZCd0VGazdma0FidE02SjFDM05OdVBU?=
 =?utf-8?B?NGZLdDE1Y1RicytuTkFUT1RFQzJReTVBK00rekF3RklTS3RvWXg0bnFTVE5u?=
 =?utf-8?B?UytJdnh0WXpTSUFUazNJYWpGVUZ5QnhSNmV6cHZnODhqeUY1aGJKQ1N6Zk5I?=
 =?utf-8?B?TmIyNXcrUHJmcFZDWkVSL1hRK29GZklBWXE1ZmJEcDltZVh6UHpXYUhSbm5q?=
 =?utf-8?B?OUNNTE1YL2FIOUZtK0E5aVlwU04xNTRNd0NlOVRMLy80T2NRS2NNdEQwU2Fj?=
 =?utf-8?B?Q2h2OTJFcDZBazJrUy9WYmNxakh6RnpTai9ZeHloOE5pL2hjNlNvcHgzaGY0?=
 =?utf-8?B?Z2Vxc3c1UUhkV2lySCt2WUdxRXBOM1haMjRSVzJxTDFCdjZnWmo3L05IcUJ4?=
 =?utf-8?B?azMxOEszTG9mTitMOXl4cGJyTlEwdklPNjgzcmdKMCs3OEUxYk8zQ0xiTlBh?=
 =?utf-8?B?Y3hqaG56OUVNTDg3RW5RR3NxWHU2MDFBbWJrKzdINU9LaDdPRGlOMWZJMTlJ?=
 =?utf-8?B?RGtNeHI3a3QrRzA4b3ZNZ1VueHFwSGl5eWRvV0xuRGI3L3haZW9xb3RXZHQz?=
 =?utf-8?B?RmJ2OUVINVZyTkVvZDZ3Q241WDJjOHFTNU5jcUYwZHNiVjZscmc5SVBsSEpQ?=
 =?utf-8?B?dGJEY21oQW10SS9ZT29DcDkxZGlDQzZKN0o3SHZsRE0wVmFWbXE1WTd6ZEZL?=
 =?utf-8?B?MkxiT1d4K1BjbVNGWGd0NEdPUTlkQzNRcUd5ODN5MHA5VHVzTVIzM0hMSGdY?=
 =?utf-8?Q?618trhOOxEw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1NnanRRdHdVR0JObEEzRnpoczNqdnNGTiszV3ZxRHNwL1g2N1VmTlFLVHEz?=
 =?utf-8?B?NE5sL3FpNkRZRU9veUZSdzZZUEx6OUxnT2FIY0VycHZOQVJzTEtOZ2VoNjgx?=
 =?utf-8?B?bnR2SWJKVjI4c2RBdnROZ0Q4NEJIdE5DeEwvSGxLVmdRTTFzeS9VVklPNFVW?=
 =?utf-8?B?QTBmcUVPMy9yeko1anNhOG1oUDQ1VXFJU3JNV0dIWDFCVTlrbEJmNUdhOFo3?=
 =?utf-8?B?bnhoTlVvTS9oZXNTR0lVb1VvdTZxZmkvT1VWc2pyVnI3WHZvN2htL0Y5Qzdx?=
 =?utf-8?B?cHVYQ0Q4bUF5a01mSGxUYUtFaitXaXJiTHlMdlVyVitlSitFVTIwcTZJOEh3?=
 =?utf-8?B?NGhYUjMzYktpZXQzL3FKNW5za3hDbm1Ua2RSYkNCV2FndHJkcGRKZjVsM3Bk?=
 =?utf-8?B?aG5qUzJkbWg0MnlWYmc3YVZwaXo0UEdrY2ljSytRRFdIS3FzK052aXoyUVZU?=
 =?utf-8?B?MW5BZ3BhRGd1TGc2aFhFUFZSanhDQmpNWlhwWGV1YmZDdWJiYnR4KzlkdFA5?=
 =?utf-8?B?em9WSkczc1BtR01iWm9aYW5IeFJseEhaVGVlRWtKNXJBTEtuclJPeTBNRG80?=
 =?utf-8?B?a1lUM3V5VTBOZlk4NnloS0Z2TTN4MG0zWWFHaVNJeGRYY29IK1N1SEVvdDJO?=
 =?utf-8?B?TmtWbTRXU2p5TUZaek16UHo0ZTV4SDhSZXlhMjNhNE1iRTBuV3JNa1VKOVBy?=
 =?utf-8?B?K25tb2JYWEdxa2hIOEo2TG1YWU9MZmVLa3dpaFJoUGwyZFY5N3ptSUdNSWhT?=
 =?utf-8?B?dmtXMDd2MUFRSVJNWFcraFcrNXRKWXdSTHY0Q01DWndRWGhRZVI2cWxUOElw?=
 =?utf-8?B?ZWdRZjVpa2UyK1A4RkV5YTFING80a2hqblN1L1YxK1I5LzhiS2p5aWxQNlRJ?=
 =?utf-8?B?cGMxWU1JM0lnTklsTWhkU2RzRGg4dnlPOTZrT3NoU2pkVXo4SnZBaDl6TE9R?=
 =?utf-8?B?V2pkZWNXRjliQ2xkK3czSlhoV1dINFlxTkNOL0VhY1hoOHVGSlFwd3gyRDRs?=
 =?utf-8?B?TWFzMVJrTUx4enA1T0MzVkUzTkE5UHNOUlNyVkp4VjhZT0x5VUNvZUtTcGNt?=
 =?utf-8?B?WE41WnNFWXdXdE9CbVdDUzZ2bE9YcmVHcFZSdGtYMmJ0d1JHbFpFdnRpZ3hn?=
 =?utf-8?B?bTRiZTNsNjI2U1Qra1BDc2M4T2dTS2xFTG1UN21tcm1LbjFaU1JuSTRjZEdZ?=
 =?utf-8?B?TVhsazRlcFViV09iQlBiSzdFVHREQ082RzlNNy9FSi9BNFhsSG9CRVl6UlFU?=
 =?utf-8?B?L2FjOUxGNzJmZWpYRTE3S2FWMHoxOGw5UlQwVGEvWVhpZlowNWZVNDMyWFJU?=
 =?utf-8?B?N2xKSUpid1dTaVpIMmJYSlN2eWVkM3lyRnhZQkt6VlgrV0k1TE1XVktQS0xj?=
 =?utf-8?B?eXRTUVZpbUIrVnp2Y3VnNENvQkw2akh3SGZTTFdLY1lvalU1TUVNT204NVNW?=
 =?utf-8?B?cmhCaU9vcHlySTMxNkd4MGFOSWRJYlFUSEltV1ZuVUd4bnlCK3RyZjRIQzNs?=
 =?utf-8?B?V3lpRUxOdTBWSUd6dUVlRTBESXg4S0gySzYxZGJQaGorRzYzUWl5bjBMRk1n?=
 =?utf-8?B?UkF2MXhGN0VQSDNLRngwK2tFRjBoNTVZZFNTOERXRGh4VkRMd0RNUW9XbEMw?=
 =?utf-8?B?Ty9DRkZ5cUpNZEErUnYxU25QQzZCRnd1UTQyUXhwMGFTRENoS2hGdjRoeWpN?=
 =?utf-8?B?SnVORExjVXVsVWRtMlQ0OGJLYnpPaVZHL20wYy9qdnJhdGlYNmlDOVBVaHJV?=
 =?utf-8?B?Z2tnNElveTZ0NUVRRmJRYXpoZXNzWkFIaEhpRy9McWxzcTAvSVpWYkZRQlJH?=
 =?utf-8?B?bkE0L2lqR1FYNDhSMVdJUnNtZ0JBUWwrM2FIQmdRRGRqMmZqSDlrQUt0c2xI?=
 =?utf-8?B?RWYwWUoyUEVLVzZVdFJqcERnUytjaEdJdjRvVU1nZnFWMitINHl5cTJqZ2Fv?=
 =?utf-8?B?cHlQdmRZNkU4aE1wWHY5WVFYYkpVSTNCTTF5eFVxbjFuN3E4TW9ZUERnN3dj?=
 =?utf-8?B?QTZBMTgrV1ViSlZYUjE2bDYzNG9UWHVTa2s3Y1JLMmswUDRJQ1RtSWM5MjNo?=
 =?utf-8?B?eWYzcDUzSjhxVmVZR1hGNGdYNkhiN1BHNlJGVDZVVERHaHdlMlptRjkzVm9X?=
 =?utf-8?Q?qI6w=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2097a4b-1a1c-416d-80b2-08dd1879be67
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 17:48:52.2069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aq/WU8doqzrAWUXlIeg6dX4D8EhUDXlStyl70wrauB0XI+KxtDRUVQJ2tExINOPkSN18pqzjUvYfC5f6RYJMfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11017

Introduce the helper function pci_epf_align_inbound_addr() to adjust
addresses according to PCI BAR alignment requirements, converting addresses
into base and offset values.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change form v9 to v11
- none

change from v8 to v9
- pci_epf_align_inbound_addr(), base and off must be not NULL
- rm pci_epf_align_inbound_addr_lo_hi()

change from v7 to v8
- change name to pci_epf_align_inbound_addr()
- update comment said only need for memory, which not allocated by
pci_epf_alloc_space().

change from v6 to v7
- new patch
---
 drivers/pci/endpoint/pci-epf-core.c | 44 +++++++++++++++++++++++++++++++++++++
 include/linux/pci-epf.h             |  3 +++
 2 files changed, 47 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 8fa2797d4169a..d7a80f9c1e661 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -464,6 +464,50 @@ struct pci_epf *pci_epf_create(const char *name)
 }
 EXPORT_SYMBOL_GPL(pci_epf_create);
 
+/**
+ * pci_epf_align_inbound_addr() - Get base address and offset that match BAR's
+ *			  alignment requirement
+ * @epf: the EPF device
+ * @addr: the address of the memory
+ * @bar: the BAR number corresponding to map addr
+ * @base: return base address, which match BAR's alignment requirement.
+ * @off: return offset.
+ *
+ * Helper function to convert input 'addr' to base and offset, which match
+ * BAR's alignment requirement.
+ *
+ * The pci_epf_alloc_space() function already accounts for alignment. This is
+ * primarily intended for use with other memory regions not allocated by
+ * pci_epf_alloc_space(), such as peripheral register spaces or the trigger
+ * address for a platform MSI controller.
+ */
+int pci_epf_align_inbound_addr(struct pci_epf *epf, enum pci_barno bar,
+			       u64 addr, u64 *base, size_t *off)
+{
+	const struct pci_epc_features *epc_features;
+	u64 align;
+
+	if (!base || !off)
+		return -EINVAL;
+
+	epc_features = pci_epc_get_features(epf->epc, epf->func_no, epf->vfunc_no);
+	if (!epc_features) {
+		dev_err(&epf->dev, "epc_features not implemented\n");
+		return -EOPNOTSUPP;
+	}
+
+	align = epc_features->align;
+	align = align ? align : 128;
+	if (epc_features->bar[bar].type == BAR_FIXED)
+		align = max(epc_features->bar[bar].fixed_size, align);
+
+	*base = round_down(addr, align);
+	*off = addr & (align - 1);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_epf_align_inbound_addr);
+
 static void pci_epf_dev_release(struct device *dev)
 {
 	struct pci_epf *epf = to_pci_epf(dev);
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 5374e6515ffa0..2847d195433bf 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -238,6 +238,9 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 			  enum pci_epc_interface_type type);
 void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
 			enum pci_epc_interface_type type);
+
+int pci_epf_align_inbound_addr(struct pci_epf *epf, enum pci_barno bar,
+			       u64 addr, u64 *base, size_t *off);
 int pci_epf_bind(struct pci_epf *epf);
 void pci_epf_unbind(struct pci_epf *epf);
 int pci_epf_add_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf);

-- 
2.34.1


