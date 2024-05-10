Return-Path: <linux-pci+bounces-7367-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A36258C2B2E
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 22:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5871B28379E
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 20:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86A15028A;
	Fri, 10 May 2024 20:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JuKtisgR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B847219FF
	for <linux-pci@vger.kernel.org>; Fri, 10 May 2024 20:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715373200; cv=none; b=LE1P2VbkJFvI6AD9BQCizz6vqb3OoFFNCIFxZDMBoBm+XEheXz1r4vgRKVClaVQhlvJsGlOIVsxAQn3fOoQUf6kXlAYVR8vHWvF0kEWUPSMHzi2TFJO4xIq6G+nc97lclo1LZnx1g1M/zAHKFdoQStJxEpHxYVGqeUWllK6GxOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715373200; c=relaxed/simple;
	bh=NEeanApc2tQZAwpe4ARYzoOWJwBpkpLvByaGSpa/2nY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBG8q6fMgPJDPsBngxxdL1kD0JHziQD1m05tYB7VC+Qfms7iyNbG3WWk49BBHANwb5wK66uDYJAreT5i0diBb581UXEfUJewhEgrrEzwLoi9nh87cGged2uCSpeL4alHjx/WC5U/ckJaW05yIqDMFXdZxK3CIuS9reJg/9ISJ4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JuKtisgR; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-792c7704e09so114487585a.1
        for <linux-pci@vger.kernel.org>; Fri, 10 May 2024 13:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1715373197; x=1715977997; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uHco92yy/5o5KwpVTM6+R5lhGcl5I06uu1AOp5Ve2/E=;
        b=JuKtisgRJIbcE0SBFTWWB783Ynu3BoPiuCAzGlrwn4/CXEYQ5aj/W0+sVOpIc2CjVw
         qGRQuevHkvC/YFllfALnBwunMoDfk9KLenNT6sX21MBaUlont2niED8q5IRnICXzUhjl
         l/nhdI/7UcyBhQHvc7zIebuFRZznzrxLayYiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715373197; x=1715977997;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uHco92yy/5o5KwpVTM6+R5lhGcl5I06uu1AOp5Ve2/E=;
        b=lvJLjjfxbD7NYi/JgUaA79buN6jS+tYvla9W5CsVpUOhwHrKfNNL7vKZ439z1nPWRF
         kX5LNSkQWJPvShvL2YhwfJWRlx1iRubyga0QLL5W18KhQyidGa/c/VEW+9r1OrqOcAwN
         O2fDCrsOmFK5KT6c5pIj0NeFzmdsm45E8egGBUZfjxWbKeT+TlryfyET7lE6Sr/6tLTk
         LzovWHygx5AfZm7qgcGFHtlhrGQAGXhXM89xZRE5M32IcMQYo1aoRpFbptgefJaztbqI
         e6DISQOfjE4FQl4d5NFGpBtVjxsNayEaERnHajNd7my8Qm3wYqtw5I3bEoS9V8MR6JfR
         rFcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOepHmksyDLVSaPaillt/w+OFdDVXQxdV9Fz0ckhq1l2gg8GCHRjul9rgnnLZdrU1Rm/pJb/1cJxKvn71GIsS9/1glYmKanVEy
X-Gm-Message-State: AOJu0YwM0AJxPNQJR2UWtLVm13YghzoPsH5EHUqQq0dtJ0RsoSlcvoEr
	AlyVQNynRn1z3Ab0qntt0JKtP+YHHC9nsq8N3JC+zJRwhn9yaH+lFKc065Iwmg==
X-Google-Smtp-Source: AGHT+IFdZlaPYRkNUf3GIJ/7asdKS9lm3Q5crdIsSh5fVHNqaGWV378nGRaBL5EcT0SBFZtyYQL81g==
X-Received: by 2002:a05:6214:3b87:b0:6a0:e381:daaf with SMTP id 6a1803df08f44-6a1692dabf9mr54976856d6.18.1715373197280;
        Fri, 10 May 2024 13:33:17 -0700 (PDT)
Received: from C02YVCJELVCG.dhcp.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1ebdb2sm20270416d6.131.2024.05.10.13.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 13:33:16 -0700 (PDT)
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
X-Google-Original-From: Andy Gospodarek <gospo@broadcom.com>
Date: Fri, 10 May 2024 16:33:14 -0400
To: David Wei <dw@davidwei.uk>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Ajit Khaparde <ajit.khaparde@broadcom.com>,
	Wei Huang <wei.huang2@amd.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org, bhelgaas@google.com, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, alex.williamson@redhat.com,
	michael.chan@broadcom.com, manoj.panicker2@amd.com,
	Eric.VanTassell@amd.com
Subject: Re: [PATCH V1 8/9] bnxt_en: Add TPH support in BNXT driver
Message-ID: <Zj6EimbBR9hp_ILT@C02YVCJELVCG.dhcp.broadcom.net>
References: <20240509162741.1937586-1-wei.huang2@amd.com>
 <20240509162741.1937586-9-wei.huang2@amd.com>
 <868a4758-2873-4ede-83e5-65f42cb12b81@linux.dev>
 <CACZ4nhuBMOX8s1ODcJOvvCKp-VsOPHShEUHAsPvB75Yv2823qA@mail.gmail.com>
 <4c6a8b86-6544-4c99-a0f2-030e2ec4e98f@linux.dev>
 <Zj48BPYoFU1ISaiL@C02YVCJELVCG.dhcp.broadcom.net>
 <0ef50183-42d4-4abd-adeb-bd92b030fe6a@davidwei.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ef50183-42d4-4abd-adeb-bd92b030fe6a@davidwei.uk>

On Fri, May 10, 2024 at 01:03:50PM -0700, David Wei wrote:
> On 2024-05-10 08:23, Andy Gospodarek wrote:
> > On Fri, May 10, 2024 at 11:35:35AM +0100, Vadim Fedorenko wrote:
> >> On 10.05.2024 04:55, Ajit Khaparde wrote:
> >>> On Thu, May 9, 2024 at 2:50 PM Vadim Fedorenko
> >>> <vadim.fedorenko@linux.dev> wrote:
> >>>>
> >>>> On 09/05/2024 17:27, Wei Huang wrote:
> >>>>> From: Manoj Panicker <manoj.panicker2@amd.com>
> >>>>>
> >>>>> As a usage example, this patch implements TPH support in Broadcom BNXT
> >>>>> device driver by invoking pcie_tph_set_st() function when interrupt
> >>>>> affinity is changed.
> >>>>>
> >>>>> Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> >>>>> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> >>>>> Reviewed-by: Wei Huang <wei.huang2@amd.com>
> >>>>> Signed-off-by: Manoj Panicker <manoj.panicker2@amd.com>
> >>>>> ---
> >>>>>    drivers/net/ethernet/broadcom/bnxt/bnxt.c | 51 +++++++++++++++++++++++
> >>>>>    drivers/net/ethernet/broadcom/bnxt/bnxt.h |  4 ++
> >>>>>    2 files changed, 55 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> >>>>> index 2c2ee79c4d77..be9c17566fb4 100644
> >>>>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> >>>>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> >>>>> @@ -55,6 +55,7 @@
> >>>>>    #include <net/page_pool/helpers.h>
> >>>>>    #include <linux/align.h>
> >>>>>    #include <net/netdev_queues.h>
> >>>>> +#include <linux/pci-tph.h>
> >>>>>
> >>>>>    #include "bnxt_hsi.h"
> >>>>>    #include "bnxt.h"
> >>>>> @@ -10491,6 +10492,7 @@ static void bnxt_free_irq(struct bnxt *bp)
> >>>>>                                free_cpumask_var(irq->cpu_mask);
> >>>>>                                irq->have_cpumask = 0;
> >>>>>                        }
> >>>>> +                     irq_set_affinity_notifier(irq->vector, NULL);
> >>>>>                        free_irq(irq->vector, bp->bnapi[i]);
> >>>>>                }
> >>>>>
> >>>>> @@ -10498,6 +10500,45 @@ static void bnxt_free_irq(struct bnxt *bp)
> >>>>>        }
> >>>>>    }
> >>>>>
> >>>>> +static void bnxt_rtnl_lock_sp(struct bnxt *bp);
> >>>>> +static void bnxt_rtnl_unlock_sp(struct bnxt *bp);
> >>>>> +static void bnxt_irq_affinity_notify(struct irq_affinity_notify *notify,
> >>>>> +                                  const cpumask_t *mask)
> >>>>> +{
> >>>>> +     struct bnxt_irq *irq;
> >>>>> +
> >>>>> +     irq = container_of(notify, struct bnxt_irq, affinity_notify);
> >>>>> +     cpumask_copy(irq->cpu_mask, mask);
> >>>>> +
> >>>>> +     if (!pcie_tph_set_st(irq->bp->pdev, irq->msix_nr,
> >>>>> +                          cpumask_first(irq->cpu_mask),
> >>>>> +                          TPH_MEM_TYPE_VM, PCI_TPH_REQ_TPH_ONLY))
> >>>>> +             pr_err("error in configuring steering tag\n");
> >>>>> +
> >>>>> +     if (netif_running(irq->bp->dev)) {
> >>>>> +             rtnl_lock();
> >>>>> +             bnxt_close_nic(irq->bp, false, false);
> >>>>> +             bnxt_open_nic(irq->bp, false, false);
> >>>>> +             rtnl_unlock();
> >>>>> +     }
> >>>>
> >>>> Is it really needed? It will cause link flap and pause in the traffic
> >>>> service for the device. Why the device needs full restart in this case?
> >>>
> >>> In that sequence only the rings are recreated for the hardware to sync
> >>> up the tags.
> >>>
> >>> Actually its not a full restart. There is no link reinit or other
> >>> heavy lifting in this sequence.
> >>> The pause in traffic may be momentary. Do IRQ/CPU affinities change frequently?
> >>> Probably not?
> >>
> >> From what I can see in bnxt_en, proper validation of link_re_init parameter is
> >> not (yet?) implemented, __bnxt_open_nic will unconditionally call
> >> netif_carrier_off() which will be treated as loss of carrier with counters
> >> increment and proper events posted. Changes to CPU affinities were
> >> non-disruptive before the patch, but now it may break user-space
> >> assumptions.
> > 
> > From my testing the link should not flap.  I just fired up a recent net-next
> > and confirmed the same by calling $ ethtool -G ens7f0np0 rx 1024 which does a
> > similar bnxt_close_nic(bp, false, false)/bnxt_open_nic(bp, false, false) as
> > this patch.  Link remained up -- even with a non-Broadocm link-partner.
> > 
> >> Does FW need full rings re-init to update target value, which is one u32 write?
> >> It looks like overkill TBH.
> > 
> > Full rings do not, but the initialization of that particular ring associated
> > with this irq does need to be done.  On my list of things we need to do in
> > bnxt_en is implement the new ndo_queue_stop/start and ndo_queue_mem_alloc/free
> > operations and once those are done we could make a switch as that may be less
> > disruptive.
> 
> Hi Andy, I have an implementation of the new ndo_queue_stop/start() API
> [1] and would appreciate comments. I've been trying to test it but
> without avail due to FW issues.
> 
> [1]: https://lore.kernel.org/netdev/20240502045410.3524155-1-dw@davidwei.uk/
> 

David, I will take a look at those in more detail over the weekend or on Monday
(they are sitting in my inbox).

The overall structure looks good, but I do have at least one concern that is
related to what would need to be done in the hardware pipeline to be sure it is
safe to free packet buffers.

> > 
> >> And yes, affinities can be change on fly according to the changes of the
> >> workload on the host.
> >>
> >>>>
> >>>>
> >>>>> +}
> >>>>> +
> >>>>> +static void bnxt_irq_affinity_release(struct kref __always_unused *ref)
> >>>>> +{
> >>>>> +}
> >>>>> +
> >>>>> +static inline void __bnxt_register_notify_irqchanges(struct bnxt_irq *irq)
> >>>>
> >>>> No inlines in .c files, please. Let compiler decide what to inline.
> >>>>
> >>>>> +{
> >>>>> +     struct irq_affinity_notify *notify;
> >>>>> +
> >>>>> +     notify = &irq->affinity_notify;
> >>>>> +     notify->irq = irq->vector;
> >>>>> +     notify->notify = bnxt_irq_affinity_notify;
> >>>>> +     notify->release = bnxt_irq_affinity_release;
> >>>>> +
> >>>>> +     irq_set_affinity_notifier(irq->vector, notify);
> >>>>> +}
> >>>>> +
> >>>>>    static int bnxt_request_irq(struct bnxt *bp)
> >>>>>    {
> >>>>>        int i, j, rc = 0;
> >>>>> @@ -10543,6 +10584,7 @@ static int bnxt_request_irq(struct bnxt *bp)
> >>>>>                        int numa_node = dev_to_node(&bp->pdev->dev);
> >>>>>
> >>>>>                        irq->have_cpumask = 1;
> >>>>> +                     irq->msix_nr = map_idx;
> >>>>>                        cpumask_set_cpu(cpumask_local_spread(i, numa_node),
> >>>>>                                        irq->cpu_mask);
> >>>>>                        rc = irq_set_affinity_hint(irq->vector, irq->cpu_mask);
> >>>>> @@ -10552,6 +10594,15 @@ static int bnxt_request_irq(struct bnxt *bp)
> >>>>>                                            irq->vector);
> >>>>>                                break;
> >>>>>                        }
> >>>>> +
> >>>>> +                     if (!pcie_tph_set_st(bp->pdev, i,
> >>>>> +                                          cpumask_first(irq->cpu_mask),
> >>>>> +                                          TPH_MEM_TYPE_VM, PCI_TPH_REQ_TPH_ONLY)) {
> >>>>> +                             netdev_err(bp->dev, "error in setting steering tag\n");
> >>>>> +                     } else {
> >>>>> +                             irq->bp = bp;
> >>>>> +                             __bnxt_register_notify_irqchanges(irq);
> >>>>> +                     }
> >>>>>                }
> >>>>>        }
> >>>>>        return rc;
> >>>>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> >>>>> index dd849e715c9b..0d3442590bb4 100644
> >>>>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> >>>>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> >>>>> @@ -1195,6 +1195,10 @@ struct bnxt_irq {
> >>>>>        u8              have_cpumask:1;
> >>>>>        char            name[IFNAMSIZ + 2];
> >>>>>        cpumask_var_t   cpu_mask;
> >>>>> +
> >>>>> +     int             msix_nr;
> >>>>> +     struct bnxt     *bp;
> >>>>> +     struct irq_affinity_notify affinity_notify;
> >>>>>    };
> >>>>>
> >>>>>    #define HWRM_RING_ALLOC_TX  0x1
> >>>>
> >>

