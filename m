Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BECA43DB1
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 17:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbfFMPo2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 11:44:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33588 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731822AbfFMJoZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jun 2019 05:44:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CRiADhhFQCJg9nNjQAj6fEu4785skzNOaJQJ8kIUJ84=; b=RICVtgPD9yRZZLP5zsYav1rSx/
        4WdeVXj2hZit21ZRFFahZ0/Xb9mrzF4vFMbjwhHwZzDxsHyjhAYAjmS4CGJjsNQ74TT7TZO+AoiA8
        +ykg9PdHRyJwz/zj0+/7ArN0Je2Zw3qhosZvIyWbnFjQtkiduRtXyxNYuw04kKoGUORMz6fHpxLtZ
        YTsDeVucQ5ychr3mWksaSDMicYxSgVYHcYqX1CuoizhG/ngsFEwRbS6GP4xrZvfELvZso8ubWK1Qy
        sTIETQwqU64lawnEds6n1N2gMvIX74tlW7hKHlfT8cTH89GLpVOhPBfu2I9eGuksdH2m3MVGivwF/
        Hf1LW1Lg==;
Received: from mpp-cp1-natpool-1-198.ethz.ch ([82.130.71.198] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbMHM-0001vf-Vf; Thu, 13 Jun 2019 09:44:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     linux-mm@kvack.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 18/22] mm: mark DEVICE_PUBLIC as broken
Date:   Thu, 13 Jun 2019 11:43:21 +0200
Message-Id: <20190613094326.24093-19-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613094326.24093-1-hch@lst.de>
References: <20190613094326.24093-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The code hasn't been used since it was added to the tree, and doesn't
appear to actually be usable.  Mark it as BROKEN until either a user
comes along or we finally give up on it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index 0d2ba7e1f43e..406fa45e9ecc 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -721,6 +721,7 @@ config DEVICE_PRIVATE
 config DEVICE_PUBLIC
 	bool "Addressable device memory (like GPU memory)"
 	depends on ARCH_HAS_HMM
+	depends on BROKEN
 	select HMM
 	select DEV_PAGEMAP_OPS
 
-- 
2.20.1

