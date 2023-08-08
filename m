Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6F07747ED
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 21:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbjHHTWf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 15:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbjHHTWA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 15:22:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3FC10E9C7;
        Tue,  8 Aug 2023 09:45:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 526CE6254B;
        Tue,  8 Aug 2023 13:06:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2DFC433C7;
        Tue,  8 Aug 2023 13:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691499979;
        bh=cRvpYcI51ENCIOzxv8f5XlXNoDaFznNKaW3wW2zr0ow=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A6E7wuFXbhqek+azVh3Uj/E3WW6xluz7q3sP84yJsB2qv+iGQaPjVs4wBy+e+S/To
         XkSdlquUSfO1uKp9oWK2o7UV6fJWQONPEnU1kHpDusthZ0jZdV+YrHV5nYBRJTi/F/
         lmuRk1voPrSp7JLOh6a8/T2ZJYRo7Ib5bHjpBLjj1aCytZFqHGX4gSO3HR/eDY5uCe
         30LLEt8CJPSLp/IiPCwKGk3dShL+BqfxQ7d0r3qRhpchAU+sRSViMoHOfC4fN6Knee
         G0zi+oEi8htuuM5y1qG9meKOZEYv8UboJYiBSNyrFxiWSMXW+mb9BnfTCIPOpCBxxZ
         Ap7e0/uyynO3w==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1qTMPh-0038M0-9S;
        Tue, 08 Aug 2023 14:06:17 +0100
Date:   Tue, 08 Aug 2023 14:06:08 +0100
Message-ID: <867cq5hef3.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anup Patel <anup@brainfault.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robert Moore <robert.moore@intel.com>,
        Haibo Xu <haibo1.xu@intel.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>
Subject: Re: [RFC PATCH v1 11/21] swnode: Add support to create early during boot
In-Reply-To: <20230803175916.3174453-12-sunilvl@ventanamicro.com>
References: <20230803175916.3174453-1-sunilvl@ventanamicro.com> <20230803175916.3174453-12-sunilvl@ventanamicro.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/28.2
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: sunilvl@ventanamicro.com, linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, corbet@lwn.net, paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org, lenb@kernel.org, andriy.shevchenko@linux.intel.com, djrscally@gmail.com, heikki.krogerus@linux.intel.com, sakari.ailus@linux.intel.com, gregkh@linuxfoundation.org, daniel.lezcano@linaro.org, tglx@linutronix.de, anup@brainfault.org, bhelgaas@google.com, robert.moore@intel.com, haibo1.xu@intel.com, ajones@ventanamicro.com, conor.dooley@microchip.com, atishp@rivosinc.com, apatel@ventanamicro.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 03 Aug 2023 18:59:06 +0100,
Sunil V L <sunilvl@ventanamicro.com> wrote:
> 
> From: Anup Patel <apatel@ventanamicro.com>
> 
> swnode framework can be used to create fwnode for interrupt
> controllers. This helps in keeping the drivers same for both
> DT and ACPI. To enable this, enhance the swnode framework so
> that it can be created early during boot without dependency
> on sysfs.

Where is this coming from? We have had common abstractions for
irqchips for a very long time. We can create fwnodes any odd way we
want, but why oh why should we invent another method for that?

We already have multiple architectures such as arm64 and loongarch
already having both DT and ACPI. Do they need another level of
"abstraction"? No. Why is risc-v so special?

	M.

-- 
Without deviation from the norm, progress is not possible.
