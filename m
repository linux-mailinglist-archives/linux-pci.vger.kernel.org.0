Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9252988CD
	for <lists+linux-pci@lfdr.de>; Mon, 26 Oct 2020 09:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1772301AbgJZIzX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Oct 2020 04:55:23 -0400
Received: from mail-eopbgr00080.outbound.protection.outlook.com ([40.107.0.80]:58242
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1772299AbgJZIzX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Oct 2020 04:55:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/7irHHPyMI39BbhgIqthYyFRC7DsSmwX2SGPSTLQ+tifamQywy8fgcuypikO4/USlOJUyKN86hpty/PR/Iwt8YbWbk1a/GL+Djt9TVzEvv1VRpTWQ+Gg8lJPLhUolh5enwDQes2tClh+LPI4F4DE6XBynJu4bJqZfAh8hSStKXTcTp7ekksD9fr+S49Tp7c0FagE/oeftSeLjPdceshTV735qJp6TBF2VJNloCqpdgzKZfbB9lnnBjV/H/DbiLnebOHWmMVWt5yLhaLxCRbfJtH8h7qk4Cc0wgwgpQHf9H4VRcIn15R7TCjZ+5MsQyNYJrqK9NamUewP7uvzSbYqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9zk4SJNSXoMOtTbfeDsEproOaAwlj/WxfuKFE5bVkI=;
 b=mj89gRkGX9UwLYcDXmagqz6B99ELD71LSLtyCBffuxLaQYW871UneLNVbMlBFDa9RwcRUFTCxB0ByIMnUtgLfN+z/GKC/zw5AOYepwyDQql7zQ4ExhKRXwcoFqt0wbLYXi2lKiSf4zjLAp5GoLk/AimRSRdkGIEUqC4Igb5YcZKrdw+tvFYYRdthC2Iw0MIaaOJliAmomTtRwCUAtd0l7DepDGTkqFxCiF1VP6yhiGQkQWqM6xJOh54ZOQwAs4dmGJ/EBT2y2wZZqDcjXESuD1lKl6F7I+kVRKk1VDjBmMDETlprDzSTs3LpFlI3UkGEOQ/xd8j9QiMYDYRR9ZyhBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9zk4SJNSXoMOtTbfeDsEproOaAwlj/WxfuKFE5bVkI=;
 b=l5TOVp3BqNV4OjKIPBmjg8txPELhOpVoctfQ4eMQrAsItt2T1Fg0hyroLPXkBuaqXfvJzkLyaVjAzcO4jnxkKzcS8I1I6zLoRTr2PhH12fuGn9MjIvNAWxS/oTDphN+UUL08Yrw4uyFRbf9/YSL/AYy0XbaiZqY0/cRqw8l/haU=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB5758.eurprd04.prod.outlook.com (2603:10a6:803:e7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Mon, 26 Oct
 2020 08:55:18 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3477.028; Mon, 26 Oct 2020
 08:55:18 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     hch@infradead.org, gregkh@linuxfoundation.org,
        sudeep.dutt@intel.com, ashutosh.dixit@intel.com, arnd@arndb.de,
        kishon@ti.com, lorenzo.pieralisi@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-imx@nxp.com, fugang.duan@nxp.com
Subject: [PATCH V4 0/2] Change vring space from nomal memory to dma coherent memory
Date:   Mon, 26 Oct 2020 16:53:33 +0800
Message-Id: <20201026085335.30048-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR0401CA0010.apcprd04.prod.outlook.com
 (2603:1096:3:1::20) To VI1PR04MB4960.eurprd04.prod.outlook.com
 (2603:10a6:803:57::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxp.ap.freescale.net (119.31.174.71) by SG2PR0401CA0010.apcprd04.prod.outlook.com (2603:1096:3:1::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Mon, 26 Oct 2020 08:55:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4e7edadd-4904-4d78-c2bc-08d8798cdcb2
X-MS-TrafficTypeDiagnostic: VI1PR04MB5758:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB5758AD54DDD6EC2B8F58715492190@VI1PR04MB5758.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5rr3yTj1CExWLrXLmYrTxYyLZtKqVLPfbwjB5T1pL8kig4iNlWakvJ0ZSfFJEOXrlN8TqkeuuxnRKm1x9SMdoByE+4OAZWYmnIAhRSH9/O+l/lUQtK0DXXoq4cnAik1k5I5qg57qPOKEVnmC+lOakybx30ilWis4YYGm0lPWfLtNMcu9PpLK4w9/NGJf3CukfUqcA1C7T+UbBG7pcscu2B76vqRlrqmX9tBRw4J+JskTl2m+NRc9fot4ThnG5zlCNDGY1X0mHMUT1+RjHyeZoUvdgpZH0uwasLnBYQbCYxONUdVQdn6jNlbX5kgINU6G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(66476007)(8936002)(316002)(86362001)(956004)(66946007)(36756003)(66556008)(6512007)(83380400001)(4326008)(2616005)(1076003)(6506007)(6666004)(2906002)(186003)(26005)(8676002)(6486002)(16526019)(5660300002)(52116002)(478600001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ugod1v2CyjkBhFMvyT1Dtu/XBcBeFCyiB205q/rgDci7e3f/taL0Ca3u+/TK/Ubo7m2VgAy6Jl6L4He4ih5aBO2ASqoTh/GqsBNkQMy8Eff/rKs+OwJp8M1dM9jYSqZK8WNCuGTeB4nvOVDuFn52Zr+xaUicErpJQS3XK8PhlYjWMEh4tzzMTsIGaX6WJO6WNJXOvBdmB+4OVPhe6CcYGxSb9OeY2bgyv5kvRhWjEA8W6yZ9nX1wqbNAUUREXItQdOcdWzcSlEh4Rl2NIOAOnJGNFG2m+YXJ+/6Vqe/gXrfaSBTmDgMT1+GliRkt0oYvxlAYLgJ10ZBPNvxpi1eAt0bxQNeoVBDnz0fXxHCwwk5D6SGm1R/47FB2i1ejzhdWYFvVozwDsxZCsHj0jLVejsjatE1nzEIQIQXXht453asBFAz7AA1gZ2fCdKUiwDFcNpg6raJeeTANxsEKw4eWqYTE43dDj+kgcYUI/U2OmzGj2E7Mk63BHcfOhbGclJh3FU1RD45TnXv+EBUcJ+pqEddncHPTVBiFr4MihSa3r5CUem81f8TLJebEPTwrUQfvxcljBVZMqlqHtV2qprlPJmxEQvePn5U9ObvzWE4g4xZi4QHDiHHRKo9KH8P9nYDqmCj11CsbjoCifafjXnsjpw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e7edadd-4904-4d78-c2bc-08d8798cdcb2
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 08:55:18.0868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FwjdHKGN4aToTVl1JSvV8aipCuCOI5hQPEEvf+0KJqmqf/Df11otscRD9PZD5caYaoIbqrTRSSFe0Iu6HupbiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5758
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes in V4:
1. Change to use dma_mmap_coherent api for vop mmap callback. 
2. Add dp_mmap callback to map device page to userspace instead of get_dp_dma
callback.
3. Move all the dma related changes to patch 1.  
4. Kill the mic_dp_init/mic_dp_uninit and inline those into the callers as
Christoph suggested.
5. Keep the code following the 80-character line rule.
6. Add endian swap for vqconfig[i].address. 

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

Sherry Sun (2):
  misc: vop: change the way of allocating vring and device page
  misc: vop: do not allocate and reassign the used ring

 drivers/misc/mic/bus/vop_bus.h     |   2 +
 drivers/misc/mic/host/mic_boot.c   |   9 +++
 drivers/misc/mic/host/mic_main.c   |  43 +++--------
 drivers/misc/mic/vop/vop_debugfs.c |   2 -
 drivers/misc/mic/vop/vop_main.c    |  51 +++----------
 drivers/misc/mic/vop/vop_vringh.c  | 110 +++++++++--------------------
 include/uapi/linux/mic_common.h    |   5 +-
 7 files changed, 66 insertions(+), 156 deletions(-)

-- 
2.17.1

