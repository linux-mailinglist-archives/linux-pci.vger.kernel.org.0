Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3866C5555AC
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jun 2022 23:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349125AbiFVVCD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jun 2022 17:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350227AbiFVVCB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jun 2022 17:02:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80402458A;
        Wed, 22 Jun 2022 14:01:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57442618EC;
        Wed, 22 Jun 2022 21:01:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743BAC34114;
        Wed, 22 Jun 2022 21:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655931718;
        bh=gUqIDk7Ba0qQOIDaM2UTR4FtTYRhUbrVOfJDxbaykaA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=R+aYeYbeIXX5/IvS1YjhAGnnZn1CibV9V/6K0a892pHofTa5uNtzusD7TeRzJyE7E
         9f1XVs6pc7J9fRUCGFxCjth9hl5zaaJjmubMk1wkSCihkME8N4wGCw5e5TIOgyPxcS
         QyCic1uhk9U+fMy01Y1PNsHEWNiCYUE0BXr7yCCazN210p2YXinnnrCEQNkZne+FOl
         LyLAZ3MtLvynfcEZI0pvCWkmAruZ/MjbheRyA7CoL702nhowx96d6HRjVh137IJejP
         yeVk2U303Ss3xcdXLH4qmPYQ2xkbrTU3QQeaagq+8tLYhxRLUYqh/fxwB7KZ47+iC6
         wq3Ob1xstqHEg==
Date:   Wed, 22 Jun 2022 16:01:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Li Chen <lchen@ambarella.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: Don't stop EP controller by EP function
Message-ID: <20220622210155.GA1392911@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622040924.113279-1-mie@igel.co.jp>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 22, 2022 at 01:09:24PM +0900, Shunsuke Mie wrote:
> For multi-function endpoint device, an ep function shouldn't stop EP
> controller. Nomally the controller is stopped via configfs.
> 
> Fixes: 349e7a85b25f ("PCI: endpoint: functions: Add an EP function to test PCI")
> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>

Fixed typo and applied with Kishon's ack to pci/endpoint for v5.20, thanks!

> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 5b833f00e980..a5ed779b0a51 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -627,7 +627,6 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
>  
>  	cancel_delayed_work(&epf_test->cmd_handler);
>  	pci_epf_test_clean_dma_chan(epf_test);
> -	pci_epc_stop(epc);
>  	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
>  		epf_bar = &epf->bar[bar];
>  
> -- 
> 2.17.1
> 
