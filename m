Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E91A3EC264
	for <lists+linux-pci@lfdr.de>; Sat, 14 Aug 2021 13:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238329AbhHNLf6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Aug 2021 07:35:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48166 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238053AbhHNLf6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 Aug 2021 07:35:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628940929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ytaw1btXTRYpOhRjjIp1sa0PYsESOsdI5TYKOfQeXXo=;
        b=UpBUY+haRIXXuTeDdW9cDyvBitc34h7gNN556jcb3mKn2Jp/v3vca7lCGI5CCFm1gHGtUm
        qp6/kTgND3yOgZfUyJfkgtEPtuBNID3FaOHoDlR/UEHj3tVqyYCzU+gkGuxlx7hB5vofzo
        9YuLOGE1iI0wlnNqs9PQGF3CgS68tnE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-R9a5U1A0NLipksrsrze6lQ-1; Sat, 14 Aug 2021 07:35:27 -0400
X-MC-Unique: R9a5U1A0NLipksrsrze6lQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3266EC7400;
        Sat, 14 Aug 2021 11:35:26 +0000 (UTC)
Received: from T590 (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E0ACF272B8;
        Sat, 14 Aug 2021 11:35:18 +0000 (UTC)
Date:   Sat, 14 Aug 2021 19:35:13 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [RESEND PATCH V3] genirq/affinity: add helper of
 irq_affinity_calc_sets
Message-ID: <YReqcQ4yvmJm5eER@T590>
References: <20210806081937.300166-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806081937.300166-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 06, 2021 at 04:19:37PM +0800, Ming Lei wrote:
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
> ---
> V3:
> 	- avoid pointless negations
> V2:
> 	- move WARN_ON_ONCE() into irq_affinity_calc_sets
> 	- don't install default calc_sets() callback as suggested by
> 	Christoph

Hello Thomas,

Can you take a look at this patch?

Thanks, 
Ming

