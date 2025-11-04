Return-Path: <linux-pci+bounces-40298-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075F3C3322C
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 23:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65ABF3AA39E
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 22:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43C82D0617;
	Tue,  4 Nov 2025 22:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWZArF3G"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768BE182D0;
	Tue,  4 Nov 2025 22:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762294322; cv=none; b=awtrX63kC98Fr+AGHDpFAV2Z6/n6KkLDqhPXZ/ZbJL0Zx9pxdX8BG9p8dTG39+t6kSQ4PSV96uhWWDbVIj2WvqsuZxKF0hRju4IuG6BRIsSdQP3l7vXO2PwyYC7RKXqFydTPlpvzHBD5FW7ToSYqVROSY9ef6++HkPmAYu6YkkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762294322; c=relaxed/simple;
	bh=Il0ufsoV/Sma0i1holpRy4Whf9gHwe/ZVb++0GXviIo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XFcQyf1fmCwOIkapR8g2RZfcd/2I+pqDQTLhDxjuFXatwBmLW4TB2WcFvTMkf7J7MyhUGXKXmM3acJQLnZewstxubxXgbcrz4D1zFzS28YAi+dwcVtM4OQcmtuAnvipD9AsLX1xbPr2pyh4mzkuVF/AId/rttQ4kh+csawYZ6WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWZArF3G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDDDAC4CEF7;
	Tue,  4 Nov 2025 22:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762294322;
	bh=Il0ufsoV/Sma0i1holpRy4Whf9gHwe/ZVb++0GXviIo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EWZArF3GsL/k7gSe/Epj5GyyKWvY26X5/gqjRNo8KfJQ58lBwq9WHSaDolISN6wtp
	 bOtLbiOtOy/Thv79tV9vyxkW04HY5U0R9QN8vZ2toPlb/01RtAy5e2hm9TrVyIfev0
	 USGfJ7mLnJQ60LI3dFew2gvVI5TQTMXwRiSJsgpBh1emQpq8Zz8opMMPfeFTtNMie7
	 9/sbY1G7syexHklGjrMKSbXvoshDqWUMhIP172g5zMGjusGm3IxgvVOLAQRxeUOuQH
	 gpsvBhXV+s9CjjciKyR733bQJls6zhVCc/droYw6jjH4/7ZLUQ6iUqn7K5hK6TNZX+
	 qruUYDce3tB9g==
Date: Tue, 4 Nov 2025 16:12:00 -0600
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
Message-ID: <20251104221200.GA1874852@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f601ff2f-cb1c-4cd1-983f-c344d05d34a6@amd.com>

On Tue, Nov 04, 2025 at 03:54:21PM -0600, Bowman, Terry wrote:
> 
> 
> On 11/4/2025 1:11 PM, Bjorn Helgaas wrote:
> > On Tue, Nov 04, 2025 at 11:02:40AM -0600, Terry Bowman wrote:
> >> This patchset updates CXL Protocol Error handling for CXL Ports and CXL
> >> Endpoints (EP). Previous versions of this series can be found here:
> >> https://lore.kernel.org/linux-cxl/20250925223440.3539069-1-terry.bowman@amd.com/
> >> ...
> >> Terry Bowman (24):
> >>   CXL/PCI: Move CXL DVSEC definitions into uapi/linux/pci_regs.h
> >>   PCI/CXL: Introduce pcie_is_cxl()
> >>   cxl/pci: Remove unnecessary CXL Endpoint handling helper functions
> >>   cxl/pci: Remove unnecessary CXL RCH handling helper functions
> >>   cxl: Move CXL driver's RCH error handling into core/ras_rch.c
> >>   CXL/AER: Replace device_lock() in cxl_rch_handle_error_iter() with
> >>     guard() lock
> >>   CXL/AER: Move AER drivers RCH error handling into pcie/aer_cxl_rch.c
> >>   PCI/AER: Report CXL or PCIe bus error type in trace logging
> >>   cxl/pci: Update RAS handler interfaces to also support CXL Ports
> >>   cxl/pci: Log message if RAS registers are unmapped
> >>   cxl/pci: Unify CXL trace logging for CXL Endpoints and CXL Ports
> >>   cxl/pci: Update cxl_handle_cor_ras() to return early if no RAS errors
> >>   cxl/pci: Map CXL Endpoint Port and CXL Switch Port RAS registers
> >>   CXL/PCI: Introduce PCI_ERS_RESULT_PANIC
> >>   CXL/AER: Introduce pcie/aer_cxl_vh.c in AER driver for forwarding CXL
> >>     errors
> >>   cxl: Introduce cxl_pci_drv_bound() to check for bound driver
> >>   cxl: Change CXL handlers to use guard() instead of scoped_guard()
> >>   cxl/pci: Introduce CXL protocol error handlers for Endpoints
> >>   CXL/PCI: Introduce CXL Port protocol error handlers
> >>   PCI/AER: Dequeue forwarded CXL error
> >>   CXL/PCI: Export and rename merge_result() to pci_ers_merge_result()
> >>   CXL/PCI: Introduce CXL uncorrectable protocol error recovery
> >>   CXL/PCI: Enable CXL protocol errors during CXL Port probe
> >>   CXL/PCI: Disable CXL protocol error interrupts during CXL Port cleanup
> > Is the mix of "CXL/PCI" vs "cxl/pci" in the above telling me
> > something, or should they all match?
> >
> > As a rule of thumb, I'm going to look at things that start with "PCI"
> > and skip most of the rest on the assumption that the rest only have
> > incidental effects on PCI.
>
> I think there was logic behind the (un)capitalized but I forget the
> reasoning. It's  better to keep it simple. I'll change to use
> PCI/CXL and AER/CXL.

I don't know what "AER/CXL" means.  I think "PCI" and "CXL" are the
big chunks here and one of them should be first in the prefix.

I do think there's value in using "PCI/AER" for things specific to AER
and "PCI/ERR" for more generic PCI error handling, and maybe "PCI/CXL"
for significant CXL-related things in drivers/pci/.

