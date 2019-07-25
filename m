Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02B717539A
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2019 18:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfGYQLU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Jul 2019 12:11:20 -0400
Received: from mga06.intel.com ([134.134.136.31]:26202 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727303AbfGYQLT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Jul 2019 12:11:19 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 09:11:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,307,1559545200"; 
   d="scan'208";a="160953283"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga007.jf.intel.com with ESMTP; 25 Jul 2019 09:11:15 -0700
Date:   Thu, 25 Jul 2019 10:08:22 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Patel, Mayurkumar" <mayurkumar.patel@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Oza Pawandeep <poza@codeaurora.org>
Subject: Re: [PATCH] PCI/AER: save/restore AER registers during suspend/resume
Message-ID: <20190725160822.GB6949@localhost.localdomain>
References: <92EBB4272BF81E4089A7126EC1E7B28479A7F14D@IRSMSX101.ger.corp.intel.com>
 <1fbfe79b-0123-7305-5fc3-4963599538a3@linux.intel.com>
 <92EBB4272BF81E4089A7126EC1E7B28479A7F9BA@IRSMSX101.ger.corp.intel.com>
 <cd3cb1af-bc80-f92d-b9e4-7b7c2a9bd2fb@linux.intel.com>
 <20190724184548.GC203187@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190724184548.GC203187@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 24, 2019 at 01:45:48PM -0500, Bjorn Helgaas wrote:
> On Wed, Jul 10, 2019 at 10:36:16AM -0700, sathyanarayanan kuppuswamy wrote:
> > On 7/10/19 10:22 AM, Patel, Mayurkumar wrote:
> > > > On 7/9/19 1:00 AM, Patel, Mayurkumar wrote:
> > > > > After system suspend/resume cycle AER registers settings are
> > > > > lost. Not restoring Root Error Command Register bits if it were
> > > > > set, keeps AER interrupts disabled after system resume.
> > > > > Moreover, AER mask and severity registers are also required
> > > > > to be restored back to AER settings prior to system suspend.
> > > > > 
> > > > > Signed-off-by: Mayurkumar Patel <mayurkumar.patel@intel.com>
> > > > > ---
> > > > >    drivers/pci/pci.c      |  2 ++
> > > > >    drivers/pci/pcie/aer.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
> > > > >    include/linux/aer.h    |  4 ++++
> > > > >    3 files changed, 55 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > > index 8abc843..40d5507 100644
> > > > > --- a/drivers/pci/pci.c
> > > > > +++ b/drivers/pci/pci.c
> > > > > @@ -1340,6 +1340,7 @@ int pci_save_state(struct pci_dev *dev)
> > > > > 
> > > > >    	pci_save_ltr_state(dev);
> > > > >    	pci_save_dpc_state(dev);
> > > > > +	pci_save_aer_state(dev);
> > > > >    	return pci_save_vc_state(dev);
> > > > >    }
> > > > >    EXPORT_SYMBOL(pci_save_state);
> > > > > @@ -1453,6 +1454,7 @@ void pci_restore_state(struct pci_dev *dev)
> > > > >    	pci_restore_dpc_state(dev);
> > > > > 
> > > > >    	pci_cleanup_aer_error_status_regs(dev);
> > > > > +	pci_restore_aer_state(dev);
> > > > > 
> > > > >    	pci_restore_config_space(dev);
> > > > > 
> > > > > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > > > > index b45bc47..1acc641 100644
> > > > > --- a/drivers/pci/pcie/aer.c
> > > > > +++ b/drivers/pci/pcie/aer.c
> > > > > @@ -448,6 +448,54 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
> > > > >    	return 0;
> > > > >    }
> > > > > 
> > > > > +void pci_save_aer_state(struct pci_dev *dev)
> > > > > +{
> > > > > +	int pos = 0;
> > > > > +	struct pci_cap_saved_state *save_state;
> > > > > +	u32 *cap;
> > > > > +
> > > > > +	if (!pci_is_pcie(dev))
> > > > > +		return;
> > > > > +
> > > > > +	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ERR);
> > > > > +	if (!save_state)
> > > > > +		return;
> > > > > +
> > > > > +	pos = dev->aer_cap;
> > > > > +	if (!pos)
> > > > > +		return;
> > > > > +
> > > > > +	cap = &save_state->cap.data[0];
> > > > > +	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, cap++);
> > > > > +	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, cap++);
> > > > > +	pci_read_config_dword(dev, pos + PCI_ERR_COR_MASK, cap++);
> > > > > +	pci_read_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, cap++);
> 
> > > > I don't see AER driver modifying UNCOR_MASK/SEVER/COR_MASK register. If
> > > > all it has is default value then why do you want to preserve it ?
> > > > 
> > > Thanks for reply.
> > > You are right about UNCOR_MASK/SEVER/COR_MASK mask AER driver
> > > leaves untouched, But IMHO users for example can use "setpci" to
> > > unmask specific errors and its severity based on their debugging
> > > requirement on Root port and/or Endpoint. So during resume, if
> > > PCIe endpoint fails due to any error which by default stays masked
> > > then it can't be catched and/or debugged.  Moreover, Endpoint
> > > driver may also unmask during "driver probe" certain specific
> > > errors for endpoint, which needs to be restored while resume.
> > 
> > Isn't these registers configuration usually done by firmware ? I
> > think user application rarely touch them. Also, IMO,
> > Caching/Restoring registers under the assumption that it might be
> > useful for user if they modified it is not a convincing argument.
> > But I will let Bjorn and others decide whether its alright to cache
> > these registers.
> 
> I think the ideal user experience would be "suspend/resume has no
> effect on any configuration".  That would argue for saving/restoring
> registers even if we think it's unlikely the user would change them.

The call to pci_save_state most likely occurs long before a user has an
opportunity to alter these regsiters, though. Won't this just restore
what was previously there, and not the state you changed it to?

> > > @Bjorn/Anybody else has any opinion to cache/restore
> > > UNCOR_MASK/SEVER/COR_MASK registers?  Please help to comment.
> > > 
> > > > Also, any reason for not preserving ECRC settings ?
> > > No specific reason. I can incorporte that with v2 of this patchset
> > > but I don’t have HW on which I can validate that.
> 
> I think we should preserve ECRC settings as well for the same reason.
> 
> > > > > +}
> > > > > +
> > > > > +void pci_restore_aer_state(struct pci_dev *dev)
> > > > > +{
> > > > > +	int pos = 0;
> > > > > +	struct pci_cap_saved_state *save_state;
> > > > > +	u32 *cap;
> > > > > +
> > > > > +	if (!pci_is_pcie(dev))
> > > > > +		return;
> > > > > +
> > > > > +	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ERR);
> > > > > +	if (!save_state)
> > > > > +		return;
> > > > > +
> > > > > +	pos = dev->aer_cap;
> > > > > +	if (!pos)
> > > > > +		return;
> > > > > +
> > > > > +	cap = &save_state->cap.data[0];
> > > > > +	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, *cap++);
> > > > > +	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, *cap++);
> > > > > +	pci_write_config_dword(dev, pos + PCI_ERR_COR_MASK, *cap++);
> > > > > +	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, *cap++);
> > > > > +}
> > > > > +
> > > > >    void pci_aer_init(struct pci_dev *dev)
> > > > >    {
> > > > >    	dev->aer_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
> > > > > @@ -1396,6 +1444,7 @@ static int aer_probe(struct pcie_device *dev)
> > > > >    		return status;
> > > > >    	}
> > > > > 
> > > > > +	pci_add_ext_cap_save_buffer(port, PCI_EXT_CAP_ID_ERR, sizeof(u32) * 4);
> > > > >    	aer_enable_rootport(rpc);
> > > > >    	pci_info(port, "enabled with IRQ %d\n", dev->irq);
> > > > >    	return 0;

You are allocating the capability save buffer in aer_probe(), so this
save/restore applies only to root ports. But you mention above that you
want to restore end devices, right?
