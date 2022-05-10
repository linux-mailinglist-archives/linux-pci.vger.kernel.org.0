Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D19F522259
	for <lists+linux-pci@lfdr.de>; Tue, 10 May 2022 19:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347964AbiEJR1E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 May 2022 13:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348061AbiEJR1B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 May 2022 13:27:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47180562EA
        for <linux-pci@vger.kernel.org>; Tue, 10 May 2022 10:22:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2B25B81C64
        for <linux-pci@vger.kernel.org>; Tue, 10 May 2022 17:22:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B10C385C2;
        Tue, 10 May 2022 17:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652203365;
        bh=GWylRjms/kidi7h4Oy0wn70MPEovvqtAvRoJ6jzh07Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sjjATE3gw5OQdOWgl2Jg0Iv+wk2KeE0T9B2qORwN32LdVApmi+5PMq8L1Xgmv5MvQ
         FUvMno/MFltgaDdLCfhkFraaxbZWhawTLtheRnHl1yNgEaKNEMeig2zMM/i9qJuR6f
         loHUNqi1wq69oXvpW4zTSennvAux1o7YJQbB5rmmN3KqrvLJ9ufVxbLisxWeA8yeAe
         qkkkYhe/Dt1eHLBu4jOF/O9U18feQK/ibe1/0Q9BzLvmzHgjhkI25Alt39HLqyVdLE
         zzImP2hwoEdInbr+gx31vCCkfu4/oQLAVppimgFjiDJRYWpSn0jaaqsD3BsVXPurSO
         pp6iazKSQ4BhQ==
Date:   Tue, 10 May 2022 12:22:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Cyril Brulebois <kibi@debian.org>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Jim Quinlan <jim2101024@gmail.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>, bjorn@helgaas.com
Subject: Re: [Bug 215925] New: PCIe regression on Raspberry Pi Compute Module
 4 (CM4) breaks booting
Message-ID: <20220510172243.GA684299@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220509174527.zoqhmaxfwo7udezo@mraw.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 09, 2022 at 07:45:27PM +0200, Cyril Brulebois wrote:
> Hi Bjorn,
> 
> Bjorn Helgaas <helgaas@kernel.org> (2022-05-09):
> > Cyril, 830aa6f29f07 ("PCI: brcmstb: Split brcm_pcie_setup() into two
> > funcs") reverts cleanly as of 57ae8a492116.  Does reverting it avoid
> > the regression?
> 
> I didn't even try and revert this commit before you suggested doing so
> since it was supposed to be some preliminary work. Quoting a part of
> its commit message:
> 
>     In future commits the brcm_pcie_linkup() function will be called
>     indirectly by pci_host_probe() as opposed to the host driver
>     invoking it directly.
> 
> 
> Anyway, the patch can indeed be reverted on top of v5.18-rc4 or
> v5.18-rc6 but the build fails due to the former function being removed,
> while being still called from other places:
> 
>       CC      drivers/pci/controller/pcie-brcmstb.o
>     drivers/pci/controller/pcie-brcmstb.c:199:12: warning: ‘brcm_pcie_linkup’ used but never defined
>       199 | static int brcm_pcie_linkup(struct brcm_pcie *pcie);
>           |            ^~~~~~~~~~~~~~~~
>     …
>     aarch64-linux-gnu-ld: drivers/pci/controller/pcie-brcmstb.o: in function `brcm_pcie_add_bus':
>     /home/kibi/hack/linux.git/drivers/pci/controller/pcie-brcmstb.c:527: undefined reference to `brcm_pcie_linkup'
> 
> 
> See for example:
> 
>     commit 93e41f3fca3d4a0f927b784012338c37f80a8a80
>     Author: Jim Quinlan <jim2101024@gmail.com>
>     Date:   Thu Jan 6 11:03:29 2022 -0500
>     
>         PCI: brcmstb: Add control of subdevice voltage regulators
> 
> (And that one cannot be trivially reverted.)

What if you revert 830aa6f29f07 and the subsequent brcmstb patches?

  11ed8b8624b8 ("PCI: brcmstb: Do not turn off WOL regulators on suspend")
  93e41f3fca3d ("PCI: brcmstb: Add control of subdevice voltage regulators")
  67211aadcb4b ("PCI: brcmstb: Add mechanism to turn on subdev regulators")
  830aa6f29f07 ("PCI: brcmstb: Split brcm_pcie_setup() into two funcs")

  $ git revert 11ed8b8624b8 93e41f3fca3d 67211aadcb4b 830aa6f29f07

I did that on current upstream: 9be9ed2612b5 ("Merge tag
'platform-drivers-x86-v5.18-4' of
git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86")
and it built fine on x86.
