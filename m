Return-Path: <linux-pci+bounces-5357-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B308E8908EE
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 20:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53213B2141B
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 19:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7E67FBB5;
	Thu, 28 Mar 2024 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPl08Goi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28812B9A7;
	Thu, 28 Mar 2024 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711653299; cv=none; b=sAdRvAVDYCDJLmb5DZ+9Xz0S6CczCPHs015b51KH9Iha0tvoTKl9OqXrgeUNXwQO9ZcRkPsGFGGk6Hv+W6pGIEiiUQsGaerzrYIaiFY2d/5qIz/oTQGVylWlf3Ra9REVlSrQXcPwsIyYsr+oFQ/wJBwxfHCNuBUubCqNjmkbW/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711653299; c=relaxed/simple;
	bh=+T4z2HBredaERjZopJntIuvdL+nijHJUXz6SvJzHMEg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=F7E0TSP7qECyglas/ryaP0Bk77fYKwwZ4UpfYUbbaOH1rFaJKwCePjaa8ndu4AfddculDDh9JptWmqM4Oz1Heo4oWecSoFwfgUHpJn5VNrnnK/xTy+DRJ+sj15G7W/eaIrRl8F7ZWmQE7xgv6j5Sb/YKVW7wIzKfabdZto27GyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPl08Goi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0475C433C7;
	Thu, 28 Mar 2024 19:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711653299;
	bh=+T4z2HBredaERjZopJntIuvdL+nijHJUXz6SvJzHMEg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fPl08GoiB4tGYfb66jaqHexEBUNPIoESeN4Kge7bTXdG7esAJ0k6blf3aj668URoq
	 cu5tg7civ8LAsfyqVUfeJJgmj44tb2nFtUsfNRd3i77qRanweVPzXL3PHdxyqIf7Af
	 Qzsl2mBpH+BcZ5CVr3fuEH3Q1CI10qE7WQwjIQjeDcZshTyIq+QipK5PfQbtNKzUof
	 fMa8QR56WuDjv3h6VbWdErw00J9FJffWSSBlvSjP381Z7yJuYXCl+eYp7boG//8Oww
	 pkQHV+BxC8ZR/zzBMUKXkfJSogKklbM/PrF2nhxws9nI9HrnphsdvIisORTcsToJQ5
	 KGnpRoZVIMnJA==
Date: Thu, 28 Mar 2024 14:14:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org, ira.weiny@intel.com,
	vishal.l.verma@intel.com, alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com, dave@stgolabs.net, bhelgaas@google.com,
	lukas@wunner.de
Subject: Re: [PATCH v2 1/3] PCI: Add check for CXL Secondary Bus Reset
Message-ID: <20240328191457.GA1577365@bhelgaas>
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

> > > >> +/* Compute Express Link (CXL) */
> > > >> +#define PCI_DVSEC_VENDOR_ID_CXL				0x1e98
> > > > 
> > > > I see that you're just moving this #define from drivers/cxl/cxlpci.h,
> > > > but I'm scratching my head a bit.  As used here, this is to match the
> > > > DVSEC Vendor ID (PCIe r6.0, sec 7.9.6.2).
> > > > 
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

What a disaster that would be.

> In other words I think the CXL specification usage of 0x1e98 is scoped
> as "DVSEC Vendor ID", not "Vendor ID".
> 
> However that would mean that a future 0x1e98 device could not publish
> DVSECs without colliding with CXL DVSECs.
> 
> I note this footnote in section 3.1.2 about the 0x1e98 value (all caps
> emphasis is from the spec, not me):
> 
> ---
> NOTICE TO USERS: THE UNIQUE VALUE THAT IS PROVIDED IN THIS CXL SPECIFICATION IS
> FOR USE IN VENDOR DEFINED MESSAGE FIELDS, DESIGNATED VENDOR SPECIFIC EXTENDED
> CAPABILITIES, AND ALTERNATE PROTOCOL NEGOTIATION ONLY...

Right, that's the one I thought was really weird.  No sane person
would put crap like that in a spec, which is why I thought there must
be some "interesting" history behind it.

Sigh.

