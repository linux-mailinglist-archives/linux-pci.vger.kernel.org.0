Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46EF4A5EC8
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 16:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239617AbiBAPBp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 10:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235655AbiBAPBo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Feb 2022 10:01:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7DFC061714;
        Tue,  1 Feb 2022 07:01:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A009261639;
        Tue,  1 Feb 2022 15:01:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE575C340EB;
        Tue,  1 Feb 2022 15:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643727703;
        bh=1lsscK2CvDTuGlMIjQLdrV/h85gyYq2WsV5RiWocm3A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DE/PwBR+nmYdXGRwtS5Dn94pMjb86NHd/0AGava6LNh1WUp/z+jof6jz8BhjiSQ+L
         200TmAjfeS+0a4lmRdxOLpLj8uurqKq2l5/PW2CN3FuaN0TXg0Ed2kyU40nTQLwGI5
         L9YY/OCpUeZPNCrCIE6URh9y8MC1X0dtJc0Fg+Vp4QcO65+prPr2KLkRI1J4XTXqrM
         VnaPj0u8TzwRrLg21gYCWGSuH80PBZ41S4ICyQXNK7MV3fVrGpoaw9g3hliI2OYfFj
         ybURLIJlNPH8qS+xdG2/bgMA4b8+cldDiEMy9nL0VUYpbHg3VCKPWUYNAYc/R3XPVw
         oZILFTrgpS03A==
Date:   Tue, 1 Feb 2022 09:01:41 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     marek.vasut@gmail.com
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 2/2] PCI: rcar: Use PCI_SET_ERROR_RESPONSE after read
 which triggered an exception
Message-ID: <20220201150141.GA565205@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129043837.172126-2-marek.vasut@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jan 29, 2022 at 05:38:37AM +0100, marek.vasut@gmail.com wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
> 
> In case the controller is transitioning to L1 in rcar_pcie_config_access(),
> any read/write access to PCIECDR triggers asynchronous external abort. This
> is because the transition to L1 link state must be manually finished by the
> driver. The PCIe IP can transition back from L1 state to L0 on its own.
> 
> The current asynchronous external abort hook implementation restarts
> the instruction which finally triggered the fault, which can be a
> different instruction than the read/write instruction which started
> the faulting access. Usually the instruction which finally triggers
> the fault is one which has some data dependency on the result of the
> read/write. In case of read, the read value after fixup is undefined,
> while a read value of faulting read should be all Fs.

Since the kernel test robot found something to fix, maybe you could
replace "all Fs" with PCI_ERROR_RESPONSE at the same time.

> It is possible to enforce the fault using 'isb' instruction placed
> right after the read/write instruction which started the faulting
> access. Add custom register accessors which perform the read/write
> followed immediately by 'isb'.
> 
> This way, the fault always happens on the 'isb' and in case of read,
> which is located one instruction before the 'isb', it is now possible
> to fix up the return value of the read in the asynchronous external
> abort hook and make that read return all Fs.

And here.

Bjorn
