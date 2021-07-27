Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79063D7E96
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jul 2021 21:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhG0Tn0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jul 2021 15:43:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:35538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229681AbhG0Tn0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Jul 2021 15:43:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6346060F59;
        Tue, 27 Jul 2021 19:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627415005;
        bh=o6qWwx7LdlYs6TGKj7dgZgd0iWbyc7atqvh4Ovs2fko=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RS8H78fdsFyi4w/OrL3WrlSktn9h34cK7B8JSHNGqMS1kjAyJCQZlGODWDDYrLAfI
         1te8Spsqb3qfMXlCauJNLjAC/BeR++OJkpsyYF/UEnRuXDWT+K/qsN3BXCEFFGpYwh
         M0zoDB8mLW1D+xQuPdKSKFv5oUgQCrmTEDFe42t+0NP2k9XlE/uH4mh/maIQADIKwx
         HfOE21k3DsD0Ambrlt8KPTHBVxhgv9oUC9xZ1YD9W33sKiPMVmFLHfwCb7gCRN6Jz5
         Iv4XCmM6WcjWMLMXXSpxF5KqV1qkxX9m3I2YEI62OasEA7/FM/8LO+WIQiHTml+Ex+
         lx4d/EoXaSe+A==
Date:   Tue, 27 Jul 2021 14:43:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Artem Lapkin <email2tema@gmail.com>
Cc:     narmstrong@baylibre.com, yue.wang@Amlogic.com,
        khilman@baylibre.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, jbrunet@baylibre.com, christianshewitt@gmail.com,
        martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        art@khadas.com, nick@khadas.com, gouwa@khadas.com
Subject: Re: [PATCH v2] PCI: DWC: meson: add 256 bytes MRRS quirk
Message-ID: <20210727194323.GA725763@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727023000.1030525-1-art@khadas.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 27, 2021 at 10:30:00AM +0800, Artem Lapkin wrote:
> 256 bytes maximum read request size. They can't handle
> anything larger than this. So force this limit on
> any devices attached under these ports.

This needs to say whether this is a functional or a performance issue.

If it's a functional issue, i.e., if meson signals an error or abort
when it receives a read request for > 256 bytes, we need to explain
exactly what happens.

If it's a performance issue, we need to explain why MRRS affects
performance and that this is an optimization.

> Come-from: https://lkml.org/lkml/2021/6/18/160
> Come-from: https://lkml.org/lkml/2021/6/19/19

Please use lore.kernel.org URLs instead.  The lore URLs are a little
uglier, but are more functional, more likely to continue working, and
avoid the ads.  These are:

  https://lore.kernel.org/r/20210618230132.GA3228427@bjorn-Precision-5520
  https://lore.kernel.org/r/20210619063952.2008746-1-art@khadas.com

> It only affects PCIe in P2P, in non-P2P is will certainly affect
> transfers on the internal SoC/Processor/Chip internal bus/fabric.

This needs to explain how a field in a PCIe TLP affects transfers on
these non-PCIe fabrics.

> These quirks are currently implemented in the
> controller driver and only applies when the controller has been probed
> and to each endpoint detected on this particular controller.
> 
> Continue having separate quirks for each controller if the core
> isn't the right place to handle MPS/MRRS.

I see similar code in dwc/pci-keystone.c.  Does this problem actually
affect *all* DesignWare-based controllers?

If so, we should put the workaround in the common dwc code, e.g.,
pcie-designware.c or similar.  

It also seems to affect pci-loongson.c (not DesignWare-based).  Is
there some reason it has the same problem, e.g., does loongson contain
DesignWare IP, or does it use the same non-PCIe fabric?

> >> Neil
> 
> Signed-off-by: Artem Lapkin <art@khadas.com>
> ---
>  drivers/pci/controller/dwc/pci-meson.c | 31 ++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
> index 686ded034..1498950de 100644
> --- a/drivers/pci/controller/dwc/pci-meson.c
> +++ b/drivers/pci/controller/dwc/pci-meson.c
> @@ -466,6 +466,37 @@ static int meson_pcie_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static void meson_mrrs_limit_quirk(struct pci_dev *dev)
> +{
> +	struct pci_bus *bus = dev->bus;
> +	int mrrs, mrrs_limit = 256;
> +	static const struct pci_device_id bridge_devids[] = {
> +		{ PCI_DEVICE(PCI_VENDOR_ID_SYNOPSYS, PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3) },

I don't really believe that PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3 is the
only device affected here.  Is this related to the Meson root port, or
is it related to a PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3 on a plug-in card?
I guess the former, since you're searching upward for a root port.

So why is this limited to PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3?

> +		{ 0, },
> +	};
> +
> +	/* look for the matching bridge */
> +	while (!pci_is_root_bus(bus)) {
> +		/*
> +		 * 256 bytes maximum read request size. They can't handle
> +		 * anything larger than this. So force this limit on
> +		 * any devices attached under these ports.
> +		 */
> +		if (!pci_match_id(bridge_devids, bus->self)) {
> +			bus = bus->parent;
> +			continue;
> +		}
> +
> +		mrrs = pcie_get_readrq(dev);
> +		if (mrrs > mrrs_limit) {
> +			pci_info(dev, "limiting MRRS %d to %d\n", mrrs, mrrs_limit);
> +			pcie_set_readrq(dev, mrrs_limit);
> +		}
> +		break;
> +	}
> +}
> +DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, meson_mrrs_limit_quirk);
> +
>  static const struct of_device_id meson_pcie_of_match[] = {
>  	{
>  		.compatible = "amlogic,axg-pcie",
> -- 
> 2.25.1
> 
