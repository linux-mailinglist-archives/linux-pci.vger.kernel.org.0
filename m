Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2964B2161FE
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jul 2020 01:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgGFXSv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jul 2020 19:18:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbgGFXSv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jul 2020 19:18:51 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDBE2205CB;
        Mon,  6 Jul 2020 23:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594077530;
        bh=yaC/st+ngw5Sh4IXqu2ErvTyb0SMPwfqL4dOJPo6D3A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bTaYqMbL88uMK3kvbCJf8qkcSU110j4Hlc2k73yEmfzzHiYvXa2NP6Y8ZNfRQpwnL
         6drEEsZORiBloqcgUry8kQyZyf+NHp/oae19Zl6eTDHDBmy9NhZPRPypZBMK6qUGx6
         x6sqtPhq85bUfdqMeYAhV6p248TsOWw60IZQN4fo=
Date:   Mon, 6 Jul 2020 18:18:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver O'Halloran <oohall@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2 1/7] PCI: Keep the ACS capability offset in device
Message-ID: <20200706231844.GA168946@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACK8Z6GtOH4o6J17YXnesf0VvQSQRTCR011RRD2U7gkrwA8ziQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 06, 2020 at 03:16:42PM -0700, Rajat Jain wrote:
> On Mon, Jul 6, 2020 at 8:58 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, Jun 29, 2020 at 09:49:37PM -0700, Rajat Jain wrote:

> > > +static void pci_enable_acs(struct pci_dev *dev);
> >
> > I don't think we need this forward declaration, do we?
> 
> We need it unless we move its definition further up in the file:
> 
> drivers/pci/pci.c: In function ‘pci_restore_state’:
> drivers/pci/pci.c:1551:2: error: implicit declaration of function
> ‘pci_enable_acs’; did you mean ‘pci_enable_ats’?
> [-Werror=implicit-function-declaration]
>  1551 |  pci_enable_acs(dev);
> 
> Do you want me to move it up in the file so that we do not need the
> forward declaration?

Yes, please move it.  Maybe a preliminary patch that moves it but
doesn't change anything else.

I think I thought you had renamed the function, in which case you
could tell from the patch itself.  But I was mistaken!

> > > @@ -4653,7 +4653,7 @@ static int pci_quirk_intel_spt_pch_acs(struct pci_dev *dev, u16 acs_flags)
> > >       if (!pci_quirk_intel_spt_pch_acs_match(dev))
> > >               return -ENOTTY;
> > >
> > > -     pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
> > > +     pos = dev->acs_cap;
> >
> > I assume you verified that all these quirks are FINAL quirks, since
> > pci_init_capabilities() is called after HEADER quirks.  I'll
> > double-check before applying this.
> 
> None of these quirks are applied via DECLARE_PCI_FIXUP_*(). All these
> quirks are called (directly or indirectly) from either
> pci_enable_acs() or pci_acs_enabled(),
> 
> EXCEPT
> 
> pci_idt_bus_quirk(). That one is called from
> pci_bus_read_dev_vendor_id() which should be called only after the
> parent bridge has been added and setup correctly.
> 
> So it looks all good to me.

Great, thanks for checking that.
