Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6EC1A8C99
	for <lists+linux-pci@lfdr.de>; Tue, 14 Apr 2020 22:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633231AbgDNUhP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Apr 2020 16:37:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633249AbgDNUhO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Apr 2020 16:37:14 -0400
Received: from localhost (mobile-166-175-184-103.mycingular.net [166.175.184.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6550D2076C;
        Tue, 14 Apr 2020 20:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586896633;
        bh=1kEessR5Rmc3hm/dxFQZPXCSt5/iIogI84U0YsP7EG0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dVleGaxaCs/x2eXvs3oxo4ao97oEJ+MLmeXA3r4YbSnq3pmpBtf4y0rDZC9PtK50b
         xdm8BjqRb/Jbm2Hqt69GRJ3mhVpJ/svl9eBlF3WWikJdGsBLU14GT5A67MvaN4r+Z0
         oMV08TEkamV+bqk8InrsN6HYQBrJRP94D73/lge4=
Date:   Tue, 14 Apr 2020 15:37:11 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sean V Kelley <sean.v.kelley@linux.intel.com>
Cc:     mj@ucw.cz, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 2/2] pciutils: Decode Compute eXpress Link DVSEC
Message-ID: <20200414203711.GA102808@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413153526.805776-3-sean.v.kelley@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 13, 2020 at 08:35:26AM -0700, Sean V Kelley wrote:
> Compute eXpress Link[1] is a new CPU interconnect created with
> workload accelerators in mind. The interconnect relies on PCIe
> electrical and physical interconnect for communication via a Flex Bus
> port which allows designs to choose between providing PCIe or CXL.
> 
> This patch introduces basic support for lspci decode of CXL and
> builds upon the existing Designated Vendor-Specific support in
> lspci through identification of a Flex Bus capable Vendor ID.

I don't think this is quite right.  Isn't the Flex Bus ID the
"DVSEC ID" (not the "DVSEC Vendor ID")?

> +static int
> +is_flexbus_cap(struct device *d, int where)
> +{
> +  u32 hdr;
> +  u16 w;
> +
> +  if (!config_fetch(d, where + PCI_DVSEC_HEADER1, 8))
> +    return 0;

And here, I think we need to check the "DVSEC Vendor ID" first, i.e.,
in the log below, I guess we'd look for the Intel Vendor ID (0x8086).

We can only decode the capability if *both* the DVSEC Vendor ID
(HEADER1) and the DVSEC ID (HEADER2) match.

> +  /* Check for Designated Vendor-Specific Flex Bus Capable ID */
> +  hdr = get_conf_long(d, where + PCI_DVSEC_HEADER2);
> +  w = BITS(hdr, 0, 16);
> +  if (w == PCI_DVSEC_FLEXBUS_ID)
> +    return 1;
> +
> +  return 0;
> +}
> +
>  static void
>  cap_dvsec(struct device *d, int where)
>  {
> @@ -947,7 +992,10 @@ show_ext_caps(struct device *d, int type)
>  	    printf("Readiness Time Reporting <?>\n");
>  	    break;
>  	  case PCI_EXT_CAP_ID_DVSEC:
> -	    cap_dvsec(d, where);
> +	    if (is_flexbus_cap(d, where))
> +	      cap_cxl(d, where);
> +	    else
> +	      cap_dvsec(d, where);
>  	    break;
>  	  case PCI_EXT_CAP_ID_VF_REBAR:
>  	    printf("VF Resizable BAR <?>\n");

> +        Capabilities: [e00 v1] CXL Designated Vendor-Specific:
> +                CXLCap: Cache+ IO+ Mem+ Mem HW Init+ HDMCount 1 Viral-
> +                CXLCtl: Cache+ IO+ Mem- Cache SF Cov 0 Cache SF Gran 0 Cache Clean- Viral-
> +                CXLSta: Viral-
> +        Capabilities: [e38 v1] Device Serial Number 12-34-56-78-90-00-00-00

> +e00: 23 00 81 e3 86 80 80 03 00 00 1f 00 03 00 00 00
> +e10: 00 00 00 00 00 00 00 00 00 00 00 00 03 01 00 08
> +e20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> +e30: 00 00 00 00 00 00 00 00 03 00 01 00 00 00 00 90
> +e40: 78 56 34 12 00 00 00 00 00 00 00 00 00 00 00 00

