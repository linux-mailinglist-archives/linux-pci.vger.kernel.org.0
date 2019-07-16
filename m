Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74E1A6A459
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2019 10:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfGPI4l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Jul 2019 04:56:41 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:55154 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbfGPI4l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Jul 2019 04:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dS/Tf+oGfMpOmpAoJQ5auE74uVqdveJHNfJTY3m/AjA=; b=WS+VlBKicQi5DpH0FN+SS/RXJ
        +M3eFbxMM36T3I4ArPAw58lfJmUGXGst0vrANBem92wphKbn+kVc7t3IW1tUSy6g4977MNw6m4VTx
        tvjqaibZ6ODbrgz8aULirzdAPl9BpYGNLYejTZQkwx5fh8g/IEskDRueDj/9OtHy+gMGmpq2Gxr2R
        LztQKPVcsGi4ggoGGTYi1c2OY1fNehE9WUvTkcJD2oKWxBolOvjKDl9vi++7P4glK9B7c13vUv96R
        HXDIaG7KCuTbjDAr0COVp8I3MQHFoVbEQaCvLPxLD6G+SF4Pf45GvWSu6F4+ttXylx/RaNO/392zs
        KhvRH4RZg==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:59526)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hnJGF-0001Yk-3u; Tue, 16 Jul 2019 09:56:35 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hnJGB-0000e1-QM; Tue, 16 Jul 2019 09:56:31 +0100
Date:   Tue, 16 Jul 2019 09:56:31 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Grzegorz Jaszczyk <jaz@semihalf.com>, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mw@semihalf.com
Subject: Re: [PATCH] PCI: aardvark: fix big endian support
Message-ID: <20190716085631.yst3kcrxtkh23xtq@shell.armlinux.org.uk>
References: <1563200122-8323-1-git-send-email-jaz@semihalf.com>
 <20190715170840.326acd73@windsurf>
 <20190715151016.6amymuikizmmmsph@shell.armlinux.org.uk>
 <20190716083204.375afc1e@windsurf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716083204.375afc1e@windsurf>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 16, 2019 at 08:32:04AM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> On Mon, 15 Jul 2019 16:10:16 +0100
> Russell King - ARM Linux admin <linux@armlinux.org.uk> wrote:
> 
> > > Also, the advk_pci_bridge_emul_pcie_conf_read() and
> > > advk_pci_bridge_emul_pcie_conf_write() return values that are in the
> > > CPU endianness.
> > > 
> > > Am I missing something ?  
> > 
> > Getting the types correct and then using Sparse to validate the code
> > will help to identify issues exactly like this.
> 
> Yes, I absolutely agree with your recommendation on the other thread.
> 
> In fact, I am wondering if it really makes sense to store the "fake"
> config space in LE, since anyway the read/write accessors should return
> values in the CPU endianness.

Consider:

	u16 vendor;
	u16 device;

and how they are laid out in LE and BE.  Then consider what happens
when you read "vendor" using a u32 accessor.  This is where the
problem lies.

Using host endian means you'd have to read the members using an
appropriately sized host access (in other words, not using a dword
accessor) to end up with the correct result - but we don't want a
large switch() statement here...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
