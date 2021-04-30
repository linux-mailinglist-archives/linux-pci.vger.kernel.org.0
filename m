Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5CC36FB38
	for <lists+linux-pci@lfdr.de>; Fri, 30 Apr 2021 15:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbhD3NLr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Apr 2021 09:11:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40797 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230020AbhD3NLq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Apr 2021 09:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619788258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eFmN7GXhyvWoD/0hmIYm1FOaJDGHK8SDles6jaDUx50=;
        b=MB4iQSeoEVIQTO9+zBQN3ZLteGwcmlzd5MkZCkM4+1nOLdxWaLbYIXAuADCZU3k/+DGIRx
        Ch9WuFWbz4KvXyZ54WgoUbP3FQElM3uRhUmN7iT0HDEhTuAnvGb0IhbOh3XPMIYBZ0DMEt
        Syer9NBP93VX9c/pUghNUdpZ3W3APaI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-GBB6TbJaO26Tf94a519zvA-1; Fri, 30 Apr 2021 09:10:56 -0400
X-MC-Unique: GBB6TbJaO26Tf94a519zvA-1
Received: by mail-lf1-f70.google.com with SMTP id w21-20020a0565120b15b02901ab3c1d6169so20167418lfu.2
        for <linux-pci@vger.kernel.org>; Fri, 30 Apr 2021 06:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eFmN7GXhyvWoD/0hmIYm1FOaJDGHK8SDles6jaDUx50=;
        b=QHlhAz0q6l5MurdqhQkRGCvkYfSDxbQDRz1gqwwxbuU3qt8CDsc6gyO5H1ljiLO9gU
         9CspYYZUkO6DfHkFEWYHm77a0KgJ/T8mOgnzUW2J+cl7phzoNrmbkVoJk9/qEUrMenFW
         IIA2ngd4AM3aLfeCwKjnyoleWXBv7d19qFKwFQp6nMnCdj1W4LSQt4R0BKEozQ96XICF
         Bj7EZYvXyF9YDLX78WSVEO0GlGlJWd5kcewzZ8+IP0sQ7ZtG5xqzIRnAUU9h5SvOLDi7
         OBdxO90uAd4akjm10jNh2sldztv1N82M+5h7kdx/shBFZOu/hup8K6+bbjbDDieKdeab
         O/Jg==
X-Gm-Message-State: AOAM532kNqss9uopWdzKHaIahedaDtoys+qgcCLlrGon77S4Zkt6cEBv
        gh/GgeiN2r14/frXckND3oS24RctdPnbG2Cxw3AT96bNlLNWcnVxrO9mPvwkW9uvsKfK0sggOYD
        CPNBcJyaSYqO8rBnaOPigCB9DxbcyrWT9vrnc
X-Received: by 2002:a2e:a71e:: with SMTP id s30mr3619798lje.137.1619788255089;
        Fri, 30 Apr 2021 06:10:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJqc1hlP2rkr8JKdzvyVvOdVHZomdQvDwhT1frYVIrIzVVBNex0m3GwjpZjhRo3TTecIKglydEAUtmkI34+Ic=
X-Received: by 2002:a2e:a71e:: with SMTP id s30mr3619779lje.137.1619788254917;
 Fri, 30 Apr 2021 06:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200625223443.2684-1-nitesh@redhat.com> <20200625223443.2684-2-nitesh@redhat.com>
 <3e9ce666-c9cd-391b-52b6-3471fe2be2e6@arm.com> <20210127121939.GA54725@fuller.cnet>
 <87r1m5can2.fsf@nanos.tec.linutronix.de> <20210128165903.GB38339@fuller.cnet>
 <87h7n0de5a.fsf@nanos.tec.linutronix.de> <20210204181546.GA30113@fuller.cnet>
 <cfa138e9-38e3-e566-8903-1d64024c917b@redhat.com> <20210204190647.GA32868@fuller.cnet>
 <d8884413-84b4-b204-85c5-810342807d21@redhat.com> <87y2g26tnt.fsf@nanos.tec.linutronix.de>
 <d0aed683-87ae-91a2-d093-de3f5d8a8251@redhat.com> <7780ae60-efbd-2902-caaa-0249a1f277d9@redhat.com>
 <07c04bc7-27f0-9c07-9f9e-2d1a450714ef@redhat.com> <20210406102207.0000485c@intel.com>
 <1a044a14-0884-eedb-5d30-28b4bec24b23@redhat.com> <20210414091100.000033cf@intel.com>
 <54ecc470-b205-ea86-1fc3-849c5b144b3b@redhat.com> <CAFki+Lm0W_brLu31epqD3gAV+WNKOJfVDfX2M8ZM__aj3nv9uA@mail.gmail.com>
 <20210429184802.0000641e@intel.com>
In-Reply-To: <20210429184802.0000641e@intel.com>
From:   Nitesh Lal <nilal@redhat.com>
Date:   Fri, 30 Apr 2021 09:10:40 -0400
Message-ID: <CAFki+LnbX6bJPh18iowxSsC=W8A3D5PXSN4xBab0Qbxm-JjBew@mail.gmail.com>
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

On Thu, Apr 29, 2021 at 9:48 PM Jesse Brandeburg
<jesse.brandeburg@intel.com> wrote:
>
> Nitesh Lal wrote:
>
> > @Jesse do you think the Part-1 findings explain the behavior that you have
> > observed in the past?
> >
> > Also, let me know if there are any suggestions or experiments to try here.
>
> Wow Nitesh, nice work! That's quite a bit of spelunking you had to do
> there!
>
> Your results that show the older kernels with ranged affinity issues is
> consistent with what I remember from that time, and the original
> problem.

That's nice.

>
> I'm glad to see that a) Thomas fixed the kernel to even do better than
> ranged affinity masks, and that b) if you revert my patch, the new
> behavior is better and still maintains the fix from a).

Right, the interrupts are naturally spread now.

>
> For me this explains the whole picture and makes me feel comfortable
> with the patch that reverts the initial affinity mask (that also
> introduces a subtle bug with the reserved CPUs that I believe you've
> noted already).
>

Thank you for confirming!

--
Nitesh

