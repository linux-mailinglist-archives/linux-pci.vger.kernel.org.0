Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9639C4FED41
	for <lists+linux-pci@lfdr.de>; Wed, 13 Apr 2022 05:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiDMDDV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 23:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiDMDDT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 23:03:19 -0400
X-Greylist: delayed 368 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Apr 2022 20:00:55 PDT
Received: from mail-m17640.qiye.163.com (mail-m17640.qiye.163.com [59.111.176.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3832656C;
        Tue, 12 Apr 2022 20:00:55 -0700 (PDT)
Received: from [172.16.12.69] (unknown [58.22.7.114])
        by mail-m17640.qiye.163.com (Hmail) with ESMTPA id D15D35403EB;
        Wed, 13 Apr 2022 10:54:44 +0800 (CST)
Message-ID: <0cf83ec0-29d3-fbde-0b7d-9d58d210f0a4@rock-chips.com>
Date:   Wed, 13 Apr 2022 10:54:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc:     shawn.lin@rock-chips.com, linux-rockchip@lists.infradead.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] PCI: dwc: rockchip: add legacy interrupt support
Content-Language: en-GB
To:     Peter Geis <pgwipeout@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>
References: <20220412185751.124783-1-pgwipeout@gmail.com>
 <20220412185751.124783-3-pgwipeout@gmail.com>
From:   Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20220412185751.124783-3-pgwipeout@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUlKS0tKN1dZLVlBSVdZDwkaFQgSH1lBWUJLHhpWH0gaSxlPHU
        1ITx1KVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PU06Dhw*Nz0*GD8RSB0uOAwe
        Lw8aFCpVSlVKTU9CQ0pDT0NOT0lKVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
        C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlDS083Bg++
X-HM-Tid: 0a8020d841c5d995kuwsd15d35403eb
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Peter,

在 2022/4/13 2:57, Peter Geis 写道:
> The legacy interrupts on the rk356x pcie controller are handled by a
> single muxed interrupt. Add irq domain support to the pcie-dw-rockchip >
> +static void rockchip_pcie_legacy_int_handler(struct irq_desc *desc)
> +{
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	struct rockchip_pcie *rockchip = irq_desc_get_handler_data(desc);
> +	struct device *dev = rockchip->pci.dev;
> +	u32 reg;
> +	u32 hwirq;
> +	u32 virq;
> +
> +	chained_irq_enter(chip, desc);
> +
> +	reg = rockchip_pcie_readl_apb(rockchip, 0x8);
> +


Overall it looks good except that 0x8 has a name,
PCIE_CLIENT_INTR_STATUS_LEGACY. BTW, If you consider adding more support
to it, for instance, enable/disable/affinity?  The downstream kernel
finished these for better fitting for function driver usage.
