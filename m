Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A401155CDAD
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239613AbiF0UZc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jun 2022 16:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240411AbiF0UZb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jun 2022 16:25:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA3519006;
        Mon, 27 Jun 2022 13:25:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A644861749;
        Mon, 27 Jun 2022 20:25:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6F2C34115;
        Mon, 27 Jun 2022 20:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656361530;
        bh=jpnWZVxb9HV/DtYzyR0zp85pAnSe8Y8gDthm+NamXjk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=McABRWdl8ZU1sUTBJ5QBjSnxP358lySY34thuCaWvZsgfLSzUXUV9s+uTqBNPmP20
         wilfErzbh3hekctCYICSkYl3RnByre5l3RxPl/Ug6Q/wwfc3XfHGyCuHUB+hgIalyZ
         FrT8Fr9HatTgK5WpbDQMCR/ONWYbt55GDGQkwyxMRCh0ZEbnyerWVFfZfcXlrNTg9u
         g7qro3k5WPH58owstLhWZqyH7/DONZ3YxIG2sWLCZ9yV5SMhnOpX+2fNyQZHRfzH0E
         jli66pKVoJak8EpHDRXS4U7KcbszEOwUIcpaOM0TOYOgD/W7IdXuDaOyP7+Y1AA5i0
         L5ij6c9tlS40A==
Date:   Mon, 27 Jun 2022 15:25:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ren Zhijie <renzhijie2@huawei.com>, Jon Mason <jdmason@kudzu.us>
Cc:     kishon@ti.com, lpieralisi@kernel.org, kw@linux.com,
        bhelgaas@google.com, Frank.Li@nxp.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] PCI: endpoint: Fix Kconfig dependency
Message-ID: <20220627202528.GA1775049@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627200750.GA1774052@bhelgaas>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 27, 2022 at 03:07:50PM -0500, Bjorn Helgaas wrote:
> On Mon, Jun 27, 2022 at 02:57:14PM -0500, Bjorn Helgaas wrote:
> > On Fri, Jun 24, 2022 at 09:19:11AM +0800, Ren Zhijie wrote:
> > > If CONFIG_NTB is not set and CONFIG_PCI_EPF_VNTB is y.
> > > 
> > > make ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu-, will be failed, like this:
> > > 
> > > drivers/pci/endpoint/functions/pci-epf-vntb.o: In function `epf_ntb_cmd_handler':
> > > pci-epf-vntb.c:(.text+0x95e): undefined reference to `ntb_db_event'
> > > pci-epf-vntb.c:(.text+0xa1f): undefined reference to `ntb_link_event'
> > > pci-epf-vntb.c:(.text+0xa42): undefined reference to `ntb_link_event'
> > > drivers/pci/endpoint/functions/pci-epf-vntb.o: In function `pci_vntb_probe':
> > > pci-epf-vntb.c:(.text+0x1250): undefined reference to `ntb_register_device'
> > > 
> > > The functions ntb_*() are defined in drivers/ntb/core.c, which need CONFIG_NTB setting y to be build-in.
> > > To fix this build error, add depends on NTB.
> > > 
> > > Reported-by: Hulk Robot <hulkci@huawei.com>
> > > Fixes: ff32fac00d97("NTB: EPF: support NTB transfer between PCI RC and EP connection")
> > > Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
> > > Acked-by: Frank Li <frank.li@nxp.com>
> > 
> > Am I missing something? 
> > 
> >   02:54:01 ~/linux (next)$ git checkout -b wip/ren-endpoint-ntb v5.19-rc1
> >   Switched to a new branch 'wip/ren-endpoint-ntb'
> >   02:54:23 ~/linux (wip/ren-endpoint-ntb)$ b4 am -om/ https://lore.kernel.org/r/20220624011911.164146-1-renzhijie2@huawei.com
> >   02:54:47 ~/linux (wip/ren-endpoint-ntb)$ git am m/20220624_renzhijie2_pci_endpoint_fix_kconfig_dependency.mbx
> >   Applying: PCI: endpoint: Fix Kconfig dependency
> >   error: patch failed: drivers/pci/endpoint/functions/Kconfig:29
> > 
> > Obviously I could fix this manually, but if there's something wrong
> > with your patch posting process, we should fix it.
> 
> Oh, I see the problem.  This patch depends on some other VNTB patch
> that hasn't been merged yet.  That means this fix should be squashed
> into the VNTB patch that adds "config PCI_EPF_VNTB".

Well, I saw *part* of the problem.  This fixes something that is in
-next, added by ff32fac00d97 ("NTB: EPF: support NTB transfer between
PCI RC and EP connection") [1], which was merged by Jon.

So I guess Jon will squash and update his branch or merge the
fixup(s).

(Jon, if you squash, note there are several typos in the commit log:
s/Virtual NTB/virtual NTB/, s/include/includes/, s/3 part/3 parts/,
s/virutal/virtual, s/pci/PCI/, s/BUS/Bus/)

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=ff32fac00d97

> > > ---
> > > v2: Fix some commit message errors
> > > ---
> > >  drivers/pci/endpoint/functions/Kconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
> > > index 362555b024e8..9beee4f0f4ee 100644
> > > --- a/drivers/pci/endpoint/functions/Kconfig
> > > +++ b/drivers/pci/endpoint/functions/Kconfig
> > > @@ -29,6 +29,7 @@ config PCI_EPF_NTB
> > >  config PCI_EPF_VNTB
> > >          tristate "PCI Endpoint NTB driver"
> > >          depends on PCI_ENDPOINT
> > > +        depends on NTB
> > >          select CONFIGFS_FS
> > >          help
> > >            Select this configuration option to enable the Non-Transparent
> > > -- 
> > > 2.17.1
> > > 
