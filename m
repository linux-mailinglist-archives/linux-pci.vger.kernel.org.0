Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557E74AFEDF
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 22:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbiBIVCX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Feb 2022 16:02:23 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbiBIVCU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Feb 2022 16:02:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F10C033255
        for <linux-pci@vger.kernel.org>; Wed,  9 Feb 2022 13:02:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1135B61B5A
        for <linux-pci@vger.kernel.org>; Wed,  9 Feb 2022 21:02:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032A9C340E7;
        Wed,  9 Feb 2022 21:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644440541;
        bh=WdDdo+IgIdXDJ+cpewwXAcOeRcwMbSOOi5pe/mRxdBs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=scYDivvA1aQL7rKV8xUdPrSQSzS5iWZqMDTiTuHk9bIYO5P87BOWHTvbmYMpYBad5
         IbyKJVWVMbnQdSDQ/t5JeyR0dgFihvMmXUztNicDejQV3qDDlQbGoLgFTDnLj8vdrW
         RqX0+xWO24boza9+z+wvUq6tg2RPNmAK7JS2JlVo4QFGiqzZSgZkN0OplsO527W3w8
         BWBODTT0L+oHUJeb8DAc7c7q1yaFO9MW9yQdC3GaT+VMSezepfnF/1GIJqh04zujU3
         7U4iOeT5SB0iMMxy4xZQxW+JxIy8j639dSZrnoUm3G1x5FMlKC8+z1tVm8FW0TAoiD
         yspxXEOVfYWzg==
Date:   Wed, 9 Feb 2022 15:02:18 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Blazej Kucman <blazej.kucman@linux.intel.com>
Cc:     Nirmal Patel <nirmal.patel@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        linux-pci@vger.kernel.org, Blazej Kucman <blazej.kucman@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        Naveen Naidu <naveennaidu479@gmail.com>,
        Keith Busch <kbusch@kernel.org>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: Re: [Bug 215525] New: HotPlug does not work on upstream kernel
 5.17.0-rc1
Message-ID: <20220209210218.GA587489@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209144102.0000143e@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 09, 2022 at 02:41:02PM +0100, Blazej Kucman wrote:
> On Thu, 3 Feb 2022 09:58:04 -0600
> Bjorn Helgaas <helgaas@kernel.org> wrote:

> > Why were you testing with "pci=nommconf"?  Do you think anybody uses
> > that with VMD and NVMe?
> 
> It was added long time ago when it was useful.

I'm curious about why it was useful.  It suggests a possible MMCONFIG
issue in firmware or in Linux.  If it was a Linux issue, ideally we
would fix that.  If it's a firmware issue, ideally we would work
around it or automatically turn on "pci=nommconf" so the user wouldn't
have to figure that out.

> Bugzilla report can be closed if you don't consider it as regression.

OK, I closed it with the details.  I'm not entirely convinced that
04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe features") was the
right thing, but I'll pursue that elsewhere.

Thanks for your patience in working through this, and sorry for the
hassle it caused you.

Bjorn
