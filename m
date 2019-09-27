Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9388C054E
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2019 14:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfI0MjP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Sep 2019 08:39:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbfI0MjP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Sep 2019 08:39:15 -0400
Received: from localhost (173-25-179-30.client.mchsi.com [173.25.179.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B22220673;
        Fri, 27 Sep 2019 12:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569587954;
        bh=uPN9RyW4YW0TDfK8hXhtBneW2YpzqT6rO2P64YR4jtY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NRxnvfmzKHdgaIuyshJwcS0iwIlp5AAK4eN8sypPK8Ovxr4/eroGgPG1+r5sQRX7A
         3KFWMi6wdJsgsMRQZWfdUebtvWDnQbLYtSudyqLNLDHco79brtd4IujFXnsszDhK1L
         GxWTS19cUuSFAcz9fNLMQ7IHk+eLiCOA06ig3lP0=
Date:   Fri, 27 Sep 2019 07:39:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 1/2] PCI/AER: Use for_each_set_bit()
Message-ID: <20190927123913.GA32321@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827151823.75312-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 27, 2019 at 06:18:22PM +0300, Andy Shevchenko wrote:
> This simplifies and standardizes slot manipulation code
> by using for_each_set_bit() library function.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pci/pcie/aer.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index b45bc47d04fe..f883f81d759a 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -15,6 +15,7 @@
>  #define pr_fmt(fmt) "AER: " fmt
>  #define dev_fmt pr_fmt
>  
> +#include <linux/bitops.h>
>  #include <linux/cper.h>
>  #include <linux/pci.h>
>  #include <linux/pci-acpi.h>
> @@ -657,7 +658,8 @@ const struct attribute_group aer_stats_attr_group = {
>  static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
>  				   struct aer_err_info *info)
>  {
> -	int status, i, max = -1;
> +	unsigned long status = info->status & ~info->mask;
> +	int i, max = -1;
>  	u64 *counter = NULL;
>  	struct aer_stats *aer_stats = pdev->aer_stats;
>  
> @@ -682,10 +684,8 @@ static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
>  		break;
>  	}
>  
> -	status = (info->status & ~info->mask);
> -	for (i = 0; i < max; i++)
> -		if (status & (1 << i))
> -			counter[i]++;
> +	for_each_set_bit(i, &status, max)

I applied this, but I confess to being a little ambivalent.  It's
arguably a little easier to read, but it's not nearly as efficient
(not a great concern here) and more importantly much harder to verify
that it's correct because you have to chase through
for_each_set_bit(), find_first_bit(), _ffs(), etc, etc.  No doubt it's
great for bitmaps of arbitrary size, but for a simple 32-bit register
I'm a little hesitant.  But I applied it anyway.

> +		counter[i]++;
>  }
>  
>  static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
> @@ -717,14 +717,11 @@ static void __print_tlp_header(struct pci_dev *dev,
>  static void __aer_print_error(struct pci_dev *dev,
>  			      struct aer_err_info *info)
>  {
> -	int i, status;
> +	unsigned long status = info->status & ~info->mask;
>  	const char *errmsg = NULL;
> -	status = (info->status & ~info->mask);
> -
> -	for (i = 0; i < 32; i++) {
> -		if (!(status & (1 << i)))
> -			continue;
> +	int i;
>  
> +	for_each_set_bit(i, &status, 32) {
>  		if (info->severity == AER_CORRECTABLE)
>  			errmsg = i < ARRAY_SIZE(aer_correctable_error_string) ?
>  				aer_correctable_error_string[i] : NULL;
> -- 
> 2.23.0.rc1
> 
