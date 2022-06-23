Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB59557F0F
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jun 2022 17:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbiFWPzm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jun 2022 11:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbiFWPze (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jun 2022 11:55:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCEC2E0A3;
        Thu, 23 Jun 2022 08:55:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6112161EA8;
        Thu, 23 Jun 2022 15:55:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E19C3411B;
        Thu, 23 Jun 2022 15:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655999726;
        bh=nQzJZplHc0/Ec1lWYneNbQij/MgioWH/DG89ypcJyRc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XbAbve4X2I83UPs5Fri+9rI5uoH1A0sZYskUqDqYqp7Cq1G9ZF6g61zZTyBdR1chw
         eQoCjC7k4SlaC8O0gF2/Nr9W6p7DvuWriIPp0/411iSTrg/5bTGlLu+RN40Ti3p2w8
         ng+GObXTMOKoZAbErK7KYxhUt8C6PC2E4aGS+qT278rU+Z1O9o4cDjM396rvRb7f6m
         T+Q3Mx/YfQFDl84N8F7zoEQwt4GEfI7ZiyJUXz2HE+hqVw/TWpWWTm6hArUAMfwcEG
         aNGr8wdLGfexldfwLf17d2OjERrOEroA2vckKx/DLthRyp3hp7v5aIlbSgNlQG/3xg
         FtlgQX4cC61QQ==
Date:   Thu, 23 Jun 2022 10:55:24 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frank Li <frank.li@nxp.com>
Cc:     Ren Zhijie <renzhijie2@huawei.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] NTB: EPF: Fix Kconfig dependency
Message-ID: <20220623155524.GA1452766@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB91861EE0E20E9EC71F4C494288B59@PAXPR04MB9186.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 23, 2022 at 03:36:38PM +0000, Frank Li wrote:
> > -----Original Message-----
> > From: Ren Zhijie <renzhijie2@huawei.com>
> > Sent: Thursday, June 23, 2022 3:46 AM
> > To: kishon@ti.com; lpieralisi@kernel.org; kw@linux.com;
> > bhelgaas@google.com; jdmason@kudzu.us; Frank Li <frank.li@nxp.com>
> > Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Ren Zhijie
> > <renzhijie2@huawei.com>
> > Subject: [PATCH -next] NTB: EPF: Fix Kconfig dependency

@Ren, please use a typical subject line for the file, e.g.,

  PCI: endpoint: ...

> > If CONFIG_NTB is not set and CONFIG_PCI_EPF_VNTB is y.
> > 
> > make ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu-, will be failed, like
> > this:
> > 
> > drivers/pci/endpoint/functions/pci-epf-vntb.o: In function
> > `epf_ntb_cmd_handler':
> > pci-epf-vntb.c:(.text+0x95e): undefined reference to `ntb_db_event'
> > pci-epf-vntb.c:(.text+0xa1f): undefined reference to `ntb_link_event'
> > pci-epf-vntb.c:(.text+0xa42): undefined reference to `ntb_link_event'
> > drivers/pci/endpoint/functions/pci-epf-vntb.o: In function `pci_vntb_probe':
> > pci-epf-vntb.c:(.text+0x1250): undefined reference to `ntb_register_device'
> > 
> > The functions ntb_*() are defined in drivers/ntb/core.c, which need
> > CONFIG_NTB setting y to be build-in.
> > To fix this build error, add depends on NTB.
> > 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Fixes: ff32fac00d97("NTB: EPF: support NTB transfer between PCI RC and EP
> > connection")
> > Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
> > ---
> [Frank Li] Acked

@Frank: if you use the conventional style, e.g.,
"Acked-by: Frank Li <frank.li@nxp.com>", tooling like b4 will
automatically pick it up.  Just saying "Acked" is likely to get missed
or ignored.
> 
> >  drivers/pci/endpoint/functions/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/pci/endpoint/functions/Kconfig
> > b/drivers/pci/endpoint/functions/Kconfig
> > index 362555b024e8..9beee4f0f4ee 100644
> > --- a/drivers/pci/endpoint/functions/Kconfig
> > +++ b/drivers/pci/endpoint/functions/Kconfig
> > @@ -29,6 +29,7 @@ config PCI_EPF_NTB
> >  config PCI_EPF_VNTB
> >          tristate "PCI Endpoint NTB driver"
> >          depends on PCI_ENDPOINT
> > +        depends on NTB
> >          select CONFIGFS_FS
> >          help
> >            Select this configuration option to enable the Non-Transparent
> > --
> > 2.17.1
> 
