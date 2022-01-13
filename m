Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE2B48DFB7
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jan 2022 22:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbiAMVcd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jan 2022 16:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbiAMVcd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jan 2022 16:32:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF21C061574
        for <linux-pci@vger.kernel.org>; Thu, 13 Jan 2022 13:32:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D007B61B7A
        for <linux-pci@vger.kernel.org>; Thu, 13 Jan 2022 21:32:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F62C36AEA;
        Thu, 13 Jan 2022 21:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642109552;
        bh=ktiPS5ehoPXlCbDZ3usActkugx47A2kyB3Dkqu0DZzw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DD3ILS3SKDVjgBfeyZIe37GsscyIubGkk1Izy48b2JF+d/dThaVBOpNUuUNz34e/Z
         uDl2Qg9OW2pKxzQujJU7qqKldquqB2mJJCSmthBE4Fr5rO1YmDcG7ONGhNWMIvXrQl
         m6KbjoJXjE0cJwKLMXXP/IpuAFxIf0hDfAtl8p83+FpmKE5YrzSVijlRV2x3+sbD+n
         HvzyYMq3KbPQBngaWrApruLD1ITimGmnMCw+0QGQ5D2c7gFNx9Mo2g0DNLgDdjCcQa
         nwTs9sCJ8XNeamn9nZh5FdYLR9V4+nz2eoVuPtK9MnuHoT1+UUwMiYs58CVTV5gX/Z
         xi7bmauSyUS/w==
Date:   Thu, 13 Jan 2022 15:32:30 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stefan Roese <sr@denx.de>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <kbusch@kernel.org>,
        Bharat Kumar Gogada <bharatku@xilinx.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: PCIe AER generates no interrupts on host (ZynqMP)
Message-ID: <20220113213230.GA433650@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aa08fac-369b-096c-8d49-eeb9dd15fa59@denx.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 13, 2022 at 08:13:55AM +0100, Stefan Roese wrote:
> On 1/12/22 18:49, Bjorn Helgaas wrote:

> > Ah.  I assume you have:
> > 
> >    00:00.0 Root Port to [bus 01-??]
> >    01:00.0 Switch Upstream Port to [bus 02-??]
> >    02:0?.0 Switch Downstream Port to [bus 04-??]
> 
> This is correct, yes.
> 
> > pcie_portdrv_probe() claims 00:00.0 and clears CERE NFERE FERE URRE.
> > 
> > aer_probe() claims 00:00.0 and enables CERE NFERE FERE URRE for all
> > downstream devices, including 01:00.0.
> > 
> > pcie_portdrv_probe() claims 01:00.0 and clears CERE NFERE FERE URRE
> > again.
> > 
> > aer_probe() declines to claim 01:00.0 because it's not a Root Port, so
> > CERE NFERE FERE URRE remain cleared.

> I'm baffled a bit, that this problem of AER reporting being disabled in
> the DevCtl regs of PCIe ports (all non root ports) was not noticed for
> this long time. As AER is practically disabled in such setups.

The more common configuration is a Root Port leading directly to an
Endpoint.  In that case, there would be no pcie_portdrv_probe() in the
middle to disable reporting after aer_probe() has enabled it.

The issue you're seeing happens because of the switch in the middle, 
which is becoming more common recently with Thunderbolt.

I poked around on my laptop (Dell 5520 running v5.4):

  00:01.0 Root Port       to [bus 01]          CorrErr-
  01:00.0 NVIDIA GPU                           CorrErr-

  00:1c.0 Root Port       to [bus 02]     AER  CorrErr+
  02:00.0 Intel NIC                       AER  CorrErr-  <-- iwlwifi

  00:1c.1 Root Port       to [bus 03]     AER  CorrErr+
  03:00.0 Realtek card reader             AER  CorrErr-  <-- rtsx_pci

  00:1d.0 Root Port       to [bus 04]     AER  CorrErr+
  04:00.0 NVMe                            AER  CorrErr+

  00:1d.6 Root Port       to [bus 06-3e]  AER  CorrErr+
  06:00.0 Thunderbolt USP to [bus 07-3e]  AER  CorrErr-
  07:00.0 Thunderbolt DSP to [bus 08]     AER  CorrErr-
  ...                                          CorrErr-

Everything in the Thunderbolt hierarchy has reporting disabled,
probably because of the issue you are pointing out.

I can't explain the iwlwifi and rtsx_pci cases.  Both devices have AER
and are directly below a Root Port that also has AER, so I would think
reporting should be enabled.

Bjorn
