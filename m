Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3045020FFEB
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jul 2020 00:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgF3WMv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Jun 2020 18:12:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgF3WMv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jun 2020 18:12:51 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D16072081A;
        Tue, 30 Jun 2020 22:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593555171;
        bh=h1obBUyTPJ75QgeorGRJK1b9zJ+cbov4c/nHPyLr+yw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=M/84Qq3eKACfAHQjDCkpV3cm4rQfN9fudLtrODHV/aJYn7tGBP4MbNKzLWTc4wcbQ
         8wxU6ED77IYa/Qy/hiMpWO6dMSUxGVVEE//2L7iGf/0Lt9kZ4iUwcFbIHZrWAum8Iq
         d1+6PKGsAIhjnkj3qCRYtXN45CyM9IaaV6LCntes=
Date:   Tue, 30 Jun 2020 17:12:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH] xen/pci: remove redundant assignment to variable irq
Message-ID: <20200630221249.GA3491219@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409114118.249461-1-colin.king@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Juergen, Boris]

On Thu, Apr 09, 2020 at 12:41:18PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable irq is being initialized with a value that is never read
> and it is being updated later with a new value.  The initialization is
> redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to pci/virtualization for v5.9, thanks!

I don't see this in linux-next yet, but if anybody else would prefer
to take it, let me know and I'll drop it.  

> ---
>  arch/x86/pci/xen.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
> index 91220cc25854..80272eb49230 100644
> --- a/arch/x86/pci/xen.c
> +++ b/arch/x86/pci/xen.c
> @@ -63,7 +63,7 @@ static int xen_pcifront_enable_irq(struct pci_dev *dev)
>  static int xen_register_pirq(u32 gsi, int gsi_override, int triggering,
>  			     bool set_pirq)
>  {
> -	int rc, pirq = -1, irq = -1;
> +	int rc, pirq = -1, irq;
>  	struct physdev_map_pirq map_irq;
>  	int shareable = 0;
>  	char *name;
> -- 
> 2.25.1
> 
