Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099823381D1
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 00:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhCKXtC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Mar 2021 18:49:02 -0500
Received: from ale.deltatee.com ([204.191.154.188]:49292 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbhCKXss (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Mar 2021 18:48:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=uc5bXdFjfzszbviuSRD0/nYF6yd83ZtY9+zFkxPv3to=; b=csakyDP9QELnHiJJt/bc3YHT5J
        MoHtqOwNirvsD4AKK/wAoHQc1OcPqyxDLj6E6XbXXUlFNW8j0LFHY9i4+0dHbeSg2ntbrL+pi1i1j
        eZgg3PZ5kKt2v2KRZww13squhr+psIVilPV8ssOeCYlImV6asqMxmsdVVlevyQ2g4RTUO3Gs5m962
        z2F1pS21nxt6uZzoVlb+9gSM1CZY/0Xh44C+NtzUIfHZPsMv/U0L/phcr8dTwoMmZ7ngxqPQCkfhn
        I5tPDsWoFxgDPV9tg1liF/lEyAEWDpXgxSWtEnSpoGLd0s/0dx4NQ/GOD4GT+AT6+UVa8Dq2T5t5L
        11sJaiZw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1lKUmf-0003ev-OY; Thu, 11 Mar 2021 16:32:02 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1lKUmX-00024k-0x; Thu, 11 Mar 2021 16:31:53 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Ira Weiny <iweiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 11 Mar 2021 16:31:39 -0700
Message-Id: <20210311233142.7900-10-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210311233142.7900-1-logang@deltatee.com>
References: <20210311233142.7900-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de, jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, dan.j.williams@intel.com, iweiny@intel.com, andrzej.jakowski@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_NO_TEXT autolearn=no autolearn_force=no version=3.4.2
Subject: [RFC PATCH v2 09/11] block: Add BLK_STS_P2PDMA
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Create a specific error code for when P2PDMA pages are passed to a block
devices that cannot map them (due to no IOMMU support or ACS protections).

This makes request errors in these cases more informative of as to what
caused the error.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 block/blk-core.c          | 2 ++
 include/linux/blk_types.h | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index fc60ff208497..2cc75b56ac43 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -192,6 +192,8 @@ static const struct {
 	[BLK_STS_ZONE_OPEN_RESOURCE]	= { -ETOOMANYREFS, "open zones exceeded" },
 	[BLK_STS_ZONE_ACTIVE_RESOURCE]	= { -EOVERFLOW, "active zones exceeded" },
 
+	[BLK_STS_P2PDMA] = { -EREMOTEIO, "P2PDMA to invalid device" },
+
 	/* everything else not covered above: */
 	[BLK_STS_IOERR]		= { -EIO,	"I/O" },
 };
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index db026b6ec15a..728a0898cb34 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -142,6 +142,13 @@ typedef u8 __bitwise blk_status_t;
  */
 #define BLK_STS_ZONE_ACTIVE_RESOURCE	((__force blk_status_t)16)
 
+/*
+ * BLK_STS_P2PDMA is returned from the driver if P2PDMA memory fails to be
+ * mapped to the target device. This is a permanent error and the request
+ * should not be retried.
+ */
+#define BLK_STS_P2PDMA		((__force blk_status_t)17)
+
 /**
  * blk_path_error - returns true if error may be path related
  * @error: status the request was completed with
-- 
2.20.1

