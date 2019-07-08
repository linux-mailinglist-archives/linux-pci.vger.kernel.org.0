Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11CB66211A
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2019 17:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732091AbfGHPFf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Jul 2019 11:05:35 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34359 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfGHPFe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Jul 2019 11:05:34 -0400
Received: by mail-pl1-f193.google.com with SMTP id i2so8437577plt.1
        for <linux-pci@vger.kernel.org>; Mon, 08 Jul 2019 08:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H9EINtO6YwQJ4ZxIKBrIJIpE+ticnzKw5UC4agQffbk=;
        b=o7cOjfvg2jSxFWlm3udFfMurqkl7jt5qfMsKpKWAAYUSE81YJtq2rBKxk+JSOXVIyB
         YBC0JGPoi97/mjdg+PWQDF+ykAdrco0wjdORXwT4eIKlyIOdFdVeUqV3MOfs1+k233IW
         YZIUF1jIEAUeTQV4F5g8s5Yn0H0qTxBfjZ5Uqb0bV11oGagTfwYccNJPFwiFEoHZFias
         mWkOherrJHDPiK10Vd3ptTm8lpLjePtpuRvWkC8V5T+T+KnpnalI5oQUIptv3c20jxYF
         RgaH5ABcTLPOjOwZjiNrjQ3rNrk8csMfU0ZWd1ht6G1hugtoF1OdhTuUyQbULd2H33fK
         EY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H9EINtO6YwQJ4ZxIKBrIJIpE+ticnzKw5UC4agQffbk=;
        b=JS5F24QPw5IZzqqwqfDea1ZSEJsd044jjbk5UoLttPUldR9ubZb+6Vu8aa85zJpCUl
         z7Lf1iasHhwhLlIIUAx97HmARlk9DRAoPPV/rg+peAKEZGPJoDNvDS1Am0vOhppiTjqc
         YvdudS7ZZ/JLy0WPJgznSMeZ6ESWIhm/Jfg8D841arFxgoFbp6ViEco3QVU9Df4sTtdG
         1CU2Hm51XuPSmiE0Fw2Bzp/8dZpaSkSmIZzkz0gHCqwGdfONHPj8WwM+08ppFomLbORT
         SbPJQRFQ3HhNvZ13qWTM6EZPD0ZSJRON7fJdioXNbV5pLZLESK8UgPFOPm6sXB/3vEvN
         k6MA==
X-Gm-Message-State: APjAAAU7bWCmj+lcZ0QBHjw3vP8+n/Km6fJI7PC0kf/yrrXP+iktZTCK
        7eHM/+Asia5jaMM+c07QC97CiA==
X-Google-Smtp-Source: APXvYqwVnbCn84uvEYTzrqNXCKBSi6I5x4jEwsn1sRjK7qh2dm1vi66uyMzQcnk061y7dVnI4L1BlA==
X-Received: by 2002:a17:902:a60d:: with SMTP id u13mr25729049plq.144.1562598334101;
        Mon, 08 Jul 2019 08:05:34 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id j1sm19833019pfe.101.2019.07.08.08.05.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 08:05:34 -0700 (PDT)
Date:   Mon, 8 Jul 2019 08:05:27 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Haiyang Zhang <haiyangz@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jake Oshins <jakeo@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Yuehaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH v2] PCI: hv: fix pci-hyperv build when SYSFS not enabled
Message-ID: <20190708080527.138e18e9@hermes.lan>
In-Reply-To: <c1261e6d-84c3-4874-5c32-a3988c5a85d6@infradead.org>
References: <535f212f-e111-399d-4ad0-82d2ae505e48@infradead.org>
        <DM6PR21MB13373F2B76558930CC368E17CAFB0@DM6PR21MB1337.namprd21.prod.outlook.com>
        <c1261e6d-84c3-4874-5c32-a3988c5a85d6@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 7 Jul 2019 10:46:22 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 7/3/19 11:06 AM, Haiyang Zhang wrote:
> > 
> >   
> >> -----Original Message-----
> >> From: Randy Dunlap <rdunlap@infradead.org>
> >> Sent: Wednesday, July 3, 2019 12:59 PM
> >> To: LKML <linux-kernel@vger.kernel.org>; linux-pci <linux-  
> >> pci@vger.kernel.org>  
> >> Cc: Matthew Wilcox <willy@infradead.org>; Jake Oshins
> >> <jakeo@microsoft.com>; KY Srinivasan <kys@microsoft.com>; Haiyang
> >> Zhang <haiyangz@microsoft.com>; Stephen Hemminger
> >> <sthemmin@microsoft.com>; Sasha Levin <sashal@kernel.org>; Bjorn
> >> Helgaas <bhelgaas@google.com>; linux-hyperv@vger.kernel.org; Dexuan
> >> Cui <decui@microsoft.com>; Yuehaibing <yuehaibing@huawei.com>
> >> Subject: [PATCH v2] PCI: hv: fix pci-hyperv build when SYSFS not enabled
> >>
> >> From: Randy Dunlap <rdunlap@infradead.org>
> >>
> >> Fix build of drivers/pci/controller/pci-hyperv.o when
> >> CONFIG_SYSFS is not set/enabled by adding stubs for
> >> pci_create_slot() and pci_destroy_slot().
> >>
> >> Fixes these build errors:
> >>
> >> ERROR: "pci_destroy_slot" [drivers/pci/controller/pci-hyperv.ko] undefined!
> >> ERROR: "pci_create_slot" [drivers/pci/controller/pci-hyperv.ko] undefined!
> >>
> >> Fixes: a15f2c08c708 ("PCI: hv: support reporting serial number as slot
> >> information")
> >>
> >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >> Cc: Matthew Wilcox <willy@infradead.org>
> >> Cc: Jake Oshins <jakeo@microsoft.com>
> >> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> >> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> >> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> >> Cc: Sasha Levin <sashal@kernel.org>
> >> Cc: Bjorn Helgaas <bhelgaas@google.com>
> >> Cc: linux-pci@vger.kernel.org
> >> Cc: linux-hyperv@vger.kernel.org
> >> Cc: Dexuan Cui <decui@microsoft.com>
> >> Cc: Yuehaibing <yuehaibing@huawei.com>
> >> ---
> >> v2:
> >> - provide non-CONFIG_SYSFS stubs for pci_create_slot() and
> >>   pci_destroy_slot() [suggested by Matthew Wilcox <willy@infradead.org>]
> >> - use the correct Fixes: tag [Dexuan Cui <decui@microsoft.com>]
> >>
> >>  include/linux/pci.h |   12 ++++++++++--
> >>  1 file changed, 10 insertions(+), 2 deletions(-)
> >>
> >> --- lnx-52-rc7.orig/include/linux/pci.h
> >> +++ lnx-52-rc7/include/linux/pci.h
> >> @@ -25,6 +25,7 @@
> >>  #include <linux/ioport.h>
> >>  #include <linux/list.h>
> >>  #include <linux/compiler.h>
> >> +#include <linux/err.h>
> >>  #include <linux/errno.h>
> >>  #include <linux/kobject.h>
> >>  #include <linux/atomic.h>
> >> @@ -947,14 +948,21 @@ int pci_scan_root_bus_bridge(struct pci_
> >>  struct pci_bus *pci_add_new_bus(struct pci_bus *parent, struct pci_dev
> >> *dev,
> >>  				int busnr);
> >>  void pcie_update_link_speed(struct pci_bus *bus, u16 link_status);
> >> +#ifdef CONFIG_SYSFS
> >> +void pci_dev_assign_slot(struct pci_dev *dev);
> >>  struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
> >>  				 const char *name,
> >>  				 struct hotplug_slot *hotplug);
> >>  void pci_destroy_slot(struct pci_slot *slot);
> >> -#ifdef CONFIG_SYSFS
> >> -void pci_dev_assign_slot(struct pci_dev *dev);
> >>  #else
> >>  static inline void pci_dev_assign_slot(struct pci_dev *dev) { }
> >> +static inline struct pci_slot *pci_create_slot(struct pci_bus *parent,
> >> +					       int slot_nr,
> >> +					       const char *name,
> >> +					       struct hotplug_slot *hotplug) {
> >> +	return ERR_PTR(-EINVAL);
> >> +}
> >> +static inline void pci_destroy_slot(struct pci_slot *slot) { }
> >>  #endif
> >>  int pci_scan_slot(struct pci_bus *bus, int devfn);
> >>  struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn);
> >>  
> > 
> > The serial number in slot info is used to match VF NIC with Synthetic NIC.
> > Without selecting SYSFS, the SRIOV feature will fail on VM on Hyper-V and
> > Azure. The first version of this patch should be used.
> > 
> > @Stephen Hemminger how do you think?

Haiyang is right, accelerated networking won't work if slot is not recorded.

So the original patch (to depend on SYSFS) or using "select SYSFS" is
are necessary.

The whole thing is a bit of "angels dancing on the head of a pin" because
there is no good reason to build kernel without SYSFS in real world.
It would just be looking for trouble. As far as I can tell it is all
about getting "make randconfig" to work in more cases.

 
