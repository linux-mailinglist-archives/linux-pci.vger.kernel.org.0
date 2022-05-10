Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414E15225EE
	for <lists+linux-pci@lfdr.de>; Tue, 10 May 2022 22:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiEJUzP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 May 2022 16:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiEJUzN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 May 2022 16:55:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929FC25A78A
        for <linux-pci@vger.kernel.org>; Tue, 10 May 2022 13:55:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAAD2616F0
        for <linux-pci@vger.kernel.org>; Tue, 10 May 2022 20:55:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04DF3C385C8;
        Tue, 10 May 2022 20:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652216111;
        bh=y5KZ01KPhZhlesTIKjKDXWUgsEACasSjVTXo1WYMOaY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cHo/O7jErWjCNI/QnnHlHJgkl2NeA+kU1BxUM+5yu0PGAxoRbghmtlRo8HdCYVAsQ
         mWijdHEY0lj+DHAxL6q/XAhXLyQnYXbgz0a2wtVfJmyusBLOln7GOmgqhoIVS4padZ
         91x+nAHvtuf4HhdcFRT2UG4j2NqtR5XI0uCI3vqler/qU8IwKD5SQCEWSvrJpNWE0i
         wp47XNjgJh10dxClPWmtO+e+flLuljgFnkb4cEHfhmGFPe90rvc9Mf6SD4VwobKWFj
         hd/rzdhiDOpHGQc3GxPLODgP99Z4ku5DNVBqJZO2z9j4iX402TuahCfxv7pg3QAy70
         ux7w+6ogrApbg==
Date:   Tue, 10 May 2022 15:55:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Cyril Brulebois <kibi@debian.org>,
        Jim Quinlan <jim2101024@gmail.com>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>, bjorn@helgaas.com
Subject: Re: [Bug 215925] New: PCIe regression on Raspberry Pi Compute Module
 4 (CM4) breaks booting
Message-ID: <20220510205508.GA704570@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220510200709.vudemjipdvm2tpkq@mraw.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+to Jim, heads-up about reverting commits to avoid the regression]

On Tue, May 10, 2022 at 10:07:09PM +0200, Cyril Brulebois wrote:
> Bjorn Helgaas <helgaas@kernel.org> (2022-05-10):
> > What if you revert 830aa6f29f07 and the subsequent brcmstb patches?
> > 
> >   11ed8b8624b8 ("PCI: brcmstb: Do not turn off WOL regulators on suspend")
> >   93e41f3fca3d ("PCI: brcmstb: Add control of subdevice voltage regulators")
> >   67211aadcb4b ("PCI: brcmstb: Add mechanism to turn on subdev regulators")
> >   830aa6f29f07 ("PCI: brcmstb: Split brcm_pcie_setup() into two funcs")
> > 
> >   $ git revert 11ed8b8624b8 93e41f3fca3d 67211aadcb4b 830aa6f29f07
> > 
> > I did that on current upstream: 9be9ed2612b5 ("Merge tag
> > 'platform-drivers-x86-v5.18-4' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86")
> > and it built fine on x86.
> 
> I've done exactly that, and it boots again. Comparing kernel messages
> against an older version (5.10.106), I'm getting the same output on that
> bare CM4 on CM4 IO Board setup:
> 
>     # dmesg|grep -i pcie
>     [    3.368620] brcm-pcie fd500000.pcie: host bridge /scb/pcie@7d500000 ranges:
>     [    3.368654] brcm-pcie fd500000.pcie:   No bus range found for /scb/pcie@7d500000, using [bus 00-ff]
>     [    3.368703] brcm-pcie fd500000.pcie:      MEM 0x0600000000..0x0603ffffff -> 0x00f8000000
>     [    3.368748] brcm-pcie fd500000.pcie:   IB MEM 0x0000000000..0x003fffffff -> 0x0400000000
>     [    3.421094] brcm-pcie fd500000.pcie: link up, 5.0 GT/s PCIe x1 (SSC)
>     [    3.421341] brcm-pcie fd500000.pcie: PCI host bridge to bus 0000:00
> 
> And with a PCIe → quad-USB board plugged in, I'm getting those
> additional lines:
> 
>     [    3.426842] pcieport 0000:00:00.0: enabling device (0000 -> 0002)
>     [    3.427072] pcieport 0000:00:00.0: PME: Signaling with IRQ 51
>     [    3.427472] pcieport 0000:00:00.0: AER: enabled with IRQ 51
> 
> (It seems to be consistently IRQ 51 with 5.18.0-rc6+ while it seems to
> be consistently IRQ 52 on 5.10.106, but the output is very similar in
> both cases.)
> 
> And plugging a keyboard on one of those USB ports works fine:
> 
>     [   13.406351] input: Logitech USB Keyboard as /devices/platform/scb/fd500000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/usb1/1-1/1-1.2/1-1.2:1.0/0003:046D:C31C.0001/input/input0
>     [   13.510144] input: Logitech USB Keyboard Consumer Control as /devices/platform/scb/fd500000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/usb1/1-1/1-1.2/1-1.2:1.1/0003:046D:C31C.0002/input/input2
>     [   13.591345] input: Logitech USB Keyboard System Control as /devices/platform/scb/fd500000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/usb1/1-1/1-1.2/1-1.2:1.1/0003:046D:C31C.0002/input/input3
> 
> 
> Wrapping up: it boots again (with or without PCIe equipment plugged in),
> and PCIe seems functional.
> 
> I'm happy to test more patches (e.g. trying to fix the actual issue
> without going for a set of reverts).

We're at -rc6 already, but no word from Jim yet.  I think all we can
do at this point is queue up reverts of these patches for v5.18.  The
reverts on now on my for-linus branch.

If we get a fix, I can easily drop the reverts, but I don't want v5.18
to release with PCI completely broken on the Compute Module 4.

Bjorn
