Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BC47802BA
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 02:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356430AbjHRAfO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 20:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356761AbjHRAfG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 20:35:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720172D5F;
        Thu, 17 Aug 2023 17:35:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0097C66975;
        Fri, 18 Aug 2023 00:35:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0885C433C8;
        Fri, 18 Aug 2023 00:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692318903;
        bh=9LK9sY0lbVycmuqop6sGmE86axZD6Ag6YMdWTQxkE6s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PIGjp+gAWYSIMdy309ziikHCyQTSLLrY7Xmcrg91W10RNbQv7WSIpo+58Q3VhDxCm
         gQs9p1uv90Q1UJA6E/7YccABPNmcY5VWMe8LAQYgydArxPwUOkw7a4QxF/YkU0Zug2
         HQw2JKxC00Mq3bG+/pviKk7Qj86oz9C/tCBeNq6INOjZu30mTbQZ2rsWedW7ldaStc
         LONyCB9ym6aEyDzvwfCfVmHmi1US1d/yKLtx7WbT+SUcWn+55VxHuJrI68Rcpr6+BD
         BvhQDQwDScPbsx9W81Grs+FHjVwsDQvqTsovpalBKi+0SlJrBOHOLDrZ3eR37Cqw8P
         QihoKaYjo3A+A==
Message-ID: <aa9d1a32-5388-97dc-3ed4-da78fab81bd3@kernel.org>
Date:   Fri, 18 Aug 2023 09:35:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v6 2/3] sysfs: Add a attr_is_visible function to
 attribute_group
Content-Language: en-US
To:     Alistair Francis <alistair23@gmail.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com,
        lukas@wunner.de
Cc:     alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, gregkh@linuxfoundation.org, logang@deltatee.com,
        linux-kernel@vger.kernel.org, chaitanyak@nvidia.com,
        rdunlap@infradead.org, Alistair Francis <alistair.francis@wdc.com>
References: <20230817235810.596458-1-alistair.francis@wdc.com>
 <20230817235810.596458-2-alistair.francis@wdc.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230817235810.596458-2-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023/08/18 8:58, Alistair Francis wrote:
> When creating an attribute group, if it is named a subdirectory it is
> created and the sysfs files are placed into that subdirectory.  If no
> files are created, normally the directory would still be present, but it
> would be empty.
> 
> This can be confusing for users, as it appears the feature is avaliable
> as there is a directory, but it isn't supported by the hardware or the
> kernel.
> 
> One way to fix this is to remove directories that don't contain any
> files, such as [1]. The problem with this is that there are currently
> lots of users in the kernel who expect the group to remain even if
> empty, as they dynamically add/merge properties later.
> 
> The documentation for sysfs_merge_group() specifically says
> 
>     This function returns an error if the group doesn't exist or any of the
>     files already exist in that group, in which case none of the new files
>     are created.
> 
> So just not adding the group if it's empty doesn't work, at least not
> with the code we currently have. The code can be changed to support
> this, but it is difficult to determine how this will affect existing use
> cases.
> 
> This approach instead adds a new function pointer, attr_is_visible(), to
> `struct attribute_group` which can be set if the user wants to filter
> the avaliablility of the function.
> 
> This matches the .is_visible() function pointer that already exists and
> is commonly used. This approach provides greater control over if the
> directory should be visible or not.
> 
> This will be used by the PCIe DOE sysfs attributes to kind the directory
> on devices that don't support DOE.
> 
> 1: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=debugfs_cleanup&id=f670945dfbaf353fe068544c31e3fa45575da5b5
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v6:
>  - Add patch
> 
>  fs/sysfs/group.c      | 12 +++++++++++-
>  include/linux/sysfs.h |  6 ++++++
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
> index 138676463336..34afd5becdbe 100644
> --- a/fs/sysfs/group.c
> +++ b/fs/sysfs/group.c
> @@ -111,6 +111,7 @@ static int internal_create_group(struct kobject *kobj, int update,
>  	kuid_t uid;
>  	kgid_t gid;
>  	int error;
> +	umode_t mode;
>  
>  	if (WARN_ON(!kobj || (!update && !kobj->sd)))
>  		return -EINVAL;
> @@ -125,6 +126,15 @@ static int internal_create_group(struct kobject *kobj, int update,
>  		return 0;
>  	}
>  
> +	if (grp->attr_is_visible) {
> +		mode = grp->attr_is_visible(kobj);
> +

Remove the blank line here.

> +		if (mode == 0)

Nit: if (!mode)

> +			return 0;
> +	} else {
> +		mode = S_IRWXU | S_IRUGO | S_IXUGO;
> +	}
> +
>  	kobject_get_ownership(kobj, &uid, &gid);
>  	if (grp->name) {
>  		if (update) {
> @@ -136,7 +146,7 @@ static int internal_create_group(struct kobject *kobj, int update,
>  			}
>  		} else {
>  			kn = kernfs_create_dir_ns(kobj->sd, grp->name,
> -						  S_IRWXU | S_IRUGO | S_IXUGO,
> +						  mode,
>  						  uid, gid, kobj, NULL);
>  			if (IS_ERR(kn)) {
>  				if (PTR_ERR(kn) == -EEXIST)
> diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
> index fd3fe5c8c17f..808e7fc0ca57 100644
> --- a/include/linux/sysfs.h
> +++ b/include/linux/sysfs.h
> @@ -63,6 +63,11 @@ do {							\
>   * @name:	Optional: Attribute group name
>   *		If specified, the attribute group will be created in
>   *		a new subdirectory with this name.
> + * @attr_is_visible:	Optional: Function to return permissions

Given that the existing is_visible() function apply to an attribute, naming this
one "grp_is_visible" may be better. Otherwise, this is really confusing I think.

> + *		associated with the attribute group. Only read/write
> + *		permissions as well as SYSFS_PREALLOC are accepted. Must
> + *		return 0 if an attribute is not visible. The returned value
> + *		will replace static permissions defined in struct attribute.
>   * @is_visible:	Optional: Function to return permissions associated with an
>   *		attribute of the group. Will be called repeatedly for each
>   *		non-binary attribute in the group. Only read/write
> @@ -83,6 +88,7 @@ do {							\
>   */
>  struct attribute_group {
>  	const char		*name;
> +	umode_t			(*attr_is_visible)(struct kobject *);
>  	umode_t			(*is_visible)(struct kobject *,
>  					      struct attribute *, int);
>  	umode_t			(*is_bin_visible)(struct kobject *,

-- 
Damien Le Moal
Western Digital Research

