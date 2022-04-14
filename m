Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A1D5002E5
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 02:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237030AbiDNAIw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Apr 2022 20:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236524AbiDNAIv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2022 20:08:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B80B3A1BA;
        Wed, 13 Apr 2022 17:06:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7DA0612B3;
        Thu, 14 Apr 2022 00:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7CDC385A6;
        Thu, 14 Apr 2022 00:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649894788;
        bh=/oZgldAb+kOFc1mkeC5QD8ri8CJ5ag/nrlNHuVkziDA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bl2XP9738G3fekEm9DvnSj0Ak9ONkUCpz322IC115aHoFK2x1MFYtdKZnSOprBsHF
         7CF5Y5E6c3IQSDOG0YR8Uydt0dEgbaaUASE/wc/23U7BiSAGSTBNlz/ht5/qvRSoV2
         iY8locAIBJ8EZv8HLAYYAKZd1FryqdOeY2CF413dgpUrLfPMwWXt7dJHuRxygDk7dF
         U9/cnm/VZV0OEO68bVEAtxuUO4DOUFkH6mUFhZKEmEHxPM71VFSOeCgRxpZyey4h6k
         JSjIFvgen/tmu4O/bojdBu4gsD0PDgkEbla9kK0s92I+TFL1RAePlU+ndO12mVTG35
         a2ZJNZy9W31DQ==
Date:   Wed, 13 Apr 2022 19:06:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Avoid handing out address 0 to devices
Message-ID: <20220414000626.GA700213@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2202260044180.25061@angie.orcam.me.uk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Feb 26, 2022 at 10:47:10AM +0000, Maciej W. Rozycki wrote:
> We have numerous platforms that permit assigning addresses from 0 to PCI 
> devices, both in the memory and the I/O bus space, and we happily do so 
> if there is no conflict, e.g.:
> 
> pci 0000:07:00.0: BAR 0: assigned [io  0x0000-0x0007]
> pci 0000:07:00.1: BAR 0: assigned [io  0x0008-0x000f]
> pci 0000:06:01.0: PCI bridge to [bus 07]
> pci 0000:06:01.0:   bridge window [io  0x0000-0x0fff]
> 
> (with the SiFive HiFive Unmatched RISC-V board and a dual serial port 
> option card based on the OxSemi OXPCIe952 device wired for the legacy 
> UART mode).
> 
> Address 0 is treated specially however in many places, for example in 
> `pci_iomap_range' and `pci_iomap_wc_range' we require that the start 
> address is non-zero, and even if we let such an address through, then 
> individual device drivers could reject a request to handle a device at 
> such an address, such as in `uart_configure_port'.  Consequently given
> devices configured as shown above only one is actually usable:

pci_iomap_range() tests the resource start, i.e., the CPU address.  I
guess the implication is that on RISC-V, the CPU-side port address is
the same as the PCI bus port address?

Is that actually a requirement?  Maybe you could also avoid this by
remapping the ports in CPU address space?

Is the same true for PCI memory addresses?  They are identical to CPU
addresses, i.e., no translation is applied?

On the PCI side, zero is a perfectly valid address, so it's a shame to
throw it away if we don't have to, especially since throwing away even
16 bytes of MMIO space means a 4GB 32-bit BAR cannot be mapped at all.

Bjorn
