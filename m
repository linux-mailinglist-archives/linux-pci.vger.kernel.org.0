Return-Path: <linux-pci+bounces-42786-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85962CAE048
	for <lists+linux-pci@lfdr.de>; Mon, 08 Dec 2025 19:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A9DB530153AE
	for <lists+linux-pci@lfdr.de>; Mon,  8 Dec 2025 18:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EDC287518;
	Mon,  8 Dec 2025 18:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNQ/lhFQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE9C1E1A3B;
	Mon,  8 Dec 2025 18:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765219372; cv=none; b=TZw+8ORzenZH4MrW+/+PWv+nhklMGA74rnC+iFVsADa9Q6yGK9tTRLtaLievdWmdGDudAJfGy9csyUn1uCbzlpx1nsB+1jey3dGC+bB+FzpP60yjbFsDITMRJE+LfmXSxI/DjQniShNdThIr2D49gTcNe/T6WnKVO/zzo618OUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765219372; c=relaxed/simple;
	bh=jWA1csN2NaMy1biIHW07S62YLP09S/Y53pVeDtyETO4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rnpJ1LFfUWkcyr7uh6RCNE7zMkZzHfPYX/OFcpoNOhzFuYFtJnhTT25mMr2V5NmDSzgxGjP7/pfH45wW+DS7MztIDIY+v4yXleGELOVOkg/JDd7yNxW3L3NMKFhrha1b/MFNdojADp/9kZ94zxjYnXusJdIFXwKSoSkrtv5tdeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNQ/lhFQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB1BC4CEF1;
	Mon,  8 Dec 2025 18:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765219371;
	bh=jWA1csN2NaMy1biIHW07S62YLP09S/Y53pVeDtyETO4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mNQ/lhFQt2Pe2XN8D5Sspg/H7Xd6ijJtscUPjYKtOEqVv8JIB8aU1mM6Ack7KPb0V
	 a9cSIHMCE+0lIh8tidR9tnstjKY6/6s7LlNQ3D6GO7NEM4v0csZYyA6VF1AH58G4UX
	 3hHFkaKbZYXoa3ak/YT6UOdBBn1p22t9a8M10MmmQXFZWro4FPEMpOe5SQHFymeCHc
	 Hv8EDBjYHD1fQUf4Vb5qyAIdF23wk4ZjDR7QGxjSi0S/oqk9RuGPWtHqO5SwQHAi9T
	 AVwAo8+cjtNpUUcTrjA2u/hiMJUTHlj4eSCHQnu4TAVQtrjGNblsS58zACMlBK/EIu
	 +GLl+c14mAZ8A==
Date: Mon, 8 Dec 2025 12:42:50 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Bowman, Terry" <terry.bowman@amd.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	lukas@wunner.de, Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RESEND v13 00/25] Enable CXL PCIe Port Protocol Error handling
 and logging
Message-ID: <20251208184250.GA3299436@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00537640-96a1-4476-afd4-c8c4894d7931@amd.com>

On Thu, Dec 04, 2025 at 11:30:45AM -0600, Bowman, Terry wrote:
> On 11/4/2025 4:12 PM, Bjorn Helgaas wrote:
> > On Tue, Nov 04, 2025 at 03:54:21PM -0600, Bowman, Terry wrote:
> >>
> >>
> >> On 11/4/2025 1:11 PM, Bjorn Helgaas wrote:
> >>> On Tue, Nov 04, 2025 at 11:02:40AM -0600, Terry Bowman wrote:
> >>>> This patchset updates CXL Protocol Error handling for CXL Ports and CXL
> >>>> Endpoints (EP). Previous versions of this series can be found here:
> >>>> https://lore.kernel.org/linux-cxl/20250925223440.3539069-1-terry.bowman@amd.com/
> >>>> ...
> >>>> Terry Bowman (24):
> >>>>   CXL/PCI: Move CXL DVSEC definitions into uapi/linux/pci_regs.h
> >>>>   PCI/CXL: Introduce pcie_is_cxl()
> >>>>   cxl/pci: Remove unnecessary CXL Endpoint handling helper functions
> >>>>   cxl/pci: Remove unnecessary CXL RCH handling helper functions
> >>>>   cxl: Move CXL driver's RCH error handling into core/ras_rch.c
> >>>>   CXL/AER: Replace device_lock() in cxl_rch_handle_error_iter() with
> >>>>     guard() lock
> >>>>   CXL/AER: Move AER drivers RCH error handling into pcie/aer_cxl_rch.c
> >>>>   PCI/AER: Report CXL or PCIe bus error type in trace logging
> >>>>   cxl/pci: Update RAS handler interfaces to also support CXL Ports
> >>>>   cxl/pci: Log message if RAS registers are unmapped
> >>>>   cxl/pci: Unify CXL trace logging for CXL Endpoints and CXL Ports
> >>>>   cxl/pci: Update cxl_handle_cor_ras() to return early if no RAS errors
> >>>>   cxl/pci: Map CXL Endpoint Port and CXL Switch Port RAS registers
> >>>>   CXL/PCI: Introduce PCI_ERS_RESULT_PANIC
> >>>>   CXL/AER: Introduce pcie/aer_cxl_vh.c in AER driver for forwarding CXL
> >>>>     errors
> >>>>   cxl: Introduce cxl_pci_drv_bound() to check for bound driver
> >>>>   cxl: Change CXL handlers to use guard() instead of scoped_guard()
> >>>>   cxl/pci: Introduce CXL protocol error handlers for Endpoints
> >>>>   CXL/PCI: Introduce CXL Port protocol error handlers
> >>>>   PCI/AER: Dequeue forwarded CXL error
> >>>>   CXL/PCI: Export and rename merge_result() to pci_ers_merge_result()
> >>>>   CXL/PCI: Introduce CXL uncorrectable protocol error recovery
> >>>>   CXL/PCI: Enable CXL protocol errors during CXL Port probe
> >>>>   CXL/PCI: Disable CXL protocol error interrupts during CXL Port cleanup
> >>> Is the mix of "CXL/PCI" vs "cxl/pci" in the above telling me
> >>> something, or should they all match?
> >>>
> >>> As a rule of thumb, I'm going to look at things that start with "PCI"
> >>> and skip most of the rest on the assumption that the rest only have
> >>> incidental effects on PCI.
> >>
> >> I think there was logic behind the (un)capitalized but I forget the
> >> reasoning. It's  better to keep it simple. I'll change to use
> >> PCI/CXL and AER/CXL.
> > 
> > I don't know what "AER/CXL" means.  I think "PCI" and "CXL" are the
> > big chunks here and one of them should be first in the prefix.
> > 
> > I do think there's value in using "PCI/AER" for things specific to AER
> > and "PCI/ERR" for more generic PCI error handling, and maybe "PCI/CXL"
> > for significant CXL-related things in drivers/pci/.
> 
> I was informed any patch touching PCI files requires a PCI maintainer 
> review or acknowledgment. I misunderstood how to communicate this.
> 
> In my workflow, I used uppercase tags like PCI or AER to indicate that 
> a patch needed PCI review or ack. For example, when I wrote CXL/PCI, I 
> intended to signal that the patch was primarily CXL-related but in a 
> PCI context, and therefore might need PCI review.
> 
> To avoid confusion in the future, can you advise on the best way to 
> indicate a patch needs your PCI review—even if the PCI changes are
> minor and don’t warrant leading with the PCI label?
> 
> Also, can you review the following patches?
> [RESEND v13 01/25] CXL-PCI-Move-CXL-DVSEC-definitions-into-uapi-lin
> [RESEND v13 02/25] PCI-CXL-Introduce-pcie_is_cxl
> [RESEND v13 07/25] CXL-AER-Replace-device_lock-in-cxl_rch_handle_er
> [RESEND v13 08/25] CXL-AER-Move-AER-drivers-RCH-error-handling-into
> [RESEND v13 16/25] CXL-AER-Introduce-pcie-aer_cxl_vh.c-in-AER-drive
> [RESEND v13 20/25] CXL-PCI-Introduce-CXL-Port-protocol-error-handle
> [RESEND v13 22/25] CXL-PCI-Export-and-rename-merge_result-to-pci_er
> [RESEND v13 23/25] CXL-PCI-Introduce-CXL-uncorrectable-protocol-err
> [RESEND v13 25/25] CXL-PCI-Disable-CXL-protocol-error-interrupts-du

Sorry, I responded to most of the first v13 series because I didn't
notice the resend, so this got a little fragmented.  Let me know if
there's more I should look at.

Bjorn

