Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1B8143DEC
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 17:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbfFMPpa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 11:45:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33298 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731802AbfFMJno (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jun 2019 05:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=b0eW2dMKelYlLaleRf5bDKha7L0ij82/1V9DJV7UjR4=; b=LrHEjG0Kdxjb47axcEbnVJ75Oj
        CqNf25lmlVLOJfKQkF3m/Ep/P6iJD6MgQry617Z97k4733kia2UZW5iJya7hxNJbAcFnBT8XQs3jc
        CWcfMFVkye1tAeuYF/JO0acUBeHn7/aMj/pyCQL4Xz4x4RtvNpeoZBzNSKTz/doY+OwHfJZybszCK
        DxEJpuNXgqckVp+x3E/8EpTeHSGafD299qd+qeRl4D7XeirEUJDqvk16JkpnMnHgojP24ZnE9OVua
        8L7QeBf5I1C+3AfNY+yeF9mDvABdV472xMWynVzOzMDJZAQqG1CbAp246zQp9OX7BwYZax0tpQTMs
        15lD1mDA==;
Received: from mpp-cp1-natpool-1-198.ethz.ch ([82.130.71.198] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbMGi-0001ki-O6; Thu, 13 Jun 2019 09:43:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     linux-mm@kvack.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/22] mm: don't clear ->mapping in hmm_devmem_free
Date:   Thu, 13 Jun 2019 11:43:07 +0200
Message-Id: <20190613094326.24093-5-hch@lst.de>
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

->mapping isn't even used by HMM users, and the field at the same offset
in the zone_device part of the union is declared as pad.  (Which btw is
rather confusing, as DAX uses ->pgmap and ->mapping from two different
sides of the union, but DAX doesn't use hmm_devmem_free).

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/hmm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 0c62426d1257..e1dc98407e7b 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -1347,8 +1347,6 @@ static void hmm_devmem_free(struct page *page, void *data)
 {
 	struct hmm_devmem *devmem = data;
 
-	page->mapping = NULL;
-
 	devmem->ops->free(devmem, page);
 }
 
-- 
2.20.1

