Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF096BB5F7
	for <lists+linux-pci@lfdr.de>; Wed, 15 Mar 2023 15:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjCOO1p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Mar 2023 10:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbjCOO1n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Mar 2023 10:27:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2758087372
        for <linux-pci@vger.kernel.org>; Wed, 15 Mar 2023 07:27:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D06E8B81E40
        for <linux-pci@vger.kernel.org>; Wed, 15 Mar 2023 14:27:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9383BC433D2;
        Wed, 15 Mar 2023 14:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678890455;
        bh=4ejSDI+7q/x+FHjOVjrWCSH/hRPU1Wj2KVWEr5ogCJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a/1ACAHHKDwE23cdrDp8TcBeRI6N8oCCDvzH5CNyvfBC6ZjLzbN6SFj2Dbh4Fo/ov
         eFMnwCWtQzB/5nBrgP/8bLkecUPvkYKRWr9Ti1bfxZ6V7YEb+dF4TttldDDPgCm7Zu
         mRvR2AsBDMdg/Z1urxfzI6p9RCwz6jKeqiodEM2O2OIg57F997NXV/nMYO2vTbQSoy
         IhR/65s9jVsoGEnhVnlO7y1yFqK+NIdETG5OH3n5UIIi7jn6oa515Nwjz+JyVrNomE
         OufTO738+ev+DtFljy5/EdH7U4R4SBNUBLONFx/KEWx3n0q3dXX3NSJ1NwA9W8yAJP
         FbRKt+BvWNojg==
Date:   Wed, 15 Mar 2023 19:57:22 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 01/16] PCI: endpoint: Automatically create a function
 specific attributes group
Message-ID: <20230315142722.GC98488@thinkpad>
References: <20230308090313.1653-1-damien.lemoal@opensource.wdc.com>
 <20230308090313.1653-2-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230308090313.1653-2-damien.lemoal@opensource.wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 08, 2023 at 06:02:58PM +0900, Damien Le Moal wrote:
> A PCI endpoint function driver can define function specific attributes
> under its function configfs directory using the add_cfs() endpoint
> driver operation. This is done by tighing up the mkdir operation for
> the function configfs directory to a call to the add_cfs() operation.
> However, there are no checks preventing the user from repeatedly
> creating function specific attribute directories with different names,
> resulting in the same endpoing specific attributes group being added

endpoint

> multiple times, which also result in an invalid refernce counting for

reference

> the attribute groups. E.g., using the pci-epf-ntb function driver as an
> example, the user creates the function as follows:
> 
>  modprobe pci-epf-ntb
> func0/
> |-- baseclass_code
> |-- cache_line_size
> |-- ...
> `-- vendorid
> 
> func0/
> |-- attrs
> |   |-- db_count
> |   |-- mw1
> |   |-- mw2
> |   |-- mw3
> |   |-- mw4
> |   |-- num_mws
> |   `-- spad_count
> |-- baseclass_code
> |-- cache_line_size
> |-- ...
> `-- vendorid
> 
> At this point, the function can be started by linking the EP controller.
> However, if the user mistakenly creates again a directory:
> 
> func0/
> |-- attrs
> |   |-- db_count
> |   |-- mw1
> |   |-- mw2
> |   |-- mw3
> |   |-- mw4
> |   |-- num_mws
> |   `-- spad_count
> |-- attrs2
> |   |-- db_count
> |   |-- mw1
> |   |-- mw2
> |   |-- mw3
> |   |-- mw4
> |   |-- num_mws
> |   `-- spad_count
> |-- baseclass_code
> |-- cache_line_size
> |-- ...
> `-- vendorid
> 
> The function specific attributes are duplicated and cause a crash when
> the function is tore down:
> 
> [ 9740.729598] ------------[ cut here ]------------
> [ 9740.730071] refcount_t: addition on 0; use-after-free.
> [ 9740.730564] WARNING: CPU: 2 PID: 834 at lib/refcount.c:25 refcount_warn_saturate+0xc8/0x144
> [ 9740.735593] CPU: 2 PID: 834 Comm: rmdir Not tainted 6.3.0-rc1 #1
> [ 9740.736133] Hardware name: Pine64 RockPro64 v2.1 (DT)
> [ 9740.736586] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [ 9740.737210] pc : refcount_warn_saturate+0xc8/0x144
> [ 9740.737648] lr : refcount_warn_saturate+0xc8/0x144
> [ 9740.738085] sp : ffff800009cebc90
> [ 9740.738385] x29: ffff800009cebc90 x28: ffff0000019ed700 x27: ffff0000040c3900
> [ 9740.739032] x26: 0000000000000000 x25: ffff800009325320 x24: ffff0000012da000
> [ 9740.739678] x23: ffff000003bd9a80 x22: ffff000005ee9580 x21: ffff000003bd9ad8
> [ 9740.740324] x20: ffff0000f36cd2c8 x19: ffff0000012da2b8 x18: 0000000000000006
> [ 9740.740969] x17: 0000000000000000 x16: 0000000000000000 x15: 0765076507720766
> [ 9740.741615] x14: 072d077207650774 x13: ffff800009281000 x12: 000000000000056d
> [ 9740.742261] x11: 00000000000001cf x10: ffff8000092d9000 x9 : ffff800009281000
> [ 9740.742906] x8 : 00000000ffffefff x7 : ffff8000092d9000 x6 : 80000000fffff000
> [ 9740.743552] x5 : ffff0000f7771b88 x4 : 0000000000000000 x3 : 0000000000000027
> [ 9740.744197] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000019ed700
> [ 9740.744842] Call trace:
> [ 9740.745068]  refcount_warn_saturate+0xc8/0x144
> [ 9740.745475]  config_item_get+0x7c/0x80
> [ 9740.745822]  configfs_rmdir+0x17c/0x30c
> [ 9740.746174]  vfs_rmdir+0x8c/0x204
> [ 9740.746482]  do_rmdir+0x158/0x184
> [ 9740.746787]  __arm64_sys_unlinkat+0x64/0x80
> [ 9740.747171]  invoke_syscall+0x48/0x114
> [ 9740.747519]  el0_svc_common.constprop.0+0x44/0xec
> [ 9740.747948]  do_el0_svc+0x38/0x98
> [ 9740.748255]  el0_svc+0x2c/0x84
> [ 9740.748541]  el0t_64_sync_handler+0xf4/0x120
> [ 9740.748932]  el0t_64_sync+0x190/0x194
> [ 9740.749269] ---[ end trace 0000000000000000 ]---
> [ 9740.749754] ------------[ cut here ]------------
> 
> Fix this by modifying pci_epf_cfs_work() to execute the new function
> pci_ep_cfs_add_type_group() which itself calls pci_epf_type_add_cfs()
> to obtain the function specific attribute group and the group name
> (directory name) from the endpoint function driver. If the function
> driver defines an attribute group, pci_ep_cfs_add_type_group() then
> proceeds to register this group using configfs_register_group(), thus
> automatically exposing the function type pecific onfigfs attributes to

specific configfs

> the user. E.g.:
> 
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
> With this change, there is no need for the user to create/delete
> directories in the endpoint function configfs directory. The
> pci_epf_type_group_ops group operations are thus removed.
> 

Now you also need a documentation change 

> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

With the above comments addressed,

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/pci/endpoint/pci-ep-cfs.c | 41 ++++++++++++++-----------------
>  1 file changed, 19 insertions(+), 22 deletions(-)
> 
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
