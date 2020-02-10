Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7F4F1585A8
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2020 23:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgBJWjZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Feb 2020 17:39:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:42972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727422AbgBJWjZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Feb 2020 17:39:25 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 883AF2072C;
        Mon, 10 Feb 2020 22:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581374364;
        bh=JUkyaQjA/BJjwBpBpWFAZlCXBfcqPB4tTAAioPPYrmU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=n3zrepfgdmzp5p1lgmrmlstOCndXQgy7eXKhyp58H4eZbM1cEDfQeiSuGp0xeznbZ
         rz0XtPZOjvN7z62T3nbAr8ONWiV9W2UTJ0CXxOJjE4QhcpD127xooJ934sVZQCcBu6
         eYdB2QoWPzJFv0Bhv87ZDz+CNLqbDq7cZRCi7t6A=
Date:   Mon, 10 Feb 2020 16:39:22 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Krzysztof Wilczynski <kw@linux.com>
Subject: Re: [PATCH] PCI/ACPI: make array pcie_to_hpx3_type static const,
 makes object smaller
Message-ID: <20200210223922.GA76091@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210085256.319424-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Krzysztof]

On Mon, Feb 10, 2020 at 08:52:56AM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the array pcie_to_hpx3_type on the stack but instead
> make it static const. Makes the object code smaller by 6 bytes:
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   19247	   3048	     64	  22359	   5757	drivers/pci/pci-acpi.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>   19177	   3112	     64	  22353	   5751	drivers/pci/pci-acpi.o
> 
> (gcc version 9.2.1, amd64)
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Nice cleanup, thanks!  Applied to pci/misc for v5.7.

> ---
>  drivers/pci/pci-acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 0c02d500158f..d914f8bc31ea 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -439,7 +439,7 @@ enum hpx_type3_dev_type {
>  static u16 hpx3_device_type(struct pci_dev *dev)
>  {
>  	u16 pcie_type = pci_pcie_type(dev);
> -	const int pcie_to_hpx3_type[] = {
> +	static const int pcie_to_hpx3_type[] = {
>  		[PCI_EXP_TYPE_ENDPOINT]    = HPX_TYPE_ENDPOINT,
>  		[PCI_EXP_TYPE_LEG_END]     = HPX_TYPE_LEG_END,
>  		[PCI_EXP_TYPE_RC_END]      = HPX_TYPE_RC_END,
> -- 
> 2.25.0
> 
