Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F81767B6A
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jul 2023 03:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbjG2B6z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jul 2023 21:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbjG2B6x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jul 2023 21:58:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7C74222;
        Fri, 28 Jul 2023 18:58:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35C5462227;
        Sat, 29 Jul 2023 01:58:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7EAFC433C9;
        Sat, 29 Jul 2023 01:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690595931;
        bh=VA1xMHCSKBMgvqjwoxIc6XApmUSX1OJVYLQaLhiOepI=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=lOsWgUXnUAWzEVfc+56pojnVfijXGwo8p8KIjwrDrZ741kjaW84dStTrN3jMkbVHC
         AaaNTnedPqlsePPzZPt5K+aeBx+EEcXB+5p3bLuP+kJKxtam8gp+jw3LsRQa2WzbZk
         ULb4oEDf/tcjJMiMSNVvkojF5fRB9InX2GaYSTLGs0f6JrRCAXSEyt119dkH/zyydg
         AUm6SJEIh9qEc+2AVgJgNd2Up6/2ZrDAX17ntjbILB9iQhWQa0xY+AQufy9I7VAMho
         ALxJehRypeMC/0SG5j7wFVq4wY3rnn5gX5/D6Ps/dRBBlOGKauXKJLd3ggtntx9Rd4
         4Uez5BIR6QBkw==
Message-ID: <dea62385-7f3a-9396-dcec-4a743bda0fca@kernel.org>
Date:   Sat, 29 Jul 2023 10:58:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v18 02/20] PCI: Rename PCI_EPC_IRQ_LEGACY to
 PCI_EPC_IRQ_INTX
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Srikanth Thokala <srikanth.thokala@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-3-yoshihiro.shimoda.uh@renesas.com>
 <6e88938f-5cb7-96c8-681e-0e929ace4517@kernel.org>
 <20230724073211.GB6291@thinkpad>
 <guakfqdncogablbr6e72xx65ssbqoz536fykegnnea7zel4bho@qyreizjysvoy>
 <ef9026be-4b46-a267-704c-8ea29cd534f0@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ef9026be-4b46-a267-704c-8ea29cd534f0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/29/23 10:55, Damien Le Moal wrote:
> On 7/29/23 10:35, Serge Semin wrote:
>> On Mon, Jul 24, 2023 at 01:02:11PM +0530, Manivannan Sadhasivam wrote:
>>> On Fri, Jul 21, 2023 at 05:10:27PM +0900, Damien Le Moal wrote:
>>>> On 7/21/23 16:44, Yoshihiro Shimoda wrote:
>>>>> Using "INTx" instead of "legacy" is more specific. So, rename
>>>>> PCI_EPC_IRQ_LEGACY to PCI_EPC_IRQ_INTX.
>>>>>
>>>>> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
>>>>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>>>>> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
>>>>> Acked-by: Jesper Nilsson <jesper.nilsson@axis.com> # ARTPEC
>>>>> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
>>>>
>>
>>>> I would rather drop completely the PCI_EPC_IRQ_XXX enum and simply use the
>>>> PCI_IRQ_XXX macros used everywhere. Less definitions :)
>>>>
>>>> See attached patch that I have in my queue (about to send that).
>>>>
>>>
>>> It looks better! This patch should be dropped.
>>
>> Back then Bjorn specifically asked to change the names suffix in a
>> preparation patch before adding the INTx support to the DW PCIe core
>> driver (see the Sb tag in the patch log). Damien, seeing you cleanup
>> the names anyway what about fixing the macro suffix too: INTx instead
>> of LEGACY)?
> 
> Sure, I can do that. That is going to be a gigantic patch though given that
> PCI_IRQ_LEGACY is used well beyond the ep/pcie controller drivers.
> While I agree it would be nice to do, not sure it is worth such code churn.
> 
>> Mani, Damien, what do you suggest to Yoshihiro to do with the
>> LEGACY/INTx names in the following up patches of this series?
> 
> If everyone is OK with the patch I proposed (the PCI_IRQ_LEGACY -> PCI_IRQ_INTx
> change can go on top), then I can rebase it and send it next week (the remaining
> of my EP cleanup series needs some more testing & rebasing). Yoshihiro can
> either include it in his series or rebase on it if the patch is added to
> pci-next quickly.

Note that we could start by simply defining an alias:

#define PCI_IRQ_INTx	PCI_IRQ_LEGACY

and gradually convert all drivers using it until we can get rid of PCI_IRQ_LEGACY.

That probably would be simpler than a treewide patch that would likely create
lots of conflicts.

-- 
Damien Le Moal
Western Digital Research

