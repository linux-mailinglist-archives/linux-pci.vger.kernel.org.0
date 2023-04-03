Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB1C6D54D7
	for <lists+linux-pci@lfdr.de>; Tue,  4 Apr 2023 00:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbjDCWpW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Apr 2023 18:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbjDCWpV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Apr 2023 18:45:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D0F4229;
        Mon,  3 Apr 2023 15:45:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC11B62CE9;
        Mon,  3 Apr 2023 22:45:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FEF4C433EF;
        Mon,  3 Apr 2023 22:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680561919;
        bh=6UNv3+eqSlkCVjZETzDidbfpnJbVpxsshChed0Ya4sk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gYKvx2yQmRk0QKdVmq6TZO2J9ADw/a5+B90W63mY2lDs9d0TittJCvPYJordwOYQx
         pNDwp04ym5zv/Yg+Drvr9bIzhdVt9/X98hC9zq/v9NG2hDnjxS0wFao7VLVGr5r/0v
         ieRNiS9GSSel464YmlE5nYW+QtcMAEhGvTnTcfKsefTNYicWRTm6y61QJ6Sux9w+u8
         G5bkeu2bTulBTjVu3taqegj/PVyIlhz7Dx+bN+VOpar931ecw4j4aOjpjHsciHp5ew
         a3u1Wx7qM+dQRLL07TcaqyF8b+Vw/E1JAO8sNHWZbjMZFM+B+4IMCPV1pJMXPBCsTG
         GPziX4oAmQolA==
Date:   Mon, 3 Apr 2023 17:45:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Xinghui Li <korantwork@gmail.com>
Cc:     nirmal.patel@linux.intel.com, kbusch@kernel.org,
        jonathan.derrick@linux.dev, lpieralisi@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>
Subject: Re: [PATCH v4] PCI: vmd: Add the module param to adjust MSI mode
Message-ID: <20230403224517.GA3472913@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEm4hYXLNP6pcCj5Av35sRG6kCOF0H3+a7VfTtFfGduMgcXJhA@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Apr 02, 2023 at 11:02:07PM +0800, Xinghui Li wrote:
> On Thu, Mar 30, 2023 at 12:31 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Mar 29, 2023 at 04:57:08PM +0800, Xinghui Li wrote:
> > > On Wed, Mar 29, 2023 at 5:34 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > It would also be nice to include a hint about why a user would choose
> > > > "on" or "off".  What is the performance effect?  What sort of I/O
> > > > scenario would lead you to choose "on" vs "off"?

> > I don't think we need detailed performance numbers, but we need
> > something like:
> >
> >   - "msi_remap=off" improves interrupt handling performance by
> >     avoiding the VMD MSI-X domain interrupt handler
> >
> >   - But "msi_remap=on" is needed when ...?
> >
> In the patch I send in last email, We speculate that the VMD
> Controller aggregate interrupts,
> making the PCIe port less stressed and improving iops. In this
> case(lots of 4k random IO), if we enable the VMD MSI
> remapping, we found the interrupts from VMD Controller's MSI are less
> and the IOPS is much higher.

Great, that's useful information about why users would want to use
this parameter.

Obviously the other half is to mention the reasons why they may not be
able to use it.  If "msi_remap=off" were *always* safe and desirable,
we would just do that unconditionally and there would be no point in a
parameter.

> > > I place the "vmd_config_msi_remap_param" that is VMD MSI-X's mode
> > > param configuring helper front
> > > "vmd_enable_domain". So, It will not change the logic disabling
> > > remapping from ee81ee84f873, such as
> > > "Currently MSI remapping must be enabled in guest passthrough mode".
> > > So, if the user config the wrong type, it will not work, and they can
> > > find it by dmesg.
> >
> > That's kind of a problem.  I'm not in favor of something failing and
> > the user having to debug it via dmesg.  That causes user frustration
> > and problem reports.
>
> What about adding a sysfs node for it in VMD PCI bus dir, which allows
> users to catch VMD's MSI current working mode?

No, a sysfs node is not the answer to this.  If we *can* avoid a
non-working situation, we should avoid it.  If users see a non-working
situation, they will rightly complain, and somebody will have to debug
it.  We don't want that.

> > I don't know what "guest passthrough mode" is.  Can you detect that
> > automatically?
>
> I quote this from the commit ee81ee84f873's comment, it can be detected by the
> logic like this:
> if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
> offset[0] || offset[1])
> I just want to answer your comment: "There's also a hint that some
> virt configs require it."
> This patch will not modify the logic of determining whether MSI
> remapping is enabled
> when running VMD in Guest.

My point is that apparently guest passthrough mode is relevant and
maybe it should be part of the commit log about how this parameter
should be used.

Bjorn
