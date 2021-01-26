Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1EA7304DFF
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jan 2021 01:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731560AbhAZXcx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 18:32:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:32904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404669AbhAZTv4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jan 2021 14:51:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3173F22B3B;
        Tue, 26 Jan 2021 19:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611690673;
        bh=vtCVPMTIKr8d/cujk/wlDZgk61TwrRcnev62B7CYDSU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ntmkasyMuY9szgYvqzjFdNX35Zl2VUsqtWEGScduGwhaKgSRF/oZrdE6uxRFgG1kE
         1Tod8EMi4jXOMSu9RO9Ey42EO2X8GgVPuvmHKMXPfs1EKRam6OJsYWnA0x/KcNJYed
         3skXaO9YVnrp225k7laYKxObMz/rc9QnMqNRnV3FYeZm0BXzJvnvkqvb1ogi+FjsFy
         8rSbTN8GXoul9Zv5gIr9iI21ejCbxUvT9bgGRRDdRMxj8/XfOTMs4zvc6aclu5Oela
         MLblTBG78VEl287pPlnNsSPXEUQGU82Ca2+agcPIztyEzvhse7XuXDVbVLNCgO+Kh9
         0WLVJ0WyRRJ6Q==
Date:   Tue, 26 Jan 2021 13:51:11 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Santosh Shilimkar <ssantosh@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] MAINTAINERS: Fix 'ARM/TEXAS INSTRUMENT KEYSTONE
 CLOCKSOURCE' capitalization
Message-ID: <20210126195111.GA2909572@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126193457.2907650-1-helgaas@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 26, 2021 at 01:34:57PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Fix capitalization typo in 'ARM/TEXAS INSTRUMENT KEYSTONE CLOCKSOURCE'.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

I'll just merge this via the PCI tree unless anybody objects.

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cc1e6a5ee6e6..52311efad03e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2603,7 +2603,7 @@ L:	linux-kernel@vger.kernel.org
>  S:	Maintained
>  F:	drivers/clk/keystone/
>  
> -ARM/TEXAS INSTRUMENT KEYSTONE ClOCKSOURCE
> +ARM/TEXAS INSTRUMENT KEYSTONE CLOCKSOURCE
>  M:	Santosh Shilimkar <ssantosh@kernel.org>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  L:	linux-kernel@vger.kernel.org
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
