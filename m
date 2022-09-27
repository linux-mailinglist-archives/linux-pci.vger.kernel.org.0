Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4454F5EC898
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 17:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbiI0PxF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 11:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiI0Pwo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 11:52:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A65FCA7A;
        Tue, 27 Sep 2022 08:52:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A093B81C1C;
        Tue, 27 Sep 2022 15:52:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29308C433C1;
        Tue, 27 Sep 2022 15:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664293925;
        bh=N20eC4gWH4sdDQ47K8ZbDdPNZFirAY4KQ+8EeKm1Oz4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pxiKef03WxpUB2KccnVelFMzxPE+2S5sQTWY0Qz1U+N3mN7Vgz4KlAEA+PcFsReW4
         Bzh9kdkLr2Ab8KY4Atpdh53NbwPlemaqjgkwoVBPAtSXGl2fkNh3PFvWz/HMGqrRm5
         yxll688FWuv4B9HR4qVSYgava1ODa4wNFysHRwsJhgWboyPvJg7sESUU7z/lJz0rJe
         a8jnb8en9VlTytozymwRw/ZcEeh3U3chgMbaDONGbNjy/gKwlkYBsS9lb5BGqEg3xZ
         QEWK/Nk6ePfLdK4gsyhXkrNYLQVJaHtn2iwuT1Q9DMG6h8ZKK70CeFf9zyiTdcPiMl
         txa2StHZKMTPw==
Date:   Tue, 27 Sep 2022 10:52:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Xiaochun XC17 Li <lixc17@lenovo.com>
Cc:     kernel test robot <lkp@intel.com>,
        Xiaochun Lee <lixiaochun.2888@163.com>,
        "nirmal.patel@linux.intel.com" <nirmal.patel@linux.intel.com>,
        "jonathan.derrick@linux.dev" <jonathan.derrick@linux.dev>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v1] PCI: Set no io resource for bridges
 that behind VMD controller
Message-ID: <20220927155203.GA1704003@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR03MB6877EF05F0F1320B6EE0B9F9BC559@SEYPR03MB6877.apcprd03.prod.outlook.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 27, 2022 at 02:40:39AM +0000, Xiaochun XC17 Li wrote:
> On Sun, Sep 25, 2022 at 8:57 PM +0800, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Sun, Sep 25, 2022 at 09:52:21AM +0000, Xiaochun XC17 Li wrote:
> > > > -----Original Message-----
> > > > From: kernel test robot <lkp@intel.com>
> > > > Sent: Friday, September 23, 2022 11:21 PM
> > > > To: Xiaochun Lee <lixiaochun.2888@163.com>;
> > > > nirmal.patel@linux.intel.com; jonathan.derrick@linux.dev
> > > > Cc: kbuild-all@lists.01.org; lpieralisi@kernel.org; robh@kernel.org;
> > > > kw@linux.com; bhelgaas@google.com; linux-pci@vger.kernel.org;
> > linux-
> > > > kernel@vger.kernel.org; Xiaochun XC17 Li <lixc17@lenovo.com>
> > > > Subject: [External] Re: [PATCH v1] PCI: Set no io resource for
> > > > bridges that behind VMD controller

> > ...
> > For future reference, your email reply doesn't follow the usual Linux
> > mailing list style, so it is unnecessarily hard to read.  In particular, it lacks
> > the line that shows what you're responding to.
> > It would look something like this:
> > 
> >   On Fri, Sep 23, 2022 at 11:21PM +0800, kernel test robot wrote:
> 
> OK, thanks! 
> I did a test just now, it seems to meet the format requirements.
> I sent emails via outlook, and I've tried to set the reply format, 
> unfortunately, the time zone and date time  are not resolved correctly.

Much better, thanks!  It's much easier to read without all the
redundant headers.

Bjorn
