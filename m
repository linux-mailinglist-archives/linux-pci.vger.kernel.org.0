Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B5F327654
	for <lists+linux-pci@lfdr.de>; Mon,  1 Mar 2021 04:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbhCADLc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Feb 2021 22:11:32 -0500
Received: from mail-bn8nam12on2077.outbound.protection.outlook.com ([40.107.237.77]:60036
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231535AbhCADL1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 28 Feb 2021 22:11:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PaMAv3AYQcdHkPBlJxeKMb4RUuD3IAYy0DkLpkjVU3GCMmKx3oDaYw8D8US481Ml6e0fuSKJMLPlbEndZDg1tK2o9AS9J8XorfHDbs7LOg1dtM7GrCFwInKJisuF4MCoitGXDBB90ukAyODJh99CwyjgzWPv1sU8NupW/PYid8IPTWSBpyk2OSKcMHChKsvH+zIzDEOZ00ffPIF+FU82/L2qyC9W592zPfbDPJAyuLiaI+trCjLgmKrfd67igI2VCvxgE+H5IWEfdYsu7LzdI/Ls6NPXZgGCOIDuNHVJe1ybByzTn3/yy9hUCehzSHdC6tZ4YbvvKIVh6u55uhuDow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rh/0z7Rk9i0TyK0mbz9Q6LJt0Ntd1nftoJJKZ+PJgYU=;
 b=SuBocLj0/hWdyY11Lu6FF+FX8MjbIeCUCa6rQCadsx4g/Ee/P+IzkydJUeqy3x/JRX81yOmlEcKtblkrgNcTIIWRBXKW7gC6ZMSbPwGxJqXPFTJTf0PnoDdTTyeH3swYDWmDvYc+0+VEMIX5h+MEAzOjvNmTh3/jlRTDXsHW2t3ffZ2ZwaMssD1fiRy5CPB8G5G5f+Z2yww69KuQQrKKti/tk41fzC/B1dLH7ZifLCfZdrNRL4yfRF03Z41IevHIk+EU9IyL9nHo04xB8CajRHqJ/oyWIfvsQIS9t7dqUnTlr+bI7PWF+bSMGyEsvDRHqUUfqoa2azqGrlOgZxd+dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rh/0z7Rk9i0TyK0mbz9Q6LJt0Ntd1nftoJJKZ+PJgYU=;
 b=I1SPJRF5sMSS/3MzULK5akxba/QprPw8T6a5a8xUk8h0HwGEbbC41vgMi69Y0AvRxFbaqABW6Wr0rQ6WIO4Jd0Fiu+Z9JdhEpwGWaPiiovBE9Se+O8KYCTrwJALeh2ELESZD+lc0XGvOrTkqEXfltQn134dCvaZo6hZ/PZko8ug=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN3PR03MB2307.namprd03.prod.outlook.com
 (2a01:111:e400:7bb1::16) by BN6PR03MB3217.namprd03.prod.outlook.com
 (2603:10b6:405:3d::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Mon, 1 Mar
 2021 03:10:40 +0000
Received: from BN3PR03MB2307.namprd03.prod.outlook.com
 ([fe80::246d:2f3d:93bf:ee56]) by BN3PR03MB2307.namprd03.prod.outlook.com
 ([fe80::246d:2f3d:93bf:ee56%4]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 03:10:39 +0000
Date:   Mon, 1 Mar 2021 11:10:31 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] PCI: dwc: Fix MSI not work after resume
Message-ID: <20210301111031.220a38b8@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BY5PR17CA0059.namprd17.prod.outlook.com
 (2603:10b6:a03:167::36) To BN3PR03MB2307.namprd03.prod.outlook.com
 (2a01:111:e400:7bb1::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BY5PR17CA0059.namprd17.prod.outlook.com (2603:10b6:a03:167::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Mon, 1 Mar 2021 03:10:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05e71691-f9db-42a2-570c-08d8dc5f97b3
X-MS-TrafficTypeDiagnostic: BN6PR03MB3217:
X-Microsoft-Antispam-PRVS: <BN6PR03MB3217ECED3203D61770D045A4ED9A9@BN6PR03MB3217.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LyX4jQYJJcCGRbSGEeoepV4e+H8HXbFBaDIibF2bKeTLXQT3s6fzJXmL3ZAh7uDyRA705x5rBahuDaK/7JQ3whnFLM/gwOZ9e0lexkbMynkrhYVHxTUsvQTx+n1exmKEvglcjA7ZeIJgstuxDncMq6aZ9F+vL0YMp709oyk9OLjnGUkCGrtGw+oem60ZMKm7ZVaAKYdi8R6faxBX28em9miw6crM9d+tRSc06JvWnq/+QXbkqakVWspD0u58/c0my66ROkCYctmwsoKJarZaRaqzPttgK/lwi3b4Ouk0V0plDSt/eUYguJyqg2omOcFfcuDNjk1FaVCQHwYnDX2ankGxtAn8R4BubenCY1VXPxfUIjfnNUUwrtAk7o2OUJBPFcTW+2D2yQsTMtZoJ0jcyoS9GjADA+G/6dgcOFcDd9CWavthE2w25eYQb2hOctPykRJHkeIyL6fGEbQY+6cUQ4FKhhXd07IObZ69+43DF+UyvD1f+sIlurrtg+2xr6Nhv2S5U4HafJoeByEYILk/Sw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR03MB2307.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(39850400004)(136003)(366004)(6666004)(8676002)(1076003)(66946007)(7696005)(26005)(8936002)(55016002)(83380400001)(2906002)(4326008)(186003)(66556008)(6506007)(478600001)(86362001)(110136005)(5660300002)(52116002)(316002)(956004)(66476007)(9686003)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Ntyy10x9eIPIYlh5JFN7N/lel3H8sYZ/XRRTrDOWzNoqZ7mjjGBZfuR/8fEg?=
 =?us-ascii?Q?j6W+yontYaVWYqSCqAKWrzXPonV0H3iVGl18hyXC4bzcDH36pkATwMD/jqMk?=
 =?us-ascii?Q?9FRe/ArmJ7FCVLKyKWB38WB9UPatv7OIBzbXBNSa/BuhkfKnHXDBgdzA9aZB?=
 =?us-ascii?Q?NNVbzjf0B6cccLHYD7fElXWPjyIK9sUXSEXCWs7cH35q0FMu/bofQZ8+FZZh?=
 =?us-ascii?Q?onvmCBTCH+6nTynNs1HkLIEOeZGWYWd7aB8z5/UQO04mn34geMYP5mFkRkEP?=
 =?us-ascii?Q?KXA7rN+916eQVH2Beq58WvJF+TEsVP6pPK/xjeTboHapBtWqyvOGjZgJueBv?=
 =?us-ascii?Q?f+oKTBBWmHDJNvZhCIqBN1Zjnj/yCy2ncNVn3QkktIPr7vmQFm29iSiuMHa6?=
 =?us-ascii?Q?fqXd0gHj3bo8K/XEPX99GRXNpby19AcVVTnb6Da2eQqz09x33fDdS3VlqORw?=
 =?us-ascii?Q?6BCfA6q6P2TusQJvQLme/w34pP/YP+7uUfDgha2objv08DrE1dUf3diWX6mn?=
 =?us-ascii?Q?OKtpqMTkqmQc7Sn8nGZYpDzovmSvmgEkC27lQa6kZslNuoHxMXgY9Cg9s/Z9?=
 =?us-ascii?Q?F56uKLmcQFhsm7VyO88iX9MQWmFzr+018slf26EFiFjqUuw9DywuEK4B8ejO?=
 =?us-ascii?Q?1lPU4MUXLAzEWaBk/ZyA7GgRcryUOnhjgMLjMEu/mHWbsvZG7kqPEjOYjWKu?=
 =?us-ascii?Q?XSg+cb/ltCUpOeRq1qC11axME1rUF6qc1/Lfx8q3KVI9MCgzIGjaUtLFIRmn?=
 =?us-ascii?Q?Sw2oHGtE3gzs11fx1wRnjjVr3Yh6bNzL3f2eFH0kXjZ3xgJy7doB2dvC1OdE?=
 =?us-ascii?Q?zSEP9yz15Zl4S/8IpT1ANTexoltJrgsKyqxeuIZbYwPQ+E2GIsrCCul7393r?=
 =?us-ascii?Q?IZcoSCkhIDUktlkIV75D8bqtPWPgDlXda1PFtv73c7nPO6hQJfc+s7nwhf7u?=
 =?us-ascii?Q?tsEpwH3bTYN6BBi0v9LMmiUQHHxwQ24SEgVInc8fFh/BzDPs8efrqvuM5ijq?=
 =?us-ascii?Q?d2G8zLesnUX4kmyNi9FKV68+EfOmHJyb39UhWNdnUMRDg6GoDW00QJN8C2L7?=
 =?us-ascii?Q?jQDD9dFCvggktPP7gcXOLc9rLd4b8ilY8h4Pd/0UO+kPuaG0+WoxTcoZgiCS?=
 =?us-ascii?Q?7ARfCn9fCHWWjz3nqwrxWvy9Q2uAIa7SIlHztpytB5lPxIS9KWev00kNEaUg?=
 =?us-ascii?Q?6M+O5BT3ytevjl/mG7+fsdTwuxHNqRbXqq0pObNOVBzpqS+gq5zdot26zr7c?=
 =?us-ascii?Q?vNyUJLZKX+UUsOVkBj3QVjoc+IacEZ68g3ES1Pfw4bz1Wo2KY9gSA665psxD?=
 =?us-ascii?Q?S8n/vVNlZaUj6IU/4STD+nqJ?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e71691-f9db-42a2-570c-08d8dc5f97b3
X-MS-Exchange-CrossTenant-AuthSource: BN3PR03MB2307.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 03:10:39.9221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZHm4ZUkw9FaQTqJwSGlmQGtTIhoL0m8yXvQZR4baox7z6oT9pMSu2Tns0gEe8bgpsPIUMcswMF78XPnDMa73qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3217
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

After we move dw_pcie_msi_init() into core -- dw_pcie_host_init(), the
MSI stops working after resume. Because dw_pcie_host_init() is only
called once during probe. To fix this issue, we move dw_pcie_msi_init()
to dw_pcie_setup_rc().

Fixes: 59fbab1ae40e ("PCI: dwc: Move dw_pcie_msi_init() into core")
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
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

