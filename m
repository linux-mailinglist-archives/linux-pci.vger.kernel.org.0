Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4049F6D16B7
	for <lists+linux-pci@lfdr.de>; Fri, 31 Mar 2023 07:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjCaFWi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Mar 2023 01:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjCaFWh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Mar 2023 01:22:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C29F77B
        for <linux-pci@vger.kernel.org>; Thu, 30 Mar 2023 22:22:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27C5462331
        for <linux-pci@vger.kernel.org>; Fri, 31 Mar 2023 05:22:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC718C433EF;
        Fri, 31 Mar 2023 05:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680240154;
        bh=627wsYNegh6eQZnBpiwr3dLkA+ywQtZa0rC0yidBnOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qZeCU1GUkkikkekynScDF2vBXI3JzSe4VL07gfbJxGHUdW4+gHIq1QcGTXcXn3C3a
         jBnpTXrE9rMntXsJWNjcDxIwwSAknHM1engc8MRhVbb6DCink91+zifsRfM76Naytr
         5MG34mLlosX/LXdiSktJ476ZVrnALpgYJvffIm8SxpVBYMYX+rrb8RE27SrZBqXIyR
         lly4CJ3Kuhdingoe+ZlxqFFOZTtmBcJSBbPCbceUF0VpLL2oKtopLc/kUnBH3ZFLxj
         CVS3G5FRj6MgmS5hkP3P97wp36MllzZVgH8q5tU27WLmoFGIjplinaEeb+nCrTRui9
         g401ACxT7hfMA==
Date:   Fri, 31 Mar 2023 10:52:20 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 01/17] PCI: endpoint: Automatically create a function
 specific attributes group
Message-ID: <20230331052220.GA4973@thinkpad>
References: <20230330085357.2653599-1-damien.lemoal@opensource.wdc.com>
 <20230330085357.2653599-2-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230330085357.2653599-2-damien.lemoal@opensource.wdc.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 30, 2023 at 05:53:41PM +0900, Damien Le Moal wrote:
> A PCI endpoint function driver can define function specific attributes
> under its function configfs directory using the add_cfs() endpoint
> driver operation. This is done by tighing up the mkdir operation for
> the function configfs directory to a call to the add_cfs() operation.
> However, there are no checks preventing the user from repeatedly
> creating function specific attribute directories with different names,
> resulting in the same endpoint specific attributes group being added
> multiple times, which also result in an invalid reference counting for
> the attribute groups. E.g., using the pci-epf-ntb function driver as an
> example, the user creates the function as follows:

[...]

> Fix this by modifying pci_epf_cfs_work() to execute the new function
> pci_ep_cfs_add_type_group() which itself calls pci_epf_type_add_cfs()
> to obtain the function specific attribute group and the group name
> (directory name) from the endpoint function driver. If the function
> driver defines an attribute group, pci_ep_cfs_add_type_group() then
> proceeds to register this group using configfs_register_group(), thus
> automatically exposing the function type pecific onfigfs attributes to

Still you haven't fixed this typo. But I don't expect you to respin unless there
are other changes.

> the user. E.g.:
> 
> $ modprobe pci-epf-ntb
> $ cd /sys/kernel/config/pci_ep/functions/pci_epf_ntb
> $ mkdir func0
> $ tree func0
> func0/
> |-- baseclass_code
> |-- cache_line_size
> |-- ...
> |-- pci_epf_ntb.0
> |   |-- db_count
> |   |-- mw1
> |   |-- mw2
> |   |-- mw3
> |   |-- mw4
> |   |-- num_mws
> |   `-- spad_count
> |-- primary
> |-- ...
> `-- vendorid
> 
> With this change, there is no need for the user to create or delete
> directories in the endpoint function attributes directory. The
> pci_epf_type_group_ops group operations are thus removed.
> 
> The documentation for the pci-epf-ntb and pci-epf-vntb function drivers
> are updated to reflect this change, removing the explanations showing
> the need to manually create the sub-directory for the function specific
> attributes.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  Documentation/PCI/endpoint/pci-ntb-howto.rst  | 11 ++---
>  Documentation/PCI/endpoint/pci-vntb-howto.rst | 13 +++---
>  drivers/pci/endpoint/pci-ep-cfs.c             | 41 +++++++++----------
>  3 files changed, 28 insertions(+), 37 deletions(-)
> 
> diff --git a/Documentation/PCI/endpoint/pci-ntb-howto.rst b/Documentation/PCI/endpoint/pci-ntb-howto.rst
> index 1884bf29caba..4261e7157ef1 100644
> --- a/Documentation/PCI/endpoint/pci-ntb-howto.rst
> +++ b/Documentation/PCI/endpoint/pci-ntb-howto.rst
> @@ -88,13 +88,10 @@ commands can be used::
>  	# echo 0x104c > functions/pci_epf_ntb/func1/vendorid
>  	# echo 0xb00d > functions/pci_epf_ntb/func1/deviceid
>  
> -In order to configure NTB specific attributes, a new sub-directory to func1
> -should be created::
> -
> -	# mkdir functions/pci_epf_ntb/func1/pci_epf_ntb.0/
> -
> -The NTB function driver will populate this directory with various attributes
> -that can be configured by the user::
> +The PCI endpoint framework also automatically creates a sub-directory in the
> +function attribute directory. This sub-directory has the same name as the name
> +of the function device and is populated with the following NTB specific
> +attributes that can be configured by the user::
>  
>  	# ls functions/pci_epf_ntb/func1/pci_epf_ntb.0/
>  	db_count    mw1         mw2         mw3         mw4         num_mws
> diff --git a/Documentation/PCI/endpoint/pci-vntb-howto.rst b/Documentation/PCI/endpoint/pci-vntb-howto.rst
> index 4ab8e4a26d4b..70d3bc90893f 100644
> --- a/Documentation/PCI/endpoint/pci-vntb-howto.rst
> +++ b/Documentation/PCI/endpoint/pci-vntb-howto.rst
> @@ -84,13 +84,10 @@ commands can be used::
>  	# echo 0x1957 > functions/pci_epf_vntb/func1/vendorid
>  	# echo 0x0809 > functions/pci_epf_vntb/func1/deviceid
>  
> -In order to configure NTB specific attributes, a new sub-directory to func1
> -should be created::
> -
> -	# mkdir functions/pci_epf_vntb/func1/pci_epf_vntb.0/
> -
> -The NTB function driver will populate this directory with various attributes
> -that can be configured by the user::
> +The PCI endpoint framework also automatically creates a sub-directory in the
> +function attribute directory. This sub-directory has the same name as the name
> +of the function device and is populated with the following NTB specific
> +attributes that can be configured by the user::
>  
>  	# ls functions/pci_epf_vntb/func1/pci_epf_vntb.0/
>  	db_count    mw1         mw2         mw3         mw4         num_mws
> @@ -103,7 +100,7 @@ A sample configuration for NTB function is given below::
>  	# echo 1 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/num_mws
>  	# echo 0x100000 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1
>  
> -A sample configuration for virtual NTB driver for virutal PCI bus::
> +A sample configuration for virtual NTB driver for virtual PCI bus::
>  
>  	# echo 0x1957 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_vid
>  	# echo 0x080A > functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_pid
> diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
> index 4b8ac0ac84d5..b16fc6093c20 100644
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
> 2.39.2
> 

-- 
மணிவண்ணன் சதாசிவம்
