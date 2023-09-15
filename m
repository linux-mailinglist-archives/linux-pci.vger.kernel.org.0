Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866E57A16D5
	for <lists+linux-pci@lfdr.de>; Fri, 15 Sep 2023 09:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbjIOHE7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Sep 2023 03:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjIOHE7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Sep 2023 03:04:59 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848A8E0;
        Fri, 15 Sep 2023 00:04:53 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9CB0DFF802;
        Fri, 15 Sep 2023 07:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694761492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PmvGks0+KQ3RgHLvTFqwqlkwpj3IXsAouo/gs54hY7M=;
        b=ATeOeyhGyvH0B4r2O6LXDZBmWhZoBHS25Y+sjVOm3LOGfmdf309G3G5/Dsq9vEw5uRQ26o
        4a6Azm929v7RYDXOdYiZGF6ijDhZTSjirctpM1veP2IMh0m4aD/f+eOCbk24MfOmdPXixE
        Qy539ox9yt2YhXdN0q0FWzcCohSpKCob2iuCCXB0hyOPu1GtzM4GXqqS869nDxBpuuOhKD
        7216eLLn6HG3srL5EACl03Dwxct7I/63O8Ng+lpF6dKCjsToXs8eAfN6niqiqgRxAAHZ54
        KMbH4GM7kYTJfIkECYtJhLOq0MsbhaOmkCdyQVrjEinZg/f09Ft4J21uhxcrDQ==
Date:   Fri, 15 Sep 2023 09:04:50 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>,
        <robh@kernel.org>
Subject: Re: [PATCH] PCI: of: Fix memory leak when
 of_changeset_create_node() failed
Message-ID: <20230915090450.206657cf@bootlin.com>
In-Reply-To: <1694715351-58279-1-git-send-email-lizhi.hou@amd.com>
References: <1694715351-58279-1-git-send-email-lizhi.hou@amd.com>
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

Hi Lizhi

On Thu, 14 Sep 2023 11:15:51 -0700
Lizhi Hou <lizhi.hou@amd.com> wrote:

> Destroy and free cset when failure happens.
> 
> Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> Reported-by: Herve Codina <herve.codina@bootlin.com>
> Closes: https://lore.kernel.org/all/20230911171319.495bb837@bootlin.com/
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>  drivers/pci/of.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 2af64bcb7da3..67bbfa2fca59 100644

Why this patch alone ?
The issue fixed by this patch is related to the patch 2 in a series under review
  https://lore.kernel.org/linux-kernel/ZQGaSr+G5qu%2F8nJZ@smile.fi.intel.com/
Is the patch 2 in this series already applied by some maintainers ?

You have to fix the patch in the series sending a new iteration of the series.

This patch alone does not make sense.

Otherwise, the modifications to fix the issue seem good.

Regards,
Hervé

> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -663,7 +663,6 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
>  	np = of_changeset_create_node(cset, ppnode, name);
>  	if (!np)
>  		goto failed;
> -	np->data = cset;
>  
>  	ret = of_pci_add_properties(pdev, cset, np);
>  	if (ret)
> @@ -673,12 +672,17 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
>  	if (ret)
>  		goto failed;
>  
> +	np->data = cset;
>  	pdev->dev.of_node = np;
>  	kfree(name);
>  
>  	return;
>  
>  failed:
> +	if (cset) {
> +		of_changeset_destroy(cset);
> +		kfree(cset);
> +	}
>  	if (np)
>  		of_node_put(np);
>  	kfree(name);

