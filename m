Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB7A2BA7B2
	for <lists+linux-pci@lfdr.de>; Fri, 20 Nov 2020 11:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgKTKqg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Nov 2020 05:46:36 -0500
Received: from mail-eopbgr760049.outbound.protection.outlook.com ([40.107.76.49]:31481
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725956AbgKTKqf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Nov 2020 05:46:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZ1bgOIHw2EYEjVxvFd9yYqGm1IG+YGr/KNlrVXnf6sTezBN8lmE9Q3Vkcp33OzmGahbFr3nAe1z2T/YS7sQJpK1ONigNV1smNstfIoqowAepSJeAXPnvFk/m2EjFrO9lnnil3hnZIyB9i4L+wKORiEMOAvHVtThDvGhCHAGsqhs4P1bY8MlVmvPKCj3AMFM5yOuw6sF5c++ZLyq4iMWhbApbO7EX2LbJrM1q0Epj97EFHDmhU0uF686/NcrOqkbJbEn4p9NG8uz18BS8nrChvOtWND2SJoCmv+nq/3kIeQu940rl02P2/NdKVdWvOlFJIefnusdAtmDnCDlDf/PVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wp3YTj75XKkr4Z0IpV5v9qGarAHxy8wSU7FFj0rxzxk=;
 b=gkTZd1h6zVIMGnct9Cyd82lBcjRNfPuMgAwWz3ke3vOUocZZ595tdWJfTb+yxI4wcdqYkJTyl8tdFkE/yFbKTHdYxyM+NFwPXcF5H/TzVN8i5W/58C2CXeP5Es1jjsh+soNdgE5JvqW0Ai5RaDcYtYD35nHMXcGbZwSkyGDMpUCID6Ujwur+ZxZukuHWYGfGJK9aD41PyPkU0SlrdKuBA9eYn7yBEoN5I13yf5Yj0E3Bf9U3D/wkOfqmJjST+TLj6Cv8FLfVPdoQ6d/DDiqTdwbYHsnG9QiZu6UcHkQzvWZ2DKmxtJjmtnwivStga+InAOOil3lU4UQaZa4E4bWcAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wp3YTj75XKkr4Z0IpV5v9qGarAHxy8wSU7FFj0rxzxk=;
 b=Ng6Fx5W8/ttTW1q1B+G1Y2WVp7ETO/ldxVoNw87Z8ZcKw32qpg/8ElWXdUP2n1SFWtI94yRfcgXTTHDR1856cyz5PwBFch1Asa7VwewVAOYB9Wk/nYMLSpeLO/TF6YsYP1uFv+o1SV+++3bQnGypwchHvYzvBwg28Vynh39Eyic=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from SN2PR03MB2383.namprd03.prod.outlook.com (2603:10b6:804:d::23)
 by SA2PR03MB5723.namprd03.prod.outlook.com (2603:10b6:806:118::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Fri, 20 Nov
 2020 10:46:33 +0000
Received: from SN2PR03MB2383.namprd03.prod.outlook.com
 ([fe80::412b:8366:f594:a39]) by SN2PR03MB2383.namprd03.prod.outlook.com
 ([fe80::412b:8366:f594:a39%9]) with mapi id 15.20.3589.022; Fri, 20 Nov 2020
 10:46:33 +0000
Date:   Fri, 20 Nov 2020 18:46:24 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH dwc-next] PCI: dwc: Fix MSI not work after resume
Message-ID: <20201120184624.471c38f5@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BYAPR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::29) To SN2PR03MB2383.namprd03.prod.outlook.com
 (2603:10b6:804:d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BYAPR07CA0016.namprd07.prod.outlook.com (2603:10b6:a02:bc::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 10:46:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 044729d0-323b-4edf-7f0e-08d88d418bcd
X-MS-TrafficTypeDiagnostic: SA2PR03MB5723:
X-Microsoft-Antispam-PRVS: <SA2PR03MB57237B858DBAC10461E3D33FEDFF0@SA2PR03MB5723.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XUhMxOXjQMCC6zzKnO3KMmZujYkS8jk89PS+RBM5/HEjNkm3CgP/mUNgr13t4EAbtMlWWEV2HIOqmzVwvGawGkh/tntxtNmiYeWG3Rg34d3cdqX/bu9Cb4n5rQJAkE/BoE5zxFcuLUZez7pCSCG42p1CXLbMrWer6eb+MH6/XW3EKOdkrH4k1LBdWI5W0hfTagql0J5/G8ODB5U2bOkCJSErRd+kGjfQnDeM1o9bmu3a7d1P8xa9+TYkNctBEjGVUAub/cXr9PlBv1kRy7u0z61RQe1JAS06ekidj2RSsASgnxuw2jdVPuUSdN7BW80q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN2PR03MB2383.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(1076003)(6666004)(5660300002)(2906002)(16526019)(55016002)(9686003)(6506007)(26005)(956004)(83380400001)(4326008)(110136005)(478600001)(66476007)(66556008)(66946007)(86362001)(186003)(52116002)(8676002)(7696005)(8936002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: fAX6d4IPONRJ1H8lVIkW7wK/j/T7rL61LrIQRTdqN2Td9mg6k3mJbEN34al0ApE6i6a1j6yYh2Ar+/16NI5SykhJno+QltnJAOG/4T82m/IAfavPvgkctlB/4ppfeWqLyxCG50iMaU2Q/4Mp8OaLH17m4ScEB8FD6Cy9suhLoGJCJ8ftuCnMW2mUGy+qixOw1KVtJ6t4lb/i0+f/2fFIAAqY3cJKzdtOCO/hFIltIzr9qTyy9ce8Z7VtqReuai/AdBXE5OT3QApZQPUaXNaXjHtyHaINfJcrgTtoDXPHn7QXzvxg7NRGLIlCGykXC1p+mLJqtQe73pVNSnPm6pFTmi3A1WZMsClckjUyu38Q2gbaC9taZxgszu1E6jS8pS1hurUJz5kl/YfH2svCoci+OwkwprnjWWMnbmz/v3DbIrAl+j7iMtqGj9hEP/zAuZ/tylEmMurhLMzPZTxS1lrWuKApzMrEQ02U24IeCxGFwHQAGM72sEc9SNTfXw4Vw14UrEL3zZBmf/SY5GusB4UY9fSB9KpUfa2peHxZankBcHS/Ro6Ah+MaR/haWkCF5NoOXRO+gav6VElolmNVY1F4F4Q5Et8cjP3KGsTLVYb1Zt2DBEbIcwuYWchB9cViwlcpPTX2jZZU0BjLE88RSITHNA==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 044729d0-323b-4edf-7f0e-08d88d418bcd
X-MS-Exchange-CrossTenant-AuthSource: SN2PR03MB2383.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 10:46:33.1965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T2x7sY46kWOEsaSzVrk7nqrpnhuVVXY79aXm54qMXb3cbk8MUguljZgL3TEn/4rduPbf4NgmSwQxaQgoNE2nsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5723
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

After we move dw_pcie_msi_init() into core -- dw_pcie_host_init(), the
MSI stops working after resume. Because dw_pcie_host_init() is only
called once during probe. To fix this issue, we move dw_pcie_msi_init()
to dw_pcie_setup_rc().

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 99ef808a40a9..e1db9056df0b 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -419,7 +419,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	}
 
 	dw_pcie_setup_rc(pp);
-	dw_pcie_msi_init(pp);
 
 	if (!dw_pcie_link_up(pci) && pci->ops->start_link) {
 		ret = pci->ops->start_link(pci);
@@ -570,6 +569,8 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 		}
 	}
 
+	dw_pcie_msi_init(pp);
+
 	/* Setup RC BARs */
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0x00000004);
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_1, 0x00000000);
-- 
2.29.2

