Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB9C9856A6
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2019 01:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388911AbfHGXvN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Aug 2019 19:51:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33603 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388123AbfHGXvN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Aug 2019 19:51:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so93153309wru.0;
        Wed, 07 Aug 2019 16:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=81W60zVYjF0WkGNMIxtxV/QpHZxdSDjYkRGFZyoC9NQ=;
        b=hhTHm5Nw3iub40WKb4H1rqVluoBt3pHck0QiywNeJGfgGNfnNjbzVrBPozkC5g8j9g
         8aab+mE+4ulrI+yy3QFobs6H3wCMogQfTTEjQ5LK3wee/MLE5uYV9hg9P3EWlEO24S4A
         GGcRJ0l3FkefLaW5R2D6+IUs60CB3RRjd630LA8qt65E0pXuyLQuHc03dYbuendzW8it
         7nEsYz/9xvm9+lK46TAYUqXDRS06we3dkaQ4lBBiwYFZJ6UCQRLZ6KAyHmrnHas1Yv09
         Fsrqehj9A5Sp6lSVWLuV7I3FdqXigC8Jlton0NbJR+TCmrH+wznz/IqijdnDjUtkTRZ5
         s6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=81W60zVYjF0WkGNMIxtxV/QpHZxdSDjYkRGFZyoC9NQ=;
        b=LKpF5+OiYEksh0PzBiWhy7Q1YNJ4NDKSKTUKT7gNlVSHI8hph8oLR9dU06xGQgQM1w
         t0drqBh0ZUkrio4CxDhmsVfs2nxI2z/YqYE+Wr/u9vuBFuhZBwUQnLBkiuKWOk4NRzMN
         Ud16RCNUsRS/usoAS03J7mUAQg2EZgf2/H6wXY27CNqyCZuncmnEzSgQSHKV2jLmO9bv
         1oFGSyR6NEd9a11C8Ou4U3LM++6tteTlXhTBa0XmueQAUY53Xw91j0YZyKPM9OEVEr7w
         6nDVTVW7tkfTvENZqB2y8+soGujoKx5SGRC4LJu89pHBwowfyI6RkYZMV2xlkuEuueTV
         383w==
X-Gm-Message-State: APjAAAX7oRodd1yh/CXhAjj92nTqVKybRtVWCm5tBMoTtSWfzCgPNffW
        6YfOa0BiMRsHns5A1Fr7HgSH8brNicnipIN3T8Q=
X-Google-Smtp-Source: APXvYqwt7F5BkB58H5wD984WMZT43ugAcQRwg0VeBjol0Scsm8pOYOWjbYcauyyRwVif41pglTfX8hitoIVSFX1lIAs=
X-Received: by 2002:adf:f088:: with SMTP id n8mr13084998wro.58.1565221870134;
 Wed, 07 Aug 2019 16:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190805011906.5020-1-ming.lei@redhat.com>
In-Reply-To: <20190805011906.5020-1-ming.lei@redhat.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Thu, 8 Aug 2019 07:50:59 +0800
Message-ID: <CACVXFVNn9wu2sU=47csi+stvzN0TnOV4E8xBHYknxo9uDksMuQ@mail.gmail.com>
Subject: Re: [PATCH] genirq/affinity: create affinity mask for single vector
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Thomas and Guys,

On Mon, Aug 5, 2019 at 9:19 AM Ming Lei <ming.lei@redhat.com> wrote:
>
> Since commit c66d4bd110a1f8 ("genirq/affinity: Add new callback for
> (re)calculating interrupt sets"), irq_create_affinity_masks() returns
> NULL in case of single vector. This change has caused regression on some
> drivers, such as lpfc.
>
> The problem is that single vector may be triggered in some generic cases:
> 1) kdump kernel 2) irq vectors resource is close to exhaustion.
>
> If we don't create affinity mask for single vector, almost every caller
> has to handle the special case.
>
> So still create affinity mask for single vector, since irq_create_affinity_masks()
> is capable of handling that.
>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: linux-nvme@lists.infradead.org
> Cc: linux-pci@vger.kernel.org
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Sumit Saxena <sumit.saxena@broadcom.com>
> Cc: Kashyap Desai <kashyap.desai@broadcom.com>
> Cc: Shivasharan Srikanteshwara <shivasharan.srikanteshwara@broadcom.com>
> Fixes: c66d4bd110a1f8 ("genirq/affinity: Add new callback for (re)calculating interrupt sets")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  kernel/irq/affinity.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> index 4352b08ae48d..6fef48033f96 100644
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -251,11 +251,9 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
>          * Determine the number of vectors which need interrupt affinities
>          * assigned. If the pre/post request exhausts the available vectors
>          * then nothing to do here except for invoking the calc_sets()
> -        * callback so the device driver can adjust to the situation. If there
> -        * is only a single vector, then managing the queue is pointless as
> -        * well.
> +        * callback so the device driver can adjust to the situation.
>          */
> -       if (nvecs > 1 && nvecs > affd->pre_vectors + affd->post_vectors)
> +       if (nvecs > affd->pre_vectors + affd->post_vectors)
>                 affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
>         else
>                 affvecs = 0;

Without this patch, kdump kernel may not work, so could you take a look
at this patch?

Thanks,
Ming Lei
