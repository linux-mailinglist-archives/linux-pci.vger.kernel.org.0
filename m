Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2215486B32
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2019 22:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404174AbfHHUPk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Aug 2019 16:15:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389974AbfHHUPk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Aug 2019 16:15:40 -0400
Received: from localhost (unknown [150.199.191.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EC8D216C8;
        Thu,  8 Aug 2019 20:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565295339;
        bh=NN99e5PHnfVmaKBrXc64nZkhR1BnM4m3Qolu56N/q/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PSwBxDwD5PNtiGP6UVcmsaSNYmAE7wY4wqZ0Qz2LOdzsasewk+C4887SX/IZ3k9ki
         /e4Ckyi6Igw8L7lxU4a82HPEQ0jaBIIUcUoZoPRLs8jdHJkCWPV2PDTsNOXSKAHQ1k
         NwYcXRexc4ny4k4Aj1bA84M7S090ygstF5/cgL94=
Date:   Thu, 8 Aug 2019 15:15:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: PCI: Correct the resource_alignment parameter example
Message-ID: <20190808201538.GB7302@google.com>
References: <20190606032557.107542-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606032557.107542-1-aik@ozlabs.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 06, 2019 at 01:25:57PM +1000, Alexey Kardashevskiy wrote:
> The option description requires an order and so does the option
> parsing code, however the example uses a size, fix this.
> 
> Fixes: 8b078c603249 ("PCI: Update "pci=resource_alignment" documentation")
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to pci/resource for v5.4, thanks!

> ---
>  Documentation/admin-guide/kernel-parameters.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 2b8ee90bb644..dcb53d64ad74 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3340,27 +3340,28 @@
>  		resource_alignment=
>  				Format:
>  				[<order of align>@]<pci_dev>[; ...]
>  				Specifies alignment and device to reassign
>  				aligned memory resources. How to
>  				specify the device is described above.
>  				If <order of align> is not specified,
>  				PAGE_SIZE is used as alignment.
>  				PCI-PCI bridge can be specified, if resource
>  				windows need to be expanded.
>  				To specify the alignment for several
>  				instances of a device, the PCI vendor,
>  				device, subvendor, and subdevice may be
> -				specified, e.g., 4096@pci:8086:9c22:103c:198f
> +				specified, e.g., 12@pci:8086:9c22:103c:198f
> +				for the 4096 alignment.
>  		ecrc=		Enable/disable PCIe ECRC (transaction layer
>  				end-to-end CRC checking).
>  				bios: Use BIOS/firmware settings. This is the
>  				the default.
>  				off: Turn ECRC off
>  				on: Turn ECRC on.
>  		hpiosize=nn[KMG]	The fixed amount of bus space which is
>  				reserved for hotplug bridge's IO window.
>  				Default size is 256 bytes.
>  		hpmemsize=nn[KMG]	The fixed amount of bus space which is
>  				reserved for hotplug bridge's memory window.
>  				Default size is 2 megabytes.
>  		hpbussize=nn	The minimum amount of additional bus numbers
> -- 
> 2.17.1
> 
