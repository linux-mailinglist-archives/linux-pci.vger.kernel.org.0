Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF72E390B21
	for <lists+linux-pci@lfdr.de>; Tue, 25 May 2021 23:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbhEYVTg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 May 2021 17:19:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231881AbhEYVTg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 May 2021 17:19:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E2F161429;
        Tue, 25 May 2021 21:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621977485;
        bh=AeBkEcxQxV+uktorBSzRzGwOfsqEOsQNS87LoS48g/o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BdNAAFtFb/I36Xt9VZ9KsOcpDgEalTVg60Yc0tYzgKHVgUWDF/+DLPLan7+AJk1UP
         p2lHGMAkvcskGGM/v9Cs7F8urRB78Ko6j5VeRTuOr1JkY9MqJUf1jlMNaBpX6cw1hM
         PaugW+JaQNs/zzrPNH0XChQnmN9CJ116gSrCtht96IuDSWrkPsUvpdtRq1Ap03a2OM
         6IjG6bp4cfYGXQHLygUwRwZu9jg0g4msiNG1F1NdFoIc2N2oNFC+2co9kXb9AqIRQM
         /r1hk7f1kuX5yJOHf3xXMF5GK8dA780+aGzfvxGFJQPfCc3/rlL48tUP+zlf8xVAV1
         WkfhhvnJiiUuQ==
Date:   Tue, 25 May 2021 16:18:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 4/4] PCI: brcmstb: add shutdown call to driver
Message-ID: <20210525211804.GA1228022@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427175140.17800-5-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Capitalize "Add" in the subject.

On Tue, Apr 27, 2021 at 01:51:39PM -0400, Jim Quinlan wrote:
> The shutdown() call is similar to the remove() call except the former does
> not need to invoke pci_{stop,remove}_root_bus(), and besides, errors occur
> if it does.

This doesn't explain why shutdown() is necessary.  "errors occur"
might be a hint, except that AFAICT, many similar drivers do invoke
pci_stop_root_bus() and pci_remove_root_bus() (several of them while
holding pci_lock_rescan_remove()), without implementing .shutdown().

It is ... unfortunate that there's such a variety of implementations
here.  I don't believe these driver differences are all necessary
consequences of hardware differences.

> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index d3af8d84f0d6..a1fe1a2ada48 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1340,6 +1340,15 @@ static int brcm_pcie_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static void brcm_pcie_shutdown(struct platform_device *pdev)
> +{
> +	struct brcm_pcie *pcie = platform_get_drvdata(pdev);
> +
> +	if (pcie->has_err_report)
> +		brcm_unregister_die_notifiers(pcie);
> +	__brcm_pcie_remove(pcie);
> +}
> +
>  static const struct of_device_id brcm_pcie_match[] = {
>  	{ .compatible = "brcm,bcm2711-pcie", .data = &bcm2711_cfg },
>  	{ .compatible = "brcm,bcm4908-pcie", .data = &bcm4908_cfg },
> @@ -1460,6 +1469,7 @@ static const struct dev_pm_ops brcm_pcie_pm_ops = {
>  static struct platform_driver brcm_pcie_driver = {
>  	.probe = brcm_pcie_probe,
>  	.remove = brcm_pcie_remove,
> +	.shutdown = brcm_pcie_shutdown,
>  	.driver = {
>  		.name = "brcm-pcie",
>  		.of_match_table = brcm_pcie_match,
> -- 
> 2.17.1
> 
