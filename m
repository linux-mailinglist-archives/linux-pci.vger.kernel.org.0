Return-Path: <linux-pci+bounces-16158-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6CA9BF424
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 18:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12311C23888
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 17:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C62B1DFE3A;
	Wed,  6 Nov 2024 17:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwOWV687"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F271632F1;
	Wed,  6 Nov 2024 17:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730913366; cv=none; b=YPueNkaNtjXmhPXuo0/Kyj9q451OAF0gSAohfBvW65BxvfPsSs+9GvQu07bsL1Wnr/2U+xX4EYJsuAGkWS9RnZJ16EIR/ba+4xTLz1pMYWTrIV8ecl5odjU43RyOH/23BYg4u9V7/Xt4/KY9X1Yo4oIKa9E4OlZ8RtJVAmfy820=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730913366; c=relaxed/simple;
	bh=zrY9tDf1KcMuOejBIoRaGmD6eUvRgew+/hXls8OMK5c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kzb3c01ujMrcSpgjQItN470RJSpADd5SnSM2uZDXdS9mqTXCZIQRkW0hQswZOYTyjOTjFgCOE9LvCaXrMGUaBjG8pAqODHJ0WzM2MRcfN3Fuoa8qxnP491vn8fhfPOwoGCnYHYsGVygcJ3e17xcdrC6TMmDbiOSF/v3cbvuyxEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwOWV687; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73FFCC4CEC6;
	Wed,  6 Nov 2024 17:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730913365;
	bh=zrY9tDf1KcMuOejBIoRaGmD6eUvRgew+/hXls8OMK5c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gwOWV687ClrucQmZOgJVj/bfAIzP8wCM/NY+p4UGqa3cXvWuKIai8aQl71CS/hM7Z
	 pucbWJrvxt7Ge2OVrax/4VW52iu4t6Uxb1gE+HsRwVtNPYT1Pf1XoFB7FXwY5+oqQz
	 TmSown4jb/rHpiRPHayERLZ47vgv9aQWZ9X31vcgXk/FYXj9MMBRmNH3bnstD6ij7/
	 GLB/uA4e4PTGMuCR2nqbMLk6Cgf1JhqLV3C+kV0C7r8oOs5/tCij+Fy2ynhlSUZCAI
	 36WpPCvowapRSrRTJOE6/l6MrHyYJoWzuGXVyl2+UL2CW43eysuLVs/sjMtvYgchvl
	 i5D7veOWqRspQ==
Date: Wed, 6 Nov 2024 11:16:04 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Jian-Hong Pan <jhp@endlessos.org>, Johan Hovold <johan@kernel.org>,
	David Box <david.e.box@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	linux@endlessos.org
Subject: Re: [PATCH v12 3/3] PCI/ASPM: Make pci_save_aspm_l1ss_state save
 both child and parent's L1SS configuration
Message-ID: <20241106171604.GA1529996@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04b86150-c6f5-2898-5b43-dcf14c19845e@linux.intel.com>

On Wed, Nov 06, 2024 at 12:54:12PM +0200, Ilpo Järvinen wrote:
> On Tue, 5 Nov 2024, Bjorn Helgaas wrote:
> > On Tue, Oct 01, 2024 at 04:34:42PM +0800, Jian-Hong Pan wrote:
> > > PCI devices' parameters on the VMD bus have been programmed properly
> > > originally. But, cleared after pci_reset_bus() and have not been restored
> > > correctly. This leads the link's L1.2 between PCIe Root Port and child
> > > device gets wrong configs.
> ...

> > > So, if the PCI device has a parent, make pci_save_aspm_l1ss_state() save
> > > the parent's L1SS configuration, too. This is symmetric on
> > > pci_restore_aspm_l1ss_state().

> > I see the suggestion for a helper here, but I'm not convinced.
> > pci_save_aspm_l1ss_state() and pci_restore_aspm_l1ss_state() should
> > *look* similar, and a helper makes them less similar.
> > 
> > I think you should go to some effort to follow the
> > pci_restore_aspm_l1ss_state() structure, as much as possible doing the
> > same declarations, checks, and lookups in the same order, e.g.:
> >
> >   struct pci_cap_saved_state *pl_save_state, *cl_save_state;
> >   struct pci_dev *parent = pdev->bus->self;
> > 
> >   if (pcie_downstream_port(pdev) || !parent)
> > 	  return;
> > 
> >   if (!pdev->l1ss || !parent->l1ss)
> > 	  return;
> > 
> >   cl_save_state = pci_find_saved_ext_cap(pdev, PCI_EXT_CAP_ID_L1SS);
> >   pl_save_state = pci_find_saved_ext_cap(parent, PCI_EXT_CAP_ID_L1SS);
> >   if (!cl_save_state || !pl_save_state)
> > 	  return;
> 
> I understand I'm not the one who has the final say in this, but the reason 
> why restore has to be done the way it is (the long way), is because of the 
> strict ordering requirement of operations it performs.
> 
> There are no similar ordering requirements on the save side AFAIK.

I'm not suggesting any change to the restore side.  The commit log
says we're making save/restore symmetric, but IMO they end up looking
very asymmetric.

Bjorn

