Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9259D4972A0
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jan 2022 16:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237935AbiAWPjx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jan 2022 10:39:53 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45646 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237928AbiAWPjx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 23 Jan 2022 10:39:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9494D60E33;
        Sun, 23 Jan 2022 15:39:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C96FC340E5;
        Sun, 23 Jan 2022 15:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642952392;
        bh=8KcaEArUV+SiXKtT18MoheOsBX2I7NbZzzQW4FxWUlg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QxSD5VcuwghaehMK+lqOhvQCo2e2qHfUKgz35uHukD2FlSQpyQorU9G1nVQDZ8Emk
         dYO/CqMvVdCDDPENZSw55BYIo999SojSxKPp/kGR+qoIJHApPyvPJsNx+WnjmmRpas
         m2RhxihjgZizcex+YzcWy0i7dGMAEwtozkxeSiyQOLdvpDso7pkscgBse8yNdSu+io
         SQc9nADXXGUQfO7wqDaYzk5ETg6iXoHvh39f2aXK5IxBHwRVZUgM5WahbZZza1CKkq
         8QCdNtcJcKORp995qxbNQviBE4iL2YIrRMSE5eBz4CkjV+MRmw1ShESYZWjIDTbKhB
         UYIwtgwESOsoQ==
Date:   Sun, 23 Jan 2022 09:39:49 -0600
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
Subject: Re: [PATCH v3 2/2] PCI: rcar: Return all Fs from read which
 triggered an exception
Message-ID: <20220123153949.GA1458406@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220122221554.196311-2-marek.vasut@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jan 22, 2022 at 11:15:54PM +0100, marek.vasut@gmail.com wrote:
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
> V3: - Add .text.fixup on all three ldr/str/isb instructions and call
>       fixup_exception() in the abort handler to trigger the fixup.
>     - Propagate return value from read/write accessors, in case the
>       access fails, return PCIBIOS_SET_FAILED, else PCIBIOS_SUCCESSFUL.
> ---
>  drivers/pci/controller/pcie-rcar-host.c | 53 +++++++++++++++++++++++--
>  1 file changed, 49 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
> index 7d38a9c50093..b2e521ee95eb 100644
> --- a/drivers/pci/controller/pcie-rcar-host.c
> +++ b/drivers/pci/controller/pcie-rcar-host.c
> @@ -114,6 +114,51 @@ static u32 rcar_read_conf(struct rcar_pcie *pcie, int where)
>  	return val >> shift;
>  }
>  
> +#ifdef CONFIG_ARM
> +#define __rcar_pci_rw_reg_workaround(instr)				\
> +		"1:	" instr " %1, [%2]\n"				\
> +		"2:	isb\n"						\
> +		"3:	.pushsection .text.fixup,\"ax\"\n"		\
> +		"	.align	2\n"					\
> +		"4:	mov	%0, #" __stringify(PCIBIOS_SET_FAILED) "\n" \
> +		"	b	3b\n"					\
> +		"	.popsection\n"					\
> +		"	.pushsection __ex_table,\"a\"\n"		\
> +		"	.align	3\n"					\
> +		"	.long	1b, 4b\n"				\
> +		"	.long	1b, 4b\n"				\
> +		"	.popsection\n"
> +#endif
> +
> +int rcar_pci_write_reg_workaround(struct rcar_pcie *pcie, u32 val, unsigned int reg)
> +{
> +	int error = PCIBIOS_SUCCESSFUL;
> +#ifdef CONFIG_ARM
> +	asm volatile(
> +		__rcar_pci_rw_reg_workaround("str")
> +	: "+r"(error):"r"(val), "r"(pcie->base + reg) : "memory");
> +#else
> +	rcar_pci_write_reg(pcie, val, reg);
> +#endif
> +	return error;
> +}
> +
> +int rcar_pci_read_reg_workaround(struct rcar_pcie *pcie, u32 *val, unsigned int reg)
> +{
> +	int error = PCIBIOS_SUCCESSFUL;
> +#ifdef CONFIG_ARM
> +	asm volatile(
> +		__rcar_pci_rw_reg_workaround("ldr")
> +	: "+r"(error), "=r"(*val) : "r"(pcie->base + reg) : "memory");
> +
> +	if (error != PCIBIOS_SUCCESSFUL)
> +		*val = 0xffffffff;

PCI_SET_ERROR_RESPONSE()?

Maybe also use PCI_ERROR_RESPONSE in the subject and commit log
instead of "all Fs" to make it more greppable.

> +#else
> +	*val = rcar_pci_read_reg(pcie, reg);
> +#endif
> +	return error;
> +}
> +
>  /* Serialization is provided by 'pci_lock' in drivers/pci/access.c */
>  static int rcar_pcie_config_access(struct rcar_pcie_host *host,
>  		unsigned char access_type, struct pci_bus *bus,
> @@ -185,14 +230,14 @@ static int rcar_pcie_config_access(struct rcar_pcie_host *host,
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  
>  	if (access_type == RCAR_PCI_ACCESS_READ)
> -		*data = rcar_pci_read_reg(pcie, PCIECDR);
> +		ret = rcar_pci_read_reg_workaround(pcie, data, PCIECDR);
>  	else
> -		rcar_pci_write_reg(pcie, *data, PCIECDR);
> +		ret = rcar_pci_write_reg_workaround(pcie, *data, PCIECDR);
>  
>  	/* Disable the configuration access */
>  	rcar_pci_write_reg(pcie, 0, PCIECCTLR);
>  
> -	return PCIBIOS_SUCCESSFUL;
> +	return ret;
>  }
>  
>  static int rcar_pcie_read_conf(struct pci_bus *bus, unsigned int devfn,
> @@ -1097,7 +1142,7 @@ static struct platform_driver rcar_pcie_driver = {
>  static int rcar_pcie_aarch32_abort_handler(unsigned long addr,
>  		unsigned int fsr, struct pt_regs *regs)
>  {
> -	return !!rcar_pcie_wakeup(pcie_dev, pcie_base);
> +	return !fixup_exception(regs);
>  }
>  
>  static const struct of_device_id rcar_pcie_abort_handler_of_match[] __initconst = {
> -- 
> 2.34.1
> 
