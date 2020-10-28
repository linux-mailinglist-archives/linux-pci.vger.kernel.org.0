Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8605729D559
	for <lists+linux-pci@lfdr.de>; Wed, 28 Oct 2020 23:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbgJ1WAH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 18:00:07 -0400
Received: from mail-eopbgr150083.outbound.protection.outlook.com ([40.107.15.83]:61238
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729289AbgJ1V71 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Oct 2020 17:59:27 -0400
Received: from VI1PR04MB3229.eurprd04.prod.outlook.com (2603:10a6:802:e::30)
 by VI1PR04MB4750.eurprd04.prod.outlook.com (2603:10a6:803:61::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Wed, 28 Oct
 2020 17:27:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbJRLO04r2brdtkRAAjam+Um+bhVfoARqpL7fiuiwwoZ0bmZfrsiBs91o5MzOu6gmInK9xwY/Y8iwpOxHcb1FH3pW8fo1CgMlx5BQSZrtoLWphQSSahqcuhFwF5EfvV3hoedHJsgxaJabVEYv4xLIjKB5JCchHz7jPpGcvbfJJfOI0TyxhKcuLxjm5Ag9CMTv9bBvi3gVjzG5Pi3dh7OR/JV8HbWJUeGLR/+udmJZPH+mW4KZN2w0JWA1hSDLi9H2t8/DI7M8fRby/eZAYCXNuC3MHbSs/zGqPuzTEsubk4P/iRJUCfWGV/4dCaBBFtF0k1/2CdMcviR7dMSRCxqzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fv1/vLYCEx/M/60dkihgJd1oyFlsp2TDB8DCbRYz0bs=;
 b=lUVProCpVeDoTMdR9wJC7YXGfOqu/eXt2SyEHpKgImE3l5Drn6dIaoqawihhf2yqoAQ3/cywiHzA4QRqj1xK4caG0YyCkbiC8RV+Cbd0L6JvzcYgJ94hJ7wohIP7/HvQjNU++Aro1fVn4vcKtpRYEwiIyYlEt24wKsZZAXVgEsKsuZyTJXHSoenxNov7PO1JPOTmfG4Cop1Rr7ryWSLmBSN9fFl2WCNztzXQlVDUT6f51ptmeBA3kLwHv/+nzIfZ1ZWPAYYNyCLRQ6SHZnknsjYDHGvtBUpDvdyjBwiLAo3tTKsaRrJgOkDQijNzMwqz8g11jaCqlnEgZOmS+DId/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fv1/vLYCEx/M/60dkihgJd1oyFlsp2TDB8DCbRYz0bs=;
 b=fiWHGqChr8UtuvtIu6wgXrg7aifQHbPr+qOxq6sTlG95Z4rGAJI6yT0lzXj3NvblDoM8Edm/jEWB4zak14+0tFWT1AUVoFk8tfgVxkE+Twg5CfksyFdZDjsJJRskoq/anoEp8ToHPV7mTxqY5TXLUvdltR5b5UG7aZfiEbIn2AM=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB3229.eurprd04.prod.outlook.com (2603:10a6:802:e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.28; Wed, 28 Oct
 2020 02:04:11 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3477.028; Wed, 28 Oct 2020
 02:04:11 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     hch@infradead.org, gregkh@linuxfoundation.org,
        vincent.whitchurch@axis.com, sudeep.dutt@intel.com,
        ashutosh.dixit@intel.com, arnd@arndb.de, kishon@ti.com,
        lorenzo.pieralisi@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-imx@nxp.com, fugang.duan@nxp.com
Subject: [PATCH V5 0/2] Change vring space from nomal memory to dma coherent memory
Date:   Wed, 28 Oct 2020 10:03:03 +0800
Message-Id: <20201028020305.10593-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: AM0PR03CA0088.eurprd03.prod.outlook.com
 (2603:10a6:208:69::29) To VI1PR04MB4960.eurprd04.prod.outlook.com
 (2603:10a6:803:57::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxp.ap.freescale.net (119.31.174.71) by AM0PR03CA0088.eurprd03.prod.outlook.com (2603:10a6:208:69::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 02:04:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 52a4ca7c-5563-4c23-6b45-08d87ae5c346
X-MS-TrafficTypeDiagnostic: VI1PR04MB3229:|VI1PR04MB4750:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB3229FA9EAC86813756F1E4CF92170@VI1PR04MB3229.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l+u5WS1dZcvEHQ6xOoYtW/ZQhb29czU1qvqYZaPgDqV5yULHmqT4i7kvXUeP1wiFL9l0mTaQ5+uvljC7a/YM+Q4vnzo4NV9UKnIhpZSvBfgUUC+mtKvpm0jeBkSiILLPwKoKpsdTtkSrkow+NZ+ZMEAua2ahrwXipaHqInyZ5Cy/5+yygrs6oaNUQmyVftp4CtO34vG7cG36vNUzsldK/iCpdf2wSk4HerIlnbBLNqSeMzxgFCa5FWKyLcBVahzAfUrJCVsIzin8ppwi+2RE9vpDRJsTCjlLLKYBKHYw1xlAekWimd7njt3jeI218BaWIK7i2h0OzsSmkyM4pjq8yQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(36756003)(2616005)(1076003)(44832011)(52116002)(2906002)(26005)(6506007)(478600001)(956004)(8936002)(83380400001)(16526019)(86362001)(8676002)(4326008)(316002)(5660300002)(186003)(7416002)(6512007)(66476007)(6666004)(66556008)(6486002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: IiCMSCkKQlTPj++Q4oXzMQiHfgVSd+kIWIpxkhqT4pe/vQcK3VUKmxnoQk/XVt9grJ+ZFAclZLMYpaxv3KeM5PVWd4E7gbVOBZ9mmIZI4rBTD734Lld1uCsPf/+cerqtLV+fOXJK8BS05mmfZNlsqArTcrvCaEuhDsmhgGMnMYnWvDJB6eJFrA6oeymKqMQCRdAZ7NBnvTXO5c6E9bGZdeA2Hx2H1Xs4uzfOLuAW6NdT6cVXFO1B34sfDwRDAHPTwFq6MohnO+7DfZRhpWoV2tw4/tdtMnPqqzNvKR2b51txCfC0EqEmh8Dk5gmsPlfvLueXXmBbqWWU1qD2jGXNv3kQc766Q8AxtJuHBrcxt5R1IncxBTUoZU09a/pJAbYb9F+c9M/3ZlAI6Ve7V0tOFNR8ZqZSwlq6Gc24KHa3+WLYF2M7BwdQbRCUiCD9i4ohe9ZFHSAvleIEG9Ck4Vxcjs5ojOLV8Q+aWggs7vovyvhCQUGzcdnDNvbOQMMleU42+YEAfhHrx2tKRvMwf3joMHe7hmsDagYRjPbxf4GZzBMIZTEaklPt/q2qHAWPY2F+MBA10Q38YfxsPb3gMbh24XoMyqLfk4Rit2J7621IvaskwxSYxF0MSFUV9snSjV6zpafHtVGVkp8EryScKcy4Dg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a4ca7c-5563-4c23-6b45-08d87ae5c346
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 02:04:11.8734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6zudVdykMeo8ryd/gVo8i0JOJp+iQiIoLhCqsVl8gVO+8T4nuMap3+6PmH3Y7oBkrVVxt0delGY6LGDdiGlfPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3229
X-OriginatorOrg: nxp.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes in V5:
1. Reorganize the vop_mmap function code in patch 1, which is done by Christoph. 
2. Completely remove the unnecessary code related to reassign the used ring for
card in patch 2.

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
  misc: vop: change the way of allocating vrings and device page
  misc: vop: do not allocate and reassign the used ring

 drivers/misc/mic/bus/vop_bus.h     |   2 +
 drivers/misc/mic/host/mic_boot.c   |   9 ++
 drivers/misc/mic/host/mic_main.c   |  43 ++------
 drivers/misc/mic/vop/vop_debugfs.c |   4 -
 drivers/misc/mic/vop/vop_main.c    |  70 +-----------
 drivers/misc/mic/vop/vop_vringh.c  | 166 ++++++++++-------------------
 include/uapi/linux/mic_common.h    |   9 +-
 7 files changed, 85 insertions(+), 218 deletions(-)

-- 
2.17.1

