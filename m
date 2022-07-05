Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D27567A23
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jul 2022 00:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbiGEWkh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jul 2022 18:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiGEWkg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jul 2022 18:40:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000D511C01;
        Tue,  5 Jul 2022 15:40:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81A78B81A2F;
        Tue,  5 Jul 2022 22:40:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10CEC341C7;
        Tue,  5 Jul 2022 22:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657060830;
        bh=hEbghLYblxH/UBauKCEXYAU5I1HKf00F59oiSCPkrcQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=f1DD5lKUgguyL6QxQirLzWNd8mln/EgZOqhXMseu1076pHC1+uGpHJVJAZ+qtMvJ1
         MSxOBEmx9xLyp/Cl9KXdr+achMOVXmjO2jxWQboGXt7BpwgC0nn0PGfWXM2Hg4yqPc
         f2GLYEposMzq9iARoh+wUPT8YDFFszUeJjtkUk3adeJw0eFGR4G8s6GKNSqkw5W0cQ
         8QKbGAedcxz1oV9fQCVyW1wPs5NjsU9hXPF/bZlNECcZhGlvhqQwuWpVt/OB0UydBK
         T2FyGB9Ty+7MN5F1UhirlTy0hf07sTBs1BxvcUrALv6PlXx8OmQ0J/m1SpumTNCwIQ
         xyUDLxhg8SAjg==
Date:   Tue, 5 Jul 2022 17:40:28 -0500
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
Message-ID: <20220705224028.GA90560@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622040924.113279-1-mie@igel.co.jp>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Can you please clarify this for me?

An endpoint function by itself wouldn't stop an endpoint controller.

I assume that some *operation* on an endpoint function currently stops
the endpoint controller, but that operation should not stop the
controller?

I guess the operation is an "unbind" that detaches an EPF device from
an EPC device?

> Fixes: 349e7a85b25f ("PCI: endpoint: functions: Add an EP function to test PCI")
> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
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
