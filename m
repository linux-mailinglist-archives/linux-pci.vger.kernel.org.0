Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A717DC082
	for <lists+linux-pci@lfdr.de>; Mon, 30 Oct 2023 20:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjJ3T3T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Oct 2023 15:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjJ3T3S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Oct 2023 15:29:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A3FCC;
        Mon, 30 Oct 2023 12:29:16 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698694154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=okhxQnUhQwZrbcdUo7XXc56UihUKqv6O8qJ7nxX4PVE=;
        b=OvyHHOlBlpoVLw3xBWs9oqxtW+DXUQgwbbHbDbUfNF/MjfJs5bWPOU8I21CIumHlkp0uPz
        5ZkiCmUvyIM5ITCYjU15vSbdzkoIOQAnrNLVHdJzkOUfToXjY1WMmUsPke3zwZKHUCO9fI
        UtYzITvFTF3nlnm+WD5jBWNGfFPpU8AMut0ABL5tfyRWUR/XBuJ0FRwWcdE9BBLsMQjL0r
        ale9RlO+OeXn67AaYYokAGjJR97Zg4Etah8s4XQzXOtJwRhaOaHgXwoOR0szhF1UpCkx4/
        alkoCjUyP5TlAmmgcYuaYzYxYK8j3ZgTEgQwUuli6ov3DrOeN0uTx5PKsH/avw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698694154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=okhxQnUhQwZrbcdUo7XXc56UihUKqv6O8qJ7nxX4PVE=;
        b=zFOsaRvRMQAnYrWgBRCI2JmVbPJt7TDD6BVd6QW+l09Vh+xA2ZroG0fVwI53jasucJNFWr
        /3KnCuuhvsW6sQCQ==
To:     Sunil V L <sunilvl@ventanamicro.com>
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
        Haibo Xu <haibo1.xu@intel.com>
Subject: Re: [RFC PATCH v2 11/21] PCI: MSI: Add helper function to set
 system wide MSI support
In-Reply-To: <ZT/t0UY5rbudhjfH@sunil-laptop>
References: <20231025202344.581132-1-sunilvl@ventanamicro.com>
 <20231025202344.581132-12-sunilvl@ventanamicro.com> <87a5s0yyje.ffs@tglx>
 <ZT/t0UY5rbudhjfH@sunil-laptop>
Date:   Mon, 30 Oct 2023 20:29:13 +0100
Message-ID: <874ji7zz7a.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 30 2023 at 23:24, Sunil V. L. wrote:
> On Mon, Oct 30, 2023 at 03:28:53PM +0100, Thomas Gleixner wrote:
> Just noting related discussion :
> https://www.spinics.net/lists/linux-serial/msg57616.html
>
> The MSI controller on RISC-V (IMSIC) is optional for the platform. So,
> when by default pci_msi_enable = 1 and the MSI controller is not
> discovered, we get stack trace like below.

<SNIP>

> So, what I did was, by default call pci_no_msi() to disable MSI and then
> call pci_set_msi() to enable when MSI controller is probed.

Your taste sensors should have gone out of range ...

> But I think Bjorn's suggestion to depend on PCI_BUS_FLAGS_NO_MSI may be
> better idea. In that case, we need to set bridge->msi_domain to true in
> pci_create_root_bus(). Let me know what do you prefer or if I am
> completely missing something here.

That's definitely more sensible, but as I said in the other thread, Marc
is the one who did the PCI core/bridge setup magic and he is definitely
in a better position to answer that bridge->msi_domain question.

Thanks,

        tglx
