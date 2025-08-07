Return-Path: <linux-pci+bounces-33589-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 056C6B1DF66
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 00:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEB97A0084A
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 22:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2F6253F07;
	Thu,  7 Aug 2025 22:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkxEPRDL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF958242D6E;
	Thu,  7 Aug 2025 22:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754606641; cv=none; b=piB8GEkmhy0hs7qFJsMU7tt+sr8j6hofQj5nP2fVffY38vm/TAD0BjO/K2v/DoMJLPP6bfbAss1m5qmVycaP++OqJnWPdXKIhpq2Edkas2ZBYKU+MTf/PwdNS06kuzgv4ALEevAdswb2VJ0eGegTrmz3mrBNGVm/VKK1mfIiLKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754606641; c=relaxed/simple;
	bh=fU1H2VAF0DSpViQqqm1OKciBG+yRKzGeafPCrd9je9A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=friP3bAiIajGmBQqJu82MSoxf3js0ejI10PoYIU1wtJt5Dqny2jRAMASV7dih/gBZes0XugN8M3DbDhO9vVTm8i+vs3aIHxc1G2PUmEPP68/SRyzCVwmGmGzTvmtwWmDCJwWG1o/T/9L609oJ97FJ9s8eNIzq9z2HAQBsjbli1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkxEPRDL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11575C4CEEB;
	Thu,  7 Aug 2025 22:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754606641;
	bh=fU1H2VAF0DSpViQqqm1OKciBG+yRKzGeafPCrd9je9A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YkxEPRDL5DPsw+YPsIZanQ5kM6NKfTgftka026sd7DeQxB3Y9jsAz6DJT0bMvFm91
	 f0jxTKIhKjEoaDlR9MWt8g7mzfEdxEStlZOvCm39nauPuBcUbRdz14Tk4+2d9nF9nt
	 yS6E1DIJJ/8NKMgD04ZDFwj+ZVcKF/WB7pGsHvwaDWvoPfxro1IU4eO9eq1bxNotuX
	 1RRyNTxEwljfBmAXuFjpZFRZpa8WjdhxRMOoxapRsoc9+kfv54AF1weqEec6OtkuB6
	 FlkIdR6qZlHsnzQ4zYD4H+5iRBimCFbNBoTc6XUWOo9pXyZ7hBgF3aukAe325uE7Ld
	 U3tD+KY1/32kg==
Date: Thu, 7 Aug 2025 17:43:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, bhelgaas@google.com, aik@amd.com,
	lukas@wunner.de, Yilun Xu <yilun.xu@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Subject: Re: [PATCH v4 02/10] PCI/IDE: Enumerate Selective Stream IDE
 capabilities
Message-ID: <20250807224359.GA66417@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717183358.1332417-3-dan.j.williams@intel.com>

On Thu, Jul 17, 2025 at 11:33:50AM -0700, Dan Williams wrote:
> Link encryption is a new PCIe feature enumerated by "PCIe 6.2 section
> 7.9.26 IDE Extended Capability".
> 
> It is both a standalone port + endpoint capability, and a building block
> for the security protocol defined by "PCIe 6.2 section 11 TEE Device
> Interface Security Protocol (TDISP)". That protocol coordinates device
> security setup between a platform TSM (TEE Security Manager) and a
> device DSM (Device Security Manager). While the platform TSM can
> allocate resources like Stream ID and manage keys, it still requires
> system software to manage the IDE capability register block.
> 
> Add register definitions and basic enumeration in preparation for
> Selective IDE Stream establishment. A follow on change selects the new
> CONFIG_PCI_IDE symbol. Note that while the IDE specification defines
> both a point-to-point "Link Stream" and a Root Port to endpoint
> "Selective Stream", only "Selective Stream" is considered for Linux as
> that is the predominant mode expected by Trusted Execution Environment
> Security Managers (TSMs), and it is the security model that limits the
> number of PCI components within the TCB in a PCIe topology with
> switches.
> 
> Cc: Yilun Xu <yilun.xu@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> Co-developed-by: Yilun Xu <yilun.xu@intel.com>
> Signed-off-by: Yilun Xu <yilun.xu@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> +++ b/drivers/pci/Kconfig
> @@ -122,6 +122,20 @@ config XEN_PCIDEV_FRONTEND
>  config PCI_ATS
>  	bool
>  
> +config PCI_IDE
> +	bool
> +
> +config PCI_IDE_STREAM_MAX
> +	int "Maximum number of Selective IDE Streams supported per host bridge" if EXPERT
> +	depends on PCI_IDE
> +	range 1 256
> +	default 64
> +	help
> +	  Set a kernel max for the number of IDE streams the PCI core supports
> +	  per device. While the PCI specification max is 256, the hardware
> +	  platform capability for the foreseeable future is 4 to 8 streams. Bump
> +	  this value up if you have an expert testing need.

Maybe worth expanding IDE once as we did for DOE:

> +
>  config PCI_DOE
>  	bool "Enable PCI Data Object Exchange (DOE) support"

