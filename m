Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706ED306DC3
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jan 2021 07:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhA1Goo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jan 2021 01:44:44 -0500
Received: from mail-bn7nam10on2084.outbound.protection.outlook.com ([40.107.92.84]:48128
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229695AbhA1Gom (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Jan 2021 01:44:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMGVotE/ZeuEidn4ISeYklAUETxQve56EN4R7X1ReKOCQ6vr4DcVNqe4aM6tY/1PGno8e/UTJN34EEUKjmz03dUffiQws5N3c5lfpIU8I+TdqySeYa6ZUdvwx+uRKZ16e6acDL84DJM2WTiwpapHUb5UhSSLjfmDC/vaixwTDT1t28v3SgAxaddNxy0WAUSLixSDNTs438eiQogMegeL71YLUap/PMK3ZZN0edCIsyO7jZ0XejJRSWgO5nk1IPl//W/BL0BAzZkz3jkfB4J65m6+69MvVK6o5mhIJP7y2dC0fs/g9V7goq2u37dEPQFXO54V8+pjDJ3RSOn1KFTh0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mRWt49XrvKC+NrXb8p/Ml+ljr3WKVq2TV+tNNociaw=;
 b=MkHCoTdBGZocZvq02K39uZDKlyDJMWyXG5V+ZsfCJ11hwS6MyLfUcZY2u/u45V2N7sFmXVNYNKE66QsLr+dmEpCMwUGWWQxaZrulRuZ9ThbbN9levD0p+h6wBWl1Oy6p/V9i9oTBm/XcZMFQX0jzckOhjuBjzEu4jrBga2PpT+8TWw0mDKaf6P9XFtMwhHpho0IW0lcAAnkWC9w9C6TlnXDfDKbX9xI3F7MWDiPtSNLDmMa5dP1qtMByiX59y1DJkyc1Zs+98Fj3Z23yLZYmJL5aEqj0tWw6QcNdnQEQIlLXRehx47/llYA07nlDR/NkDmgIYGOVNz06Dlqkf5FSoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mRWt49XrvKC+NrXb8p/Ml+ljr3WKVq2TV+tNNociaw=;
 b=UamFy1EEW4dTLNPp2oQGcHb08LCf4ErG6rIDWXask6Y8/cEnh3hstBoPJrxgv7vZg3VkpS0aer85IsKSd/eKhMObKVSqea5PFANjG6TN//2YK5CSL2Gd+uZ9PE9CDiq6Y0sj6hYpkWsjKKFXB6lkAl7ZUiCET+M+eHyahtHN8N0=
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN8PR03MB4724.namprd03.prod.outlook.com (2603:10b6:408:96::21)
 by BN6PR03MB2563.namprd03.prod.outlook.com (2603:10b6:404:5a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Thu, 28 Jan
 2021 06:43:47 +0000
Received: from BN8PR03MB4724.namprd03.prod.outlook.com
 ([fe80::f80a:407e:46ca:e6ce]) by BN8PR03MB4724.namprd03.prod.outlook.com
 ([fe80::f80a:407e:46ca:e6ce%5]) with mapi id 15.20.3784.017; Thu, 28 Jan 2021
 06:43:47 +0000
Date:   Thu, 28 Jan 2021 14:42:58 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jonathan Chocron <jonnyc@amazon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] PCI: dwc: Don't assume the ops in dw_pcie always
 exists
Message-ID: <20210128144258.10329aa4@xhacker.debian>
In-Reply-To: <20210128144208.343052f7@xhacker.debian>
References: <20210128144208.343052f7@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BYAPR08CA0033.namprd08.prod.outlook.com
 (2603:10b6:a03:100::46) To BN8PR03MB4724.namprd03.prod.outlook.com
 (2603:10b6:408:96::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BYAPR08CA0033.namprd08.prod.outlook.com (2603:10b6:a03:100::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend Transport; Thu, 28 Jan 2021 06:43:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5607dc1-0111-4ead-b47c-08d8c358104c
X-MS-TrafficTypeDiagnostic: BN6PR03MB2563:
X-Microsoft-Antispam-PRVS: <BN6PR03MB256386428A3BB0ABE7E66642EDBA9@BN6PR03MB2563.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: StNDHVzPjFZbtvlAi46CKxuJtDiSStinGAEpJkGiHOHhnsWvl3IlHh/0Zw2QwYaCf4RLHfpmz8CQo//ba1hyKyBDKWCkIyR13vO3KQKnHtJwR8m51hSM3NjmcR6n2k0d/wouwY3la6F7JjtEGshWqlQrS3O8mZPUMsNXxjxgWL0Zq7i8rW9jXn8KRfPOM6dO9BHJ3SrUbARbuTEHEAjS48O1ml3gAQE7qP5erTY518PQOb4WuNc+OIecMKEjJaulKAMGdaDGTceKE/CwS5ZgcvPxfmXRvas1L9O0341uRx7lxf7c2F2ReIgPLdxIzb+785bT57ZZksTacQMZUkOjcjw3f5yN/ZvHc57pH8cdcHButCxJz8C0MhlEVnjqR8jwnQrziM051w64jC7EOboteKDYlCoJbii3L6LzP1/Odb4L99twX4JgWesFcTxVBOrRE9TN/6G/I4RNhuTT0NRPcGGqlJxVAZXBe3wRjNkeaCc8vn+b6KWG1zDatlJIXd27n2q0f9qkeHqFUwA8F6K/dQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR03MB4724.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(39860400002)(346002)(376002)(1076003)(6506007)(86362001)(2906002)(8676002)(16526019)(186003)(6666004)(26005)(478600001)(52116002)(83380400001)(66946007)(7696005)(4326008)(9686003)(66556008)(55016002)(8936002)(956004)(110136005)(316002)(66476007)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/alKIPS0IA6w/XVhTil4FM4vF2QpvcUnKfbJVzpSzpRPGnL2DHkSvZrIkIjy?=
 =?us-ascii?Q?wtxNPYFx6JCXGIeYJJCxUFXfDYw5QV+wJhPtEgFKodxx+0+HYu3Yhct6bU54?=
 =?us-ascii?Q?oSbMsEdok7OkAyUKTFOQFgz80HlWN077cD3hxq1ifqOS+auckNPPSNPJpyi8?=
 =?us-ascii?Q?uwMIUfpjIVHMF7uEkXdXkb/OAqDUj5hMVYwKI3SZiJKQPRQQ2LHxVzy6/D7y?=
 =?us-ascii?Q?9t30cgGFEOeusmyhPjBaBC6tSJ7ANV2pJ3gQTeYRB+pQihP6Tb9o3EZWu9XX?=
 =?us-ascii?Q?XzWQ/j6dkmeoBGMymjl3Q/KHq7wgDDamKXvjsC2prZtw2qNfS/Lq+9r78r3U?=
 =?us-ascii?Q?S3nKgqAirMjGgGcUCSAkRyfFIiV6SlvAZDranGeszUSRuOfCey8CwxZcBcPR?=
 =?us-ascii?Q?0nefifb6g2opUoRYZzXtYcQbLegx8d76KBnPmOwHp37mNyAG/zZ9Zh426uOj?=
 =?us-ascii?Q?5252wTCbYNZ7PSuvDpIwyMyMy1GP/gZ39yeT+qxGIhEYdowsYACBoslDd6Ys?=
 =?us-ascii?Q?2WSUFvTxZE2a1ZlJqw/miKc+uamRkUqxyR5mML7wiiXzJjwcmF3LlZyVeG84?=
 =?us-ascii?Q?lH58YvbI6Waz0mSMxHdLBR5Q30Fm+Ij2jB2Nb4SZqzpUIxsKhmg5wIQ/v0W6?=
 =?us-ascii?Q?R055iTMNiE1qbGy29Rex5onmb4gB4/AHu7ptp1g0dHADkfrMLOB4U1aMA8Bq?=
 =?us-ascii?Q?fujs2+0NrdRPYyTXcNsy+6uizFhnp8cq7j9L7Ga7BbT558KbiNpaNglhwwtg?=
 =?us-ascii?Q?YszjShqZeeWYyt1J6lifpBbQQi62GkpfqIRCa718481v7neC2mqO83ftRY3V?=
 =?us-ascii?Q?egx6X89zkz8Aojsn92FkYPq9VTzkttsHkYhfS6V2lSixnxdVCmrJ5ejjwmmU?=
 =?us-ascii?Q?9l4CGH3CxSg6PSedfJMqmXgfxHHVgLghgta0nh0ZiN56dnareJhJc0qCahiv?=
 =?us-ascii?Q?86mkXO0DW7jhKRKfKW2nmIA/aYOHdPTOAAfGeE4Z8Z0jVt8SgjRMw4ZTn2LX?=
 =?us-ascii?Q?jxBIDmqDnkmns4qOhTNvDnuCJVp3JFL4ftQMszwsO4GPqCTB/FiMqpZtJzW8?=
 =?us-ascii?Q?U5j3FpQu?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5607dc1-0111-4ead-b47c-08d8c358104c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR03MB4724.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2021 06:43:47.3734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vr6AweDaJ8Zf6VtOXzWY/ygVaHKCsy53PMoIfIcVo8wN5A7Ob8oWosQe3pz3mgPxPfo51fuYcEmjq+IFEg8khQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2563
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some designware based device driver especially host only driver may
work well with the default read_dbi/write_dbi/link_up implementation
in pcie-designware.c, thus remove the assumption to simplify those
drivers.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c   |  8 +++-----
 drivers/pci/controller/dwc/pcie-designware-host.c |  2 +-
 drivers/pci/controller/dwc/pcie-designware.c      | 14 +++++++-------
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index bcd1cd9ba8c8..1c25d8337151 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -434,10 +434,8 @@ static void dw_pcie_ep_stop(struct pci_epc *epc)
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
-	if (!pci->ops->stop_link)
-		return;
-
-	pci->ops->stop_link(pci);
+	if (pci->ops && pci->ops->stop_link)
+		pci->ops->stop_link(pci);
 }
 
 static int dw_pcie_ep_start(struct pci_epc *epc)
@@ -445,7 +443,7 @@ static int dw_pcie_ep_start(struct pci_epc *epc)
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
-	if (!pci->ops->start_link)
+	if (!pci->ops || !pci->ops->start_link)
 		return -EINVAL;
 
 	return pci->ops->start_link(pci);
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index bcb5bd7ec5ef..0f0d8f477596 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -404,7 +404,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	dw_pcie_setup_rc(pp);
 	dw_pcie_msi_init(pp);
 
-	if (!dw_pcie_link_up(pci) && pci->ops->start_link) {
+	if (!dw_pcie_link_up(pci) && pci->ops && pci->ops->start_link) {
 		ret = pci->ops->start_link(pci);
 		if (ret)
 			goto err_free_msi;
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 5b72a5448d2e..ea1c07146442 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -141,7 +141,7 @@ u32 dw_pcie_read_dbi(struct dw_pcie *pci, u32 reg, size_t size)
 	int ret;
 	u32 val;
 
-	if (pci->ops->read_dbi)
+	if (pci->ops && pci->ops->read_dbi)
 		return pci->ops->read_dbi(pci, pci->dbi_base, reg, size);
 
 	ret = dw_pcie_read(pci->dbi_base + reg, size, &val);
@@ -156,7 +156,7 @@ void dw_pcie_write_dbi(struct dw_pcie *pci, u32 reg, size_t size, u32 val)
 {
 	int ret;
 
-	if (pci->ops->write_dbi) {
+	if (pci->ops && pci->ops->write_dbi) {
 		pci->ops->write_dbi(pci, pci->dbi_base, reg, size, val);
 		return;
 	}
@@ -171,7 +171,7 @@ void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val)
 {
 	int ret;
 
-	if (pci->ops->write_dbi2) {
+	if (pci->ops && pci->ops->write_dbi2) {
 		pci->ops->write_dbi2(pci, pci->dbi_base2, reg, size, val);
 		return;
 	}
@@ -186,7 +186,7 @@ static u32 dw_pcie_readl_atu(struct dw_pcie *pci, u32 reg)
 	int ret;
 	u32 val;
 
-	if (pci->ops->read_dbi)
+	if (pci->ops && pci->ops->read_dbi)
 		return pci->ops->read_dbi(pci, pci->atu_base, reg, 4);
 
 	ret = dw_pcie_read(pci->atu_base + reg, 4, &val);
@@ -200,7 +200,7 @@ static void dw_pcie_writel_atu(struct dw_pcie *pci, u32 reg, u32 val)
 {
 	int ret;
 
-	if (pci->ops->write_dbi) {
+	if (pci->ops && pci->ops->write_dbi) {
 		pci->ops->write_dbi(pci, pci->atu_base, reg, 4, val);
 		return;
 	}
@@ -315,7 +315,7 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
 {
 	u32 retries, val;
 
-	if (pci->ops->cpu_addr_fixup)
+	if (pci->ops && pci->ops->cpu_addr_fixup)
 		cpu_addr = pci->ops->cpu_addr_fixup(pci, cpu_addr);
 
 	if (pci->iatu_unroll_enabled) {
@@ -525,7 +525,7 @@ int dw_pcie_link_up(struct dw_pcie *pci)
 {
 	u32 val;
 
-	if (pci->ops->link_up)
+	if (pci->ops && pci->ops->link_up)
 		return pci->ops->link_up(pci);
 
 	val = readl(pci->dbi_base + PCIE_PORT_DEBUG1);
-- 
2.30.0

