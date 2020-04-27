Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11121BAA37
	for <lists+linux-pci@lfdr.de>; Mon, 27 Apr 2020 18:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgD0Qoz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Apr 2020 12:44:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:58972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbgD0Qoz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Apr 2020 12:44:55 -0400
Received: from localhost (mobile-166-175-187-210.mycingular.net [166.175.187.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9294E206B8;
        Mon, 27 Apr 2020 16:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588005894;
        bh=dz+Rgg3SXeJ6QPz2VoSQwAfEmUmoDKm81P9rettR8lg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=itnRw9HtrkFaI0EqTrdQs/LUGozM81dORo7CxoxvAhdZ04+qqh7ncP38cc7IRRNYK
         59+ogWyGg/P9xsVqCOHeL5NIsrE1GOEbDQ5djZpMwZOQOKzjLeomgcd8bTZh2SXrUd
         6aXp+uv5ZN1zAKXY3i4Ee7LjDt1NabD1O4FLTN8s=
Date:   Mon, 27 Apr 2020 11:44:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: pcie-rcar: Mark rcar_pcie_resume() with
 __maybe_unused
Message-ID: <20200427164452.GA207715@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200426123115.55995-1-marek.vasut@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Apr 26, 2020 at 02:31:15PM +0200, marek.vasut@gmail.com wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> If CONFIG_PM_SLEEP is not set, SET_SYSTEM_SLEEP_PM_OPS() is expanded to
> empty macro and there is no reference to rcar_pcie_resume(), hence the
> following warning is generated:
> 
> drivers/pci/controller/pcie-rcar.c:1253:12: warning: ‘rcar_pcie_resume’ defined but not used [-Wunused-function]
>  1253 | static int rcar_pcie_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~
> 
> Fix this by marking this function as __maybe_unused , just like in
> commit 226e6b866d74 ("gpio: pch: Convert to dev_pm_ops")
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Reported-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> NOTE: Based on git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git
>       branch pci/rcar
> NOTE: The driver tag is now 'pcie-rcar' to distinguish it from pci-rcar-gen2.c

I hope Lorenzo will squash this into the original commit.  I don't
think it adds anything useful to keep it as a separate commit.

> ---
>  drivers/pci/controller/pcie-rcar.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
> index b58dfe415cb3..1a0e74cad9bb 100644
> --- a/drivers/pci/controller/pcie-rcar.c
> +++ b/drivers/pci/controller/pcie-rcar.c
> @@ -1250,7 +1250,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>  	return err;
>  }
>  
> -static int rcar_pcie_resume(struct device *dev)
> +static int __maybe_unused rcar_pcie_resume(struct device *dev)
>  {
>  	struct rcar_pcie *pcie = dev_get_drvdata(dev);
>  	int (*hw_init_fn)(struct rcar_pcie *);
> -- 
> 2.25.1
> 
