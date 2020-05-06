Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82611C7CBB
	for <lists+linux-pci@lfdr.de>; Wed,  6 May 2020 23:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbgEFVl5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 May 2020 17:41:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730307AbgEFVl4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 May 2020 17:41:56 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 872D02078C;
        Wed,  6 May 2020 21:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588801315;
        bh=hIXvI2c1b1nXaKYGCPmnNib4tAE0InuTDY3Z91LsdGo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=d0/Xa402U/z6EWAhW42wFq4bziSEcX3F9e+jL2DylN/Xh10llEClo0hr8wWUB5Mvs
         Sqq58juRQBt2RR+JFshuMqpdvhDnwDDvsrIzpwF395LbLdoDhD15GIQm24JAcv4U3R
         WIQd8Ua8fuFJQ1duRIS4cxSgca3ropmfKd40x4bg=
Date:   Wed, 6 May 2020 16:41:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bryce Willey <bryce.steven.willey@gmail.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] Documentation: PCI: gave unique labels to sections
Message-ID: <20200506214154.GA456677@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200503214926.23748-1-bryce.steven.willey@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

s/gave/Give/ (in subject)

On Sun, May 03, 2020 at 05:49:26PM -0400, Bryce Willey wrote:
> From: Bryce Willey <Bryce.Steven.Willey@gmail.com>
> 
> Made subsection label more specific to avoid sphinx warnings

s/Made/Make/
s/label/labels/
s/warnings/warnings./

> Exact warning:
>  Documentation/PCI/endpoint/pci-endpoint.rst:208: WARNING: duplicate label
> pci/endpoint/pci-endpoint:other apis, other instance in Documentation/PCI/endpoint/pci-endpoint.rst
> 
> Signed-off-by: Bryce Willey <Bryce.Steven.Willey@gmail.com>

I assume Lorenzo will pick this up, since he's merged most of the
recent Documentation/PCI/endpoint changes, and he'll likely fix the
nits above.  FWIW,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  Documentation/PCI/endpoint/pci-endpoint.rst | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
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
