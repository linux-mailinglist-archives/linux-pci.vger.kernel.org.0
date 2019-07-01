Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA8B55B495
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2019 08:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfGAGUa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jul 2019 02:20:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48128 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfGAGUa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jul 2019 02:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6xqIf0xVqrmwyuBYUV8qbkcY4fEJxDo5YYvPGQNv0Dg=; b=GnFpJ4/Oc/100n/wlMN0yyuTT
        qBVa3bbru2+kI55sKA82ZcwWbugtiuZLwkxnhpe5470h26XmfvTn4dShhCGDC99YkHXONgWcU6z0S
        5t/erBmlFFzhqv1WZ+ZnfPaiEb7cET33XrkX7TjbDP0GDKX4lTAs35mFDMwJwFFJXsTbjCCnz9Qsb
        T3LnzxrWgwM+9wArnuvCnRPC5yeDP07v4E+ncJnB+zriXMvtCe7R2MCuImkRo0lDXVWrImhTs8/Hp
        vF2SD1TvWGF7X/3d5CVihaeKKlUv9boEcAw2xU/YcQWyjar7krBJ5gs3T6qNDPoM5TghNpS8HWW4h
        KPFEdN94g==;
Received: from [46.140.178.35] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hhpfq-0002sH-DB; Mon, 01 Jul 2019 06:20:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: dev_pagemap related cleanups v4
Date:   Mon,  1 Jul 2019 08:19:58 +0200
Message-Id: <20190701062020.19239-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Dan, Jérôme and Jason,

below is a series that cleans up the dev_pagemap interface so that
it is more easily usable, which removes the need to wrap it in hmm
and thus allowing to kill a lot of code

Note: this series is on top of Linux 5.2-rc6 and has some minor
conflicts with the hmm tree that are easy to resolve.

Diffstat summary:

 34 files changed, 379 insertions(+), 1016 deletions(-)

Git tree:

    git://git.infradead.org/users/hch/misc.git hmm-devmem-cleanup.4

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/hmm-devmem-cleanup.4


Changes since v3:
 - pull in "mm/swap: Fix release_pages() when releasing devmap pages" and
   rebase the other patches on top of that
 - fold the hmm_devmem_add_resource into the DEVICE_PUBLIC memory removal
   patch
 - remove _vm_normal_page as it isn't needed without DEVICE_PUBLIC memory
 - pick up various ACKs

Changes since v2:
 - fix nvdimm kunit build
 - add a new memory type for device dax
 - fix a few issues in intermediate patches that didn't show up in the end
   result
 - incorporate feedback from Michal Hocko, including killing of
   the DEVICE_PUBLIC memory type entirely

Changes since v1:
 - rebase
 - also switch p2pdma to the internal refcount
 - add type checking for pgmap->type
 - rename the migrate method to migrate_to_ram
 - cleanup the altmap_valid flag
 - various tidbits from the reviews
