Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1606E5412
	for <lists+linux-pci@lfdr.de>; Mon, 17 Apr 2023 23:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjDQVpJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Apr 2023 17:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjDQVpE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Apr 2023 17:45:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B22C3;
        Mon, 17 Apr 2023 14:45:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59C566283C;
        Mon, 17 Apr 2023 21:45:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF9EC433D2;
        Mon, 17 Apr 2023 21:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681767902;
        bh=iMvBat6JGoiezpSgSLHgA87p1kUGkTidDfjKAsfHQjk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cn3HDsxT8BxBMy3kfQxTT5VjUDI9HkJz/UpdLLar+xEuC8a7sMaVM9uq64EHYXyxk
         iN6FI0tFJtL2GNDSgVW/VJQ7kMIOC9hBLRKEgZOfE1BQkkgigFVpuR1aj5N+QWe2VP
         XRxfvy4/HafhcPhns24slU5bAckApj4KdeeJbSfhR2VtrBcfYaFvrlocyiZi66Qcu5
         awzaeJNW1BDoChEDGHrdlwlHl/vHbE5bl1Td/Uvnh8g+5mqiCRkZDSoFQREDQZq9eh
         Mh8ucR7pKId6AMHbC+4/1muZHXtcCd8A0BUGp/YGLOfuDSRHFwT4oHjZAN5uRrGLxI
         PW60LCggHum7w==
Date:   Mon, 17 Apr 2023 16:44:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Xinghui Li <korantwork@gmail.com>
Cc:     nirmal.patel@linux.intel.com, kbusch@kernel.org,
        jonathan.derrick@linux.dev, lpieralisi@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>
Subject: Re: [PATCH v4] PCI: vmd: Add the module param to adjust MSI mode
Message-ID: <20230417214459.GA53460@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEm4hYU4Z+LzhC8PT3OTePMeYjDa-QZEfXMkZqODnSY5i+_hrQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 17, 2023 at 05:15:00PM +0800, Xinghui Li wrote:
> Friendly ping~

We had quite a bit of discussion that I don't see reflected in the
latest patch, so we're waiting on a v5 patch that addresses the
comments.

> On Tue, Apr 4, 2023 at 7:02 PM Xinghui Li <korantwork@gmail.com> wrote:
> >
> > On Tue, Apr 4, 2023 at 6:45 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > > In the patch I send in last email, We speculate that the VMD
> > > > Controller aggregate interrupts,
> > > > making the PCIe port less stressed and improving iops. In this
> > > > case(lots of 4k random IO), if we enable the VMD MSI
> > > > remapping, we found the interrupts from VMD Controller's MSI are less
> > > > and the IOPS is much higher.
> > >
> > > Great, that's useful information about why users would want to use
> > > this parameter.
> > >
> > > Obviously the other half is to mention the reasons why they may not be
> > > able to use it.  If "msi_remap=off" were *always* safe and desirable,
> > > we would just do that unconditionally and there would be no point in a
> > > parameter.
> > >
> > > > > > I place the "vmd_config_msi_remap_param" that is VMD MSI-X's mode
> > > > > > param configuring helper front
> > > > > > "vmd_enable_domain". So, It will not change the logic disabling
> > > > > > remapping from ee81ee84f873, such as
> > > > > > "Currently MSI remapping must be enabled in guest passthrough mode".
> > > > > > So, if the user config the wrong type, it will not work, and they can
> > > > > > find it by dmesg.
> > > > >
> > > > > That's kind of a problem.  I'm not in favor of something failing and
> > > > > the user having to debug it via dmesg.  That causes user frustration
> > > > > and problem reports.
> > > >
> > > > What about adding a sysfs node for it in VMD PCI bus dir, which allows
> > > > users to catch VMD's MSI current working mode?
> > >
> > > No, a sysfs node is not the answer to this.  If we *can* avoid a
> > > non-working situation, we should avoid it.  If users see a non-working
> > > situation, they will rightly complain, and somebody will have to debug
> > > it.  We don't want that.
> > emm~
> > I privately suppose: In the traditional way without module parameters,
> > this problem also exists. If the user disables remapping in guest os, the VMD
> > driver will force it to remapping mode.
> > What about I add the additional description in MODULE_PARM_DESC and comment?
> > As for some devices not support disable remapping,  What about changing
> > the param to disabae_bypass=0/1?
> > And make it clear in the description:
> > this parameter will only affect the disabling of bypass mode on
> > devices that support it.
> > >
> > > My point is that apparently guest passthrough mode is relevant and
> > > maybe it should be part of the commit log about how this parameter
> > > should be used.
> > You are right~
> > I will add some clarification on how to configure VMD MSI in the guest.
> > >
> > > Bjorn
