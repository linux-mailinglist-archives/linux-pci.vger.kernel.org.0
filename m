Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391D529579E
	for <lists+linux-pci@lfdr.de>; Thu, 22 Oct 2020 07:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502365AbgJVFH5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Oct 2020 01:07:57 -0400
Received: from mail-eopbgr60087.outbound.protection.outlook.com ([40.107.6.87]:51428
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2502363AbgJVFH5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Oct 2020 01:07:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMHPYLwQ3QvpWxnTQK1a2vuIU21EkOxUBqQR6EeLBDJ9wD7LGgeh4sMYZIt5peocx+14myupAPSpWSFO1h5PB+4OttT93cTkrkdjnl/7+eCUw8p7ZCMRbQyvntIUe2aGeD98mByNluxpekbcSr+VtpwMI/s6V5I/onXmnoaVP3RwoCfqRWQB/Y2HZuKEnIVavWK67D1FHnr63VnD58B7VWwkYevTGIcSfyHBbEwukPdrufGeIGAwWMk+YaRc9rF5PnKD2fcGoutCfxfPPQRwwhNJccpfaR5z/pqHjMDoQieZa6O8gydLyNo8eKUOEFFjQ0pzlWVVhOjT+n2smQkiCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhWzavHzUUf3Etfa6AUfZO/+ec8HBmp6Hu9AkAXnGAY=;
 b=TPEr8pR6pjYaTJcyWTRTi9KNUkRGhoyBU74IrCiH6iCB6cNCq3xa4Zpyw6ViVzze+CecDzelHnILiuWQFx/k0r6VQZtbbQiuhY7X3cle+kSAhI7LojSPMV70UMVoLBVZP+vuCOkPMXX0waq7lH14hM7gkDGTE224/wp0Lfs+CigP66z6AKmsrZUICGbqxon8XC9aXmEBn9OEGyHNFkRnzilth7mPDUfPsS4Y9Pz1X+3Th6PNsCcC9y2Xk9PK4gj5TMhg1h02buEap1QxskC9KYrtkEGs6aVn2ZT7eUJyGJdiiefdHJud63P116jAIahfFILauWZil3/uaAMzNcrsOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhWzavHzUUf3Etfa6AUfZO/+ec8HBmp6Hu9AkAXnGAY=;
 b=bV+cgipDyki9UCtgjIysvgWERRjxmsvGZ429DaGU4Xh3KQs33yzFJe7F8gUeJ17t4d67j4EMmF/7MruGUeGtps32yHLhaMPA9z+noyzSHAXU7WuS5AyqlSA9ERZZ9zSg/4eOuztJlGiQMVOOP3UCjSHb/lPc21wMamuvsFsYxoo=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR0402MB3358.eurprd04.prod.outlook.com (2603:10a6:803:11::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Thu, 22 Oct
 2020 05:07:52 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3477.028; Thu, 22 Oct 2020
 05:07:52 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     hch@infradead.org, sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, kishon@ti.com,
        lorenzo.pieralisi@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V3 0/4]  Change vring space from nomal memory to dma coherent memory
Date:   Thu, 22 Oct 2020 13:06:34 +0800
Message-Id: <20201022050638.29641-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR0601CA0012.apcprd06.prod.outlook.com (2603:1096:3::22)
 To VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxp.ap.freescale.net (119.31.174.71) by SG2PR0601CA0012.apcprd06.prod.outlook.com (2603:1096:3::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Thu, 22 Oct 2020 05:07:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b13e4230-2286-4b58-d1d9-08d876486d7f
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3358:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB33586D665A44BCE7CCB79A98921D0@VI1PR0402MB3358.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s2vhPI0p4S/15UGCU7XBAi6D+Tean7vHKTS5RE3SvPDOcbi/JHs3R19fis45KjuBA6rhLM7aelMHyvm34avGZd46g0jU9iC0rr6vfmrua5sqCaJZXM4j2QF7LH9quBgaA4180I+GC8ZUAOkIi9A19pkM94gwM8kDBSoXIl6n6jZFXgSYcvnWScQcWIx7UwCeZbGeVDcFY7h7X3HQ7dctMRC2xwAWF6DMD3hGH7N6904gQ5a+vT7uUjWWShpdj9nWcRy4a/IW/fxBsSbBfjG04od7m6ozj6RfztrvYp3YeVbDUYXbLMfOLjGOxk9KIt1ubPoKb3G42l8LJyWX9t27KuC7xfwzSyF9/o5kjl84dG7yOaJdhl4M3h8bM7fxXHgrqYqx14PRNrsfbuie675t8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(6486002)(6506007)(966005)(44832011)(2906002)(66476007)(66946007)(4326008)(83380400001)(86362001)(6512007)(316002)(2616005)(66556008)(956004)(1076003)(186003)(26005)(16526019)(478600001)(6666004)(8676002)(36756003)(52116002)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 9BwRR5WBCx8bFuH7lbTdDdKJqKaCakGi4XWsGuPWfHxuPOfx/D688ERMaGVVlmS3m+8/dxZBETjh37yyVbeOcrSUYsx30l81r3h3PiInC5TsoBzNH4Mday6dLRIBxy3M/pu26fyrWNSfSgCLFfIuGE2cQsP3tMXSrNxxnPvjstnzOfw0a0o5nQkafkSg63NstcLQVRvw8S66FDOe/40xyNnj0+VyPeJfZRW4uvXidY9V87p4400zjinS/35qIbHZFK4Wz0oZvh4Iz53wCs1aNbRKG1q8wjr7x3p5wWGYVDei58UjkksrhV+/ImmSLqAgO6J4FmWjv6rt7+nsoFvwziHI1VPvUyDtczFgfxLbzMDu9Zw7VyCIOp+yR9Z0H/m7ja/cF7ZrDMDjxe6AZHv2AinEVhFGFjHjyvUQeyIfM3JAvR3p74GCX/V9JUrlGSDDuqxlXePDjERWvcGDmUocGk0VKZBItpI1op5h4XoatmmkPjzANIVrXXQqJDk7n7PmU/YG/SPPcFh7IDLv1EWwzSl8WSbIKBMLj+4x/VxPuzniFFfa8R6jxqs5MjdK+Noc010FbhGI/RAKHl9gg2ekO2nj1qJeA28hVTWtpSAmjsLN6OaxpFm0dY1CwTJxem9u//iC8OD4RbIp1BtgoXJWzw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b13e4230-2286-4b58-d1d9-08d876486d7f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 05:07:52.2639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 91kQnHyhFRE7x/NavKuU0TAUE5caZUuyoZosSL5VjMmGIKamOnhtlfGFaE+r0BrVu/4TRNFAg3x+N8VWWvub2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3358
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes in V3:
1. Change the device page allocation method of the Intel mic layer in Patch 1 to
align with the vring allocation. 
2. Move the vring physical address changes in mmap callback from Prach 3 to 1.
3. Use must_be_zero instead of directly deleting used_address_updated in
Patch 2 to avoid the influence of ABI change.
(I tried to use dma_mmap_coherent api in Patch 4 as Christoph suggested, but
 met some issues explained here https://lore.kernel.org/patchwork/patch/1313327/,
 so there is no change to Patch 4, and still can't find a better way than
 patch 3)

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
  misc: vop: change the way of allocating vring and device page
  misc: vop: do not allocate and reassign the used ring
  misc: vop: simply return the saved dma address instead of virt_to_phys
  misc: vop: mapping kernel memory to user space as noncached

 drivers/misc/mic/bus/vop_bus.h     |  2 +
 drivers/misc/mic/host/mic_boot.c   |  8 +++
 drivers/misc/mic/host/mic_main.c   | 15 ++----
 drivers/misc/mic/vop/vop_debugfs.c |  2 -
 drivers/misc/mic/vop/vop_main.c    | 48 +++--------------
 drivers/misc/mic/vop/vop_vringh.c  | 84 +++++++-----------------------
 include/uapi/linux/mic_common.h    |  5 +-
 7 files changed, 42 insertions(+), 122 deletions(-)

-- 
2.17.1

