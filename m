Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182582E6DA8
	for <lists+linux-pci@lfdr.de>; Tue, 29 Dec 2020 04:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgL2Dgy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Dec 2020 22:36:54 -0500
Received: from mail-bn7nam10on2087.outbound.protection.outlook.com ([40.107.92.87]:63329
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726659AbgL2Dgy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Dec 2020 22:36:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKLAzV1OsM4RWUGC2QmqilEHxijUY9DM9iEsb/W9I5do7w6IjyZnSe0Qnhlo0zk4WRubz2OYE8L/ljcwAwN5t68NRyFGfUA5rVYm0x9iVim13efQKT/f0Rqh7Q3cks4FdLHSWCaS4wK5d72k5+37G/zkRlrfKmgJgxd0Cen0oQGDYWxYkKdlBzQHFswgcH3amuTP+2MW4eH41l9o8Smj3lxe+ApwOTkW7z6OXeNt4jJ+Umtj2X8REdC89INMS5nFLwp2h286FUi5TaRuGqZmUZjJkzDIn3JtKpjbbeGx8Svx9oqJJn7yg6rhKwkV4yg/yvopZTFmeYu7+LP1OEJxzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HoKMmvmbwFPdVl/LaHseApPwy06yaJuinAdbNdoYssU=;
 b=CgefxWbkPc97eQbrHe75rHW6UVbalgpx4ZzPNfXRZuNumJCjd8AqWfE2Z/pitl7zOuP6Y4esZtd+/LGODfmLKJo0hnabhtR8RQqG0FJDySE6nLBBJ2cE32sdvwC2T1TX64GW9r1nfifOMlsARQDkcHL6Mb6JLDolNGlUvwcK8UEs1vaiWSnZL1SJ82h5V9c8ryA15ixvt+FRIhc/WjkXQtGol1oz3cBh3OEBxjOFMwmnwq859cZxEclSSKdgrlCv4cafVyFv6Yt8cPk6+NeoDIyXHxui+XEOiUmSLuZKJ556CLBD7mCtQA+NEHehHTu3PWOzBIre3L5jN1hjUo3owA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HoKMmvmbwFPdVl/LaHseApPwy06yaJuinAdbNdoYssU=;
 b=MwGHmMT//5EgbxpIg3dVpooxByZtB1QynFTxQGfUMwVp08sbQkZi9FxYJWS9y0MiYDhgrUzuFsGqQRr1UvzHeSGlPt3rJ7Im7NKgXI3pFc2NSMUNPmudB6Mvxvuum9FoTCfYpfyQHVOr25lwzQAnCxC2OK9yIUS3kMDIWG51Lng=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN8PR03MB4724.namprd03.prod.outlook.com (2603:10b6:408:96::21)
 by BN7PR03MB3940.namprd03.prod.outlook.com (2603:10b6:408:2d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.31; Tue, 29 Dec
 2020 03:36:05 +0000
Received: from BN8PR03MB4724.namprd03.prod.outlook.com
 ([fe80::e192:4c65:5936:1fb4]) by BN8PR03MB4724.namprd03.prod.outlook.com
 ([fe80::e192:4c65:5936:1fb4%5]) with mapi id 15.20.3700.031; Tue, 29 Dec 2020
 03:36:05 +0000
Date:   Tue, 29 Dec 2020 11:35:56 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] PCI: dwc: Fix MSI not work after resume
Message-ID: <20201229113556.5dd4610c@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BYAPR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:40::42) To BN8PR03MB4724.namprd03.prod.outlook.com
 (2603:10b6:408:96::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BYAPR04CA0029.namprd04.prod.outlook.com (2603:10b6:a03:40::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27 via Frontend Transport; Tue, 29 Dec 2020 03:36:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c54e2b8b-8dd4-4c8e-b737-08d8abaadf39
X-MS-TrafficTypeDiagnostic: BN7PR03MB3940:
X-Microsoft-Antispam-PRVS: <BN7PR03MB394065FB844C38037C1D3D59EDD80@BN7PR03MB3940.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +EgrO5xR2pRUKesNYoXpbTUN7KOnr3CQGcEMUaYY1xm3U+SC2Ort0XMxw5QWPn6dmrz7wj1zMbnwFej44fxf8rYKwEyoCVj9kpQkO37iZAlGzjtNuQ2WPouBENKitqHN+yGAcrPfY2NGmNBcLKZwR8dnnUxDKWufgZCbg9obQipHAQqK0O/RS5YKbIhD96dZcH6A56mR2YZH66mN0emMqczMWp71bkgVfJeV2PVNxPmki9xr7CfQnRi5W9Sz2Uhg7GUMmUw6rYmCdFnPUroNvIcQ9cWJpgybCN+/px55zXrCuUOzixcgIem+qkGW/2KFil1xJYYtuFYU5ps9kmU/Mgux1VSA0e9hqFJY/4ldofeDnnHoQ9DK60qdavNz5dW5SKbMFtKRhbu3iif5YQBLtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR03MB4724.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(110136005)(8676002)(956004)(478600001)(316002)(2906002)(52116002)(8936002)(5660300002)(86362001)(26005)(6506007)(7696005)(9686003)(186003)(66476007)(6666004)(66556008)(4326008)(16526019)(83380400001)(55016002)(66946007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GlrbuYQawiUG1i3D+h3ToMvcLmQ5MHOP4czzn28bimbZ/uHqwwInycqSpmc5?=
 =?us-ascii?Q?4ucT7pD9WUEt1Pmy9hMJXeIob7tqwL8VVVkIeMJ4vw1RsfqHzIN+nFsyahrO?=
 =?us-ascii?Q?/9LeHyV1O4Byap28lMWvArJZYcWX9+QFKkLqiKR3xamlaqUh1d9gtt1cBXPA?=
 =?us-ascii?Q?GeYqx8jlZ0xDPPSzyDzFAYbMfWhMAytmF2UjJZ3cePsqhE/wiKfp+wUUm+tU?=
 =?us-ascii?Q?s4wQc3bX7rzkz0Khwcq/IAosmvWEs+I1G3vMBofrMhknJ2Us322kJPhyUmJ2?=
 =?us-ascii?Q?kXEPnVmxTwX7mSPKlKvq8hNsGP+8RoZ6j7UYPurhRzOreMAaC+zCZATGgxxV?=
 =?us-ascii?Q?Wzuk7W2C2QuQMq+TMJtk9ZVRNkqivO4xq1g95vPhplgfEpDnNwRrKRZ50iG5?=
 =?us-ascii?Q?wBBOt017JjyvJoGzCT6IuvB38jnj6pv9v66/qD9f0CwPNAjAuUgRj1EZWK9y?=
 =?us-ascii?Q?8vL6eWYtCk5k622IfcGkaByOdPAk5wJ5WsNR/YkCguNOLn1AZ69YGy+4Vnpl?=
 =?us-ascii?Q?RXTyTUbqhJayYa4wl5sGlDAdXu5J3ugQswooDT4+CMaMe3wX0y2JVh979HXu?=
 =?us-ascii?Q?9js5mami3eLF3sgzwdxLwC1a8xWUvsZP7kr+eR779YVnibCX0TSF5wrCw5IT?=
 =?us-ascii?Q?V8426zGK/8bOee5mSybJzPoNX6+LZHboyjmvlFUmLU1hciTar57XYFMWDIiT?=
 =?us-ascii?Q?Mw+FIkkATmwoAtrgMFA71hIYM4j/vP/i6YGXUYdTN92F6SAvsHS+BOIqo/w6?=
 =?us-ascii?Q?ofz3lKJSd3AgjKo0Y7NQD6M+EYEfkpPs28t5rqlKx8PnQ///zE4nZO9njXnF?=
 =?us-ascii?Q?aEsarznjNOOUToMHUscXVcLoJWnUFwWJkuabzckNnAVe+tLljNeubQMwg3QS?=
 =?us-ascii?Q?Gz2eSjfyyFFWkxpt/kV5sU3Ydm96z+mJtQ2aOKVrKN7lINVeoOgvZVbAjg7x?=
 =?us-ascii?Q?m2SypnJM5/GI7dlW2CCt7A9oUuiQFKd5xlRVid6+RIN4KhnWx8GTEIaswAqP?=
 =?us-ascii?Q?AHiX?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-AuthSource: BN8PR03MB4724.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2020 03:36:04.9497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-Network-Message-Id: c54e2b8b-8dd4-4c8e-b737-08d8abaadf39
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o6Q46OcDxRtnFeoeus05QYzjMxEER8HseS5gNYdrkLTpri1y3nv3U3FP7tiaQLZ88R8LLId02FxFPaFZikQDvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB3940
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

After we move dw_pcie_msi_init() into core -- dw_pcie_host_init(), the
MSI stops working after resume. Because dw_pcie_host_init() is only
called once during probe. To fix this issue, we move dw_pcie_msi_init()
to dw_pcie_setup_rc().

Fixes: 59fbab1ae40e ("PCI: dwc: Move dw_pcie_msi_init() into core")
Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---

Since v1:
 - rebased on 5.11-rc1
 - add Fixes tag

 drivers/pci/controller/dwc/pcie-designware-host.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 8a84c005f32b..5240b5f0973d 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -423,7 +423,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	}
 
 	dw_pcie_setup_rc(pp);
-	dw_pcie_msi_init(pp);
 
 	if (!dw_pcie_link_up(pci) && pci->ops->start_link) {
 		ret = pci->ops->start_link(pci);
@@ -574,6 +573,8 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 		}
 	}
 
+	dw_pcie_msi_init(pp);
+
 	/* Setup RC BARs */
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0x00000004);
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_1, 0x00000000);
-- 
2.30.0.rc2

