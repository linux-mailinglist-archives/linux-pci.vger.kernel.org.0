Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1A14B871C
	for <lists+linux-pci@lfdr.de>; Wed, 16 Feb 2022 12:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbiBPLvE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Feb 2022 06:51:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiBPLvC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Feb 2022 06:51:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A151CEB29;
        Wed, 16 Feb 2022 03:50:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A13BB81EBE;
        Wed, 16 Feb 2022 11:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C879C004E1;
        Wed, 16 Feb 2022 11:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645012247;
        bh=WsEFfbYJE6Lo2G0DMfj7k4uUYaubjxYJL8BKx1NHyu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ERVnwa4fEztdw2J4gsG6nx+Hjo6NBjyBE8kkwayuTCR2yQyfa5e1EzvV3cZYT2nNv
         jvOeD1k2pp8+lIiC/DvPnRkiKhxeD359FCzH4bewyd2tVjqcy6/vL19WfdAr2eAph3
         zS/CcGAc70ONpn31HuZFVs6FBbR43Wo7a+ea9pUNFfnt+Zxg9aCXqVI5hTF/5IAPC7
         QRZmWFSgTP4tGtTRNNukCQIJTbKadPkHBII3xQZKSRsNXcRRQKZ/gn5kMWZ+EgiOXK
         CrQOpqDPD5rjFNxmeBDvaptQr4vZlmI1sm3YzX5HEtLWzXgWufuhQ7r1R2sIBck/39
         rTbxDMj3mxd8w==
Received: by pali.im (Postfix)
        id CCAC67F4; Wed, 16 Feb 2022 12:50:44 +0100 (CET)
Date:   Wed, 16 Feb 2022 12:50:44 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     marek.vasut@gmail.com, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 2/2] PCI: rcar: Return all Fs from read which
 triggered an exception
Message-ID: <20220216115044.kslb47pup4dsukgh@pali>
References: <20220122221554.196311-1-marek.vasut@gmail.com>
 <20220122221554.196311-2-marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220122221554.196311-2-marek.vasut@gmail.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Saturday 22 January 2022 23:15:54 marek.vasut@gmail.com wrote:
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

I'm looking at this again and I do not think that this is reliable.
Asynchronous aborts are by definition asynchronous. Placing isb looks
like a hack to decrease probability that asynchronous abort would be
triggered at wrong time.

Marek: Cannot you change the code to trigger proper synchronous abort
for this operation? If this is ARMv7 system, what about trying to change
memory mapping where is the accessing address to strongly-ordered?
Writing to strongly-ordered ARMv7 mapping could not report asynchronous
aborts anymore, but I'm not sure.

Marek: Are you sure that also ldr instruction is causing asynchronous
abort? This is strange as normally load from memory mapped config space
could not finish earlier than data from config space are fetched.
Normally these load instructions should cause synchronous abort on data
errors.

Bjorn, Lorenzo, Krzysztof: These kind of aborts are common for lot of
ARM SoCs and I think that some generic/core PCI code would be useful.
I talked with more people and these aborts really affects more drivers,
just mainline kernel does not have fixes/workarounds. Common suggestions
(as workarounds) in vendors kernels are to disable ASPM or other PCIe
feature (which has probability to trigger this error) or stop using any
PCIe switches, etc... This is really ridiculous but everything comes to
the issue that some device in the PCIe topology sends UR or CA response,
or that PCIe controller itself send this response. Lot of PCIe
controllers on ARM SoCs converts PCIe UR or CA as fatal aborts to CPU
(AXI slave error) and crash is there. Note that at least during PCIe
device enumeration is UR or CA fully valid response which should never
cause CPU/SoC to crash.

Lorenzo: Do you have an idea if it is possible to completely mute AXI
slave errors which comes from PCIe controllers?

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
