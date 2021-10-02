Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75DB641FB10
	for <lists+linux-pci@lfdr.de>; Sat,  2 Oct 2021 13:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbhJBLQU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 2 Oct 2021 07:16:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232805AbhJBLQU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 2 Oct 2021 07:16:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9F1A61A8F;
        Sat,  2 Oct 2021 11:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633173274;
        bh=oA5M5+lU7nwhD/rOivosaKv0XTN5QnVPtj675tCx3ks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1Z9pCS6A/zvKbuIWtPQJlXbQRYqiOOfvQxKqHhEIkajwh0e3d4lJeeYcqUtmHAduS
         9p1lU36Hd879Z2rHYNKKlSlgdoVXSyo0enKGfKCPqHiQm3G+LWvy/TiI25Ef+L2jJm
         AZPD3QuK/tbDBXoLEs5C2I3i7LyKTQCngkqZPsXE=
Date:   Sat, 2 Oct 2021 13:14:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
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
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        "Reshetova, Elena" <elena.reshetova@intel.com>
Subject: Re: [PATCH v2 4/6] virtio: Initialize authorized attribute for
 confidential guest
Message-ID: <YVg/F10PCFNOtCnL@kroah.com>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930065953-mutt-send-email-mst@kernel.org>
 <CAPcyv4hP6mtzKS-CVb-aKf-kYuiLM771PMxN2zeBEfoj6NbctA@mail.gmail.com>
 <6d1e2701-5095-d110-3b0a-2697abd0c489@linux.intel.com>
 <YVXWaF73gcrlvpnf@kroah.com>
 <1cfdce51-6bb4-f7af-a86b-5854b6737253@linux.intel.com>
 <YVaywQLAboZ6b36V@kroah.com>
 <64eb085b-ef9d-dc6e-5bfd-d23ca0149b5e@linux.intel.com>
 <20211002070218-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211002070218-mutt-send-email-mst@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 02, 2021 at 07:04:28AM -0400, Michael S. Tsirkin wrote:
> On Fri, Oct 01, 2021 at 08:49:28AM -0700, Andi Kleen wrote:
> > >   Do you have a list of specific drivers and kernel options that you
> > > feel you now "trust"?
> > 
> > For TDX it's currently only virtio net/block/console
> > 
> > But we expect this list to grow slightly over time, but not at a high rate
> > (so hopefully <10)
> 
> Well there are already >10 virtio drivers and I think it's reasonable
> that all of these will be used with encrypted guests. The list will
> grow.

What is keeping "all" drivers from being on this list?  How exactly are
you determining what should, and should not, be allowed?  How can
drivers move on, or off, of it over time?

And why not just put all of that into userspace and have it pick and
choose?  That should be the end-goal here, you don't want to encode
policy like this in the kernel, right?

thanks,

greg k-h
