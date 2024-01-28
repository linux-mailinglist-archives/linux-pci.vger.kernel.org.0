Return-Path: <linux-pci+bounces-2624-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCCE83F27D
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 01:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECD751F226FC
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jan 2024 00:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD554803;
	Sun, 28 Jan 2024 00:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aj7AUAvI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980A77FD;
	Sun, 28 Jan 2024 00:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706401308; cv=none; b=jTc24depZKU+u5ZiKuB5tcEUW/epEXG7EG1liDa+Guc5CVkeZedgblF9FQL+ZCTam0RstCsoBbjvM7aNYfgFnlhB/LdgFPGvOuB7WGzAOayNbSfmK1vIAAV74z+P+ibyoXARUXkpxDd8ymV95r+SOWrDhraKwPln0Hc1G8aWGnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706401308; c=relaxed/simple;
	bh=O1HtQqb8uagwWk8OzE7aX8zY4ynE04Ka2ERi+QZPaXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udy2cH7pi6WnbOSRNvdqHKTDOVa1yRex8QFFk57Rga4t+jXgf2cMiiTUYQWLYgiygpW7UhGKtKdflr12k18kf1z2Q4MPCzWxo/VxVLVqenj94i9zQDBDQpaDzF7jo1mxiq897ZG85b4mZpu0VRN2j2PiprKmVYJowFj412xwC/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aj7AUAvI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4BDC433C7;
	Sun, 28 Jan 2024 00:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706401308;
	bh=O1HtQqb8uagwWk8OzE7aX8zY4ynE04Ka2ERi+QZPaXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aj7AUAvIwmPFEtyaMiYsvjpWgjETBGBfSif92P4GRtpl6q6aIGju/np+eFg3uBJkl
	 lZy40o8qJubduDLGtVcRB0FssQLaq0g6Aul4ZTn7uDvSG4wgct1/L6SlV5s7LqOBCF
	 Ke67cR9MSLrLR7h4F9yggkhUHGSLN+Xysa5Aan/Y=
Date: Sat, 27 Jan 2024 16:21:47 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Alistair Francis <alistair23@gmail.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com,
	lukas@wunner.de, alex.williamson@redhat.com,
	christian.koenig@amd.com, kch@nvidia.com, logang@deltatee.com,
	linux-kernel@vger.kernel.org, chaitanyak@nvidia.com,
	rdunlap@infradead.org, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v6 2/3] sysfs: Add a attr_is_visible function to
 attribute_group
Message-ID: <2024012703-exclaim-ground-2b8b@gregkh>
References: <CAKmqyKOgej1jiiHsoLuDKXwdLDGa4njrndu6c1=bxnqk2NM58Q@mail.gmail.com>
 <2023101113-swimwear-squealer-464c@gregkh>
 <CAKmqyKMX3HDphrWHYcdnLEjMwe1pCROcPNZchPonhsLOq=FoHw@mail.gmail.com>
 <CAKmqyKOOSBF7qDpqAp6nn3+3wAnaGmqu88Fk3KY58fmgQ-44Jw@mail.gmail.com>
 <2024012321-envious-procedure-4a58@gregkh>
 <65b1739b2c789_37ad294f5@dwillia2-xfh.jf.intel.com.notmuch>
 <65b400bf65c33_51c7f294c5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <2024012631-removed-stuffed-ecc0@gregkh>
 <65b4112db4de0_51c7f2943a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <65b471ced39b_4e7f529431@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65b471ced39b_4e7f529431@dwillia2-xfh.jf.intel.com.notmuch>

On Fri, Jan 26, 2024 at 07:00:30PM -0800, Dan Williams wrote:
> > I'll type it up and see how it looks, but if you're not worried about
> > the is_group_visible() addition to 'struct atttribute_group' I think
> > that way is less hacky than the above.
> 
> Ok, here it is (below the scissors line). I ended up including a way to
> determine if an attribute_group is opting into this new capability, and
> I do think this is more in line with your direction to just reuse
> existing is_visible() callbacks. This was tested with the following hack
> to a dynamic visibility group in CXL:

At first glance, I like this, but your example here:

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 3e817a6f94c6..286b91e29c88 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2010,8 +2010,8 @@ static struct attribute *target_attrs[] = {
>  	NULL,
>  };
>  
> -static umode_t cxl_region_target_visible(struct kobject *kobj,
> -					 struct attribute *a, int n)
> +static umode_t cxl_region_target_attr_visible(struct kobject *kobj,
> +					      struct attribute *a, int n)
>  {
>  	struct device *dev = kobj_to_dev(kobj);
>  	struct cxl_region *cxlr = to_cxl_region(dev);
> @@ -2022,9 +2022,22 @@ static umode_t cxl_region_target_visible(struct kobject *kobj,
>  	return 0;
>  }
>  
> +static bool cxl_region_target_group_visible(struct kobject *kobj)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +	struct cxl_region_params *p = &cxlr->params;
> +
> +	if (!p->interleave_ways || p->interleave_ways > 2)
> +		return false;
> +	return true;
> +}
> +DEFINE_SYSFS_GROUP_VISIBLE(cxl_region_target);
> +
>  static const struct attribute_group cxl_region_target_group = {
> +	.name = "target_group",
>  	.attrs = target_attrs,
> -	.is_visible = cxl_region_target_visible,
> +	.is_visible = SYSFS_GROUP_VISIBLE(cxl_region_target),
>  };
>  
>  static const struct attribute_group *get_cxl_region_target_group(void)
> 

Seems to not match the documentation in the patch itself, but maybe I'm
reading it wrong.

If all that is needed is the above type of change, I'm all for this,
comments on the implementation below:

> -- >8 --
> >From 293a9b1d451cba5e7f95897de8c980fddead43ab Mon Sep 17 00:00:00 2001
> From: Dan Williams <dan.j.williams@intel.com>
> Date: Fri, 26 Jan 2024 18:17:53 -0800
> Subject: [PATCH v2] sysfs: Introduce a mechanism to hide static attribute_groups
> 
> Add a mechanism for named attribute_groups to hide their directory at
> sysfs_update_group() time, or otherwise skip emitting the group
> directory when the group is first registered. It piggybacks on
> is_visible() in a similar manner as SYSFS_PREALLOC, i.e. special flags
> in the upper bits of the returned mode. To use it, specify a symbol
> prefix to DEFINE_SYSFS_GROUP_VISIBLE(), and then pass that same prefix
> to SYSFS_GROUP_VISIBLE() when assigning the @is_visible() callback:
> 
> 	DEFINE_SYSFS_GROUP_VISIBLE($prefix)
> 
> 	struct attribute_group $prefix_group = {
> 		.name = $name,
> 		.is_visible = SYSFS_GROUP_VISIBLE($prefix),
> 	};
> 
> SYSFS_GROUP_VISIBLE() expects a definition of $prefix_group_visible()
> and $prefix_attr_visible(), where $prefix_group_visible() just returns
> true / false and $prefix_attr_visible() behaves as normal.
> 
> The motivation for this capability is to centralize PCI device
> authentication in the PCI core with a named sysfs group while keeping
> that group hidden for devices and platforms that do not meet the
> requirements. In a PCI topology, most devices will not support
> authentication, a small subset will support just PCI CMA (Component
> Measurement and Authentication), a smaller subset will support PCI CMA +
> PCIe IDE (Link Integrity and Encryption), and only next generation
> server hosts will start to include a platform TSM (TEE Security
> Manager).
> 
> Without this capability the alternatives are:
> 
> * Check if all attributes are invisible and if so, hide the directory.
>   Beyond trouble getting this to work [1], this is an ABI change for
>   scenarios if userspace happens to depend on group visibility absent any
>   attributes. I.e. this new capability avoids regression since it does
>   not retroactively apply to existing cases.
> 
> * Publish an empty /sys/bus/pci/devices/$pdev/tsm/ directory for all PCI
>   devices (i.e. for the case when TSM platform support is present, but
>   device support is absent). Unfortunate that this will be a vestigial
>   empty directory in the vast majority of cases.
> 
> * Reintroduce usage of runtime calls to sysfs_{create,remove}_group()
>   in the PCI core. Bjorn has already indicated that he does not want to
>   see any growth of pci_sysfs_init() [2].
> 
> * Drop the named group and simulate a directory by prefixing all
>   TSM-related attributes with "tsm_". Unfortunate to not use the naming
>   capability of a sysfs group as intended.
> 
> In comparison, there is a small potential for regression if for some
> reason an @is_visible() callback had dependencies on how many times it
> was called.

Great changelog, thanks for all of that.

> 
> Link: https://lore.kernel.org/all/2024012321-envious-procedure-4a58@gregkh/ [1]
> Link: https://lore.kernel.org/linux-pci/20231019200110.GA1410324@bhelgaas/ [2]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  fs/sysfs/group.c      | 64 ++++++++++++++++++++++++++++++++------
>  include/linux/sysfs.h | 71 +++++++++++++++++++++++++++++++++++--------
>  2 files changed, 114 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
> index 138676463336..90dd98c82776 100644
> --- a/fs/sysfs/group.c
> +++ b/fs/sysfs/group.c
> @@ -31,6 +31,17 @@ static void remove_files(struct kernfs_node *parent,
>  			kernfs_remove_by_name(parent, (*bin_attr)->attr.name);
>  }
>  
> +static umode_t __first_visible(const struct attribute_group *grp, struct kobject *kobj)
> +{
> +	if (grp->attrs && grp->is_visible)
> +		return grp->is_visible(kobj, grp->attrs[0], 0);
> +
> +	if (grp->bin_attrs && grp->is_bin_visible)
> +		return grp->is_bin_visible(kobj, grp->bin_attrs[0], 0);

This kind of makes sense, but why the first attribute only?  I guess we
have to pick one?

> +
> +	return 0;
> +}
> +
>  static int create_files(struct kernfs_node *parent, struct kobject *kobj,
>  			kuid_t uid, kgid_t gid,
>  			const struct attribute_group *grp, int update)
> @@ -52,6 +63,7 @@ static int create_files(struct kernfs_node *parent, struct kobject *kobj,
>  				kernfs_remove_by_name(parent, (*attr)->name);
>  			if (grp->is_visible) {
>  				mode = grp->is_visible(kobj, *attr, i);
> +				mode &= ~SYSFS_GROUP_VISIBLE_MASK;
>  				if (!mode)
>  					continue;
>  			}
> @@ -81,6 +93,7 @@ static int create_files(struct kernfs_node *parent, struct kobject *kobj,
>  						(*bin_attr)->attr.name);
>  			if (grp->is_bin_visible) {
>  				mode = grp->is_bin_visible(kobj, *bin_attr, i);
> +				mode &= ~SYSFS_GROUP_VISIBLE_MASK;
>  				if (!mode)
>  					continue;
>  			}
> @@ -127,16 +140,35 @@ static int internal_create_group(struct kobject *kobj, int update,
>  
>  	kobject_get_ownership(kobj, &uid, &gid);
>  	if (grp->name) {
> +		umode_t mode = __first_visible(grp, kobj);
> +		bool has_group_visible = mode & SYSFS_HAS_GROUP_VISIBLE;
> +
> +		if (has_group_visible && (mode & SYSFS_GROUP_INVISIBLE))

These new SYSFS_*_GROUP values are confusing me, more below:

> +			mode = 0;
> +		else
> +			mode = S_IRWXU | S_IRUGO | S_IXUGO;
> +
>  		if (update) {
>  			kn = kernfs_find_and_get(kobj->sd, grp->name);
>  			if (!kn) {
> -				pr_warn("Can't update unknown attr grp name: %s/%s\n",
> -					kobj->name, grp->name);
> -				return -EINVAL;
> +				if (!has_group_visible) {
> +					pr_warn("Can't update unknown attr grp name: %s/%s\n",
> +						kobj->name, grp->name);
> +					return -EINVAL;
> +				}
> +				/* may have been invisible prior to this update */
> +				update = 0;
> +			} else if (!mode) {
> +				sysfs_remove_group(kobj, grp);
> +				kernfs_put(kn);
> +				return 0;
>  			}
> -		} else {
> -			kn = kernfs_create_dir_ns(kobj->sd, grp->name,
> -						  S_IRWXU | S_IRUGO | S_IXUGO,
> +		}
> +
> +		if (!update) {
> +			if (!mode)
> +				return 0;
> +			kn = kernfs_create_dir_ns(kobj->sd, grp->name, mode,
>  						  uid, gid, kobj, NULL);
>  			if (IS_ERR(kn)) {
>  				if (PTR_ERR(kn) == -EEXIST)
> @@ -262,6 +294,22 @@ int sysfs_update_group(struct kobject *kobj,
>  }
>  EXPORT_SYMBOL_GPL(sysfs_update_group);
>  
> +static void warn_group_not_found(const struct attribute_group *grp,
> +				 struct kobject *kobj)
> +{
> +	umode_t mode = __first_visible(grp, kobj);
> +
> +	if (mode & SYSFS_HAS_GROUP_VISIBLE) {
> +		/* may have never been created */
> +		pr_debug("sysfs group '%s' not found for kobject '%s'\n",
> +			 grp->name, kobject_name(kobj));
> +		return;

So if the group is visible somehow, but not found, then it's ok?  But:


> +	}
> +
> +	WARN(1, KERN_WARNING "sysfs group '%s' not found for kobject '%s'\n",
> +	     grp->name, kobject_name(kobj));

We crash the box if it was not visible and not found?


> +}
> +
>  /**
>   * sysfs_remove_group: remove a group from a kobject
>   * @kobj:	kobject to remove the group from
> @@ -279,9 +327,7 @@ void sysfs_remove_group(struct kobject *kobj,
>  	if (grp->name) {
>  		kn = kernfs_find_and_get(parent, grp->name);
>  		if (!kn) {
> -			WARN(!kn, KERN_WARNING
> -			     "sysfs group '%s' not found for kobject '%s'\n",
> -			     grp->name, kobject_name(kobj));
> +			warn_group_not_found(grp, kobj);

We really should not WARN(), but I guess we don't ever get reports of
this so it's ok.

>  			return;
>  		}
>  	} else {
> diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
> index b717a70219f6..4fb4f4da003a 100644
> --- a/include/linux/sysfs.h
> +++ b/include/linux/sysfs.h
> @@ -62,21 +62,32 @@ do {							\
>   * struct attribute_group - data structure used to declare an attribute group.
>   * @name:	Optional: Attribute group name
>   *		If specified, the attribute group will be created in
> - *		a new subdirectory with this name.
> + *		a new subdirectory with this name. Additionally when a
> + *		group is named, @is_visible and @is_bin_visible may
> + *		return SYSFS_HAS_GROUP_VISIBLE | SYSFS_GROUP_INVISIBLE
> + *		to control visibility of the directory itself. If
> + *		SYSFS_GROUP_INVISIBLE is ever to be returned,
> + *		SYSFS_HAS_GROUP_VISIBLE must always be included in the
> + *		return value from @is_visible and @is_bin_visible. See
> + *		the DEFINE_SYSFS_GROUP_VISIBLE() helper.

Here it gets confusing for me.  Why are you saying things like
SYSFS_HAS_GROUP_VISIBLE and SYSFS_GROUP_INVISIBLE, when your example
shows none of that at all?  Shouldn't this all be internal-to-sysfs
stuff?  Why list it here?


>   * @is_visible:	Optional: Function to return permissions associated with an
> - *		attribute of the group. Will be called repeatedly for each
> - *		non-binary attribute in the group. Only read/write
> - *		permissions as well as SYSFS_PREALLOC are accepted. Must
> - *		return 0 if an attribute is not visible. The returned value
> - *		will replace static permissions defined in struct attribute.
> + *		attribute of the group. Will be called repeatedly for
> + *		each non-binary attribute in the group. Only read/write
> + *		permissions as well as SYSFS_PREALLOC (and the
> + *		visibility flags for named groups) are accepted. Must
> + *		return 0 (or just SYSFS_HAS_GROUP_VISIBLE) if an
> + *		attribute is not visible. The returned value will
> + *		replace static permissions defined in struct attribute.
>   * @is_bin_visible:
>   *		Optional: Function to return permissions associated with a
>   *		binary attribute of the group. Will be called repeatedly
>   *		for each binary attribute in the group. Only read/write
> - *		permissions as well as SYSFS_PREALLOC are accepted. Must
> - *		return 0 if a binary attribute is not visible. The returned
> - *		value will replace static permissions defined in
> - *		struct bin_attribute.
> + *		permissions as well as SYSFS_PREALLOC (and the
> + *		visibility flags for named groups) are accepted. Must
> + *		return 0 (or just SYSFS_HAS_GROUP_VISIBLE) if a binary
> + *		attribute is not visible. The returned value will
> + *		replace static permissions defined in struct
> + *		bin_attribute.
>   * @attrs:	Pointer to NULL terminated list of attributes.
>   * @bin_attrs:	Pointer to NULL terminated list of binary attributes.
>   *		Either attrs or bin_attrs or both must be provided.
> @@ -91,13 +102,49 @@ struct attribute_group {
>  	struct bin_attribute	**bin_attrs;
>  };
>  
> +#define SYSFS_PREALLOC		010000
> +#define SYSFS_HAS_GROUP_VISIBLE 020000

Nit, forgot a tab :(

> +#define SYSFS_GROUP_INVISIBLE	040000
> +#define SYSFS_GROUP_VISIBLE_MASK (SYSFS_HAS_GROUP_VISIBLE|SYSFS_GROUP_INVISIBLE)

Ackward defines, "HAS_GROUP_VISABLE" vs. "GROUP_INVISIBLE"?  Why not
just "GROUP_VISIBLE" and "GROUP_INVISIBLE"?


> +
> +static inline umode_t sysfs_group_visible(umode_t mode)
> +{
> +	return mode | SYSFS_HAS_GROUP_VISIBLE;

So if mode is 0, then we return visible?  is that really correct?

> +}
> +
> +/*
> + * The first call to is_visible() in the create / update path may
> + * indicate visibility for the entire group
> + */
> +#define DEFINE_SYSFS_GROUP_VISIBLE(name)                                \
> +static inline umode_t sysfs_group_visible_##name(                       \
> +	struct kobject *kobj, struct attribute *attr, int n)            \
> +{                                                                       \
> +	if (n == 0 && !name##_group_visible(kobj))			\
> +		return sysfs_group_visible(SYSFS_GROUP_INVISIBLE);      \

This reads really funny, we are passing in "invisible" to a "visible"
function call :)

Why pass anything in here?  I really have a hard time parsing this,
maybe because of the negative of the "*_group_visible()" call?


> +	return sysfs_group_visible(name##_attr_visible(kobj, attr, n)); \

But you only call this on the first attribute, right?  I kind of
understand that, but documenting it a bit better here might help?

Anyway, basic structure I like, changes for a driver to use this I love,
but implementation confuses me, and if I have to maintain it for the
next 20+ years, and can't understand it on day 1, I'm going to be in
trouble soon, which makes me wary to take this as-is.

thanks,

greg k-h

