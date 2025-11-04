Return-Path: <linux-pci+bounces-40287-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE992C32BD4
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 20:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E978426AE1
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 19:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C1633F8DF;
	Tue,  4 Nov 2025 19:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaYLHN4q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F079831BCAA;
	Tue,  4 Nov 2025 19:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762283502; cv=none; b=HZmUDrFie5xZKYngx6m5Vw+SSip9z1wv13jcZXe4uWXxGNMeUnHMwAMsZ1OYR5u9Oq4OR34BcNvz3bOMv9MLy9KN1SqCyPORb/SGRRoPFKfBZfc5MR3RDLFmyqPgfwRHB6w186Xf9eAtbC302E+26XKz4bYpWfBkc6mbS1K+s1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762283502; c=relaxed/simple;
	bh=feAzHebGt3RKeVkxL9g9dQgYt0I5/dFG9JRAxr8UuDY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oepNI+M9C2qyKcslVZ71WhOmqsKbEv4Ryz69pYeeh/WHZ3hupRtAfwV5XmlMnqWhyCLp+dDrOJvUuDZ8q9OJFgNx1OvCWtriBn1ZDM7B2ms587I/iPhYXtooAgDf8bt83kgcQlC7htYXrWbJP+Nrt9F1ITW0NxoEeduWo7wacEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aaYLHN4q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4BCFC4CEF7;
	Tue,  4 Nov 2025 19:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762283501;
	bh=feAzHebGt3RKeVkxL9g9dQgYt0I5/dFG9JRAxr8UuDY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aaYLHN4qdQBf2u8W+sWoxuCTpxQt0lrd4BsUrrGbyZKgwBxacXj4pfiLDwYIRpV4C
	 9Rvke00fLg6JGhysEyeLFICrpv+zAqvuYzhz7TX6YJR/kGnLAoQVFUvYZcJSCap+0+
	 1SShH4GCBRRphlpWCnUqmVGEEBWI2kkXRKhHuTafr+qN8XgMaD3E5EA5hWR88lBQ0w
	 Ar/b625AfNM2DYL1Fh/0cPSSjRrsyYgzq8R1QqVIcHLjkecD9mv8Ea+M9+op11Cggu
	 m2bwoTiPDVJp51F9k0wLsTehd37u+DAnRVNy0Nqo5ueGFWr1ybmSFCl1pZiysMzx2f
	 Hwyq00UPnsVMA==
Date: Tue, 4 Nov 2025 13:11:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
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
Message-ID: <20251104191140.GA1861840@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104170305.4163840-1-terry.bowman@amd.com>

On Tue, Nov 04, 2025 at 11:02:40AM -0600, Terry Bowman wrote:
> This patchset updates CXL Protocol Error handling for CXL Ports and CXL
> Endpoints (EP). Previous versions of this series can be found here:
> https://lore.kernel.org/linux-cxl/20250925223440.3539069-1-terry.bowman@amd.com/
> ...

> Terry Bowman (24):
>   CXL/PCI: Move CXL DVSEC definitions into uapi/linux/pci_regs.h
>   PCI/CXL: Introduce pcie_is_cxl()
>   cxl/pci: Remove unnecessary CXL Endpoint handling helper functions
>   cxl/pci: Remove unnecessary CXL RCH handling helper functions
>   cxl: Move CXL driver's RCH error handling into core/ras_rch.c
>   CXL/AER: Replace device_lock() in cxl_rch_handle_error_iter() with
>     guard() lock
>   CXL/AER: Move AER drivers RCH error handling into pcie/aer_cxl_rch.c
>   PCI/AER: Report CXL or PCIe bus error type in trace logging
>   cxl/pci: Update RAS handler interfaces to also support CXL Ports
>   cxl/pci: Log message if RAS registers are unmapped
>   cxl/pci: Unify CXL trace logging for CXL Endpoints and CXL Ports
>   cxl/pci: Update cxl_handle_cor_ras() to return early if no RAS errors
>   cxl/pci: Map CXL Endpoint Port and CXL Switch Port RAS registers
>   CXL/PCI: Introduce PCI_ERS_RESULT_PANIC
>   CXL/AER: Introduce pcie/aer_cxl_vh.c in AER driver for forwarding CXL
>     errors
>   cxl: Introduce cxl_pci_drv_bound() to check for bound driver
>   cxl: Change CXL handlers to use guard() instead of scoped_guard()
>   cxl/pci: Introduce CXL protocol error handlers for Endpoints
>   CXL/PCI: Introduce CXL Port protocol error handlers
>   PCI/AER: Dequeue forwarded CXL error
>   CXL/PCI: Export and rename merge_result() to pci_ers_merge_result()
>   CXL/PCI: Introduce CXL uncorrectable protocol error recovery
>   CXL/PCI: Enable CXL protocol errors during CXL Port probe
>   CXL/PCI: Disable CXL protocol error interrupts during CXL Port cleanup

Is the mix of "CXL/PCI" vs "cxl/pci" in the above telling me
something, or should they all match?

As a rule of thumb, I'm going to look at things that start with "PCI"
and skip most of the rest on the assumption that the rest only have
incidental effects on PCI.

