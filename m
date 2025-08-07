Return-Path: <linux-pci+bounces-33579-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 033D4B1DED9
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 23:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB4718C12F0
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 21:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDFB1EEA5D;
	Thu,  7 Aug 2025 21:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgA49b+q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC89D4430;
	Thu,  7 Aug 2025 21:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754602038; cv=none; b=e5V/IyEo4EMnZ1CfdWdvc87iHhq8acLpjo5k/inAHsYVIQhAbSLJpitU3UiLqOmdzTQCbXR+anY/6Hfa1TMy04tpeVAbWBNdGtpStNXCmL4jlifmP5K+pFqr0SsREzE5bhaPTTgNFOxSyhfrD6jecOCCrN/mYKRj5S43e3uRRFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754602038; c=relaxed/simple;
	bh=M+BpxkzLlHggZ+tzzpG3I7CKLqmuVCeyZCvynYpp+cI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BxC5L7XyYLByBQH0Dy994+tzUX8tAOo2L4bbpazIhZ+K0PQ1Om4aYnek5lTWoMm0Dwx36JyXCrog9nbha0HXavh18EMC4lQOhEUF3hdCHS+IKtSUOCCsku/NgcGZ4GZMNO0zM2wz0/LW1c2ZH8zhFVBQwTUbXqJGlF8b+vFRhqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgA49b+q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C326C4CEEB;
	Thu,  7 Aug 2025 21:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754602038;
	bh=M+BpxkzLlHggZ+tzzpG3I7CKLqmuVCeyZCvynYpp+cI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tgA49b+qML6PL5Nw3Npd8nkQGofTTIN3bl8U8n3258gH2XQRG775PVx5zWEXpt7qx
	 ShgISsRS3CBesFuYKQ4lTECYOZrFprP7FZvwF/Y4oGoG8Lb9NV7sKRcNlF+dYYXasK
	 odmm5pnqmuUImoscTfYT6tPlYQGgDMGvMcVT/o+Ig8BX992zWm/GF5rqJyfYjpfOB6
	 2zTFUKVCZ557RnvFH6yb67pJAy74x6sS644GXb2fYwPsCaEFuOjGntgXlB/uRTQrwF
	 yLAONkcemsMR6FMbDQ6ApOys6l3BR2uUF+WCNH9sM7LfGZDakfWIBRbdc7fjHrDJb9
	 IjM1iYbTwzk9g==
Date: Thu, 7 Aug 2025 16:27:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, bhelgaas@google.com, aik@amd.com,
	lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v4 04/10] PCI/TSM: Authenticate devices via platform TSM
Message-ID: <20250807212716.GA62016@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717183358.1332417-5-dan.j.williams@intel.com>

On Thu, Jul 17, 2025 at 11:33:52AM -0700, Dan Williams wrote:
> The PCIe 6.1 specification, section 11, introduces the Trusted Execution
> Environment (TEE) Device Interface Security Protocol (TDISP).  This
> protocol definition builds upon Component Measurement and Authentication
> (CMA), and link Integrity and Data Encryption (IDE). It adds support for
> assigning devices (PCI physical or virtual function) to a confidential
> VM such that the assigned device is enabled to access guest private
> memory protected by technologies like Intel TDX, AMD SEV-SNP, RISCV
> COVE, or ARM CCA.

Previous patches reference PCIe r6.2.  Personally I would change them
all the citations to r7.0, since that's out now and (I assume)
includes everything.  I guess you said "introduced in r6.1," which is
not the same as "introduced in r7.0," but I'm not sure how relevant it
is to know that very first revision.

> The operations that can be executed against a PCI device are split into
> 2 mutually exclusive operation sets, "Link" and "Security" (struct

s/2/two/  Old skool, but you obviously pay attention to details like
that :)

> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> +What:		/sys/bus/pci/devices/.../tsm/
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		This directory only appears if a physical device function
> +		supports authentication (PCIe CMA-SPDM), interface security
> +		(PCIe TDISP), and is accepted for secure operation by the
> +		platform TSM driver. This attribute directory appears
> +		dynamically after the platform TSM driver loads. So, only after
> +		the /sys/class/tsm/tsm0 device arrives can tools assume that
> +		devices without a tsm/ attribute directory will never have one,
> +		before that, the security capabilities of the device relative to
> +		the platform TSM are unknown. See
> +		Documentation/ABI/testing/sysfs-class-tsm.

s/never have one,/never have one;/

> +++ b/drivers/pci/tsm.c
> +#define dev_fmt(fmt) "TSM: " fmt

Include "PCI" for context?

> + * Provide a read/write lock against the init / exit of pdev tsm
> + * capabilities and arrival/departure of a tsm instance

s/tsm/TSM/ in comments.

> +static void pci_tsm_walk_fns(struct pci_dev *pdev,
> +			     int (*cb)(struct pci_dev *pdev, void *data),
> +			     void *data)
> +{
> +	struct pci_dev *fn;
> +	int i;
> +
> +	/* walk virtual functions */
> +        for (i = 0; i < pci_num_vf(pdev); i++) {
> +		fn = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
> +						 pci_iov_virtfn_bus(pdev, i),
> +						 pci_iov_virtfn_devfn(pdev, i));
> +		if (call_cb_put(fn, data, cb))
> +			return;
> +        }
> +
> +	/* walk subordinate physical functions */
> +	for (i = 1; i < 8; i++) {
> +		fn = pci_get_slot(pdev->bus,
> +				  PCI_DEVFN(PCI_SLOT(pdev->devfn), i));
> +		if (call_cb_put(fn, data, cb))
> +			return;
> +	}
> +
> +	/* walk downstream devices */
> +        if (pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM)
> +                return;
> +
> +        if (!is_dsm(pdev))
> +                return;
> +
> +        pci_walk_bus(pdev->subordinate, cb, data);

What's the difference between all this and just pci_walk_bus() of
pdev->subordinate?  Are VFs not included in that walk?  Maybe a
hint here would be useful.

> +static int pci_tsm_connect(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
> +{
> +	int rc;
> +	struct pci_tsm_pf0 *tsm_pf0;
> +	const struct pci_tsm_ops *ops = tsm_pci_ops(tsm_dev);
> +	struct pci_tsm *pci_tsm __free(tsm_remove) = ops->probe(pdev);
> +
> +	if (!pci_tsm)
> +		return -ENXIO;
> +
> +	pdev->tsm = pci_tsm;
> +	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
> +
> +	ACQUIRE(mutex_intr, lock)(&tsm_pf0->lock);
> +	if ((rc = ACQUIRE_ERR(mutex_intr, &lock)))
> +		return rc;
> +
> +	rc = ops->connect(pdev);
> +	if (rc)
> +		return rc;
> +
> +	pdev->tsm = no_free_ptr(pci_tsm);
> +
> +	/*
> +	 * Now that the DSM is established, probe() all the potential
> +	 * dependent functions. Failure to probe a function is not fatal
> +	 * to connect(), it just disables subsequent security operations
> +	 * for that function.
> +	 */
> +	pci_tsm_probe_fns(pdev);

Makes me wonder what happens if a device is hot-added in the
hierarchy.  I guess nothing.  Is that what we want?  What would be the
flow if we *did* want to do something?  I guess disconnect and connect
again?

> + * Find the PCI Device instance that serves as the Device Security
> + * Manger (DSM) for @pdev. Note that no additional reference is held for

s/Manger/Manager/

> +	 * For cases where a switch may be hosting TDISP services on
> +	 * behalf of downstream devices, check the first usptream port
> +	 * relative to this endpoint.

s/usptream/upstream/

> +++ b/include/linux/pci-tsm.h
> + * struct pci_tsm_ops - manage confidential links and security state
> + * @link_ops: Coordinate PCIe SPDM and IDE establishment via a platform TSM.
> + * 	      Provide a secure session transport for TDISP state management
> + * 	      (typically bare metal physical function operations).
> + * @sec_ops: Lock, unlock, and interrogate the security state of the
> + *	     function via the platform TSM (typically virtual function
> + *	     operations).
> + * @owner: Back reference to the TSM device that owns this instance.
> + *
> + * This operations are mutually exclusive either a tsm_dev instance
> + * manages phyiscal link properties or it manages function security
> + * states like TDISP lock/unlock.

s/phyiscal/physical/

> +struct pci_tsm_ops {
> +	/*
> +	 * struct pci_tsm_link_ops - Manage physical link and the TSM/DSM session
> +	 * @probe: probe device for tsm link operation readiness, setup
> +	 *	   DSM context

s/tsm link/TSM link/

> +	 * struct pci_tsm_security_ops - Manage the security state of the function
> +	 * @sec_probe: probe device for tsm security operation
> +	 *	       readiness, setup security context

s/for tsm/for TSM/

> + * struct pci_tsm - Core TSM context for a given PCIe endpoint
> + * @pdev: Back ref to device function, distinguishes type of pci_tsm context
> + * @dsm: PCI Device Security Manager for link operations on @pdev.

Extra period at end, unlike others.

> + * @ops: Link Confidentiality or Device Function Security operations

> +static inline bool is_pci_tsm_pf0(struct pci_dev *pdev)
> +{
> +	if (!pci_is_pcie(pdev))
> +		return false;
> +
> +	if (pdev->is_virtfn)
> +		return false;
> +
> +	/*
> +	 * Allow for a Device Security Manager (DSM) associated with function0
> +	 * of an Endpoint to coordinate TDISP requests for other functions
> +	 * (physical or virtual) of the device, or allow for an Upstream Port
> +	 * DSM to accept TDISP requests for switch Downstream Endpoints.

What exactly is a "switch Downstream Endpoint"?  Do you mean a "Switch
Downstream Port"?  Or an Endpoint that is downstream of a Switch?

Bjorn

