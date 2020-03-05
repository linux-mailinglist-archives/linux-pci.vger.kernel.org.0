Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3A317A442
	for <lists+linux-pci@lfdr.de>; Thu,  5 Mar 2020 12:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgCEL3m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Mar 2020 06:29:42 -0500
Received: from foss.arm.com ([217.140.110.172]:47440 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgCEL3m (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Mar 2020 06:29:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 933A431B;
        Thu,  5 Mar 2020 03:29:41 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1C5B3F6C4;
        Thu,  5 Mar 2020 03:29:40 -0800 (PST)
Date:   Thu, 5 Mar 2020 11:29:31 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Replace zero-length array with flexible-array member
Message-ID: <20200305112923.GA5576@e121166-lin.cambridge.arm.com>
References: <20200213005221.GA10532@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213005221.GA10532@embeddedor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 12, 2020 at 06:52:21PM -0600, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to pci/hv for v5.7, thanks.

Lorenzo

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d828ca835a98..3217b8cdb1e0 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1521,7 +1521,7 @@ EXPORT_SYMBOL(pci_restore_state);
>  
>  struct pci_saved_state {
>  	u32 config_space[16];
> -	struct pci_cap_saved_data cap[0];
> +	struct pci_cap_saved_data cap[];
>  };
>  
>  /**
> -- 
> 2.23.0
> 
