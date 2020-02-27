Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 286AE172BD2
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2020 00:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbgB0XDH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Feb 2020 18:03:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:55256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729704AbgB0XDH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Feb 2020 18:03:07 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 153F724699;
        Thu, 27 Feb 2020 23:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582844586;
        bh=P4oQur2XtbC7njpdq9saO0WFyxGYlvu37AkdrE90ojM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Ab/ivqhTkf+ewF6Z6ueVsZWH8gpWMsjsA8g80EYH6a2VrhhUKmBtCXh5KDs4RoEc2
         XLEPIiVK6idFLATH0jGnUkwTvFXgSIkiWGt9Gyo+vvRKuYsXYdLgcctmu+TQA3nYh+
         2K330rNBqyiKGpoyLfWNZYrie9O4Dglxtr21SBhs=
Date:   Thu, 27 Feb 2020 17:03:04 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 12/24] docs: pci:
 endpoint/function/binding/pci-test.txt convert to ReST
Message-ID: <20200227230304.GA159790@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84d6075c17ce9a1c5c214f2f11ea55d951fdc3bd.1581956285.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 17, 2020 at 05:20:30PM +0100, Mauro Carvalho Chehab wrote:
> Convert this file to ReST by adding a proper title to it and
> use the right markups for a table.
> 
> While here, add a SPDX header.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

FWIW,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I assume you'll merge this, Jonathan.  Let me know if I should do
anything else with this.

> ---
>  .../endpoint/function/binding/pci-test.rst    | 26 +++++++++++++++++++
>  .../endpoint/function/binding/pci-test.txt    | 19 --------------
>  Documentation/PCI/endpoint/index.rst          |  2 ++
>  3 files changed, 28 insertions(+), 19 deletions(-)
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
> -- 
> 2.24.1
> 
