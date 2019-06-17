Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B90264823C
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 14:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfFQM1q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 08:27:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42416 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbfFQM1p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jun 2019 08:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IiaLcJALEKaB7Li7OAHwGVaUV7J5HHtfGyRFzVhVT5I=; b=nRxanBbFaXKRrfonPCdCK8x8a
        H13NLWpT/FYGEMhPawtjpKXuuFd5AsVGls0FU/bFblMxeQyfmVpGkj8pGsbrVCCWMJWTllTMnGpqR
        lLvHY6XYJAnUlu8naiV+ey/kfflUSIzdOe46iLEfPoDAcpWQgUXfY+Hmls32zlkAUygawRFXkMCHP
        wYZFnLlYcqST58xEgFnwklfAMQdGemLG8MCW+sf8MPt5vq44TqtytxlspPlDutukXjQTeeXjgmomc
        DBnAvx70XsOhTxq4s1gUZqpsTkLMt1yioXaF7KDQUOS+v7Psp7YyIakjW17TKDyANImlYyLvulA8s
        Kdy4HvCiw==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hcqjZ-0008K6-5z; Mon, 17 Jun 2019 12:27:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     linux-mm@kvack.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: dev_pagemap related cleanups v2
Date:   Mon, 17 Jun 2019 14:27:08 +0200
Message-Id: <20190617122733.22432-1-hch@lst.de>
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

Note: this series is on top of the rdma/hmm branch + the dev_pagemap
releas fix series from Dan that went into 5.2-rc5.

Git tree:

    git://git.infradead.org/users/hch/misc.git hmm-devmem-cleanup.2

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/hmm-devmem-cleanup.2

Changes since v1:
 - rebase
 - also switch p2pdma to the internal refcount
 - add type checking for pgmap->type
 - rename the migrate method to migrate_to_ram
 - cleanup the altmap_valid flag
 - various tidbits from the reviews
