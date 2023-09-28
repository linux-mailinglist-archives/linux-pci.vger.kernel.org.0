Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695FA7B24DC
	for <lists+linux-pci@lfdr.de>; Thu, 28 Sep 2023 20:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjI1SJg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Sep 2023 14:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjI1SJf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Sep 2023 14:09:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922E91AB;
        Thu, 28 Sep 2023 11:09:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA1DC433C7;
        Thu, 28 Sep 2023 18:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695924573;
        bh=2qBfUq7zWGAyojkeyv+y+j9ujXphXt1jcqfOsRztZ7M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SDlyCrs2IAx2RPKXARbhOF1WzFcECuS570OsPH8Xp6oQ66DSJjaYiDm+jsNAqFLsD
         RHHSN6sXYbJZUXj9TJ44QH+vMVF2XbKkBFAN/EdbMvyospNkKiDF8q3vUKSvrDmcWM
         d8cV5FD2Rlec/6KyQ5Lg1qT0o04a0YwdXTQAc+fLpZkFkH7/dD42LRCqOarEnxyg0J
         NoN46F208PEZyXs/IE/eI3RX8Pjza+LTnCLs6bGEPS1baOuvN3jvp5Hxr/MUik01i2
         Q1HcmDYHEK6GSFK8aKbkgixGY4Fj+Jd5kC65tNuNSFrR/iElqra7pdC3b06ztU0IkE
         sVPdZXtUzwG/w==
Date:   Thu, 28 Sep 2023 13:09:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH] PCI: make pci_assign_unassigned_resources() non-init
Message-ID: <20230928180931.GA491945@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925042316.15415-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 24, 2023 at 09:23:16PM -0700, Randy Dunlap wrote:
> Fix a section mismatch warning on Sparc 32-bit:
> 
> WARNING: modpost: vmlinux: section mismatch in reference: leon_pci_init+0xf8 (section: .text) -> pci_assign_unassigned_resources (section: .init.text)
> 
> This is due to this comment from arch/sparc/kernel/leon_pci.c:
>  * The LEON architecture does not rely on a BIOS or bootloader to setup
>  * PCI for us. The Linux generic routines are used to setup resources,
>  * reset values of configuration-space register settings are preserved.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org

Applied to misc for v6.7, thanks!

> ---
>  drivers/pci/setup-bus.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -- a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -2129,7 +2129,7 @@ dump:
>  	pci_bus_dump_resources(bus);
>  }
>  
> -void __init pci_assign_unassigned_resources(void)
> +void pci_assign_unassigned_resources(void)
>  {
>  	struct pci_bus *root_bus;
>  
