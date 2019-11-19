Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 180F4102F9A
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2019 23:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfKSW5Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Nov 2019 17:57:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:50628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfKSW5Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Nov 2019 17:57:24 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41B882245B;
        Tue, 19 Nov 2019 22:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574204243;
        bh=MfxbIsx2AwLtCUhkamnT0UAwFBGbj1YyWpFNWLIPhMM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=E52+6cgLfMfo9ceaHCYZ+iAp4zf56dFMAe0NcguaKJCgzSyAD9J19ZM6oLMsh0R0R
         JOkfl/XLao+RYszehEsWWTShlZeOhUuIiZOAk7lvjnwKmyQlFn7Vd+w0/9CGSoA0i4
         Cc2z3+YhUvhSgeBDsRLdaEMY+KWsj10hEhoT7Wz0=
Date:   Tue, 19 Nov 2019 16:57:21 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Karol Herbst <kherbst@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>,
        Daniel Drake <drake@endlessm.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
Message-ID: <20191119225721.GA237491@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACO55tu+8VeyMw1Lb6QvNspaJm9LDgoRbooVhr0s3v9uBt=feg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Daniel, Vidya, Thierry; thread starts at
https://lore.kernel.org/r/20191017121901.13699-1-kherbst@redhat.com]

On Tue, Nov 19, 2019 at 11:26:45PM +0100, Karol Herbst wrote:
> On Tue, Nov 19, 2019 at 10:50 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Thu, Oct 17, 2019 at 02:19:01PM +0200, Karol Herbst wrote:
> > > Fixes state transitions of Nvidia Pascal GPUs from D3cold into
> > > higher device states.
> > > ...

> > > + *  - kernel crashes, as all pci reads return -1, which most code
> > > + *    isn't able to handle well enough.
> >
> > More details about these crashes would be useful as we look at
> > places that *should* be able to handle errors like this.
> 
> makes sense, I could ,orthogonal to this, make the code more robust
> if we hit issues like this in the future. What I am mostly wondering
> about is, why pci core doesn't give up if the device doesn't come
> back from D3cold? It sounds like, that the most sane thing to do
> here is to just give up and fail runtime_resume and report errors
> back to userspace trying to make use of the devices.

It's possible there's something the core could do here.  It's
interesting that we have at least three issues in this area in this
release:

  1) This NVIDIA GPU issue
  2) Daniel's issue with AMD Ryzen5/7 XHCI power-on
     (https://lore.kernel.org/r/20191014061355.29072-1-drake@endlessm.com)
  3) Vidya's issue with Intel 750 NVMe power-on
     (https://lore.kernel.org/r/20191118172310.21373-1-vidyas@nvidia.com)

Vidya's current patch is the most generic (calling pci_dev_wait() from
pci_power_up()).  That will print a warning if the device doesn't
respond, but we still don't go as far as returning errors to
runtime_resume.

This is definitely something we should consider improving in the
future.

> > > + *  - sudden shutdowns, as the kernel identified an unrecoverable error after
> > > + *    userspace tries to access the GPU.
> >
> > This doesn't fit with the others and more details might be
> > informative here as well.
> 
> yeah.. I try to get more infos on that. But at least for me (and it
> might be a distribution thing) if I execute lspci, the system shuts
> down, or at least tries to and might fail.

The lspci doesn't need to be after the failure occurs.  You can do it
immediately after boot.

If you can capture any part of the dmesg or console log of these
sudden shutdowns, that's all I'm interested in at this point.

Bjorn
