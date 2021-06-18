Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82DE73AD59A
	for <lists+linux-pci@lfdr.de>; Sat, 19 Jun 2021 01:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhFRXDq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Jun 2021 19:03:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:44498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231240AbhFRXDo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Jun 2021 19:03:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2AFA1613BD;
        Fri, 18 Jun 2021 23:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624057294;
        bh=O1HK2H+gu/eyMSlkJPLC7a6tkuqX8DtvddAbywKNgsY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AwlM75/MLDYy2ICXfXKfgBe+lffzr9iRQdVYubIDEDRCZn2QBg8NRxVp1nmERZx0K
         VJk/xLkFoiYZh+SPdCLHlhUtra58DbPOdmy5mFL2Agnd2xL+5p74UNPN9NfEi2otoN
         8V8wCIr3mQ/R1whT+fDFA7vpHPe+cRR+9JS/SPFT/Y6g1xYhA9Njq78YxZC1BpeFIW
         9QgL0SIPuoItZvKcwfeLaefKIFggtxY9pB6CeDZKy+38jzLU2db7EcBDYCvsjq1HuU
         Gydk6a8b3tP8rJyS95wI4tkeeLoVxNpTrNWCqODTn19GCfrIJ7UD6m88vRNyXI1jfP
         DMfaE0ADiIP0w==
Date:   Fri, 18 Jun 2021 18:01:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Artem Lapkin <email2tema@gmail.com>
Cc:     narmstrong@baylibre.com, yue.wang@Amlogic.com,
        khilman@baylibre.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, jbrunet@baylibre.com, christianshewitt@gmail.com,
        martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        art@khadas.com, nick@khadas.com, gouwa@khadas.com
Subject: Re: [PATCH] PCI: dwc: meson add quirk
Message-ID: <20210618230132.GA3228427@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618063821.1383357-1-art@khadas.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 18, 2021 at 02:38:21PM +0800, Artem Lapkin wrote:
> Device set same 256 bytes maximum read request size equal MAX_READ_REQ_SIZE
> was find some issue with HDMI scrambled picture and nvme devices
> at intensive writing...

Wait a minute.  We're getting way too much of this MRRS fiddling with 
too little understanding of what the real problem is, and this is
becoming a maintenance problem.

We need more details about what the problem is and what specific
devices are affected.  If this is a defect in the host bridge, we
should have published errata about this because AFAICT there is
nothing in the spec that limits the MRRS the OS can program.

If we need to work around a problem, the quirk should relate to the
device that is defective, not to every PCI device that could
potentially be plugged in.

Related recent issue:
https://lore.kernel.org/r/20210528203224.GA1516603@bjorn-Precision-5520

> [    4.798971] nvme 0000:01:00.0: fix MRRS from 512 to 256
> 
> This quirk setup same MRRS if we try solve this problem with
> pci=pcie_bus_perf kernel command line param
> 
> Signed-off-by: Artem Lapkin <art@khadas.com>
> ---
>  drivers/pci/controller/dwc/pci-meson.c | 27 ++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
> index 686ded034f22..e2d40e5c2661 100644
> --- a/drivers/pci/controller/dwc/pci-meson.c
> +++ b/drivers/pci/controller/dwc/pci-meson.c
> @@ -466,6 +466,33 @@ static int meson_pcie_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static void meson_pcie_quirk(struct pci_dev *dev)
> +{
> +	int mrrs;
> +
> +	/* no need quirk */
> +	if (pcie_bus_config != PCIE_BUS_DEFAULT)
> +		return;
> +
> +	/* no need for root bus */
> +	if (pci_is_root_bus(dev->bus))
> +		return;
> +
> +	mrrs = pcie_get_readrq(dev);
> +
> +	/*
> +	 * set same 256 bytes maximum read request size equal MAX_READ_REQ_SIZE
> +	 * was find some issue with HDMI scrambled picture and nvme devices
> +	 * at intensive writing...
> +	 */
> +
> +	if (mrrs != MAX_READ_REQ_SIZE) {
> +		dev_info(&dev->dev, "fix MRRS from %d to %d\n", mrrs, MAX_READ_REQ_SIZE);
> +		pcie_set_readrq(dev, MAX_READ_REQ_SIZE);
> +	}
> +}
> +DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, meson_pcie_quirk);
> +
>  static const struct of_device_id meson_pcie_of_match[] = {
>  	{
>  		.compatible = "amlogic,axg-pcie",
> -- 
> 2.25.1
> 
