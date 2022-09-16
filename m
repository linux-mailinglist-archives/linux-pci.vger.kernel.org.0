Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E0E5BB4B9
	for <lists+linux-pci@lfdr.de>; Sat, 17 Sep 2022 01:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiIPXPk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Sep 2022 19:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiIPXPf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Sep 2022 19:15:35 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD95C94123;
        Fri, 16 Sep 2022 16:15:33 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id w2so13466226qtv.9;
        Fri, 16 Sep 2022 16:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=xrdApMTq5zOhcCS+8MmLGnmeyIwc3fFgqNMhkenSddo=;
        b=Yxa6Zy4fu8MoQo7sgJ1u3LEI7CbFjP38KiDy7+i1ZYQvXQ10fjXU8Kj7F2i1g1DQSd
         t1MN0w52T1YoNq523H4LtiYvYDrnYdF8nwShg0lRwEyNwQ4JduiYm7KTPvakqoRzIay6
         VsrymLSvnoeK7PbmroS1jQtD8fSa8Q9wwjdKtTaJSXMi7DvnZa+mlEvRFXUduHutsx7n
         0CytAX8aGaVJKYuzvvgjKjyP7cDghKe5YDkvDPjmp3xlC9r5anjWiVOP+cgbMiA62fGE
         jfMQxCKABIwZ24xRcud2C63IRh+vvokRaB+GqBrAEA6V+xbbLzs2cXy4uj8lKOV1U9cC
         iCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=xrdApMTq5zOhcCS+8MmLGnmeyIwc3fFgqNMhkenSddo=;
        b=HkxUAGR7o39nXVg+StV0N6Ovuu7OT7zjXTJv+ebExxDoLQag72voNG39tX1Ng2j/qW
         G9g2xZKN8Hy5/t3DrmaAgtZ4RCSXtNjzHFcu7UfGAYLjczaTRyiFDsDdeSbWPEogtjZf
         Y6dwsE5lYA0d9zJ2E4lyB8EE7Ivl/vbZRTyDmXavSyuLktknQFnKlcfguD3n7lFKmL5e
         dxaCTVJ71zHZH5kOMhWyA6UFegkYClkKpm/WrKJhLov2Q04YV8/jQx2NR58/vjvhUCdJ
         vrIwI/bjz3O6OEWaZKUNv74MBKuRKdxwFJePYBzMmpyF7CV+NiQno0WrLPcFggr295+p
         MDTw==
X-Gm-Message-State: ACrzQf10Yi00x16mzvRtRhzoTGEbk49KVKDs2IZg9qFvqH2U4630PsKd
        OudTeOr2IuJKpNRQ9/uECH0=
X-Google-Smtp-Source: AMsMyM5GKGT92rIYHz8nzFQftpXrtAhLhtGQb555eSbO+Dv/xB+nWtj9CTNsgG3EWY7RWcAN9vFf3g==
X-Received: by 2002:a05:622a:104:b0:35c:cb31:c0d9 with SMTP id u4-20020a05622a010400b0035ccb31c0d9mr6505210qtw.49.1663370132605;
        Fri, 16 Sep 2022 16:15:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:90c9:b1c1:5c9e:9030? ([2600:1700:2442:6db0:90c9:b1c1:5c9e:9030])
        by smtp.gmail.com with ESMTPSA id f16-20020a05620a20d000b006b95b0a714esm6408981qka.17.2022.09.16.16.15.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 16:15:32 -0700 (PDT)
Message-ID: <3c40e495-2474-b7a6-6a5c-7ad29e8324bc@gmail.com>
Date:   Fri, 16 Sep 2022 18:15:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RFC 1/2] of: dynamic: add of_node_alloc()
Content-Language: en-US
To:     Lizhi Hou <lizhi.hou@amd.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, helgaas@kernel.org
Cc:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        max.zhen@amd.com, sonal.santan@amd.com, larry.liu@amd.com,
        brian.xu@amd.com, stefano.stabellini@xilinx.com, trix@redhat.com
References: <1661809417-11370-1-git-send-email-lizhi.hou@amd.com>
 <1661809417-11370-2-git-send-email-lizhi.hou@amd.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <1661809417-11370-2-git-send-email-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/29/22 16:43, Lizhi Hou wrote:
> From: Clément Léger <clement.leger@bootlin.com>
> 
> Add of_node_alloc() which allows to create nodes. The node full_name
> field is allocated as part of the node allocation and the kfree() for
> this field is checked at release time to allow users using their own
> allocated name.
> 
> Signed-off-by: Clément Léger <clement.leger@bootlin.com>
> ---
>  drivers/of/dynamic.c | 50 +++++++++++++++++++++++++++++++++++---------
>  include/linux/of.h   |  7 +++++++
>  2 files changed, 47 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> index cd3821a6444f..0e08283fd4fd 100644
> --- a/drivers/of/dynamic.c
> +++ b/drivers/of/dynamic.c
> @@ -362,10 +362,49 @@ void of_node_release(struct kobject *kobj)
>  	fwnode_links_purge(of_fwnode_handle(node));
>  
>  	kfree(node->full_name);
> +	if (node->full_name != (const char *)(node + 1))
> +		kfree(node->full_name);
> +

Why free node->full_name a second time?

>  	kfree(node->data);k>  	kfree(node);
>  }
>  
> +/**
> + * of_node_alloc - Allocate a node dynamically.
> + * @name:	Node name
> + *
> + * Create a node by dynamically allocating the memory of both the
> + * node structure and the node name & contents. The node's
> + * flags have the OF_DYNAMIC & OF_DETACHED bit set so that we can
> + * differentiate between dynamically allocated nodes and not.
> + *
> + * Return: The newly allocated node or NULL on out of memory error.
> + */
> +struct device_node *of_node_alloc(const char *name)
> +{

The body of this function is already implemented by __of_node_dup(NULL, ...)

> +	struct device_node *node;
> +	int name_len = 0;
> +
> +	if (name)
> +		name_len = strlen(name) + 1;
> +
> +	node = kzalloc(sizeof(*node) + name_len, GFP_KERNEL);
> +	if (!node)
> +		return NULL;
> +
> +	if (name) {
> +		node->full_name = (const char *)(node + 1);
> +		strcpy((char *)node->full_name, name);
> +	}
> +
> +	of_node_set_flag(node, OF_DYNAMIC);
> +	of_node_set_flag(node, OF_DETACHED);
> +	of_node_init(node);
> +
> +	return node;
> +}
> +EXPORT_SYMBOL(of_node_alloc);
> +
>  /**
>   * __of_prop_dup - Copy a property dynamically.
>   * @prop:	Property to copy
> @@ -426,18 +465,9 @@ struct device_node *__of_node_dup(const struct device_node *np,
>  {
>  	struct device_node *node;
>  
> -	node = kzalloc(sizeof(*node), GFP_KERNEL);
> +	node = of_node_alloc(full_name);
>  	if (!node)
>  		return NULL;
> -	node->full_name = kstrdup(full_name, GFP_KERNEL);
> -	if (!node->full_name) {
> -		kfree(node);
> -		return NULL;
> -	}
> -
> -	of_node_set_flag(node, OF_DYNAMIC);
> -	of_node_set_flag(node, OF_DETACHED);
> -	of_node_init(node);
>  
>  	/* Iterate over and duplicate all properties */
>  	if (np) {
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 766d002bddb9..fc71e0355f05 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -1462,6 +1462,8 @@ enum of_reconfig_change {
>  };
>  
>  #ifdef CONFIG_OF_DYNAMIC
> +struct device_node *of_node_alloc(const char *name);
> +
>  extern int of_reconfig_notifier_register(struct notifier_block *);
>  extern int of_reconfig_notifier_unregister(struct notifier_block *);
>  extern int of_reconfig_notify(unsigned long, struct of_reconfig_data *rd);
> @@ -1506,6 +1508,11 @@ static inline int of_changeset_update_property(struct of_changeset *ocs,
>  	return of_changeset_action(ocs, OF_RECONFIG_UPDATE_PROPERTY, np, prop);
>  }
>  #else /* CONFIG_OF_DYNAMIC */
> +static inline struct device_node *of_node_alloc(const char *name)
> +{
> +	return NULL;
> +}
> +
>  static inline int of_reconfig_notifier_register(struct notifier_block *nb)
>  {
>  	return -EINVAL;

