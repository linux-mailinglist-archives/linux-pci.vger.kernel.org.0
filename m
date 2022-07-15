Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6975768CF
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 23:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiGOVYS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 17:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiGOVYR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 17:24:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D026A40BD4;
        Fri, 15 Jul 2022 14:24:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 823F2B82D13;
        Fri, 15 Jul 2022 21:24:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D43C34115;
        Fri, 15 Jul 2022 21:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657920254;
        bh=AuMf9brf4hFR2Ew3KkReR/9KySRw3UkgCYJXMhCgSTw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jQtVx5Vtz0PYvJyOqsALVQG12LzsNlaojhDx/g309Yr+EZt4Ce3dtEuNPBc3I/ipN
         l5skhM2k3kap1hUAimJ+Od1gwRfQ6ZmBxDZ+OxpjO3n+L1uyCsL5K7L7TkqmDbp82A
         w0lNZWFXrlfis0WtUzn3d14+xruVvDRIM/C1KxmdZ/MxsdTHj9i8lnzhnPzaIekLh8
         QpX0Fig7N1+cNqTwClUGDcVwMvyw+6UG7o+TwEEiwyySq04bYW/MvSGgTnOd+a/VRg
         NxqcaHVf0MJnPlPbi3yuzmGhbMCj6dOGzyCx9PmF/eZOBdRdLerhxA7flJqLyo3XeP
         co8AnU2g/PKgw==
Date:   Fri, 15 Jul 2022 16:24:11 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ren Zhijie <renzhijie2@huawei.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, Jon Mason <jdmason@kudzu.us>,
        kishon@ti.com, lpieralisi@kernel.org, kw@linux.com,
        bhelgaas@google.com, Frank.Li@nxp.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] PCI: endpoint: Fix Kconfig dependency
Message-ID: <20220715212411.GA1192563@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdaf434f-90d5-696f-2a60-5946ecefcf0b@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 09, 2022 at 10:50:53AM +0800, Ren Zhijie wrote:
> Hi, Bjorn and jon
> 
> Just a friendly ping ...
> 
> Is this patch be merged or squashed?

Jon has to take care of this because I don't have the VNTB patches in
my tree.

> > > > > >   drivers/pci/endpoint/functions/Kconfig | 1 +
> > > > > >   1 file changed, 1 insertion(+)
> > > > > > 
> > > > > > diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
> > > > > > index 362555b024e8..9beee4f0f4ee 100644
> > > > > > --- a/drivers/pci/endpoint/functions/Kconfig
> > > > > > +++ b/drivers/pci/endpoint/functions/Kconfig
> > > > > > @@ -29,6 +29,7 @@ config PCI_EPF_NTB
> > > > > >   config PCI_EPF_VNTB
> > > > > >           tristate "PCI Endpoint NTB driver"
> > > > > >           depends on PCI_ENDPOINT
> > > > > > +        depends on NTB
> > > > > >           select CONFIGFS_FS
> > > > > >           help
> > > > > >             Select this configuration option to enable the Non-Transparent
