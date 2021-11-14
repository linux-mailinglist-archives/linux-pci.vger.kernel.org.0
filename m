Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C061E44F70A
	for <lists+linux-pci@lfdr.de>; Sun, 14 Nov 2021 07:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbhKNGZa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 14 Nov 2021 01:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbhKNGZ3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 14 Nov 2021 01:25:29 -0500
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44168C061570
        for <linux-pci@vger.kernel.org>; Sat, 13 Nov 2021 22:22:36 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 96C04100EF4D1;
        Sun, 14 Nov 2021 07:22:31 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 55E2BF5A09; Sun, 14 Nov 2021 07:22:31 +0100 (CET)
Date:   Sun, 14 Nov 2021 07:22:31 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kw@linux.com
Subject: Re: [PATCH v1 1/1] PCI: probe: Use pci_find_vsec_capability() when
 looking for TBT devices
Message-ID: <20211114062231.GA10937@wunner.de>
References: <20211109151604.17086-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109151604.17086-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 09, 2021 at 05:16:04PM +0200, Andy Shevchenko wrote:
> -	while ((vsec = pci_find_next_ext_capability(dev, vsec,
> -						    PCI_EXT_CAP_ID_VNDR))) {
> -		pci_read_config_dword(dev, vsec + PCI_VNDR_HEADER, &header);
> -
> -		/* Is the device part of a Thunderbolt controller? */

Could you preserve that code comment please so that an uninitiated
reader knows what the is_thunderbolt flag is about?

Thanks!

Lukas

> -		if (dev->vendor == PCI_VENDOR_ID_INTEL &&
> -		    PCI_VNDR_HEADER_ID(header) == PCI_VSEC_ID_INTEL_TBT) {
> -			dev->is_thunderbolt = 1;
> -			return;
> -		}
> -	}
> +	vsec = pci_find_vsec_capability(dev, PCI_VENDOR_ID_INTEL, PCI_VSEC_ID_INTEL_TBT);
> +	if (vsec)
> +		dev->is_thunderbolt = 1;
