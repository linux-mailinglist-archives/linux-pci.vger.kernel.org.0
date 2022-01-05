Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB97485630
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jan 2022 16:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241677AbiAEPt7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jan 2022 10:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241661AbiAEPt7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jan 2022 10:49:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C107C061245;
        Wed,  5 Jan 2022 07:49:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E8EC6179C;
        Wed,  5 Jan 2022 15:49:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC910C36AE9;
        Wed,  5 Jan 2022 15:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641397798;
        bh=uDYG/IJoBKEoZh832BQxUsG+vyQ8MDYSgq+gprMQZjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tWN45LEnYa4XxwE0cD1n4KegcPxZSM9z2lAbWG9UBdGAgXFBg+5YcpOPMGuJUIwMm
         xsL49YKwMER98DdIlcm30OeFOm0aW9xmE6nbry7vpR6aHBGPCxUCqlWCrV5ZPXYq5j
         s/xoe+ecZ0c5p9Fa/4WPcEP/4Ay6B7o0rhKD3ncYX+s/fB4b8ijsz+miGLJajeDvB5
         0ibjN/pn3YIgO/qkvTkVFM4ilEa0MYQip2BPzqeQgy/1waafTPBbOHzu3oOE0oFnn2
         ZckkEYN6Hw2V1yJZbjj4CK4Byiiy/25ISTChN8d2jsD45VsyXIkwCgc1hJT4SZagwo
         JbQYrVIRmW86A==
Received: by pali.im (Postfix)
        id 5035782A; Wed,  5 Jan 2022 16:49:55 +0100 (CET)
Date:   Wed, 5 Jan 2022 16:49:55 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 08/11] PCI: mvebu: Use child_ops API
Message-ID: <20220105154955.lxhnhjgjsiwhuffq@pali>
References: <20220105150239.9628-1-pali@kernel.org>
 <20220105150239.9628-9-pali@kernel.org>
 <CAL_Jsq+1hoAUVOzyOGZ1vVMsChhHJJpzk5HNU4Gi=Luy_8LArA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+1hoAUVOzyOGZ1vVMsChhHJJpzk5HNU4Gi=Luy_8LArA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 05 January 2022 09:41:51 Rob Herring wrote:
> > @@ -347,6 +375,11 @@ static int mvebu_pcie_hw_wr_conf(struct mvebu_pcie_port *port,
> >         return PCIBIOS_SUCCESSFUL;
> >  }
> >
> > +static struct pci_ops mvebu_pcie_child_ops = {
> > +       .read = mvebu_pcie_child_rd_conf,
> > +       .write = mvebu_pcie_child_wr_conf,
> > +};
> > +
> >  /*
> >   * Remove windows, starting from the largest ones to the smallest
> >   * ones.
> > @@ -862,25 +895,12 @@ static int mvebu_pcie_wr_conf(struct pci_bus *bus, u32 devfn,
> >  {
> >         struct mvebu_pcie *pcie = bus->sysdata;
> >         struct mvebu_pcie_port *port;
> > -       int ret;
> >
> >         port = mvebu_pcie_find_port(pcie, bus, devfn);
> >         if (!port)
> >                 return PCIBIOS_DEVICE_NOT_FOUND;
> 
> It would be nice to go from 'bus' to 'bridge' ptr directly, but I
> still had this in my version. I guess a standard RP struct as part of
> decoupling host bridges from RPs would solve this issue.

Hello!

The problem is somewhere else. This driver is misusing bus 0 for doing
non-transparent bus-bridging between multiple PCI domains by registering
roots ports across all domains into domain 0, bus 0. All details are
in this my patch which documents this strange driver behavior:
https://lore.kernel.org/linux-pci/20211125124605.25915-12-pali@kernel.org/

So the correct solution is is split these multidomain mixing and then
every domain would have exactly one root port (as it is designed in HW).
