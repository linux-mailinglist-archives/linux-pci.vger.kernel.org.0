Return-Path: <linux-pci+bounces-7369-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9FB8C2B35
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 22:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6D2B1F256FB
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 20:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085F04F881;
	Fri, 10 May 2024 20:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="E+GZi+cv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431DF288D1
	for <linux-pci@vger.kernel.org>; Fri, 10 May 2024 20:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715373434; cv=none; b=GE/ZtnkdUA8+lajs3XrjE6227bv4YajdH4A1zAV4fymfxp/SibSR9nJlTZDFNKW9sf5YHeXpCfQR0RhoQH4xbMOf/w4MjXak+u1brJs/lwCD4I6MMPmVZcyHCY+/Ve6VbTGAX482z5w1Ta+yEB1yNIxJjoxmFDWp4KK5WcEDN0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715373434; c=relaxed/simple;
	bh=soWc4IEDHuaWuKfQxQunEhBG0jXJIdZ7DForSA5/30o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJvXSUj5UhN3ZZ3tGCM05G+jQK4/a5XhTKSeU4QItKpe6Vi9+csPhjaZ2qG+y2ZcWsFjXMvLdoK78EeKb5NZayY85+p6/VY9+iZtgSKxNM1SlOBeA9B32fr+koyz+Q7eZVtRXaY5xXTT1Xq+XYGYtgUwp0yAB5MCTHdTuvZ7Zjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=E+GZi+cv; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-434c695ec3dso14274611cf.0
        for <linux-pci@vger.kernel.org>; Fri, 10 May 2024 13:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1715373431; x=1715978231; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xhdl6rJNLlf5uJgnXjIjjuBOlYowvBqM3grROZJSB4k=;
        b=E+GZi+cv2ly6EcBIhHyJMmytFtEw/Bm+CWIhbVCZBuswwwEkVdWisQD8eWQjAgDjZD
         8uxuvFFlJGUx47TdlOrD/jxHB358QhXkxUGU1QFa+1sIP9GEvg1YXXmzb7kXyo9zPkRV
         o+HXcxmXmatfiVeYP3W6aJjkuExLOOKY8v1ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715373431; x=1715978231;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xhdl6rJNLlf5uJgnXjIjjuBOlYowvBqM3grROZJSB4k=;
        b=rXwZsk2p0vCjknakMOYkbrPYnl0AVlqbuUTF3Y17tleXvSFes33djSyR4mhjyoql1b
         FR0VwjEtBUgH1S3cVaHn4svuhYDoNZHd4/hfRCXtPDZDtZodwNpkJMTttLG0eMePixq0
         h0X0bKfwjxAvaLnYfOjVJ4PEzVufuXz999v4bz7kFM9gBmCOPj6II8QzvjXXG3SZ6gO0
         B3HcGnAC1vfNJo9U628IUuR/+Lj1DRpW6/d1uPwxwrQUqj2lpvG8N1r1y3L13rgglLkI
         VXN9+FRUefwJEbUWuWGqxddi8f7zsqQFgKaD6sWKNBs1hoBlTR+J1v9a0bqKWxP/zCTS
         tL+w==
X-Forwarded-Encrypted: i=1; AJvYcCV+5A7bzM60g8dd1nXp75re5hXj7wyWMwFXOSyQcKyaVktTsPXfeMXXtH/RkDyFO93FS3a+xmE8AgsFdn1ux8N0Qr4EWkAWOAno
X-Gm-Message-State: AOJu0Yz5GSCs2a88Tk1z0cXAZ0LxL3s09KivdDsWXsN1Y32wVj9RerRe
	q5SmWDIleJqKNFuIE3vaVZNFupgfDkTpv/xLrI04/mi0abkat/k0TgHoOJGBTA==
X-Google-Smtp-Source: AGHT+IGDzlofd6WAZhQ4JPfcPSjF/Nsjq3LZD69cWUFtPM+Om6AmASsCfdD/ablWnXCGJWyF72yHdg==
X-Received: by 2002:a05:622a:6:b0:43a:cfc5:9cdf with SMTP id d75a77b69052e-43dfdaf47ebmr32233751cf.32.1715373431081;
        Fri, 10 May 2024 13:37:11 -0700 (PDT)
Received: from C02YVCJELVCG.dhcp.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df54f5c72sm25132951cf.36.2024.05.10.13.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 13:37:10 -0700 (PDT)
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
X-Google-Original-From: Andy Gospodarek <gospo@broadcom.com>
Date: Fri, 10 May 2024 16:37:08 -0400
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Ajit Khaparde <ajit.khaparde@broadcom.com>,
	Wei Huang <wei.huang2@amd.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org, bhelgaas@google.com, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, alex.williamson@redhat.com,
	michael.chan@broadcom.com, manoj.panicker2@amd.com,
	Eric.VanTassell@amd.com
Subject: Re: [PATCH V1 8/9] bnxt_en: Add TPH support in BNXT driver
Message-ID: <Zj6FdAb34o1-GNeV@C02YVCJELVCG.dhcp.broadcom.net>
References: <20240509162741.1937586-1-wei.huang2@amd.com>
 <20240509162741.1937586-9-wei.huang2@amd.com>
 <868a4758-2873-4ede-83e5-65f42cb12b81@linux.dev>
 <CACZ4nhuBMOX8s1ODcJOvvCKp-VsOPHShEUHAsPvB75Yv2823qA@mail.gmail.com>
 <4c6a8b86-6544-4c99-a0f2-030e2ec4e98f@linux.dev>
 <Zj48BPYoFU1ISaiL@C02YVCJELVCG.dhcp.broadcom.net>
 <da52a255-e92c-48ac-bb30-02df2e86f119@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da52a255-e92c-48ac-bb30-02df2e86f119@linux.dev>

On Fri, May 10, 2024 at 09:33:46PM +0100, Vadim Fedorenko wrote:
> On 10/05/2024 16:23, Andy Gospodarek wrote:
> > On Fri, May 10, 2024 at 11:35:35AM +0100, Vadim Fedorenko wrote:
> > > On 10.05.2024 04:55, Ajit Khaparde wrote:
> > > > On Thu, May 9, 2024 at 2:50 PM Vadim Fedorenko
> > > > <vadim.fedorenko@linux.dev> wrote:
> > > > > 
> > > > > On 09/05/2024 17:27, Wei Huang wrote:
> > > > > > From: Manoj Panicker <manoj.panicker2@amd.com>
> > > > > > 
> > > > > > As a usage example, this patch implements TPH support in Broadcom BNXT
> > > > > > device driver by invoking pcie_tph_set_st() function when interrupt
> > > > > > affinity is changed.
> > > > > > 
> > > > > > Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> > > > > > Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> > > > > > Reviewed-by: Wei Huang <wei.huang2@amd.com>
> > > > > > Signed-off-by: Manoj Panicker <manoj.panicker2@amd.com>
> > > > > > ---
> > > > > >     drivers/net/ethernet/broadcom/bnxt/bnxt.c | 51 +++++++++++++++++++++++
> > > > > >     drivers/net/ethernet/broadcom/bnxt/bnxt.h |  4 ++
> > > > > >     2 files changed, 55 insertions(+)
> > > > > > 
> > > > > > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > > > > > index 2c2ee79c4d77..be9c17566fb4 100644
> > > > > > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > > > > > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > > > > > @@ -55,6 +55,7 @@
> > > > > >     #include <net/page_pool/helpers.h>
> > > > > >     #include <linux/align.h>
> > > > > >     #include <net/netdev_queues.h>
> > > > > > +#include <linux/pci-tph.h>
> > > > > > 
> > > > > >     #include "bnxt_hsi.h"
> > > > > >     #include "bnxt.h"
> > > > > > @@ -10491,6 +10492,7 @@ static void bnxt_free_irq(struct bnxt *bp)
> > > > > >                                 free_cpumask_var(irq->cpu_mask);
> > > > > >                                 irq->have_cpumask = 0;
> > > > > >                         }
> > > > > > +                     irq_set_affinity_notifier(irq->vector, NULL);
> > > > > >                         free_irq(irq->vector, bp->bnapi[i]);
> > > > > >                 }
> > > > > > 
> > > > > > @@ -10498,6 +10500,45 @@ static void bnxt_free_irq(struct bnxt *bp)
> > > > > >         }
> > > > > >     }
> > > > > > 
> > > > > > +static void bnxt_rtnl_lock_sp(struct bnxt *bp);
> > > > > > +static void bnxt_rtnl_unlock_sp(struct bnxt *bp);
> > > > > > +static void bnxt_irq_affinity_notify(struct irq_affinity_notify *notify,
> > > > > > +                                  const cpumask_t *mask)
> > > > > > +{
> > > > > > +     struct bnxt_irq *irq;
> > > > > > +
> > > > > > +     irq = container_of(notify, struct bnxt_irq, affinity_notify);
> > > > > > +     cpumask_copy(irq->cpu_mask, mask);
> > > > > > +
> > > > > > +     if (!pcie_tph_set_st(irq->bp->pdev, irq->msix_nr,
> > > > > > +                          cpumask_first(irq->cpu_mask),
> > > > > > +                          TPH_MEM_TYPE_VM, PCI_TPH_REQ_TPH_ONLY))
> > > > > > +             pr_err("error in configuring steering tag\n");
> > > > > > +
> > > > > > +     if (netif_running(irq->bp->dev)) {
> > > > > > +             rtnl_lock();
> > > > > > +             bnxt_close_nic(irq->bp, false, false);
> > > > > > +             bnxt_open_nic(irq->bp, false, false);
> > > > > > +             rtnl_unlock();
> > > > > > +     }
> > > > > 
> > > > > Is it really needed? It will cause link flap and pause in the traffic
> > > > > service for the device. Why the device needs full restart in this case?
> > > > 
> > > > In that sequence only the rings are recreated for the hardware to sync
> > > > up the tags.
> > > > 
> > > > Actually its not a full restart. There is no link reinit or other
> > > > heavy lifting in this sequence.
> > > > The pause in traffic may be momentary. Do IRQ/CPU affinities change frequently?
> > > > Probably not?
> > > 
> > >  From what I can see in bnxt_en, proper validation of link_re_init parameter is
> > > not (yet?) implemented, __bnxt_open_nic will unconditionally call
> > > netif_carrier_off() which will be treated as loss of carrier with counters
> > > increment and proper events posted. Changes to CPU affinities were
> > > non-disruptive before the patch, but now it may break user-space
> > > assumptions.
> > 
> >  From my testing the link should not flap.  I just fired up a recent net-next
> > and confirmed the same by calling $ ethtool -G ens7f0np0 rx 1024 which does a
> > similar bnxt_close_nic(bp, false, false)/bnxt_open_nic(bp, false, false) as
> > this patch.  Link remained up -- even with a non-Broadocm link-partner.
> 
> Hi Andy!
> 
> Well, it might be that from phy PoV the link didn't flap, but from network
> subsystem it does flap:
> 
> [root@host ~]# ethtool -G eth0 rx 512
> [root@host ~]# cat /sys/class/net/eth0/carrier_changes
> 6
> [root@host ~]# ethtool -G eth0 rx 1024
> [root@host ~]# cat /sys/class/net/eth0/carrier_changes
> 8

Fair point :)

I also think that we should skip doing the bnxt_close_nic/bnxt_open_nic
except when TPH is possible on the system.  That should mitigate some of
these concerns for users who do not have it enabled.

> And this is what I'm referring to when talking about user-space experience.
> But I would like to see new ndo_queue_stop/start implementation, it may help
> in this situation.
> 
> > > Does FW need full rings re-init to update target value, which is one u32 write?
> > > It looks like overkill TBH.
> > 
> > Full rings do not, but the initialization of that particular ring associated
> > with this irq does need to be done.  On my list of things we need to do in
> > bnxt_en is implement the new ndo_queue_stop/start and ndo_queue_mem_alloc/free
> > operations and once those are done we could make a switch as that may be less
> > disruptive.
> > 
> > > And yes, affinities can be change on fly according to the changes of the
> > > workload on the host.
> > > 
> > > > > 
> > > > > 
> > > > > > +}
> > > > > > +
> > > > > > +static void bnxt_irq_affinity_release(struct kref __always_unused *ref)
> > > > > > +{
> > > > > > +}
> > > > > > +
> > > > > > +static inline void __bnxt_register_notify_irqchanges(struct bnxt_irq *irq)
> > > > > 
> > > > > No inlines in .c files, please. Let compiler decide what to inline.
> > > > > 
> > > > > > +{
> > > > > > +     struct irq_affinity_notify *notify;
> > > > > > +
> > > > > > +     notify = &irq->affinity_notify;
> > > > > > +     notify->irq = irq->vector;
> > > > > > +     notify->notify = bnxt_irq_affinity_notify;
> > > > > > +     notify->release = bnxt_irq_affinity_release;
> > > > > > +
> > > > > > +     irq_set_affinity_notifier(irq->vector, notify);
> > > > > > +}
> > > > > > +
> > > > > >     static int bnxt_request_irq(struct bnxt *bp)
> > > > > >     {
> > > > > >         int i, j, rc = 0;
> > > > > > @@ -10543,6 +10584,7 @@ static int bnxt_request_irq(struct bnxt *bp)
> > > > > >                         int numa_node = dev_to_node(&bp->pdev->dev);
> > > > > > 
> > > > > >                         irq->have_cpumask = 1;
> > > > > > +                     irq->msix_nr = map_idx;
> > > > > >                         cpumask_set_cpu(cpumask_local_spread(i, numa_node),
> > > > > >                                         irq->cpu_mask);
> > > > > >                         rc = irq_set_affinity_hint(irq->vector, irq->cpu_mask);
> > > > > > @@ -10552,6 +10594,15 @@ static int bnxt_request_irq(struct bnxt *bp)
> > > > > >                                             irq->vector);
> > > > > >                                 break;
> > > > > >                         }
> > > > > > +
> > > > > > +                     if (!pcie_tph_set_st(bp->pdev, i,
> > > > > > +                                          cpumask_first(irq->cpu_mask),
> > > > > > +                                          TPH_MEM_TYPE_VM, PCI_TPH_REQ_TPH_ONLY)) {
> > > > > > +                             netdev_err(bp->dev, "error in setting steering tag\n");
> > > > > > +                     } else {
> > > > > > +                             irq->bp = bp;
> > > > > > +                             __bnxt_register_notify_irqchanges(irq);
> > > > > > +                     }
> > > > > >                 }
> > > > > >         }
> > > > > >         return rc;
> > > > > > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> > > > > > index dd849e715c9b..0d3442590bb4 100644
> > > > > > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> > > > > > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> > > > > > @@ -1195,6 +1195,10 @@ struct bnxt_irq {
> > > > > >         u8              have_cpumask:1;
> > > > > >         char            name[IFNAMSIZ + 2];
> > > > > >         cpumask_var_t   cpu_mask;
> > > > > > +
> > > > > > +     int             msix_nr;
> > > > > > +     struct bnxt     *bp;
> > > > > > +     struct irq_affinity_notify affinity_notify;
> > > > > >     };
> > > > > > 
> > > > > >     #define HWRM_RING_ALLOC_TX  0x1
> > > > > 
> > > 
> 

