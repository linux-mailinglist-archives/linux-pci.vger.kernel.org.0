Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F78C697185
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 00:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjBNXEW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 18:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbjBNXEM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 18:04:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB8583DB;
        Tue, 14 Feb 2023 15:03:53 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676415738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1TZyqrcMFCLessiMncscuzYoYIAD62aNI8vRDgUPP3k=;
        b=jMzPtUH8cOaAWtyVHBIQ2BbS0NZpRPb60KzK5K9SRz5L30HSvrbDWT7l995RFz+0BgwERa
        zsieuBAGYveJQl1cxKykS1g74XZGSdJj1hjpERTUqX89YohcB3BrnA/YTGBAD1drcQdgFc
        n8TD1RE4LAOGJV0XURmMIc3bhUPB4uJM5MelYIphtPFHJr2whhkMjkgV+y6k/8sMfUNIt1
        7ozxNEn5Cy/OPFBuKy7ZJLnkGn+pXH25WQr0zZdBXza+2PifozLHut8kwcsMa9lqDQ0jZW
        rXTMjyGHT0/e0ymqr77qM5vcA0SDlSUSYFNq7mg84/JGaHBlrbVUh3fx+77xLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676415738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1TZyqrcMFCLessiMncscuzYoYIAD62aNI8vRDgUPP3k=;
        b=giWIrphHr/qvN3KE3qcAtDFYG0NVvPtd6fRhLnGlV4NUj+LGCINAQ7Utf3Z0PnZ/wApjc7
        9BXt+4Ii3Ay/WuAA==
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>
Cc:     bhelgaas@google.com, nathan@kernel.org, ndesaulniers@google.com,
        trix@redhat.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kevin.tian@intel.com, darwi@linutronix.de
Subject: Re: [PATCH] PCI: Fix build error when CONFIG_PCI_MSI disabled
In-Reply-To: <20230214222400.GA3089902@bhelgaas>
References: <20230214222400.GA3089902@bhelgaas>
Date:   Wed, 15 Feb 2023 00:02:17 +0100
Message-ID: <87v8k3rgue.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 14 2023 at 16:24, Bjorn Helgaas wrote:
>> Provide definitions for pci_msix_alloc_irq_at() and pci_msix_free_irq() in
>> preparation for users that need to compile when CONFIG_PCI_MSI is
>> disabled.
>
> I think this should have a "Fixes:" tag to connect it with the commit
> that added pci_msix_alloc_irq_at() and pci_msix_free_irq().
>
> Looks like 34026364df8e ("PCI/MSI: Provide post-enable dynamic
> allocation interfaces for MSI-X").
>
> Thomas merged 34026364df8e, so it would be best if he took the fixup
> as well.

I did and miserably failed to Cc you on the notification. Sorry about that.

  https://lore.kernel.org/r/167628749774.4906.17069524905880641563.tip-bot2@tip-bot2

Thanks,

        tglx
