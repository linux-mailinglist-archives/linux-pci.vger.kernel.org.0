Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB0A6258DD
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 11:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiKKKzn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 05:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbiKKKzm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 05:55:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EB0A1B8;
        Fri, 11 Nov 2022 02:55:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CD4661F4B;
        Fri, 11 Nov 2022 10:55:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E807DC433D6;
        Fri, 11 Nov 2022 10:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668164140;
        bh=YgT9HbNnkYoJ9TgXZuI/u/GTK6ynNr2dgWPGMyfleo8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tg5/eFaZwwDS/Pqdk7YLePY85c3r3KXQOjcRK0VOWG/nex26O0uZ5qCkrjN6FuCr1
         oJfKHN92CfYrXN1ZUofQEfQ+AywjGY3WHy600XYP3SHhEFT9ZrwfXecQninr88VAB1
         bbrLu4TF9tHBejUhcRBF0Nwco8oCt/QrIALkR/z3JtQZ6D65YOdIrlX3lH81l6DrPz
         1YaPnWbfkALBmwNp4X1zzaO0byDHp3viRWOoQkzK5DuZcZmlAq+15q30ho4tpGls3m
         dHkdqcc4NxeP5vuIZEfgl1JB+Wwj+Qj8rrrNQOWke0Z/CfNGgsRO1F/p8ytvw7jwRO
         QWY3nZhZ1jSrQ==
Date:   Fri, 11 Nov 2022 11:55:33 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Frank Li <frank.li@nxp.com>
Cc:     "mani@kernel.org" <mani@kernel.org>,
        "allenbh@gmail.com" <allenbh@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "kw@linux.com" <kw@linux.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>
Subject: Re: [EXT] Re: [PATCH v16 4/7] PCI: endpoint: pci-epf-vntb: remove
 unused field epf_db_phy
Message-ID: <Y24qJb9UisCqpdKZ@lpieralisi>
References: <20221102141014.1025893-1-Frank.Li@nxp.com>
 <20221102141014.1025893-5-Frank.Li@nxp.com>
 <Y20Yt7T0bivqUvop@lpieralisi>
 <HE1PR0401MB23317A2372FCE691C230806E88009@HE1PR0401MB2331.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HE1PR0401MB23317A2372FCE691C230806E88009@HE1PR0401MB2331.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:39:12AM +0000, Frank Li wrote:
> > -----Original Message-----
> > From: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Sent: Thursday, November 10, 2022 9:29 AM
> > To: Frank Li <frank.li@nxp.com>
> > Cc: mani@kernel.org; allenbh@gmail.com; bhelgaas@google.com;
> > dave.jiang@intel.com; helgaas@kernel.org; imx@lists.linux.dev;
> > jdmason@kudzu.us; kw@linux.com; linux-kernel@vger.kernel.org; linux-
> > pci@vger.kernel.org; ntb@lists.linux.dev
> > Subject: [EXT] Re: [PATCH v16 4/7] PCI: endpoint: pci-epf-vntb: remove
> > unused field epf_db_phy
> > 
> > Caution: EXT Email
> > 
> > On Wed, Nov 02, 2022 at 10:10:11AM -0400, Frank Li wrote:
> > > From: Frank Li <frank.li@nxp.com>
> > >
> > > epf_db_phy is not used, so remove it
> > 
> > Sentences end with a period (.). I can fix these things but
> > we can't spend our lives telling you how to write a commit log,
> > check how they are written in the PCI subsystem and follow the
> > pattern.
> 
> [Frank Li] Do you need me send new version to fix "."? Or you will plan

You don't have to write your name in brackets all the time in replies,
it is clear from the indentation what I am replying to and to whom.

> queue these patches?

I will queue them but next time I won't fix the commit log myself.

> My means: 
> Mani's below feedback will make both live easy.

What feedback ? I am sorry I don't understand.

Thank you,
Lorenzo

> 	 > 
>                > None use epf_db_phy and remove it.
> 
>                   "epf_db_phy is not used, so remove it"
> 
>                 >
>                 > 
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.k
> > ernel.org%2Fall%2F20171026223701.GA25649%40bhelgaas-
> > glaptop.roam.corp.google.com&amp;data=05%7C01%7CFrank.Li%40nxp.co
> > m%7Ca0924bed538a494cbfd508dac3304e8e%7C686ea1d3bc2b4c6fa92cd99c
> > 5c301635%7C0%7C0%7C638036909484154968%7CUnknown%7CTWFpbGZsb
> > 3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> > %3D%7C3000%7C%7C%7C&amp;sdata=B3G7sfaSVdLDC8BG95WzpBPFO5lPJ
> > QpThKDcEexOHfU%3D&amp;reserved=0
> 
> [Frank Li] Thank you for your documents.
> 
> > 
> > >
> > > Signed-off-by: Frank Li <frank.li@nxp.com>
> > > Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> > > ---
> > >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > index 191924a83454..ee66101cb5c4 100644
> > > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > @@ -136,7 +136,6 @@ struct epf_ntb {
> > >
> > >       struct epf_ntb_ctrl *reg;
> > >
> > > -     phys_addr_t epf_db_phy;
> > >       void __iomem *epf_db;
> > >
> > >       phys_addr_t vpci_mw_phy[MAX_MW];
> > > --
> > > 2.34.1
> > >
