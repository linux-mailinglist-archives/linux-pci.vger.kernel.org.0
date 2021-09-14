Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C34640BA15
	for <lists+linux-pci@lfdr.de>; Tue, 14 Sep 2021 23:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234522AbhINVT5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Sep 2021 17:19:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:34166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234344AbhINVT4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Sep 2021 17:19:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9765460F4A;
        Tue, 14 Sep 2021 21:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631654318;
        bh=+Thh9ySVMqSVqEQEAhx3cZ/Q2OrjZ2vHh7kqCsxy8O4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZpFqOivNBYbDyMr5IoxPI0mxkCKQ+5l6DYplnUYEteBmym0FFsnZ7EhyX2SfUY9Ff
         YcQFgG0m5jpiizVpsR6V9MJGHT8CU4lwamYyZV1M7TRbzqAWrybZedpFWkIgvsKs3U
         Uh8LHt54l//5R4YROucYl3kpDkATsr/mvDQ9KLZ/YhzKUFCYg2HsetOBuYMIb1/DMS
         lYk2bC554UhWYsbTZ/6SXGN/OQOfYQ97VVNMeCdb/GrA7hgoFGHEgOH/uYCj/9tr3e
         krQEZ4u9KMkY41IUBS6R8SIopF5Z5MPCQ/GT/AmgdE4PpwgDRajdEKkyPCHWXhN5xG
         sI+Ac2ELED6DA==
Date:   Tue, 14 Sep 2021 16:18:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nathan Rossi <nathan@nathanrossi.com>
Cc:     linux-pci@vger.kernel.org, Nathan Rossi <nathan.rossi@digi.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3] PCI: Add ACS errata for Pericom PI7C9X2G switches
Message-ID: <20210914211837.GA1458880@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910025823.196508-1-nathan@nathanrossi.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 10, 2021 at 02:58:23AM +0000, Nathan Rossi wrote:
> From: Nathan Rossi <nathan.rossi@digi.com>
> 
> The Pericom PI7C9X2G404/PI7C9X2G304/PI7C9X2G303 PCIe switches have an
> errata for ACS P2P Request Redirect behaviour when used in the
> cut-through forwarding mode. The recommended work around for this issue
> is to use the switch in store and forward mode. The errata results in
> packets being queued and not being delivered upstream, this can be
> observed as very poor downstream device performance and/or dropped
> device generated data/interrupts.
> 
> This change adds a fixup specific to this switch that when enabling or
> resuming the downstream port it checks if it has enabled ACS P2P Request
> Redirect, and if so changes the device (via the upstream port) to use
> the store and forward operating mode.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=177471
> Signed-off-by: Nathan Rossi <nathan.rossi@digi.com>
> Tested-by: Alex Williamson <alex.williamson@redhat.com>

Applied to pci/virtualization for v5.16, thanks!

> ---
> Changes in v2:
> - Added DECLARE_PCI_FIXUP_RESUME to handle applying fixup upon resume as
>   switch operation may have been reset or ACS configuration may have
>   changed
> Changes in v3:
> - Apply fixup to PI7C9X2G303 and PI7C9X2G304 switch models, these models
>   are also covered by the errata, although have not been validated
> - Rename PI7C9X2G404 defines to more generic PI7C9X2Gxxx
> ---
>  drivers/pci/quirks.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index e5089af8ad..f7cbc4fa40 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5790,3 +5790,59 @@ static void apex_pci_fixup_class(struct pci_dev *pdev)
>  }
>  DECLARE_PCI_FIXUP_CLASS_HEADER(0x1ac1, 0x089a,
>  			       PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_class);
> +
> +/*
> + * Pericom PI7C9X2G404/PI7C9X2G304/PI7C9X2G303 switch errata E5 - ACS P2P Request
> + * Redirect is not functional
> + *
> + * When ACS P2P Request Redirect is enabled and bandwidth is not balanced
> + * between upstream and downstream ports, packets are queued in an internal
> + * buffer until CPLD packet. The workaround is to use the switch in store and
> + * forward mode.
> + */
> +#define PI7C9X2Gxxx_MODE_REG		0x74
> +#define PI7C9X2Gxxx_STORE_FORWARD_MODE	BIT(0)
> +static void pci_fixup_pericom_acs_store_forward(struct pci_dev *pdev)
> +{
> +	struct pci_dev *upstream;
> +	u16 val;
> +
> +	/* Downstream ports only */
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM)
> +		return;
> +
> +	/* Check for ACS P2P Request Redirect use */
> +	if (!pdev->acs_cap)
> +		return;
> +	pci_read_config_word(pdev, pdev->acs_cap + PCI_ACS_CTRL, &val);
> +	if (!(val & PCI_ACS_RR))
> +		return;
> +
> +	upstream = pci_upstream_bridge(pdev);
> +	if (!upstream)
> +		return;
> +
> +	pci_read_config_word(upstream, PI7C9X2Gxxx_MODE_REG, &val);
> +	if (!(val & PI7C9X2Gxxx_STORE_FORWARD_MODE)) {
> +		pci_info(upstream, "Setting PI7C9X2Gxxx store-forward mode\n");
> +		/* Enable store-foward mode */
> +		pci_write_config_word(upstream, PI7C9X2Gxxx_MODE_REG, val |
> +				      PI7C9X2Gxxx_STORE_FORWARD_MODE);
> +	}
> +}
> +/*
> + * Apply fixup on enable and on resume, in order to apply the fix up whenever
> + * ACS configuration changes or switch mode is reset
> + */
> +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0x2404,
> +			 pci_fixup_pericom_acs_store_forward);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0x2404,
> +			 pci_fixup_pericom_acs_store_forward);
> +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0x2304,
> +			 pci_fixup_pericom_acs_store_forward);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0x2304,
> +			 pci_fixup_pericom_acs_store_forward);
> +DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0x2303,
> +			 pci_fixup_pericom_acs_store_forward);
> +DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0x2303,
> +			 pci_fixup_pericom_acs_store_forward);
> ---
> 2.33.0
