Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1351E27D475
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 19:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgI2R26 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 13:28:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47292 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727328AbgI2R26 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2020 13:28:58 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601400536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8BuFCHV4DyyyceiFSJkI3cyJ1EYQRloVeaKvvp0HdMc=;
        b=OdeMN/HF0OEjO7iJNBzBx3qalDHvHuKPMM7v85KT3GbDkMCkuYLUJ6LhraC6n2hRHlnmsO
        Oc07xuoOBOJ02BWbmDhCibS4y4A7ooCuXMc9TTe70FZLAx8S4CfCdASKiFZ8CNTYKGCNmb
        okBSbDr+ZCI/NvZLgTRt6A/L6whJP1c=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-KwrF9QM9OIurGHED7PZ-nw-1; Tue, 29 Sep 2020 13:28:52 -0400
X-MC-Unique: KwrF9QM9OIurGHED7PZ-nw-1
Received: by mail-ot1-f72.google.com with SMTP id m6so3475666otn.13
        for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2020 10:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8BuFCHV4DyyyceiFSJkI3cyJ1EYQRloVeaKvvp0HdMc=;
        b=oXnB7mqbO5CJjFnf3CwUcDfxe2KPaxWsTMwzFOErnHfBx8BrbkuBl1om0daJqGLBoa
         Twk241St3m2bEFHdczTgjuflXw9i0OlR9EL27XuAbtbMp4Eq+ZZuTP20CFrtuFr1tXtp
         ZRMrGjnYETCGNNTdEkvMxixl1nGgm3rzTVUDcCZbg3K5Z9SV7U9qUiAG9+1lwzy+dBLz
         Tk601LXb0iSYmM7xekHP052Yz/i7QW48Y+CJjfdnDtnPoKaqvaWRi1eRvXZlkpXeK86Z
         tCFkWQrag4qKYffY8WVS6yD0/7u2MzNKCGajjpuEJAwWEjpE7EAZ4YGU6Mf7eky9NmMl
         +knw==
X-Gm-Message-State: AOAM530davNkIoaUpKsmIPj4g0FR4BYc9B7NpfZ/Q5al4bpqB6NspfWo
        VEERSawQc5UooI0oXpQvTvf2ZgngTmPa5MYN+MPS0SPEfHpBIMzdrcdN2FSY7Dlg8aGWADtou7r
        Qc8orwcR+ljRBTjXqXNvN
X-Received: by 2002:aca:1312:: with SMTP id e18mr3259412oii.19.1601400531248;
        Tue, 29 Sep 2020 10:28:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuBdTi+WL2ru4njoi33T1kboK4M7/85ghf3zubjSkL4Y6DUjJ7A5Y4VxcyHt+ZGTU5MThUsw==
X-Received: by 2002:aca:1312:: with SMTP id e18mr3259396oii.19.1601400530952;
        Tue, 29 Sep 2020 10:28:50 -0700 (PDT)
Received: from localhost (c-67-165-232-89.hsd1.co.comcast.net. [67.165.232.89])
        by smtp.gmail.com with ESMTPSA id p16sm1137448otl.17.2020.09.29.10.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 10:28:50 -0700 (PDT)
Date:   Tue, 29 Sep 2020 11:28:48 -0600
From:   Al Stone <ahs3@redhat.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, lorenzo.pieralisi@arm.com
Subject: Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Message-ID: <20200929172848.GZ138842@redhat.com>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <ab2a1668-e40c-c8f0-b77b-abadeceb4b82@redhat.com>
 <20200924045958-mutt-send-email-mst@kernel.org>
 <20200924092129.GH27174@8bytes.org>
 <20200924053159-mutt-send-email-mst@kernel.org>
 <d54b674e-2626-fc73-d663-136573c32b8a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d54b674e-2626-fc73-d663-136573c32b8a@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 24 Sep 2020 11:54, Auger Eric wrote:
> Hi,
> 
> Adding Al in the loop
> 
> On 9/24/20 11:38 AM, Michael S. Tsirkin wrote:
> > On Thu, Sep 24, 2020 at 11:21:29AM +0200, Joerg Roedel wrote:
> >> On Thu, Sep 24, 2020 at 05:00:35AM -0400, Michael S. Tsirkin wrote:
> >>> OK so this looks good. Can you pls repost with the minor tweak
> >>> suggested and all acks included, and I will queue this?
> >>
> >> My NACK still stands, as long as a few questions are open:
> >>
> >> 	1) The format used here will be the same as in the ACPI table? I
> >> 	   think the answer to this questions must be Yes, so this leads
> >> 	   to the real question:
> > 
> > I am not sure it's a must.
> > We can always tweak the parser if there are slight differences
> > between ACPI and virtio formats.
> > 
> > But we do want the virtio format used here to be approved by the virtio
> > TC, so it won't change.

As long as we can convey the same content to the UEFI ASWG, we're
fine.  Format/syntax of the submittal is not absolutely critical
though it does need translating to what the ASWG expects (see
https://github.com/tianocore/tianocore.github.io/wiki/EDK-II-Code-First-Process
for details -- basically a bugzilla with markdown text.

> > Eric, Jean-Philippe, does one of you intend to create a github issue
> > and request a ballot for the TC? It's been posted end of August with no
> > changes ...
> Jean-Philippe, would you?
> > 
> >> 	2) Has the ACPI table format stabalized already? If and only if
> >> 	   the answer is Yes I will Ack these patches. We don't need to
> >> 	   wait until the ACPI table format is published in a
> >> 	   specification update, but at least some certainty that it
> >> 	   will not change in incompatible ways anymore is needed.
> >>
> 
> Al, do you have any news about the the VIOT definition submission to
> the UEFI ASWG?
> 
> Thank you in advance
> 
> Best Regards
> 
> Eric
> 
> 
> > 
> > Not that I know, but I don't see why it's a must.
> > 
> >> So what progress has been made with the ACPI table specification, is it
> >> just a matter of time to get it approved or are there concerns?
> >>
> >> Regards,
> >>
> >> 	Joerg

My apologies for the delay.  No excuses, just not enough hours in the
day.

I will make the proper submission to the ASWG later today to have it
considered later this week -- I had quite a bit of confusion around
how the process is supposed to work but I think we've got that cleared
up (see the link noted above).

The content of the table appears to be in really good shape.  Will it
change?  Possibly, but my expectation is that it will be minor details,
nothing wholesale; having the table in use in code tends to act as a
pretty fierce restraint on making changes (there's a lot of precedent
for that in ASWG).

The biggest question is: are there any objections to having this
table description licensed under Creative Commons Attribution
International 4.0 (see https://spdx.org/licenses/CC-BY-4.0.html)?
This is just for the table description, not the code.  If there
are, that needs to be cleared up first.  If not, then the submittal
this week should happen.

Once submitted to ASWG, there is a very slim chance it will end up
in ACPI 6.4 which is mostly done now -- very, very slim, but stranger
things have happened.  Most likely, once approved it would be in
ACPI 6.5, sometime in 2021.  I'll post the link to the submittal
as soon as I can.

Again, my apologies for the delays; approval in the spec can proceed
pretty much independent of the implementation, and vice versa.  That's
really the whole point of this new process with the UEFI Forum.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------

