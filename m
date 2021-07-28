Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF2E3D96AA
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jul 2021 22:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhG1UZR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jul 2021 16:25:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231268AbhG1UZR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jul 2021 16:25:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B542160F12;
        Wed, 28 Jul 2021 20:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627503915;
        bh=A091a54c0uUiNdEa4DyZyzmh4FRgXhjsONTrLRgO6dU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=F3T/qYyarYoOhflabSANAGrX1x6WIiO7qAAAn9kSiZkJBGedQh+Rx1XL2qOTJMX27
         V5Vkp8hEUBlf2mAb4cD7eoLEGHNRrbSNKUPG/hWCzDyfY8nMihNVaYVYSJgSpn9rHl
         zUfDGZZWoI2Gbzp6ccHlLALnSe+MzSiBIRm4NPsf/XSrTnoCPtwW/2l+mlqsGQHD4N
         iyjFEOFR7F9844Y4Ir2d7feowZ7SBwkgOqfrU6XmGGTKLxW2tV3Pc5wwXXS27jZ5O3
         SvwMIyCtXZkWv2LpO+swwb6ySF1SO8ks4tnELfgugjMaNCJWG63X/WYqISslkLwadp
         fQQBs7B/L7khA==
Date:   Wed, 28 Jul 2021 15:25:13 -0500
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
Subject: Re: [PATCH v10 2/8] PCI: Add new array for keeping track of ordering
 of reset methods
Message-ID: <20210728202513.GA848092@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f89b5c62-56d5-3437-f8e7-24c5d74a7afa@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 28, 2021 at 01:31:19PM -0500, Shanker R Donthineni wrote:
> Hi Bjorn,
> 
> On 7/27/21 5:59 PM, Bjorn Helgaas wrote:
> >> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >> index fefa6d7b3..42440cb10 100644
> >> --- a/drivers/pci/pci.c
> >> +++ b/drivers/pci/pci.c
> >> @@ -72,6 +72,14 @@ static void pci_dev_d3_sleep(struct pci_dev *dev)
> >>               msleep(delay);
> >>  }
> >>
> >> +int pci_reset_supported(struct pci_dev *dev)
> >> +{
> >> +     u8 null_reset_methods[PCI_NUM_RESET_METHODS] = { 0 };
> >> +
> >> +     return memcmp(null_reset_methods,
> >> +                   dev->reset_methods, sizeof(null_reset_methods));
> > I think "return dev->reset_methods[0] != 0;" is sufficient, isn't it?
> >
> 
> Agree with you, it simplifies code logic and can be moved to
> "include/linux/pci.h" with inline definition. Can we change return
> type to 'bool' instead of 'int' ?

Does it need to be exported to drivers?  Looks like it's only used
inside drivers/pci/, so it shouldn't be in include/linux/pci.h.

Making it bool is fine with me.

> static inline bool pci_reset_supported(struct pci_dev *dev)
> {  
>     return !!dev->reset_methods[0];
> }
> 
