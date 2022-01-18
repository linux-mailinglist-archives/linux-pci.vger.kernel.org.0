Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E7C492AE7
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jan 2022 17:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238387AbiARQPo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jan 2022 11:15:44 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43902 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244129AbiARQNR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jan 2022 11:13:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE45D612B5;
        Tue, 18 Jan 2022 16:13:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B809C340E0;
        Tue, 18 Jan 2022 16:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642522396;
        bh=jh8J4bdUgvQxCRwye873ExFL2Bf/MJfjTabI1oZoIxg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=l2OCucNeGvoeKJoDD88LNdndQ1/xPaTFrq9gChPtKMuBU6DH2pmkn9Zq6jsKEIrZB
         AceU2oMwrnYR5XivN+NAHrAy4rJIHKN6h3mmzSa/fB7z7fTSoRMzoGWoV5aTiRqCxL
         73g6XNX2IBQEkoZxFAaJjDu3bNy3yZmo+/649qZrnsFsPyQg9jBYJu6gX3i7xEnfg5
         P1SlRm6TYrEgG6jVUcMg0SKkRsODK1EORAQjFxzmAoCol+ov1eH75RpEOmfz3v8fua
         re5zRxdcnseZShAsEt9mDZaqBqh7TIWHkhY+9yUPAhj4wqcxL3v7H3ENUv3tOMxbaS
         n7v7MkGcqESWA==
Date:   Tue, 18 Jan 2022 10:13:14 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: rcar: Return all Fs from read which
 triggered an exception
Message-ID: <20220118161314.GA871416@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220117220355.92575-2-marek.vasut@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 17, 2022 at 11:03:55PM +0100, marek.vasut@gmail.com wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> In case the controller is transitioning to L1 in rcar_pcie_config_access(),
> any read/write access to PCIECDR triggers asynchronous external abort. This
> is because the transition to L1 link state must be manually finished by the
> driver. The PCIe IP can transition back from L1 state to L0 on its own.
> 
> The current asynchronous external abort hook implementation restarts
> the instruction which finally triggered the fault, which can be a
> different instruction than the read/write instruction which started
> the faulting access. Usually the instruction which finally triggers
> the fault is one which has some data dependency on the result of the
> read/write. In case of read, the read value after fixup is undefined,
> while a read value of faulting read should be all Fs.
> 
> It is possible to enforce the fault using 'isb' instruction placed
> right after the read/write instruction which started the faulting
> access. Add custom register accessors which perform the read/write
> followed immediately by 'isb'.
> 
> This way, the fault always happens on the 'isb' and in case of read,
> which is located one instruction before the 'isb', it is now possible
> to fix up the return value of the read in the asynchronous external
> abort hook and make that read return all Fs.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Krzysztof Wilczyński <kw@linux.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> V2: Rebase on 1/2
> ---
>  drivers/pci/controller/pcie-rcar-host.c | 67 ++++++++++++++++++++++++-
>  1 file changed, 65 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
> index f0a0d560fefc..875dd5d417ee 100644
> --- a/drivers/pci/controller/pcie-rcar-host.c
> +++ b/drivers/pci/controller/pcie-rcar-host.c
> @@ -107,6 +107,35 @@ static u32 rcar_read_conf(struct rcar_pcie *pcie, int where)
>  	return val >> shift;
>  }
>  
> +void rcar_pci_write_reg_workaround(struct rcar_pcie *pcie, u32 val, unsigned int reg)
> +{
> +#ifdef CONFIG_ARM
> +	asm volatile(
> +		"	str %0, [%1]\n"
> +		"	isb\n"
> +	::"r"(val), "r"(pcie->base + reg):"memory");
> +#else
> +	rcar_pci_write_reg(pcie, val, reg);
> +#endif
> +}
> +
> +u32 rcar_pci_read_reg_workaround(struct rcar_pcie *pcie, unsigned int reg)
> +{
> +#ifdef CONFIG_ARM
> +	u32 val;
> +
> +	asm volatile(
> +		"rcar_pci_read_reg_workaround_start:\n"
> +		"1:	ldr %0, [%1]\n"
> +		"	isb\n"
> +	: "=r"(val):"r"(pcie->base + reg):"memory");
> +
> +	return val;
> +#else
> +	return rcar_pci_read_reg(pcie, reg);
> +#endif
> +}
> +
>  /* Serialization is provided by 'pci_lock' in drivers/pci/access.c */
>  static int rcar_pcie_config_access(struct rcar_pcie_host *host,
>  		unsigned char access_type, struct pci_bus *bus,
> @@ -179,9 +208,9 @@ static int rcar_pcie_config_access(struct rcar_pcie_host *host,
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  
>  	if (access_type == RCAR_PCI_ACCESS_READ)
> -		*data = rcar_pci_read_reg(pcie, PCIECDR);
> +		*data = rcar_pci_read_reg_workaround(pcie, PCIECDR);
>  	else
> -		rcar_pci_write_reg(pcie, *data, PCIECDR);
> +		rcar_pci_write_reg_workaround(pcie, *data, PCIECDR);
>  
>  	/* Disable the configuration access */
>  	rcar_pci_write_reg(pcie, 0, PCIECCTLR);
> @@ -1091,7 +1120,11 @@ static struct platform_driver rcar_pcie_driver = {
>  static int rcar_pcie_aarch32_abort_handler(unsigned long addr,
>  		unsigned int fsr, struct pt_regs *regs)
>  {
> +	extern u32 *rcar_pci_read_reg_workaround_start;
> +	unsigned long pc = instruction_pointer(regs);
> +	unsigned long instr = *(unsigned long *)pc;
>  	unsigned long flags;
> +	u32 reg, val;
>  	int ret = 0;
>  
>  	spin_lock_irqsave(&pmsr_lock, flags);
> @@ -1101,6 +1134,36 @@ static int rcar_pcie_aarch32_abort_handler(unsigned long addr,
>  	if (ret)
>  		goto unlock_exit;
>  
> +	/*
> +	 * Test whether the faulting instruction is 'isb' and if
> +	 * so, test whether it is the 'isb' instruction within
> +	 * rcar_pci_read_reg_workaround() asm volatile()
> +	 * implementation of read access. If it is, fix it up.
> +	 */
> +	instr &= ~0xf;
> +	if ((instr == 0xf57ff060 || instr == 0xf3bf8f60) &&
> +	    (pc == (u32)&rcar_pci_read_reg_workaround_start + 4)) {
> +		/*
> +		 * If the instruction being executed was a read,
> +		 * make it look like it read all-ones.
> +		 */
> +		instr = *(unsigned long *)(pc - 4);
> +		reg = (instr >> 12) & 15;
> +
> +		if ((instr & 0x0c100000) == 0x04100000) {
> +			if (instr & 0x00400000)
> +				val = 255;
> +			else
> +				val = -1;

Can you please use PCI_SET_ERROR_RESPONSE() or something similar here
to make this greppable?

> +			regs->uregs[reg] = val;
> +			regs->ARM_pc += 4;
> +		} else if ((instr & 0x0e100090) == 0x00100090) {
> +			regs->uregs[reg] = -1;

Also here, I guess?

> +			regs->ARM_pc += 4;
> +		}
> +	}
> +
>  unlock_exit:
>  	spin_unlock_irqrestore(&pmsr_lock, flags);
>  	return ret;
> -- 
> 2.34.1
> 
