Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331051CD5A2
	for <lists+linux-pci@lfdr.de>; Mon, 11 May 2020 11:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbgEKJrf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 May 2020 05:47:35 -0400
Received: from foss.arm.com ([217.140.110.172]:55006 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728209AbgEKJre (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 May 2020 05:47:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31DFC1FB;
        Mon, 11 May 2020 02:47:34 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1734D3F305;
        Mon, 11 May 2020 02:47:32 -0700 (PDT)
Date:   Mon, 11 May 2020 10:47:27 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Fix reporting GPIO error value
Message-ID: <20200511094727.GA24149@e121166-lin.cambridge.arm.com>
References: <20200414102512.27506-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200414102512.27506-1-pali@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
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

Applied to pci/tegra, thanks.

Lorenzo

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
> -- 
> 2.20.1
> 
