Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F943D57A0
	for <lists+linux-pci@lfdr.de>; Mon, 26 Jul 2021 12:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbhGZJ4H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Jul 2021 05:56:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20526 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232202AbhGZJ4E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Jul 2021 05:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627295790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o8QnaCGDF3BF7Y7BK6EzAmp31UuvyDE4mhgWiZM2WuY=;
        b=jSeslw02p17I1bKtPZDoPxk6dnbnnNS+SwSgWyaWj5JTEhnrAz5oA84hy5UhcIunpxEM45
        uuq/Guh60of4Z/YYr3LeE/rvjFpk3EuZW1bMpIVZ8LZ/7cZWNWlxe/mpEKFd+PL3TALqG3
        cNGi2whwGbc+aRDI3mjSPoXHyJl/aCU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-nsY09kDSMHSe0UwCODYDcg-1; Mon, 26 Jul 2021 06:36:29 -0400
X-MC-Unique: nsY09kDSMHSe0UwCODYDcg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83332800D55;
        Mon, 26 Jul 2021 10:36:27 +0000 (UTC)
Received: from T590 (ovpn-13-107.pek2.redhat.com [10.72.13.107])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 242D660862;
        Mon, 26 Jul 2021 10:36:18 +0000 (UTC)
Date:   Mon, 26 Jul 2021 18:36:17 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH V3] genirq/affinity: add helper of irq_affinity_calc_sets
Message-ID: <YP6QIVNOVstFqvFn@T590>
References: <20210721014804.1059421-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721014804.1059421-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Thomas,

On Wed, Jul 21, 2021 at 09:48:04AM +0800, Ming Lei wrote:
> When driver requests to allocate irq affinity managed vectors,
> pci_alloc_irq_vectors_affinity() may fallback to single vector
> allocation. In this situation, we don't need to call
> irq_create_affinity_masks for calling into ->calc_sets() for
> avoiding potential memory leak, so add the helper for this purpose.
> 
> Fixes: c66d4bd110a1 ("genirq/affinity: Add new callback for (re)calculating interrupt sets")
> Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Can you take this patch if you are fine?


Thanks,
Ming

