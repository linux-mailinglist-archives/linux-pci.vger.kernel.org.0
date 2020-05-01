Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB7D1C1B44
	for <lists+linux-pci@lfdr.de>; Fri,  1 May 2020 19:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbgEARKN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 May 2020 13:10:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728495AbgEARKN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 May 2020 13:10:13 -0400
Received: from localhost (mobile-166-175-184-168.mycingular.net [166.175.184.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1C6C2137B;
        Fri,  1 May 2020 17:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588353013;
        bh=AZtGupY3KVT174f6mc/9Z29DqA2plgz5WC6ENyZ6TPE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PBt0yxaZV/zHBhSkjLZbx2e68r1SeWS0rIaOCYIyY1T/juir9wkfAEotoNf0Pv7UG
         YFlTN1FA2MgY60VvWQWC71/qkgHXC1qnlNlFjaZyxujhRhRp++Suc5WqQQlYztBHIl
         HT1CeSIrQedVZhkaX1SyQLwHwRRv+9ec8VC8Vo1c=
Date:   Fri, 1 May 2020 12:10:11 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 12/19] docs: pci:
 endpoint/function/binding/pci-test.txt convert to ReST
Message-ID: <20200501171011.GA116051@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa73d1a7fb6c4691899a110a732216bcdac75f2b.1588263270.git.mchehab+huawei@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 30, 2020 at 06:18:26PM +0200, Mauro Carvalho Chehab wrote:
> Convert this file to ReST by adding a proper title to it and
> use the right markups for a table.
> 
> While here, add a SPDX header.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  .../endpoint/function/binding/pci-test.rst    | 26 +++++++++++++++++++
>  .../endpoint/function/binding/pci-test.txt    | 19 --------------
>  Documentation/PCI/endpoint/index.rst          |  2 ++
>  .../misc-devices/pci-endpoint-test.rst        |  2 +-
>  4 files changed, 29 insertions(+), 20 deletions(-)
>  create mode 100644 Documentation/PCI/endpoint/function/binding/pci-test.rst
>  delete mode 100644 Documentation/PCI/endpoint/function/binding/pci-test.txt
> 
> diff --git a/Documentation/PCI/endpoint/function/binding/pci-test.rst b/Documentation/PCI/endpoint/function/binding/pci-test.rst
> new file mode 100644
> index 000000000000..57ee866fb165
> --- /dev/null
> +++ b/Documentation/PCI/endpoint/function/binding/pci-test.rst
> @@ -0,0 +1,26 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==========================
> +PCI Test Endpoint Function
> +==========================
> +
> +name: Should be "pci_epf_test" to bind to the pci_epf_test driver.
> +
> +Configurable Fields:
> +
> +================   ===========================================================
> +vendorid	   should be 0x104c
> +deviceid	   should be 0xb500 for DRA74x and 0xb501 for DRA72x
> +revid		   don't care
> +progif_code	   don't care
> +subclass_code	   don't care
> +baseclass_code	   should be 0xff
> +cache_line_size	   don't care
> +subsys_vendor_id   don't care
> +subsys_id	   don't care
> +interrupt_pin	   Should be 1 - INTA, 2 - INTB, 3 - INTC, 4 -INTD
> +msi_interrupts	   Should be 1 to 32 depending on the number of MSI interrupts
> +		   to test
> +msix_interrupts	   Should be 1 to 2048 depending on the number of MSI-X
> +		   interrupts to test
> +================   ===========================================================
> diff --git a/Documentation/PCI/endpoint/function/binding/pci-test.txt b/Documentation/PCI/endpoint/function/binding/pci-test.txt
> deleted file mode 100644
> index cd76ba47394b..000000000000
> --- a/Documentation/PCI/endpoint/function/binding/pci-test.txt
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -PCI TEST ENDPOINT FUNCTION
> -
> -name: Should be "pci_epf_test" to bind to the pci_epf_test driver.
> -
> -Configurable Fields:
> -vendorid	 : should be 0x104c
> -deviceid	 : should be 0xb500 for DRA74x and 0xb501 for DRA72x
> -revid		 : don't care
> -progif_code	 : don't care
> -subclass_code	 : don't care
> -baseclass_code	 : should be 0xff
> -cache_line_size	 : don't care
> -subsys_vendor_id : don't care
> -subsys_id	 : don't care
> -interrupt_pin	 : Should be 1 - INTA, 2 - INTB, 3 - INTC, 4 -INTD
> -msi_interrupts	 : Should be 1 to 32 depending on the number of MSI interrupts
> -		   to test
> -msix_interrupts	 : Should be 1 to 2048 depending on the number of MSI-X
> -		   interrupts to test
> diff --git a/Documentation/PCI/endpoint/index.rst b/Documentation/PCI/endpoint/index.rst
> index d114ea74b444..4ca7439fbfc9 100644
> --- a/Documentation/PCI/endpoint/index.rst
> +++ b/Documentation/PCI/endpoint/index.rst
> @@ -11,3 +11,5 @@ PCI Endpoint Framework
>     pci-endpoint-cfs
>     pci-test-function
>     pci-test-howto
> +
> +   function/binding/pci-test
> diff --git a/Documentation/misc-devices/pci-endpoint-test.rst b/Documentation/misc-devices/pci-endpoint-test.rst
> index 26e5d9ba146b..4cf3f4433be7 100644
> --- a/Documentation/misc-devices/pci-endpoint-test.rst
> +++ b/Documentation/misc-devices/pci-endpoint-test.rst
> @@ -53,4 +53,4 @@ ioctl
>  	      Perform read tests. The size of the buffer should be passed
>  	      as argument.
>  
> -.. [1] Documentation/PCI/endpoint/function/binding/pci-test.txt
> +.. [1] Documentation/PCI/endpoint/function/binding/pci-test.rst
> -- 
> 2.25.4
> 
