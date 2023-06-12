Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0B472CC37
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jun 2023 19:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbjFLRQa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jun 2023 13:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235831AbjFLRQV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jun 2023 13:16:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504791BEB;
        Mon, 12 Jun 2023 10:16:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E7EE61D90;
        Mon, 12 Jun 2023 17:16:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46911C433D2;
        Mon, 12 Jun 2023 17:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686590170;
        bh=xj3M0zo4cwvRb6WefsPDD+81JYRZMhz/DnqNCxQRyxU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Su/3te6udFJnrcKKH6Bir/diFv2nErdZq2gcb56KDSfmSC3owPdpIbew76DYaLYgi
         VjFFt4DOFYf0xf11/AqMe0qTRwDH2nfV6VJQ9/wgxMeu1PJlCy0KLHJXkecnGRLsSn
         7f9IAz7Pxn0wfBwThYnXnsFqpODCs0DWPVvE8gkbQAoIrP16odilTZoByS9E8g2neS
         pUKcqL5ZHZcYk69xiV8TJhzrgTTI59aeLAunqjfkul/3Gz5VaZ0ec0H5Vx2yx+i5rf
         guP1O6bFhWnVsWw4DUQ0yUaiYWK5+FOI59uDQ/nFUIIcllbcKJTXcfqQbH/dIt9Bj7
         MPYW3jPxXaLxw==
Date:   Mon, 12 Jun 2023 12:16:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v7 00/11] PCI: dwc: Relatively simple fixes and
 cleanups
Message-ID: <20230612171608.GA1339616@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612164124.ytqn5lfeaxds6ywq@mobilestation>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 12, 2023 at 07:41:24PM +0300, Serge Semin wrote:
> On Mon, Jun 12, 2023 at 10:41:27AM -0500, Bjorn Helgaas wrote:
> > On Sun, Jun 11, 2023 at 10:19:54PM +0300, Serge Semin wrote:
> > > It turns out the recent DW PCIe-related patchset was merged in with
> > > several relatively trivial issues left unsettled (noted by Bjorn and
> > > Manivannan). All of these lefovers have been fixed in this patchset.
> > > Namely the series starts with two bug-fixes. The first one concerns the
> > > improper link-mode initialization in case if the CDM-check is enabled. The
> > > second unfortunate mistake I made in the IP-core version type helper. In
> > > particular instead of testing the IP-core version type the macro function
> > > referred to the just IP-core version which obviously wasn't what I
> > > intended.
> > > ...
> 
> > I am unable to do anything with this series.
> > 
> > Google's legal team is reviewing this matter under applicable laws and
> > regulations.
> 
> I don't get it, how come Google gets to decide anything about what to
> do with this patchset?

I am employed by Google, and my Linux work is part of my job
responsibility, so Google sets some boundaries on my activities.

Bjorn
