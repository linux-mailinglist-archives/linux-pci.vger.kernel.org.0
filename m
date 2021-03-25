Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E08B0348A21
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 08:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhCYH0b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 03:26:31 -0400
Received: from mail-co1nam11on2068.outbound.protection.outlook.com ([40.107.220.68]:3489
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229812AbhCYH0W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Mar 2021 03:26:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYPhB3xQlZbAsPOQeEUG32I686xVDi+9xrdMTvB9PC+R2rzv8IArO4q6D/z8yqLe61V9pzOih8vNv6Lg3xMEnSi5XoUiAZ7L2EtFjU0UtC1ZTguq/9+g25XN1GWG3jL+su985NLg+cNWTYtEK+PWfPIGm8lGJgpGLa2sRVGF/0FZ/vLH0tKIMUqHxmL95zoyNIj4834flhezwRDEOy/Dvds4Hm3yG15RmBryMMNK/Bupx+x3TBBrxV27rRHLkASTljexp2rP1aAq2IpcMJ/9a8YMbMjFsfQdR5YgHaHvOIQYhEOgzgKkQUsDJPjQNnV5PbKSQgqAZVkDq5erxS4U+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFfFITAfcgY0T99BUQwmg4+ZcfrE3lO9uJXnKMO6/tM=;
 b=HVr6tE7WGOjNiNcSBL19ibwalyFs/R4B6il9SvUtWOV13SH13nFR0ZtcNpgbmgOVx9VYrELc7YW2SMN/aJnw78chEveRnqhpbgNcsDmIDnfF5Pto/Y9cevxyYWJMGXGQ8KyykXUAi8654V89RW9s8KIT08fKVwa+Fz7Xy+yYE6GuPmFz06jrql2gvyVwte57TOGwIt6mBWqZQ3hWG7PHq4FGZyn3ypSRumfUyHa0olpKXS7IbVt+A6dEMMULoVRrcSkLdfLE78pYw33lIBfN6c6QB9eUMxyk3rxGgYjWLIL9VSMaZx2s3Y5f8YfPcGPJFimVosmMhHy1tdTsmPNpeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFfFITAfcgY0T99BUQwmg4+ZcfrE3lO9uJXnKMO6/tM=;
 b=j2y1CQcI68JQzGcAdAXETkMfYYrwTh8fsnjuhmfozR2Iry9yaTrWivgBG3b3y2/PMS5vtI1DzTc6uLofKFLlMhj42G95Ycw0jElQHMqLQAY2ir0u+Rxz5zhUaHQUIiY3K+FAJehVMo2hJATreCDLToNpVu5+Z7p66dGlP+6KxHU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synaptics.com;
Received: from BY5PR03MB5345.namprd03.prod.outlook.com (2603:10b6:a03:219::16)
 by SJ0PR03MB5920.namprd03.prod.outlook.com (2603:10b6:a03:2d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 25 Mar
 2021 07:26:17 +0000
Received: from BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72]) by BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72%7]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 07:26:17 +0000
Date:   Thu, 25 Mar 2021 15:26:04 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] PCI: dwc: move dw_pcie_msi_init() to dw_pcie_setup_rc()
Message-ID: <20210325152604.6e79deba@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BYAPR11CA0053.namprd11.prod.outlook.com
 (2603:10b6:a03:80::30) To BY5PR03MB5345.namprd03.prod.outlook.com
 (2603:10b6:a03:219::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BYAPR11CA0053.namprd11.prod.outlook.com (2603:10b6:a03:80::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Thu, 25 Mar 2021 07:26:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1751da76-824e-42e1-1724-08d8ef5f4723
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5920:
X-Microsoft-Antispam-PRVS: <SJ0PR03MB59205F4AB6D14A3E5581A784ED629@SJ0PR03MB5920.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G+8TfUqIJfuvxr6ebItq0jJiPPeI/p04MsYJ33GrE0aJtf7V/Drmjlfrwpxs7lf4hb4zGmBeXkcXEAp6+tV1yYcW6V6NYlrtUZQPzNZ+O8VJkoFZHWPExZBSDfxfWmdqZNaGETbb7fAylGVWCI/emAHmxGcmCqHgvWUzph3ZOcUrZG/N7zt/h/mkgxyLPIWHkkGlznvN9sb54FA7xtUDvSOs0D53dstIkRKgSpCw8mRQ7prJh7RxZaY9Fj1WxA7FBnSVu0Q44lPHiVsDqdJ8knjMLb2XKs74IOcJA0q+xCkKIJ/QFuoXt9OPUK+t7cNn1gg9F+w/Y2fizkRTgdADysUq57j2wn1AIkR0ACfTSAw8a+dlK5EYTr+h6rkEoHG3qhGC5Tz43PpQucr6RFho6s5YkpPNJHmrqn39zaimBxQpno9KD5eD1G5VWB1DXxm8BmJ0Agmz1oXNTGO0IB6C08jnsbNCP9yzVOaDi1IXk7zINj3EiawrDSqNRvcmu3dbZ4/JWnTBLkwblUHU4fPIWmDpAn7PQL/gPDmMIEysNDXjuazH+r41N+DsRDFTx+jBd5DLKXCLlLX/GEaVnpTsfRYaOtOVbw89/ogpuQkAczuP/pBvaOIF3hkH8mHexQE/MvDawgNgKYhVkrb64SX+1bGYsae4gPbAsfhK0Yxvnqw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR03MB5345.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(39860400002)(366004)(346002)(1076003)(316002)(83380400001)(4326008)(8676002)(8936002)(5660300002)(110136005)(478600001)(9686003)(6666004)(956004)(26005)(66556008)(66476007)(55016002)(6506007)(52116002)(2906002)(38100700001)(66946007)(7696005)(16526019)(186003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hrMEcdnw2L+6OqhNDC7SNaH7urIJpx3Xgg2QgqlhhefYifyLJvSMSGNw0KU7?=
 =?us-ascii?Q?GS1bds+KE+hRUqZ//ZbomlwctoyOnSSKEs9Ngrw0x76oMca+szB8K4cy+t/o?=
 =?us-ascii?Q?NCT6a8uRE4ZHq/lwROLic1tlwOg065wgbWTTQaJV52B6RWqc37W3rpIVum80?=
 =?us-ascii?Q?DtJIuEqXoHOxjwLUsvY2ZIZ2/DY5JXbUEjMfN69QidGSVfG77liyGKlrr7lo?=
 =?us-ascii?Q?EwaqCSckTOmlX0GCyAMVRp9T6KY3LV9uSYsI3NcQVVKZ1vUtRFK7RKsvSoW9?=
 =?us-ascii?Q?mVPwQPwP1WGT7c+aWztEiEdisfRZbum81JMDeiHPR75aTVxF2hLaNNki/msO?=
 =?us-ascii?Q?ENb8m7xU7SXhg9hLok/LQXr/kvkpLQar6nqJMNVSf8B6mneXQN17pFZY8Wa0?=
 =?us-ascii?Q?iKe0/VEtbn/vhgvWQT2mRK5g7WNnhVRypCXERe6VBL0ZA5zMg/9zrfildmMK?=
 =?us-ascii?Q?eA80EiaaSOC92yI5UInkw1MejsLnUnfLNhMtzy6AX1zfsoSINORBjhQJypyk?=
 =?us-ascii?Q?C8pkngDNx7U6wBz1bN72FZ2Bi8rcVKXSHXbqO6uhN477cyvO/irwQc0DM3Sy?=
 =?us-ascii?Q?6u8JdyBxMiUvddwmVU4ME9rVk8Ww6KLwI2yesSVWtQQwkJ0pMb/SB8JqtNUr?=
 =?us-ascii?Q?Yoiv/LpOySQK1P7BjAj8yugaAcSpPGnqXVxZ3ZO/1Q6LAZpqMBHRdJce9d5X?=
 =?us-ascii?Q?8z/KHiwSrv6BQXiigYWUr0LTz4hSOSpTqOE9gxUTNMUB6iTICr/QhljIB3pI?=
 =?us-ascii?Q?GSQHNVQpAiudlymReQ5Rdyixdg3DUn8izNHKXdatRmeuQ/OrKUSSIDsKCwZe?=
 =?us-ascii?Q?41muCljB+MvLjfYxEAbOz8iG9Xq3RiSJNSoFyNeE/el6iKnsitJ6Y5mXEHM0?=
 =?us-ascii?Q?GKVx89TZyGrLhC/ooJB49lyAcMTkzIOrrF+2Q9WDfcVTO3kF72yNopjanKpb?=
 =?us-ascii?Q?EKjcz3kiYuSUe6IW9Ivyxr6M3+jQNlWQ0PYVpWGF0XY2Wk+ECuheN5UntiZB?=
 =?us-ascii?Q?daWs/xamRRfjZC7tvT30ZqgdAywbauWDdmD/1HiH6CKprvqZ8U8L831eaFxS?=
 =?us-ascii?Q?vIlsYa1WsY+l6jxs87jV0rcsSClNR74P3wVDHigbwggfA3d2MhNSOVYQvrK/?=
 =?us-ascii?Q?TgyEqpf1MT8f55bsOTsvU94Emh4z9gYE0Pf/gfQOZC6oIhvZb4jsO252YGx7?=
 =?us-ascii?Q?/KZfFbygkkba34Trwq9BgpHeNtKkmRETSfUwIvj35X/OEVaMbr2oen1Dekak?=
 =?us-ascii?Q?Dm4dYRaPyZgKFrSzF9JfDeDwc1lK9dGV3k/4/C6qSLDzyAfsVXYX9L6CkPCC?=
 =?us-ascii?Q?ic6AH3qBmxQXCdhNQGMZNw3l?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1751da76-824e-42e1-1724-08d8ef5f4723
X-MS-Exchange-CrossTenant-AuthSource: BY5PR03MB5345.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 07:26:16.9061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ivg0Bp9Ttl/0uMIEsEaTBrWkgq9b4I5LoQxImP5+VPYvoep9aqDoKPOMykIYeunIGcJw85DeYuqDrobSIL+Zig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5920
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If the host which makes use of IP's integrated MSI Receiver losts
power during suspend, we need to reinit the RC and MSI Receiver in
resume. But after we move dw_pcie_msi_init() into the core, we have no
API to do so. Usually the dwc users need to call dw_pcie_setup_rc() to
reinit the RC, we can solve this problem by moving dw_pcie_msi_init()
to dw_pcie_setup_rc().

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
Since v2:
 - rewrite the commit msg

Since v1:
 - collect Reviewed-by tag

 drivers/pci/controller/dwc/pcie-designware-host.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 7e55b2b66182..e6c274f4485c 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -400,7 +400,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	}
 
 	dw_pcie_setup_rc(pp);
-	dw_pcie_msi_init(pp);
 
 	if (!dw_pcie_link_up(pci) && pci->ops && pci->ops->start_link) {
 		ret = pci->ops->start_link(pci);
@@ -551,6 +550,8 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 		}
 	}
 
+	dw_pcie_msi_init(pp);
+
 	/* Setup RC BARs */
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0x00000004);
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_1, 0x00000000);
-- 
2.30.1

