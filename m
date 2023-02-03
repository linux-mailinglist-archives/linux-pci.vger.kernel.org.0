Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2492068A11F
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 19:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjBCSEA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Feb 2023 13:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjBCSD7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2023 13:03:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3528FB4E
        for <linux-pci@vger.kernel.org>; Fri,  3 Feb 2023 10:03:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C6F561FBE
        for <linux-pci@vger.kernel.org>; Fri,  3 Feb 2023 18:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D329C433D2;
        Fri,  3 Feb 2023 18:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675447436;
        bh=n68JmCMxszY+ezNL8hlnkBN/KpleZYkyvk547kzVE/U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=m9s7cvh6jSrXZOZRdkUSJKd+XJNL1T0AQN+IkzUh13re7Qs4BnIpktoZOAqGJ9dNU
         CMkILQjui/tFERPtMBFbIOlBxVKvcHERkhKCfOWk5aMyIAf6nOp3Peq2aj9bog3mPM
         AzC7pvZdc2d5EsSEIgUmLbQ9A+t93652q3Etg5ZqRE0NnKX+u9UNGat0jWbMu6T3xd
         8Zy9h/3KYiRR7l2fzqVxnVxrfA20BIj8RTfcfIJhrkWcLBq998MlQ0VoWMKrYftgCT
         WaTSErEjco6rJIgDBAls+9ut1sFdm2YAq7A/0XQMJVLi/JHbO6jUMxCaJgw/wFzEyb
         8rZP0Bufo1C2g==
Date:   Fri, 3 Feb 2023 12:03:55 -0600
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
Message-ID: <20230203180355.GA2030524@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H60bmz_oaWj5ZjM9mbcPtm4Z=8xu+FrEmJZ_Xer4WD8rA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 03, 2023 at 12:00:37PM +0800, Huacai Chen wrote:
> Hi, Bjorn,
> 
> On Fri, Feb 3, 2023 at 4:30 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Thu, Feb 02, 2023 at 09:27:03PM +0800, Huacai Chen wrote:
> > > On Thu, Feb 2, 2023 at 2:17 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Wed, Feb 01, 2023 at 12:30:17PM +0800, Huacai Chen wrote:
> >
> > > > > +static void pcie_portdrv_shutdown(struct pci_dev *dev)
> > > > > +{
> > > > > +     if (pci_bridge_d3_possible(dev)) {
> > > > > +             pm_runtime_forbid(&dev->dev);
> > > > > +             pm_runtime_get_noresume(&dev->dev);
> > > > > +             pm_runtime_dont_use_autosuspend(&dev->dev);
> > > > > +     }
> > > > > +
> > > > > +     pcie_port_device_remove(dev);
> > > >
> > > > Thanks!  I guess you verified that this actually *does* call all the
> > > > port service .remove() methods, right?  aer_remove(), dpc_remove(),
> > > > etc?
> > >
> > > I have tested, but aer_probe(), dpc_probe() doesn't get called at
> > > boot, so does aer_remove(), dpc_remove() when poweroff. I haven't got
> > > the root cause but I will continue to investigate.
> >
> > We'll only call aer_probe() and dpc_probe() if the port supports those
> > services and the platform has granted us control of them.  I don't
> > know if your platform does.  It may support PCIe native hotplug
> > (pcie_hp_init()) or PME (pcie_pme_init()).
>
> When I use pcie_ports=native to boot kernel, I verified that
> aer_remove() and pcie_pme_remove() are both called, while DPC and
> HOTPLUG are both not supported.

Great, thank you!
