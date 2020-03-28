Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06B19196984
	for <lists+linux-pci@lfdr.de>; Sat, 28 Mar 2020 22:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgC1Vco (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 Mar 2020 17:32:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:51902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbgC1Vcn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 28 Mar 2020 17:32:43 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4F5720714;
        Sat, 28 Mar 2020 21:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585431163;
        bh=Sm9UxCFkReymw0VK998m7lOC7r/2q34CtNDPF8OvlMY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UN21uTwkLC4LhRoVv/YxW2MPA9ZkpQIxhUJw8gcsqgM0IuM8EAP9IRFRG12Bs1hwA
         TzrUw6Rj9cB3D77c/p9N0SLcGNU5M4oZOgxSOkKgzR18UtcdGw4wWqnKGRegYWgSJX
         3VUAd3E2i3l4DMWIh+pcvdJHNup86ygonsKG7NMc=
Date:   Sat, 28 Mar 2020 16:32:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
Subject: Re: [PATCH v18 05/11] PCI/ERR: Remove service dependency in
 pcie_do_recovery()
Message-ID: <20200328213241.GA127815@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcc1910b-90fe-25b5-3cee-8f9d7e83e45e@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Mar 28, 2020 at 02:12:48PM -0700, Kuppuswamy, Sathyanarayanan wrote:
> On 3/23/20 5:26 PM, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > 
> 
> > +void pcie_do_recovery(struct pci_dev *dev,
> > +		      enum pci_channel_state state,
> > +		      pci_ers_result_t (*reset_link)(struct pci_dev *pdev))
> >   {
> >   	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
> >   	struct pci_bus *bus;
> > @@ -206,9 +165,12 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
> >   	pci_dbg(dev, "broadcast error_detected message\n");
> >   	if (state == pci_channel_io_frozen) {
> >   		pci_walk_bus(bus, report_frozen_detected, &status);
> > -		status = reset_link(dev, service);
> > -		if 		if (reset_link)
> 			status = reset_link(dev);(status == PCI_ERS_RESULT_DISCONNECT
> > +		status = reset_link(dev);
> Above line needs to be replaced as below. Since there is a
> possibility reset_link can NULL (eventhough currently its
> not true).
> 		if (reset_link)
> 			status = reset_link(dev);
> Shall I submit another version to add above fix on top of
> our pci/edr branch ?

No, I can squash that in if needed.

But I don't actually think we *do* need it.  All the callers supply a
valid reset_link function pointer, and if somebody changes or adds a
new one that doesn't, I'd rather take the null pointer exception and
find out about it than silently ignore it.

Bjorn
