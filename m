Return-Path: <linux-pci+bounces-17099-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0245E9D2F0D
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 20:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE3FCB2B32B
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 19:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10A21D31BA;
	Tue, 19 Nov 2024 19:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iId3zEjR"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2055.outbound.protection.outlook.com [40.107.103.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8817F1D31B5;
	Tue, 19 Nov 2024 19:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732045515; cv=fail; b=Lcx0ISUdThZaaYk3unQN4S5066kao6zYYuu0efjbEy9pvBQipYqnBIihe9yTpzRkW+9sWMAf3WhyBPmiPcHjg7N3MdPTf2mJF5sagTVtFI2OaRQN0OpM6wRMoPSuL8RZWpm2iTIVsXyGUQf5mMGpI2HkXDg8bWWZr47fYh3cPAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732045515; c=relaxed/simple;
	bh=mbHe59tkIpbHTtvY3w/H80mU68bHhQgeFO0tnBttso8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZNFaEdPgYfMJKsx6e+M0LS8zRyQS2Z3i4Wy+dneYJKILC2CPBSM5//z2t+LFK2BTh42efnWDDM42oNxse2obdAR2oFMgaEQaN+T8LVcfWqJTYdZ6gBu5Y/yVjgf7bjPbkSkvVzHJs6LnMIS++5Nr1JAFhSYfTbniJZ1sBS2wlGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iId3zEjR; arc=fail smtp.client-ip=40.107.103.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMyUQHftAbEqaz4D3/FUQTGQzGzCzf62tVdlP0tPB6rhWdWFsle8ZiFlfp/z82eZfnhsGvnhGmhcKxJVBOkWoAOrN4KddEHZpFWWwvsAoNNGNfs7A7f0DceEhMSdiL7XWsU9SBgaAQj6FBEPpAa2GFftaCoG4Fzctyi+H33W9W4qO7Wbm79HyN3bkyMjjdOMLBzSAYhb6QS75yZYULryP06P0S6xS00b9I1bCtZIFaqDJFm9u5FYR1iQfotcEFsIb/uVEeT3wvd83VPAOKQjIgtz5mV0N8BCIbEcADbzbxm3JeBETUE5FDIQns1pXaSA9WNTiQAP50gTiLVZ77iIag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L02xQI8CqGMvu/Xott6SAD1YcJnHf27P2jsLGw+ynKY=;
 b=sPHpX0Hq1E/5XgiCIqkk/+GZsdLipcZ09aTKO7fd2+bFf2gyAi25t//9p8f4swT2yQM9oM0vN97xxOS6+8KNx2AsCWwZmflDOaJ5gVrlogIHYPr73xoNFFNDA/TbKGCltvBiuGeuUh2QHlC6/4xcsz2GCfGLc8SHhsh5oKZwOu3Nc6WIYtffdAZ35Nyht1nSOaKXJ3nG5CJ1rk1HNAH5y1h70tcJqdQrkFWEVUA1/mwmLdqrvn6kPeHZvYM7NH5CEivoELup95Sx4Fj+xxqAK098VIBbakmdBu0CIM4VVfiRo2SZFNR8s9qE4knfV6Uj4xaH1lJ0R3dKmE5amZ6kmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L02xQI8CqGMvu/Xott6SAD1YcJnHf27P2jsLGw+ynKY=;
 b=iId3zEjRBJIpCymv3E28zXpQYv5o3XkQRx25nvmzsAHPi3J8anUdcc7YtsWop+PDqC5P2Mj/PR2ZR+5/Q7CiOoKgZQjV9MNl426Pf+URC9wNvOp4nNgwfJnnK9z9uYbSX/lnvE6sj14vKN5g1kdcAaRKuNDDhj+GlE52rjXNPBnIJ3BQmcra5K9jC6o1RJQfQSLPQtzFiFBgOuyDlaTcAjm96kI+j0lce5LxMU8g7suX7mj572bmd78uq8kxKaXKNHOcKfWV38c0BzCEdgujEMoJolckscA+cdVAdmOjD5A/GPGqAlji1lFy/bJk2JKbIaXASXgQb9TMnv0240cvdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DUZPR04MB10014.eurprd04.prod.outlook.com (2603:10a6:10:4db::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 19:45:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 19:45:09 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 19 Nov 2024 14:44:25 -0500
Subject: [PATCH v8 7/7] PCI: imx6: Add i.MX8Q PCIe Endpoint (EP) support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-pci_fixup_addr-v8-7-c4bfa5193288@nxp.com>
References: <20241119-pci_fixup_addr-v8-0-c4bfa5193288@nxp.com>
In-Reply-To: <20241119-pci_fixup_addr-v8-0-c4bfa5193288@nxp.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732045469; l=2548;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=mbHe59tkIpbHTtvY3w/H80mU68bHhQgeFO0tnBttso8=;
 b=s8zSC1wVV41AI86MzbTvnNDCe+Z8XvF9S85E+UaQQbDhYDbZkgOb+t8zjBVPlKUYzwzLYX+1y
 hYuk1VmUiZvCBQjEUR43aRvHcrRiY+707uRzoIMZKJgS7iCtVRIH1Ob
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DUZPR04MB10014:EE_
X-MS-Office365-Filtering-Correlation-Id: 97664a82-7382-4f8c-661c-08dd08d2aceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjVJektGV3dkdG9GK3RBZEcvL0FBUmFNRkRSbDFqS2RPbkE4R0ozTE5DNjJu?=
 =?utf-8?B?RDFjRU45VS9qMXhiaHJvcWtXVnd4ODgxL00zL1hLWE53dVJ0THJSNmZtQUlB?=
 =?utf-8?B?VGZwTHN6Nk5NVDlSTTVETTltVFdiSHhGZytBN28vS0lmdmJuSXlDMDllb2Yx?=
 =?utf-8?B?dTJwbU5sRlEyUjRBQ2diQ0FMVGVqNUFVeUhjUFNBWVNoUEFQZEYwYWJGZGVx?=
 =?utf-8?B?TmVGWVBvdTdSQ3hybGF5ZGRaUlhlNk9BWG9mYTNTVlRtSlpSN2Q1aUNuMUVn?=
 =?utf-8?B?ZjM5bVBzNURpZTVZSU0yTXNCcjFkL0ZLL3NBRWF6OGM3RVFFL3JUWnFEWFRZ?=
 =?utf-8?B?Y2VKWjZYaXpjdW9PM3RFT00ySHNkMHdrTlo5N2VzN0VPR3JrWlJlZy9uelNI?=
 =?utf-8?B?Z2RRV21GdnBwRkk0bkRBTXVXZytLb1daOUV0Z1V1VlZUenV0Q01lU1c0ZFN5?=
 =?utf-8?B?WXpHS3RhdmhiNDlJME1NRWVsTHJsWCtHcHNJbHhwYkpRQVdSQW10aXo4SXkv?=
 =?utf-8?B?SGFLUlo5UUU0VHVYdGpFOHhhN0pmNWtRV3JqS2Fhc2V2R0sycXorQ0J0bHFm?=
 =?utf-8?B?enJLdGFOWlN1eFZ5eWNyL0VJRlRmVGYxMFgvTXlweGtIMzZVbDRteFR4YzNM?=
 =?utf-8?B?UDdsVklZRE0zY01KYURGd0Z1Q0F4N1huRlFOUUdZMFJUZUJ0dnZFQzdINzhq?=
 =?utf-8?B?QjQ4bHNkaTB0TWsrWUQ3UzJLbG1qSEl4SWRqRlRFbnRYZFpHYU9ReTdaMU9n?=
 =?utf-8?B?VC9KMVRvSkplU25ZTXUyV3FyMUlueWw3cG5mM3NPVmNRblBJbkx0OEpQcHhC?=
 =?utf-8?B?Y3NRWVRpS0V1MTdXZm0wSTY1ZFNUMHQ3ZUYraFFXWU1NakNXSCtNczZZUndG?=
 =?utf-8?B?M0tiRzU1U0U5QjNBc2UvTHltbDZjU0NXVEdId3ZFQThqUDhmb3hudHNMSnlm?=
 =?utf-8?B?V2lJVUw3M1kzSXBLWko1ejJoeTFSdTZqVFBYcDlSMjFZRVJ3WTB5TTZ3WDk3?=
 =?utf-8?B?OEovVTh1WVBTOEM3ZzdVYktqSjgzRlByVVRsajFROUN1VDFOM3MwMkpKcHp5?=
 =?utf-8?B?VTZLTHoxNnVWSmxhS3J3U1RHSGtQUkp2UW1xZ0lhcFJJNjdNNjBnV2NiSjAy?=
 =?utf-8?B?cmJoeUVBaWhHckpDMEtpZElnUmFsYkJBM3FGWFlGVXRFZGxsajU3eUpNU2ht?=
 =?utf-8?B?WkhPdStOd2o5SGtpc3VLb1dWZlR6SERsWS9PWjZaQmFLcnNUZnFVaWZ2ZHZU?=
 =?utf-8?B?cWw5aWZFV1BMcDN0R2MwOENKdUd3NzllbUVrNit6VlZhalNoQVQrcWtjVVlV?=
 =?utf-8?B?a0xpdzFkYUM2RDlsajV4UHpySzdGZDl0NVZMVDd6M20za1R2RlVMYTRCTE9S?=
 =?utf-8?B?S0REWGE2NDlmUWI1N0VvZFk1bmxTKzhwa3pJVW9HVkp3WnVLSmdrQ0Z4M3ox?=
 =?utf-8?B?eThZZlBTMnpOTWxqNnhqSERWY3hnQkhobW9nL0N3SEdiZWkwcVkxWTVCVWNR?=
 =?utf-8?B?TDRnZWlDc1l4dEJnTDZYUnRvb2JML0d2bURsQWxYSTFqOXkrcUtIeVdiV1pQ?=
 =?utf-8?B?T2NOcHlWTDlmTGVMTW5sbzB1TWg5WmtwcGsxc1RzcjJYSlc4UTdBSHhPeVRz?=
 =?utf-8?B?bjJ0b2pQVHEwV284WG9yeXJlK1RFektTNjA1dmVjUVpCM2loOWJ4OWNvMUZT?=
 =?utf-8?B?aXVsTnpFSXcwTFhPVU43UlYrS04ySThGOHFPMEUxRHlyYkNHczRpWXdWdm80?=
 =?utf-8?B?QVZwdGJEeUc1S29tUUpReVMzOWNLYmo3eWl3MzBLZlBVOVM5eExYZHJKdy9q?=
 =?utf-8?B?TDhQaEd5RzE3M1E5emV2R0E1UUl3MlZBQ3k1QUFKa1ozb1RIa2t6RWNaM3VK?=
 =?utf-8?Q?MAw3ArUFJQKd8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHgvRHlqK1h1ZU5nNitsc2ZXeUt0MzQ4OCtWVXJRT3gvTWxzVENFNDdSN3lR?=
 =?utf-8?B?SkhybW9FVjFaVWJMcWRuakZtdzA3ZTEyaE0ybzZVUkZ1d2pUNlIzUnViaU0x?=
 =?utf-8?B?R0J0VWxvdDRvODFEVlV5T1g4SXp4UGN3L3hGSExUbFlNNUdvOWt3cXpIRnhr?=
 =?utf-8?B?RlpCOHhxUkxpOU0rdWJSaW95b1hoWUU3L2JJZGUydVgrZ1NqRC9zTkE0eE1K?=
 =?utf-8?B?emVGVHM5NlMvaE1oZ0NOYU9PQ3B4a2hOTWVncVpZTk9CaGllSVJzUm9DUENX?=
 =?utf-8?B?cXhNM3M0ZkhvdStsbFNUTWZFdzNucnBmbVcxekxqU0tDVjZTdlNvSU8xOEZx?=
 =?utf-8?B?djV0ZHZ5ckRaMVlDUVBpU2hCVWdLbEpUNzBoOTZWb0VUSUROYlhlQU85R3hR?=
 =?utf-8?B?VUJjM1Z5ZGV1S2pmcmhsVXY0cUlOV29HZTJxeFdoSG0vNlJtNzVIMThiVnFs?=
 =?utf-8?B?RGhqMDlmRmNOZzVJdHdxejZGRFFqREJFYWhmM014Z1B0OHU5eXJjZUFvUDc3?=
 =?utf-8?B?OHdRK2FnWGdLNWw1a3dMajJFaUV3TXRtQ0pQcERMdklWRlV2cVRiVjV3UHl5?=
 =?utf-8?B?c09nUWx2bG5XVFRiTktTZGVFRUdPbW9yOEVGbGVWWHkrcUFYOVdRMmxiVVZs?=
 =?utf-8?B?eUJNNldtU3JNd0piNGFFRVlLRVBlSjM2K05KMXdLa0o4aERSdTBZVVFGVXRG?=
 =?utf-8?B?WTRHRW1BaGhJdDNGZ3RiRUIwemxXUkM1cGhvOXRxOHp2aXdTb1UrNHk4MFdJ?=
 =?utf-8?B?ODdOWXFvc041emw0OHlMdS9HR3FUZWc2TVhMVEhNbkdaTW00ZHZ4ZlQ1YVgx?=
 =?utf-8?B?QWo3SUpoMHJPREFNK2NBclBOTzZBaklvY1M1S3VkMmI2WDVCRXJ4OE9BT01S?=
 =?utf-8?B?azdkbW9JL3d0SVpWWlZHVjBzSzlqQWxxK0xoUnJ2dEcwOGxCSklMNHlaMWtL?=
 =?utf-8?B?STFvcmovYldaUmZNNkh3eEJzb1BUZWZETUNZYzlGVWtvSTZnWjlmdi9kYjd4?=
 =?utf-8?B?b1lhZHREMHlSUzVxUm9DdGYrbUhFdDVVTWtkZVAzaFZEUENpSUh5SzdvelND?=
 =?utf-8?B?K05aK3NLM0RSVjVvZ2N1eG4wZG9hckQ2QXNUK3VRTmphdFpvVFBqclA1akVL?=
 =?utf-8?B?MWgzMnNRRGxuV05ScGVQTzVSd0c5a0NFMThVcW5MYVArTkZKZENTWlcvM3V4?=
 =?utf-8?B?ZGM1cE5NRklpUEMrV200U2d3cUUzTkxNRWQ4Wk5LcXU5bEl1ODZsRTN2dCs3?=
 =?utf-8?B?YThwS2IzVENrTmRnampRazI1c1dRanN3TktnRWliY0Yza1FSWC9tYnBhR2o3?=
 =?utf-8?B?OHVELzRWUFZZcTFvWjRRYkdkdEM3N3FyQXVwcUQzQUwyNDcyVmZBVTc4eGt1?=
 =?utf-8?B?TDFXOW1sdjJiVm8vTmFFcUY1TGtIeE1MNkZSRE9Ja2h5ZUtFZktOVFdYRkxa?=
 =?utf-8?B?NC9tb29DUkZ5U3QxRk54Um8xb0doazhjcis3MXl5aG9VWGhWRlpNNndqRTdr?=
 =?utf-8?B?N0o2SnRaT29FemJ1SXBGcXJaL3IrUGZlcy9ZMkpIaFkrYWI4K1pRQzZhelJY?=
 =?utf-8?B?RjhuMzRwYktQZURBUi9HWk85empVVFh2b0liRUxWaWVzZTdyK3BEN1dHVyts?=
 =?utf-8?B?VDh4K1NSdCtsZmJnZ0NVV1h2T00xOHA4UDRKYnhJR3hVVFhldTdvM3lxS1Bo?=
 =?utf-8?B?ZlZCZTFwd2dzN1ozYmo3RVRVbHhUa1lPSDlULzJNTmxZY2xSTXlzYWdJTkRq?=
 =?utf-8?B?bHVIWVp4djdzZGdUcjZISVFmSUZEeDM0V2xVUnBYdVUxODVXQkM2VENMWHgw?=
 =?utf-8?B?MFc4emwyUWhqeDBMY0JCL0srZFlsTHlHTHlkY2FHcDVvVWt5ZElBTEs0MDZx?=
 =?utf-8?B?UkJhRmc5T1lwSFVSVTNuRHlTRWhScUp1UzlKR09kRHFjTjFaS1E4Yndua1Nn?=
 =?utf-8?B?ZE1WaTl4MzJqMXBuV3E3WDNuVHFqYzJNSG40b0kvTmlTNmNyd01qVW9uSGpn?=
 =?utf-8?B?WXlGbmhRZE8rNno5bE5kbkVNSTNOVW8yQmRsN0wybU1FdGsyS0ovTWMyczhX?=
 =?utf-8?B?RHM4QnJ3Y3dGdTl2UnBiVjh4Z3RERmZhR29kT1FWcWtaM0w4eFZoT2lzcmpj?=
 =?utf-8?Q?awv8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97664a82-7382-4f8c-661c-08dd08d2aceb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 19:45:09.5248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d1/zzoPF1jcGfQUTur3z25o48loXrecIP4G7FWte5TGJr/KqpsHaxD1XXtmiBG52vTubhOrrYs/yx/JJPd2nMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10014

Add support for i.MX8Q series (i.MX8QM, i.MX8QXP, and i.MX8DXL) PCIe
Endpoint (EP). On i.MX8Q platforms, the PCI bus addresses differ from the
CPU addresses. The DesignWare (DWC) driver already handles this in the
common code.

Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Chagne from v3 to v8
- none
change from v2 to v3
- add Mani's review tag
- Add pci->using_dtbus_info = true;
---
 drivers/pci/controller/dwc/pci-imx6.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 5303dfc3dbb41..d457514d17485 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -70,6 +70,7 @@ enum imx_pcie_variants {
 	IMX8MQ_EP,
 	IMX8MM_EP,
 	IMX8MP_EP,
+	IMX8Q_EP,
 	IMX95_EP,
 };
 
@@ -1061,6 +1062,16 @@ static const struct pci_epc_features imx8m_pcie_epc_features = {
 	.align = SZ_64K,
 };
 
+static const struct pci_epc_features imx8q_pcie_epc_features = {
+	.linkup_notifier = false,
+	.msi_capable = true,
+	.msix_capable = false,
+	.bar[BAR_1] = { .type = BAR_RESERVED, },
+	.bar[BAR_3] = { .type = BAR_RESERVED, },
+	.bar[BAR_5] = { .type = BAR_RESERVED, },
+	.align = SZ_64K,
+};
+
 /*
  * BAR#	| Default BAR enable	| Default BAR Type	| Default BAR Size	| BAR Sizing Scheme
  * ================================================================================================
@@ -1627,6 +1638,14 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.epc_features = &imx8m_pcie_epc_features,
 		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
 	},
+	[IMX8Q_EP] = {
+		.variant = IMX8Q_EP,
+		.flags = IMX_PCIE_FLAG_HAS_PHYDRV,
+		.mode = DW_PCIE_EP_TYPE,
+		.epc_features = &imx8q_pcie_epc_features,
+		.clk_names = imx8q_clks,
+		.clks_cnt = ARRAY_SIZE(imx8q_clks),
+	},
 	[IMX95_EP] = {
 		.variant = IMX95_EP,
 		.flags = IMX_PCIE_FLAG_HAS_SERDES |
@@ -1656,6 +1675,7 @@ static const struct of_device_id imx_pcie_of_match[] = {
 	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
 	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },
 	{ .compatible = "fsl,imx8mp-pcie-ep", .data = &drvdata[IMX8MP_EP], },
+	{ .compatible = "fsl,imx8q-pcie-ep", .data = &drvdata[IMX8Q_EP], },
 	{ .compatible = "fsl,imx95-pcie-ep", .data = &drvdata[IMX95_EP], },
 	{},
 };

-- 
2.34.1


