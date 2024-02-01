Return-Path: <linux-pci+bounces-2941-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8E2845CCD
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 17:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F6711F2CD34
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 16:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E0715DBAC;
	Thu,  1 Feb 2024 16:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QKD9f8hD"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2059.outbound.protection.outlook.com [40.107.104.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371A615CD40;
	Thu,  1 Feb 2024 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804037; cv=fail; b=h9+/1AKuNwi114NIFvWe8dYxtrqpN6gs1IqjdDn9RuP0SuSt7RTDr4ZKfHF/enE3A+zDHfJgZpdcYmHyezWVmt2a3Y6Vzhy/AaAf5PsDC5Xxsq9veCQNc9Kh5jpdhMuxh16ru79ARHYNAPfRv7AFUUzanquMNHSYw+rOChe1BhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804037; c=relaxed/simple;
	bh=hzGYRhAZl9U+Uvuu6aIidx5j0fhBAx2klPXN/eaV8Q8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=iffr3MDhdd8+v+v0PCNgg/CI5AvDRHj4xugJ3sC8IWqm4qpXYivpY3Zq27HZYPKxSv34VG1RODJzZK0Esxx5+h2mhCCV7BXw4ElxEkFUjEktLvven967NX2IAnrWDE3nfXSxPpl969OeZMDQD3g61N9vCehXWzbNYOp1kNaVq6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=QKD9f8hD; arc=fail smtp.client-ip=40.107.104.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ir7oEeMSBi+KMIgd5WSug7eGi1DvXdAyJCqixfn/3SUkqajL+T7Fu1W4U7RpP6opVFAtrmkvuroRUHO6oni9G04ipjDuiKhziylDdKCIks1zZCRCCg0733k+cnCI4RsY+babHhO/OUS57WnYt4qxYBJLC+9DNwm6I/+LmYoKcjJtz6czGtj7G7G7q4Vym6fVPoFLgx1bLJCAMjxmy0pT+RGpEEYr4uji+VLXQBCNyJtxp67uks7JFD++4AoEph12Z8OP2mTuW194hTiuh0p8fsjNusADv+EZ20D2FJVyCdsD2gFnVanVn0SJ1ecbkIq/BZ8WFkXvLUnLaOClRoQxfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0z4U3sEC3khiRNkm46MPnkPrIySIybGo6ofqvEZ86Bc=;
 b=ELvO7lwShuhmNsV4C4OWDjrPB0aihAPWLeS6WclmkunNXSguijy3jXZKUjzdzX/G4bbIuoeEgKh4DRXMdKxH3DL56UBiqdIfD/Q1aWoZcFZuwn4mrAJxKCC3w1K7QQpvV03IhWdHJpvq+M7Xm60GmUcPeS30mXml2Lind1tvh4q+YMaVOJWFKV1IgGHeDHf4CcTgGObxdeqwsNMhmkRJIN8RtbgMa6QSJzU4oM4lKhCAvTq/CtRnFNHYdgz9rFSPSEbdFAoVgGq9XrM7Jy+pE0yjrilaDx66s6PsIsnP95FtDu5cgUeDzpGfzkn2PA2jeQUMG0yg8JfTbJ7I6kin2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0z4U3sEC3khiRNkm46MPnkPrIySIybGo6ofqvEZ86Bc=;
 b=QKD9f8hDqCFrpPCP4x7T3E7mjaa9vfETQVSY6OLsJfTpBq2a+UD/YE0w0/cLS63xGTGhx63BYijM3yF6EuLiHvm7xO99chVH/++htbcjIBYVg8K4jHWzAwi+MM0tj80Ak2WeAf9L/ukGAtkUj+PoUYs8aMD+ZjPIfLJpK0gXWDk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB9110.eurprd04.prod.outlook.com (2603:10a6:20b:449::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Thu, 1 Feb
 2024 16:13:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Thu, 1 Feb 2024
 16:13:52 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 01 Feb 2024 11:13:26 -0500
Subject: [PATCH v2 2/6] PCI: dwc: Consolidate args of
 dw_pcie_prog_outbound_atu() into a structure
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240201-pme_msg-v2-2-6767052fe6a4@nxp.com>
References: <20240201-pme_msg-v2-0-6767052fe6a4@nxp.com>
In-Reply-To: <20240201-pme_msg-v2-0-6767052fe6a4@nxp.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Serge Semin <fancer.lancer@gmail.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706804020; l=12761;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=HU4ER7vz+HwzR2rHdE/BVWAKQXG5UmDhW10DZ8OHeTA=;
 b=/nG5ov9U+Bp++6VJGCBINBDC6OCrCbdPcMtVZyZhDf2qNHn1BWG3t0Nib7QeXX6MY9vznuKQY
 6pbJRM0J94gAYn9AvFweHAuP4ZFDifKjqi3fPi6ysms0c6WvFoOiIrt
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0065.namprd05.prod.outlook.com
 (2603:10b6:a03:74::42) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB9110:EE_
X-MS-Office365-Filtering-Correlation-Id: 2add2321-01cf-4040-8690-08dc2340c7fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zz4KBrm0vYuUAKpxdPEVv3CERqPqS1BQ50blGOlAFShGqTKofFQ7B+lEtDrgIaWWLcbiT5e+nKntL3ErmnH3X6smDIqienF205H79tjnCO8FHiQymjMGSjr95Oi5bHP3+iPyzL4L29cuT2+K3Yp7Rm7UGv3j98buOw7sKTGwRjKkYYRClpsrB9vnPq+Oq5RYBCXjDeseVnOyIp8DF+KZI8aOg++o/mrlANSE+Y4CmW4fvNub5LaAZYYia5e9dXMq0YprlBK+ZMFFctjGZY3uRnvCksFWmBx0hjCSq6e/blvf63Ay+pBj7os1XKkiioNOL/v6QquM5mVaoEhwNw9svH5zCv/iU0dhSQKQq/XtIWV70PATExaUMVWKdpfTEIUOE1p6P+rI2WFLI2ycU+tgjpH41wBKzhlpmttz9qLbpWEckcHmD/+IIjqRD3BfGJs40U3FeArzsxo8s5dlVVblp1ALDYeS5RYAkmKQoayw7pNn0/D8EzED15GXJfdsmrgk8uBSiGUB713bd4DTxJj5Idgjug3W6F98GdkXseOjkEXd5dtaZh9O6caQqx69rzETotvkUCHanu7iDnlMDfwsJtEk96KxqIwEstGvDfSk17WsWz+s6fRBFb5+Y3qyzJT6iFeve6XvGtZithAaF0b/yg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(396003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(2906002)(30864003)(7416002)(5660300002)(41300700001)(6486002)(36756003)(86362001)(38100700002)(478600001)(38350700005)(52116002)(83380400001)(6512007)(2616005)(6506007)(26005)(6666004)(8676002)(8936002)(4326008)(921011)(316002)(66556008)(66476007)(110136005)(66946007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUg4OWpLUmFSY0RyendUb2YwZE1lSGpZODNpYnJwdVhuUU14dmVYK0hyOFFq?=
 =?utf-8?B?czYvRTFydDFCVzBFRzJ0TGthbXNkbUZNZlZTTkZYUkVIVXpaK3FpMFFVYUdv?=
 =?utf-8?B?U1F2d0gzbUhZTTBVMmdrU09qWWxXY3c3Tm1xeFF6WnFGYVl5KzNzRFRlZDVa?=
 =?utf-8?B?bTJwZmYrU01uZVRKWXZzVkRHZWplWVF4T1M2WTBrSFFISHNjSDNKd3Ayb0xk?=
 =?utf-8?B?bC9vcTU4Z2dPU01OQWQxbVRybFhQN1ZNMS9rQ25PelY5SHRTYjFBcVF1eGJt?=
 =?utf-8?B?dzhUYloyVUVVZkpZdVdsVHlnYWMxOG9TMVhydXRjN1ZqenY4NkRMSGZQcW1U?=
 =?utf-8?B?UnUzRFBRU3FnVTJKV0lOTDFMeFBlR2hjalRzeFgyZkFRbFVNQWExMXdBcW1S?=
 =?utf-8?B?MTRtUFdreklTNW5mN3I2d1FWUGRwYm9zeTFZZlRuQkVkdDUwK05WQ1Z0SjQ0?=
 =?utf-8?B?K0tBTUZmbG9mdTYvQThFL0hCOEt3UXE0ZldsUDJrMGF3d0lNb2xHdmxEZEU0?=
 =?utf-8?B?akIyNGhjVVZrTDhkb0l5UlZzcEh5WXZmYWxvLzFjZzRtR2h2Q1NhNkx3dXZB?=
 =?utf-8?B?dW1MWndXZXdXMUgvbXliOWRPTzN6WVVnZTdzdjh3WngrcHZ5Y0g1SXNON214?=
 =?utf-8?B?SmRFeE12Ny9hTStKbXJ2Sm1sMkQyMktBYVNNMUpYWnRtM09ORFZ1cE1UdEhN?=
 =?utf-8?B?ejlRWjJuS05PRWVsU1g2anFMbkN1M1Iwa2dSMi96N25BdFFrSVk0cEt6dFQ5?=
 =?utf-8?B?cXNRNnVqV0RvNkU1L0tsODRjc1pWcDIxQzRjekJVazYvR1B2UmtidzhvYTV4?=
 =?utf-8?B?RDhlanB5NVk0cnovbEdVRnpIa0MvcUMzU3MySm1yd3JSbUt2c0IrNE1meW12?=
 =?utf-8?B?NDh3Rm9qZXExbHNjSW1mbzRxTzVLUS9vSk5SR3crU1FMQTBCOEJ3UFZBNGxs?=
 =?utf-8?B?cUZ0NTd1Q1RZVFJRM09NTm5MYVd0MHI0diszTHJ5b3d4aE53TjV0WTNFcFZ1?=
 =?utf-8?B?YzhWbmdXM2JRZ3hZcEFvRjlGVG5IaFdnNVFXM1pEaDNZd204dGVxaWRhTjI5?=
 =?utf-8?B?WXhSL3BWVSsrNmRTRlRKaGMyOGROczBXYWtadFZiU3ROQzliMXROOVRZclJa?=
 =?utf-8?B?RkNWaVcrTzZhT2RyS1YwMVJaSWcydDZzc0lwMy84eVZlN2grSUNOSmVjNWJo?=
 =?utf-8?B?d1ZPMDRqWnl3RGtCQ1lHT1VPUTRYa1ZiQVBkTjhnS00yeG9EZy9JbW1EOVBE?=
 =?utf-8?B?Q1AzNXhEbUx3RjZZTnhQTEk2anNWWXlWMUtpVGUxSlpaVWwrVy9rUWp0MW45?=
 =?utf-8?B?dFZIK3E5SVo3N2IvSDY2SGdLS3F1VkRSalpEQzBMYURZdnByZkJiTko1M0dH?=
 =?utf-8?B?UjJWNmFQZjU3MXZ6aEw3TnFqVFphNXpOZGFpU001VWRiaGpyS3ZzS09JdVpT?=
 =?utf-8?B?OGhDUnl3YmFEWGZTMHNldmVnNG1CdlZaUXB1R25aWEdqY2JySThIMFBOVGJE?=
 =?utf-8?B?TXJqdllOVnVlQ2tPVWJ6Y0tKbkw2aHRDblZwV2NpVXgxa2NiWmFWNkJiRlJz?=
 =?utf-8?B?RExzVlhqbHVRR2VPakdJajltVjkxd3BNVVlXRmx5eUhXVDFxVnlJSTRGY0M5?=
 =?utf-8?B?OUhocnVkL09lUnJiNlYxY1g0MGFLUkQyZ1lYQXVudlk3Vm1ydFpaOUhoNjNo?=
 =?utf-8?B?NGwwQlErT3NxVXZVN1VZS3JrSGZVb0F5RUJYSjIxb0V4bS9abnVlTW41SERU?=
 =?utf-8?B?S1NaTERHVk5QZmZtb2FlVTNMdk03SVBlVUMyS2ErTjVnWGNzc0M1c0RlYU16?=
 =?utf-8?B?R2dVK3pkTFN5aGlTZ1B6Z1BzelNaYWZic3JJRW1iMnZ2TDBvUlptRGhDR1lZ?=
 =?utf-8?B?Z0RHaE5lNWNiUVlGMDdxdVRNeFNRUVR0KzVNRVJGb3lHWFJ5VFlZbk9MdzV2?=
 =?utf-8?B?dmdHWHZYRjhWdEQ1enBLYlhPQU5MNjA3S1Z5cWY1dXBSOC9Vd2VYVGo1UXRB?=
 =?utf-8?B?bXVLdW9NSitjSzJLUVZvT2hDRVVRR0hNZUtWUzRDbFh1L3dOVTZpK2FnYkV4?=
 =?utf-8?B?OFpOV1VONE11T0VxeGJLVW5lNkE2cWpXRE1sU0s3Vm1sdTdLQy8yVEtsVDRw?=
 =?utf-8?Q?XCXQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2add2321-01cf-4040-8690-08dc2340c7fe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 16:13:52.0804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bI4IkCQyImCsA1kVk5u8IuAtJcCFOnhSfzZuahBc1D6+RdaT1yWgNLyKyyGN3sXna/3A5Yg8RGyfEHdoGuna9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9110

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This is a preparation before adding the Msg-type outbound iATU
mapping. The respective update will require two more arguments added
to __dw_pcie_prog_outbound_atu(). That will make the already
complicated function prototype even more hard to comprehend accepting
_eight_ arguments. In order to prevent that and keep the code
more-or-less readable all the outbound iATU-related arguments are
moved to the new config-structure: struct dw_pcie_ob_atu_cfg pointer
to which shall be passed to dw_pcie_prog_outbound_atu(). The structure
is supposed to be locally defined and populated with the outbound iATU
settings implied by the caller context.

As a result of the denoted change there is no longer need in having
the two distinctive methods for the Host and End-point outbound iATU
setups since the corresponding code can directly call the
dw_pcie_prog_outbound_atu() method with the config-structure
populated. Thus dw_pcie_prog_ep_outbound_atu() is dropped.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c   | 21 +++++----
 drivers/pci/controller/dwc/pcie-designware-host.c | 52 ++++++++++++++++-------
 drivers/pci/controller/dwc/pcie-designware.c      | 49 ++++++++-------------
 drivers/pci/controller/dwc/pcie-designware.h      | 15 +++++--
 4 files changed, 77 insertions(+), 60 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 5befed2dc02b7..27956b2a73be7 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -159,9 +159,8 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
 	return 0;
 }
 
-static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, u8 func_no,
-				   phys_addr_t phys_addr,
-				   u64 pci_addr, size_t size)
+static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep,
+				   struct dw_pcie_ob_atu_cfg *atu)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	u32 free_win;
@@ -173,13 +172,13 @@ static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, u8 func_no,
 		return -EINVAL;
 	}
 
-	ret = dw_pcie_prog_ep_outbound_atu(pci, func_no, free_win, PCIE_ATU_TYPE_MEM,
-					   phys_addr, pci_addr, size);
+	atu->index = free_win;
+	ret = dw_pcie_prog_outbound_atu(pci, atu);
 	if (ret)
 		return ret;
 
 	set_bit(free_win, ep->ob_window_map);
-	ep->outbound_addr[free_win] = phys_addr;
+	ep->outbound_addr[free_win] = atu->cpu_addr;
 
 	return 0;
 }
@@ -279,8 +278,14 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	int ret;
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
-
-	ret = dw_pcie_ep_outbound_atu(ep, func_no, addr, pci_addr, size);
+	struct dw_pcie_ob_atu_cfg atu = { 0 };
+
+	atu.func_no = func_no;
+	atu.type = PCIE_ATU_TYPE_MEM;
+	atu.cpu_addr = addr;
+	atu.pci_addr = pci_addr;
+	atu.size = size;
+	ret = dw_pcie_ep_outbound_atu(ep, &atu);
 	if (ret) {
 		dev_err(pci->dev, "Failed to enable address\n");
 		return ret;
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index d5fc31f8345f7..267687ab33cbc 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -549,6 +549,7 @@ static void __iomem *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
 {
 	struct dw_pcie_rp *pp = bus->sysdata;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct dw_pcie_ob_atu_cfg atu = { 0 };
 	int type, ret;
 	u32 busdev;
 
@@ -571,8 +572,12 @@ static void __iomem *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
 	else
 		type = PCIE_ATU_TYPE_CFG1;
 
-	ret = dw_pcie_prog_outbound_atu(pci, 0, type, pp->cfg0_base, busdev,
-					pp->cfg0_size);
+	atu.type = type;
+	atu.cpu_addr = pp->cfg0_base;
+	atu.pci_addr = busdev;
+	atu.size = pp->cfg0_size;
+
+	ret = dw_pcie_prog_outbound_atu(pci, &atu);
 	if (ret)
 		return NULL;
 
@@ -584,6 +589,7 @@ static int dw_pcie_rd_other_conf(struct pci_bus *bus, unsigned int devfn,
 {
 	struct dw_pcie_rp *pp = bus->sysdata;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct dw_pcie_ob_atu_cfg atu = { 0 };
 	int ret;
 
 	ret = pci_generic_config_read(bus, devfn, where, size, val);
@@ -591,9 +597,12 @@ static int dw_pcie_rd_other_conf(struct pci_bus *bus, unsigned int devfn,
 		return ret;
 
 	if (pp->cfg0_io_shared) {
-		ret = dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO,
-						pp->io_base, pp->io_bus_addr,
-						pp->io_size);
+		atu.type = PCIE_ATU_TYPE_IO;
+		atu.cpu_addr = pp->io_base;
+		atu.pci_addr = pp->io_bus_addr;
+		atu.size = pp->io_size;
+
+		ret = dw_pcie_prog_outbound_atu(pci, &atu);
 		if (ret)
 			return PCIBIOS_SET_FAILED;
 	}
@@ -606,6 +615,7 @@ static int dw_pcie_wr_other_conf(struct pci_bus *bus, unsigned int devfn,
 {
 	struct dw_pcie_rp *pp = bus->sysdata;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct dw_pcie_ob_atu_cfg atu = { 0 };
 	int ret;
 
 	ret = pci_generic_config_write(bus, devfn, where, size, val);
@@ -613,9 +623,12 @@ static int dw_pcie_wr_other_conf(struct pci_bus *bus, unsigned int devfn,
 		return ret;
 
 	if (pp->cfg0_io_shared) {
-		ret = dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO,
-						pp->io_base, pp->io_bus_addr,
-						pp->io_size);
+		atu.type = PCIE_ATU_TYPE_IO;
+		atu.cpu_addr = pp->io_base;
+		atu.pci_addr = pp->io_bus_addr;
+		atu.size = pp->io_size;
+
+		ret = dw_pcie_prog_outbound_atu(pci, &atu);
 		if (ret)
 			return PCIBIOS_SET_FAILED;
 	}
@@ -650,6 +663,7 @@ static struct pci_ops dw_pcie_ops = {
 static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct dw_pcie_ob_atu_cfg atu = { 0 };
 	struct resource_entry *entry;
 	int i, ret;
 
@@ -677,10 +691,13 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		if (pci->num_ob_windows <= ++i)
 			break;
 
-		ret = dw_pcie_prog_outbound_atu(pci, i, PCIE_ATU_TYPE_MEM,
-						entry->res->start,
-						entry->res->start - entry->offset,
-						resource_size(entry->res));
+		atu.index = i;
+		atu.type = PCIE_ATU_TYPE_MEM;
+		atu.cpu_addr = entry->res->start;
+		atu.pci_addr = entry->res->start - entry->offset;
+		atu.size = resource_size(entry->res);
+
+		ret = dw_pcie_prog_outbound_atu(pci, &atu);
 		if (ret) {
 			dev_err(pci->dev, "Failed to set MEM range %pr\n",
 				entry->res);
@@ -690,10 +707,13 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 
 	if (pp->io_size) {
 		if (pci->num_ob_windows > ++i) {
-			ret = dw_pcie_prog_outbound_atu(pci, i, PCIE_ATU_TYPE_IO,
-							pp->io_base,
-							pp->io_bus_addr,
-							pp->io_size);
+			atu.index = i;
+			atu.type = PCIE_ATU_TYPE_IO;
+			atu.cpu_addr = pp->io_base;
+			atu.pci_addr = pp->io_bus_addr;
+			atu.size = pp->io_size;
+
+			ret = dw_pcie_prog_outbound_atu(pci, &atu);
 			if (ret) {
 				dev_err(pci->dev, "Failed to set IO range %pr\n",
 					entry->res);
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 250cf7f40b858..df2575ec5f44c 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -465,56 +465,56 @@ static inline u32 dw_pcie_enable_ecrc(u32 val)
 	return val | PCIE_ATU_TD;
 }
 
-static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
-				       int index, int type, u64 cpu_addr,
-				       u64 pci_addr, u64 size)
+int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
+			      const struct dw_pcie_ob_atu_cfg *atu)
 {
+	u64 cpu_addr = atu->cpu_addr;
 	u32 retries, val;
 	u64 limit_addr;
 
 	if (pci->ops && pci->ops->cpu_addr_fixup)
 		cpu_addr = pci->ops->cpu_addr_fixup(pci, cpu_addr);
 
-	limit_addr = cpu_addr + size - 1;
+	limit_addr = cpu_addr + atu->size - 1;
 
 	if ((limit_addr & ~pci->region_limit) != (cpu_addr & ~pci->region_limit) ||
 	    !IS_ALIGNED(cpu_addr, pci->region_align) ||
-	    !IS_ALIGNED(pci_addr, pci->region_align) || !size) {
+	    !IS_ALIGNED(atu->pci_addr, pci->region_align) || !atu->size) {
 		return -EINVAL;
 	}
 
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LOWER_BASE,
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LOWER_BASE,
 			      lower_32_bits(cpu_addr));
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_BASE,
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_BASE,
 			      upper_32_bits(cpu_addr));
 
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LIMIT,
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LIMIT,
 			      lower_32_bits(limit_addr));
 	if (dw_pcie_ver_is_ge(pci, 460A))
-		dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_LIMIT,
+		dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_LIMIT,
 				      upper_32_bits(limit_addr));
 
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_LOWER_TARGET,
-			      lower_32_bits(pci_addr));
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_UPPER_TARGET,
-			      upper_32_bits(pci_addr));
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_LOWER_TARGET,
+			      lower_32_bits(atu->pci_addr));
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_TARGET,
+			      upper_32_bits(atu->pci_addr));
 
-	val = type | PCIE_ATU_FUNC_NUM(func_no);
+	val = atu->type | PCIE_ATU_FUNC_NUM(atu->func_no);
 	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
 	    dw_pcie_ver_is_ge(pci, 460A))
 		val |= PCIE_ATU_INCREASE_REGION_SIZE;
 	if (dw_pcie_ver_is(pci, 490A))
 		val = dw_pcie_enable_ecrc(val);
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL1, val);
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
 
-	dw_pcie_writel_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
 
 	/*
 	 * Make sure ATU enable takes effect before any subsequent config
 	 * and I/O accesses.
 	 */
 	for (retries = 0; retries < LINK_WAIT_MAX_IATU_RETRIES; retries++) {
-		val = dw_pcie_readl_atu_ob(pci, index, PCIE_ATU_REGION_CTRL2);
+		val = dw_pcie_readl_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2);
 		if (val & PCIE_ATU_ENABLE)
 			return 0;
 
@@ -526,21 +526,6 @@ static int __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
 	return -ETIMEDOUT;
 }
 
-int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
-			      u64 cpu_addr, u64 pci_addr, u64 size)
-{
-	return __dw_pcie_prog_outbound_atu(pci, 0, index, type,
-					   cpu_addr, pci_addr, size);
-}
-
-int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
-				 int type, u64 cpu_addr, u64 pci_addr,
-				 u64 size)
-{
-	return __dw_pcie_prog_outbound_atu(pci, func_no, index, type,
-					   cpu_addr, pci_addr, size);
-}
-
 static inline u32 dw_pcie_readl_atu_ib(struct dw_pcie *pci, u32 index, u32 reg)
 {
 	return dw_pcie_readl_atu(pci, PCIE_ATU_REGION_DIR_IB, index, reg);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 26dae48374627..d21db82e586d5 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -299,6 +299,15 @@ enum dw_pcie_ltssm {
 	DW_PCIE_LTSSM_UNKNOWN = 0xFFFFFFFF,
 };
 
+struct dw_pcie_ob_atu_cfg {
+	int index;
+	int type;
+	u8 func_no;
+	u64 cpu_addr;
+	u64 pci_addr;
+	u64 size;
+};
+
 struct dw_pcie_host_ops {
 	int (*init)(struct dw_pcie_rp *pp);
 	void (*deinit)(struct dw_pcie_rp *pp);
@@ -434,10 +443,8 @@ void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
 int dw_pcie_link_up(struct dw_pcie *pci);
 void dw_pcie_upconfig_setup(struct dw_pcie *pci);
 int dw_pcie_wait_for_link(struct dw_pcie *pci);
-int dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
-			      u64 cpu_addr, u64 pci_addr, u64 size);
-int dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
-				 int type, u64 cpu_addr, u64 pci_addr, u64 size);
+int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
+			      const struct dw_pcie_ob_atu_cfg *atu);
 int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,
 			     u64 cpu_addr, u64 pci_addr, u64 size);
 int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,

-- 
2.34.1


