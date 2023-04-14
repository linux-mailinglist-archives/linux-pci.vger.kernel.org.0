Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F896E27C5
	for <lists+linux-pci@lfdr.de>; Fri, 14 Apr 2023 17:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjDNP6R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 11:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjDNP6Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 11:58:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD8C1996
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 08:58:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CEA464819
        for <linux-pci@vger.kernel.org>; Fri, 14 Apr 2023 15:58:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C3EC433D2;
        Fri, 14 Apr 2023 15:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681487893;
        bh=mVcJTehJLTFGUCRpWQZQOO3CGEP49yV2RYmurDBilOc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HT9e2XUk6YPLLPM8Pi0rg6ht9GnUHGVtPY/Vg113HO4BMrI+LZHdrHpyJ3zGycQaW
         q6pOkY/CccnR4KIgU0s3My1RCQuUyZmpztkJbvjETw5STelO/sk8CCCS+/SVJ0nLs0
         lvv/um+4MpCAKhxCjSAyWB9Ox/iscNiag42JkAf0qCIfiKI2dZmr5RQIabO7yE9PtT
         YoYU6fcDXfzfkrXj1Ig/5hBMIK3taTBnwtZrEwIEYQXT/tpnPDVFp1QCViZSWVXaIt
         SKmDKUucv93OPeQYgKkltCK7xxOM+I0iCS4t0dfwEygt87vrBIcBbkc2WREKUpEI2h
         BxLJUvTqTOsZQ==
Date:   Fri, 14 Apr 2023 10:58:11 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <20230414155811.GA195618@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330085357.2653599-2-damien.lemoal@opensource.wdc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 30, 2023 at 05:53:41PM +0900, Damien Le Moal wrote:
> A PCI endpoint function driver can define function specific attributes
> under its function configfs directory using the add_cfs() endpoint
> driver operation. This is done by tighing up the mkdir operation for

tightening?

Or maybe "tying the mkdir ... to add_cfs()"?  Not sure what you
intended.

> the function configfs directory to a call to the add_cfs() operation.
> However, there are no checks preventing the user from repeatedly
> creating function specific attribute directories with different names,
> resulting in the same endpoint specific attributes group being added
> multiple times, which also result in an invalid reference counting for
> the attribute groups. E.g., using the pci-epf-ntb function driver as an
> example, the user creates the function as follows:

I don't know anything about configfs, but having the user mkdir things
isn't the model I would have expected.  IIUC this patch creates the
subdirectory automatically without the user mkdir, so I have to wonder
why it wasn't done that way in the first place.

> $ modprobe pci-epf-ntb
> $ cd /sys/kernel/config/pci_ep/functions/pci_epf_ntb
> $ mkdir func0
> $ tree func0
> func0/
> |-- baseclass_code
> |-- cache_line_size
> |-- ...
> `-- vendorid
> 
> $ mkdir func0/attrs
> $ tree func0
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
> $ mkdir func0/attrs2
> $ tree func0
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

torn

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

"Cut here" lines, timestamps, and the bottom half of the call trace
aren't really relevant here.  Register contents probably not revelant
either.

> Fix this by modifying pci_epf_cfs_work() to execute the new function
> pci_ep_cfs_add_type_group() which itself calls pci_epf_type_add_cfs()
> to obtain the function specific attribute group and the group name
> (directory name) from the endpoint function driver. If the function
> driver defines an attribute group, pci_ep_cfs_add_type_group() then
> proceeds to register this group using configfs_register_group(), thus
> automatically exposing the function type pecific onfigfs attributes to

specific configfs?

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

"Update the documentation ... to reflect ..."

(More direct than "The documentation ... is updated to reflect ...")

> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
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

Is it possible to connect this with a device via pci_err() or
dev_err()?

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

Same.

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
