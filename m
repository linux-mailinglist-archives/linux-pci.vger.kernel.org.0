Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8DC497C1F
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 10:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbiAXJiA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jan 2022 04:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbiAXJh7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jan 2022 04:37:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C85FC06173B;
        Mon, 24 Jan 2022 01:37:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCFFCB80E91;
        Mon, 24 Jan 2022 09:37:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3272DC340E1;
        Mon, 24 Jan 2022 09:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643017076;
        bh=trMMsK0upawtiqHzBj/YBpmQi2sZ2sDGXQLM3jRktag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E5KyOkT94TOrFGTJe/+B9Rsugxiuxl/i2FbuYXMiKAf6rAEYbIIbF2YmX7mG2nE3+
         EkJ3QV+7RrMXXWGSirzg3CrupA6SIKbFdyVB8wsi3+KNpA8nKdzQc/puksFPfAfVqF
         FsIS0kI5QYFXfhYVnijh+/FR3eY6QU1ASEutLQJrTbnvuUf03JKknD9bYf6odfNIPz
         codCfAPX6Gwxm/dxARJPT1oL8KQs22+f6cOPrSWuEZvkGIBLSu03i2lA8/A/ndo/c2
         AnSkfcR3jIOi0JCpQ9lNE7Qly/3Ojg9zlib65x53Cqcg7O/FfM/NS5FMhqbSrND548
         +GY1U6Vyhs+Bw==
Received: by pali.im (Postfix)
        id F2E68A79; Mon, 24 Jan 2022 10:37:52 +0100 (CET)
Date:   Mon, 24 Jan 2022 10:37:52 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 2/2] PCI: rcar: Return all Fs from read which
 triggered an exception
Message-ID: <20220124093752.l2kpenot6wj76753@pali>
References: <20220122221554.196311-1-marek.vasut@gmail.com>
 <20220122221554.196311-2-marek.vasut@gmail.com>
 <20220123153147.sv6eoayxqvqbaa66@pali>
 <7ced7370-1853-b52d-7e04-062d1bf3334c@gmail.com>
 <20220123164936.cmzvkkkuw5chz3ek@pali>
 <9d89314c-8757-8965-0f5d-14fd95669320@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d89314c-8757-8965-0f5d-14fd95669320@gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday 24 January 2022 06:46:47 Marek Vasut wrote:
> On 1/23/22 17:49, Pali Rohár wrote:
> 
> Hi,
> 
> [...]
> 
> > > > I must admit that this patch from its initial version evolved into giant hack...
> > > > https://lore.kernel.org/linux-pci/20210514200549.431275-1-marek.vasut@gmail.com/
> > > > 
> > > > During review of the previous patch I have asked some important
> > > > questions but I have not got any answer to them. So I'm reminding it:
> > > > https://lore.kernel.org/linux-pci/20210805183024.ftdwknkttfwwogks@pali/
> > > > 
> > > > So could please answer what happens when PCIe controller is in some
> > > > non-L* state and either MMIO happen or config read happens or config
> > > > write happens?
> > > 
> > > What kind of non-L state ?
> > 
> > E.g. Hot Reset, Detect, Polling, Configuration or Recovery.
> > 
> > > Do you have some specific test which fails ?
> > 
> > Yes, by putting PCIe controller into one of those states. I have already
> > wrote you in some previous email to trigger hot reset as this is the
> > easiest test and can be done also by userspace (setpci).
> > 
> > Link goes to Recovery state automatically when doing link retraining
> > (e.g. by setting RT bit in PCIe Root Port config space) and from
> > Recovery to Configuration or directly back to L0. So testing this path
> > needs precise timing and repeating it more times to trigger.
> > 
> > So the easiest test is really via PCIe Hot Reset by setting Secondary
> > Bus Reset bit in Bridge Control register of PCIe Root Port. After this
> > is link in Hot Reset and does not go back to L0 until you clear that
> > bit. So in this state you can do all these operations which cause
> > aborts, like calling that kernel function which is reading from config
> > space which belongs to device on the other end of the PCIe link or doing
> > MMIO read / write operation of mapped memory which again belongs to
> > other end of PCIe link.
> > 
> > Or instead of Hot Reset, you can set link disable bit in config space of
> > PCIe Root Port. Then link also would not be in L0 state (until you clear
> > that bit), so again you have lot of time to do same tests.
> 
> Can you give me the exact setpci invocation ? If so, then I can test this
> for you on the hardware.

Call "setpci -s $bdf_root_port BRIDGE_CONTROL" with address of the PCIe
Root Port device (parent of selected device). This will print value of
bridge control register. Logical OR it with value 0x20 (Secondary Bus
Reset Bit) and call "setpci -s $bdf_root_port BRIDGE_CONTROL=$new_value".
After this call is link in the Hot Reset state and you can do any test.
To bring link back, call setpci again with cleared 0x20 bit mask.

Similar test you can done also with setting Link Disable bit (bit 4) in
PCIe Link Control register. Offset to this register is not static and
you can figure it out from lspci -s $bdf_root_port -vv output.
Retrain Link is bit 5 in the same register.
