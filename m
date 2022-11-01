Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DFE614537
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 08:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiKAHr5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 03:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiKAHr4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 03:47:56 -0400
Received: from smtp.smtpout.orange.fr (smtp-11.smtpout.orange.fr [80.12.242.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201FF17E2B
        for <linux-pci@vger.kernel.org>; Tue,  1 Nov 2022 00:47:54 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id pm00o8nsx42kJpm00oEoLN; Tue, 01 Nov 2022 08:47:53 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 01 Nov 2022 08:47:53 +0100
X-ME-IP: 86.243.100.34
Message-ID: <67fdf851-961d-2f4b-591f-4939e1937e68@wanadoo.fr>
Date:   Tue, 1 Nov 2022 08:47:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH RFC V2 1/3] of: dynamic: Add of_create_node() and
 of_destroy_node()
To:     Lizhi Hou <lizhi.hou@amd.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, frowand.list@gmail.com, helgaas@kernel.org
Cc:     clement.leger@bootlin.com, max.zhen@amd.com, sonal.santan@amd.com,
        larry.liu@amd.com, brian.xu@amd.com, stefano.stabellini@xilinx.com,
        trix@redhat.com
References: <1665598440-47410-1-git-send-email-lizhi.hou@amd.com>
 <1665598440-47410-2-git-send-email-lizhi.hou@amd.com>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <1665598440-47410-2-git-send-email-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Le 12/10/2022 à 20:13, Lizhi Hou a écrit :
> of_create_node() creates device node and apply to base tree dynamically.
> The parent device node and full name are required for creating the node.
> And the caller can also provide a property array for the node.
> 
> Inside this function, it creates a changeset. Then the new device node
> and properties are added to the changeset and applied to base tree. The
> pointer of this changeset is saved in device node private data.
> 
> of_destroy_node() removes the node created by of_create_node() from the
> base tree and free it. It gets the changeset pointer from device node
> private data and call of_changeset_destroy() to free everything.
> 
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Signed-off-by: Sonal Santan <sonal.santan@amd.com>
> Signed-off-by: Max Zhen <max.zhen@amd.com>
> Signed-off-by: Brian Xu <brian.xu@amd.com>
> ---
>   drivers/of/dynamic.c | 80 ++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/of.h   |  4 +++
>   2 files changed, 84 insertions(+)
> 
> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> index cd3821a6444f..eca28b723706 100644
> --- a/drivers/of/dynamic.c
> +++ b/drivers/of/dynamic.c
> @@ -934,3 +934,83 @@ int of_changeset_action(struct of_changeset *ocs, unsigned long action,
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(of_changeset_action);
> +
> +/**
> + * of_create_node - Dynamically create a device node and apply it to base tree
> + *
> + * @parent: Pointer to parent device node
> + * @full_name: Full name of device node
> + * @props: Pointer to property array
> + *
> + * Return: Pointer to the created device node or NULL in case of an error.
> + */
> +struct device_node *of_create_node(struct device_node *parent,
> +				   const char *full_name,
> +				   struct property *props)
> +{
> +	struct of_changeset *cset;
> +	struct property *new_pp;
> +	struct device_node *np;
> +	int ret, i;
> +
> +	cset = kzalloc(sizeof(*cset), GFP_KERNEL);

Hi,

kmalloc() would be enough. of_changeset_init() below already calls 
memset().

> +	if (!cset)
> +		return NULL;
> +
> +	of_changeset_init(cset);
> +
> +	np = __of_node_dup(NULL, full_name);
> +	if (!np)
> +		goto failed;

'cset' seems to be leaking if __of_node_dup() fails.

> +	np->parent = parent;
> +
> +	ret = of_changeset_attach_node(cset, np);
> +	if (ret)
> +		goto failed;
> +
> +	if (props) {
> +		for (i = 0; props[i].name; i++) {
> +			new_pp = __of_prop_dup(&props[i], GFP_KERNEL);
> +			if (!new_pp)
> +				goto failed;
> +			ret = of_changeset_add_property(cset, np, new_pp);
> +			if (ret) {
> +				kfree(new_pp->name);
> +				kfree(new_pp->value);
> +				kfree(new_pp);
> +				goto failed;
> +			}
> +		}
> +	}
> +
> +	ret = of_changeset_apply(cset);
> +	if (ret)
> +		goto failed;
> +
> +	np->data = cset;
> +
> +	return np;
> +
> +failed:
> +	of_changeset_destroy(cset);
> +	if (np)
> +		of_node_put(np);
> +
> +	return NULL;
> +}
> +
> +/**
> + * of_destroy_node - Destroy a dynamically created device node
> + *
> + * @np: Pointer to dynamically created device node
> + *
> + */
> +void of_destroy_node(struct device_node *np)
> +{
> +	struct of_changeset *cset;
> +
> +	cset = (struct of_changeset *)np->data;
> +	of_changeset_destroy(cset);
> +	of_node_put(np);
> +	kfree(cset);
> +}
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 766d002bddb9..493ef957c1a8 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -1475,6 +1475,10 @@ extern int of_changeset_revert(struct of_changeset *ocs);
>   extern int of_changeset_action(struct of_changeset *ocs,
>   		unsigned long action, struct device_node *np,
>   		struct property *prop);
> +struct device_node *of_create_node(struct device_node *parent,
> +				   const char *full_name,
> +				   struct property *props);
> +void of_destroy_node(struct device_node *np);
>   
>   static inline int of_changeset_attach_node(struct of_changeset *ocs,
>   		struct device_node *np)

