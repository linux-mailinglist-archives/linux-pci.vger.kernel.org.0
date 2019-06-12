Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1551442F74
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2019 21:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfFLTDE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jun 2019 15:03:04 -0400
Received: from mga09.intel.com ([134.134.136.24]:23178 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbfFLTDE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jun 2019 15:03:04 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2019 12:03:04 -0700
X-ExtLoop1: 1
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.145])
  by orsmga003.jf.intel.com with ESMTP; 12 Jun 2019 12:03:03 -0700
Date:   Wed, 12 Jun 2019 12:03:03 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, mike.campin@intel.com,
        Ashok Raj <ashok.raj@intel.com>,
        KarimAllah Ahmed <karahmed@amazon.de>
Subject: Re: [PATCH v2 1/1] PCI/IOV: Fix incorrect cfg_size for VF > 0
Message-ID: <20190612190303.GA29348@otc-nc-03>
References: <20190612170647.43220-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20190612121910.231368e2@x1.home>
 <0b21c76e-53f3-c35e-cebf-00719e451b11@linux.intel.com>
 <20190612125817.42909d83@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612125817.42909d83@x1.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 12, 2019 at 12:58:17PM -0600, Alex Williamson wrote:
> On Wed, 12 Jun 2019 11:41:36 -0700
> sathyanarayanan kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
> wrote:
> 
> > On 6/12/19 11:19 AM, Alex Williamson wrote:
> > > On Wed, 12 Jun 2019 10:06:47 -0700
> > > sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > >  
> > >> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > >>
> > >> Commit 975bb8b4dc93 ("PCI/IOV: Use VF0 cached config space size for
> > >> other VFs") calculates and caches the cfg_size for VF0 device before
> > >> initializing the pcie_cap of the device which results in using incorrect
> > >> cfg_size for all VF devices > 0. So set pcie_cap of the device before
> > >> calculating the cfg_size of VF0 device.
> > >>
> > >> Fixes: 975bb8b4dc93 ("PCI/IOV: Use VF0 cached config space size for
> > >> other VFs")
> > >> Cc: Ashok Raj <ashok.raj@intel.com>
> > >> Suggested-by: Mike Campin <mike.campin@intel.com>
> > >> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > >> ---
> > >>
> > >> Changes since v1:
> > >>   * Fixed a typo in commit message.
> > >>
> > >>   drivers/pci/iov.c | 1 +
> > >>   1 file changed, 1 insertion(+)
> > >>
> > >> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> > >> index 3aa115ed3a65..2869011c0e35 100644
> > >> --- a/drivers/pci/iov.c
> > >> +++ b/drivers/pci/iov.c
> > >> @@ -160,6 +160,7 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
> > >>   	virtfn->device = iov->vf_device;
> > >>   	virtfn->is_virtfn = 1;
> > >>   	virtfn->physfn = pci_dev_get(dev);
> > >> +	virtfn->pcie_cap = pci_find_capability(virtfn, PCI_CAP_ID_EXP);
> > >>   
> > >>   	if (id == 0)
> > >>   		pci_read_vf_config_common(virtfn);  
> > > Why not re-order until after we've setup pcie_cap?
> > >
> > > https://lore.kernel.org/linux-pci/20190604143617.0a226555@x1.home/T/#  
> > 
> > pci_read_vf_config_common() also caches values for properties like 
> > class, hdr_type, susbsystem_vendor/device. These values are read/used in 
> > pci_setup_device(). So if we can use cached values in 
> > pci_setup_device(), we don't have to read them from registers twice for 
> > each device.
> 
> Sorry, I missed that dependency, a bit too subtle.  It's still pretty
> ugly that pci_setup_device()->set_pcie_port_type() is the canonical
> location for setting pcie_cap and now we need to kludge it earlier.
> What about the question in the self follow-up to my patch in the link
> above, can we simply assume 4K config space on a VF?  Thanks,

There should be no issue simply reading them once? I don't know
what that exact optimization saves, unless some broken VFs didn't
actually expose all the capabilities in config space and this happens
to workaround the problem.

+ Karim

Cheers,
Ashok
