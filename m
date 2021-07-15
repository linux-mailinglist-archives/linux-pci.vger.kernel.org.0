Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314B43C9E3B
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jul 2021 14:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbhGOMLz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jul 2021 08:11:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36680 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229973AbhGOMLz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Jul 2021 08:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626350942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VueNy71C319SH8P9/tMFkGcyyqOLngYJs4y2xiGYU50=;
        b=gkD1kj72/hSKPD+4KR3SOubVcTBXthG7HvaFyUZGpheWgRQGtekscG5edLSAZUigFlQsFg
        Hcrc3HVova48eMLp9/F2wBjubR/+m8TzCp6Ba6flK74dpThZSej298pWsspWGKPwOP2ydX
        /uiUTVSRscI6tQJpAkZ05BwsFHFCwkM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-EqtUD8mEMvWqWBpD4ujVXA-1; Thu, 15 Jul 2021 08:08:59 -0400
X-MC-Unique: EqtUD8mEMvWqWBpD4ujVXA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D722C804142;
        Thu, 15 Jul 2021 12:08:56 +0000 (UTC)
Received: from localhost (ovpn-12-61.pek2.redhat.com [10.72.12.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F1D4660C13;
        Thu, 15 Jul 2021 12:08:51 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.de>,
        Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 0/3] blk-mq: fix blk_mq_alloc_request_hctx
Date:   Thu, 15 Jul 2021 20:08:41 +0800
Message-Id: <20210715120844.636968-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

blk_mq_alloc_request_hctx() is used by NVMe fc/rdma/tcp/loop to connect
io queue. Also the sw ctx is chosen as the 1st online cpu in hctx->cpumask.
However, all cpus in hctx->cpumask may be offline.

This usage model isn't well supported by blk-mq which supposes allocator is
always done on one online CPU in hctx->cpumask. This assumption is
related with managed irq, which also requires blk-mq to drain inflight
request in this hctx when the last cpu in hctx->cpumask is going to
offline.

However, NVMe fc/rdma/tcp/loop don't use managed irq, so we should allow
them to ask for request allocation when the specified hctx is inactive
(all cpus in hctx->cpumask are offline). Fix blk_mq_alloc_request_hctx() by
allowing to allocate request when all CPUs of this hctx are offline.


V4:
	- remove patches for cleanup queue map helpers
	- take Christoph's suggestion to add field into 'struct device' for
	describing if managed irq is allocated from one device

V3:
	- cleanup map queues helpers, and remove pci/virtio/rdma queue
	  helpers
	- store use managed irq info into qmap


V2:
	- use flag of BLK_MQ_F_MANAGED_IRQ
	- pass BLK_MQ_F_MANAGED_IRQ from driver explicitly
	- kill BLK_MQ_F_STACKING


Ming Lei (3):
  driver core: mark device as irq affinity managed if any irq is managed
  blk-mq: mark if one queue map uses managed irq
  blk-mq: don't deactivate hctx if managed irq isn't used

 block/blk-mq-pci.c      |  1 +
 block/blk-mq-rdma.c     |  3 +++
 block/blk-mq-virtio.c   |  1 +
 block/blk-mq.c          | 27 +++++++++++++++++----------
 block/blk-mq.h          |  8 ++++++++
 drivers/base/platform.c |  7 +++++++
 drivers/pci/msi.c       |  3 +++
 include/linux/blk-mq.h  |  3 ++-
 include/linux/device.h  |  1 +
 9 files changed, 43 insertions(+), 11 deletions(-)

-- 
2.31.1

