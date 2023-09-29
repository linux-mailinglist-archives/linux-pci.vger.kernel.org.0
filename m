Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFD67B3877
	for <lists+linux-pci@lfdr.de>; Fri, 29 Sep 2023 19:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjI2RSb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Sep 2023 13:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjI2RSb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Sep 2023 13:18:31 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56952B4;
        Fri, 29 Sep 2023 10:18:28 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8E05E240005;
        Fri, 29 Sep 2023 17:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696007906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HG2dvDUve3uTM4Z7g3W9DUMv+LMY4laZ6mDUP3Xm8vo=;
        b=Skjkzz+JxZ//KdyFOwjlbpudULf17RSn+Xo2plOZ0ngc6NQJCu0WbnKP8RgTKcLNNy1M+x
        +Bt19CM4S2WBesX60Wb8/wGMDigsV8Bw1TmVHEZd7h841smsgMoiLiHkIc8BE0NRlZUggu
        KR3KpbD6L9ZjYZ26clUvHoROL//iB73zR7/dwxXedG6gnfjYqxO93x1Bv+TqWtl2KuAUcm
        Ie3eW5lo6vgCOMX7lwBiVI84e+luInWx/9mgVb1r5rnMqkop/moXEXgK9Ay0eW9Cpfe/y7
        6B1+nkZuFdwy6s1Ly/vGf8+90NVJrVFThSpROvskeLOxhqqTsfgnakQfNgGbOQ==
Date:   Fri, 29 Sep 2023 19:18:24 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Jonathan.Cameron@Huawei.com>,
        <bhelgaas@google.com>, <robh@kernel.org>
Subject: Re: [PATCH v3] PCI: of: Fix memory leak when
 of_changeset_create_node() failed
Message-ID: <20230929191824.25ef93f1@bootlin.com>
In-Reply-To: <1696007417-42059-1-git-send-email-lizhi.hou@amd.com>
References: <1696007417-42059-1-git-send-email-lizhi.hou@amd.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lizhi,

On Fri, 29 Sep 2023 10:10:17 -0700
Lizhi Hou <lizhi.hou@amd.com> wrote:

> In function of_pci_make_dev_node(), the cset needs to be destroyed and
> freed when of_changeset_create_node() returns null.
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
> index 2af64bcb7da3..51e3dd0ea5ab 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -657,30 +657,33 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
>  
>  	cset = kmalloc(sizeof(*cset), GFP_KERNEL);
>  	if (!cset)
> -		goto failed;
> +		goto out_free_name;
>  	of_changeset_init(cset);
>  
>  	np = of_changeset_create_node(cset, ppnode, name);
>  	if (!np)
> -		goto failed;
> -	np->data = cset;
> +		goto out_destroy_cset;
>  
>  	ret = of_pci_add_properties(pdev, cset, np);
>  	if (ret)
> -		goto failed;
> +		goto out_free_node;
>  
>  	ret = of_changeset_apply(cset);
>  	if (ret)
> -		goto failed;
> +		goto out_free_node;
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
> +out_free_node:
> +	of_node_put(np);
> +out_destroy_cset:
> +	of_changeset_destroy(cset);
> +	kfree(cset);
> +out_free_name:
>  	kfree(name);
>  }
>  #endif

Reviewed-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé
