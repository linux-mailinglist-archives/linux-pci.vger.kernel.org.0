Return-Path: <linux-pci+bounces-16355-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D641E9C25C6
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 20:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D87D1C2361A
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 19:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CBF1F26C5;
	Fri,  8 Nov 2024 19:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KWvZfuxN"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2069.outbound.protection.outlook.com [40.107.21.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E62C1EBFEC;
	Fri,  8 Nov 2024 19:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731095042; cv=fail; b=FG2mKXIz+hpwhm5NGoVZ1hsSpiFfiMvvktOh/snQbV0FvG0Ravd1kCyc6Rphx9OIvgxTEtT4HzN1yQtjwdk5qSXBpLGMg9BHLKwMxQH6Z2C5E3VRxs9H8iMpZF9jmP4kxEnDonOgI5G0PE7y/f2HqPcv1SHDtMSNyu/fB5GMjGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731095042; c=relaxed/simple;
	bh=pYt5jLNYZmjwZJXEi4DDlIg0upH0rCO+gYIhEutBvCg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PutdOO5Ko90RfQVGfbwlv9NtyHQgVoLy4Y3qH04viHx2HbgQhIl9nkug5dVxdr+8YHM+u7vjN1jhpNjnWaH95n1J5B9g7AiueuHMrBp9FosL0+WSTsj5SK1+I3hsPTLrS+U4uwYQnH7jUiYisvaxRlNv6nIdF3hV41SdfuL/wM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KWvZfuxN; arc=fail smtp.client-ip=40.107.21.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KjYqbyYOQxP8U1vnHqaNvIsEgPGq19dNe/UBHmAL4otL8VPtMvQ5LI3p8bMpIo1yn5M34yRvcxEd/mGeNOek0BmVAClK960hnTHbHv9hwDRBzKYJtcnnohCER8wf1/A/uhqCVu/S5HNBRbRucI2cf9RlJCpUBL4x2GkQXKvYq2UGFZpUaF6MCiuY7mrmNwTq1xpQlE4iprDda43n8UESuXf7Id8c6MxIgwwdxjP2C7RdW0Uze3BKrIlEyLNdvzy4PSLiE9d/PPTlRxCzZQKGJPnVQOwAqdBA3BSnZiGDrDKBihOlKc0fcVcVLQpfmwAyS0QGAGAcrG5R1iLad5OKNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDKjFU4cXoZFEgIfqxFbVQhZAT91I1Dpe/rORgznK00=;
 b=TT6FBwKQL4CZwiKImXAClFADjqiC9AcZkk3DOqIA5Z+nVTsgqGFibpvSv9kfJmfDpblcWCcRqAFGcJflbf22GpmhSdEu4HZ9HWq/LRmfbHRA6xh7O4xcRFJHyGgddBbdhaHIczg0gkr92dhyHla+JNRA7vX8O2IqWSNkhw36vabSX+QtRKBWdKRY31kU8n//Yl/5FHPrM0ehDHzjV1DtO/u01krg1WHJrv7H4l4ry5/0XdBASH8q1ylW2iko3MkuL/BaycoO7X0mgpgLZNta89957AyQRhKWfCTvNxvn1ogOstBBjEZ0u5u0fORvzAnid7ioIItP1+9zU7WlpEFL6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDKjFU4cXoZFEgIfqxFbVQhZAT91I1Dpe/rORgznK00=;
 b=KWvZfuxNQ/eIBUnqYVS8crOC1r0R/KQpk+59Y+xCwSspAoYBd9xI/bVMk5/THbEhpR/DeRHnkrAnIadcSJ+fCtzHm/y1mGRUKOihWZcGmo14sc58uBfgBa7jxLD+dg+QoP3/McBPPKXsZj117jL8RM30jR98mSy5z+MnlC97ZT6cKo/YDKsjaqkKz0vPZ3yJMVnbPPi6QHtgW1bfMYzgl3jgcBQB176BWWhBU4miuUOQiExCLC1M/OmdGU3rFX7QZ/OlbTX2t96ZY+ZBOXLVEFrLAy/Zo3s9THzDS89lAtdkrlybIMmKs67XiQnCOieQkr1+U7LQvMA1hfvZng34tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8669.eurprd04.prod.outlook.com (2603:10a6:102:21c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 19:43:57 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.021; Fri, 8 Nov 2024
 19:43:57 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 08 Nov 2024 14:43:30 -0500
Subject: [PATCH v5 3/5] PCI: endpoint: pci-epf-test: Add doorbell test
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-ep-msi-v5-3-a14951c0d007@nxp.com>
References: <20241108-ep-msi-v5-0-a14951c0d007@nxp.com>
In-Reply-To: <20241108-ep-msi-v5-0-a14951c0d007@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731095022; l=7940;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=pYt5jLNYZmjwZJXEi4DDlIg0upH0rCO+gYIhEutBvCg=;
 b=+Oon8qydEw9hdV8US6oyNRAUhHdoe/xxsI0lkNdnDSUxaqIUS0awY3qKYNCFnWbbq9X7xDxfd
 0ybJMRHNRd7DxpYoEMsSEbgwq4iwrj8WN24HlDKZCRAkFnKXEqMPBeU
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY1P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8669:EE_
X-MS-Office365-Filtering-Correlation-Id: 3abdebfc-6d88-4adf-764a-08dd002daf3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmIvQmZ3SDFhNks0WXBKelFtdTdaZ0N2bkZFT0Ztdy9EWXYvTndkNkNxTjlD?=
 =?utf-8?B?eWplTENMenAyQkFqenUrNUYxSTl2RUdoVFp5ay8yNjQrL0Q4ZzFjSGczdDBV?=
 =?utf-8?B?WnVIbFZHUFRGc1U0dWRPNjYrSjNHYmpIN2laeEM2UXc4NnZjWWl5dzI0bXFF?=
 =?utf-8?B?enFqTDhoMFhLVDNMTHA0SGRDcGRNUytBOE9STkIxRkRHRC9zV1hXNEM1S3px?=
 =?utf-8?B?VVNTRHVLVEZESlhiMTY1NUd1SXN2aWxtbzlSZW9jR2JrWG5LMjQwSi96b1pp?=
 =?utf-8?B?S3krT3FaU0VVcndhOUJOTWx6UGEyRXYwN2FsaHVlT0tXbk9pRy90NGlmSnJM?=
 =?utf-8?B?UDJ5blhta1pHZ3JzZ1VDa2RTbTlTSitKcmpkS09ZTTU1Q205Z2pTSEdFa1Bo?=
 =?utf-8?B?UEtJdzI5citOd2lwUzRBbWFhNnh0YmZDM0MrNSswcFFndTFuVlFKbEJPakZX?=
 =?utf-8?B?a2hDRzhxWGVqTEZuS2VGM1pvcUdUTlIvODFzekJFQ05Md1VwN3RtVmZDVms3?=
 =?utf-8?B?OVIweGg0RVdzVDQ3akVybkxacU8wNFliSWUza1QrMjl5S2VNSTV2eVV5elNl?=
 =?utf-8?B?ZzdLeXhCNFUzc2pWM1dOWmVIaEc1YkJUYWZQam1DUHNiL3pPUFQvOEdXWEdF?=
 =?utf-8?B?aXB6blBSa09JcHR0aVJmRUpUZk1ZdFhoUmg5bGtnczIzaVZqRnFVNDVrMVNE?=
 =?utf-8?B?NVhzWE15TjFLNHlNcGVSS1RSQ1ZhU21YcDBNSVViNTF2TUI1d0xRbDFjcXJP?=
 =?utf-8?B?dUJtQzM5d1JXNW9pS0QrR2lhQUpuUHlST2haK3orQ1pvVHN6MFZ4Y1ZNZUhK?=
 =?utf-8?B?M1RtVEM3cndaR2czMXN1aVppM3JvYklidzZXTWsxaXlsS1JWTExKQ2F3VEtT?=
 =?utf-8?B?MFo2MFNqRWNtcDFXV0NDYkcvenpEbXBCVGVUS01rV1IzcUR1SnowUlFRUk9t?=
 =?utf-8?B?SjJaWEVtemNUNkIrcEY1T1NXRVdJWmxQOWo1dDZ2TmpDZENxZ1JFemlqYmdo?=
 =?utf-8?B?YVBVdW1BeUxVVkJCYTRsUERnYXgvWHZGQUF3Yjk2QTVwRkphQlp1RERoTFFT?=
 =?utf-8?B?cW5zRU8xZFRva00raUltYlB2VVlJWnVxQmpDeEMwdE1DWVhLTHBERjR3Wm14?=
 =?utf-8?B?Y0pocloxdXF5MXpRYlZRSmNPZkhFRHJZb0Q1MVRnT2ZkOHVDVUJURHZzNFBj?=
 =?utf-8?B?SHhPMEJFR1lwdzI0UXJYRGIrZWw4QUtuNjIzSXREclo4NkdmZ2VhOGJQc3BF?=
 =?utf-8?B?MTN2V1llT1hlS0Zsa2lqMGMzSWJ5UjNZcWt3UTNXSEh3clFoRVhzN2JTY2Np?=
 =?utf-8?B?ZU5aQVNKTVBTWm9oNHZVVUpmb0x4djQxWEZOU3BGbHBUL0VvOUNhbGJBbi9K?=
 =?utf-8?B?R0ptT1N2UlZZVlV4WnFVRnM5eHlwR2haMWJQS2Ryem40OHhTRzVxMmRpNnNY?=
 =?utf-8?B?Skw3bUhmaDJINGVMSys0bjEyeGxJaFQxMC9KTkoxNHU1d3RkSWZ4amVRR0lz?=
 =?utf-8?B?VEprUHRpQTl3UjFUVGltaGcvK2trWjMwS2p3bjBBMWU4bGhRaUdveDArc2lq?=
 =?utf-8?B?QVg1YlQ5bldOS3F6RVhxQ0J6S1RHMlhML00rM1JXdUUwMXBVcHBURlFsZDlP?=
 =?utf-8?B?UjgydzRxTmNOSk5IbVpDNk95ZzF3QWZ3ZDNtMzUzeW5JYkFZcElodHg3ajl1?=
 =?utf-8?B?dFFwV2pGVEFjVjNaUWRUWGVqcVNydE95VW94TFlWM2hHbjlMamxmb2t3c1Rn?=
 =?utf-8?B?ZGo4TVE5NGhSaW1LT1V4VVhMemE2ZjNVaXNVLyt1SWNWNllFb09GMDVJSFJi?=
 =?utf-8?Q?PogKiFy5RekzOKn1271oylF8R7xpBBhW2VhYo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0JOL0wvUFlvQ0lXWi9QNlZQKy90c1dWV0tnTk1COWE0Q0FPK2pERENoV0pM?=
 =?utf-8?B?M2lYazZmdE12R3k1aFNqdmw1eHJMNW1KejVqd0xlMWpzTVJJRnlNVDcyR245?=
 =?utf-8?B?dmJRUXVxTWpZMjB5dlFSaHVWWTBQbE1xQ3ZDdzhzbUp2STR3bW92RmF0dGJl?=
 =?utf-8?B?alJPQklRRk91NHFkMGpkaHptME5lb3hFRVRhK0phQlZzbmlhaVBQS1lFcHZF?=
 =?utf-8?B?Qk9XbXN4aWkxNWtiNGkxcEhSczdUZEUvUS9vTGdWRzJsbXRTT2dhZlI3ODJB?=
 =?utf-8?B?c3pFdFgzQjMxR3NUTzlCY1RkN21nN3BsVWZydDNoRjF3cHdzaXFLUGVrU3Vx?=
 =?utf-8?B?YnBOeEhBSXloSndtNzh1cnBJR2ZoejFBR0RBMVFmZERmMzMwaGFmbTZkQndM?=
 =?utf-8?B?Y05vWmVOTkFJaXF0dzkzTnRUcElUK0ViL2pZZjkvd251YWY4N1FZNmNFY0RB?=
 =?utf-8?B?ajB1QVZMejNrNyt1V3Irc0RnMjFGbnVab0M4eU9YZ0tJOWhzMWN5bDBKNU92?=
 =?utf-8?B?T2EyTUFhVFlHeEdLRDl3VGEwTGhxa2hudiszUzJXT3JJY252M2tiZkJIUE8v?=
 =?utf-8?B?eEFDcU8zR2wwT0FnTi9vaGVBNnpRdExoSGZjbWVReW9yY0NXTTdpK1VBNWE3?=
 =?utf-8?B?ajNPcTB2Um5UUFMvUUJUdXlEL0t6cWVLb1NCdk1wd3N4S0liVldnU0V1VnZo?=
 =?utf-8?B?VnNDNmlpc3JRRWN2V0dmSmNNS3pzVWdCYUd3MGh1S21kUVZtdnBsTUF5blRx?=
 =?utf-8?B?bFp0R216V1pTeFBJd0JvWGplcHg2Tmh6a0t3MVhOVDNYZGxYYzZPZVM5cEtZ?=
 =?utf-8?B?UHQwRllTZWkrRGFJdkExZVQ0NHgxT21pMzB2Qm1mc0xjd1dzR3RGc1E0REg2?=
 =?utf-8?B?Qm93NUV1YVVadUdpT3FGWXN4dzhCZ3d4NHF1d3VDWldqT05ibmtsSlFXbk5B?=
 =?utf-8?B?Ti9QMTFXRmFTbnhqVXVKWk5MZWQvRUV4aFh4dzNLTm1rdlhFSTh0RXJSKzBo?=
 =?utf-8?B?MzdtZ3paOG5kTUo2cHRtZkJMV0tmcVpmak00UmpGblZMc3BFYy8zWEx6NG9q?=
 =?utf-8?B?R0M2bXI4SU9XUnduUjRMVFVpTEMwN0NjT004RjJ3cjJRS0VZZ2g5ekh4UXVD?=
 =?utf-8?B?eUxRL09Nald4UGt3MCtjRGNZRjNTOGxHS09YRDFDQm9mMzRlMVZTdzMxSjlo?=
 =?utf-8?B?bnlpbWRxNWJkSDRjK1FkM3luejRTVWJpU0F6V0ZqQVJmQk9PYXZoVjdsUE1V?=
 =?utf-8?B?R3FEVytJajIyMkpheTg5NVpIenFYV1lSVVZMZWlqNnNOdFJSMlVtMW5kWTlJ?=
 =?utf-8?B?ejlpSFBVMUZFT1JlV2p4cHQ2b3dvR0IzZGQ5VzM0RTV0Yzl2TjAxZk9jekN5?=
 =?utf-8?B?ZFdJZFBlKzM3Q0J3eSs2V25aTUxXK2dHbXV6Y3Vqdmg0Mm8ySXZrK3BoL1RT?=
 =?utf-8?B?eG1rT1k5TTc4dzV4UE5XemxVaGRrNmFhZlp0VEpBN2hMNFRTUWkxbkdWUHJR?=
 =?utf-8?B?bkxjVHkzVzhKZFlIRU5CZUp5dlpMNEQxYmNSVy9KTjJFSzZIdm1oVVJMMGZ4?=
 =?utf-8?B?VWIwb2lKTXQwRGRMRXFGeFcyTGJHYmZTbG1WdUdlUTB1SnFPdlFYa0puY0Ji?=
 =?utf-8?B?VzhDMzYxY3dnMzE0cG11c2V5VFBGQXAzcUpGenFHL1dHTzI5ZE5hVGt1eWZu?=
 =?utf-8?B?NmV4bkpTbkVuejd4dmNGUnpNbWY3eDByY2p2NUZZRlFJVDZuNWdpNHY2TWxq?=
 =?utf-8?B?eUhpTW5XaGZBLzRmSEQ5L2ZrMnNteTZqYlBFQnpzVzcwUnZEVHlOOW5kR3pX?=
 =?utf-8?B?MW1xYTh3eXpoak04cVN1cCtTMmdTakdCRGZ1czhJV1FBc0loLzI2SHVkN0F3?=
 =?utf-8?B?Q3NXbkZDVjJjWTM5MlQ4T2llMUNVM0xLN1J0eWVzZS9TWmsxTFRXbFJDZWEr?=
 =?utf-8?B?S0FkQzZiWjRvQ2RMUWI3YlA5dFNINmh0T0NiU2J1M3JMdHRYUy9rNEhhOTVa?=
 =?utf-8?B?bTIxVW41UU9EQU1aWGtkZVRIZ0dZUGppeHR5K0sydHllVFZKYndxY1NsT3lE?=
 =?utf-8?B?aGlYbnFtK0VzMmtSdUUrM2REWE9wa0h2T1E0UldVN2Fyd1NncGo1THVBK1Vs?=
 =?utf-8?Q?OiemBF+dp4CRY6wW6+NaQEdC+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3abdebfc-6d88-4adf-764a-08dd002daf3d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 19:43:57.0759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x3yULh7EzlssD2/epa1bIeceDlBqeRRs5umjC4szxJqa3XAUh8bmP87i9d5bQ5H+6cVbxNiK8aJKIabVqxAXRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8669

Add three registers: doorbell_bar, doorbell_addr, and doorbell_data,
along with doorbell_done. Use pci_epf_alloc_doorbell() to allocate a
doorbell address space.

Enable the Root Complex (RC) side driver to trigger pci-epc-test's doorbell
callback handler by writing doorbell_data to the mapped doorbell_bar's
address space.

Set doorbell_done in the doorbell callback to indicate completion.

To avoid broken compatibility, add new command COMMAND_ENABLE_DOORBELL
and COMMAND_DISABLE_DOORBELL. Host side need send COMMAND_ENABLE_DOORBELL
to map one bar's inbound address to MSI space. the command
COMMAND_DISABLE_DOORBELL to recovery original inbound address mapping.

	 	Host side new driver	Host side old driver

EP: new driver      S				F
EP: old driver      F				F

S: If EP side support MSI, 'pcitest -B' return success.
   If EP side doesn't support MSI, the same to 'F'.

F: 'pcitest -B' return failure, other case as usual.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Chagne from v4 to v5
- Add doorbell free at unbind function.
- Move msi irq handler to here to more complex user case, such as differece
doorbell can use difference handler function.
- Add Niklas's code to handle fixed bar's case. If need add your signed-off
tag or co-developer tag, please let me know.

change from v3 to v4
- remove revid requirement
- Add command COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL.
- call pci_epc_set_bar() to map inbound address to MSI space only at
COMMAND_ENABLE_DOORBELL.
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 129 ++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 7c2ed6eae53ad..52e36c7c04c85 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -11,12 +11,14 @@
 #include <linux/dmaengine.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/msi.h>
 #include <linux/slab.h>
 #include <linux/pci_ids.h>
 #include <linux/random.h>
 
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
+#include <linux/pci-ep-msi.h>
 #include <linux/pci_regs.h>
 
 #define IRQ_TYPE_INTX			0
@@ -29,6 +31,8 @@
 #define COMMAND_READ			BIT(3)
 #define COMMAND_WRITE			BIT(4)
 #define COMMAND_COPY			BIT(5)
+#define COMMAND_ENABLE_DOORBELL		BIT(6)
+#define COMMAND_DISABLE_DOORBELL	BIT(7)
 
 #define STATUS_READ_SUCCESS		BIT(0)
 #define STATUS_READ_FAIL		BIT(1)
@@ -39,6 +43,11 @@
 #define STATUS_IRQ_RAISED		BIT(6)
 #define STATUS_SRC_ADDR_INVALID		BIT(7)
 #define STATUS_DST_ADDR_INVALID		BIT(8)
+#define STATUS_DOORBELL_SUCCESS		BIT(9)
+#define STATUS_DOORBELL_ENABLE_SUCCESS	BIT(10)
+#define STATUS_DOORBELL_ENABLE_FAIL	BIT(11)
+#define STATUS_DOORBELL_DISABLE_SUCCESS BIT(12)
+#define STATUS_DOORBELL_DISABLE_FAIL	BIT(13)
 
 #define FLAG_USE_DMA			BIT(0)
 
@@ -74,6 +83,9 @@ struct pci_epf_test_reg {
 	u32	irq_type;
 	u32	irq_number;
 	u32	flags;
+	u32	doorbell_bar;
+	u32	doorbell_addr;
+	u32	doorbell_data;
 } __packed;
 
 static struct pci_epf_header test_header = {
@@ -630,6 +642,63 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
 	}
 }
 
+static void pci_epf_enable_doorbell(struct pci_epf_test *epf_test, struct pci_epf_test_reg *reg)
+{
+	enum pci_barno bar = reg->doorbell_bar;
+	struct pci_epf *epf = epf_test->epf;
+	struct pci_epc *epc = epf->epc;
+	struct pci_epf_bar db_bar;
+	struct msi_msg *msg;
+	u64 doorbell_addr;
+	u32 align;
+	int ret;
+
+	align = epf_test->epc_features->align;
+	align = align ? align : 128;
+
+	if (epf_test->epc_features->bar[bar].type == BAR_FIXED)
+		align = max(epf_test->epc_features->bar[bar].fixed_size, align);
+
+	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {
+		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
+		return;
+	}
+
+	msg = &epf->db_msg[0].msg;
+	doorbell_addr = msg->address_hi;
+	doorbell_addr <<= 32;
+	doorbell_addr |= msg->address_lo;
+
+	db_bar.phys_addr = round_down(doorbell_addr, align);
+	db_bar.barno = bar;
+	db_bar.size = epf->bar[bar].size;
+	db_bar.flags = epf->bar[bar].flags;
+	db_bar.addr = NULL;
+
+	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &db_bar);
+	if (!ret)
+		reg->status |= STATUS_DOORBELL_ENABLE_SUCCESS;
+}
+
+static void pci_epf_disable_doorbell(struct pci_epf_test *epf_test, struct pci_epf_test_reg *reg)
+{
+	enum pci_barno bar = reg->doorbell_bar;
+	struct pci_epf *epf = epf_test->epf;
+	struct pci_epc *epc = epf->epc;
+	int ret;
+
+	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {
+		reg->status |= STATUS_DOORBELL_DISABLE_FAIL;
+		return;
+	}
+
+	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf->bar[bar]);
+	if (ret)
+		reg->status |= STATUS_DOORBELL_DISABLE_FAIL;
+	else
+		reg->status |= STATUS_DOORBELL_DISABLE_SUCCESS;
+}
+
 static void pci_epf_test_cmd_handler(struct work_struct *work)
 {
 	u32 command;
@@ -676,6 +745,14 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 		pci_epf_test_copy(epf_test, reg);
 		pci_epf_test_raise_irq(epf_test, reg);
 		break;
+	case COMMAND_ENABLE_DOORBELL:
+		pci_epf_enable_doorbell(epf_test, reg);
+		pci_epf_test_raise_irq(epf_test, reg);
+		break;
+	case COMMAND_DISABLE_DOORBELL:
+		pci_epf_disable_doorbell(epf_test, reg);
+		pci_epf_test_raise_irq(epf_test, reg);
+		break;
 	default:
 		dev_err(dev, "Invalid command 0x%x\n", command);
 		break;
@@ -810,6 +887,18 @@ static int pci_epf_test_link_down(struct pci_epf *epf)
 	return 0;
 }
 
+static irqreturn_t pci_epf_test_doorbell_handler(int irq, void *data)
+{
+	struct pci_epf_test *epf_test = data;
+	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
+	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+
+	reg->status |= STATUS_DOORBELL_SUCCESS;
+	pci_epf_test_raise_irq(epf_test, reg);
+
+	return IRQ_HANDLED;
+}
+
 static const struct pci_epc_event_ops pci_epf_test_event_ops = {
 	.epc_init = pci_epf_test_epc_init,
 	.epc_deinit = pci_epf_test_epc_deinit,
@@ -909,12 +998,46 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	if (ret)
 		return ret;
 
+	ret = pci_epf_alloc_doorbell(epf, 1);
+	if (!ret) {
+		struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+		struct msi_msg *msg = &epf->db_msg[0].msg;
+		u32 align = epc_features->align;
+		u64 doorbell_addr;
+		enum pci_barno bar;
+
+		bar = pci_epc_get_next_free_bar(epc_features, test_reg_bar + 1);
+
+		ret = request_irq(epf->db_msg[0].virq, pci_epf_test_doorbell_handler, 0,
+				  "pci-test-doorbell", epf_test);
+		if (ret) {
+			dev_err(&epf->dev,
+				"Failed to request irq %d, doorbell feature is not supported\n",
+				epf->db_msg[0].virq);
+			return 0;
+		}
+
+		align = align ? align : 128;
+
+		if (epf_test->epc_features->bar[bar].type == BAR_FIXED)
+			align = max(epf_test->epc_features->bar[bar].fixed_size, align);
+
+		doorbell_addr = msg->address_hi;
+		doorbell_addr <<= 32;
+		doorbell_addr |= msg->address_lo;
+
+		reg->doorbell_addr = doorbell_addr & (align - 1);
+		reg->doorbell_data = msg->data;
+		reg->doorbell_bar = bar;
+	}
+
 	return 0;
 }
 
 static void pci_epf_test_unbind(struct pci_epf *epf)
 {
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
+	struct pci_epf_test_reg *reg = epf_test->reg[epf_test->test_reg_bar];
 	struct pci_epc *epc = epf->epc;
 
 	cancel_delayed_work(&epf_test->cmd_handler);
@@ -922,6 +1045,12 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 		pci_epf_test_clean_dma_chan(epf_test);
 		pci_epf_test_clear_bar(epf);
 	}
+
+	if (reg->doorbell_bar > 0) {
+		free_irq(epf->db_msg[0].virq, epf_test);
+		pci_epf_free_doorbell(epf);
+	}
+
 	pci_epf_test_free_space(epf);
 }
 

-- 
2.34.1


