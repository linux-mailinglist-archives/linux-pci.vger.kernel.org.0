Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE3802A50BA
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 21:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgKCUJL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 15:09:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54619 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725997AbgKCUJK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Nov 2020 15:09:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604434148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NqhKVR/2Ajvl50Pd8Ilz+ajONAsW3dvf+1ZyM0gSs30=;
        b=blRjpJIdn+E+jt0iZB6ZcMKxG57jzKeJawkX122wU5i+c9V0yMrBndArvbFA0SWMTn0kzS
        db5PtitwmKeacmmurm3LMO9SOhb1G58evQfWoULoiBKCXMEN+v1XWyeuXWLW8BFtSTk7ls
        zvei0gLEaRA4+65POc5xh70MBq59ZTo=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-Kt3SfkKfN1S-yov4VXcEsQ-1; Tue, 03 Nov 2020 15:09:06 -0500
X-MC-Unique: Kt3SfkKfN1S-yov4VXcEsQ-1
Received: by mail-io1-f72.google.com with SMTP id q3so11222370iow.12
        for <linux-pci@vger.kernel.org>; Tue, 03 Nov 2020 12:09:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NqhKVR/2Ajvl50Pd8Ilz+ajONAsW3dvf+1ZyM0gSs30=;
        b=F+ymwrcz6FTOEA33d5vcuWmz/woLjwFS+aZiOQwKyuXdYKNhaqKOZGAqC4O1rfUEks
         s2v2HDWWMZVHlWia8fgsgvuAyXepgCozQtmyGUC44CBzDIQJaQA2Osz/tqcqTAgosrit
         VqcOiCJxR2XCU4PMFW4v1laqVaajdVBVGOY9QHrg+EdAGymmjh2YLc24jGdmgb8YaPPV
         2z3yvPu0UoO7rHWhk7mPu7nvqjjS2BvIp/sAMCaGYp0sm+0wQcl5UUvR4p/eAkUxtkjS
         ZJsel4ZXLdpWEv4DFhxJ4CHyZE6Q9MVunoq0KsEEumufsj9r76nY4AZoC6bfGrVRtV4S
         75Qw==
X-Gm-Message-State: AOAM530Rhf+Y5YX+406nfj7WKa/4IrJcyVuSSHsbSPl1AynFcWzdxq69
        YayXGHs7V4SfrLIKM/Ga8QyFqUf3+rcjtMv9nWi8xaAxlUZCfZxe5ItKP6jhvsK7HWKMFCM/xhb
        eZuenaS2Y6nx+giM5LgiF
X-Received: by 2002:a92:7a0c:: with SMTP id v12mr14054035ilc.37.1604434146123;
        Tue, 03 Nov 2020 12:09:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyfLVxyBBmzFRGEt1E1I5sfsYYkY/HJFsCafbpR5oigBeFopgLwYltmKHsb4aWM3tTZxIhDAA==
X-Received: by 2002:a92:7a0c:: with SMTP id v12mr14054011ilc.37.1604434145890;
        Tue, 03 Nov 2020 12:09:05 -0800 (PST)
Received: from localhost (c-67-165-232-89.hsd1.co.comcast.net. [67.165.232.89])
        by smtp.gmail.com with ESMTPSA id 9sm14471896ila.61.2020.11.03.12.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 12:09:05 -0800 (PST)
Date:   Tue, 3 Nov 2020 13:09:04 -0700
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
Message-ID: <20201103200904.GA1557194@redhat.com>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <ab2a1668-e40c-c8f0-b77b-abadeceb4b82@redhat.com>
 <20200924045958-mutt-send-email-mst@kernel.org>
 <20200924092129.GH27174@8bytes.org>
 <20200924053159-mutt-send-email-mst@kernel.org>
 <d54b674e-2626-fc73-d663-136573c32b8a@redhat.com>
 <20201002182348.GO138842@redhat.com>
 <e8a37837-30d0-d7cc-496a-df4c12fff1da@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8a37837-30d0-d7cc-496a-df4c12fff1da@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 06 Oct 2020 17:23, Auger Eric wrote:
> Hello Al,
> 
> On 10/2/20 8:23 PM, Al Stone wrote:
> > On 24 Sep 2020 11:54, Auger Eric wrote:
> >> Hi,
> >>
> >> Adding Al in the loop
> >>
> >> On 9/24/20 11:38 AM, Michael S. Tsirkin wrote:
> >>> On Thu, Sep 24, 2020 at 11:21:29AM +0200, Joerg Roedel wrote:
> >>>> On Thu, Sep 24, 2020 at 05:00:35AM -0400, Michael S. Tsirkin wrote:
> >>>>> OK so this looks good. Can you pls repost with the minor tweak
> >>>>> suggested and all acks included, and I will queue this?
> >>>>
> >>>> My NACK still stands, as long as a few questions are open:
> >>>>
> >>>> 	1) The format used here will be the same as in the ACPI table? I
> >>>> 	   think the answer to this questions must be Yes, so this leads
> >>>> 	   to the real question:
> >>>
> >>> I am not sure it's a must.
> >>> We can always tweak the parser if there are slight differences
> >>> between ACPI and virtio formats.
> >>>
> >>> But we do want the virtio format used here to be approved by the virtio
> >>> TC, so it won't change.
> >>>
> >>> Eric, Jean-Philippe, does one of you intend to create a github issue
> >>> and request a ballot for the TC? It's been posted end of August with no
> >>> changes ...
> >> Jean-Philippe, would you?
> >>>
> >>>> 	2) Has the ACPI table format stabalized already? If and only if
> >>>> 	   the answer is Yes I will Ack these patches. We don't need to
> >>>> 	   wait until the ACPI table format is published in a
> >>>> 	   specification update, but at least some certainty that it
> >>>> 	   will not change in incompatible ways anymore is needed.
> >>>>
> >>
> >> Al, do you have any news about the the VIOT definition submission to
> >> the UEFI ASWG?
> >>
> >> Thank you in advance
> >>
> >> Best Regards
> >>
> >> Eric
> > 
> > A follow-up to my earlier post ....
> > 
> > Hearing no objection, I've submitted the VIOT table description to
> > the ASWG for consideration under what they call the "code first"
> > process.  The "first reading" -- a brief discussion on what the
> > table is and why we would like to add it -- was held yesterday.
> > No concerns have been raised as yet.  Given the discussions that
> > have already occurred, I don't expect any, either.  I have been
> > wrong at least once before, however.
> > 
> > At this point, ASWG will revisit the request to add VIOT each
> > week.  If there have been no comments in the prior week, and no
> > further discussion during the meeting, then a vote will be taken.
> > Otherwise, there will be discussion and we try again the next
> > week.
> > 
> > The ASWG was also told that the likelihood of this definition of
> > the table changing is pretty low, and that it has been thought out
> > pretty well already.  ASWG's consideration will therefore start
> > from the assumption that it would be best _not_ to make changes.
> > 
> > So, I'll let you know what happens next week.
> 
> Thank you very much for the updates and for your support backing the
> proposal in the best delays.
> 
> Best Regards
> 
> Eric

So, there are some questions about the VIOT definition and I just
don't know enough to be able to answer them.  One of the ASWG members
is trying to understand the semantics behind the subtables.

Is there a particular set of people, or mailing lists, that I can
point to to get the questions answered?  Ideally it would be one
of the public lists where it has already been discussed, but an
individual would be fine, too.  No changes have been proposed, just
some questions asked.

Thanks.

> > 
> >>
> >>>
> >>> Not that I know, but I don't see why it's a must.
> >>>
> >>>> So what progress has been made with the ACPI table specification, is it
> >>>> just a matter of time to get it approved or are there concerns?
> >>>>
> >>>> Regards,
> >>>>
> >>>> 	Joerg
> >>>
> >>
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

