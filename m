Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9787E2019
	for <lists+linux-pci@lfdr.de>; Mon,  6 Nov 2023 12:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjKFLff (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Nov 2023 06:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjKFLfe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Nov 2023 06:35:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCDABE;
        Mon,  6 Nov 2023 03:35:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832BAC433C7;
        Mon,  6 Nov 2023 11:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699270531;
        bh=fI4NKuZ1uY8mqL9yZ9YNJndkjv1j7nVGFqh2pflGyYI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cRiY+eu6yXREipoxzeem9UkMf7DbKLyTEsBhihxAIIk9nQ7OhutANlrX0EN63aFg8
         ZSOLFibjhi2PMsmJgXzpwOvA3yqj+aXKhPs5qY42O3Uubyo3b9ra3w1ryHOdHG+HiZ
         lHOvlA1VxBzJlQ/bT8UqOpfVLA184ZKyXm6dfKOVjFk5US/uhLcvJeH9TagyH2mwcu
         9b39ZbgDKTEhKmjrt0MJvhXN1mZbmQCjYEQL13faJBplEzfT8BihvSFWhGl8cQUWBC
         bWSHz+fQSNq7mqI8jiAcEbQjHnTmI/qTbh4GYesnI1QXEQSU6GqcBjGWWa/rNB3tBe
         ESW6CSQ0mYtcg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1qzxtA-00AkGy-HO;
        Mon, 06 Nov 2023 11:35:28 +0000
Date:   Mon, 06 Nov 2023 11:35:27 +0000
Message-ID: <86fs1j15ds.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Sunil V L <sunilvl@ventanamicro.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Anup Patel <anup@brainfault.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Haibo Xu <haibo1.xu@intel.com>
Subject: Re: [RFC PATCH v2 13/21] irqchip: riscv-intc: Add ACPI support for AIA
In-Reply-To: <87jzr82c3h.ffs@tglx>
References: <20231026165150.GA1825130@bhelgaas>
        <87jzr82c3h.ffs@tglx>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@linutronix.de, helgaas@kernel.org, sunilvl@ventanamicro.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-serial@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com, anup@brainfault.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, conor.dooley@microchip.com, ajones@ventanamicro.com, atishp@rivosinc.com, haibo1.xu@intel.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 27 Oct 2023 18:45:38 +0100,
Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> On Thu, Oct 26 2023 at 11:51, Bjorn Helgaas wrote:
> > On Thu, Oct 26, 2023 at 01:53:36AM +0530, Sunil V L wrote:
> >> The RINTC subtype structure in MADT also has information about other
> >> interrupt controllers like MMIO. So, save those information and provide
> >> interfaces to retrieve them when required by corresponding drivers.
> >
> >> @@ -218,7 +306,19 @@ static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
> >
> >> +	 * MSI controller (IMSIC) in RISC-V is optional. So, unless
> >> +	 * IMSIC is discovered, set system wide MSI support as
> >> +	 * unsupported. Once IMSIC is probed, MSI support will be set.
> >> +	 */
> >> +	pci_no_msi();
> >
> > It doesn't seem like we should have to tell the PCI core about
> > functionality we *don't* have.
> >
> > I would think IMSIC would be detected before enumerating PCI devices
> > that might use it, and if we *haven't* found an IMSIC by the time we
> > get to pci_register_host_bridge(), would/should we set
> > PCI_BUS_FLAGS_NO_MSI there?
> >
> > I see Thomas is cc'd; he'd have better insight.
> 
> I was not really involved with this bus and MSI domain logic. Marc
> should know. CC'ed.

The canonical way of doing this is by the platform expressing that
there is no linkage between the PCIe RC and the MSI controller.  If
there is no MSI domain associated with the RC, then by extension the
endpoints don't get one either.

There are additional quirks linked to the msi_domain host bridge
property, allowing the host bridge driver to indicate that it isn't in
charge of MSIs, but that a third party may provide it (in which case a
MSI irq domain will be associated with it).

In any case, slapping a pci_no_msi() call in an irqchip driver is
gross and most probably a sign that this is going in the wrong
direction, specially as this is platform-wide.

The only cases I'd expect this function to be called are:

- Platform or firmware explicitly disallowing MSIs
- pci=nomsi on the command line

none of which are the business of an irqchip driver.

HTH,

	M.

-- 
Without deviation from the norm, progress is not possible.
