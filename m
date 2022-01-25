Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7D449B6FB
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jan 2022 15:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358250AbiAYOyq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jan 2022 09:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1580830AbiAYOwj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jan 2022 09:52:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA67C061748
        for <linux-pci@vger.kernel.org>; Tue, 25 Jan 2022 06:52:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35067B81816
        for <linux-pci@vger.kernel.org>; Tue, 25 Jan 2022 14:52:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7372C340E0;
        Tue, 25 Jan 2022 14:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643122357;
        bh=u6z7VL+6yOq09urW0AXXqAeLrjcOpLhLbPXm+Vz6y0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JSJge4jYjogoVn2tXyqLUMfg2k8YlhkK9NlMz3e0jB+4cHEABfXa4HvMqJm4Tqoe/
         NOnS4u4MR+AhYKkYeZLK9tjLDcG84lTHqo7dtp67+pzifSZG9uHn5mQpiOavm2C8Zp
         IrAabMHbSpqNsiWDnqhjnIi1PpBy7GoEY4C+YcKFQupCiLgqJgnxP93PReuDoAnBpG
         fifMFCz0UrQ+EFLALglevk9tITSZqBilRIO4sd0jITZd8BKfuL0xekrO1DHy0cGTrd
         Eztb5gDVyOxWe2KoI0HrodAA129O7mdScIZb5PBB2XOL7YqBgoKC9DpwvP006Bx6TT
         IeNDp8+/f2q1Q==
Received: by pali.im (Postfix)
        id 0A24C12F7; Tue, 25 Jan 2022 15:52:33 +0100 (CET)
Date:   Tue, 25 Jan 2022 15:52:33 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Stefan Roese <sr@denx.de>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Yao Hongbo <yaohongbo@linux.alibaba.com>,
        Naveen Naidu <naveennaidu479@gmail.com>
Subject: Re: [PATCH v4 1/3] PCI/AER: Call pcie_set_ecrc_checking() for each
 PCIe device
Message-ID: <20220125145233.nhhxe232sosutbqu@pali>
References: <20220125071820.2247260-1-sr@denx.de>
 <20220125071820.2247260-2-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220125071820.2247260-2-sr@denx.de>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 25 January 2022 08:18:18 Stefan Roese wrote:
> Make sure that pcie_set_ecrc_checking() is called for each PCIe device,
> also when it's hot-plugged. This is done by moving
> pcie_set_ecrc_checking() to pci_aer_init().
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Pali Rohár <pali@kernel.org>
> Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: Yao Hongbo <yaohongbo@linux.alibaba.com>
> Cc: Naveen Naidu <naveennaidu479@gmail.com>

Reviewed-by: Pali Rohár <pali@kernel.org>

> ---
> v4:
> - New patch
> 
>  drivers/pci/pcie/aer.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 9fa1f97e5b27..5585fefc4d0e 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -387,6 +387,9 @@ void pci_aer_init(struct pci_dev *dev)
>  	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_ERR, sizeof(u32) * n);
>  
>  	pci_aer_clear_status(dev);
> +
> +	/* Enable ECRC checking if enabled and configured */
> +	pcie_set_ecrc_checking(dev);
>  }
>  
>  void pci_aer_exit(struct pci_dev *dev)
> @@ -1223,9 +1226,6 @@ static int set_device_error_reporting(struct pci_dev *dev, void *data)
>  			pci_disable_pcie_error_reporting(dev);
>  	}
>  
> -	if (enable)
> -		pcie_set_ecrc_checking(dev);
> -
>  	return 0;
>  }
>  
> -- 
> 2.35.0
> 
