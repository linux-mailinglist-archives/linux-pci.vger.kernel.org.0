Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3884436A3
	for <lists+linux-pci@lfdr.de>; Tue,  2 Nov 2021 20:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhKBTs1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Nov 2021 15:48:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:33334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229813AbhKBTs1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Nov 2021 15:48:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7482F60F45;
        Tue,  2 Nov 2021 19:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635882351;
        bh=BaKa+LRMR1Qg9okZxOXYMQ7K/FG4UI/5H64nxaY8350=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Mj0fZK3yAu91rG8g9nUh0Z4sg4CuWhvNj32HbeAaZIoHeVz6Wj/CzKyC6Zgse/hCi
         DdX7TSfYG0pU/0XhD6r+QtTFYsmHRWTHD63Wa9w3lCXKCrNdvzhTHjtJ4GB6B4cJvJ
         3uHkIFnDhcsHPu8sRMjV5IpT0l8klr1f/1T3tfIAWfDoS//idbzsBTxc+NiZ89cszX
         Cs9b4+9JxyW9mVojf7QZ4JbBWCnF8twhzZCGrwxTPKQsYkLo9X5t/OBA6ZRhsI+Bky
         wzrRFiugy34UT9Pj4uLRNa7jn6voKJMpjxYEnOvCqkoENUZgjMJJJ4pVL+Tb1jCzcu
         +QIEjfT4mJheg==
Date:   Tue, 2 Nov 2021 14:45:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: vmd: Use preferred header files linux/device.h
 and linux/msi.h
Message-ID: <20211102194550.GA637938@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211013003145.1107148-1-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 13, 2021 at 12:31:44AM +0000, Krzysztof Wilczyński wrote:
> Use the preferred generic header files linux/device.h and linux/msi.h
> that already include the corresponding asm/device.h and asm/msi.h files,
> especially where the headers files linux/msi.h and asm/msi.h where both
> included.
> 
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>

Applied both to pci/misc for v5.16, thanks!

> ---
>  drivers/pci/controller/vmd.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index a5987e52700e..9609eb911349 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -9,6 +9,7 @@
>  #include <linux/irq.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/device.h>
>  #include <linux/msi.h>
>  #include <linux/pci.h>
>  #include <linux/pci-acpi.h>
> @@ -18,8 +19,6 @@
>  #include <linux/rcupdate.h>
>  
>  #include <asm/irqdomain.h>
> -#include <asm/device.h>
> -#include <asm/msi.h>
>  
>  #define VMD_CFGBAR	0
>  #define VMD_MEMBAR1	2
> -- 
> 2.33.0
> 
