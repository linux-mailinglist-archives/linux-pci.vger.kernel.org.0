Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B9E3DE232
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 00:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbhHBWLB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Aug 2021 18:11:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:57628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233663AbhHBWKp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Aug 2021 18:10:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B50D60E78;
        Mon,  2 Aug 2021 22:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627942234;
        bh=uSZT+ndJN1JqUIGueDTsU95u9z8W4jD3Ak6TK1dxC+s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gCUHKZYPwETo/6lfMN4knzRegMa8yZT2V6qF7N9oWrMfZcayJfq36qjBGkVdepcSh
         yAIvjd9ygYE1R2aHB2Lq9MKsCACHvCB/i6IFXXHOPefq3uLikgYhkFs22SgF01oGNJ
         /syugoaVAgSNV/GpNRL1yhAMkzo09TStvYXZV5TnbKeygLX4piad1WhIyrYuvci42X
         Gqn4RE1avoKBzYFMwOTVSk1K7BPoaYXWkfbes3j3YDBtHE5NRsCkLfwCPk0GFe2xon
         MTnm1Qcj8/bjCY6on8kA2jAgGUiiMq+fu3x6haowTSIsBz+CTAHBQp1MP2NbfFm8hN
         RmqlStWH39NMw==
Date:   Mon, 2 Aug 2021 17:10:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Make pci_cap_saved_state private to core
Message-ID: <20210802221033.GA1419404@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802131704.0a212f89.alex.williamson@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 02, 2021 at 01:17:04PM -0600, Alex Williamson wrote:
> On Wed, 28 Jul 2021 18:14:47 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > struct pci_cap_saved_data and struct pci_cap_saved_state were declared in
> > include/linux/pci.h, but aren't needed outside drivers/pci/.  Move them to
> > drivers/pci/pci.h.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/pci/pci.h   | 17 +++++++++++++++--
> >  include/linux/pci.h | 12 ------------
> >  2 files changed, 15 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index 93dcdd431072..ab5a989e6580 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -37,6 +37,21 @@ int pci_probe_reset_function(struct pci_dev *dev);
> >  int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
> >  int pci_bus_error_reset(struct pci_dev *dev);
> >  
> > +struct pci_cap_saved_data {
> > +	u16		cap_nr;
> > +	bool		cap_extended;
> > +	unsigned int	size;
> > +	u32		data[];
> > +};
> > +
> > +struct pci_cap_saved_state {
> > +	struct hlist_node		next;
> > +	struct pci_cap_saved_data	cap;
> > +};
> > +
> > +void pci_allocate_cap_save_buffers(struct pci_dev *dev);
> > +void pci_free_cap_save_buffers(struct pci_dev *dev);
> > +
> >  #define PCI_PM_D2_DELAY         200	/* usec; see PCIe r4.0, sec 5.9.1 */
> >  #define PCI_PM_D3HOT_WAIT       10	/* msec */
> >  #define PCI_PM_D3COLD_WAIT      100	/* msec */
> > @@ -100,8 +115,6 @@ void pci_pm_init(struct pci_dev *dev);
> >  void pci_ea_init(struct pci_dev *dev);
> >  void pci_msi_init(struct pci_dev *dev);
> >  void pci_msix_init(struct pci_dev *dev);
> > -void pci_allocate_cap_save_buffers(struct pci_dev *dev);
> > -void pci_free_cap_save_buffers(struct pci_dev *dev);
> >  bool pci_bridge_d3_possible(struct pci_dev *dev);
> >  void pci_bridge_d3_update(struct pci_dev *dev);
> >  void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev);
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 540b377ca8f6..2ceeb5e9f28a 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -288,18 +288,6 @@ enum pci_bus_speed {
> >  enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev);
> >  enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
> >  
> > -struct pci_cap_saved_data {
> > -	u16		cap_nr;
> > -	bool		cap_extended;
> > -	unsigned int	size;
> > -	u32		data[];
> > -};
> > -
> > -struct pci_cap_saved_state {
> > -	struct hlist_node		next;
> > -	struct pci_cap_saved_data	cap;
> > -};
> > -
> >  struct irq_affinity;
> >  struct pcie_link_state;
> >  struct pci_vpd;
> 
> 
> Do you want to move these from include/linux/pci.h as well?
> 
> struct pci_cap_saved_state *pci_find_saved_cap(struct pci_dev *dev, char cap);
> struct pci_cap_saved_state *pci_find_saved_ext_cap(struct pci_dev *dev, u16 cap);

Yes, and maybe these as well:

  void pci_allocate_cap_save_buffers(struct pci_dev *dev);
  void pci_free_cap_save_buffers(struct pci_dev *dev);
  int pci_add_cap_save_buffer(struct pci_dev *dev, char cap, unsigned int size);
  int pci_add_ext_cap_save_buffer(struct pci_dev *dev,
				 u16 cap, unsigned int size);

Thought I went through these before, but maybe I'm misremembering.

Bjorn
