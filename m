Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC8F288413
	for <lists+linux-pci@lfdr.de>; Fri,  9 Oct 2020 09:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732392AbgJIH5t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Oct 2020 03:57:49 -0400
Received: from mail-bn8nam11on2046.outbound.protection.outlook.com ([40.107.236.46]:61874
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732086AbgJIH5t (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Oct 2020 03:57:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HeAg3YXhmG1OWPcc4gl3CsBuJGG0+0YCK9bCG+r2DSgJ1RReSrChkG++AcTv/PVmfWQ+vlG7pNwNFkorwCXysUTqyAVMzcN45acTnn0aJs1IZ0PzQtqZEDlZtIlvZToWXJGCrhAut5ZvfAgIB/9ylrkc7vCD7Ycf+NyNuXdYfX5vJMTpOZhBBQYTe5BMrVrfJLHJC6Lvga5QYkeNA1wJyZmx3Pb9OyUlxbGXkKiFg4jFDRcqYwXrGELgXw3fwU/EL6gdA5uYb21IRACl/gqBAi+QpUC/AIvSHtCVBaDkwwzzk6Fq8JUSeixFcevuvzqdaMnL+dzoGv8e9lG6TCKJkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMv2KCGB5LuSyCYNjvXkxUsl/D6L8sSQYG6wyWbXloI=;
 b=jWTwYILdfDMBCy5z1sl55Pd4OXbbpt3orVSOZ2k5WEVltfRThFjruxfu2BkL+fSivtSnaQHYdPWSyL9NOf3Fp0VG7zA+JAiTu4O4Kex59Ik2d3nDqsy+t06ltTw4P1HEpHfAhCDnLVNRtVLz0SuUk+DKk7iQmrfD7KHeoiPwcw4sMqF7ip8J31ItbhgzAN2q6uCYk+WawGmGztjLyT5/0jXGRN/z6M6ISHZLQKEbC9cTV58LUCSjOtfkkTM2F64KCH28KXLMZUW2YAytcAwYTQAorz8MTuB1i3KjUk3q59wc0w+4B9DQvrprVeXHOXAv16soQKN9nkKV/tbjQkM4Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMv2KCGB5LuSyCYNjvXkxUsl/D6L8sSQYG6wyWbXloI=;
 b=WEW1XpMrunXNHzfqtT6Wno000KtSkq0uBuWBwonTTHZiAP6kfBG+gGoXyOyIQsMENHFcxh+BjV7HkomDFZ7aIUFpUX0O/YKKpiuBdowKdojeIf+bZnLzTWOzhTNw6UfLA8NODX7dGqXYD6oH+2Fl/cYboTDFVxLPMKM+fLoCxz4=
Authentication-Results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DM5PR03MB2683.namprd03.prod.outlook.com (2603:10b6:3:47::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Fri, 9 Oct
 2020 07:57:46 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3433.046; Fri, 9 Oct 2020
 07:57:46 +0000
Date:   Fri, 9 Oct 2020 15:54:36 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/2] PCI: dwc: Skip PCIE_MSI_INTR0* programming if MSI is
 disabled
Message-ID: <20201009155436.27e67238@xhacker.debian>
In-Reply-To: <20201009155311.22d3caa5@xhacker.debian>
References: <20201009155311.22d3caa5@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY1PR01CA0164.jpnprd01.prod.outlook.com (2603:1096:402::16)
 To DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TY1PR01CA0164.jpnprd01.prod.outlook.com (2603:1096:402::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22 via Frontend Transport; Fri, 9 Oct 2020 07:57:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 467779a3-5b45-4920-ccac-08d86c290221
X-MS-TrafficTypeDiagnostic: DM5PR03MB2683:
X-Microsoft-Antispam-PRVS: <DM5PR03MB268316E7B77C19741516C8DDED080@DM5PR03MB2683.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fs+fYZPXjxBDidMU9xY3tQIRkO5ghj62mxW1KpbdrfMEwKcwDhrxjz9evRx7p4/wW0FzzinMaC+MZQZ8TJqdxI0v6UvjKIIRP3hWO0bSEQhJhbTVqGImN5KaVBj+0YWOWkbevm7me7wIqwIMKCkITEJw8q2ROd2a6N0Wc3GGow7p/hfNe6SGYcLTv8QkOdvuP1rK2JJXe7FaXao4K5Ki0EnALzHJ9FJ1oABtUVHGcRoUk42kDXKu5XpZlEPQyUYXv5z8GVvQXLMomz5KsZxwS7rb0siL6ren9aNJaxbeDkigNzLY4rCFFeKhitfjg/B9PlmEbxtQyNGrtEikQKez0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(346002)(136003)(39850400004)(5660300002)(6666004)(956004)(8676002)(66946007)(7416002)(86362001)(83380400001)(4326008)(55016002)(8936002)(110136005)(2906002)(16526019)(316002)(4744005)(186003)(6506007)(66556008)(478600001)(1076003)(52116002)(9686003)(66476007)(26005)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: bRQHwFHJUGhttaeB4rfEczk5H18okEpBE6gSHZ/8Xhg/t8Lyr4/oYZAL1AV30y46WkAKhChJYolwk9JTsKwHM6WEGzbUT2BIRkg/XKTRIK05Ju+ip4ejEV/FKTpkaywG6gRDpt8gzGOXNNmoFqK6awPbBpeS/DZUFX4hwqUnSUETrur4H+Pmp/3M8EA3xwawXTFEqt9TbN48ORjr5ikaNEwAdWLaZx1lKWpz6vO1U4sh4cvnPNvBnEQEAEUp5N+gDkTt/ScEDKTi0JkO85HFgROTxc3rY59IrVXeVoeilwMFSYUVeEQhnni6W1Ddq1orzWwUvG0tIcHjINM34QoT0FCikgeAFu7lASmiRcV+8wrRV1TIXgUgxN+4+zcoDCh+sdiWu4lZcVSZyEW48rGi4w1K/xeXq+kUBZ38bj9Qc5yQQtlK7zvMLpqG8ML8vGaWq0dWy1KX/LdEOjRnZvl17+uoyqgr6OyyWvAq3SGhlDQrqqGsw570wRoC6wpqopxSYO+L3Hk87j4kjhZ16uIp9/CqVXklvHV8bNS9mSt0eM57dLI8AjULykSpsiUWKd8+YJdFHq+Tslp79zwGstpLMYJ216upXkrrQ1WZrbaBYdhE8S01GAX9r5Kai6/vXGAofx+p2p9CFCvj+3+93x7ROw==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 467779a3-5b45-4920-ccac-08d86c290221
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2020 07:57:46.5169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nsW3jdtPzXFq40JiWNcgK1DxIOcGleTwFnyUlzwytYeo9Q03rhTrZmwnqz5C9JNryJ6RyrpKYsZLz2PpKRA/3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2683
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If MSI is disabled, there's no need to program PCIE_MSI_INTR0_MASK
and PCIE_MSI_INTR0_ENABLE registers.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 317ff512f8df..d3e9ea11ce9e 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -528,7 +528,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 
 	dw_pcie_setup(pci);
 
-	if (!pp->ops->msi_host_init) {
+	if (pci_msi_enabled() && !pp->ops->msi_host_init) {
 		num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
 
 		/* Initialize IRQ Status array */
-- 
2.28.0

