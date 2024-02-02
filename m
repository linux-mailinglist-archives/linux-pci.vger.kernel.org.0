Return-Path: <linux-pci+bounces-3027-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C525E8472C2
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 16:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3161F24C76
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 15:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AE7146913;
	Fri,  2 Feb 2024 15:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KWEit8cL"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2078.outbound.protection.outlook.com [40.107.8.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83D314690C;
	Fri,  2 Feb 2024 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706886720; cv=fail; b=EIbDTMWN+bajMzhWduaWWZMK75L5QF6LDGnfV42WnturbrNwRIejA9IBG0tpT6O/4V/MD/oTJoQSBjCkJPZE6Af+R1ulZ3AjHyel926rd5VtTcCfM2g+DG5KSwWBcdoFWWq4mwSXjY80ya+f98tbxTkwDM2C6zMCg5KBQJkX17M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706886720; c=relaxed/simple;
	bh=iaMVhIlaxnDKrjo/B86UwmBA4lUHgRwjSU/hHDluay0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=MAw8MoLgksdxhwdczJOu50lB2eRMqDiCk1yA2hT8O9bGf2PaqBNV0a2eFA2gcp3tK/hFZLw7WeythoBaKHLPad99noq0Zo564EHFlz2ne8cRYamAq4sjyTYys0wrhbuKiB3APYZ9zqZnaQwCB+4OoWShHLegOaNE1jBjone8i/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=KWEit8cL; arc=fail smtp.client-ip=40.107.8.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NW2S8FjE3v5rMH2mFcB4bwCfWxviiTLkIaUAMTfM4tHIFxyAtH1q6MdRbH42Dk3FGFYN89mzgHme1HkPOwBOLv/x11W6gc7X+WFAeM05ISOD63AMraYsrG0IBERsIhMCMfN/C50VITsMvag/SYPU6vc9D4DsYUh9YscuRM989QTRp+xFQjbSg29vMn3QTkK2WCeyHyJhsoXDVXFXndHHDX2G1Bmq035on9VQ5VNF9dIkuMVwZ/cHKwnS5uEnSE7wwDgKIzoFKQjQWKYuWHLCFkXnEXIV+2qYAunfduuYyFvuXu/Yl7oRp0eXypaak7jdLjR3UeY9z9Py/0oVpsVS4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqraZNkbMXJ8bdVBUWBtPeGCWP+ilAu0pVj9SSD+e7E=;
 b=H2Na/P4TSko2s9CIZxcuAaiMjq1dNiyepk2Q5WOl9h5Cut8I6FwiXL2W/pU7LLNENAy/Vg1JLcBH4hErzWAbF3uyC1aBbuOxkfeJENIxEEtGfsxr7sZX36hvQuaa7UWDrzr3EwI9l7/aK6Ej0KqmzK/PoPqoCicjOSc3uycv5fjl70gJoRrVF+CkE/X+B2nmHk8Dajgq6zJUTBMTk/+33W847LoxTH8LvfaYNeDI78Ac7fiw/7Sd3v3jhRpHgr1tQ0ZPbS0YC8whv+fhhhyI+G3TqTjJTVWsJcbtfzUrKb/zp0NJJ2o4Z/lWEe5vqkbt0bJJleUmvZPjkYjhxGDU1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqraZNkbMXJ8bdVBUWBtPeGCWP+ilAu0pVj9SSD+e7E=;
 b=KWEit8cLjK6WiueMuo/WG8qwH6/JwQEBtLnCR/SfA8JV/c6/XFEMkZoEX/OpBCa0R0Lu4g9N3EEduDs+/rjlyC0A/dZtWZeevPO6gw+Su+h3OeCs/WDBP6jWhwKEcTZcmiSEs74jem5UYKry7+fiZWqVYucMc6ZW0FgWPUBXh+A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8425.eurprd04.prod.outlook.com (2603:10a6:102:1c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 15:11:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 15:11:52 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 02 Feb 2024 10:11:25 -0500
Subject: [PATCH v3 3/6] PCI: dwc: Add outbound MSG TLPs support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-pme_msg-v3-3-ff2af57a02ad@nxp.com>
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
 devicetree@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Serge Semin <fancer.lancer@gmail.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706886696; l=2940;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Vx141tscxeq3VO/J2v1vu73YFB2QjcNfIuChtPapKMY=;
 b=NA5IbWk8w8i/7XBwGa5boTLkm2rU/Yu6N0cLgfUosCrAZ5a9JXk1Wqg83FprrDPI1mBm6ROMp
 dRLQBqndzwlADK436tmf4kjh/+dYjxZTmgLh3wUoi/GdLcWmkE6vc6G
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
X-MS-Office365-Filtering-Correlation-Id: 7d2a9e28-091d-423d-ec52-08dc24014917
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2r7PWPD195gn9hPQAWJ2YkVgGqLkx13ttOiW93oW8/rv4qLnUisTCrp6jaUs9saVmKI4EpIKMi9yDM8N5wSD0R5Ebb2gSiJ9pV8rlRU1uQKQMa/eWBxhn5Wa9S7xnKojZIMJUPoFtdCf5SAWldRISS8ocB57Maq5uI7w3Om4igZjJbIUO+fwWz1PE/jyqy3xl5FC1psmzCRDzigtYwxFH+Qz5D2Z0UdUkzewbWyKamQkYLbAuq3Bq5KFdlCWLre+YebdLXI4akp014tYkaRc6uVQV6u6uN7gRknmqUxJEIQR19/V0yKpPBNkhgqGJHvJYNw6Yr9126UvMRFMDNYRIUJY54BawQVz7Mi8AXxCQEQzz2J9TYherbIEEvlAYyAkf+DapEBqupRxq3UxMNFn/WGowKlOvGofK7Tql1qtC/t/sLI9NbV7V5RxAhI+Fc0rZFbjbA6eqvXSPHnGAZCklRdf/Arbw+z1x8FSxdfHU+diQvnLUZOU+YTHY76VFdVJrSj75aq2Pf2MXQ68X9JojrJenBSCrSKLL8cjxwhlaEn4GGllwZY+L8lEneTRiBpNhJPYPR/0LUSrLGkLA9OlnVHuDZoF8eyrcLtxGnVkmWLrxClFVvS5iP/zHPZq0hj25pV0wQe7ZSd8KoKy7wCWDA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(366004)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(2906002)(478600001)(7416002)(5660300002)(83380400001)(921011)(38350700005)(4326008)(36756003)(66946007)(8936002)(8676002)(54906003)(316002)(66476007)(86362001)(6506007)(6486002)(52116002)(6512007)(6666004)(41300700001)(26005)(2616005)(66556008)(38100700002)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1BySnJkZ2crSy9aakQ0L05ubGVqbmU1akFFSzh5QUExMmdjSDF1azVhR2Uz?=
 =?utf-8?B?Q29kTlUrYlhWYzVhWTRPck85Mi9NdDZhQ3lXVmR0UDdTQlgxWGtCMDFtMVd3?=
 =?utf-8?B?ZU04UDdac2JoZTFWSWFxdVRIYThtYUI0dFRJRUlqd1Jxd1J1RzluMGdpZ0pK?=
 =?utf-8?B?dCtTNkVJT3dYOXU0Q3lJNC8xUUMwSXRQcWVLaitZa2cxaDFtQVpsVlVxcHZw?=
 =?utf-8?B?L3NJZzdiSW9QYXkxczNOZzM3QjIrdjNSR3YrTVA5L3p2ZmdhTlE3cVFhcW1i?=
 =?utf-8?B?Q1BsOEVHZ1oxSzdjdEVtRVlPd2ZMZlRwQkZnRTlyaWwrbjVmZ0lITTVGOHBj?=
 =?utf-8?B?amQvaCt2dVNlNXByVFZVNXhPbVJ6cE85dk5pd0JqWlF1QnZPQStESTR6MUc1?=
 =?utf-8?B?MS9iNmZaaVBPdEJoZEN2b1hsdGdIRnFUM2Y4YXlqTGNsYllGSVNrVWMwS0lL?=
 =?utf-8?B?cnZOclZLc1BlaWw2bndNbmtER08zRzgrOXk3QUtlOVRJNVJyNzdWZE5LK2Yz?=
 =?utf-8?B?MjdnTldtWWFXRE9PM3JjK2x5VEV6bzBXaW50QTY0bERZYVpxSWx6c2FRWFhs?=
 =?utf-8?B?ZVFoOHp5cWxGYndqTTZEeVpSUU5KNVN1Ujd4K2ZKbEpFbVd2VUQ3aXBQOC9X?=
 =?utf-8?B?T0tVRWROQTRkZkxiQmlBT09sQmVlRTBkd1ZDMGRRNVd5NnJrS1UwdGhCSk1O?=
 =?utf-8?B?N0dSNVlscXlrS1hZWHRxVURqWVhPOVRMbVlYWlFoWGk2ODFMOU9Lb1ptTXQr?=
 =?utf-8?B?eW94aVlhWmxQYisyZHdpODRTRW0vbVVuVFBQNWE0NkpQMUwyWk5Sc1d1NnZ4?=
 =?utf-8?B?UjZUTTNYNjZxN2tsY2U2M0lrK05BQUN6ZUhjRSs2VHNOVGdXTjhqN3QyeFRh?=
 =?utf-8?B?TXF5d1FtYzhEMDR4WGg2bW10RStTWnc2YmlkblhZa0U1ZFJuKzkxM2Q0WVhr?=
 =?utf-8?B?bVJkWFlrYzgvUldoSnhSTzVQV3kweTkwVjB0Q1hoVmxGenZNTkxDMU9rTlo1?=
 =?utf-8?B?bkZqOUhuOWRVNCtmVHdtTlpmbGpiaUViSkg3am9JSmUxTnBwZWJlTndWVEhP?=
 =?utf-8?B?TlNPZENFc045RGpzcjR5NjlLY1lPa1J2aDc1MnBhdTlRWm8yUi9tOVFzMUQy?=
 =?utf-8?B?OWtmczdDREI2cGtFWTBYaVdmakNSMENndGRBbU80WURLSXg0Mkd6cTNmYlJ6?=
 =?utf-8?B?ZUplLzBBLzg1ZFRUeW5JK1FBWGJITVBUMjREM3R2d1BlaTRWWlU5WGo3VERD?=
 =?utf-8?B?L3l3NE9Wbk9WSUtzWXdxaDFrRFNnR0dwWWVHaFdaMmkrbmF6QjlsckUwL0xB?=
 =?utf-8?B?LzI1ZjE2Z3hPeEFHeFRSWWg4YWdxbzF3ZGI0K2ZMRHhWcTN6NmMwc0tER3Nn?=
 =?utf-8?B?V0VDMi9PVXJzU1JFQjIxcXlxdU9iL1FRL3dydjVDejRyNlpEZkYvbDhZM0N0?=
 =?utf-8?B?VDkvVFFwN2paMDZTZms0MnBXQks1UFYxSXBuaGNLME01YnJVVXFHeWdRSGlu?=
 =?utf-8?B?L0pqZzNZOWllcmt6SGNyRFZnMWdnazVMRUtxVEJmcUZiNGRxSm5ZRytmZC96?=
 =?utf-8?B?eXdNVWZNeWVWVTVCeTc1K1l3MU9ObVdwQXlKNGkzOWdaT1EyZjRrL1ZXR1Zy?=
 =?utf-8?B?TFFhYnUreUY5V3NuTFliYWdnU0hacGFBQjA1bXBSWW43dm85WmsxNUNac1Rl?=
 =?utf-8?B?UFUwbC9NWXR5UW5uYkJkMjFvNEJtUUtJMWExNlIxVWIwWHNTeFdiOGZWY0JK?=
 =?utf-8?B?bzUxN05XUy9UUWNqU0cra1VtZ3RBeXNyaHhGTWM3SGQrenY4K1AyemJsSHdB?=
 =?utf-8?B?QzlZK3VEREtOTkQ3MHVoMXlEOXNQN2MxSWprWmhGVm1uZmxOOHpsN3BQVzEy?=
 =?utf-8?B?cFVuZFlCTXRnZnJkbmNsUU11Q1crRUJrbWs3VGtYT3dudk1Lekg0cktFdElt?=
 =?utf-8?B?NmNNUjNZL3BONWRUUXhia0svR25aYzl6VXVDTWZvUzdXL2tPUGVuT2V5SjFl?=
 =?utf-8?B?RldmcUpiTmJMa0tQQWZEY3BoMm9TQnRQVTA1ZkF2Q2ROY1FZNmFtM3NHNHlT?=
 =?utf-8?B?U2Z5VVVGZjEzZWlHV2hlaSs5c1FadElKYzdCeWo0NUNkTDYvT1ZIcm5haGlB?=
 =?utf-8?Q?KAONvc65CVhZRneG5I3q6s8qD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d2a9e28-091d-423d-ec52-08dc24014917
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 15:11:52.0459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sHscLF5276+jfbi0HjqrDTLSw8kpD1NDKQjMNdVuDMjczoNDPVSyh+rclyUoNh2lAJwB2pPRijRVAXO3s1iXsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8425

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Add "code" and "routing" into struct dw_pcie_ob_atu_cfg for triggering
INTx IRQs by iATU in the PCIe endpoint mode in near the future.
PCIE_ATU_INHIBIT_PAYLOAD is set to issue TLP type of Msg instead of
MsgD. So, this implementation supports the data-less messages only
for now.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 9 +++++++--
 drivers/pci/controller/dwc/pcie-designware.h | 4 ++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index df2575ec5f44c..ba909fade9db1 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -499,7 +499,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_TARGET,
 			      upper_32_bits(atu->pci_addr));
 
-	val = atu->type | PCIE_ATU_FUNC_NUM(atu->func_no);
+	val = atu->type | atu->routing | PCIE_ATU_FUNC_NUM(atu->func_no);
 	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
 	    dw_pcie_ver_is_ge(pci, 460A))
 		val |= PCIE_ATU_INCREASE_REGION_SIZE;
@@ -507,7 +507,12 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 		val = dw_pcie_enable_ecrc(val);
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
 
-	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
+	val = PCIE_ATU_ENABLE;
+	if (atu->type == PCIE_ATU_TYPE_MSG) {
+		/* The data-less messages only for now */
+		val |= PCIE_ATU_INHIBIT_PAYLOAD | atu->code;
+	}
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, val);
 
 	/*
 	 * Make sure ATU enable takes effect before any subsequent config
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index d21db82e586d5..703b50bc5e0f1 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -148,11 +148,13 @@
 #define PCIE_ATU_TYPE_IO		0x2
 #define PCIE_ATU_TYPE_CFG0		0x4
 #define PCIE_ATU_TYPE_CFG1		0x5
+#define PCIE_ATU_TYPE_MSG		0x10
 #define PCIE_ATU_TD			BIT(8)
 #define PCIE_ATU_FUNC_NUM(pf)           ((pf) << 20)
 #define PCIE_ATU_REGION_CTRL2		0x004
 #define PCIE_ATU_ENABLE			BIT(31)
 #define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
+#define PCIE_ATU_INHIBIT_PAYLOAD	BIT(22)
 #define PCIE_ATU_FUNC_NUM_MATCH_EN      BIT(19)
 #define PCIE_ATU_LOWER_BASE		0x008
 #define PCIE_ATU_UPPER_BASE		0x00C
@@ -303,6 +305,8 @@ struct dw_pcie_ob_atu_cfg {
 	int index;
 	int type;
 	u8 func_no;
+	u8 code;
+	u8 routing;
 	u64 cpu_addr;
 	u64 pci_addr;
 	u64 size;

-- 
2.34.1


