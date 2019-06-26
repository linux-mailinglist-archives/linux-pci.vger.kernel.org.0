Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A394256931
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2019 14:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfFZM3Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jun 2019 08:29:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42618 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfFZM1n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jun 2019 08:27:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YGx69ktqFfd50Mnd66pLKlz3uikDiZWUcfJ3jfUuvQk=; b=e05g33Wex+0CQQ9qi04aK+PPD
        72YJJQlOybfiI5HDpvAwNw3qyS9BQ2WnPDw3YMr+fSZN7R9d4Tn5T/Kg6qLvyaoDaHQZ0vlVbYbhx
        sH7r9sk7n9uAVs7ytRQPMUWtpIBu34n75RQsdX09ZN7vTlq63SjgxFL3+W2CGRZnbY4b1uq2QoXC9
        wfCap12FyOEmQpV3o8HSsJ+3sDUypgYRRenguNdBNIJhO4plDWVryg6VP0j/VmweKz3YUcCgDWjkR
        wJkxMMcljSkpHVx1W9E80XqfefYKjbk4v/9jvt3SU/bAHja9Xecuu8HugJFvBvJ02cUDAF0fQb/UW
        LymOmxY1g==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hg71L-0001Kf-Nf; Wed, 26 Jun 2019 12:27:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     linux-mm@kvack.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: dev_pagemap related cleanups v3
Date:   Wed, 26 Jun 2019 14:26:59 +0200
Message-Id: <20190626122724.13313-1-hch@lst.de>
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

Note: this series is on top of Linux 5.2-rc5 and has some minor
conflicts with the hmm tree that are easy to resolve.

Diffstat summary:

 32 files changed, 361 insertions(+), 1012 deletions(-)

Git tree:

    git://git.infradead.org/users/hch/misc.git hmm-devmem-cleanup.3

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/hmm-devmem-cleanup.3


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
