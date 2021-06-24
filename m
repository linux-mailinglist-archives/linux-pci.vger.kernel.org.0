Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55F23B2EDD
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jun 2021 14:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhFXMZb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 08:25:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhFXMZ3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jun 2021 08:25:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A700613EC;
        Thu, 24 Jun 2021 12:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624537390;
        bh=rmf7ragLQsx12kP7udAKSz/Aa/cGJBbFX2RgFPlayrM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RHYvYSsoliCiIFyHs9ZZD4iSKUyuMQNOHiydFyIMIFrP7pLsdONMzGClKOPfa7ekD
         pIf03P9gjPEe5395F8Bfc/KWlTU5rd0gdJgGC/8rp1IOiM9jU17yrR2IwCiIEh+JNB
         jukIzCqD2xczuyyYJvWsLgN0TaxLRdkT+Qp/CcEUQkpWkZVIYG3t76Py+U9zn2SlWN
         gvbefrPzqLZAcV4w8Mcb4U3VdLS+9hV7mYBM7hRylpESq2lqAxrQ7XmgFsts2Waybx
         15kHsEMzJg4zOCCnD2XGncZqA4OZbMTEhW/2IXAuAXTFwdw2rijwrMaTOxeKUtmfmH
         3kH39qM0Msn3w==
Date:   Thu, 24 Jun 2021 07:23:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v7 1/8] PCI: Add pcie_reset_flr to follow calling
 convention of other reset methods
Message-ID: <20210624122309.GA3518896@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608054857.18963-2-ameynarkhede03@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 08, 2021 at 11:18:50AM +0530, Amey Narkhede wrote:
> Currently there is separate function pcie_has_flr() to probe if pcie flr is
> supported by the device which does not match the calling convention
> followed by reset methods which use second function argument to decide
> whether to probe or not.  Add new function pcie_reset_flr() that follows
> the calling convention of reset methods.

> +/**
> + * pcie_reset_flr - initiate a PCIe function level reset
> + * @dev: device to reset
> + * @probe: If set, only check if the device can be reset this way.
> + *
> + * Initiate a function level reset on @dev.
> + */
> +int pcie_reset_flr(struct pci_dev *dev, int probe)
> +{
> +	u32 cap;
> +
> +	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
> +		return -ENOTTY;
> +
> +	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
> +	if (!(cap & PCI_EXP_DEVCAP_FLR))
> +		return -ENOTTY;
> +
> +	if (probe)
> +		return 0;
> +
> +	return pcie_flr(dev);
> +}

Tangent: I've been told before, but I can't remember why we need the
"probe" interface.  Since we're looking at this area again, can we add
a comment to clarify this?

Every time I read this, I wonder why we can't just get rid of the
probe and attempt a reset.  If it fails because it's not supported, we
could just try the next one in the list.
