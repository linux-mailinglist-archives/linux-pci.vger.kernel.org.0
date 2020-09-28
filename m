Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18D227B86C
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 01:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgI1Xpb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 19:45:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbgI1Xpb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Sep 2020 19:45:31 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C21723A01;
        Mon, 28 Sep 2020 22:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601332084;
        bh=S4ZZpLxDLTrA5UZupqdxXb9DG8i/pEmX4qZWLYkRWqw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SB4BB2mHCAapqsvbg/J7bspl5EcJQiNPoxQKinVP3NsRZ7/Oc7KILiQJJitQNwBgL
         JzlA/nGYacTQPMpYrH1ZwYxO+wy52aBWRV5oMtLMl1/wbdOO4Mef4wGk1mCiRsGNk6
         MvMbsJBqJ901IXw67oz5XIRp/Gx4Xd2apK0YHcsc=
Date:   Mon, 28 Sep 2020 17:28:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: shpchp: Remove unused assignment to variable rc
Message-ID: <20200928222803.GA2502380@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200923025225.471459-1-kw@linux.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 23, 2020 at 02:52:25AM +0000, Krzysztof Wilczyński wrote:
> The value of the constant POWER_FAILURE assigned to the variable rc
> after the power fault check is never used for anything within the body
> of the board_added() function and it is also overridden later following
> jump to the err_exit label with the return value from the slot_disable()
> callback.
> 
> Since the value of rc is never used in any meaningful way the assignment
> can be removed.
> 
> I believe the assignment of constant POWER_FAILURE to the rc variable
> was initially taken from the file drivers/pci/hotplug/cpqphp_ctrl.c and
> then used in the file pci/hotplug/shpchp_ctrl.c (the code base is very
> similar) around the time of the Kernel version 2.6.4-rc1 when the
> support for the Standard Hot Plug was first added, sadly the Git history
> only goes as far as to commit 1da177e4c3f4 ("Linux-2.6.12-rc2").
> 
> Related:
>   https://elixir.bootlin.com/linux/v2.6.4-rc1/source/drivers/pci/hotplug/shpchp_ctrl.c
>   https://elixir.bootlin.com/linux/v2.6.4-rc1/source/drivers/pci/hotplug/cpqphp_ctrl.c
> 
> Addresses-Coverity-ID: 1226899 ("Unused value")
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>

Applied to pci/hotplug for v5.10, thanks!

> ---
>  drivers/pci/hotplug/shpchp_ctrl.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/shpchp_ctrl.c b/drivers/pci/hotplug/shpchp_ctrl.c
> index 65502e3f7b4f..6a6705e0cf17 100644
> --- a/drivers/pci/hotplug/shpchp_ctrl.c
> +++ b/drivers/pci/hotplug/shpchp_ctrl.c
> @@ -299,7 +299,6 @@ static int board_added(struct slot *p_slot)
>  	if (p_slot->status == 0xFF) {
>  		/* power fault occurred, but it was benign */
>  		ctrl_dbg(ctrl, "%s: Power fault\n", __func__);
> -		rc = POWER_FAILURE;
>  		p_slot->status = 0;
>  		goto err_exit;
>  	}
> -- 
> 2.28.0
> 
