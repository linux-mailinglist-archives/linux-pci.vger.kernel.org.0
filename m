Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A696F25B668
	for <lists+linux-pci@lfdr.de>; Thu,  3 Sep 2020 00:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgIBWYC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 18:24:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:41480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbgIBWYB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Sep 2020 18:24:01 -0400
Received: from localhost (47.sub-72-107-117.myvzw.com [72.107.117.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 026FD2078E;
        Wed,  2 Sep 2020 22:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599085441;
        bh=5f7lIb4QbY0622F+X0Ir61gDDo4JrTGNJF1iLeYsr5g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=GFoXKBHYPK3IE5Z+NMEBvUGCzp5Fbz0GBdAR1mpA5qJajW74QUuaFBd/7q0PO0/6y
         +QjauDCERpleThcGXm8nwZ8oV8HlFC2pAqU1CggsulTuIdJ8SddxWhHwicr2Xy4teZ
         SIRTl865r5MvpwouDwlDmJ2/otEeFob/4j15e6/w=
Date:   Wed, 2 Sep 2020 17:23:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc:     amd-gfx@lists.freedesktop.org,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, alexander.deucher@amd.com,
        nirmodas@amd.com, Dennis.Li@amd.com, christian.koenig@amd.com,
        luben.tuikov@amd.com, bhelgaas@google.com
Subject: Re: [PATCH v4 4/8] drm/amdgpu: Fix consecutive DPC recovery failures.
Message-ID: <20200902222359.GA272485@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599072130-10043-5-git-send-email-andrey.grodzovsky@amd.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 02, 2020 at 02:42:06PM -0400, Andrey Grodzovsky wrote:
> Cache the PCI state on boot and before each case where we might
> loose it.

s/loose/lose/

> v2: Add pci_restore_state while caching the PCI state to avoid
> breaking PCI core logic for stuff like suspend/resume.
> 
> v3: Extract pci_restore_state from amdgpu_device_cache_pci_state
> to avoid superflous restores during GPU resets and suspend/resumes.
> 
> v4: Style fixes.

Is the DRM convention to keep the v2/v3/v4 stuff in the commit log?  I
keep those below the "---" or manually remove them for PCI, but use
the local convention, of course.

> +	/* Have stored pci confspace at hand for restore in sudden PCI error */

I assume that at least from the perspective of this code, all PCI
errors are "sudden".  Or if they're not, I'm curious about which would
be sudden and which would not.

> +	if (amdgpu_device_cache_pci_state(adev->pdev))
> +		pci_restore_state(pdev);

> +bool amdgpu_device_cache_pci_state(struct pci_dev *pdev)
> +{
> +	struct drm_device *dev = pci_get_drvdata(pdev);
> +	struct amdgpu_device *adev = drm_to_adev(dev);
> +	int r;
> +
> +	r = pci_save_state(pdev);
> +	if (!r) {
> +		kfree(adev->pci_state);
> +
> +		adev->pci_state = pci_store_saved_state(pdev);
> +
> +		if (!adev->pci_state) {
> +			DRM_ERROR("Failed to store PCI saved state");
> +			return false;
> +		}
> +	} else {
> +		DRM_WARN("Failed to save PCI state, err:%d\n", r);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +bool amdgpu_device_load_pci_state(struct pci_dev *pdev)
> +{
> +	struct drm_device *dev = pci_get_drvdata(pdev);
> +	struct amdgpu_device *adev = drm_to_adev(dev);
> +	int r;
> +
> +	if (!adev->pci_state)
> +		return false;
> +
> +	r = pci_load_saved_state(pdev, adev->pci_state);

I'm a little bit hesitant to pci_load_saved_state() and
pci_store_saved_state() being used here, simply because they're
currently only used by VFIO, Xen, and nvme.  So I don't have a real
objection, but just pointing out that apparently you're doing
something really special that isn't commonly used and tested, so it's
more likely to be broken or incomplete.

There's lots of state that the PCI core *can't* save/restore, and
pci_load_saved_state() doesn't even handle all the architected PCI
state, i.e., we only call pci_add_cap_save_buffer() or
pci_add_ext_cap_save_buffer() for a few of the capabilities.
