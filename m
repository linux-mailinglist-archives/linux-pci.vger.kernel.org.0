Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 511F2FC829
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2019 14:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfKNNyE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Nov 2019 08:54:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:55440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbfKNNyE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Nov 2019 08:54:04 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C0652075E;
        Thu, 14 Nov 2019 13:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573739643;
        bh=chRsb111oIkb8Tzn2xgWqviCPKmTcyrTGOQXYvjbrPM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RzUgS6QAWtYQM41uHu/0NEkORyOPiv325Qhmm7647HI3Gp1vfvxwBbT/ANNLl87/e
         u20KA1F4oSl3xM2vUxLtICSGhHdsM4iAM1WjWJbxbCwJHVXx1btx/0hLRQlcSCSKGT
         li4+815TmqcxzSwQPemQnofeF2RPOZqXeYjoe+AQ=
Date:   Thu, 14 Nov 2019 07:54:02 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Oliver O'Halloran <oohall@gmail.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-pci@vger.kernel.org,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: Re: [PATCH] powerpc/powernv: Disable native PCIe port management
Message-ID: <20191114135402.GA200503@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOSf1CHzBJjxOd0f-CZcGPDW6S5GXMvw+6VmzBADJWeP2y1WAQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 15, 2019 at 12:34:50AM +1100, Oliver O'Halloran wrote:
> On Thu, Nov 14, 2019 at 1:31 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > This is fine, but it feels like sort of a blunt instrument.  Is there
> > any practical way to clear pci_host_bridge.native_pcie_hotplug (and
> > native_aer if appropriate) for the PHBs in question? That would also
> > prevent pciehp from binding.
> 
> It is a large hammer, but I don't see a better way to handle it for
> the moment. I had another look and my initial assessment was wrong in
> that it's the portbus driver which claims the MSI rather than pciehp
> itself. The MSI in the PCIe capability is shared between hotplug
> events, PMEs, and BW notifications so to make the portbus concept work
> the portbus driver needs to own the interrupt. Basicly, pnv_php and
> portbus are fundamentally at odds with each other and can't be used
> concurrently.

Yeah, that makes sense.  Is there a Kconfig symbol for pnv_php?  If
so, you could make CONFIG_PCIEPORTBUS unselectable in the first place.

But I'm guessing there isn't such a symbol because you probably want
to be able to build generic kernels that run on machines that *can*
use portdrv as well as on PowerNV.

So I'm find with the patch as posted.

Bjorn
