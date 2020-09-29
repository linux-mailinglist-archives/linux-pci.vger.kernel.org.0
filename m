Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971DC27C278
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 12:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbgI2Kfk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 06:35:40 -0400
Received: from mail-bn8nam12on2077.outbound.protection.outlook.com ([40.107.237.77]:7552
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725306AbgI2Kfk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Sep 2020 06:35:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0VcpqbxOp0F4YW3l+w52M0iOP9f/RfLmhQ7665ucgEH1BHuUcFSGHzF/a56RKzfphTkkUoGO9G7yb/5wd9q/GGEvHL5ybFbAHswrB+4c86ae2gEVpCloQSlQMEZJxKO9+kicW1f3dwnWW3FVzHFTzY7RqX5d1/gWlvE48W8v3pxOlxlSAAR1JLvGVwypDj5GyaJKHiT9PkZxS7kgYS6ngT5374k+NTyT/deHYlHcifAiTG9xjXABQB/IWtlXUrr5wi2x+uAD2vzI7K0YELHmwvADD4YkuQYTi0c/zoM8vOo7jaYTQTIeRqsNUPL0JtWRGAAJJcicg4bvt/QpdYUCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3QpN2f2mgnbcEkJZ5GGWu0nyYZ8+wL7/g2y8y0+qM0=;
 b=PgqFyqkxQLFzM/xwB9LLbnYUiyeV+06QFwpPe8HFI7on1cLV65yz46mtYzcoeDWIlOd6N33AlPM6Jt6r4zJQ2bKoJzyT5RtafgSloFhBYimf8qGaGn2wJZ0D3YN41Qea8KJLwVkILxKTiZEYJSFB3NoPkvCGQJWHj/IK/RGkLNat1MuDvkc7u41CvwvvR2Bqafi0NRh5pDO2fFE1Xda9+ygZmD0ykicE6iZVTqYE0PodsbeHpd6h1Ow6NVdxDRKNn8eg3gZrBoQZlIbzEhfwMj0LTNuzpM3HvJdT3TD2mWJpD7u+uVspxMDqP4ikAD28BRl9GeWCWCZ/7Bl+Q87Ggw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3QpN2f2mgnbcEkJZ5GGWu0nyYZ8+wL7/g2y8y0+qM0=;
 b=DLNJMC2ysE5L3H/bHHLKVEOnGVfnStMYND8+zWOPmwXYcPQ7hjayi/4Q79Tvs9eP4cpvx6Qf3bEUwSlWS4iYOeVufvXvqSS+y69l81JfEcQ2Et7wDQSv1NIwM+8SsqwQFaj7EMRsgyTnqGPtXpn3BQsfk0kKlShiJ7JyDQlBJXc=
Authentication-Results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DM6PR03MB5292.namprd03.prod.outlook.com (2603:10b6:5:240::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Tue, 29 Sep
 2020 10:35:37 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 10:35:37 +0000
Date:   Tue, 29 Sep 2020 18:34:03 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] PCI: dwc: fix two MSI issues
Message-ID: <20200929183403.060d1853@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYBP286CA0025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::13) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TYBP286CA0025.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:10a::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend Transport; Tue, 29 Sep 2020 10:35:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4621c029-698a-40a8-a04f-08d8646366fe
X-MS-TrafficTypeDiagnostic: DM6PR03MB5292:
X-Microsoft-Antispam-PRVS: <DM6PR03MB52922D70E5CFB9D178AF2CF5ED320@DM6PR03MB5292.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y6ILWZ4anFO2jrE57beRnC4/Unvm7stmJ4Zovms+Rx8AQ8ODQf2QRvRHQL+mH8p8H/gzGG7O8bd0QXZ+Dx4VZJs5B7/rSo4LLoWt93a9GhZGuJEvpGs1p1Yv8dFUfR7EXDLLIeB/Dp2t3WSYa4U3lUZ0ypad+p9gYPLpz7OVeCj8uzHklXjx6YtJn59vJ6m51oNzCuxxq+kj2mzTrjX2HvZr1CWaVlA0lJfhZoa5Em8eeZOA0slfzrFgttCD1lyXDhEekhRt9EQ/s2JtcXYZpaF8bOfqDxhZAjnoTbllr01VIvKNhWfpDR47GGnL34Ev7rX7s2PD1kzu7Bqx0JWK9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(376002)(39860400002)(366004)(4326008)(6506007)(186003)(8936002)(16526019)(26005)(55016002)(9686003)(8676002)(7696005)(52116002)(86362001)(66946007)(66556008)(66476007)(478600001)(5660300002)(1076003)(6666004)(956004)(110136005)(316002)(2906002)(83380400001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: CWyJtgAhwNCuIJLPGkPADkaOm80qpip2kbocP5lH8dCQruXYObLwXe0qMIh9rZB2IW86i3E8qwfrz2RTHK0I6eNclpFET+9eYllb6IeiFTkwHLJXu7qzdq5hQfxds1mcOhu+KiVh0N0sTftEQyPfCh2/mEcgp500OIVXqD8VPep2oXSl05BEMdMLJfok+H5nJGH3CzlhStfv+JKBBrOErgkF15Y4XXHSSz0MEEF2Ol13+lHPQ5t+VS6hEexGv0enhZruTvG3fzAfCCClyIhEfcrxkS0dTT4fLeWx7kqojt5Sh1GY5uojJM5S3ftH/UHFdDv3/0DUSkx0bEyFnfU8IzL9X5yVKW0je1hB4nsoejk0gj6LMHOUaDrHpP8YDngSZbwomVDbZcLm9pihpNgARgm2llzo1V5PX9v7qW720ASdDDao7LZea+tdpfI8/uomIT/32KEnzXci1LOwjl1Q5DuF/9GK4QjQYw+Ri45SpV+0kQTlBh6VyOdb4BJaj1APcJILPnD7U1cj+m4B7CvVDCJeYuRTskOtpDuApqSO0u5gd3+fa40mbWCyNQsyai5Gf7TyEdQfiQrWhw6kZk+6Ifvydgd5JqWJzNfbau2pjhPZHumxfDyBHEQriguOuVsHgW6n4YO9fQZDOrGrI4NHGw==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4621c029-698a-40a8-a04f-08d8646366fe
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 10:35:36.8336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mB0PA6AYtYEzEBFbWcXBXe+INjHS6KL+Mx/Nyqh/phyYltzFUbQA2Xyn76xaGTIN1bd6daYHsUynLTlI/P+qfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5292
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix two MSI issues. One to skip PCIE_MSI_INTR0* programming if MSI is
disabled, another to use an address in the driver data for MSI address,
to fix the MSI page leakage during suspend/resume.

Since v3:
  - add Acked-by tag
  - change patch2 commit msg to make it more clear
  - map the MSI msg with dma_map_single_attrs() for some platforms
    which either has seperate addrs for dma and phy or has mem access
    limitation for the PCIe.

Since v2:
  - add Acked-by tag
  - use an address in the driver data for MSI address. Thank Ard and Rob
    for pointing out this correct direction.
  - Since the MSI page has gone, the leak issue doesn't exist anymore,
    remove unnecessary patches.
  - Remove dw_pcie_free_msi rename and the last patch. They could be
    targeted to next. So will send out patches in a separate series.

Since v1:
  - add proper error handling patches.
  - solve the msi page leakage by moving dw_pcie_msi_init() from each
    users to designware host



Jisheng Zhang (2):
  PCI: dwc: Skip PCIE_MSI_INTR0* programming if MSI is disabled
  PCI: dwc: Fix MSI page leakage in suspend/resume

 drivers/pci/controller/dwc/pci-dra7xx.c       | 16 ++++++++-
 .../pci/controller/dwc/pcie-designware-host.c | 34 +++++++++----------
 drivers/pci/controller/dwc/pcie-designware.h  |  2 +-
 3 files changed, 33 insertions(+), 19 deletions(-)

-- 
2.28.0

