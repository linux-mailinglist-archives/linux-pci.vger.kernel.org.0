Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18577DBBCB
	for <lists+linux-pci@lfdr.de>; Mon, 30 Oct 2023 15:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbjJ3O27 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Oct 2023 10:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbjJ3O26 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Oct 2023 10:28:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3807F9F;
        Mon, 30 Oct 2023 07:28:56 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698676134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HGYwynunSWpp7MY0OO3XJkBFIC76kaNXkC48AoOrAVc=;
        b=HG5UUtFdFYt0Bica1QYIiuNSEnQMtxRj9w+bpsYb3AfvdlKXY7TY7mG0I7mfBNJ26Vb3vH
        ER4H+Nk6g/JJW+Vn/Oi13KEL6TEQLaGby5uQ6JqENOPTd6j2Jmflk+MxodDPQmZZD26+91
        GrnifWswkG3mK1wi/Ks+vRIrhC6i7fLlRRulZxfm8mzbuCumlthapIZTd8RtggLw0yswll
        XBp1pDDuxSh27lbtEBhVahhSXksr9sda76qTJ88Esg4Bwcj203d453C5XBKRoiR5vEavF3
        yZOr9uPr8SsPoXo2eSnlKfAuctUz5lgEeGQpqPKDtf9P6WaWZW8KRQacCl/P3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698676134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HGYwynunSWpp7MY0OO3XJkBFIC76kaNXkC48AoOrAVc=;
        b=QaOIDXiFtF6jCGy9EsLrcRusyaTEH5L7V++quj7q1yHWGNZwm+B08xNgGMCk9CUXz1WMun
        3MLluabPLEJBK5DQ==
To:     Sunil V L <sunilvl@ventanamicro.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
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
        Haibo Xu <haibo1.xu@intel.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: Re: [RFC PATCH v2 11/21] PCI: MSI: Add helper function to set
 system wide MSI support
In-Reply-To: <20231025202344.581132-12-sunilvl@ventanamicro.com>
References: <20231025202344.581132-1-sunilvl@ventanamicro.com>
 <20231025202344.581132-12-sunilvl@ventanamicro.com>
Date:   Mon, 30 Oct 2023 15:28:53 +0100
Message-ID: <87a5s0yyje.ffs@tglx>
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

On Thu, Oct 26 2023 at 01:53, Sunil V. L. wrote:
> Like pci_no_msi() used to disable MSI support, add a function to enable
> system wide MSI support.

Why?

int pci_msi_enable = 1;

So this function makes it more one or what am I missing here?

Thanks,

        tglx
