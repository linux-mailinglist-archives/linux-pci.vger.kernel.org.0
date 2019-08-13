Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD4548B4E9
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2019 12:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbfHMKED (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Aug 2019 06:04:03 -0400
Received: from foss.arm.com ([217.140.110.172]:33110 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728559AbfHMKEC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Aug 2019 06:04:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A0511570;
        Tue, 13 Aug 2019 03:04:02 -0700 (PDT)
Received: from red-moon (red-moon.cambridge.arm.com [10.1.197.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCC683F774;
        Tue, 13 Aug 2019 03:03:59 -0700 (PDT)
Date:   Tue, 13 Aug 2019 11:04:09 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Xiaowei Bao <xiaowei.bao@nxp.com>
Cc:     bhelgaas@google.com, minghuan.Lian@nxp.com, mingkai.hu@nxp.com,
        roy.zang@nxp.com, l.stach@pengutronix.de, kishon@ti.com,
        tpiepho@impinj.com, leonard.crestez@nxp.com,
        andrew.smirnov@gmail.com, yue.wang@amlogic.com,
        hayashi.kunihiko@socionext.com, dwmw@amazon.co.uk,
        jonnyc@amazon.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv5 1/2] PCI: layerscape: Add the bar_fixed_64bit property
 in EP driver.
Message-ID: <20190813100409.GB10070@red-moon>
References: <20190813062840.2733-1-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813062840.2733-1-xiaowei.bao@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

git log --oneline --follow drivers/pci/controller/dwc/pci-layerscape.c

Do you see any commit with a $SUBJECT ending with a period ?

There is not. So remove it from yours too.

On Tue, Aug 13, 2019 at 02:28:39PM +0800, Xiaowei Bao wrote:
> The PCIe controller of layerscape just have 4 BARs, BAR0 and BAR1
> is 32bit, BAR2 and BAR4 is 64bit, this is determined by hardware,
> so set the bar_fixed_64bit with 0x14.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> ---
> v2:
>  - Replace value 0x14 with a macro.
> v3:
>  - No change.
> v4:
>  - send the patch again with '--to'.
> v5:
>  - fix the commit message.
> 
>  drivers/pci/controller/dwc/pci-layerscape-ep.c | 1 +
>  1 file changed, 1 insertion(+)

scripts/get_maintainer.pl -f drivers/pci/controller/dwc/pci-layerscape-ep.c
Now, with the output you get justify all the people you send this email
to.

So, again, trim the CC list and it is the last time I tell you.

Before sending patches on mailing lists use git --dry-run to check
the emails you are sending.

Thanks,
Lorenzo

> diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> index be61d96..ca9aa45 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> @@ -44,6 +44,7 @@ static const struct pci_epc_features ls_pcie_epc_features = {
>  	.linkup_notifier = false,
>  	.msi_capable = true,
>  	.msix_capable = false,
> +	.bar_fixed_64bit = (1 << BAR_2) | (1 << BAR_4),
>  };
>  
>  static const struct pci_epc_features*
> -- 
> 2.9.5
> 
