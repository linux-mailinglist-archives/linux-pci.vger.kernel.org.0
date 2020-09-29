Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1FD727BFD8
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 10:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725355AbgI2Ipf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 04:45:35 -0400
Received: from mail-eopbgr60076.outbound.protection.outlook.com ([40.107.6.76]:16849
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725372AbgI2Ipf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Sep 2020 04:45:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrocBFqfNvr600LgS8GIDLJJeQ44FPzgiPS7BggrHlMy7LfROT7QZsEt5g1SqqXinc44XrklHjI3KrOJQntR1DzExXApdpr5Qn1FnUWr0Y/chQBue3uT1inlZzulhm2rxZowa6Yei4w4XsWin/LtFZFpTc3BLqoST/XbXas2JPhFX0X2xGvDe2PF/TwaOrlmCQVswH1e7xtjH6X80mEN5Af4OnzLhMAjcs2J/B0La8MvphkGoyo2JoQSaSXjziAw233tf97vofE6kA0x6bJChXNpkJsc60879l2hXRvO7caJeisc2ky2HYYFmeKlNO+ZRlQMfUTCGKPZmJOQGaa3rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZLfiba29tqvqyzkCjLR/toS/hZhKVCRUQVvHMp1uj0=;
 b=V7+thZIPPFC3jSLOmTBUrXcfFUIoJ9Wb36xDaPJupjGM3m+lnZxe8nhLCu5SddCfovBuGeSAZpkl3+bEmE4EXbCk4QKrj400eW6U6cgA3D3GeHtFHrRD34ezKmSFcfO+KtDM5yYzXvXs2z6OdDPmMK39H7DHv4E7Ww/mhLa3xN51HEL5kRM2RQ+SGRcToGg4awcY7QghfPJdp5Nsc7tUxHwNcwW/vujFr98r/bvMcVwwb377ReFbxp67dAKdVVnDSsXofVCmDFF+D8LW7H7UTlEPki6jEDLkLeSCJjZ7bqha7ZTCNcWkEFUWP2jllGDw4C6nL/RTKLksQNEBl3yjNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZLfiba29tqvqyzkCjLR/toS/hZhKVCRUQVvHMp1uj0=;
 b=WkIMdQP+TRucS4TJ1Z84P84HlKGbCsA3PY3DL8c5RYAEITCV/Dm8qIQR4Vj7W3XrO4hyyBLnQl8sFsc5t8Fip8n1KlDwNeYphRo+DmeJ/w1WCmIvmJzHWfnZdVeF65CKaBzGh/mWQFKOmqJ4wBclchk3Flg725WNbdIukAmpOBY=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB6910.eurprd04.prod.outlook.com (2603:10a6:803:135::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 29 Sep
 2020 08:45:32 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 08:45:32 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     hch@infradead.org, sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, kishon@ti.com,
        lorenzo.pieralisi@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V2 0/4] Change vring space from nomal memory to dma coherent memory
Date:   Tue, 29 Sep 2020 16:44:21 +0800
Message-Id: <20200929084425.24052-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0302CA0032.eurprd03.prod.outlook.com
 (2603:10a6:205:2::45) To VI1PR04MB4960.eurprd04.prod.outlook.com
 (2603:10a6:803:57::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxp.ap.freescale.net (119.31.174.71) by AM4PR0302CA0032.eurprd03.prod.outlook.com (2603:10a6:205:2::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend Transport; Tue, 29 Sep 2020 08:45:27 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9ff97ab9-c917-4997-752d-08d864540617
X-MS-TrafficTypeDiagnostic: VI1PR04MB6910:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB6910C37630F93650092CC9FD92320@VI1PR04MB6910.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YY07fKp0SB1jy9mEa/e8iMRmJldAGa4UqLRgeiePLkP/9RmGPZhBCbz3fTM68QHXIUp59RSE7QjoPF5TjZ8AGW4oCuK8c3lBl1db+sGakZ6vka2nznjUOSeaf10mH3DFygWYuTmKsGZgrcyILXPaQgK51m3er4LJaE2UelXuJNUgG+KKVGU/vdDgYYmzgxRJIlHjLO9tjk1z4eDdr2Qh+AHRg25m15IxszUxPMlvFsVsngJdCSLIRAgCFJP4e7XWV2LvdWYxPgykT21/SaprS/nhvxPi4mivvuDKpr/xKhEQ5LxpfaY9tBpOMgK8qHhVhpRVcWzeREakm0Ad6uzxSJgYo3K0bTqjJkaQtDH8gV4AByHKX6PgqAjyxtNJKKx/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(2616005)(186003)(956004)(316002)(6666004)(8936002)(6506007)(52116002)(478600001)(6486002)(5660300002)(66946007)(1076003)(26005)(4326008)(6512007)(16526019)(8676002)(2906002)(86362001)(83380400001)(66556008)(44832011)(66476007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 3CyimHrXcN4GXpbd09mCsVk8vUcsKea656yk2vK2A8KCwtjIZGa3irSsDueWZFfDJJIwVK5n1DVdWZlShH7ZSL7iOMN5ABd5EZBPr4nbr3vIFEuXRxWZxfZegbMxHexi/989DQI2Re2cbQ7NnCyG8ZuvCntYmMCqvp5C/Wyt8amfzrcKCoTRxXWSHwFWcDlYbWLXXaOs4yQEyBBawPkl/TCKz2xfkL5pqWf7L8xG1Ohaqm26nzUtvIwFXsEtGUGbLfZH1RujRLhGgPPtUFPTZorXX/CNkX2+NW137kR6+L659LvsAxGDZOkhMhqbSn1dNABlQ8w8nRv3U4Pht3UYRByItZf1Ijdw3O0R14HR6TZBW6XREU36fN2wjof7bwc58L5Vjgrl7R8Ohn2VtV/CSTTf3FD3mCZBuUqpYHomK3CaziYibhPmr952IATnOGNzYZ5ful3wjm8k5bJOoIVtbJ5RzV/cRno5tjVw1xbPhpUPADXTo6ADHfug1s23wiug33SWsYBNDTALLQQfD7rMCAF7GYQUNwZmuzkM2TNamJm1nyyMPKo4fz4yymystbIrDz3DVwl0v6MEcwOJ5bhDnXmdKlkDxJ8/wjAAINK4RfdzHeC/dYflGLMHwsPWZ+/A9jOcwYRRHvE4rVdyAr6KSg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff97ab9-c917-4997-752d-08d864540617
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 08:45:31.9473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cNzokJEqyMif5UWvMipMa75pECWPbbDBR8fROhLO+a8tfyYFQLajJx2eB10BGhiJl7CrDw/YNbQ9al3tGBpvYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6910
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes in V2:
1. Remove dev_is_dma_coherent check as Christoph suggested in the patchset. 
2. Remove used_address_updated flags in Patch2.
3. Remove WARN_ON in Patch3 and return error code instead directly return -1.
4. Remove Patch4 as it is a separate patch now.
5. Add more detailed explanations in the commit of patches.

The original vop driver only supports dma coherent device, as it allocates and
maps vring by _get_free_pages and dma_map_single, but not use 
dma_sync_single_for_cpu/device to sync the updates of device_page/vring between
EP and RC, which will cause memory synchronization problem for device don't
support hardware dma coherent.

And allocate vrings use dma_alloc_coherent is a common way in kernel, as the
memory interacted between two systems should use consistent memory to avoid
caching effects. So here add noncoherent platform support for vop driver.
Also add some related dma changes to make sure noncoherent platform works
well.

Sherry Sun (4):
  misc: vop: change the way of allocating vring
  misc: vop: do not allocate and reassign the used ring
  misc: vop: simply return the saved dma address instead of virt_to_phys
  misc: vop: mapping kernel memory to user space as noncached

 drivers/misc/mic/bus/vop_bus.h     |  2 +
 drivers/misc/mic/host/mic_boot.c   |  8 +++
 drivers/misc/mic/vop/vop_debugfs.c |  2 -
 drivers/misc/mic/vop/vop_main.c    | 48 +++--------------
 drivers/misc/mic/vop/vop_vringh.c  | 83 +++++++-----------------------
 include/uapi/linux/mic_common.h    |  3 --
 6 files changed, 35 insertions(+), 111 deletions(-)

-- 
2.17.1

