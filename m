Return-Path: <linux-pci+bounces-5565-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CF3895AA2
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 19:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E16F5B23942
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 17:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FA815A48D;
	Tue,  2 Apr 2024 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jG/Cao38"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0274B159910;
	Tue,  2 Apr 2024 17:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712078606; cv=none; b=sjNcc4K4kfbJQfVJ2jvZpCxZlReYWnpz6O6IHgzVBzdQZozonbiMYTKm1zXG0Fp282KCEvqgQAKVM+oZOsFuTA0lNVlvMpe/+HVwVtc3okQVUXUIJS7/s2/+2L+yXFUs84hcmfn/RY7oHG3VG4rsGDv/aFPmJt8cP/TcVLxdBUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712078606; c=relaxed/simple;
	bh=aiWEoGsthNfBoX4TzpfH80TC69ONo89ixeOUJY2xeS0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=H1l3YCrq6GcoIbP9/xyrhXH/2ziqVFSytwlR3/6hIWpNpe2qpYRfjXIWUGD/lTDlZVCPV+BWB2B+JioIVSXPr/riUeMvRdOGFmY4/GVDRFmF3GValtv14MNEaKkyIKTtMFtS9xtx54zRk++snuIp9c73kkyHNVIMJoUWRX1K3FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jG/Cao38; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC54C433F1;
	Tue,  2 Apr 2024 17:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712078605;
	bh=aiWEoGsthNfBoX4TzpfH80TC69ONo89ixeOUJY2xeS0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jG/Cao38PhEpQlu0lpEo54GtEqi3ykvGK/YP8jEPH5ShMyj88mgnnmA9qYjc0PlLG
	 po1N1rpVdRjkbkIjnRSzqMgGOUycpOf6ENIO6sv9qfRozzI31UwLIg5hJQY3yKxl3h
	 cGOkGvoZCC+BpZnZjMZDeQK/2FChRWXLNDGKYkycROdF5/bTAy780HytmH3bxEovbY
	 5o6jU7uN9XT9JTFW2pNJO1jeF6NSHs1ojI2qcKgkPxSqjZdUkuv4eWWCSUtzU2Avb4
	 bxWfoe6GUYUVbPFCZH6AE2jH2ZiwqlsvxEEfWhUgj492elIvrFtgpsSY3Xm7D/HkRB
	 aF7QBsL6nCiRg==
Date: Tue, 2 Apr 2024 12:23:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org, ira.weiny@intel.com,
	vishal.l.verma@intel.com, alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com, dave@stgolabs.net, bhelgaas@google.com,
	lukas@wunner.de
Subject: Re: [PATCH v2 1/3] PCI: Add check for CXL Secondary Bus Reset
Message-ID: <20240402172323.GA1818777@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6605bef53c82b_1fb31e29481@dwillia2-xfh.jf.intel.com.notmuch>

On Thu, Mar 28, 2024 at 12:03:17PM -0700, Dan Williams wrote:
> Bjorn Helgaas wrote:
> > On Wed, Mar 27, 2024 at 04:57:40PM -0700, Dave Jiang wrote:
> > > On 3/27/24 2:26 PM, Bjorn Helgaas wrote:
> > > > On Mon, Mar 25, 2024 at 04:58:01PM -0700, Dave Jiang wrote:
> ...

> > > > IIUC, this should be just a PCI SIG-defined "Vendor ID", e.g.,
> > > > "PCI_VENDOR_ID_CXL", that doesn't need the "DVSEC" qualifier in the
> > > > name, and would normally be defined in include/linux/pci_ids.h.
> > > > 
> > > > But I don't see CXL in pci_ids.h, and I don't see either "CXL" or the
> > > > value "1e98" in the PCI SIG list at
> > > > https://pcisig.com/membership/member-companies.
> > > > 
> > > I'll create a new patch and move to include/linux/pci_ids.h first
> > > for this define and change to PCI_VENDOR_ID_CXL. The value is
> > > defined in CXL spec r3.1 sec 8.1.1.
> > 
> > I saw the CXL mentions of 0x1e98, but IMO that's not an authoritative
> > source; no vendor is allowed to just squat on a Vendor ID value simply
> > by mentioning it in their own internal specs.  That would obviously
> > lead to madness.
> > 
> > The footnote in CXL r3.1, sec 3.1.2, about how the 1E98h value is only
> > for use in DVSEC etc., is really weird.
> > 
> > IIUC, the PCI SIG controls the Vendor ID namespace, so I'm still
> > really confused about why it is not reserved there.  I emailed the PCI
> > SIG, but the footnote suggests to me that there some kind of history
> > here that I don't know.
> > 
> > Anyway, I think all we can do here is to put the definition in
> > include/linux/pci_ids.h as you did and hope 0x1e98 is never allocated
> > to another vendor.
> 
> Oh, true, I think this should be PCI_DVSEC_VENDOR_ID_CXL, because afaics
> it is still possible that 0x1e98 be used as a non-DVSEC vendor-id in
> some future device.
> 
> In other words I think the CXL specification usage of 0x1e98 is scoped
> as "DVSEC Vendor ID", not "Vendor ID".
> 
> However that would mean that a future 0x1e98 device could not publish
> DVSECs without colliding with CXL DVSECs.

FWIW, I pinged administration@pcisig.com and got the response that
"1E98h is not a VID in our system, but 1E98 has already been reserved
by CXL."

I wish there were a clearer public statement of this reservation, but
I interpret the response to mean that CXL is not a "Vendor", maybe due
to some strict definition of "Vendor," but that PCI-SIG will not
assign 0x1e98 to any other vendor.

So IMO we should add "#define PCI_VENDOR_ID_CXL 0x1e98" so that if we
ever *do* see such an assignment, we'll be more likely to flag it as
an issue.

Bjorn

