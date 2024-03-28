Return-Path: <linux-pci+bounces-5348-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0B689074A
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 18:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3B31C2A7D9
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 17:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB0512FB21;
	Thu, 28 Mar 2024 17:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUp9z2zi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0498D39FCF;
	Thu, 28 Mar 2024 17:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711647538; cv=none; b=KbE98NMzQd63lUJL489WEjZ0d4ts+kWujfFRWdckTPnIkhcJ6a0rn+ak4GjxHt3UpbFc0FVjajiEJVoCUdS6v7HxG2F4jKM7w75oEUL7bum70mFiW4CvbeKs5RjX0z3NZ/v99tZZ6PuBooxFV7K1GPIHlmR6kCCvUgDLOX48hOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711647538; c=relaxed/simple;
	bh=sUJiuWGvJ7K3b0lCTxqkhpEU1qk0awgSCqYlo16Lb44=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tx7kSaRRBDNbgjNw/7AY+Y8v6O+fPCKgswNJ1mUBwG923BxYZypkSNck/N5NiVuz9mx5P6IgEun7OHUbp304/TVjMcJ9/8eIzaF0UQB8gZEexl2H1eGo7MzMaHyMnnKLYtO4zTaRK38wZdTsx9Hm43elMjTndQMdTT9gtOsK2s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUp9z2zi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B675C433F1;
	Thu, 28 Mar 2024 17:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711647537;
	bh=sUJiuWGvJ7K3b0lCTxqkhpEU1qk0awgSCqYlo16Lb44=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aUp9z2ziyU3WRYZJAFT9HlxN1dP6jcbL0f0Cb8BrVxUYCKmHwVgZTQnybNn6t1H6k
	 LtKc2fKsg/EZ1xE1mDX3JLRbraSrVICKtKxCn2/ZUKUDiNXC36tUzRry+PTr8yeS4X
	 lrmkXEuezg34KKB4/9ZlHi6v1uZ+B7P2RlnscBWguyXj+eBTODXyUpSyKuUOpQXdV2
	 HS3g6+5wb2eAfaorrVFcdlAkLYNwDgcr3+BJkkHwYOPgnk4Nd+uJvsNs+22Y8LR0w/
	 e2mLXt8S66ZoZ0v9LXiQYiHbruWdCv8O6W9bPDzkutk/uadkfL3X3r2DRl+Lq04qbB
	 K5LdVQ8mAjA2A==
Date: Thu, 28 Mar 2024 12:38:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	dan.j.williams@intel.com, ira.weiny@intel.com,
	vishal.l.verma@intel.com, alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com, dave@stgolabs.net, bhelgaas@google.com,
	lukas@wunner.de
Subject: Re: [PATCH v2 1/3] PCI: Add check for CXL Secondary Bus Reset
Message-ID: <20240328173855.GA1571809@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201384aa-a7a3-415a-9159-a615e8b3cc53@intel.com>

On Wed, Mar 27, 2024 at 04:57:40PM -0700, Dave Jiang wrote:
> On 3/27/24 2:26 PM, Bjorn Helgaas wrote:
> > On Mon, Mar 25, 2024 at 04:58:01PM -0700, Dave Jiang wrote:

> >> With the current behavior, the bus_reset would appear to have executed
> >> successfully, however the operation is actually masked if the "Unmask
> >> SBR" bit is set with the default value. The intention is to inform the
> >> user that SBR for the CXL device is masked and will not go through.
> > 
> > The default value of Unmask SBR isn't really relevant here.
> 
> Changing to:
>     When the "Unmask SBR" bit is set to 0 (default), the bus_reset would
>     appear to have executed successfully. However the operation is actually
>     masked. The intention is to inform the user that SBR for the CXL device
>     is masked and will not go through.
> 
> > 
> >> The expectation is that if a user overrides the "Unmask SBR" via a
> >> user tool such as setpci then they can trigger a bus reset successfully.
> > 
> > ... if a user *sets* Unmask SBR ...
> > to be more specific about what value is required.
> > 
> 
>     If a user overrides the "Unmask SBR" via a user tool such as setpci and
>     sets the value to 1, then the bus reset will execute successfully.

I'm not super enamored with the "if a user overrides" language because
a driver may change that bit in the future, and then the suggestion of
a "user" will be misleading.

It doesn't matter *how* it gets set to 1; it only matters that SBR
doesn't work when "Unmask SBR" is 0 and it does work when "Unmask SBR"
is 1.

> >> +/* Compute Express Link (CXL) */
> >> +#define PCI_DVSEC_VENDOR_ID_CXL				0x1e98
> > 
> > I see that you're just moving this #define from drivers/cxl/cxlpci.h,
> > but I'm scratching my head a bit.  As used here, this is to match the
> > DVSEC Vendor ID (PCIe r6.0, sec 7.9.6.2).
> > 
> > IIUC, this should be just a PCI SIG-defined "Vendor ID", e.g.,
> > "PCI_VENDOR_ID_CXL", that doesn't need the "DVSEC" qualifier in the
> > name, and would normally be defined in include/linux/pci_ids.h.
> > 
> > But I don't see CXL in pci_ids.h, and I don't see either "CXL" or the
> > value "1e98" in the PCI SIG list at
> > https://pcisig.com/membership/member-companies.
> > 
> I'll create a new patch and move to include/linux/pci_ids.h first
> for this define and change to PCI_VENDOR_ID_CXL. The value is
> defined in CXL spec r3.1 sec 8.1.1.

I saw the CXL mentions of 0x1e98, but IMO that's not an authoritative
source; no vendor is allowed to just squat on a Vendor ID value simply
by mentioning it in their own internal specs.  That would obviously
lead to madness.

The footnote in CXL r3.1, sec 3.1.2, about how the 1E98h value is only
for use in DVSEC etc., is really weird.

IIUC, the PCI SIG controls the Vendor ID namespace, so I'm still
really confused about why it is not reserved there.  I emailed the PCI
SIG, but the footnote suggests to me that there some kind of history
here that I don't know.

Anyway, I think all we can do here is to put the definition in
include/linux/pci_ids.h as you did and hope 0x1e98 is never allocated
to another vendor.

> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index a0c75e467df3..7dfbf6d96b3d 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2607,6 +2607,8 @@
>  
>  #define PCI_VENDOR_ID_ALIBABA          0x1ded
>  
> +#define PCI_VENDOR_ID_CXL              0x1e98
> +
>  #define PCI_VENDOR_ID_TEHUTI           0x1fc9
>  #define PCI_DEVICE_ID_TEHUTI_3009      0x3009
>  #define PCI_DEVICE_ID_TEHUTI_3010      0x3010

