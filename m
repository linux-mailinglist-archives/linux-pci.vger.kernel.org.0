Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF7841DE46
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 17:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347405AbhI3QA4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 12:00:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57142 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347326AbhI3QAz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Sep 2021 12:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633017552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9CLOOKqnl6WBTiVh9cnZX+K/sEpCo7/g2qzibCOpSjw=;
        b=WFfJsIce6l1rBp9X4Yi/5B9Dabs2qryT18zWK+ssgoXw+D4TZUV9znp5Ro/UqRq+34UsaZ
        x6pfZUY7Deduxndoqav9/5LW9gP4oUYVFMCOSvsfZ/9dM2H/A336qWiV26cXjFdAOtWSdh
        jHTwrGSXPUOZbp9xpvNbVvi82YDNA5Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-NXVmb8NHOxqiHHbeXOS8rw-1; Thu, 30 Sep 2021 11:59:11 -0400
X-MC-Unique: NXVmb8NHOxqiHHbeXOS8rw-1
Received: by mail-wr1-f69.google.com with SMTP id j15-20020a5d564f000000b00160698bf7e9so1835219wrw.13
        for <linux-pci@vger.kernel.org>; Thu, 30 Sep 2021 08:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9CLOOKqnl6WBTiVh9cnZX+K/sEpCo7/g2qzibCOpSjw=;
        b=CKfwylvXWKI1+UWwDP8dTobqYxbfGVjtgpRWbIDAoocYeU3CgMOw8cn4RUIyBMnj1j
         oZUkT0SuwFPsXb2gEtzKoquWOjXsDv3yL4iLNssUnd9aZ42ACrVKCjZoeBmm0DiSWkQx
         NbR2w70loZkO2U2fFXCX1enXFbvaO5XIrg9JwNjXmGG0KsQHud4gELi5ITxazH+lAlqK
         tDedHqyA5dgJ6oPkHne5N0dDnvDCO4R5AhAf3GnGm+m4s8Hs2uetnM0STXS912fUfVhz
         kAAKeT0VQJ11sZ9IoXkcdVmKwEJvSwYOyB/nIbPzCJ6NH+c6C8PNX+ii9PRfTtC5SImL
         uVww==
X-Gm-Message-State: AOAM533o/4kcUT0JvwAQClE0zOULKsUz01Fh3UaxUqCT3zzfXNTlKGlG
        kjLu1OWiyQUxv3H8SGlg7hTl3qXVN1cxUH1STEeZRImX7N/YcOttcA/4ADXxgFT0sFbR/FR2VhM
        iHTKTjmVtyLPFcRjCR+lK
X-Received: by 2002:adf:c7c2:: with SMTP id y2mr6859870wrg.248.1633017550251;
        Thu, 30 Sep 2021 08:59:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy42E8my5muvsE8Nz78EmU3Z+uZP9H3yPkno0xob4dMAYSNcsCrkwFOYhLWIW8NasAhP33f4A==
X-Received: by 2002:adf:c7c2:: with SMTP id y2mr6859853wrg.248.1633017550085;
        Thu, 30 Sep 2021 08:59:10 -0700 (PDT)
Received: from redhat.com ([2.55.134.220])
        by smtp.gmail.com with ESMTPSA id o19sm3590521wrg.60.2021.09.30.08.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 08:59:09 -0700 (PDT)
Date:   Thu, 30 Sep 2021 11:59:04 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jason Wang <jasowang@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-usb@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 2/6] driver core: Add common support to skip probe for
 un-authorized devices
Message-ID: <20210930115243-mutt-send-email-mst@kernel.org>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065807-mutt-send-email-mst@kernel.org>
 <YVXBNJ431YIWwZdQ@kroah.com>
 <20210930144305.GA464826@rowland.harvard.edu>
 <20210930104924-mutt-send-email-mst@kernel.org>
 <20210930153509.GF464826@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930153509.GF464826@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 30, 2021 at 11:35:09AM -0400, Alan Stern wrote:
> On Thu, Sep 30, 2021 at 10:58:07AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Sep 30, 2021 at 10:43:05AM -0400, Alan Stern wrote:
> > > I don't see any point in talking about "untrusted drivers".  If a 
> > > driver isn't trusted then it doesn't belong in your kernel.  Period.  
> > > When you load a driver into your kernel, you are implicitly trusting 
> > > it (aside from limitations imposed by security modules).
> > 
> > Trusting it to do what? Historically a ton of drivers did not
> > validate input from devices they drive. Most still don't.
> 
> Trusting it to behave properly (i.e., not destroy your system, among 
> other things).

I don't think the current mitigations under discussion here are about
keeping the system working. In fact most encrypted VM configs tend to
stop booting as a preferred way to handle security issues.

> The fact that many drivers haven't been trustworthy is beside the 
> point.  By loading them into your kernel, you are trusting them 
> regardless.  In the end, you may regret having done so.  :-(
> 
> Alan Stern



-- 
MST

