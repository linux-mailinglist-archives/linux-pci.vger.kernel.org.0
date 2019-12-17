Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3377122EE4
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2019 15:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfLQOge (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Dec 2019 09:36:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:37268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726402AbfLQOge (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Dec 2019 09:36:34 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A6232072D;
        Tue, 17 Dec 2019 14:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576593393;
        bh=otz2sbQzhiJxVm0FVlkP/Fn8/XLXf3QBj2FIs0MC7Gk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=w9SIW0zQkbYVcBqz00/udDKv5a92C/DnYCHoDcPKL6xU+/cw0TIuJq6yLBC+enyoM
         9xLxyZECpAtZpupYeIpLUrqeN8C58Ulw0RVHo697gNVYXszldzHSA2PoP14OFGNT/a
         jRiF7MINmBG1XVS79/ct2p6imJdnXM8cN3suiKgI=
Date:   Tue, 17 Dec 2019 08:36:32 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     David Engraf <david.engraf@sysgo.com>
Cc:     thierry.reding@gmail.com, lorenzo.pieralisi@arm.com,
        andrew.murray@arm.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: Re: [PATCH v2] PCI: tegra: Fix return value check of
 pm_runtime_get_sync
Message-ID: <20191217143632.GA160591@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216111825.28136-1-david.engraf@sysgo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 16, 2019 at 12:18:25PM +0100, David Engraf wrote:
> pm_runtime_get_sync() returns the device's usage counter. This might
> be >0 if the device is already powered up or CONFIG_PM is disabled.
> 
> Abort probe function on real error only.
> 
> Fixes: da76ba50963b ("PCI: tegra: Add power management support")
> Signed-off-by: David Engraf <david.engraf@sysgo.com>

I added Andrew's ack and a stable tag for v4.17+.  Also cc'd
Manikanta, author of da76ba50963b.

I put this on my pci/host-tegra branch for v5.6 for now.  Lorenzo may
move this when he returns.

> ---
>  drivers/pci/controller/pci-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index 673a1725ef38..090b632965e2 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -2798,7 +2798,7 @@ static int tegra_pcie_probe(struct platform_device *pdev)
>  
>  	pm_runtime_enable(pcie->dev);
>  	err = pm_runtime_get_sync(pcie->dev);
> -	if (err) {
> +	if (err < 0) {
>  		dev_err(dev, "fail to enable pcie controller: %d\n", err);
>  		goto teardown_msi;
>  	}
> -- 
> 2.17.1
> 
