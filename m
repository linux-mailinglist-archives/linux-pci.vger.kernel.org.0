Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF891A7985
	for <lists+linux-pci@lfdr.de>; Tue, 14 Apr 2020 13:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439211AbgDNLbR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Apr 2020 07:31:17 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:21527 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439200AbgDNLbM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Apr 2020 07:31:12 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 491jwp4f2HzZ5;
        Tue, 14 Apr 2020 13:31:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1586863867; bh=XMK7e0Dm8F9YE8gKtQY1u7hsmjy1KuLoqRJsGZsIDcE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CPsOHPWcNDRbKJmA8ReFm7MwVhynuUCOFOdWX6Kj3c3xx9s4hmVn0j6s2Z4nzzt1c
         Z/XzQ1W/X1ISsCV0CfSuVFBiTlLHb0I0iejhgKeM6WJs/JfZ35kq3KjyN5LuJEjEV5
         WcWH0WoFwMfJ7qyqXaw3zhARV8ktvem1kFKh/y/aA4APigaAxCXAABAbL0rEQk6rt2
         n54j71vXR4APXPcqYXC2+hZ0OTlr1LYcy/2dFdqBj8KFoAi158AeS2Ug+8TmLbxJ4G
         +zsecp8nh0QLpwSIilYPdOCCvD0MbqBUeiP3kFlQ0AdNu22tN631+88QZjSRB3X0La
         AR5yu3RKD69EQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Tue, 14 Apr 2020 13:31:04 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Pali =?iso-8859-2?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Fix reporting GPIO error value
Message-ID: <20200414113104.GA27984@qmqm.qmqm.pl>
References: <20200414102512.27506-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200414102512.27506-1-pali@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 14, 2020 at 12:25:12PM +0200, Pali Rohár wrote:
> Error code is stored in rp->reset_gpio and not in err variable.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  drivers/pci/controller/pci-tegra.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index 0e03cef72840..378d5a8773c7 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -2314,8 +2314,8 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
>  			if (PTR_ERR(rp->reset_gpio) == -ENOENT) {
>  				rp->reset_gpio = NULL;
>  			} else {
> -				dev_err(dev, "failed to get reset GPIO: %d\n",
> -					err);
> +				dev_err(dev, "failed to get reset GPIO: %ld\n",
> +					PTR_ERR(rp->reset_gpio));
>  				return PTR_ERR(rp->reset_gpio);
>  			}
>  		}

You can use %pe directly on the pointer for added benefit of translation
of the error to a name.

Best Regards,
Micha³ Miros³aw
