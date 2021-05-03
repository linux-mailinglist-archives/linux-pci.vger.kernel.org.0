Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C45E3715CD
	for <lists+linux-pci@lfdr.de>; Mon,  3 May 2021 15:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbhECNRa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 May 2021 09:17:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37906 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233362AbhECNQv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 May 2021 09:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620047757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DSRbYPurKI4e7C4gWHrv9oXOAAUShsDTAm8CvlGmLRE=;
        b=OFLQVLSJGAq8zYAmN7rS+9zhJRbfMqgx+9bAVseMHqRfk3f0PmqrBX/KF20Pkiq9PQEpUp
        +7AhsVpciT3YUK9h9qGhrVMR50VwdhHZvCPyiau9UDMqpB7ceYIwDQ5y/rKzAsH/2GYJsD
        /FfHceWKjzRXUadVwT2dDAEO4Kv5wLg=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-SX6xHym_MN2n3W_MZ_Gzpw-1; Mon, 03 May 2021 09:15:55 -0400
X-MC-Unique: SX6xHym_MN2n3W_MZ_Gzpw-1
Received: by mail-lj1-f200.google.com with SMTP id f5-20020a2e9e850000b02900bdf2002a82so2505889ljk.21
        for <linux-pci@vger.kernel.org>; Mon, 03 May 2021 06:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DSRbYPurKI4e7C4gWHrv9oXOAAUShsDTAm8CvlGmLRE=;
        b=C2KplLhprGmzAuFfNm84C/Ge8G1Tz9DvbW+I1rgTPm9tbaQWKfKdYEcvGVl3ZJ3xEI
         K5qt5hmrrQyLPE3mfvkHondzHsF3r8kWZFwv0rdEKiA4uKXFuy/Tq0Sq6m9DZP29fq8J
         iDhMEWRwIhB9Re1UUPPDhRayiX0LnDNr2l9lNNxjYxksi6/iNOQut7zwB/ER7a78Ms7h
         yf1Iqx+I8yrxP4hF9EPCR5ouXvmca/Scb8oBYdIgOPnIVmThfYM8hH9mrqkOGJmyPj1x
         t39e60zr16nPqytaksNuhL3LuArUDFfJGxDyVdIMbr3szplmkHtV64xiEiqGePZnvoxX
         Aw9Q==
X-Gm-Message-State: AOAM530oWlH6ezL85woEd4tPAw401AnVnwA4i4lAuGs27v2IH/1oumgW
        /hdDIoIj/JkDe6ckeUk/LYGrD7qbsrMZ2J6R53i2q8Qf4zlqDE+t6ldxHGBDjm6DLicMxCYppF0
        XyvROGQb+9Vj8ASB80QG4eqUF6u9ASt800tFh
X-Received: by 2002:ac2:5a08:: with SMTP id q8mr13204356lfn.12.1620047754105;
        Mon, 03 May 2021 06:15:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9vFTWw26Bz6L2Xra00hzqXnOSRPp+WnUdBy//UrVLHLkrC+WuOtvUxrn3BuqHUBQmmkg+YlydgpN904FYrpU=
X-Received: by 2002:ac2:5a08:: with SMTP id q8mr13204323lfn.12.1620047753857;
 Mon, 03 May 2021 06:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200625223443.2684-1-nitesh@redhat.com> <20210128165903.GB38339@fuller.cnet>
 <87h7n0de5a.fsf@nanos.tec.linutronix.de> <20210204181546.GA30113@fuller.cnet>
 <cfa138e9-38e3-e566-8903-1d64024c917b@redhat.com> <20210204190647.GA32868@fuller.cnet>
 <d8884413-84b4-b204-85c5-810342807d21@redhat.com> <87y2g26tnt.fsf@nanos.tec.linutronix.de>
 <d0aed683-87ae-91a2-d093-de3f5d8a8251@redhat.com> <7780ae60-efbd-2902-caaa-0249a1f277d9@redhat.com>
 <07c04bc7-27f0-9c07-9f9e-2d1a450714ef@redhat.com> <20210406102207.0000485c@intel.com>
 <1a044a14-0884-eedb-5d30-28b4bec24b23@redhat.com> <20210414091100.000033cf@intel.com>
 <54ecc470-b205-ea86-1fc3-849c5b144b3b@redhat.com> <CAFki+Lm0W_brLu31epqD3gAV+WNKOJfVDfX2M8ZM__aj3nv9uA@mail.gmail.com>
 <87czucfdtf.ffs@nanos.tec.linutronix.de> <CAFki+LmmRyvOkWoNNLk5JCwtaTnabyaRUKxnS+wyAk_kj8wzyw@mail.gmail.com>
 <87sg37eiqa.ffs@nanos.tec.linutronix.de> <CAFki+L=_dd+JgAR12_eBPX0kZO2_6=1dGdgkwHE=u=K6chMeLQ@mail.gmail.com>
 <20210430192145.00000e23@intel.com>
In-Reply-To: <20210430192145.00000e23@intel.com>
From:   Nitesh Lal <nilal@redhat.com>
Date:   Mon, 3 May 2021 09:15:41 -0400
Message-ID: <CAFki+L=0jj5sYhB9wvAZ-LmHR87mJk3y-bM4Z=zLi_n9LCnFBA@mail.gmail.com>
Subject: Re: [Patch v4 1/3] lib: Restrict cpumask_local_spread to houskeeping CPUs
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>, abelits@marvell.com,
        Robin Murphy <robin.murphy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "stephen@networkplumber.org" <stephen@networkplumber.org>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "jinyuqi@huawei.com" <jinyuqi@huawei.com>,
        "zhangshaokun@hisilicon.com" <zhangshaokun@hisilicon.com>,
        netdev@vger.kernel.org, chris.friesen@windriver.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 30, 2021 at 10:21 PM Jesse Brandeburg
<jesse.brandeburg@intel.com> wrote:
>
> Nitesh Lal wrote:
>
> > On Fri, Apr 30, 2021 at 2:21 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > >
> > > Nitesh,
> > >
> > > On Fri, Apr 30 2021 at 12:14, Nitesh Lal wrote:
> > > > Based on this analysis and the fact that with your re-work the interrupts
> > > > seems to be naturally spread across the CPUs, will it be safe to revert
> > > > Jesse's patch
> > > >
> > > > e2e64a932 genirq: Set initial affinity in irq_set_affinity_hint()
> > > >
> > > > as it overwrites the previously set IRQ affinity mask for some of the
> > > > devices?
> > >
> > > That's a good question. My gut feeling says yes.
> > >
> >
> > Jesse do you want to send the revert for the patch?
> >
> > Also, I think it was you who suggested cc'ing
> > intel-wired-lan ml as that allows intel folks, to do some initial
> > testing?
> > If so, we can do that here (IMHO).
>
> Patch sent here:
> https://lore.kernel.org/lkml/20210501021832.743094-1-jesse.brandeburg@intel.com/T/#u
>
> Any testing appreciated!
>
> Jesse
>

Thank you!

--
Nitesh

