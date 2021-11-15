Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C025451D43
	for <lists+linux-pci@lfdr.de>; Tue, 16 Nov 2021 01:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351867AbhKPA0S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 19:26:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:39368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344431AbhKOUHt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Nov 2021 15:07:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A788E61B73;
        Mon, 15 Nov 2021 20:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637006694;
        bh=NSvZp3iPvOIxlsXyrCf2huEoqllZk2lj2JhQrEmhSL0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AfdQRVAHBRHDiZBWWWHUIAkS2G6UUWAK06tD3lB0HRB/x9XzUFwTRxwp6PjFqD3nR
         POhJSObI1wt5S2DdZV/Ncj+4XHU89pgMMDg5L5oTZglglytiCxDU6Dw9ILKVYLM7As
         iq0jnt23DYANUFOS7B9NBwn0Jo5AfpKyFphuZyQ7SKfc6yxaaYJoFSfz50NHrBWzwV
         ttxfK0xlI7XyEOMjbdBhgzj/EdpBRKzfZQe8RYAFWcly8W8+OCFAtNjfaSB32KSpPB
         naJSef57Typs6c5CmPk4J8gTh1blvyV8ZFneiVFmlcgWG2Dk7kHIsZeRVZErfEukhJ
         11jjTHjv5fe4Q==
Date:   Mon, 15 Nov 2021 14:04:52 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH v2 1/1] PCI: probe: Use pci_find_vsec_capability() when
 looking for TBT devices
Message-ID: <20211115200452.GA1584559@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211115112902.24033-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 15, 2021 at 01:29:02PM +0200, Andy Shevchenko wrote:
> Currently the set_pcie_thunderbolt() open codes pci_find_vsec_capability().
> Refactor the former to use the latter. No functional change intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Applied to pci/enumeration for v5.17, thanks!

> ---
> v2: preserved comment (Lukas), added tag (Krzysztof)
>  drivers/pci/probe.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 087d3658f75c..496c8b8d903c 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1579,20 +1579,12 @@ void set_pcie_hotplug_bridge(struct pci_dev *pdev)
>  
>  static void set_pcie_thunderbolt(struct pci_dev *dev)
>  {
> -	int vsec = 0;
> -	u32 header;
> +	u16 vsec;
>  
> -	while ((vsec = pci_find_next_ext_capability(dev, vsec,
> -						    PCI_EXT_CAP_ID_VNDR))) {
> -		pci_read_config_dword(dev, vsec + PCI_VNDR_HEADER, &header);
> -
> -		/* Is the device part of a Thunderbolt controller? */
> -		if (dev->vendor == PCI_VENDOR_ID_INTEL &&
> -		    PCI_VNDR_HEADER_ID(header) == PCI_VSEC_ID_INTEL_TBT) {
> -			dev->is_thunderbolt = 1;
> -			return;
> -		}
> -	}
> +	/* Is the device part of a Thunderbolt controller? */
> +	vsec = pci_find_vsec_capability(dev, PCI_VENDOR_ID_INTEL, PCI_VSEC_ID_INTEL_TBT);
> +	if (vsec)
> +		dev->is_thunderbolt = 1;
>  }
>  
>  static void set_pcie_untrusted(struct pci_dev *dev)
> -- 
> 2.33.0
> 
