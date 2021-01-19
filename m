Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B972FBF1B
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jan 2021 19:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390327AbhASSfC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jan 2021 13:35:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:57356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729244AbhASSe7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Jan 2021 13:34:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF15B22CAD;
        Tue, 19 Jan 2021 18:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611081257;
        bh=npoMGud/Iw0YvepzPzwovgq82kJjrZwGBV9fWSxQsss=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Ab2U1vrnYCgojZWYU9sJCLx5EeHkPO5r/M4fddI9c2ZKGOztsUEtAIIv/wU2G7Cyr
         3sFOmwdObW2+xDJAC8lXIpON6Vqfui4/3J+KbjAMrRxL1xpIqAfSlfiFPUWb268hmB
         cuK8mDa/Ug7Iu9HBSVVJO2GnJpt23Tj5P0ht88ZcaZmWB3vOOYKyhtNn6+2i1zhiX+
         9UsE1Lo9/G/NjBGZbcH84bVgy4sEOsTjdua5lIVm47mmxWU2mN66u22nAT5Exia9Gy
         6DnXkURogPHgywAGtM7Yy6myzgi9w/OFjnCL9Ja3dLDwNjhVPQGyLkjTGQVcXAfV0N
         tEFWqMPKG7bFQ==
Date:   Tue, 19 Jan 2021 12:34:15 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
Subject: Re: [PATCH v9 17/17] Documentation: PCI: Add userguide for PCI
 endpoint NTB function
Message-ID: <20210119181852.GA2495234@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104152909.22038-18-kishon@ti.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 04, 2021 at 08:59:09PM +0530, Kishon Vijay Abraham I wrote:
> Add documentation to help users use pci-epf-ntb function driver and
> existing host side NTB infrastructure for NTB functionality.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> ---
>  Documentation/PCI/endpoint/index.rst         |   1 +
>  Documentation/PCI/endpoint/pci-ntb-howto.rst | 160 +++++++++++++++++++
>  2 files changed, 161 insertions(+)
>  create mode 100644 Documentation/PCI/endpoint/pci-ntb-howto.rst
> 
> diff --git a/Documentation/PCI/endpoint/index.rst b/Documentation/PCI/endpoint/index.rst
> index 9cb6e5f3c4d5..38ea1f604b6d 100644
> --- a/Documentation/PCI/endpoint/index.rst
> +++ b/Documentation/PCI/endpoint/index.rst
> @@ -12,6 +12,7 @@ PCI Endpoint Framework
>     pci-test-function
>     pci-test-howto
>     pci-ntb-function
> +   pci-ntb-howto
>  
>     function/binding/pci-test
>     function/binding/pci-ntb
> diff --git a/Documentation/PCI/endpoint/pci-ntb-howto.rst b/Documentation/PCI/endpoint/pci-ntb-howto.rst
> new file mode 100644
> index 000000000000..b6e1073c9a39
> --- /dev/null
> +++ b/Documentation/PCI/endpoint/pci-ntb-howto.rst
> @@ -0,0 +1,160 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===================================================================
> +PCI Non-Transparent Bridge (NTB) Endpoint Function (EPF) User Guide
> +===================================================================
> +
> +:Author: Kishon Vijay Abraham I <kishon@ti.com>
> +
> +This document is a guide to help users use pci-epf-ntb function driver
> +and ntb_hw_epf host driver for NTB functionality. The list of steps to
> +be followed in the host side and EP side is given below. For the hardware
> +configuration and internals of NTB using configurable endpoints see
> +Documentation/PCI/endpoint/pci-ntb-function.rst
> +
> +Endpoint Device
> +===============
> +
> +Endpoint Controller Devices
> +---------------------------
> +
> +For implementing NTB functionality at least two endpoint controller devices
> +are required.
> +To find the list of endpoint controller devices in the system::

Is the above one paragraph or two?  Reflow or add blank line as
appropriate.
