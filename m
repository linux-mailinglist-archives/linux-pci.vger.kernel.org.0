Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FCE3D983E
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 00:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbhG1WQk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jul 2021 18:16:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231982AbhG1WQk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jul 2021 18:16:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4AAE0603E9;
        Wed, 28 Jul 2021 22:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627510598;
        bh=eFciqfWNmyLu0Hy7m//jYdIb3XQRAWS7pAgCiQ+QOrY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TpBqYtzGa+W1ndTSO0DuTp5u4MzXsIXirVbD3RxaB90Mc9xEMTbMent/ltieHiMpf
         35ajIt87rvIn3Dx0JSyKKHoGzYCUw7epqi9oQlDhQ/4S72NHxJokeBjUfSaIR18jKJ
         TaMw6pgH+gMz9ea5srkjmHW9LSQgKHrUM1ylvTD6rWVjINQkwhntV3jgcbaxLKTOBg
         tgt8LuObwbUjZHbtDHsk34nO3qKy+YGuOmGcG1M/L28FF+dhmUsHbA1t+oj++WldpI
         Y3JQal54fTsOIDF1psZ6QhGAMUx2mtjhvGyehF5rOXu2ev7xPlz2iAwxDA1KXpU+T4
         JsA8sGbfUFyMg==
Date:   Wed, 28 Jul 2021 17:16:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shanker R Donthineni <sdonthineni@nvidia.com>
Cc:     Amey Narkhede <ameynarkhede03@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Sinan Kaya <okaya@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v10 1/8] PCI: Add pcie_reset_flr to follow calling
 convention of other reset methods
Message-ID: <20210728221636.GA858116@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64a0049e-00dc-8b10-6c9a-0b270c0a181d@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 28, 2021 at 04:58:14PM -0500, Shanker R Donthineni wrote:
> On 7/28/21 3:23 PM, Bjorn Helgaas wrote:
> > On Wed, Jul 28, 2021 at 01:54:16PM -0500, Shanker R Donthineni wrote:
> >> On 7/27/21 5:12 PM, Bjorn Helgaas wrote:
> >>> On Fri, Jul 09, 2021 at 06:08:06PM +0530, Amey Narkhede wrote:
> >>>> Add has_pcie_flr bitfield in struct pci_dev to indicate support for PCIe
> >>>> FLR to avoid reading PCI_EXP_DEVCAP multiple times.

> >> -       pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
> >> -       return cap & PCI_EXP_DEVCAP_FLR;
> >> +       return !!FIELD_GET(PCI_EXP_DEVCAP_FLR, dev->devcap);
> >
> > Nice, thanks for reminding me of FIELD_GET().  I like how that works
> > without having to #define *_SHIFT values.  I personally don't care for
> > "!!" and would probably write something like:
> >
> >   return FIELD_GET(PCI_EXP_DEVCAP_FLR, dev->devcap) == 1;
> 
> Both are same since FLR is a single bit value.

Right; this is a style preference, not a correctness question.
