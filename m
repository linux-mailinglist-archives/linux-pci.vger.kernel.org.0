Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124825185D7
	for <lists+linux-pci@lfdr.de>; Tue,  3 May 2022 15:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236446AbiECNtP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 May 2022 09:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236441AbiECNsr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2022 09:48:47 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D3538BE;
        Tue,  3 May 2022 06:45:14 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id k25-20020a056830169900b00605f215e55dso8330336otr.13;
        Tue, 03 May 2022 06:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=A1UXqOQDWN29yZdWS1MjN+0wL7Zcwams/h1nKwkWFEo=;
        b=dIgx2Rbu+rKSYh5lsWbIsz3IXg4Eugehy4xu0yV+0COEJcO3AK6+G3n97drQtYLl7h
         wdjKiqi8Xq9aZ1s7U3+QQj2CeNInrlwucbE5S5f5HBgCfJVNDMczIB7UvXiJ+KKPvZg+
         PtzwCBfx3rQtYqS7cbXz+iXnGqb1w7o0G4K6/giWD5KGe8PkFwnmyy05oG7Mvh11XejZ
         /tesYL9+arlqQcfnx6q4BfzbG0ej2jDnWQhcfX35cKsqvq0bhEu/YlDdicUZwnk+uZni
         NZdkzK1E1qj2khBer3MsE+n5Z2PslPEtu0A6eMcfQOJgNoQuZKvCxibxPQNhimy4RJ9x
         6JvQ==
X-Gm-Message-State: AOAM531sTE4q2dWo+TYp23F6WV119WCqfkyCW4332wtmZzB0KODB4IOC
        +NVYRrhhg0p5Z+cajMAmuz/AXg0IXQ==
X-Google-Smtp-Source: ABdhPJx+Ei6Zri1G26UsYkOZxJaJg8rp/zmZXmMcL7B1HLketdjL/VdqmjhrlyCAIbhwwyELBrpohA==
X-Received: by 2002:a9d:84f:0:b0:605:e229:3c82 with SMTP id 73-20020a9d084f000000b00605e2293c82mr5911074oty.71.1651585513217;
        Tue, 03 May 2022 06:45:13 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s14-20020a056870e6ce00b000e686d1389fsm6845670oak.57.2022.05.03.06.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 06:45:12 -0700 (PDT)
Received: (nullmailer pid 3523573 invoked by uid 1000);
        Tue, 03 May 2022 13:45:11 -0000
Date:   Tue, 3 May 2022 08:45:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazonni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/3] of: always populate a root node
Message-ID: <YnEx5/ni1ddIFCj9@robh.at.kernel.org>
References: <20220427094502.456111-1-clement.leger@bootlin.com>
 <20220427094502.456111-2-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220427094502.456111-2-clement.leger@bootlin.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 27, 2022 at 11:45:00AM +0200, Clément Léger wrote:
> When enabling CONFIG_OF on a platform where of_root is not populated by
> firmware, we end up without a root node. In order to apply overlays and
> create subnodes of the root node, we need one. This commit creates an
> empty root node if not present.

The existing unittest essentially does the same thing for running the 
tests on non-DT systems. It should be modified to use this support 
instead. Maybe that's just removing the unittest code that set of_root.

I expect Frank will have some comments.

> Co-developed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Clément Léger <clement.leger@bootlin.com>
> ---
>  drivers/of/base.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index e7d92b67cb8a..6b8584c39f73 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -177,6 +177,19 @@ void __init of_core_init(void)
>  		pr_err("failed to register existing nodes\n");
>  		return;
>  	}
> +
> +	if (!of_root) {
> +		of_root = kzalloc(sizeof(*of_root), GFP_KERNEL);
> +		if (!of_root) {
> +			mutex_unlock(&of_mutex);
> +			pr_err("failed to create root node\n");
> +			return;
> +		}
> +
> +		of_root->full_name = "/";
> +		of_node_init(of_root);
> +	}
> +
>  	for_each_of_allnodes(np) {
>  		__of_attach_node_sysfs(np);
>  		if (np->phandle && !phandle_cache[of_phandle_cache_hash(np->phandle)])
> @@ -185,8 +198,7 @@ void __init of_core_init(void)
>  	mutex_unlock(&of_mutex);
>  
>  	/* Symlink in /proc as required by userspace ABI */
> -	if (of_root)
> -		proc_symlink("device-tree", NULL, "/sys/firmware/devicetree/base");
> +	proc_symlink("device-tree", NULL, "/sys/firmware/devicetree/base");
>  }
>  
>  static struct property *__of_find_property(const struct device_node *np,
> -- 
> 2.34.1
> 
> 
