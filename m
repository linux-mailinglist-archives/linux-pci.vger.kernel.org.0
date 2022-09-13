Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5222B5B7CCC
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 23:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiIMVxE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 17:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiIMVxE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 17:53:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6876D9FF;
        Tue, 13 Sep 2022 14:53:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9093615B0;
        Tue, 13 Sep 2022 21:53:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13FC5C433C1;
        Tue, 13 Sep 2022 21:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663105982;
        bh=Xxpeh83ghyVDcQZqEqOkPGke5vxRqIieah6+QXlXYMc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=m8dxabHFp5ULuP6WVPkdHq/pklVKFakjrmD+SbtwbiclkVePpe6JtwAIIg9ofLhiE
         aLCDo58f47IfpYxG1Dc/pYnE+HhT0q2Uq6w8zqZBo5gZ1Ycq/JPzvmri6zAk22eFE2
         jRXu4hxSxF02khL3LBiUf/WEnXyzrsFD2Fw31SE9jUJYtBmUGTwbRke/fYoLfwiK8b
         ADKQlfqRWd/BgsbHfAJ7Kw39MaxjfDe2llKNOR4iuz3REmytY75UhOUrUwrbVLNhhf
         CYffVsOrkK5xQcJa43+ocqDG7FuzS7IlCZywBl4cOF5Dug/qcxtMGg7b4hYUgVJlu9
         NyaSmZ8RPh8UQ==
Date:   Tue, 13 Sep 2022 16:53:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] PCI: Add standard PCI Config Address macros
Message-ID: <20220913215300.GA626928@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220913212421.yblwhgbd7zpdg5eo@pali>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 13, 2022 at 11:24:21PM +0200, Pali Rohár wrote:
> On Tuesday 13 September 2022 16:11:43 Bjorn Helgaas wrote:
> > On Sun, Sep 11, 2022 at 01:20:22PM +0200, Pali Rohár wrote:
> > > Lot of PCI and PCIe controllers are using standard Config Address for PCI
> > > Configuration Mechanism #1 (as defined inPCI Local Bus Specification) or
> > > its extended version.
> > > 
> > > So introduce new macros PCI_CONF1_ADDRESS() and PCI_CONF1_EXT_ADDRESS() in
> > > new include file linux/pci-conf1.h which can be suitable for PCI and PCIe
> > > controllers which uses this type of access to PCI config space.
> > > 
> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > ---
> > >  include/linux/pci-conf1.h | 51 +++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 51 insertions(+)
> > >  create mode 100644 include/linux/pci-conf1.h
> > 
> > This seems like a nice addition, but it would be nice if we could
> > encapsulate it in drivers/pci.
> > 
> > I know it's parallel to the existing include/linux/pci-ecam.h.  I wish
> > we could encapsulate *that* in drivers/pci, too.  For pci-ecam.h, I
> > think the only things that prevent that are drivers/acpi/pci_mcfg.c,
> > loongarch, and a few arm64 things.
> 
> As these macros describe original Intel x86 API, it can be used also in
> arch/x86 PCI code.

I would love to see that happen, too, and that could be a reason to
put pci-conf.h in include/linux.  But this series doesn't include
that.

> > I guess that's a long-winded way of saying that I think maybe we could
> > put this in drivers/pci/pci.h even though the parallel ECAM stuff is
> > in include/linux/pci-ecam.h.
> 
> Well, if you like this change, let me know where to put those new
> macros, into which file and in which subdirectory, and I can prepare a
> new patch version.

drivers/pci/pci.h

> But doing all those arm64, x86, ACPI cleanup is a huge cross-tree work
> which I'm really not going to do...

Of course not, I didn't suggest or expect that.  What I'm trying to
point out is that I don't think we have very good reasons for
pci-ecam.h to be public.  And therefore, I don't think we need
pci-conf1.h to be next to it.

Unless you want to convert the arch/x86 code to use them as well.  I'm
not asking you to do that either, just that if you *did* do that, it
would be an argument for keeping the macros where you put them.

Bjorn
