Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4112882D8
	for <lists+linux-pci@lfdr.de>; Fri,  9 Oct 2020 08:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgJIGnh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Oct 2020 02:43:37 -0400
Received: from mail-mw2nam12on2041.outbound.protection.outlook.com ([40.107.244.41]:52193
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726510AbgJIGnh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Oct 2020 02:43:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9xdTIFnKK4m4uO6hwDHfMDdsteln9BLOOyVpPpgihIesSa7eeo3etYCdUJwyuuPtqR0a242CPpzDWbnbkJl9rzSKESNV6bBYwqTSrm3jTnzy+xmLJ78Zk1WO5CxG0N6Bbi15Vleqdv3BbqLxfQj7bbt/c212ICqd6nkxPpOMMQt9b6RyRUiYAL4VYUITc9ckcaIWMlHvXY5p4zEXLI6jkUkHdrPjk4lwsMteIwzaue/gXTUyIC+YT6Insj4qBzH3FrqeZ7OjgOxblB+nCy4Tp7B5onY8XEqFQRgNirb2lUInPGDOkFBKZzWyfACTd287dLZpmJxYlgS7OmdS6rDDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H48G7QfZnH9nUHuleRCrMY5vga6sx9XjnMa7GjkNdyg=;
 b=odyXNN2I8ooSTHit4hyGowMTw/F69mpSsozAk4znSJMwmYtC1PAFt2sGc3gMpZsE0GzR8wM2UIgNpIobt1/CwSW2Tsd/CyXmI25cRNbtjCyJTwfZx7swGIbLcBNJHAh3jcKBBuMaPCCP+tJclRJk3TdanS22+VMyEdYQT/bHVeuIBj7jHd+p1S97+JeOy/gm4Q4uW8y+HQNZQOxahzEVDlTR/EqGhRvsTzHd43mr7XXGbqXCXc/YS6caaTHLM7p2iEL77VrQ6/1vFBrv7ZOjpJdK2r3S1L4zjkgvrd2KtfiBF0PcZy5vycq9TUW656qzfZnREP2bknBCUzfWI7XHzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H48G7QfZnH9nUHuleRCrMY5vga6sx9XjnMa7GjkNdyg=;
 b=KEVdmXZXHx+a4iwzSymWrpemPdxTW5LoF9jI5h3D9oNWQ8tPf5s8gQ/KNMxecmqYputo+q3yKhoAg/zvBQKRg2bvX39grDGaGoCMituhkKPDLgXMmRZMfc/g7/zlUE/WjQ7ahy/2hyXKofVy9T32YtIeN6iIncEA6H502zK2rVM=
Authentication-Results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DM5PR03MB3036.namprd03.prod.outlook.com (2603:10b6:3:11e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Fri, 9 Oct
 2020 06:43:34 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3433.046; Fri, 9 Oct 2020
 06:43:34 +0000
Date:   Fri, 9 Oct 2020 14:40:29 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/2] PCI: dwc: fix two MSI issues
Message-ID: <20201009144029.62f327a9@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR03CA0016.apcprd03.prod.outlook.com
 (2603:1096:404:14::28) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TYAPR03CA0016.apcprd03.prod.outlook.com (2603:1096:404:14::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.11 via Frontend Transport; Fri, 9 Oct 2020 06:43:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbbedda9-72a9-4a81-92c4-08d86c1ea4ca
X-MS-TrafficTypeDiagnostic: DM5PR03MB3036:
X-Microsoft-Antispam-PRVS: <DM5PR03MB30368ACBF28BD4E4B7C71E9EED080@DM5PR03MB3036.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: //TXgtJe06VOfOPvWFGsMRmCW93Kj8+xf4TV1PBCIm5r8FTBNToz49DMDvSCQrsVUUtZ4zh/WweiTcvG8uuTgDQ2DsHau+dEAaYVXLP6kNDeiqf7NneHfvScZw7NNQjeQPiF9fMqv2e0Z7jN1IBH8/1w/04ZYz64aAiACaQobnTta1C7o3Zrqh6uT1onaiY9M/MXv1yuXqL9o1pzLXzYy2filByPQG0pp/sDLSP3GtOpZebRyGR/J7XCNTVHuF1u07tYyRYB99Yo69zmmp+bACbYA94BSTA9O3WkNPGA6WjG45kiAxFJNGDL1gFe8OL1I3b6VFYmqzjpII7vD4I6fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39850400004)(376002)(396003)(366004)(136003)(5660300002)(66946007)(8676002)(66476007)(66556008)(55016002)(9686003)(2906002)(7416002)(110136005)(86362001)(83380400001)(956004)(1076003)(26005)(6506007)(316002)(7696005)(52116002)(4326008)(478600001)(186003)(16526019)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: mXCNIHF9P4fZu7xcIHwIWipfpUBOX585Q9x5tcH74yRrOOtwsaGesroqsoEXk/x/xD611/qDvHh5AV5clzdGTX4DtaRVknycaI/cyB1Rmg8d5Lllq6NtlwXkx9FTd7TcszMmOzOZS0fAtHTk7S6BGi4MCH24q1nyh/SGtQs8udzyhENCCfamoUsePnBlfv7pJmE/GrA+1uycItHJGHPPHD2RKt5I3f+QKs2eT0rwdaW/wm3suK96rTpLjR7Gf+Lj62CmTMbK4dDSnrL/QhxTbSVjKhcRA8/DHvVgQuab8ROF5CxidS43fykwdAWmcvg0luPGxaGxacsZpCAVSD1eoA496bfmcNfr7+00AyfuLI5MMGpIIN/hwYvWUbOWWDOqw1vWf3YYhQ8SD8dLBtMVrBJY4oDWd1iS98+FmDeTg6hcFCO7LNQKcUdaz3+Ohc9qOhGgBjjqIXkiT7aSsQSAnfK8/urfdNFdWSUr3+vlRDzrptCHROk97+I3Ko3VSZA+R2rWUSEvnhnIbfDRKVEaOKsuNuoONzrxlue7Hcbw75EtoSxu+EALjp1mUNILgcQiC0W1Xtku6KLCCkJcqs5mcMd7L2HNGiJL6y3gvnPEsQ/7qBFdSkMODIlDQ21RFzcRRfFMZ93IShPoQsiLkGkdjA==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbbedda9-72a9-4a81-92c4-08d86c1ea4ca
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2020 06:43:34.4711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EJMHGcIYOqmWJWkrOHtmHy/U0tqwaofpbRwkwmuabc7vFylhk4S177ptSsETz3XsN+M2XCNtTX+rluKaDL1N9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3036
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix two MSI issues. One to skip PCIE_MSI_INTR0* programming if MSI is
disabled, another to use an address in the driver data for MSI address,
to fix the MSI page leakage during suspend/resume.

Since v5:
  - rebase on pci/dwc branch
  - add Acked-by tag

Since v4:
  - fix pci-dra7xx.c

Since v3:
  - add Acked-by tag
  - change patch2 commit msg to make it clear
  - map the MSI msg with dma_map_single_attrs() for some platforms
    which either has separate addrs for dma and phy or has mem access
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

 drivers/pci/controller/dwc/pci-dra7xx.c       | 18 ++++++++-
 .../pci/controller/dwc/pcie-designware-host.c | 37 +++++++++----------
 drivers/pci/controller/dwc/pcie-designware.h  |  2 +-
 3 files changed, 36 insertions(+), 21 deletions(-)

-- 
2.28.0

