Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A602B1BB8D6
	for <lists+linux-pci@lfdr.de>; Tue, 28 Apr 2020 10:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgD1I2L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Apr 2020 04:28:11 -0400
Received: from foss.arm.com ([217.140.110.172]:47650 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbgD1I2L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Apr 2020 04:28:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5CDC30E;
        Tue, 28 Apr 2020 01:28:10 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4F3F3F305;
        Tue, 28 Apr 2020 01:28:09 -0700 (PDT)
Date:   Tue, 28 Apr 2020 09:28:07 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: pcie-rcar: Mark rcar_pcie_resume() with
 __maybe_unused
Message-ID: <20200428082807.GB12459@e121166-lin.cambridge.arm.com>
References: <20200426123115.55995-1-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200426123115.55995-1-marek.vasut@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
> ---
>  drivers/pci/controller/pcie-rcar.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Squashed in https://patchwork.kernel.org/patch/11438665/

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
