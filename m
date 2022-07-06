Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22440567C50
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jul 2022 05:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiGFDIS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jul 2022 23:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbiGFDIR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jul 2022 23:08:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9868F1B791;
        Tue,  5 Jul 2022 20:08:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 340CE619D3;
        Wed,  6 Jul 2022 03:08:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5142EC341C7;
        Wed,  6 Jul 2022 03:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657076894;
        bh=QVsieE1u5SR/xKZTre3ny7IyDuUKUvbKp16x93OZKRI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BDPGhzQeeVZZ1udLY5lJ/DU1YHrP3ZDp3IvmIxJG14GVW9BoI0n6oFKK4UtUsPgmF
         r57NhxVcLliBlNgFHD/35Jq9/wC0fKqpjgntzDFMBeLrDLk/WJiBrw2Lf/MfdWFXqC
         Vas7OR256OIeayzPaeFGn+Uw7VLBQ3gUh9TXv/VP8t68OzneUx7KH8Fv3tOBrglC81
         K5+jCwy0PGHrNpvRuobr8rw7hn7Y/MaJG6JzNQZIbGcUXqbnIvHSmWOZUE0o3HPCbQ
         ZxHHkAU2FZ+P49+gJ702CtIXxivGKwTDJ4uwwVZsIeNyBWmu4wxvOD979PC0uuQtBP
         I7mo7IazM5jOg==
Date:   Tue, 5 Jul 2022 22:08:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Li Chen <lchen@ambarella.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: endpoint: Don't stop EP controller by EP function
Message-ID: <20220706030812.GA109866@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANXvt5qjx6gXhBZD3ndBPCxx++i2oxd5X7=MRgUGrXUj4kRgfw@mail.gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 06, 2022 at 11:37:29AM +0900, Shunsuke Mie wrote:
> 2022年7月6日(水) 7:40 Bjorn Helgaas <helgaas@kernel.org>:
> > On Wed, Jun 22, 2022 at 01:09:24PM +0900, Shunsuke Mie wrote:
> > > For multi-function endpoint device, an ep function shouldn't stop EP
> > > controller. Nomally the controller is stopped via configfs.
> >
> > Can you please clarify this for me?
> >
> > An endpoint function by itself wouldn't stop an endpoint controller.
> > I assume that some *operation* on an endpoint function currently stops
> > the endpoint controller, but that operation should not stop the
> > controller?
> >
> > I guess the operation is an "unbind" that detaches an EPF device from
> > an EPC device?
>
> It is likely that after all of the endpoint functions are unbound, the
> controller can be stopped safely, but I'm not sure if it is desired behavior
> for endpoint framework.

I'm not asking about the patch itself.  I'm asking about the commit
log because "an EP function shouldn't stop EP controller" doesn't
quite make sense in English.

I suspect it should say something like "unbinding one endpoint
function of a multi-function device from the endpoint controller
should not stop the controller."

But I don't know enough about EPF/EPC binding to know whether that
makes sense either.

> Kishon, could you please comment?
> 
> > > Fixes: 349e7a85b25f ("PCI: endpoint: functions: Add an EP function to test PCI")
> > > Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> > > ---
> > >  drivers/pci/endpoint/functions/pci-epf-test.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > index 5b833f00e980..a5ed779b0a51 100644
> > > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > @@ -627,7 +627,6 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
> > >
> > >       cancel_delayed_work(&epf_test->cmd_handler);
> > >       pci_epf_test_clean_dma_chan(epf_test);
> > > -     pci_epc_stop(epc);
> > >       for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
> > >               epf_bar = &epf->bar[bar];
> > >
> > > --
> > > 2.17.1
> > >
> 
> Thanks,
> Shunsuke
