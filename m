Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 674D648201
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 14:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbfFQM1p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 08:27:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42412 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFQM1p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jun 2019 08:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PvDb2Ox1k4dZazYGdHDZANbuB1HI2/N93WOg6eXhjAQ=; b=sb1bPHYSDLwe702WgBPwsLs+J0
        vhPm0vc39IREraw5fNiKWwVi9b2XYJL8w6l2OeJY6AgdG8fPQh63r1aibZKvGoX4P777qmADQIXze
        OYKNAjycAzImv4MUUNJ1Sv6fOnX95UP0Tu509ppILxE5n4d614sDWPMcRXsHXnhq1gEXEUCA1AvUq
        OqgqDRRmXt/AFAdHkWOVd0/MMaDaR60es8wSgvkI32aP283KFFhUOZkJ79kLqoS/P/7e6eF2EVA7o
        0cDAzMOCQw8d61JCfYZgkqA5mYDhyXUXH6xL/G5qSJueB/oc/v0KwCGT+woKWUhfY5a9eI/qAtVq6
        jjs4LpNQ==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hcqjb-0008KG-Cp; Mon, 17 Jun 2019 12:27:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     linux-mm@kvack.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/25] mm: remove the unused ARCH_HAS_HMM_DEVICE Kconfig option
Date:   Mon, 17 Jun 2019 14:27:09 +0200
Message-Id: <20190617122733.22432-2-hch@lst.de>
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
---
 mm/Kconfig | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index f0c76ba47695..0d2ba7e1f43e 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -675,16 +675,6 @@ config ARCH_HAS_HMM_MIRROR
 	depends on (X86_64 || PPC64)
 	depends on MMU && 64BIT
 
-config ARCH_HAS_HMM_DEVICE
-	bool
-	default y
-	depends on (X86_64 || PPC64)
-	depends on MEMORY_HOTPLUG
-	depends on MEMORY_HOTREMOVE
-	depends on SPARSEMEM_VMEMMAP
-	depends on ARCH_HAS_ZONE_DEVICE
-	select XARRAY_MULTI
-
 config ARCH_HAS_HMM
 	bool
 	default y
-- 
2.20.1

