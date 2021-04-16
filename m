Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617D936259B
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 18:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236252AbhDPQYR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Apr 2021 12:24:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235820AbhDPQYL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Apr 2021 12:24:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2042D61002;
        Fri, 16 Apr 2021 16:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618590226;
        bh=/a1sDlZNCDt5H3fPLy5LZGMuwyqS+pjC9L/aHXdKetg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qpPtXvXJvZoWTh9JsEGBV7yfVq6HuU/P+r+9+1OYTzBFavLG7+9dckQWFi4m3c42e
         e1z9FXj4qE3/bia1biZrNff/7PaIY9mmw2V8KD37IKI2F6Fw2AQiH0txmTxa6ahQsq
         GZJRlEpOvJLJOzzX2xpDsHkEbMqtIBdUe3jH1CY0zR4qQ4H0cuks/3MEb9Su2clpIk
         IRKmhL0CPrkZlFfT836gZrNjjAq7BYzt/l87/j+rGfAnAb07dlhaObA/PShPPqJ7BE
         pKOE4GN43RzoPq/R9f64FjooWFPEazQxZIq6Riis1k88MW518WfltJUtZjOBFtj6iV
         UnA9BQ7cb/8fA==
Date:   Fri, 16 Apr 2021 11:23:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: shpchp: remove unused function
Message-ID: <20210416162344.GA2724691@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618475422-96531-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 15, 2021 at 04:30:22PM +0800, Jiapeng Chong wrote:
> Fix the following clang warning:
> 
> drivers/pci/hotplug/shpchp_hpc.c:177:20: warning: unused function
> 'shpc_writeb' [-Wunused-function].
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Applied to pci/hotplug for v5.13 with the following subject, thanks!

  PCI: shpchp: Remove unused shpc_writeb()

> ---
>  drivers/pci/hotplug/shpchp_hpc.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/shpchp_hpc.c b/drivers/pci/hotplug/shpchp_hpc.c
> index db04728..9e3b277 100644
> --- a/drivers/pci/hotplug/shpchp_hpc.c
> +++ b/drivers/pci/hotplug/shpchp_hpc.c
> @@ -174,11 +174,6 @@ static inline u8 shpc_readb(struct controller *ctrl, int reg)
>  	return readb(ctrl->creg + reg);
>  }
>  
> -static inline void shpc_writeb(struct controller *ctrl, int reg, u8 val)
> -{
> -	writeb(val, ctrl->creg + reg);
> -}
> -
>  static inline u16 shpc_readw(struct controller *ctrl, int reg)
>  {
>  	return readw(ctrl->creg + reg);
> -- 
> 1.8.3.1
> 
