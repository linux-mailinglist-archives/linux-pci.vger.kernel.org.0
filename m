Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7EC7D9F00
	for <lists+linux-pci@lfdr.de>; Fri, 27 Oct 2023 19:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjJ0Rpr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Oct 2023 13:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjJ0Rpq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Oct 2023 13:45:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988ABF3;
        Fri, 27 Oct 2023 10:45:40 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698428739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vCF2sTMjoJARe87DP7lAD8rcZvlM4BFzZKH7cV3QuU8=;
        b=xXX2ovs1OHhXbwDuZac6CP8IsOrVj54bZeD5nyxWlPUBOXUniX1BJWPV+PcVr7obtLN3eF
        I6uPBnLwqsSeXJfTpISEjW/ksbeWDMkDlGhuSLkQd0gwCvAm+Ogc1qakMhd99FaKFmFOz6
        1GIjy1E+N/YDe03TxrnRIU53J4jidS28NuERCZkDyMkX8X5wFJu/OtV20oF773goJYLcMm
        /ktLuCbvSshkq1Zxca8OxoWF8VJ4zqw5Ohr8CYTRGpLm9x96JuE60jmezp5gm6X3Yn94AK
        7ns6idG1lqprpc0Y27+8vH0y0yrCC8o1DwW3zTycAy/bFh5YoXh4wv0+CbwiwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698428739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vCF2sTMjoJARe87DP7lAD8rcZvlM4BFzZKH7cV3QuU8=;
        b=WWHizKPPbjghvXPvf1/QyrM9sNTsNYrmVq6GoM+JMN89I9M6CgHAYJRHoOSGLIiqmVpfsl
        B+qpDGnW7YiT4hDg==
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
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
        Haibo Xu <haibo1.xu@intel.com>, Marc Zyngier <maz@kernel.org>
Subject: Re: [RFC PATCH v2 13/21] irqchip: riscv-intc: Add ACPI support for AIA
In-Reply-To: <20231026165150.GA1825130@bhelgaas>
References: <20231026165150.GA1825130@bhelgaas>
Date:   Fri, 27 Oct 2023 19:45:38 +0200
Message-ID: <87jzr82c3h.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 26 2023 at 11:51, Bjorn Helgaas wrote:
> On Thu, Oct 26, 2023 at 01:53:36AM +0530, Sunil V L wrote:
>> The RINTC subtype structure in MADT also has information about other
>> interrupt controllers like MMIO. So, save those information and provide
>> interfaces to retrieve them when required by corresponding drivers.
>
>> @@ -218,7 +306,19 @@ static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
>
>> +	 * MSI controller (IMSIC) in RISC-V is optional. So, unless
>> +	 * IMSIC is discovered, set system wide MSI support as
>> +	 * unsupported. Once IMSIC is probed, MSI support will be set.
>> +	 */
>> +	pci_no_msi();
>
> It doesn't seem like we should have to tell the PCI core about
> functionality we *don't* have.
>
> I would think IMSIC would be detected before enumerating PCI devices
> that might use it, and if we *haven't* found an IMSIC by the time we
> get to pci_register_host_bridge(), would/should we set
> PCI_BUS_FLAGS_NO_MSI there?
>
> I see Thomas is cc'd; he'd have better insight.

I was not really involved with this bus and MSI domain logic. Marc
should know. CC'ed.

Thanks,

        tglx


