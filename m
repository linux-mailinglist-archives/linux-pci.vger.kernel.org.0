Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9719D5E933D
	for <lists+linux-pci@lfdr.de>; Sun, 25 Sep 2022 14:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbiIYM5K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 25 Sep 2022 08:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiIYM5J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 25 Sep 2022 08:57:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5D12EF3D;
        Sun, 25 Sep 2022 05:57:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BBD261236;
        Sun, 25 Sep 2022 12:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C1EC433C1;
        Sun, 25 Sep 2022 12:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664110626;
        bh=lpxHGM3HbyqMCrPoY8FSs2HB8+UD8aJ0GkZRmIOLDmY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sNWDG3U16sJyMq7BJ0X0+7OviEfdiWzMG5liH1Sy5pTGzKweGyUWA2noCWtihN1v1
         ImlMKDTjidD0aroE890aMGE/20/DtS8xcwSydVfO9wkb2mNkwj/M/LM/7KqZOvcIIu
         l5Xj9tZNb7khNhgAsVK+e1/jRhGPC2+FeFtsAQF8u/W8OwIyFrObDwpcATXcS5df8+
         4degZxtcJ6jtJSQPbe0SgHBNvzbJXxc2dZ9un+dj0dinVd+UjTOhqFbL/40wTdwHG1
         II2RsPvAI0JFR4WvY3ejvKn//kgX8WmH1nE2IM6I/VEMdCMTu3tBEB3+r4QtPMXUNg
         kiadFPiHrY3Iw==
Date:   Sun, 25 Sep 2022 07:57:04 -0500
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
Message-ID: <20220925125704.GA1529068@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR03MB68772E818ECCE020FEF785DBBC539@SEYPR03MB6877.apcprd03.prod.outlook.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 25, 2022 at 09:52:21AM +0000, Xiaochun XC17 Li wrote:
> > -----Original Message-----
> > From: kernel test robot <lkp@intel.com>
> > Sent: Friday, September 23, 2022 11:21 PM
> > To: Xiaochun Lee <lixiaochun.2888@163.com>;
> > nirmal.patel@linux.intel.com; jonathan.derrick@linux.dev
> > Cc: kbuild-all@lists.01.org; lpieralisi@kernel.org; robh@kernel.org;
> > kw@linux.com; bhelgaas@google.com; linux-pci@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Xiaochun XC17 Li <lixc17@lenovo.com>
> > Subject: [External] Re: [PATCH v1] PCI: Set no io resource for bridges that
> > behind VMD controller
> > 
> > Hi Xiaochun,
> > 
> > Thank you for the patch! Yet something to improve:
> > 
> > [auto build test ERROR on helgaas-pci/next] [also build test ERROR on
> > linus/master v6.0-rc6 next-20220923] [If your patch is applied to the wrong
> > git tree, kindly drop us a note.
> Hi, thanks for your reply, this patch is only expected to be applied
> on x86 or x64, actually function "is_vmd()" is just defined in
> arch/x86/include/asm/pci.h, do we need to support it on arch um?

Yes, all possible Kconfig configurations must build cleanly.  You
may have to add additional ifdef tests or an is_vmd() stub.

For future reference, your email reply doesn't follow the usual Linux
mailing list style, so it is unnecessarily hard to read.  In
particular, it lacks the line that shows what you're responding to.
It would look something like this:

  On Fri, Sep 23, 2022 at 11:21PM +0800, kernel test robot wrote:

Here's a sample:
https://lore.kernel.org/r/YyGghUdcrOdrR0ep@smile.fi.intel.com

More background:
https://en.wikipedia.org/wiki/Posting_style#Interleaved_style
