Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918B421E10E
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 21:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgGMT7J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 15:59:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgGMT7J (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jul 2020 15:59:09 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC413205CB;
        Mon, 13 Jul 2020 19:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594670349;
        bh=m7q8Lm3rfVtz69niSHI9PA8vgQdUHeyhuoMTf7154aE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SrSkTad2Yn5Gw5HMzlom+8RpXACBynIzQKNyAb9KhGVYtbdUuthU44Z4HkeweqXS+
         yyfKaW+MhV6WReLon0DTMM4tY0ub5QutIBB3UY2grABBuVjO5myZZq6gFzgqNF4cVr
         z/y5nx+NglTCQijBkKWU+ZcOViBsued0zbtt68OU=
Date:   Mon, 13 Jul 2020 14:59:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 2/2] x86/PCI: Describe @reg for type1_access_ok()
Message-ID: <20200713195907.GA269828@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713194437.11325-2-andriy.shevchenko@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 13, 2020 at 10:44:37PM +0300, Andy Shevchenko wrote:
> Describe missed parameter in documentation of type1_access_ok().
> Otherwise we get the following warning:

Would you mind including the "make" invocation that runs this
checking?  I assume it's something like "make C=2
arch/x86/pci/intel_mid_pci.o"?

I'm not in the habit of running these checks, but maybe seeing how
easy it is will help me and others get in the habit.

>   CHECK   arch/x86/pci/intel_mid_pci.c
>   CC      arch/x86/pci/intel_mid_pci.o
>   arch/x86/pci/intel_mid_pci.c:152: warning: Function parameter or member 'reg' not described in 'type1_access_ok'
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/x86/pci/intel_mid_pci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
> index d8af4787e616..f855e12d7bed 100644
> --- a/arch/x86/pci/intel_mid_pci.c
> +++ b/arch/x86/pci/intel_mid_pci.c
> @@ -141,6 +141,7 @@ static int pci_device_update_fixed(struct pci_bus *bus, unsigned int devfn,
>   * type1_access_ok - check whether to use type 1
>   * @bus: bus number
>   * @devfn: device & function in question
> + * @reg: configuration register offset
>   *
>   * If the bus is on a Lincroft chip and it exists, or is not on a Lincroft at
>   * all, the we can go ahead with any reads & writes.  If it's on a Lincroft,
> -- 
> 2.27.0
> 
