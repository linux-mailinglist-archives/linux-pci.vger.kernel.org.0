Return-Path: <linux-pci+bounces-24964-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E75B2A74EC5
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 18:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74E9C7A6BCC
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 17:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BD31A08B1;
	Fri, 28 Mar 2025 17:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQ443N26"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9684379D2;
	Fri, 28 Mar 2025 17:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743181334; cv=none; b=jtJv+i7nq5gkoC741ByGoz23qyxQsPfKy9y2Ip54bPwq136YkwHK9vW/yn3d5uV4dF2YM/9DOmnkhRM7c6Z/I9TnfY8mjZNLGbiPFjz0bU5KUabZwCxJzcwnaYM9SwFvJ2p16JjKgGEKDiS6P2OaX/rEOuFEjB3RwAlyyyFpVPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743181334; c=relaxed/simple;
	bh=0CCc9sG1JRFAdQjSNsWyNdNN0+t+ZAjvF9/cbOcLf0M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rDJJA8VxSYrzKMlqX2/HnQAqmLe/HXe5Ou8iZtZEO4YwbsJMoKrq4nct37XyOt6ZUEM+J888jIyLSnP+PLdyYlvWTHj2i5F8LFyLBXGLMQZy1NHPtnVYo7ebCnL8ATMOjqLuqvXQy5B0wien3fKsPLuLYrVXOSOe7HBAvZXPQpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQ443N26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E657AC4CEE4;
	Fri, 28 Mar 2025 17:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743181334;
	bh=0CCc9sG1JRFAdQjSNsWyNdNN0+t+ZAjvF9/cbOcLf0M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KQ443N26l/zrrNFcZuLCsFD+fHb/9AxUOkdSw5avOuQBnl+eMjIk41LJjDRtS5Svf
	 ZRFJ/9MZjqvRCGPE0kDa2jF+q77kBCtede9kNALSzIj6tM4/ZCSlWTk3FKTCYhMMlL
	 o23ptcBHfnMAvDbGJGRDiiG0edxFOQyeOeUPULFQAYkFw5BRgtQZraR51zpVjyKCQJ
	 fdBREzkitzvgFhCRNphs6JHe8MQU1Qw9I8kS1RZwxXRKOG3ftL29SUSaO7TiSwWRe0
	 79F7kGxqTITPfBsNCt2iC5KamhJqgP92FVCL2MrsO290RGNovYI4lZNEAqRJfHRoxB
	 gVN9LvU3uQdLw==
Date: Fri, 28 Mar 2025 12:02:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Bowman, Terry" <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
	ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
	rrichter@amd.com, nathan.fontenot@amd.com,
	Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
	ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
Subject: Re: [PATCH v8 03/16] CXL/AER: Introduce Kfifo for forwarding CXL
 errors
Message-ID: <20250328170212.GA1508786@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ae4740d-e2d9-4d49-b021-6712311842ed@amd.com>

What does this series apply to?  I default to the current -rc1
(v6.14-rc1), but this doesn't apply there, and I don't have the
base-commit: aae0594a7053c60b82621136257c8b648c67b512 mentioned in the
cover letter.

Sometimes things make more sense when I can see everything as applied.

On Thu, Mar 27, 2025 at 01:12:30PM -0500, Bowman, Terry wrote:
> On 3/27/2025 12:08 PM, Bjorn Helgaas wrote:
> > On Wed, Mar 26, 2025 at 08:47:04PM -0500, Terry Bowman wrote:
> >> CXL error handling will soon be moved from the AER driver into the CXL
> >> driver. This requires a notification mechanism for the AER driver to share
> >> the AER interrupt details with CXL driver. The notification is required for
> >> the CXL drivers to then handle CXL RAS errors.
> >>
> >> Add a kfifo work queue to be used by the AER driver and CXL driver. The AER
> >> driver will be the sole kfifo producer adding work. The cxl_core will be
> >> the sole kfifo consumer removing work. Add the boilerplate kfifo support.
> >>
> >> Add CXL work queue handler registration functions in the AER driver. Export
> >> the functions allowing CXL driver to access. Implement the registration
> >> functions for the CXL driver to assign or clear the work handler function.
> >>
> >> Create a work queue handler function, cxl_prot_err_work_fn(), as a stub for
> >> now. The CXL specific handling will be added in future patch.
> >>
> >> Introduce 'struct cxl_prot_err_info'. This structure caches CXL error
> >> details used in completing error handling. This avoid duplicating some
> >> function calls and allows the error to be treated generically when
> >> possible.

> >> +int cxl_create_prot_err_info(struct pci_dev *_pdev, int severity,
> >> +			     struct cxl_prot_error_info *err_info)
> >> +{
> ...

> >> +	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
> >> +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END)) {
> >> +		pci_warn_once(pdev, "Error: Unsupported device type (%X)", pci_pcie_type(pdev));
> >> +		return -ENODEV;
> >
> > Similar.  A pci_warn_once() here seems like a debugging aid during
> > development, not necessarily a production kind of thing.
> >
> > Thanks for printing the type.  I would use "%#x" to make it clear that
> > it's hex.  There are about 1900 %X uses compared with 33K
> > %x uses, but maybe you have a reason to capitalize it?
>
> Got it "%x". Would you recommend the pci_warn_once() is removed?

The dependency on pdev being an endpoint is not clear here, so I would
just remove the check altogether or move it to the place that breaks
if pdev is not an endpoint.

> >> +#if defined(CONFIG_PCIEAER_CXL)
> >> +int cxl_register_prot_err_work(struct work_struct *work,
> >> +			       int (*_cxl_create_prot_err_info)(struct pci_dev*, int,
> >> +								struct cxl_prot_error_info*))
> >
> > Ditto.  Rewrap to fit in 80 columns, unindent this function
> > pointer decl to make it fit.  Same below in aer.h.
>
> Ok, got it. Without using typedefs, right ?

A typedef would be fine with me.

> >> +struct cxl_prot_error_info {
> >> +	struct pci_dev *pdev;
> >> +	struct device *dev;
> >> +	void __iomem *ras_base;
> >> +	int severity;
> >
> > What does the "prot" in "cxl_prot_error_info" refer to?
>
> Protocol. As in CXL Protocol Error Information. I suppose it needs
> to be renamed if it wasn't obvious.

Unless there are CXL non-protocol errors that need to be
distinguished, I would just omit "prot" altogether.

> > There's basically no error info here other than "severity".
>
> Correct. It's more accurately "CXL Protocol Error Context" but I didn't
> want to re-use 'context' because 'context' is used for thread/process
> statefulness. Also, I followed the existing CPER parallel work that uses
> a similar kfifo etc. Thoughts on rename?

What's the name of the corresponding CPER struct?

> > I guess "dev" and "pdev" are separate devices (otherwise you would
> > just use "&pdev->dev"), but I don't have any intuition about how they
> > might be related, which is a little disconcerting.
>
> "pdev" represents a PCIe device: RP, USP, DSP, or EP.  "dev" is the
> same device as "pdev" but "dev" is found in CXL topology. "dev" is
> discovered through ACPI/platform enumeration and interconnected with
> other CXL "devs" using upstream and downstream links. Moving back
> and forth between "pdev" and its CXL "dev" requires a search unique
> to the device type and point beginning the search.

It seems weird to me to have two device pointers here.  Seems like we
should use a single pointer to identify the device, and if we need to
get from PCI to CXL or vice versa, there should be a pointer somewhere
so we don't have to search all the time.

> > I would have thought that "ras_base" would be a property of "dev"
> > (the CXL device) and wouldn't need to be separate.
>
> "ras_base" is a common member of the CXL Port, CXL Downstream Port,
> CXL Upstream Port, and CXL EP. If one wants the "ras_base" for a
> given CXL "dev" then the "dev" must be converted to CXL Port,
> Downstream Port, or Upstream Port.

Passing around ras_base seems dodgy to me.  I think it's better to
pass around a real entity like a pci_dev or cxl_port or cxl_dport or
whatever.  Code that needs to deal with ras_base presumably should
know about the internals of the device ras_base belongs to.

Bjorn

