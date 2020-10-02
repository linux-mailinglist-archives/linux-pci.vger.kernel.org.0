Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071EE281AC9
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 20:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388265AbgJBSXy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 14:23:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52811 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387602AbgJBSXy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Oct 2020 14:23:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601663032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K5o0jYIGnG/0f5zW82Cze4bYT081fEytdlidzckiyxk=;
        b=AaCjpbJCNqEpnB0aER0qwg7daAd7pBl4IRZjJqv4WeS73E8C6mVssuD80eLVcchEBtoqPJ
        TDbTRMow1aIQkPN3+mo0KTDDWUne5/j2UvncE5leADkomU7TMog0aDU1/1m9jAHkUuCtdt
        qCwuDGE5BuWCsprwlHflwOK2K99/xZA=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-ewndQx58PVCweXgQAoWYBQ-1; Fri, 02 Oct 2020 14:23:51 -0400
X-MC-Unique: ewndQx58PVCweXgQAoWYBQ-1
Received: by mail-il1-f197.google.com with SMTP id 9so1226896ile.22
        for <linux-pci@vger.kernel.org>; Fri, 02 Oct 2020 11:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K5o0jYIGnG/0f5zW82Cze4bYT081fEytdlidzckiyxk=;
        b=f6BEEh8YdfKT4WSwrRkkknbfJgoZw++cpnJTyXrr+74gbeh5aXTZu7w2Z8+DGptdnl
         h7cp42zvNwaFJ0LZBxa1m70SrcxfkG5lrcCyoW6G7ikUUqP6p0AuB+BhYdxw1kM/+0lR
         XgHbz0YQ7BEKvfQFfClplYgDqbxInxbLnF7K6ruwWxKs35yqJJ7xiQNMn9QRg/JhLMtv
         iFnJ0Zo4mFHZWbFRUpOhUxrCLezGz42DbvwcfR1CqORmWUTpgD8ICKOmzmKxN+SOL+1G
         p27b8gsXZn+uUfOn7jywri54AOrUD8El9xxxRHM0Z4B8A05DQbjE/8MjKUnN1ZIs4ETI
         Xkog==
X-Gm-Message-State: AOAM531p5MVAiIYWlbhsHesbuWoC3rqIKsBetVLuMcAM8QmUqbYkX1TE
        zhTslHp2PoAarw8zsxFMjrewzLrruYzsOWyGrNtUj9FlZBKLLfoBBgZ2DP0+PdHg9vY1lW+OtHc
        eODfVvBhltPPV/P7SbD/j
X-Received: by 2002:a5e:dc04:: with SMTP id b4mr2936562iok.208.1601663030551;
        Fri, 02 Oct 2020 11:23:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJym7hhfSAz5RkroqhQVSDKIyKMh66KVDC7NYEDjTn8eT708NnRxui/FuJxqPH3RScDsgKVqBg==
X-Received: by 2002:a5e:dc04:: with SMTP id b4mr2936537iok.208.1601663030343;
        Fri, 02 Oct 2020 11:23:50 -0700 (PDT)
Received: from localhost (c-67-165-232-89.hsd1.co.comcast.net. [67.165.232.89])
        by smtp.gmail.com with ESMTPSA id u15sm1052127ior.6.2020.10.02.11.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 11:23:49 -0700 (PDT)
Date:   Fri, 2 Oct 2020 12:23:48 -0600
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
Message-ID: <20201002182348.GO138842@redhat.com>
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
> > 
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

A follow-up to my earlier post ....

Hearing no objection, I've submitted the VIOT table description to
the ASWG for consideration under what they call the "code first"
process.  The "first reading" -- a brief discussion on what the
table is and why we would like to add it -- was held yesterday.
No concerns have been raised as yet.  Given the discussions that
have already occurred, I don't expect any, either.  I have been
wrong at least once before, however.

At this point, ASWG will revisit the request to add VIOT each
week.  If there have been no comments in the prior week, and no
further discussion during the meeting, then a vote will be taken.
Otherwise, there will be discussion and we try again the next
week.

The ASWG was also told that the likelihood of this definition of
the table changing is pretty low, and that it has been thought out
pretty well already.  ASWG's consideration will therefore start
from the assumption that it would be best _not_ to make changes.

So, I'll let you know what happens next week.

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
> > 
> 

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------

