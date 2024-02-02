Return-Path: <linux-pci+bounces-3028-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4808472C5
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 16:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A043A1C20AD5
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 15:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13651474B4;
	Fri,  2 Feb 2024 15:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jXf0/5f2"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2078.outbound.protection.outlook.com [40.107.8.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B741474A3;
	Fri,  2 Feb 2024 15:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706886722; cv=fail; b=NOOP+Gjjd4odfaHiVXsuB3bJamPIo5qOyxc6wtL8RiN7RlcYWgIn6w2Q9qHLdUYyqSE4J1wQ51olxOe6rQMgZd0T2OegacnDYv+WIFGZO/C2KaF4s62vQpRf9aOo3ZBhORiLY7iyl/CbZFWvFTLxlP7dl2qpUJCiwWu8vZGhiOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706886722; c=relaxed/simple;
	bh=ze2L3Nl6ITdmvSqJ46+wd69F0Sc18FLzWocNjgTx/8s=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JV3G5vqS2b2j3382dbQfmLw8RvoupTRtB5Qs97Lj7HT2wxOu5IbRTE0UFZsVuC2ht8d+F1OODQMPBVOhPg54tX2PcvRwOigOndh8msrzclN6Vf8VQQtbM1I6uix5Di3p+I0cLJ8DppSCEYkTflPHTev9zhAHqIIDbFU7fvycGSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=jXf0/5f2; arc=fail smtp.client-ip=40.107.8.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrXlYjPkfN4WCxgfELF1aHrn7NpkUJzjQR86BQOgk25FPLQ2psMpbpwa+1/UsbLmM5xszwgk3vrHncUYlxuKrqBXNucBojZgeN+iGmCX4TGJgS1QDTU2Pp4PPB17OBzl2vh+02SaswdH2SZiU8M2l72hUoPykrlpB+d6CAsi1ZsU1ix/TigZP+zoBKbSZ58x+06QRpvKfzyRwoCdSqHZtsqCAgqMa1YAG+rYefSIIoRemDftLcIhvZVYk+IZaWHurwdmsQLGs3IXMfPY65pGVf/vR/YL3cvnK+TjjPr06s8iao7FzuxcwjmL5MR99hU9U6BZziLuhqTT04Ej8/8E1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCa+JiPEcnah1R3m5WeFYRmyUijTCb6SN5/1c3JFNUU=;
 b=fTkN5c2t08IIsCAiUR02P5oR7MdvUQPblduzFTMurpnyVML44yXfrdrMk02rvg4TfbVMakl1BC5M78tIFm8TwhHWEqsw9eKmwE6tAV2kpIzmHkTul8MND4v7fs1WzTx31yI940xIXwNWm1i3kNU8AHlXmXD3wL/eFYh1uimcCT/W6nUn/hW+IYZ9s+REVaagBpvJqjHxUvSkEMjAdQx6NcjTBcENNNmMvQ/1eOzgWCQ5tFU1rUJrUf8yf/DhiKdZDEBaXpkq02/i9xhepTKEDHeOKX/uFa37raxUndX9OyCZTneMmoZHJHIILzORK8CJL6ndo/L30RBGKdRsDqcRkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCa+JiPEcnah1R3m5WeFYRmyUijTCb6SN5/1c3JFNUU=;
 b=jXf0/5f2MOt9s45aqwmvPFzN3ysU5RjgI9smCPq43lDpxkCnPGivx0IarIMg5Jcu4euWwDkAvFExeTQwi6YHkeI9COqqx2Og3T59vbRvVSni8KbhiyEwGETnZwGtw9wgjQxeQyXgi0g/LnXkMEFk6x4APb8teapbKkDUnePVWzM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8425.eurprd04.prod.outlook.com (2603:10a6:102:1c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 15:11:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 15:11:55 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 02 Feb 2024 10:11:26 -0500
Subject: [PATCH v3 4/6] PCI: Add PCIE_MSG_CODE_PME_TURN_OFF message macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-pme_msg-v3-4-ff2af57a02ad@nxp.com>
References: <20240202-pme_msg-v3-0-ff2af57a02ad@nxp.com>
In-Reply-To: <20240202-pme_msg-v3-0-ff2af57a02ad@nxp.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706886696; l=608;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ze2L3Nl6ITdmvSqJ46+wd69F0Sc18FLzWocNjgTx/8s=;
 b=xlDvb9xvDjSEKHo89z84k0VDggPn/A4dlj/anQGCt1jr/oF4yq0trB1uzBZg/oYW01NcRcxi0
 nOh0m+ApYo0BGbAMaxkpSGzhDFofkvy6R/qNNdH6AWITHqmg0hJd5Wu
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0138.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8425:EE_
X-MS-Office365-Filtering-Correlation-Id: 3017ce15-a94d-4d6f-b6e8-08dc24014b40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ifUWixetP84DiubFlEQoUUEbQS5GXz3Q3+rW9OQXNSUoe5auOEarY6hwJBmc73y5ecK3YLTiYTncjAMwcVy1dsAgSEFz+hxwmvodH312gAyMm+sC1xz7Aymdc/0z+SSr6AyctMht/MzYvBvUy9i4hDzYqLBufCtNau+53GQ4puKhiJrB2nFSlO1bCcT1lUGNpI7Dky7zY8zFxbdO8u4S/OVGNOoDBw7Un6cxpRwOEJIBJZzyFiIXOkA+dUnVJs6mj9rSElsxyemZxYP3/OX6TRiVE391RbbX58NhvNniemT8NG+MA/zcZqfMm7X6mJeKylEIfGvnkhej5XwQC/fMnDcvQzwmXaJPzgKpkcN99TdDMEpDQZuzts4n7zj+uvhPui35UC/Twi9b94r8YJuQLkxbS+q+UfPEgX/Ev/mNqdkF3qyWAOUL25SW3RIaOOe8KubK4GUmmhtNJ84GtT/5GwULn7q5tqeHCcdrK2wkqIyKjp3MOUDEzb8T7hF8Ioyv98BdpUbiGFM7HzsZlDQwtz1/hGX+Fy+n29YFZuI4+M5yZAtJok143JxePHmmL8/65Y5emO9NkZqP+G/ECuZxnYOyMTcUoL3y4kA3D1J3x6ZAcybFdOBIltiBlr+RPDXhDHYD/gM+Kdtx4T9zgDxpPQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(366004)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(2906002)(478600001)(7416002)(5660300002)(4744005)(15650500001)(83380400001)(921011)(38350700005)(4326008)(36756003)(66946007)(8936002)(8676002)(316002)(66476007)(86362001)(6506007)(6486002)(52116002)(6512007)(6666004)(41300700001)(26005)(2616005)(66556008)(38100700002)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S09DVEt5em11T0RVL0hYbUtXWW5LVUlYcFZPT002T1BSU00wMXFSNjgyUTVn?=
 =?utf-8?B?TyszRyswcUQ0N0lNQWdJVHVzd2QrSjlTbmdRV0FLbzQ1VWloMzhDM3JBczRr?=
 =?utf-8?B?VzZYQmtqemFSNmdhcUFEN0Qzc0dvN08rZDYvaEVycjZhYng2dGhPcUdYUFMx?=
 =?utf-8?B?MlRoM0hkdXhQaEpFOUtFTXJyenp5LzdxL2ZXVmNuaERKalBMS24yZHY3WGJP?=
 =?utf-8?B?cDFrcFJaNmlRT0MveG5MMzVQdTQ5WG9uOHBNUWIvbmdqVXZqNEc2elBYZ21j?=
 =?utf-8?B?N1BuVG5ZTVpaZ3FBemM2WU9OUDhuRmVpYmFodlRYTlU5V05FS3FKYjBNT000?=
 =?utf-8?B?cmdNTDA2VW13WlVmSk15S0g1blF6MGw4R2RNNnFwMWpnTU13SmhBZWVTTTBs?=
 =?utf-8?B?SWJLN3hNbnowTXduVlZoakZUYm9qdXBnd29kYVlVbkJuektMdjlyOW1wRTBu?=
 =?utf-8?B?cGJYd0tIWWdCdzJONDVIU0F3SHZQWE9UVDIxNEhMVlZRTlNuU3kvd1hsdTJ6?=
 =?utf-8?B?bTFXNklRM3A1Nk9QMEo5VUpTRmZQZHA0ZCtpRUIyL01aTUlZb1VvdzlFN1NG?=
 =?utf-8?B?dmxMdk5Rc29ibm94cUlyZEdDaTVaN24ySzNJTTI1dE5SVm9ML1BoR1pJY3l3?=
 =?utf-8?B?S3NuYXBaa0JUZ21obzRsdXNXQnMrNVVaVUcwc1hEL0J3WTE1TWVJSXRjTWRi?=
 =?utf-8?B?YUJma0VqVkQrdGRqMGlKL21QWU83bXM4WUpFOEFraGhmY1YyVFdzQURNai9B?=
 =?utf-8?B?S1NzRi9vREpScjY5YVJSWXRhcVlNczE5N3YzQjcyMG5EVm5EcVFqK25yVjEw?=
 =?utf-8?B?NlBpNFZMN2gwblBqQ2JIN1U3ekFmdVFxcVFtL2M1bU5RUlVDYkVKUHFZenEw?=
 =?utf-8?B?YTJFOGxyU2puRWR5Q0k0cDg1TTJuQ084MGdKZnJqRVNPbEttb3Q3NzlwR3Z4?=
 =?utf-8?B?TDNVSElJSGxwMGZXS0l3OVpneGEwVnlOWk9Pc1lvdDlrUlkremdWZUppbVNC?=
 =?utf-8?B?SDN5UFBQaVBsdVFZYldVTmF2OUR2dmtyME5vdXRCdU9TZmFoL0NYL1E0a3ZZ?=
 =?utf-8?B?UkhMOWpFNVR2ZGlFOHF6bU11MjllZExFS29GeHMrV3c4NE9nc0o3dUs0ZWR0?=
 =?utf-8?B?a1AzTHJiMTN3QmRXd1lNOUVJOGpJR295VUlEdDRKNkYrMllmTFRPeXFvQi9w?=
 =?utf-8?B?KzFac0dkVUdMaHZZb2syVU1RSFRvbUJweGdZSm5pMHE3V1p4UGdiaENxeUdh?=
 =?utf-8?B?d3UwdFgyZU9qYzRwM1JvZzNWME9jMjd2UHR5SXdrTitvT1lzZ0lzQ3EzZG1a?=
 =?utf-8?B?cWxTZG51NytkMjg0NzBpSUZxdi8vTGZOMnBmbExUT2thbnQ5NzUrOWtJbi9C?=
 =?utf-8?B?amRHQ3ZWWHNlQ2k2dFlRQjJrekVqbmZNd1BrTjh3L2J6OXEzSlRoWWZTaEJ4?=
 =?utf-8?B?OWJLcVFEb0FYM2orQzJHYlRieGNxbnFBWW5laVBuMlZGVi9xYVNReDdlMjVR?=
 =?utf-8?B?U1RJVkZ2MnJTTGxoUHJabzdXQmlDZXN1RVpqeWdieHRKN0dmMTNNVDBPWWJV?=
 =?utf-8?B?VDhSL3NRM2daYUpaNXk1cG1Pd1NXU0RzN09ZOWRYNmlrUTJ4NmhMWWpSSmVQ?=
 =?utf-8?B?RFJiWXBnSW5OTkNGaVhXZEF1Z2owWXBEd3N5OHVnN0UrTkVXRlI1OUZBYnpR?=
 =?utf-8?B?dExDMjNyUnF6TEJHdlA0Q21SRXBQMldiVysyS0F1Wnd1ek0wNmpjNXM0ZEFI?=
 =?utf-8?B?TnBEa2k3Wld0VEV3RE5HVk5DK3I4Q0JuaG5pNU1OUXJBWVVmTjNHYTFHQzNQ?=
 =?utf-8?B?VVBxK1NXWXpMVUdyd05oMDJyV3IvZWczNmJRcEpERDN0eWFEK0tNbk0yUUtQ?=
 =?utf-8?B?aTFzVVduWGYwNkZqWXJDTUFDYzRLVUtGS0owc1pVUmZjTTN5THlYMllZVE1B?=
 =?utf-8?B?ZXZiVys5eWFQZFVBUElqUmJTK0RHVjQ2SHFYM1pMTEU1MkpBR1k0UUpKNWIw?=
 =?utf-8?B?d0NIaWZhaHF0N2t1Y0J4REZIOG1UUDBNTE1VL2p0WnNYZStOT2xCWTd6UWlW?=
 =?utf-8?B?ZGpFQksyRGJkdEE1RnZmMjJhd2JYL1RuSnp3bVFLeXZ3ck4zcmh6Y3FNOEdu?=
 =?utf-8?Q?CGUwUyD0UIug54hsWW5ubZW7C?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3017ce15-a94d-4d6f-b6e8-08dc24014b40
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 15:11:55.6779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gboivQJz35c0wgYCRkLTnTfl8xi6ACmrMlDQjLxt99FHja+1krr5cPMTQfXXk6VY1JeG/yuOyIAxNWlBc6GeNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8425

Add PCIE_MSG_CODE_PME_TURN_OFF macros to enable a PCIe host driver to send
PME_Turn_Off messages.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/pci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ffd066c15f3bb..989681a0d6057 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -40,6 +40,8 @@
 #define PCIE_MSG_CODE_DEASSERT_INTC	0x26
 #define PCIE_MSG_CODE_DEASSERT_INTD	0x27
 
+#define PCIE_MSG_CODE_PME_TURN_OFF	0x19
+
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 

-- 
2.34.1


