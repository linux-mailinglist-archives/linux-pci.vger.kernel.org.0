Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB8F7B14CF
	for <lists+linux-pci@lfdr.de>; Thu, 28 Sep 2023 09:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjI1H1E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Sep 2023 03:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjI1H1D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Sep 2023 03:27:03 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F154495;
        Thu, 28 Sep 2023 00:27:00 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CF9EC20005;
        Thu, 28 Sep 2023 07:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695886019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y3919oFJXD3Z80tV6szKrbS40xM7VKr5B0qY8vY1KUA=;
        b=BpgMCWn8tz2opVdMbiT3hF/A4kjFLdb5PDjvMeLjoH5vHAxZmt/E7DXNGSy4PdgV9cZDhC
        wdM+cvEC7inO+Ku2aVxTwOMIccVlihoK28yzMj6f/jPFppIhM+s8T6xMPfuENruIG1vgEm
        0TUcBl2HdhtFBuubkQRxgNyQ5RLCCbvva5iywDAM7LZTHum/991LyUsX0VWDbaNkZCr+do
        aHuViRopHgZ1TOG4an8zqTH2CGssR1JVwIjh359+nA+lnEC8qX4G07dh+auKrtp+5sYpkF
        uqv6/ukr/jqBdzoXd7q1V1/mQnMEo+nCetLwua+NiwgYy8rJ2stkyliok99tSg==
Date:   Thu, 28 Sep 2023 09:26:57 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Jonathan.Cameron@Huawei.com>,
        <bhelgaas@google.com>, <robh@kernel.org>
Subject: Re: [PATCH 1/2] PCI: of: Fix memory leak when
 of_changeset_create_node() failed
Message-ID: <20230928092657.5e575202@bootlin.com>
In-Reply-To: <1694801287-17217-1-git-send-email-lizhi.hou@amd.com>
References: <1694801287-17217-1-git-send-email-lizhi.hou@amd.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lizhi,

On Fri, 15 Sep 2023 11:08:06 -0700
Lizhi Hou <lizhi.hou@amd.com> wrote:

> Destroy and free cset when failure happens.
> 
> Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> Reported-by: Herve Codina <herve.codina@bootlin.com>
> Closes: https://lore.kernel.org/all/20230911171319.495bb837@bootlin.com/
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>  drivers/pci/of.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 2af64bcb7da3..498b5cae8bca 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -657,30 +657,33 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
>  
>  	cset = kmalloc(sizeof(*cset), GFP_KERNEL);
>  	if (!cset)
> -		goto failed;
> +		goto failed_alloc_cset;

Usually goto labels indicate what the goto does instead of where we come
from.
https://elixir.bootlin.com/linux/v6.5/source/Documentation/process/coding-style.rst#L536

In this case, it should be "goto failed_free_name".

>  	of_changeset_init(cset);
>  
>  	np = of_changeset_create_node(cset, ppnode, name);
>  	if (!np)
> -		goto failed;
> -	np->data = cset;
> +		goto failed_create_node;

same comment

>  
>  	ret = of_pci_add_properties(pdev, cset, np);
>  	if (ret)
> -		goto failed;
> +		goto failed_add_prop;

same comment

>  
>  	ret = of_changeset_apply(cset);
>  	if (ret)
> -		goto failed;
> +		goto failed_add_prop;

same comment

>  
> +	np->data = cset;
>  	pdev->dev.of_node = np;
>  	kfree(name);
>  
>  	return;
>  
> -failed:
> -	if (np)
> -		of_node_put(np);
> +failed_add_prop:
> +	of_node_put(np);
> +failed_create_node:
> +	of_changeset_destroy(cset);
> +	kfree(cset);
> +failed_alloc_cset:
>  	kfree(name);
>  }
>  #endif

Best regards,
Hervé
