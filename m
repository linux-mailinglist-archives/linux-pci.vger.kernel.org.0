Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4143F7A992C
	for <lists+linux-pci@lfdr.de>; Thu, 21 Sep 2023 20:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjIUSLz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Sep 2023 14:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjIUSLQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Sep 2023 14:11:16 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71B6566F4;
        Thu, 21 Sep 2023 10:18:11 -0700 (PDT)
Received: from relay3-d.mail.gandi.net (unknown [217.70.183.195])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 44DA2D2A89;
        Thu, 21 Sep 2023 13:27:08 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 19EC960004;
        Thu, 21 Sep 2023 13:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695302806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kj1DdUWkzlgEljhadlQHHpn2eO93iRvKozJKFFaqhJ8=;
        b=k/IBP72ImwLm+awCTGPrjbS+9xPBl/wQE7MrB0pTrwtdaHL0T3h2bgW/tfGWDJX5/FaUzZ
        ucasGuuEi2qGwTfUXODyhmvGuZPGLxrMiktcTXKLnxyAJb115p2g+RnZ1p2Vn0//jG0AP2
        VJZe3/2LTYjSwv08HPPS7EMm9C910Pm/W8pf/u/tiDR0S6ZRADeJOlRaVqOEFhm4Uixu4U
        NPSruaQ85lvz9znzHKhRpWXFd0aglRj3mpJvbUIxEFvBt3LuimSgHl1XHedffeFwluZjEz
        +v8DwwjSLp26HyR7BGLIzfnGQnkleztC4200qm3Ds7BDgzel0IWUcvAQKLXPmA==
Date:   Thu, 21 Sep 2023 15:26:43 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Lizhi Hou <lizhi.hou@amd.com>, Andrew Lunn <andrew@lunn.ch>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, max.zhen@amd.com,
        sonal.santan@amd.com, stefano.stabellini@xilinx.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH V13 0/5] Generate device tree node for pci devices
Message-ID: <20230921152611.19e07907@bootlin.com>
In-Reply-To: <CAL_JsqKNC1Qv+fucobnzoXmxUYNockWR=BbGhds2tNAYZWqgOA@mail.gmail.com>
References: <1692120000-46900-1-git-send-email-lizhi.hou@amd.com>
        <ZP96feVs2ev7098Y@smile.fi.intel.com>
        <CAL_JsqKfQJFrd8MOdjW55cYdEb8yyPyR+P3ran9+X3dCwUgdyA@mail.gmail.com>
        <ZQGaSr+G5qu/8nJZ@smile.fi.intel.com>
        <20230915193008.6d87b8a0@bootlin.com>
        <ZQf5huX2AMuf9kHC@smile.fi.intel.com>
        <CAL_JsqKNC1Qv+fucobnzoXmxUYNockWR=BbGhds2tNAYZWqgOA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 21 Sep 2023 07:20:46 -0500
Rob Herring <robh@kernel.org> wrote:

> On Mon, Sep 18, 2023 at 2:17 AM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > On Fri, Sep 15, 2023 at 07:30:08PM +0200, Herve Codina wrote:  
> > > On Wed, 13 Sep 2023 14:17:30 +0300
> > > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:  
> > > > On Tue, Sep 12, 2023 at 02:12:04PM -0500, Rob Herring wrote:  
> > > > > On Mon, Sep 11, 2023 at 3:37 PM Andy Shevchenko
> > > > > <andriy.shevchenko@intel.com> wrote:  
> > > > > > On Tue, Aug 15, 2023 at 10:19:55AM -0700, Lizhi Hou wrote:  
> >
> > ...
> >  
> > > > > > Can you point out to the ACPI excerpt(s) of the description of anything related
> > > > > > to the device(s) in question?  
> > > > >
> > > > > I don't understand what you are asking for.  
> > > >
> > > > Through the email thread it was mentioned that this series was tested on the
> > > > ACPI enabled platform, Jonathan (IIRC) asked why do we need to have a shadow
> > > > DT for the something that ACPI already describes. That's why I'm trying to
> > > > understand if it's the case. and if so, how can we improve the approach.  
> > >
> > > Patches from Frank Rowand series [1] are needed to create an of_root_node if a DT
> > > was not provided by the firmware, bootloader, etc that run the kernel.
> > >
> > > [1]: https://lore.kernel.org/lkml/20220624034327.2542112-1-frowand.list@gmail.com/
> > >
> > > Current Lizhi's series creates nodes from the PCI host node during the PCI
> > > enumeration. It creates PCI-PCI bridge and PCI device nodes.
> > >
> > > I use these series on an ACPI system.
> > >
> > > I need one more missing component: the node related to the PCI host bridge
> > > This was the purpose of Clement's work. This work was not sent upstream yet and I
> > > am working on it in order to have a full tree from the of_root to the PCI device
> > > ie:
> > >  of_root                  <-- Frank Rowand series
> > >    + of_host_pci_bridge   <-- Clement's work
> > >        + pci_bridge       <-- Current Lizhi series
> > >            + pci_bridge   <-- Current Lizhi series
> > >             ...
> > >              + pci_dev    <-- Current Lizhi series
> > >
> > > Hope that this status helped.  
> >
> > Thanks for the explanation! I suppose it's better to have three series combined
> > into one and being sent with a better cover letter to explain all this.  
> 
> You can go back (years now) and see that. I asked for this to be split
> up into manageable chunks and not solve multiple problems at once. No
> point in trying to do DT on top of ACPI if DT on top of DT doesn't
> work first.

I agree.

Hervé

> 
> Rob



-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
