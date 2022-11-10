Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4E2624C54
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 22:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiKJVCV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 16:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiKJVCT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 16:02:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CE545EFA
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 13:02:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0832AB8224F
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 21:02:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AFAFC433C1;
        Thu, 10 Nov 2022 21:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668114135;
        bh=tINnwNKzRqIRaSW5ZEl650mulWBp1Qe/aVQyhkrRyxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UPufBiFZ7Qcfx03lwzYqf8LMW29ZkSN66RRH49RnjCblrw4/WZhKcNi2+qtXTI15T
         xBh9buD0xObRt8hn1VdjgPS2QbTxRCFneHBCo2yNQ5R+azffD/DWp2J/Exd8gM7g0D
         yDqM4JL77TANMPDJFXUW5lqkLduxKwRdM8IgrHbmf6dEEaVdeAOjQ5nDBD/82AFFtH
         dlpcBj3pyGJK+UHP5D4YrnA9aqhYJonqn7P9F6EkxNciyusbGHZR6/gnRz4pwLwxoW
         WEYD9MvnKWchIWDHlqe9Wn59zi+wSuxPJ7NcFcbiyVSX3rZ4f2Rn5tTIFvHgOgq9PE
         HWpaCLidnu18w==
Received: by pali.im (Postfix)
        id 30CD7856; Thu, 10 Nov 2022 22:02:12 +0100 (CET)
Date:   Thu, 10 Nov 2022 22:02:12 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Jonathan Derrick <jonathan.derrick@linux.dev>
Cc:     Vidya Sagar <vidyas@nvidia.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2 5/7] PCI: pci-bridge-emul: Provide a helper to set
 behavior
Message-ID: <20221110210212.2jpllczct5pggob4@pali>
References: <20221110195015.207-1-jonathan.derrick@linux.dev>
 <20221110195015.207-6-jonathan.derrick@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110195015.207-6-jonathan.derrick@linux.dev>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 10 November 2022 12:50:13 Jonathan Derrick wrote:
> Add a handler to set behavior of a PCI or PCIe register. Add the
> appropriate enums to specify the register's Read-Only, Read-Write, and
> Write-1-to-Clear behaviors.
> 
> Signed-off-by: Jonathan Derrick <jonathan.derrick@linux.dev>

I do not think that this is the correct way. Drivers should not need to
tell bridge emulator that some register is read-only or read-write.
Bridge emulator has already all required information in its internal
structures.

If there is a need to tell bridge emulator to "emulate" some optional
feature, for example hot plug capabilities, then it would be better to
extend pci_bridge_emul_init() flags and let init function to correctly
fill all behavior bits. There is already PCI_BRIDGE_EMUL_NO_PREFMEM_FORWARD
flag which modify bridge prefetchable bits.

In my opinion, all standard PCI/PCIe behavior bits should be in
pci-bridge-emul.c source file and drivers should not modify them.
I think that this approach makes implementation lot of cleaner.

> ---
>  drivers/pci/pci-bridge-emul.c | 19 +++++++++++++++++++
>  drivers/pci/pci-bridge-emul.h | 10 ++++++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
> index 9334b2dd4764..3c1a683ece66 100644
> --- a/drivers/pci/pci-bridge-emul.c
> +++ b/drivers/pci/pci-bridge-emul.c
> @@ -46,6 +46,25 @@ struct pci_bridge_reg_behavior {
>  	u32 w1c;
>  };
>  
> +void pci_bridge_emul_set_reg_behavior(struct pci_bridge_emul *bridge,
> +				      bool pcie, int reg, u32 val,
> +				      enum pci_bridge_emul_reg_behavior type)
> +{
> +	struct pci_bridge_reg_behavior *behavior;
> +
> +	if (pcie)
> +		behavior = &bridge->pcie_cap_regs_behavior[reg / 4];
> +	else
> +		behavior = &bridge->pci_regs_behavior[reg / 4];
> +
> +	if (type == PCI_BRIDGE_EMUL_REG_BEHAVIOR_RO)
> +		behavior->ro = val;
> +	else if (type == PCI_BRIDGE_EMUL_REG_BEHAVIOR_RW)
> +		behavior->rw = val;
> +	else /* PCI_BRIDGE_EMUL_REG_BEHAVIOR_W1C */
> +		behavior->w1c = val;
> +}
> +
>  static const
>  struct pci_bridge_reg_behavior pci_regs_behavior[PCI_STD_HEADER_SIZEOF / 4] = {
>  	[PCI_VENDOR_ID / 4] = { .ro = ~0 },
> diff --git a/drivers/pci/pci-bridge-emul.h b/drivers/pci/pci-bridge-emul.h
> index 2a0e59c7f0d9..b2401d58518c 100644
> --- a/drivers/pci/pci-bridge-emul.h
> +++ b/drivers/pci/pci-bridge-emul.h
> @@ -72,6 +72,12 @@ struct pci_bridge_emul;
>  typedef enum { PCI_BRIDGE_EMUL_HANDLED,
>  	       PCI_BRIDGE_EMUL_NOT_HANDLED } pci_bridge_emul_read_status_t;
>  
> +enum pci_bridge_emul_reg_behavior {
> +	PCI_BRIDGE_EMUL_REG_BEHAVIOR_RO,
> +	PCI_BRIDGE_EMUL_REG_BEHAVIOR_RW,
> +	PCI_BRIDGE_EMUL_REG_BEHAVIOR_W1C,
> +};
> +
>  struct pci_bridge_emul_ops {
>  	/*
>  	 * Called when reading from the regular PCI bridge
> @@ -161,4 +167,8 @@ int pci_bridge_emul_conf_read(struct pci_bridge_emul *bridge, int where,
>  int pci_bridge_emul_conf_write(struct pci_bridge_emul *bridge, int where,
>  			       int size, u32 value);
>  
> +void pci_bridge_emul_set_reg_behavior(struct pci_bridge_emul *bridge,
> +				      bool pcie, int reg, u32 val,
> +				      enum pci_bridge_emul_reg_behavior type);
> +
>  #endif /* __PCI_BRIDGE_EMUL_H__ */
> -- 
> 2.30.2
> 
