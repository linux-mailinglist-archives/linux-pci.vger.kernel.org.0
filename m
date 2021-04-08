Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896EA35884F
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 17:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbhDHP0K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 11:26:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231791AbhDHP0I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Apr 2021 11:26:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19BA861103;
        Thu,  8 Apr 2021 15:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617895557;
        bh=BsPq63IUE5jWhjlxvaXJnOCOfTCS2YyV8dn/2ZoA/lo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eRDFNz9LLPJlb7/BO6iRuz8b20it6l/spqCku3w8cbhaSpg/uE6wm3qFl2VgumX+J
         QGl8TcngavSZ94kjkK+MfyRPumJaImgi+zhrvAdWTUUIyNYstatpSWj9NYi58erxTZ
         5v9E9NY7ZXetBWUcDuzu0Pnrz2le9TKBGNjXLCLfFGJ8NyCUyJrtLHCQCVH5j1D1j3
         5M2euKQTUg5rF2AhXOefkgpw1/xl2QFW0A7nsSG/7cub4Z8UI5jjFr9vl2KCUP8AcA
         8xLwFVczImw0H9sfcx/mqXDSRojENwVBX1wAc0ibb/LNz9Nc8fIuDRnqXI512nz71n
         7LhpciDYlH++Q==
Date:   Thu, 8 Apr 2021 10:25:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linfeilong <linfeilong@huawei.com>
Subject: Re: [PATCH v2] ACPI / hotplug / PCI: fix memory leak in enable_slot()
Message-ID: <20210408152555.GA1928260@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j2a803ye6KYzM9dZ_inCTqiwmN7UvAdYeynk+A9F97Fg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 08, 2021 at 05:18:46PM +0200, Rafael J. Wysocki wrote:
> On Thu, Mar 25, 2021 at 8:27 AM Zhiqiang Liu <liuzhiqiang26@huawei.com> wrote:
> >
> > From: Feilong Lin <linfeilong@huawei.com>
> >
> > In enable_slot() in drivers/pci/hotplug/acpiphp_glue.c, if pci_get_slot()
> > will return NULL, we will do not set SLOT_ENABLED flag of slot. if one
> > device is found by calling pci_get_slot(), its reference count will be
> > increased. In this case, we did not call pci_dev_put() to decrement the
> > its reference count, the memory of the device (struct pci_dev type) will
> > leak.
> >
> > Fix it by calling pci_dev_put() to decrement its reference count after that
> > pci_get_slot() returns a PCI device.
> >
> > Signed-off-by: Feilong Lin <linfeilong@huawei.com>
> > Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> > --
> > v2: rewrite subject and commit log as suggested by Bjorn Helgaas.
> 
> The fix is correct AFAICS, so
> 
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Bjorn, has this been applied already?  If not, do you want me to take
> it or are you going to queue it up yourself?

I'll pick it up; thanks for the review and the reminder!

> > ---
> >  drivers/pci/hotplug/acpiphp_glue.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> > index 3365c93abf0e..f031302ad401 100644
> > --- a/drivers/pci/hotplug/acpiphp_glue.c
> > +++ b/drivers/pci/hotplug/acpiphp_glue.c
> > @@ -533,6 +533,7 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
> >                         slot->flags &= ~SLOT_ENABLED;
> >                         continue;
> >                 }
> > +               pci_dev_put(dev);
> >         }
> >  }
> >
> > --
> > 2.19.1
> >
