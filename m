Return-Path: <linux-pci+bounces-40285-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71ABDC32BA9
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 20:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E5554EC93C
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 19:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D3533F8BE;
	Tue,  4 Nov 2025 19:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLucJqX4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A5F2EC097;
	Tue,  4 Nov 2025 19:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762283035; cv=none; b=WvtEt1UYMOIzuR/2/7PbFZVzijsTjZemKV7+KYvcG01o8BcbGMrm75kEvJs06TfygM+dqQwvYM5jtorn8klrY3z0v4K0l/kS0pk26RBQQWvGNgeS2Fc2znPSS5iQ6lblSD40jLS3hBfBHAjIif1HDcoHxEJRfWnwJpynXEDOwOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762283035; c=relaxed/simple;
	bh=nTkZFV7DU8/opvW9dEZgcXnoBAujetOGxNge261BBqY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=aUZHtgZxyURI1jz1XCh+16dbwcYS87K96E6d9IYcCjloFQWLmOp+fISsLYdISIc5NUziBGHZk5hXAT8db5J7dODcW73qi4Z7RLJ2wIT8GCxhw92jrjxBGtFRWwTV+czlIdt4/YF/L00nwbL/BgarX/h5xONuIINkHsbWBOGfUJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLucJqX4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B236CC4CEF7;
	Tue,  4 Nov 2025 19:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762283034;
	bh=nTkZFV7DU8/opvW9dEZgcXnoBAujetOGxNge261BBqY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aLucJqX4HfHKuCrs9eSnLB/tUxRXf46oDWdDLBn8DuQDON46rpUzEa82tkHRweBwh
	 zDOldKMVoEbo7lL4JjnANhV/iceUQFYZM+LPwRXE46NZvbKymC04t51hUNJmWXfPA9
	 yPn/mgABNLqbuP2YlHj9KQKGrNbZ+cYXrnMLzmQ7a4pTyI2Gli8RYbrgIhoYiSq7Uk
	 UiKBn7hvFpmuVItZhlXbo8uopk5srUGYzSGmwkkHeKOjSMhL4/ENnzxwQ1H677JvMp
	 9aVU+Th2uZkgGi8bu0sAD1EhWgWOfWQbFpvJGJg9MP6wobLCdYcXYX5lZeZg6L0G5/
	 PZUw37ciCi0lQ==
Date: Tue, 4 Nov 2025 13:03:53 -0600
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
Subject: Re: [RESEND v13 15/25] CXL/PCI: Introduce PCI_ERS_RESULT_PANIC
Message-ID: <20251104190353.GA1865360@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104170305.4163840-16-terry.bowman@amd.com>

On Tue, Nov 04, 2025 at 11:02:55AM -0600, Terry Bowman wrote:
> The CXL driver's error handling for uncorrectable errors (UCE) will be
> updated in the future. A required change is for the error handlers to
> to force a system panic when a UCE is detected.
> 
> Introduce PCI_ERS_RESULT_PANIC as a 'enum pci_ers_result' type. This will
> be used by CXL UCE fatal and non-fatal recovery in future patches. Update
> PCIe recovery documentation with details of PCI_ERS_RESULT_PANIC.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

This patch doesn't actually *do* anything.  There's no possibility of a
bisect landing on it.  I think it would be better to combine this with
something that *uses* PCI_ERS_RESULT_PANIC, maybe the merge_result()
update?

Suggest possible subject prefix of "PCI/ERR" since this really isn't
CXL-specific; it just so happens that you don't know of uses outside
CXL.

> +++ b/Documentation/PCI/pci-error-recovery.rst
> @@ -102,6 +102,8 @@ Possible return values are::
>  		PCI_ERS_RESULT_NEED_RESET,  /* Device driver wants slot to be reset. */
>  		PCI_ERS_RESULT_DISCONNECT,  /* Device has completely failed, is unrecoverable */
>  		PCI_ERS_RESULT_RECOVERED,   /* Device driver is fully recovered and operational */
> +		PCI_ERS_RESULT_NO_AER_DRIVER, /* No AER capabilities registered for the driver */

"AER capabilities" is confusingly similar to the PCIe AER Capability.

I think this really means "there's no
pci_error_handlers.error_detected() callback".

> +		PCI_ERS_RESULT_PANIC,       /* System is unstable, panic. Is CXL specific */
>  	};
>  
>  A driver does not have to implement all of these callbacks; however,
> @@ -116,6 +118,10 @@ The actual steps taken by a platform to recover from a PCI error
>  event will be platform-dependent, but will follow the general
>  sequence described below.
>  
> +PCI_ERS_RESULT_PANIC is currently unique to CXL and handled in CXL
> +cxl_do_recovery(). The PCI pcie_do_recovery() routine does not report or
> +handle PCI_ERS_RESULT_PANIC.

I'm not sure all these mentions of being CXL specific are really
helpful.  I don't think they are actionable to driver writers.

>  STEP 0: Error Event
>  -------------------
>  A PCI bus error is detected by the PCI hardware.  On powerpc, the slot
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 5c4759078d2f..cffa5535f28d 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -890,6 +890,9 @@ enum pci_ers_result {
>  
>  	/* No AER capabilities registered for the driver */
>  	PCI_ERS_RESULT_NO_AER_DRIVER = (__force pci_ers_result_t) 6,
> +
> +	/* System is unstable, panic. Is CXL specific */
> +	PCI_ERS_RESULT_PANIC = (__force pci_ers_result_t) 7,
>  };
>  
>  /* PCI bus error event callbacks */
> -- 
> 2.34.1
> 

