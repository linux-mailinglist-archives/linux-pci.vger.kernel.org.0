Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB0E1F33B8
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 07:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgFIF5F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 01:57:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727122AbgFIF5F (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jun 2020 01:57:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CD37207F9;
        Tue,  9 Jun 2020 05:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591682224;
        bh=l6ipBhA5f8rK4KSDgULx6FzzquE+2+fxxHeCVYrSBu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M9adgHhT8SWWIYkFtoCSNXvqZzHrk6SOVJQiT5pfWbSeJKYwmIC8A5rT7OdSYT2vn
         KIddEWjzGL4Vaf8Jfr7QXltgcPIJo2amSuloXTLkzl8pJWdQGaA5AQp4E59UdZk9mF
         bFBpt50gWgbwlk6F2AqEaCxz6sw45MgXj7p40Afc=
Date:   Tue, 9 Jun 2020 07:57:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jesse Barnes <jsbarnes@google.com>
Cc:     Rajat Jain <rajatja@google.com>, Rajat Jain <rajatxjain@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Zubin Mithra <zsm@google.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Restrict the untrusted devices, to bind to only a set of
 "whitelisted" drivers
Message-ID: <20200609055702.GB497287@kroah.com>
References: <20200603060751.GA465970@kroah.com>
 <CACK8Z6EXDf2vUuJbKm18R6HovwUZia4y_qUrTW8ZW+8LA2+RgA@mail.gmail.com>
 <20200603121613.GA1488883@kroah.com>
 <CACK8Z6EOGduHX1m7eyhFgsGV7CYiVN0en4U0cM4BEWJwk2bmoA@mail.gmail.com>
 <20200605080229.GC2209311@kroah.com>
 <CACK8Z6GR7-wseug=TtVyRarVZX_ao2geoLDNBwjtB+5Y7VWNEQ@mail.gmail.com>
 <20200607113632.GA49147@kroah.com>
 <CAJmaN=m5cGc8019LocvHTo-1U6beA9-h=T-YZtQEYEb_ry=b+Q@mail.gmail.com>
 <20200608175015.GA457685@kroah.com>
 <CAJmaN=mvnrLLkJC=6ddO_Rj+1FpRHoQzWFo9W3AZmsW_qS5CYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJmaN=mvnrLLkJC=6ddO_Rj+1FpRHoQzWFo9W3AZmsW_qS5CYQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 08, 2020 at 11:29:58AM -0700, Jesse Barnes wrote:
> > Now, as to you all getting some sort of "Hardware flag" to determine
> > "inside" vs. "outside" devices, hah, good luck!  It took us a long time
> > to get that for USB, and even then, BIOSes lie and get it wrong all the
> > time.  So you will have to also deal with that in some way, for your
> > userspace policy.
> 
> I think that's inherently platform specific to some extent.  We can do
> it with our coreboot based firmware, but there's no guarantee other
> vendors will adopt the same approach.  But I think at least for the
> ChromeOS ecosystem we can come up with something that'll work, and
> allow us to dtrt in userspace wrt driver binding.

Why not work with the UEFI group to add this to their spec so that it
will work for all future firmware releases, not just your
vendor-specific one?  :)

thanks,

greg k-h
