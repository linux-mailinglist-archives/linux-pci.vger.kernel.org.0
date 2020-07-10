Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E6321BF34
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jul 2020 23:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgGJV2z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jul 2020 17:28:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:38481 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbgGJV2z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Jul 2020 17:28:55 -0400
IronPort-SDR: /cGw18/t93ETKUtLBi3nHl2ejpSgkeBjcuEf8wibmWlGyW7l+PZ8iVIDPEmCEjx2nOVJIVUcf7
 m/eCkgHegSyw==
X-IronPort-AV: E=McAfee;i="6000,8403,9678"; a="128358809"
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="128358809"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2020 14:28:54 -0700
IronPort-SDR: QtJ0Svtzt5o6heD9E9eaHtgim1i9h9gjLpXXGOf4JZ7gPfDKJXpNrqYhYQmshlI4nLU8n/Z1Rf
 QFQDNbv/W8kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,336,1589266800"; 
   d="scan'208";a="306677452"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.25])
  by fmsmga004.fm.intel.com with ESMTP; 10 Jul 2020 14:28:53 -0700
Date:   Fri, 10 Jul 2020 14:28:53 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rajat Jain <rajatja@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, lalithambika.krishnakumar@intel.com,
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
        oohall@gmail.com, Saravana Kannan <saravanak@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v4 4/4] PCI/ACS: Enable PCI_ACS_TB for
 untrusted/external-facing devices
Message-ID: <20200710212853.GA328472@otc-nc-03>
References: <20200707224604.3737893-4-rajatja@google.com>
 <20200710202922.GA77140@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710202922.GA77140@bjorn-Precision-5520>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn


On Fri, Jul 10, 2020 at 03:29:22PM -0500, Bjorn Helgaas wrote:
> On Tue, Jul 07, 2020 at 03:46:04PM -0700, Rajat Jain wrote:
> > When enabling ACS, enable translation blocking for external facing ports
> > and untrusted devices.
> > 
> > Signed-off-by: Rajat Jain <rajatja@google.com>
> > ---
> > v4: Add braces to avoid warning from kernel robot
> >     print warning for only external-facing devices.
> > v3: print warning if ACS_TB not supported on external-facing/untrusted ports.
> >     Minor code comments fixes.
> > v2: Commit log change
> > 
> >  drivers/pci/pci.c    |  8 ++++++++
> >  drivers/pci/quirks.c | 15 +++++++++++++++
> >  2 files changed, 23 insertions(+)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 73a8627822140..a5a6bea7af7ce 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -876,6 +876,14 @@ static void pci_std_enable_acs(struct pci_dev *dev)
> >  	/* Upstream Forwarding */
> >  	ctrl |= (cap & PCI_ACS_UF);
> >  
> > +	/* Enable Translation Blocking for external devices */
> > +	if (dev->external_facing || dev->untrusted) {
> > +		if (cap & PCI_ACS_TB)
> > +			ctrl |= PCI_ACS_TB;
> > +		else if (dev->external_facing)
> > +			pci_warn(dev, "ACS: No Translation Blocking on external-facing dev\n");
> > +	}
> 
> IIUC, this means that external devices can *never* use ATS and can
> never cache translations.  And (I guess, I'm not an expert) it can
> also never use the Page Request Services?

Yep, sounds like it.

> 
> Is this what we want?  Do we have any idea how many external devices
> this will affect or how much of a performance impact they will see?
> 
> Do we need some kind of override or mechanism to authenticate certain
> devices so they can use ATS and PRI?

Sounds like we would need some form of an allow-list to start with so we
can have something in the interim. 

I suppose a future platform might have a facilty to ensure ATS is secure and
authenticated we could enable for all of devices in the system, in addition
to PCI CMA/IDE. 

I think having a global override to enable all devices so platform can
switch to current behavior, or maybe via a cmdline switch.. as much as we
have a billion of those, it still gives an option in case someone needs it.



> 
> If we do decide this is the right thing to do, I think we need to
> expand the commit log a bit, because this is potentially a significant
> user-visible change.
> 
> >  	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
> >  }
> >  
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index b341628e47527..bb22b46c1d719 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -4934,6 +4934,13 @@ static void pci_quirk_enable_intel_rp_mpc_acs(struct pci_dev *dev)
> >  	}
> >  }
> >  
> > +/*
> > + * Currently this quirk does the equivalent of
> > + * PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF
> > + *
> > + * TODO: This quirk also needs to do equivalent of PCI_ACS_TB,
> > + * if dev->external_facing || dev->untrusted
> > + */
> >  static int pci_quirk_enable_intel_pch_acs(struct pci_dev *dev)
> >  {
> >  	if (!pci_quirk_intel_pch_acs_match(dev))
> > @@ -4973,6 +4980,14 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
> >  	ctrl |= (cap & PCI_ACS_CR);
> >  	ctrl |= (cap & PCI_ACS_UF);
> >  
> > +	/* Enable Translation Blocking for external devices */
> > +	if (dev->external_facing || dev->untrusted) {
> > +		if (cap & PCI_ACS_TB)
> > +			ctrl |= PCI_ACS_TB;
> > +		else if (dev->external_facing)
> > +			pci_warn(dev, "ACS: No Translation Blocking on external-facing dev\n");
> > +	}
> > +
> >  	pci_write_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, ctrl);
> >  
> >  	pci_info(dev, "Intel SPT PCH root port ACS workaround enabled\n");
> > -- 
> > 2.27.0.212.ge8ba1cc988-goog
> > 
