Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD8E207C08
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jun 2020 21:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404434AbgFXTLG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jun 2020 15:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404891AbgFXTLF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Jun 2020 15:11:05 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2B4C061796
        for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2020 12:11:04 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id d15so2307692edm.10
        for <linux-pci@vger.kernel.org>; Wed, 24 Jun 2020 12:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HUy3SYLieHUYRrbu7ksz+DDx5NoSGhvtwAWM7BS+NcQ=;
        b=in62/pK4305qlruXOrme3JoGaFZsG+ngmdYPd6qQJVPMZU8zi45J/cdtrR/1S2nDpG
         osC789ZrUhTlXbnv7LgWIfcNPZ+ugiqfFG98EnA6GebisxGlzNr6DE/YYjikoTyjpTr6
         dzESw5Tk70JPsArLMfUSCMZmv4fCVRQauL8U50UEeeTPu7ml5UcziaUxfOow1iLRtOE9
         g3KIkUWDlvL4VHx0ultb5v4HHmoFF5GBabUMOWbywjy9cYRAsAWsYMhAumd5XKngyrLj
         x1ScTaJ71iWX60kuFWHkQlJK56tNx/8L3F9ZHkDXvkYZVgaBDVCDP3QzFahIOfXx7tbl
         dc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HUy3SYLieHUYRrbu7ksz+DDx5NoSGhvtwAWM7BS+NcQ=;
        b=YOJ9JkuWu/tZOQTB0RuFOKy+MgwiO2BqsbeafmifB7HEX9wiGW2nHbCc52GLhVhkvV
         C7p2fjhnYQT175rBSSvfjhYn60wTIGPobSuNHVXpIcxBwP9jBmf/NDQjrNXXIIZQJe2e
         4fMW0/vNcJ6oLo+qISJrF5XVqUobFJqrZ6QauhavcGoG2tayCKA0hJdMQUkkR652cFZd
         n1HREAZ/SrVQ4RK2uR1b8tlbT9rlHRVEgCFlADPRqilsRKGnDykbwrpsoyqG1i/zkZRL
         SKcjYwR9TG60bWPwZZMVHscn093L14AT0iMb8dYOsOWYdlNteF0iKgWb3d9eztfF3XjR
         yN2w==
X-Gm-Message-State: AOAM530mM7O0ekH7tVMrBdDYU22CJfQJgJWpL+IF6KFw8y/UI7SrpmaP
        H9KWeNOnyGfEyrrEuAcJA/Ygydir/0XOQXt+XjRbCA==
X-Google-Smtp-Source: ABdhPJwTc+VdGxK7PxA2A2Hb2Q/oOwneukaqMN+TiIWLM8FMg1nGLcl6/OQXIozSlGxncNmyGtKZ6GK3+EL+fh+R4Sw=
X-Received: by 2002:aa7:d6c1:: with SMTP id x1mr27574990edr.154.1593025862677;
 Wed, 24 Jun 2020 12:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200428003214.3764-1-david.e.box@linux.intel.com>
 <20200612204820.20111-1-david.e.box@linux.intel.com> <12d36fdcdbcf438dd3aac7769e8366afd9d5aa1a.camel@linux.intel.com>
In-Reply-To: <12d36fdcdbcf438dd3aac7769e8366afd9d5aa1a.camel@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 24 Jun 2020 12:10:50 -0700
Message-ID: <CAPcyv4iYGgjmAUiKUgFBF+nm=axamYFueCkN5Jyu7yQ6w1HxLg@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] nvme: Add support for ACPI StorageD3Enable property
To:     David Box <david.e.box@linux.intel.com>
Cc:     "N, Shyjumon" <shyjumon.n@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 24, 2020 at 11:55 AM David E. Box
<david.e.box@linux.intel.com> wrote:
>
> Friendly reminder. Thanks.

Are you looking for this to be merged by ACPI with an NVMe ack, or
merged by NVMe with an ACPI ack? It sometimes helps to be explicit to
break the log jam.

>
> David
>
> On Fri, 2020-06-12 at 13:48 -0700, David E. Box wrote:
> > This patch set implements a solution for a BIOS hack used on some
> > currently
> > shipping Intel systems to address issues with power management policy
> > decisions concerning PCIe NVMe drives. Some newer Intel platforms,
> > like
> > some Comet Lake systems, require that PCIe devices use D3 when doing
> > suspend-to-idle in order to allow the platform to realize maximum
> > power
> > savings. This is particularly needed to support ATX power supply
> > shutdown
> > on desktop systems. In order to ensure this happens for root ports
> > with
> > storage devices, Microsoft apparently created this ACPI _DSD property
> > as a
> > way to override their driver policy. To my knowledge this property
> > has not
> > been discussed with the NVME specification body.
> >
> > Though the solution is not ideal, it addresses a problem that also
> > affects
> > Linux since the NVMe driver's default policy of using NVMe APST
> > during
> > suspend-to-idle would lead to higher power consumption for these
> > platforms.
> >
> > Patch 1 provides a symbol in the PCI/ACPI layer to read the property.
> > Patch 2 uses the symbol in the NVMe driver to select D3 as a quirk if
> > set.
> >
> > Changes from V2:
> >       - Export the pci_acpi_storage_d3 function for use by drivers as
> >         needed instead of modifying the pci header.
> >       - Add missing put on acpi device handle.
> >       - Add 'noacpi' module parameter to allow undoing this change.
> >       - Add info message that this is a platform quirk.
> >
> > David E. Box (2):
> >   PCI: Add ACPI StorageD3Enable _DSD support
> >   drivers/nvme: Add support for ACPI StorageD3Enable property
> >
> >  drivers/acpi/property.c |  3 +++
> >  drivers/nvme/host/pci.c | 14 ++++++++++
> >  drivers/pci/pci-acpi.c  | 59
> > +++++++++++++++++++++++++++++++++++++++++
> >  include/linux/pci.h     |  2 ++
> >  4 files changed, 78 insertions(+)
> >
>
