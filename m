Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C2725FBF9
	for <lists+linux-pci@lfdr.de>; Mon,  7 Sep 2020 16:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbgIGOWG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Sep 2020 10:22:06 -0400
Received: from foss.arm.com ([217.140.110.172]:36936 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729764AbgIGOVX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Sep 2020 10:21:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6125C31B;
        Mon,  7 Sep 2020 07:18:30 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11A973F73C;
        Mon,  7 Sep 2020 07:18:28 -0700 (PDT)
Date:   Mon, 7 Sep 2020 15:18:21 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH v2][next] PCI: rcar-gen2: Use fallthrough pseudo-keyword
Message-ID: <20200907141821.GA9474@e121166-lin.cambridge.arm.com>
References: <20200722032851.GA4251@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722032851.GA4251@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 21, 2020 at 10:28:51PM -0500, Gustavo A. R. Silva wrote:
> Replace the existing /* fall through */ comments and its variants with
> the new pseudo-keyword macro fallthrough[1].
> 
> [1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>  - Update URL. Use proper URL to Linux v5.7 documentation.
>  - Add Geert's Reviewed-by tag.
>  - Update changelog text.
> 
>  drivers/pci/controller/pci-rcar-gen2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to pci/rcar, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/pci-rcar-gen2.c b/drivers/pci/controller/pci-rcar-gen2.c
> index 326171cb1a97..2ec7093a7588 100644
> --- a/drivers/pci/controller/pci-rcar-gen2.c
> +++ b/drivers/pci/controller/pci-rcar-gen2.c
> @@ -228,7 +228,7 @@ static int rcar_pci_setup(int nr, struct pci_sys_data *sys)
>  		pr_warn("unknown window size %ld - defaulting to 256M\n",
>  			priv->window_size);
>  		priv->window_size = SZ_256M;
> -		/* fall-through */
> +		fallthrough;
>  	case SZ_256M:
>  		val |= RCAR_USBCTR_PCIAHB_WIN1_256M;
>  		break;
> -- 
> 2.27.0
> 
