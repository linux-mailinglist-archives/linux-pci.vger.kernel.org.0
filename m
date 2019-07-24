Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEBE9736D8
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2019 20:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfGXSpx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Jul 2019 14:45:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:41696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbfGXSpx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Jul 2019 14:45:53 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8B272173B;
        Wed, 24 Jul 2019 18:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563993951;
        bh=XKPmi/PPLmbA2SDQAzqL7g5D9KtzhmkiOjkoBfVdpIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xHKhhxBYejjW25mGZLVBAW7yEnVd6U1hDUk4uFWh0L8Ja99Pq74oyn8KSTJ9ecTOU
         FpFa9aC3lMmDILZRqCePo+gvRjWQsgTk0Hv6E1dfglgVLoW39cWHaNw0CPRMlKxCC2
         OVJ53a6ko5G81J4d9XI0LHOukqq3vN5W3ddzzKrI=
Date:   Wed, 24 Jul 2019 13:45:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     "Patel, Mayurkumar" <mayurkumar.patel@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Oza Pawandeep <poza@codeaurora.org>
Subject: Re: [PATCH] PCI/AER: save/restore AER registers during suspend/resume
Message-ID: <20190724184548.GC203187@google.com>
References: <92EBB4272BF81E4089A7126EC1E7B28479A7F14D@IRSMSX101.ger.corp.intel.com>
 <1fbfe79b-0123-7305-5fc3-4963599538a3@linux.intel.com>
 <92EBB4272BF81E4089A7126EC1E7B28479A7F9BA@IRSMSX101.ger.corp.intel.com>
 <cd3cb1af-bc80-f92d-b9e4-7b7c2a9bd2fb@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd3cb1af-bc80-f92d-b9e4-7b7c2a9bd2fb@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Keith, Oza, who did quite a bit of recent AER work]

Please see
https://lkml.kernel.org/r/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com
for a few incidental subject line/commit log hints.

On Wed, Jul 10, 2019 at 10:36:16AM -0700, sathyanarayanan kuppuswamy wrote:
> On 7/10/19 10:22 AM, Patel, Mayurkumar wrote:
> > > On 7/9/19 1:00 AM, Patel, Mayurkumar wrote:
> > > > After system suspend/resume cycle AER registers settings are
> > > > lost. Not restoring Root Error Command Register bits if it were
> > > > set, keeps AER interrupts disabled after system resume.
> > > > Moreover, AER mask and severity registers are also required
> > > > to be restored back to AER settings prior to system suspend.
> > > > 
> > > > Signed-off-by: Mayurkumar Patel <mayurkumar.patel@intel.com>
> > > > ---
> > > >    drivers/pci/pci.c      |  2 ++
> > > >    drivers/pci/pcie/aer.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
> > > >    include/linux/aer.h    |  4 ++++
> > > >    3 files changed, 55 insertions(+)
> > > > 
> > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > index 8abc843..40d5507 100644
> > > > --- a/drivers/pci/pci.c
> > > > +++ b/drivers/pci/pci.c
> > > > @@ -1340,6 +1340,7 @@ int pci_save_state(struct pci_dev *dev)
> > > > 
> > > >    	pci_save_ltr_state(dev);
> > > >    	pci_save_dpc_state(dev);
> > > > +	pci_save_aer_state(dev);
> > > >    	return pci_save_vc_state(dev);
> > > >    }
> > > >    EXPORT_SYMBOL(pci_save_state);
> > > > @@ -1453,6 +1454,7 @@ void pci_restore_state(struct pci_dev *dev)
> > > >    	pci_restore_dpc_state(dev);
> > > > 
> > > >    	pci_cleanup_aer_error_status_regs(dev);
> > > > +	pci_restore_aer_state(dev);
> > > > 
> > > >    	pci_restore_config_space(dev);
> > > > 
> > > > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > > > index b45bc47..1acc641 100644
> > > > --- a/drivers/pci/pcie/aer.c
> > > > +++ b/drivers/pci/pcie/aer.c
> > > > @@ -448,6 +448,54 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
> > > >    	return 0;
> > > >    }
> > > > 
> > > > +void pci_save_aer_state(struct pci_dev *dev)
> > > > +{
> > > > +	int pos = 0;
> > > > +	struct pci_cap_saved_state *save_state;
> > > > +	u32 *cap;
> > > > +
> > > > +	if (!pci_is_pcie(dev))
> > > > +		return;
> > > > +
> > > > +	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ERR);
> > > > +	if (!save_state)
> > > > +		return;
> > > > +
> > > > +	pos = dev->aer_cap;
> > > > +	if (!pos)
> > > > +		return;
> > > > +
> > > > +	cap = &save_state->cap.data[0];
> > > > +	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, cap++);
> > > > +	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, cap++);
> > > > +	pci_read_config_dword(dev, pos + PCI_ERR_COR_MASK, cap++);
> > > > +	pci_read_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, cap++);

> > > I don't see AER driver modifying UNCOR_MASK/SEVER/COR_MASK register. If
> > > all it has is default value then why do you want to preserve it ?
> > > 
> > Thanks for reply.
> > You are right about UNCOR_MASK/SEVER/COR_MASK mask AER driver
> > leaves untouched, But IMHO users for example can use "setpci" to
> > unmask specific errors and its severity based on their debugging
> > requirement on Root port and/or Endpoint. So during resume, if
> > PCIe endpoint fails due to any error which by default stays masked
> > then it can't be catched and/or debugged.  Moreover, Endpoint
> > driver may also unmask during "driver probe" certain specific
> > errors for endpoint, which needs to be restored while resume.
> 
> Isn't these registers configuration usually done by firmware ? I
> think user application rarely touch them. Also, IMO,
> Caching/Restoring registers under the assumption that it might be
> useful for user if they modified it is not a convincing argument.
> But I will let Bjorn and others decide whether its alright to cache
> these registers.

I think the ideal user experience would be "suspend/resume has no
effect on any configuration".  That would argue for saving/restoring
registers even if we think it's unlikely the user would change them.

> > @Bjorn/Anybody else has any opinion to cache/restore
> > UNCOR_MASK/SEVER/COR_MASK registers?  Please help to comment.
> > 
> > > Also, any reason for not preserving ECRC settings ?
> > No specific reason. I can incorporte that with v2 of this patchset
> > but I don’t have HW on which I can validate that.

I think we should preserve ECRC settings as well for the same reason.

> > > > +}
> > > > +
> > > > +void pci_restore_aer_state(struct pci_dev *dev)
> > > > +{
> > > > +	int pos = 0;
> > > > +	struct pci_cap_saved_state *save_state;
> > > > +	u32 *cap;
> > > > +
> > > > +	if (!pci_is_pcie(dev))
> > > > +		return;
> > > > +
> > > > +	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ERR);
> > > > +	if (!save_state)
> > > > +		return;
> > > > +
> > > > +	pos = dev->aer_cap;
> > > > +	if (!pos)
> > > > +		return;
> > > > +
> > > > +	cap = &save_state->cap.data[0];
> > > > +	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, *cap++);
> > > > +	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, *cap++);
> > > > +	pci_write_config_dword(dev, pos + PCI_ERR_COR_MASK, *cap++);
> > > > +	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, *cap++);
> > > > +}
> > > > +
> > > >    void pci_aer_init(struct pci_dev *dev)
> > > >    {
> > > >    	dev->aer_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
> > > > @@ -1396,6 +1444,7 @@ static int aer_probe(struct pcie_device *dev)
> > > >    		return status;
> > > >    	}
> > > > 
> > > > +	pci_add_ext_cap_save_buffer(port, PCI_EXT_CAP_ID_ERR, sizeof(u32) * 4);
> > > >    	aer_enable_rootport(rpc);
> > > >    	pci_info(port, "enabled with IRQ %d\n", dev->irq);
> > > >    	return 0;
> > > > diff --git a/include/linux/aer.h b/include/linux/aer.h
> > > > index 514bffa..fa19e01 100644
> > > > --- a/include/linux/aer.h
> > > > +++ b/include/linux/aer.h
> > > > @@ -46,6 +46,8 @@ int pci_enable_pcie_error_reporting(struct pci_dev *dev);
> > > >    int pci_disable_pcie_error_reporting(struct pci_dev *dev);
> > > >    int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev);
> > > >    int pci_cleanup_aer_error_status_regs(struct pci_dev *dev);
> > > > +void pci_save_aer_state(struct pci_dev *dev);
> > > > +void pci_restore_aer_state(struct pci_dev *dev);
> > > >    #else
> > > >    static inline int pci_enable_pcie_error_reporting(struct pci_dev *dev)
> > > >    {
> > > > @@ -63,6 +65,8 @@ static inline int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
> > > >    {
> > > >    	return -EINVAL;
> > > >    }
> > > > +static inline void pci_save_aer_state(struct pci_dev *dev) {}
> > > > +static inline void pci_restore_aer_state(struct pci_dev *dev) {}
> > > >    #endif
> > > > 
> > > >    void cper_print_aer(struct pci_dev *dev, int aer_severity,
> > > --
> > > Sathyanarayanan Kuppuswamy
> > > Linux kernel developer
> > Intel Deutschland GmbH
> > Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
> > Tel: +49 89 99 8853-0, www.intel.de
> > Managing Directors: Christin Eisenschmid, Gary Kershaw
> > Chairperson of the Supervisory Board: Nicole Lau
> > Registered Office: Munich
> > Commercial Register: Amtsgericht Muenchen HRB 186928
> 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux kernel developer
> 
