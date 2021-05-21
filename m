Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E7638C898
	for <lists+linux-pci@lfdr.de>; Fri, 21 May 2021 15:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbhEUNsD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 May 2021 09:48:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59032 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232646AbhEUNr6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 May 2021 09:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621604795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pxEOV+Bz/B1tAe8FeS+TqChUcoqHhutaFnjDp8o1QJQ=;
        b=KeNHVcRVT58onkahgRnGTqmZtrTznEsFOgUHylGzCH9uHS0L8SvF9pbsHHzFWDSPKU/Rjc
        24Q6PtNJ1VDlSXDE6htWiX1E91iat0K77ARBw9w2UApjVhpniKREqcnDpgRvyfgj/hRCqD
        nJSPZJoNVKZxafkwLg0WyUPDpWiwr/M=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-K0i5yN8NPne9EDRSgVGIzg-1; Fri, 21 May 2021 09:46:33 -0400
X-MC-Unique: K0i5yN8NPne9EDRSgVGIzg-1
Received: by mail-lf1-f72.google.com with SMTP id u23-20020a1979170000b02901d2e8dd801dso5194672lfc.6
        for <linux-pci@vger.kernel.org>; Fri, 21 May 2021 06:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pxEOV+Bz/B1tAe8FeS+TqChUcoqHhutaFnjDp8o1QJQ=;
        b=ghcM+voPFzm3HQbz5mTGk1tKbhvzh9z49QywyeyDxDNN3723ab6Z9EcsLG2R7+sMCS
         uIMYSXrvuFAL/OSJhGZJocR3CvN/zlpDXitFMEsAK69zBLvnL9rErFc7Qj9Br/n5Xck2
         XK7FE7+8yeoAqegXJ07ud0nXSReeWlr6O475An3DMTnyVO2hA+TVmG6p4kbfz+n2g6hF
         0bRZq3SaEnYvFmqgKfXiYeTosuRJSiGLJOC5g7aa83E9NKq7hfRhRhIA0BadWs67/yOl
         YsubRrkCEZOHDf45p2+NpL66rEAl2Ep6uDqK+9v1x0RLqZgNYV+2I15UYiCHaVlFl8Zi
         uqqw==
X-Gm-Message-State: AOAM53008BGXbCjZhKMUWmlREs2bvZthYkvpZKBHUXxFGueQXzHCtYgo
        E31AjL2Cf23q9fJqS5KldIPdaFEN85O7uDPPBmDx7w0sK2IsUe0eq+YJ9RUnlbIERLgz7kiWINv
        IFPTAMZWx9jxH5ORWRKlgTORUtXAVn8fOaLVn
X-Received: by 2002:a2e:9802:: with SMTP id a2mr6897015ljj.232.1621604792286;
        Fri, 21 May 2021 06:46:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlGxBda5A/LzKGja1+OEN8tx6PjZF4MfUkV3JmKj4AkWLhF+MPQT6UkdSN2h3rzdDqbYrS1zrIy9/RGgGSqN4=
X-Received: by 2002:a2e:9802:: with SMTP id a2mr6896994ljj.232.1621604792081;
 Fri, 21 May 2021 06:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210504092340.00006c61@intel.com> <87pmxpdr32.ffs@nanos.tec.linutronix.de>
 <CAFki+Lkjn2VCBcLSAfQZ2PEkx-TR0Ts_jPnK9b-5ne3PUX37TQ@mail.gmail.com>
 <87im3gewlu.ffs@nanos.tec.linutronix.de> <CAFki+L=gp10W1ygv7zdsee=BUGpx9yPAckKr7pyo=tkFJPciEg@mail.gmail.com>
 <CAFki+L=eQoMq+mWhw_jVT-biyuDXpxbXY5nO+F6HvCtpbG9V2w@mail.gmail.com>
 <CAFki+LkB1sk3mOv4dd1D-SoPWHOs28ZwN-PqL_6xBk=Qkm40Lw@mail.gmail.com> <87zgwo9u79.ffs@nanos.tec.linutronix.de>
In-Reply-To: <87zgwo9u79.ffs@nanos.tec.linutronix.de>
From:   Nitesh Lal <nilal@redhat.com>
Date:   Fri, 21 May 2021 09:46:20 -0400
Message-ID: <CAFki+LnKycMFYTGTswX9vpMepNiCW6BL5TFMTuKZSniab5=4SA@mail.gmail.com>
Subject: Re: [PATCH tip:irq/core v1] genirq: remove auto-set of the mask when
 setting the hint
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, jbrandeb@kernel.org,
        "frederic@kernel.org" <frederic@kernel.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "stephen@networkplumber.org" <stephen@networkplumber.org>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "jinyuqi@huawei.com" <jinyuqi@huawei.com>,
        "zhangshaokun@hisilicon.com" <zhangshaokun@hisilicon.com>,
        netdev@vger.kernel.org, chris.friesen@windriver.com,
        Marc Zyngier <maz@kernel.org>,
        Neil Horman <nhorman@tuxdriver.com>, pjwaskiewicz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 21, 2021 at 7:56 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Nitesh,
>
> On Thu, May 20 2021 at 20:03, Nitesh Lal wrote:
> > On Thu, May 20, 2021 at 5:57 PM Nitesh Lal <nilal@redhat.com> wrote:
> >> I think here to ensure that we are not breaking any of the drivers we have
> >> to first analyze all the existing drivers and understand how they are using
> >> this API.
> >> AFAIK there are three possible scenarios:
> >>
> >> - A driver use this API to spread the IRQs
> >>   + For this case we should be safe considering the spreading is naturally
> >>     done from the IRQ subsystem itself.
> >
> > Forgot to mention another thing in the above case is to determine whether
> > it is true for all architectures or not as Thomas mentioned.
>
> Yes.
>
> >>
> >> - A driver use this API to actually set the hint
> >>   + These drivers should have no functional impact because of this revert
>
> Correct.
>
>
> >> - Driver use this API to force a certain affinity mask
> >>   + In this case we have to replace the API with the irq_force_affinity()
>
> irq_set_affinity() or irq_set_affinity_and_hint()

Ah yes! my bad. _force_ doesn't check the mask against the online CPUs.
Hmm, I didn't realize that you also added irq_set_affinity_and_hint()
in your last patchset.

>
> >> I can start looking into the individual drivers, however, testing them will
> >> be a challenge.
>
> The only way to do that is to have the core infrastructure added and

Right.

> then send patches changing it in the way you think. The relevant
> maintainers/developers should be able to tell you when your analysis
> went south. :)

Ack will start looking into this.


--
Thanks
Nitesh

