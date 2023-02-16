Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28116990AB
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 11:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjBPKEz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 05:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjBPKEz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 05:04:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29214DBFD
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 02:04:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7289F61F3A
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 10:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802DAC433D2;
        Thu, 16 Feb 2023 10:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676541891;
        bh=8jNhpWrzi05xmla1MYTwnBp39ByVVJR8xz2DP0KG6Ck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NNqdKmwgvGnhFXMcQkFFazojcRLnqrS/CgBQ4EEDYgLii8mJE3TdNZtX1/7w54LMK
         dn4Kh9uz1aXZqPKgdRWL8GwU7dlw4QEthvgYmxH6bjSJ+qZJZuHMoIYwVxOPxKnR0g
         0sIfUeuPpIXtcGqBCB5nU+Mhsr//Bq6UT1hqM2u+yz4TQcvH24LN1mnHtXfHxk17E2
         BkYWRHS+mhVUuDT77xya/6JSFPoQAoKoKh6y3pNIs+/LUBoZaAwYd+6ipu33JiGzEk
         NKNKB4PMc/NLtFx2BRkXKow8nRmXriilDkvPz0JUZTvKJx7N46T59+UGLfWO9668Ga
         f1/99qINraWtg==
Date:   Thu, 16 Feb 2023 15:34:38 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 01/12] pci: endpoint: Automatically create a function
 type attributes group
Message-ID: <20230216100438.GC2420@thinkpad>
References: <20230215032155.74993-1-damien.lemoal@opensource.wdc.com>
 <20230215032155.74993-2-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230215032155.74993-2-damien.lemoal@opensource.wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 15, 2023 at 12:21:44PM +0900, Damien Le Moal wrote:
> A PCI endpoint function driver can define function specific attributes
> using the add_cfs() endpoint driver operation. However, this attributes
> group is not created automatically when the function is created and
> rather relies on the user creating a directory within the endpoint
> function configfs directory to initialize the attributes.
> 

This is not accurate. An endpoint function will only be created when a
directory is created under /sys/kernel/debug/pci_ep/functions/<func_name>/

Here, func_name is just a debugfs group created during EPF registration and
doesn't represent a function unless a subdirectory is created.

> While working, this approach is dangerous as nothing prevents the user
> from creating multiple directories with differenti (wrong) names that
> all will contain the same attributes.
> 
> Fix this by modifying pci_epf_cfs_work() to execute the new function
> pci_ep_cfs_add_type_group() which itself calls pci_epf_type_add_cfs() to
> obtain the function specific attribute group from the function driver.
> If the function driver defines an attribute group,
> pci_ep_cfs_add_type_group() then proceeds to register this group using
> configfs_register_group(), thus automatically exposing the configfs
> attributes to the user.
> 
> With this change, there is no need for the user to create/delete
> directories in the endpoint function configfs directory. The
> pci_epf_type_group_ops group operations are thus removed.
> 

No. You are just automating the creation of sub-directories specific to
functions such as NTB. Users still need to create a directory to create an
actual endpoint function.

The commit message sounds like it is automating the whole endpoint function
creation which it is not doing.

Thanks,
Mani

> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  drivers/pci/endpoint/pci-ep-cfs.c | 41 ++++++++++++++-----------------
>  1 file changed, 19 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
> index d4850bdd837f..1fb31f07199f 100644
> --- a/drivers/pci/endpoint/pci-ep-cfs.c
> +++ b/drivers/pci/endpoint/pci-ep-cfs.c
> @@ -23,6 +23,7 @@ struct pci_epf_group {
>  	struct config_group group;
>  	struct config_group primary_epc_group;
>  	struct config_group secondary_epc_group;
> +	struct config_group *type_group;
>  	struct delayed_work cfs_work;
>  	struct pci_epf *epf;
>  	int index;
> @@ -502,34 +503,28 @@ static struct configfs_item_operations pci_epf_ops = {
>  	.release		= pci_epf_release,
>  };
>  
> -static struct config_group *pci_epf_type_make(struct config_group *group,
> -					      const char *name)
> -{
> -	struct pci_epf_group *epf_group = to_pci_epf_group(&group->cg_item);
> -	struct config_group *epf_type_group;
> -
> -	epf_type_group = pci_epf_type_add_cfs(epf_group->epf, group);
> -	return epf_type_group;
> -}
> -
> -static void pci_epf_type_drop(struct config_group *group,
> -			      struct config_item *item)
> -{
> -	config_item_put(item);
> -}
> -
> -static struct configfs_group_operations pci_epf_type_group_ops = {
> -	.make_group     = &pci_epf_type_make,
> -	.drop_item      = &pci_epf_type_drop,
> -};
> -
>  static const struct config_item_type pci_epf_type = {
> -	.ct_group_ops	= &pci_epf_type_group_ops,
>  	.ct_item_ops	= &pci_epf_ops,
>  	.ct_attrs	= pci_epf_attrs,
>  	.ct_owner	= THIS_MODULE,
>  };
>  
> +static void pci_ep_cfs_add_type_group(struct pci_epf_group *epf_group)
> +{
> +	struct config_group *group;
> +
> +	group = pci_epf_type_add_cfs(epf_group->epf, &epf_group->group);
> +	if (!group)
> +		return;
> +
> +	if (IS_ERR(group)) {
> +		pr_err("failed to create epf type specific attributes\n");
> +		return;
> +	}
> +
> +	configfs_register_group(&epf_group->group, group);
> +}
> +
>  static void pci_epf_cfs_work(struct work_struct *work)
>  {
>  	struct pci_epf_group *epf_group;
> @@ -547,6 +542,8 @@ static void pci_epf_cfs_work(struct work_struct *work)
>  		pr_err("failed to create 'secondary' EPC interface\n");
>  		return;
>  	}
> +
> +	pci_ep_cfs_add_type_group(epf_group);
>  }
>  
>  static struct config_group *pci_epf_make(struct config_group *group,
> -- 
> 2.39.1
> 

-- 
மணிவண்ணன் சதாசிவம்
