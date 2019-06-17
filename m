Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31D1748265
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 14:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfFQM2v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 08:28:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44024 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728206AbfFQM23 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jun 2019 08:28:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=a9DxKrjk6QhfPonTyrF2mzugaowpnIicUuVlQP+zq4o=; b=cb4e9uP9535wnLLOSnyqggTl8I
        82wOdiYWnYuuZDAUgSyu83ySmcMJojBjfZpU/s/pwummAkreTbFbiDHxAlfmBp5zlGTCnvwaEkK/L
        m1+oWm8zfvKdQd7GjZ0w1pVZLn03vSyh1IoQL4nXiuZP60/CtR4bs0Fm58kSyrWF4OpfS1kgWP6tx
        YnPl/xrcUiJCqrWQhwC7a/lCoLnzRnV06voZ+USZ2cbZhzpOyPZZwkkTeqQsbHiFvOxIVh2073+QJ
        QM/0SM6iEz4vo+RuWl6T+Yc7bPyaPv8+xdh1ViBq0agPBngSwftA/sRBlGXYsGYx+CFcC1b9d2sia
        w6ZGeIZw==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hcqkJ-0000Qu-Su; Mon, 17 Jun 2019 12:28:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     linux-mm@kvack.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 21/25] mm: mark DEVICE_PUBLIC as broken
Date:   Mon, 17 Jun 2019 14:27:29 +0200
Message-Id: <20190617122733.22432-22-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617122733.22432-1-hch@lst.de>
References: <20190617122733.22432-1-hch@lst.de>
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
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
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

