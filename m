Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22401CE028
	for <lists+linux-pci@lfdr.de>; Mon, 11 May 2020 18:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbgEKQNJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 May 2020 12:13:09 -0400
Received: from foss.arm.com ([217.140.110.172]:35434 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728556AbgEKQNJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 May 2020 12:13:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A588930E;
        Mon, 11 May 2020 09:13:08 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02B323F305;
        Mon, 11 May 2020 09:13:07 -0700 (PDT)
Date:   Mon, 11 May 2020 17:13:02 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bryce Willey <bryce.steven.willey@gmail.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] Documentation: PCI: gave unique labels to sections
Message-ID: <20200511161302.GA28925@e121166-lin.cambridge.arm.com>
References: <20200503214926.23748-1-bryce.steven.willey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200503214926.23748-1-bryce.steven.willey@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, May 03, 2020 at 05:49:26PM -0400, Bryce Willey wrote:
> From: Bryce Willey <Bryce.Steven.Willey@gmail.com>
> 
> Made subsection label more specific to avoid sphinx warnings
> 
> Exact warning:
>  Documentation/PCI/endpoint/pci-endpoint.rst:208: WARNING: duplicate label
> pci/endpoint/pci-endpoint:other apis, other instance in Documentation/PCI/endpoint/pci-endpoint.rst
> 
> Signed-off-by: Bryce Willey <Bryce.Steven.Willey@gmail.com>
> ---
>  Documentation/PCI/endpoint/pci-endpoint.rst | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Applied changes requested and merged in pci/misc, thanks.

Lorenzo

> diff --git a/Documentation/PCI/endpoint/pci-endpoint.rst b/Documentation/PCI/endpoint/pci-endpoint.rst
> index 0e2311b5617b..7536be445db8 100644
> --- a/Documentation/PCI/endpoint/pci-endpoint.rst
> +++ b/Documentation/PCI/endpoint/pci-endpoint.rst
> @@ -78,8 +78,8 @@ by the PCI controller driver.
>     Cleanup the pci_epc_mem structure allocated during pci_epc_mem_init().
>  
>  
> -APIs for the PCI Endpoint Function Driver
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +EPC APIs for the PCI Endpoint Function Driver
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
>  This section lists the APIs that the PCI Endpoint core provides to be used
>  by the PCI endpoint function driver.
> @@ -117,8 +117,8 @@ by the PCI endpoint function driver.
>     The PCI endpoint function driver should use pci_epc_mem_free_addr() to
>     free the memory space allocated using pci_epc_mem_alloc_addr().
>  
> -Other APIs
> -~~~~~~~~~~
> +Other EPC APIs
> +~~~~~~~~~~~~~~
>  
>  There are other APIs provided by the EPC library. These are used for binding
>  the EPF device with EPC device. pci-ep-cfs.c can be used as reference for
> @@ -160,8 +160,8 @@ PCI Endpoint Function(EPF) Library
>  The EPF library provides APIs to be used by the function driver and the EPC
>  library to provide endpoint mode functionality.
>  
> -APIs for the PCI Endpoint Function Driver
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +EPF APIs for the PCI Endpoint Function Driver
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
>  This section lists the APIs that the PCI Endpoint core provides to be used
>  by the PCI endpoint function driver.
> @@ -204,8 +204,8 @@ by the PCI endpoint controller library.
>     The PCI endpoint controller library invokes pci_epf_linkup() when the
>     EPC device has established the connection to the host.
>  
> -Other APIs
> -~~~~~~~~~~
> +Other EPF APIs
> +~~~~~~~~~~~~~~
>  
>  There are other APIs provided by the EPF library. These are used to notify
>  the function driver when the EPF device is bound to the EPC device.
> -- 
> 2.17.1
> 
