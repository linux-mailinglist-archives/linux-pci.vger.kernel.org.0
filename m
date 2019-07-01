Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B16C5B4E4
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2019 08:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbfGAGU4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jul 2019 02:20:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48458 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbfGAGU4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jul 2019 02:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=T9L9b2qHusEgYVnEV0zNHhUWzUZ4CrAFpQ1lfd/2V3Q=; b=uEwsBCXo4kNVg1cdlTcZ6OQwT
        V77aSF2koYFI6fO6vmNmbj1w3NL5OsxXP8Se91mN/ixPBJrvWQUc7JNf4j04wFaAqTbKyFXgGLWRf
        wPuUarztGE18wV59Arf6P/hupXGoCTIBqLpufaY8xaGdkdvx/Q8VMLVv0tnLHEQJVeopYpSBh052p
        5Q+aQ3mlTS3dldfsf+ivaqpsFy5r8m2ioQmXyGeCdmrlloPdTFiVHFGaXTy7FbYp2E6CesRB0KFie
        YdOBWrDVTPdo++UTICIQeUq8omxGj/sgWAsDoFZS8ib0Snh1C8z7FE5HiEOrigdW0jlsGYSDAMqZF
        uRNOJPWrA==;
Received: from [46.140.178.35] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hhpgK-00032M-0s; Mon, 01 Jul 2019 06:20:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH 13/22] mm/hmm: Use lockdep instead of comments
Date:   Mon,  1 Jul 2019 08:20:11 +0200
Message-Id: <20190701062020.19239-14-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701062020.19239-1-hch@lst.de>
References: <20190701062020.19239-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

So we can check locking at runtime.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
Acked-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Philip Yang <Philip.Yang@amd.com>
---
 mm/hmm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 1eddda45cefa..6f5dc6d568fe 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -246,11 +246,11 @@ static const struct mmu_notifier_ops hmm_mmu_notifier_ops = {
  *
  * To start mirroring a process address space, the device driver must register
  * an HMM mirror struct.
- *
- * THE mm->mmap_sem MUST BE HELD IN WRITE MODE !
  */
 int hmm_mirror_register(struct hmm_mirror *mirror, struct mm_struct *mm)
 {
+	lockdep_assert_held_exclusive(&mm->mmap_sem);
+
 	/* Sanity check */
 	if (!mm || !mirror || !mirror->ops)
 		return -EINVAL;
-- 
2.20.1

