Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3B6487DC9
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 21:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiAGUeS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jan 2022 15:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiAGUeS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jan 2022 15:34:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA39C061574
        for <linux-pci@vger.kernel.org>; Fri,  7 Jan 2022 12:34:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CA4E61FF8
        for <linux-pci@vger.kernel.org>; Fri,  7 Jan 2022 20:34:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA67DC36AE9;
        Fri,  7 Jan 2022 20:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641587657;
        bh=O5BxUUd7ntAVkb9/Z3z5KZVAK9xTZX8PV0KGDhF+c1I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YKOWISct/whG5KbRPwF9Wx3CkMsAy1949mawdYGaaawjO24nHAd3o2QXLK6M4Sl7T
         BHpw6khWHHVTFuLYhgj6I/lKNVqSsIPdurXSfkKPLQkaYrCz1FM6F39+szj6rArRuk
         WsH3luckvaLKiQPCZzlNWL9OnnJpKjB7PFhn8tjaqugWU56R+dnpAOTPBuIeBIIzfF
         r4YHvGrzDRZeYg16Of12PzOtp7EhwxNCPkzbhexGJ9ItY+m6+Vnmb6LXgdVQ+Yy/rA
         gCV9UBOLi87m9hMoZLi98uO8mPDy01EE72NEfaqY5rk2MF56NqpwrIjBgJvhlduxmR
         c/5mSAv0oodKQ==
Date:   Fri, 7 Jan 2022 14:34:15 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Stefan Roese <sr@denx.de>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <kbusch@kernel.org>,
        Bharat Kumar Gogada <bharatku@xilinx.com>
Subject: Re: PCIe AER generates no interrupts on host (ZynqMP)
Message-ID: <20220107203415.GA398389@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220107100458.sfqcq7gy6nwwamjt@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 07, 2022 at 11:04:58AM +0100, Pali Rohár wrote:
> Hello! You asked me in another email for comments to this email, so I'm
> replying directly to this email...
> 
> On Tuesday 04 January 2022 10:02:18 Stefan Roese wrote:
> > Hi,
> > 
> > I'm trying to get the Kernel PCIe AER infrastructure to work on my
> > ZynqMP based system. E.g. handle the events (correctable, uncorrectable
> > etc). In my current tests, no AER interrupt is generated though. I'm
> > currently using the "surprise down error status" in the uncorrectable
> > error status register of the connected PCIe switch (PLX / Broadcom
> > PEX8718). Here the bit is correctly logged in the PEX switch
> > uncorrectable error status register but no interrupt is generated
> > to the root-port / system. And hence no AER message(s) reported.

I think the error should also be logged in the Root Port AER
Capability.  And of course the interrupt enable bits in the Root Error
Command register would have to be set.

> > Does any one of you have some ideas on what might be missing? Why are
> > these events not reported to the PCIe rootport driver via IRQ? Might
> > this be a problem of the missing MSI-X support of the ZynqMP? The AER
> > interrupt is connected as legacy IRQ:
> > 
> > cat /proc/interrupts | grep -i aer
> >  58:          0          0          0          0  nwl_pcie:legacy   0 Level
> > PCIe PME, aerdrv

I guess this means whatever INTx the Root Port is using is connected
to IRQ 58?  Can you tell whether that INTx works if a device below the
Root Port uses it?  Or whether it is asserted for PMEs?

> Error events (correctable, non-fatal and fatal) are reported by PCIe
> devices to the Root Complex via PCIe error messages (Message code of TLP
> is set to Error Message) and not via interrupts. Root Port is then
> responsible to "convert" these PCIe error messages to MSI(X) interrupt
> and report it to the system. According to PCIe spec, AER is supported
> only via MSI(X) interrupts, not legacy INTx.

Where does it say that?  PCIe r5.0, sec 6.2.4.1.2 and 6.2.6, both
mention INTx, and the diagram in 6.2.6 even shows possible
platform-specific System Error signaling.

But I doubt Linux is smart enough to configure this correctly for
INTx.  You could experiment by setting the AER control bits with
setpci.

There was some previous discussion, and it even mentions ZynqMP as a
device that has a dedicated non-MSI mechanism for AER signaling:

  https://lore.kernel.org/linux-pci/1533141889-19962-1-git-send-email-bharat.kumar.gogada@xilinx.com/
  https://lore.kernel.org/all/1464242406-20203-1-git-send-email-po.liu@nxp.com/T/#u

But I don't think it went anywhere.

It seems like maybe this *could* be made to work.  

Bjorn
