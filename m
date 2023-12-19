Return-Path: <linux-pci+bounces-1151-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F04278180AF
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 05:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A358C284FAB
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 04:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CCE129EEE;
	Tue, 19 Dec 2023 04:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MSehmuBR"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AED5393;
	Tue, 19 Dec 2023 04:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHRSiwY0Ln/2Fu6qk41WIooO4QBIwLCe4aSjVSPUrXEKgWuetksUiI3StyAs9peXD2zLGdcvm63XG+32ywWgVrhB06UrjnmSbcqR6Zf8ZII5n0HxQD+cBDtfR0jGCXbLQtRI67Uq1WE358aV4MEDEZcm5DF8Wnn/WkagryZbl0Q0M1UMP1/sTJ7aLRFUiTRFC/2ngcsufvHTHmA0tOC+ad1XQwZy+blqOAsn1HquerIiRqk28yDvv3RtCv/61eHsICJTFAZODW98C6CJsKMiuV0aMOwEc39+z61tUGlO5EgDoYo2rd3+NLYh5YFAlImy5tMBWe2x3gWun4P9giAcmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6oNC4ObsvNqUDhQQwIKLvKoUztjDywjQKt68rBtEgk=;
 b=f61mR+JB7JgSX8VVCqxpoaS8z2HBUEujNeyDTSmw2PeNwL3yv6Ic2SCbS/71F79AB7enuUxglzzqRKMp+TVHjKaLBhTYKsmZH9g04aRw5ZejDpnTzszKzSWeYUxlQkvogCRi/TfTmHvbPOvL+31QcJD0JBuOTsSjGWSdYIPtatXqkBMTXQxUXpbpS8kH43T1wO4+4SvfT9ZYhjetVjzoCO8tUH7pPy27Ze656aclxgYbJw+nPhtyLFUvnEI4gCtYQDw9bsO+4JEm+Ymfa3sGymncgwMXQI+fjLRAzQbZe53ORegqfJO+9AHDON+GpbwheHJwSZae1ZjX73vCccTzHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6oNC4ObsvNqUDhQQwIKLvKoUztjDywjQKt68rBtEgk=;
 b=MSehmuBRHEUn71SCnwInwtgeOidjWB1KQWxk2jGcxNxhxK7axsjJUAsouAEmLvvH+qMfZWjN7jvnKoUoCD5fE3O7jwrduBg9g2wIN2tOHqVz3mGMo033eXDw9QVQ7F90pRAzAoOEYeMoCluXfAoN6opmIjJ0uSRtilDcuryEHrc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM8PR04MB7203.eurprd04.prod.outlook.com (2603:10a6:20b:1d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 04:49:02 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 04:49:02 +0000
From: Frank Li <Frank.Li@nxp.com>
To: niklas.cassel@wdc.com,
	imx@lists.linux.dev,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jon Mason <jdmason@kudzu.us>,
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR SYNOPSYS DESIGNWARE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/1] PCI: dwc: Fix BAR0 wrong map to iATU6 after root complex reinit endpoint
Date: Mon, 18 Dec 2023 23:48:43 -0500
Message-Id: <20231219044844.1195294-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0224.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::19) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM8PR04MB7203:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f7e78d9-3252-4abf-1021-08dc004dd220
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0bNNzudrjAe51ge725YtTtWNkoWoZz6WQBu4HPE3bgqv4QaYPrOKZnNzU6l7CAQjAV17heFpj1APg9r37d8sRDq8buDvxRmVVt6KUwzNis6g08fDOTgT4unmofvjPDlnFRPstmyaTYr5o8AtjNgjoB3Ff94RKP70AuA+mOn9HKQ9mFRRHSRNpz/YNlaJO1bjOghDra9FZVqyJ61YokSxBOXuT3u6rRwbuiSnYeOwynjLKC+wY+CQ5T8tDjUyGKb3OU6gKmreZuf1nWaj7RAOMtxJOdhbv20QxndQ7fKNwB8+ZA0IRecwaTjB/O+AzNskaUqZ+m5c2kIh1exdV5QbOJGFmgCNGIbQ09sfN0YQAhPJDfPNNB18C32DGevEqHbODmjcESwoRns9JKMf8TadYMZYDCaSA6JWaZUNOMu1TGAc6Ms/nVk5B81ZbwBLRplWBXJI4pCSoHIFZk+Cw2+qIRY3X1fXs+1cNY5PmsKf/Cs2cbZKkQwbpKQXD6MjYY2Rjn4wBegTChA0jrIZOorob1rOJazp0AvcbD2WH7L9Bj5bcbib06xAeEvFXFNyyrFsRO0wn763g9yQaYMKJHQfICfA19LdpIDQMYpXQWqVmmIwlHGCak6CUzc9CGi1dCsh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(921008)(38350700005)(316002)(66556008)(66476007)(66946007)(8936002)(8676002)(478600001)(6486002)(36756003)(110136005)(966005)(41300700001)(7416002)(2906002)(86362001)(5660300002)(38100700002)(6666004)(6512007)(6506007)(26005)(83380400001)(2616005)(1076003)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m3NkQwCR4UOG65H8gzC+HxYKl/wxqPL/9Ooq5TGk8lYo4W5MBsH9NVFUZ/vt?=
 =?us-ascii?Q?B+igFuNA1MN5PuTNZIVzAkjX9T351MaaBJ1R9GzcsCeVwmw0zuHftZjPXNKn?=
 =?us-ascii?Q?pvzMtuiIVYpUnqIFgAcC6l3LuHrdTf7ZjKO3wr7ysUv98uamjIOdaTBL0pLm?=
 =?us-ascii?Q?FuxOs8AaB6vclGMZclVLzSyeu1Io4unQ8/0UGlW171oLvf4BTkKyxKh61OPL?=
 =?us-ascii?Q?vkl6+cYSN3Z4lkU5MnpaJIQeAohaDL8Fi79tw68wamFel3kxXhD49DuVlcRh?=
 =?us-ascii?Q?CI6wFttpORRQEpKi04MaW6aae32WuNgOFAmROXChkojbHrmNRRK81+uqUace?=
 =?us-ascii?Q?/rQB/bvKf8XJAqB4F4dKgFK3B3OzR4Cl+Ie+9cXG5TfTnwXuldeaxP2yjaRj?=
 =?us-ascii?Q?2/zprpsjzMm3FmRbOIpY9D6fcHVX0IsUNeRtA0xW+jKNmkzEfOLvtv9cImqB?=
 =?us-ascii?Q?0okqTqLh9c3Je88gwcuqW8pPEDIZDPzlnVIDsBfqC2gctEglNCm3Ap/MqaG2?=
 =?us-ascii?Q?eIGXLYy5w0/GP0sfoJOZqC04FCJBAtBx4tvvHZt50qKugIEyOdHXBAe6tbjW?=
 =?us-ascii?Q?nPalqSwl9bXR0nZBsKh+7vt8KKyNcc706XiRvXqfSwpUmQhZ12G45Wp//hYk?=
 =?us-ascii?Q?mweCANOQVtWW1KKD2KTYviVx7qACv4EydfX75aWlLPBayxkx37doPrUfqLIu?=
 =?us-ascii?Q?jOADOr4llNB7Hpd1snUyq2sZvS8PIoureiZgFn53WPXrAWzvAujPi7n1mmUl?=
 =?us-ascii?Q?rIHSKqpVyWNPao5c9jV/8yYA2r9PkyrDz6FKK+fbXWh9IN1FX+mz6C4isXGz?=
 =?us-ascii?Q?VBsaMVqk6q/tcWTGgWlC5QbVohQEL7ZSi7cjBiTxCLdLgeYl8g18QfurQfBE?=
 =?us-ascii?Q?VaGbdWv5NOYkzCdTnAnSbMEDuFTOkmlycCBKbWSa21AW6Pc/+fKDrNa+SEiP?=
 =?us-ascii?Q?sKRtwCxBkozKJ7RC3F4bpjEyuj0oqJB+jG5A24e/Xh3AugpehOH5PrbkwQkF?=
 =?us-ascii?Q?SvUU1os7GC70KxV1R/8oxYUpkp/6kx9Baoy3/S4Zuxycau/rqN3JmyIFs9bv?=
 =?us-ascii?Q?f9hN+NO6E507uQ5sQTW8NTveF0u6+Dx2zskiJDAJ5+jFc/C4IQbhNMxWuBha?=
 =?us-ascii?Q?Nzwa+RfgQ4D3Lj19+t7ew2xPZm/HU+0d0pP7S8BPnwngSqXSDxC1/7sSRltJ?=
 =?us-ascii?Q?GBxIZIDGMsiPZ3bB6UjI2Mkp3lqsEi95dpWPlpxT3C0skioSyfPgaQHV590K?=
 =?us-ascii?Q?Oy6xlRHx20G7V5z3keU3epV2Az05i/wQBOvq1M7epKiSYY3vOBJpVvcN0fEW?=
 =?us-ascii?Q?Ox3IZ3j6omnVQrs0i4ZcWdMsulJR136jvpuZyW+aQn4Rhl+jBcApVovx9Za3?=
 =?us-ascii?Q?W0eKL4wZf4UGnA1K+tYnYSEoPcoiNy4L0KDaSfR/J8XxO9kT7jA2390Tzick?=
 =?us-ascii?Q?26JRk8SE2ePxNkj1Opt/f/SZe4eyz7eC1lCaXkwJIgw1rQBqvS6Rjyi9oy+j?=
 =?us-ascii?Q?naFllCjGBMWe4sKDl52x5nOkyGiulAmqc1i8Z4mBCE5NIg8WbpYWQlRa4cyd?=
 =?us-ascii?Q?Yo32kuWFz+wzNBOZPXM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f7e78d9-3252-4abf-1021-08dc004dd220
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 04:49:01.9581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K/R2F2ENIIh9jEd+kWauCQhE6AS7mPyJumeHms0M8Dn93QlPHTAu0AxBkvTIJrQYjxk5j7pY84FVpOl93epMTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7203

dw_pcie_ep_inbound_atu()
{
	...
	if (!ep->bar_to_atu[bar])
		free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
	else
		free_win = ep->bar_to_atu[bar];
	...
}

The atu index 0 is valid case for atu number. The find_first_zero_bit()
will return 6 when second time call into this function if atu is 0. Suppose
it should use branch 'free_win = ep->bar_to_atu[bar]'.

Change 'bar_to_atu' to s8. Initialize bar_to_atu as -1 to indicate it have
not allocate atu to the bar.

Reported-by: Niklas Cassel <Niklas.Cassel@wdc.com>
Close: https://lore.kernel.org/linux-pci/ZXt2A+Fusfz3luQV@x1-carbon/T/#u
Fixes: 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    @Niklas:
    	I have not test your case. I should be equal to previous's fix in
    mail list.

 drivers/pci/controller/dwc/pcie-designware-ep.c | 11 ++++++++---
 drivers/pci/controller/dwc/pcie-designware.h    |  2 +-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index f6207989fc6ad..0ff5cd64f49b0 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -174,7 +174,7 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
 	u32 free_win;
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
-	if (!ep->bar_to_atu[bar])
+	if (ep->bar_to_atu[bar] < 0)
 		free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
 	else
 		free_win = ep->bar_to_atu[bar];
@@ -228,14 +228,17 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	enum pci_barno bar = epf_bar->barno;
-	u32 atu_index = ep->bar_to_atu[bar];
+	s8 atu_index = ep->bar_to_atu[bar];
+
+	if (atu_index < 0)
+		return;
 
 	__dw_pcie_ep_reset_bar(pci, func_no, bar, epf_bar->flags);
 
 	dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, atu_index);
 	clear_bit(atu_index, ep->ib_window_map);
 	ep->epf_bar[bar] = NULL;
-	ep->bar_to_atu[bar] = 0;
+	ep->bar_to_atu[bar] = -1;
 }
 
 static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
@@ -767,6 +770,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		return -ENOMEM;
 	ep->outbound_addr = addr;
 
+	memset(ep->bar_to_atu, -1, sizeof(ep->bar_to_atu));
+
 	epc = devm_pci_epc_create(dev, &epc_ops);
 	if (IS_ERR(epc)) {
 		dev_err(dev, "Failed to create epc device\n");
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 55ff76e3d3846..5879907c5cf25 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -362,7 +362,7 @@ struct dw_pcie_ep {
 	phys_addr_t		phys_base;
 	size_t			addr_size;
 	size_t			page_size;
-	u8			bar_to_atu[PCI_STD_NUM_BARS];
+	s8			bar_to_atu[PCI_STD_NUM_BARS];
 	phys_addr_t		*outbound_addr;
 	unsigned long		*ib_window_map;
 	unsigned long		*ob_window_map;
-- 
2.34.1


