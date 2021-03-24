Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7B8347428
	for <lists+linux-pci@lfdr.de>; Wed, 24 Mar 2021 10:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbhCXJJq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Mar 2021 05:09:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234461AbhCXJJp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Mar 2021 05:09:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D9EC619C9;
        Wed, 24 Mar 2021 09:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616576985;
        bh=jnRQ8XZk0O0MVorAp4ULBhBFeVXaOntVyd1dhKGu/08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J9SxtN4tax4jDCHzd7N2lDjj/TnkkirePg7ebZQZFE14lMDngpFfc1MMbZ6M5yE8r
         ZU6Ta8fVY0MHn6l1LHxaI6D2AAMXJlLAkM4TVQ5Dvcu6KbTC2pPHoApRXO+X5bo1Sa
         tA9tgMnawow1GlrTJSK3cCEP0Hc+v8OgITKyw6liFGLoCmb3Xsq3zNKImNxbU1j76c
         ES1vqy2c4TYHlx3Yr/N2bgG7Ub5zFG3H2ThQztLUD2uL8cHZGyeKN3w/dhCLPeG668
         ahyRkW0k2tmt8dAU/PcQTOokqNikXMrX0K+wQvEGZCDo7QC80LmKqiBIpyAhHmBAUG
         4TKpcgPS9iGHw==
Received: by pali.im (Postfix)
        id 6F3F2A7E; Wed, 24 Mar 2021 10:09:42 +0100 (CET)
Date:   Wed, 24 Mar 2021 10:09:42 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, youlin.pei@mediatek.com,
        chuanjia.liu@mediatek.com, qizhong.cheng@mediatek.com,
        sin_jieyang@mediatek.com, drinkcat@chromium.org,
        Rex-BC.Chen@mediatek.com, anson.chuang@mediatek.com,
        Krzysztof Wilczyski <kw@linux.com>
Subject: Re: [v9,2/7] PCI: Export pci_pio_to_address() for module use
Message-ID: <20210324090942.kmhxnxzm7tz3ynuy@pali>
References: <20210324030510.29177-1-jianjun.wang@mediatek.com>
 <20210324030510.29177-3-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324030510.29177-3-jianjun.wang@mediatek.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 24 March 2021 11:05:05 Jianjun Wang wrote:
> This interface will be used by PCI host drivers for PIO translation,
> export it to support compiling those drivers as kernel modules.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> ---
>  drivers/pci/pci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 16a17215f633..12bba221c9f2 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4052,6 +4052,7 @@ phys_addr_t pci_pio_to_address(unsigned long pio)
>  
>  	return address;
>  }
> +EXPORT_SYMBOL(pci_pio_to_address);

Hello! I'm not sure if EXPORT_SYMBOL is correct because file has GPL-2.0
header. Should not be in this case used only EXPORT_SYMBOL_GPL? Maybe
other people would know what is correct?

>  
>  unsigned long __weak pci_address_to_pio(phys_addr_t address)
>  {
> -- 
> 2.25.1
> 
