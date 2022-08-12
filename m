Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C9D590F87
	for <lists+linux-pci@lfdr.de>; Fri, 12 Aug 2022 12:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238562AbiHLKdH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Aug 2022 06:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238572AbiHLKdG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Aug 2022 06:33:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A1C75FA8;
        Fri, 12 Aug 2022 03:33:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D0A6106F;
        Fri, 12 Aug 2022 03:33:06 -0700 (PDT)
Received: from [10.57.12.42] (unknown [10.57.12.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2051B3F70D;
        Fri, 12 Aug 2022 03:33:03 -0700 (PDT)
Message-ID: <3096bb82-62e6-bc9f-1600-fb58d6826302@arm.com>
Date:   Fri, 12 Aug 2022 11:32:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] PCI: mvebu: Fix endianity when accessing pci emul bridge
 members
Content-Language: en-GB
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220812094058.16141-1-pali@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220812094058.16141-1-pali@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022-08-12 10:40, Pali Rohár wrote:
> PCI emul bridge members iolimitupper, iobaseupper, memlimit and membase are
> of type __le16, so correctly access these members via le16_to_cpu() macros.
> 
> Fixes: 4ded69473adb ("PCI: mvebu: Propagate errors when updating PCI_IO_BASE and PCI_MEM_BASE registers")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>   drivers/pci/controller/pci-mvebu.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index c1ffdb06c971..00ea0836b81a 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -523,7 +523,7 @@ static int mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
>   
>   	/* Are the new iobase/iolimit values invalid? */
>   	if (conf->iolimit < conf->iobase ||
> -	    conf->iolimitupper < conf->iobaseupper)
> +	    le16_to_cpu(conf->iolimitupper) < le16_to_cpu(conf->iobaseupper))
>   		return mvebu_pcie_set_window(port, port->io_target, port->io_attr,
>   					     &desired, &port->iowin);
>   
> @@ -535,10 +535,10 @@ static int mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
>   	 * is the CPU address.
>   	 */
>   	desired.remap = ((conf->iobase & 0xF0) << 8) |
> -			(conf->iobaseupper << 16);
> +			le16_to_cpu(conf->iobaseupper << 16);

This will always give 0, even when natively LE.

>   	desired.base = port->pcie->io.start + desired.remap;
>   	desired.size = ((0xFFF | ((conf->iolimit & 0xF0) << 8) |
> -			 (conf->iolimitupper << 16)) -
> +			 le16_to_cpu(conf->iolimitupper << 16)) -

Similarly here.

Robin.

>   			desired.remap) +
>   		       1;
>   
> @@ -552,7 +552,7 @@ static int mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
>   	struct pci_bridge_emul_conf *conf = &port->bridge.conf;
>   
>   	/* Are the new membase/memlimit values invalid? */
> -	if (conf->memlimit < conf->membase)
> +	if (le16_to_cpu(conf->memlimit) < le16_to_cpu(conf->membase))
>   		return mvebu_pcie_set_window(port, port->mem_target, port->mem_attr,
>   					     &desired, &port->memwin);
>   
> @@ -562,8 +562,8 @@ static int mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
>   	 * window to setup, according to the PCI-to-PCI bridge
>   	 * specifications.
>   	 */
> -	desired.base = ((conf->membase & 0xFFF0) << 16);
> -	desired.size = (((conf->memlimit & 0xFFF0) << 16) | 0xFFFFF) -
> +	desired.base = ((le16_to_cpu(conf->membase) & 0xFFF0) << 16);
> +	desired.size = (((le16_to_cpu(conf->memlimit) & 0xFFF0) << 16) | 0xFFFFF) -
>   		       desired.base + 1;
>   
>   	return mvebu_pcie_set_window(port, port->mem_target, port->mem_attr, &desired,
