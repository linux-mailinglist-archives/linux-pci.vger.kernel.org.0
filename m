Return-Path: <linux-pci+bounces-41588-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB04C6D665
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 09:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 05E572D5EE
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 08:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53266328B70;
	Wed, 19 Nov 2025 08:26:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78F1328B56;
	Wed, 19 Nov 2025 08:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763540799; cv=none; b=RCdHRFW+XEgsdvbEYgTUe/zF5a7W/xILD2zkNw2LeD3B1qgxhOJugrPfsdk248gQBYD/IIQWx2b3SY3ZUloaSc7giQTvc2sdHE8FwgisCPIA1AiuRj+hCQPFyX3kzMFR1RgyvsGn8SghU97pj//bavsEoTKQGRTfL/RuPBSvQmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763540799; c=relaxed/simple;
	bh=JoUwFWeauGilOKqObiO9RqGOULtI6Vb7USPVXnJc++M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vc/kBAGOF5oNmQTuxP4pmtPw6he+jPdQ4q3auycIA+cdEKj1sgzF7/xv5GmuX0w/hKCItZW7uk3F02/gS9bunLXZIzw6JjsiCXuLbuJbM9/gSqQwxkaLbk/3mnDA9nkJ2iKZF0yTRss3yhOWQniVHgbR0j9yzpD5ZUUyW4VUIAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id AA6D72C000A9;
	Wed, 19 Nov 2025 09:26:27 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 77875E7B8; Wed, 19 Nov 2025 09:26:27 +0100 (CET)
Date: Wed, 19 Nov 2025 09:26:27 +0100
From: Lukas Wunner <lukas@wunner.de>
To: dan.j.williams@intel.com
Cc: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, bhelgaas@google.com,
	shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RESEND v13 08/25] CXL/AER: Move AER drivers RCH error handling
 into pcie/aer_cxl_rch.c
Message-ID: <aR1_M_i3yIygd8v-@wunner.de>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-9-terry.bowman@amd.com>
 <691d377611d7b_1a37510056@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <691d377611d7b_1a37510056@dwillia2-mobl4.notmuch>

On Tue, Nov 18, 2025 at 07:20:22PM -0800, dan.j.williams@intel.com wrote:
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -1130,7 +1130,7 @@ static bool find_source_device(struct pci_dev *parent,
> >   * Note: AER must be enabled and supported by the device which must be
> >   * checked in advance, e.g. with pcie_aer_is_native().
> >   */
> > -static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
> > +void pci_aer_unmask_internal_errors(struct pci_dev *dev)
> >  {
> >  	int aer = dev->aer_cap;
> >  	u32 mask;
> > @@ -1143,116 +1143,25 @@ static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
> >  	mask &= ~PCI_ERR_COR_INTERNAL;
> >  	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
> >  }
> > +EXPORT_SYMBOL_GPL(pci_aer_unmask_internal_errors);
> 
> I can not imagine any other driver but the CXL core consuming this
> symbol, so how about:
> 
> EXPORT_SYMBOL_FOR_MODULES(pci_aer_unmask_internal_errors, "cxl_core")

The "xe" driver needs to unmask Uncorrectable Internal Errors
(the default is "masked" per PCIe r7.0 sec 7.8.4.3) and could
take advantage of this helper, so I've asked Terry to keep it
available for anyone to use:

https://lore.kernel.org/all/aK66OcdL4Meb0wFt@wunner.de/

Thanks,

Lukas

