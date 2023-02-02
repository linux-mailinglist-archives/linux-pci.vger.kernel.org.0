Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE88D688845
	for <lists+linux-pci@lfdr.de>; Thu,  2 Feb 2023 21:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjBBUap (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Feb 2023 15:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjBBUao (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Feb 2023 15:30:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B03C69520
        for <linux-pci@vger.kernel.org>; Thu,  2 Feb 2023 12:30:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA37861CC9
        for <linux-pci@vger.kernel.org>; Thu,  2 Feb 2023 20:30:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A0BC433EF;
        Thu,  2 Feb 2023 20:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675369842;
        bh=tJfnJGWI3fvJ8uh8PcBxxuQHrKbnBtCLtuVlDujdzdc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Cc9mkNZEk2iGEjJEuFKH4BKIg2i8l3KfVKIR0PX/KDJ3aKnpkOLQ287Gc/o0JwL67
         BIFWnmksn2Dlfc7hvtXRPkBwI0Av2wuugHZRKurNk7bEy52LLBqlpPEx6aHbcSTVft
         8RaJx6NHq6sEyqVrI361v2vgBI32v/wIRwdjIDih23d/5SUjpBX/+sfAsAn+owuQ7R
         HZf9m5xaydHpRXmJBtKDiBgaymE4BgeLrWGglm3/p0NtGyiITwldwUNXT4JpQ8bfRc
         kzXJ/tjl81uU3AFOT4oWMnIGqTkImE/jc+SGjSOA51x4dBrEKwzC92ZBWrwg1OeHFC
         Y1N3KZv4ALRdg==
Date:   Thu, 2 Feb 2023 14:30:40 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V4 1/2] PCI: Omit pci_disable_device() in .shutdown()
Message-ID: <20230202203040.GA1964750@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H5fgG5uV5Zy6BsmwPpuhuog_L11TjWr4A82nbAcmHSj2w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 02, 2023 at 09:27:03PM +0800, Huacai Chen wrote:
> On Thu, Feb 2, 2023 at 2:17 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Feb 01, 2023 at 12:30:17PM +0800, Huacai Chen wrote:

> > > +static void pcie_portdrv_shutdown(struct pci_dev *dev)
> > > +{
> > > +     if (pci_bridge_d3_possible(dev)) {
> > > +             pm_runtime_forbid(&dev->dev);
> > > +             pm_runtime_get_noresume(&dev->dev);
> > > +             pm_runtime_dont_use_autosuspend(&dev->dev);
> > > +     }
> > > +
> > > +     pcie_port_device_remove(dev);
> >
> > Thanks!  I guess you verified that this actually *does* call all the
> > port service .remove() methods, right?  aer_remove(), dpc_remove(),
> > etc?
>
> I have tested, but aer_probe(), dpc_probe() doesn't get called at
> boot, so does aer_remove(), dpc_remove() when poweroff. I haven't got
> the root cause but I will continue to investigate.

We'll only call aer_probe() and dpc_probe() if the port supports those
services and the platform has granted us control of them.  I don't
know if your platform does.  It may support PCIe native hotplug
(pcie_hp_init()) or PME (pcie_pme_init()).

Bjorn
