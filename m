Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384BE75B3F9
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jul 2023 18:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjGTQQB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jul 2023 12:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjGTQP7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jul 2023 12:15:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403DD1722;
        Thu, 20 Jul 2023 09:15:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF5FD61B54;
        Thu, 20 Jul 2023 16:15:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA036C433C7;
        Thu, 20 Jul 2023 16:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689869757;
        bh=FRKVuYHq1ZSB29kS1w0pda8OH+Ba8Mh80RiqlSiMHZM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sgU+7SJcGwceF0yS1ER0eHVaA156QO5sygp4hNSYRAjpu2U8mKJDaZfuchJdo7hXR
         5UZ+igBNqTgQ8HJlkUTOKmb47E2gzYbOPQ07DRGy0MF/0K8yGfTxuvSc/OlMSEZJmp
         n2l3EBbQU67UfEXH5A7HY7DxhsnVzpD7L1H9MFi6rRZ3zRSZ2TrN3qQ//NWTPPqspP
         82olwsCbQ/dgZzwSp9dLrb/Z0b+bUCO4ISZHJLbs9VS9t8nGO5XbYBzeZ9788EpAIk
         EY858GicTuPvTBPv5N7cTJkS3IH8MFZdTDDOm5Nl5JqLJrp8oihFHPxqLBpAmc9npy
         jqun9eOPCzDxA==
Date:   Thu, 20 Jul 2023 11:15:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kevin Xie <kevin.xie@starfivetech.com>
Cc:     Minda Chen <minda.chen@starfivetech.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>
Subject: Re: [PATCH v1 8/9] PCI: PLDA: starfive: Add JH7110 PCIe controller
Message-ID: <20230720161555.GA526946@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be30446c-f350-471d-bfac-b4b8dc0a75a2@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 20, 2023 at 06:11:59PM +0800, Kevin Xie wrote:
> On 2023/7/20 0:48, Bjorn Helgaas wrote:
> > On Wed, Jul 19, 2023 at 06:20:56PM +0800, Minda Chen wrote:
> >> Add StarFive JH7110 SoC PCIe controller platform
> >> driver codes.

> >> + * The BAR0/1 of bridge should be hidden during enumeration to
> >> + * avoid the sizing and resource allocation by PCIe core.
> >> + */
> >> +static bool starfive_pcie_hide_rc_bar(struct pci_bus *bus, unsigned int  devfn,
> >> +				      int offset)
> >> +{
> >> +	if (pci_is_root_bus(bus) && !devfn &&
> >> +	    (offset == PCI_BASE_ADDRESS_0 || offset == PCI_BASE_ADDRESS_1))
> >> +		return true;
> >> +
> >> +	return false;
> >> +}
> >> +
> >> +int starfive_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
> >> +			       int where, int size, u32 value)
> >> +{
> >> +	if (starfive_pcie_hide_rc_bar(bus, devfn, where))
> >> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> > 
> > I think you are trying present BARs 0 & 1 as unimplemented.  Such BARs
> > are hardwired to zero, so you should make them behave that way (both
> > read and write).  Many callers of config accessors don't check the
> > return value, so I don't think it's reliable to just return
> > PCIBIOS_BAD_REGISTER_NUMBER.
> 
> This is a hardware defect that we did not hardwired those BARs to
> zero, and it is configurable for software now.  We have to add this
> filter function for workaround.

Yes.  My point is that this only affects the write path, and the read
probably does not read 0 as it should.  This means lspci will show the
wrong thing, and the PCI core will try to size the BAR when it doesn't
need to.  I haven't looked at the BAR sizing code; it might even come
up with a bogus size and address, when it *should* just conclude the
BAR doesn't exist at all.

> >> +	/* Ensure that PERST has been asserted for at least 100 ms */
> >> +	msleep(300);
> >> +	gpiod_set_value_cansleep(pcie->reset_gpio, 0);
> > 
> > At least 100 ms, but you sleep *300* ms?  This is probably related to
> > https://lore.kernel.org/r/20230718155515.GA483233@bhelgaas
> > 
> > Please include a comment with the source of the delay value.  I assume
> > it's T_PVPERL and T_PERST-CLK from the PCIe CEM spec.  This way we can
> > someday share those #defines across drivers.
> 
> Yes, the delay value here is T_PVPERL from PCIe CEM spec r2.0 (Table
> 2-4).  At the first time we set 100ms delay according to sector 2.2
> of the spec: "After there has been time (TPVPERL) for the power and
> clock to become stable, PERST# is deasserted high and the PCI
> Express functions can start up."
> 
> However, in the compatibility testing with several NVMe SSD, we
> found that Lenovo Thinklife ST8000 NVMe can not get ready in 100ms,
> and it actually needs almost 200ms.  Thus, we increased the T_PVPERL
> value to 300ms for the better device compatibility.
>
> We will use a macro to define T_PVPERL, and add comments for the
> source of it.  If the compatibility delay of 300ms is not
> reasonable, we can revert it to 100ms.

Thanks for this valuable information!  This NVMe issue potentially
affects many similar drivers, and we may need a more generic fix so
this device works well with all of them.

T_PVPERL is defined to start when power is stable.  Do you have a way
to accurately determine that point?  I'm guessing this:

  gpiod_set_value_cansleep(pcie->power_gpio, 1)

turns the power on?  But of course that doesn't mean it is instantly
stable.  Maybe your testing is telling you that your driver should
have a hardware-specific 200ms delay to wait for power to become
stable, followed by the standard 100ms for T_PVPERL?

Bjorn
