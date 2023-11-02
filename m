Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FBC7DF201
	for <lists+linux-pci@lfdr.de>; Thu,  2 Nov 2023 13:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjKBMHs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Nov 2023 08:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjKBMHo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Nov 2023 08:07:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBE9D6F;
        Thu,  2 Nov 2023 05:07:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E5EC433C8;
        Thu,  2 Nov 2023 12:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698926861;
        bh=xSE58Aje/v66DeXgYWtNHYfh66tVbkIWO7Rg8XNcywo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tBm5B3hTGS4GZArwtuFrMD/sN7WSCmWjJHJLPCkd41R6u2M5sAXgAFpYNIdRTabEH
         4mLPysXX912aTZQa5o0J1+MhZA0MNZY90D+t1bC5LdkEFma1iDlv6h11Vx7rPD4uCn
         mJ8XRqVbVebOshN+IvuXMoSV83q5aMvJeg31uSEoEnXS2B3kw19uo5MJw/cakHe07t
         odiyzoeXIPAN7t3KXeLcIUlDUefofkA4++ufUq4BK9936QgMXmaDi/zGcU1KALfMCQ
         hRnINZgfeNL5Sk5pD3C/QRM3ZZZsYmxUuyQfOYSrj0waEJ1hZR6S5ZeBSzM62OcjjI
         6Ti6KTn4/O3+Q==
Date:   Thu, 2 Nov 2023 07:07:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Mario Limonciello <mario.limonciello@amd.com>, bhelgaas@google.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Alexander.Deucher@amd.com
Subject: Re: [PATCH 2/2] PCI: Ignore PCIe ports used for tunneling in
 pcie_bandwidth_available()
Message-ID: <20231102120739.GA114661@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102103108.GK17433@black.fi.intel.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 02, 2023 at 12:31:08PM +0200, Mika Westerberg wrote:
> On Wed, Nov 01, 2023 at 08:14:31PM -0500, Mario Limonciello wrote:
> > On 11/1/2023 17:52, Bjorn Helgaas wrote:

> > > Lukas' brief intro in
> > > https://lore.kernel.org/all/20230925141930.GA21033@wunner.de/ really
> > > helped me connect a few dots, because things like
> > > Documentation/admin-guide/thunderbolt.rst assume we already know those
> > > details.
> > 
> > Thanks for sharing that.  If I move the detection mechanism as I suggested
> > above I'll reference some of that as well in the commit message to explain
> > what exactly a tunneled port is.
> 
> I'm not sure it makes sense to explain from the zero all this stuff that
> people can easily look up from the corresponding spec, such as PCIe or
> USB.

I don't know if it needs to be in the commit log.

I mentioned thunderbolt.rst because the text at
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/thunderbolt.rst?id=v6.6#n6
assumes that we know the terms "host router", "host controller",
"router", "tunnel", "connection manager", and I don't think that's a
good assumption in that documentation.

A little bit of introduction based on Lukas' text could improve that.

> There is a good picture in USB4 v2 ch 2.2.3 about paths crossing USB4
> fabric, perhaps reference that one? Or ch 2.2.10.3 that shows how this
> works with PCIe tunneling instead (although they are similar).

Thanks for these!

Bjorn
