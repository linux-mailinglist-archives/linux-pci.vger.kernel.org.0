Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C72279030D
	for <lists+linux-pci@lfdr.de>; Fri,  1 Sep 2023 23:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350131AbjIAVBT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Sep 2023 17:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350803AbjIAVBR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Sep 2023 17:01:17 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0291981;
        Fri,  1 Sep 2023 14:01:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5BA84CE2485;
        Fri,  1 Sep 2023 21:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211C5C433C7;
        Fri,  1 Sep 2023 21:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693602062;
        bh=3eG073MaHpi+kzniM7goePmdp+lcRXVj4Za8bRJlu8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e4bjD9XyFED/mK+Svi26gCXfIfnri4Q1b+DVLiTue/zR/BJwNsKK5l3xtvhMS0Kxy
         2zk1A1qlT7zIy4o6m7rIEoHXHDiU2adZR3JK9vvA2B0eObbt0eRRSTQxGkGJJ0cYVO
         9XRSYH6dhT/EFzIghfUlhuevUXEsnWWzQ4f/YWxc=
Date:   Fri, 1 Sep 2023 23:00:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alistair Francis <alistair23@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Jonathan.Cameron@huawei.com, lukas@wunner.de,
        alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, logang@deltatee.com, linux-kernel@vger.kernel.org,
        chaitanyak@nvidia.com, rdunlap@infradead.org,
        Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v6 2/3] sysfs: Add a attr_is_visible function to
 attribute_group
Message-ID: <2023090142-circling-probably-7828@gregkh>
References: <20230817235810.596458-1-alistair.francis@wdc.com>
 <20230817235810.596458-2-alistair.francis@wdc.com>
 <2023081959-spinach-cherisher-b025@gregkh>
 <CAKmqyKM+DNTF1f0FvDEda_db792Ta4w_uAKNTZ6E3NkYoVcPFQ@mail.gmail.com>
 <2023082325-cognitive-dispose-1180@gregkh>
 <CAKmqyKMMKJN7HU_achBc8S6-Jx16owrthwDDRWysMZe=jymnMA@mail.gmail.com>
 <2023083111-impulsive-majestic-24ee@gregkh>
 <2023083139-underling-amuser-772e@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023083139-underling-amuser-772e@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 31, 2023 at 04:36:13PM +0200, Greg KH wrote:
> On Thu, Aug 31, 2023 at 10:31:07AM +0200, Greg KH wrote:
> > On Mon, Aug 28, 2023 at 03:05:41PM +1000, Alistair Francis wrote:
> > > On Wed, Aug 23, 2023 at 5:02 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Tue, Aug 22, 2023 at 04:20:06PM -0400, Alistair Francis wrote:
> > > > > On Sat, Aug 19, 2023 at 6:57 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > On Thu, Aug 17, 2023 at 07:58:09PM -0400, Alistair Francis wrote:
> > > > > > > The documentation for sysfs_merge_group() specifically says
> > > > > > >
> > > > > > >     This function returns an error if the group doesn't exist or any of the
> > > > > > >     files already exist in that group, in which case none of the new files
> > > > > > >     are created.
> > > > > > >
> > > > > > > So just not adding the group if it's empty doesn't work, at least not
> > > > > > > with the code we currently have. The code can be changed to support
> > > > > > > this, but it is difficult to determine how this will affect existing use
> > > > > > > cases.
> > > > > >
> > > > > > Did you try?  I'd really really really prefer we do it this way as it's
> > > > > > much simpler overall to have the sysfs core "do the right thing
> > > > > > automatically" than to force each and every bus/subsystem to have to
> > > > > > manually add this type of attribute.
> > > > > >
> > > > > > Also, on a personal level, I want this function to work as it will allow
> > > > > > us to remove some code in some busses that don't really need to be there
> > > > > > (dynamic creation of some device attributes), which will then also allow
> > > > > > me to remove some apis in the driver core that should not be used at all
> > > > > > anymore (but keep creeping back in as there is still a few users.)
> > > > > >
> > > > > > So I'll be selfish here and say "please try to get my proposed change to
> > > > > > work, it's really the correct thing to do here."
> > > > >
> > > > > I did try!
> > > > >
> > > > > This is an attempt:
> > > > > https://github.com/alistair23/linux/commit/56b55756a2d7a66f7b6eb8a5692b1b5e2f81a9a9
> > > > >
> > > > > It is based on your original patch with a bunch of:
> > > > >
> > > > > if (!parent) {
> > > > >     parent = kernfs_create_dir_ns(kobj->sd, grp->name,
> > > > >                   S_IRWXU | S_IRUGO | S_IXUGO,
> > > > >                   uid, gid, kobj, NULL);
> > > > >     ...
> > > > >     }
> > > > >
> > > > >
> > > > > added throughout the code base.
> > > > >
> > > > > Very basic testing shows that it does what I need it to do and I don't
> > > > > see any kernel oops on boot.
> > > >
> > > > Nice!
> > > >
> > > > Mind if I take it and clean it up a bit and test with it here?  Again, I
> > > > need this functionality for other stuff as well, so getting it merged
> > > > for your feature is fine with me.
> > > 
> > > Sure! Go ahead. Sorry I was travelling last week.
> > > 
> > > >
> > > > > I prefer the approach I have in this mailing list patch. But if you
> > > > > like the commit mentioned above I can tidy and clean it up and then
> > > > > use that instead
> > > >
> > > > I would rather do it this way.  I can work on this on Friday if you want
> > > > me to.
> > > 
> > > Yeah, that's fine with me. If you aren't able to let me know and I can
> > > finish up the patch and send it with this series
> > 
> > Great, and for the email record, as github links are not stable, here's
> > the patch that you have above attached below.  I'll test this out and
> > clean it up a bit more and see how it goes...
> > 
> > thanks,
> > 
> > greg k-h
> > 
> > 
> > From 2929d17b58d02dcf52d0345fa966c616e09a5afa Mon Sep 17 00:00:00 2001
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Date: Wed, 24 Aug 2022 15:45:36 +0200
> > Subject: [PATCH] sysfs: do not create empty directories if no attributes are
> >  present
> > 
> > When creating an attribute group, if it is named a subdirectory is
> > created and the sysfs files are placed into that subdirectory.  If no
> > files are created, normally the directory would still be present, but it
> > would be empty.  Clean this up by removing the directory if no files
> > were successfully created in the group at all.
> > 
> > Co-developed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Co-developed-by: Alistair Francis <alistair.francis@wdc.com>
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  fs/sysfs/file.c  | 14 ++++++++++--
> >  fs/sysfs/group.c | 56 ++++++++++++++++++++++++++++++++++++------------
> >  2 files changed, 54 insertions(+), 16 deletions(-)
> > 
> > diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
> > index a12ac0356c69..7aab6c09662c 100644
> > --- a/fs/sysfs/file.c
> > +++ b/fs/sysfs/file.c
> > @@ -391,8 +391,18 @@ int sysfs_add_file_to_group(struct kobject *kobj,
> >  		kernfs_get(parent);
> >  	}
> >  
> > -	if (!parent)
> > -		return -ENOENT;
> > +	if (!parent) {
> > +		parent = kernfs_create_dir_ns(kobj->sd, group,
> > +					  S_IRWXU | S_IRUGO | S_IXUGO,
> > +					  uid, gid, kobj, NULL);
> > +		if (IS_ERR(parent)) {
> > +			if (PTR_ERR(parent) == -EEXIST)
> > +				sysfs_warn_dup(kobj->sd, group);
> > +			return PTR_ERR(parent);
> > +		}
> > +
> > +		kernfs_get(parent);
> > +	}
> >  
> >  	kobject_get_ownership(kobj, &uid, &gid);
> >  	error = sysfs_add_file_mode_ns(parent, attr, attr->mode, uid, gid,
> > diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
> > index 138676463336..013fa333cd3c 100644
> > --- a/fs/sysfs/group.c
> > +++ b/fs/sysfs/group.c
> > @@ -31,12 +31,14 @@ static void remove_files(struct kernfs_node *parent,
> >  			kernfs_remove_by_name(parent, (*bin_attr)->attr.name);
> >  }
> >  
> > +/* returns -ERROR if error, or >= 0 for number of files actually created */
> >  static int create_files(struct kernfs_node *parent, struct kobject *kobj,
> >  			kuid_t uid, kgid_t gid,
> >  			const struct attribute_group *grp, int update)
> >  {
> >  	struct attribute *const *attr;
> >  	struct bin_attribute *const *bin_attr;
> > +	int files_created = 0;
> >  	int error = 0, i;
> >  
> >  	if (grp->attrs) {
> > @@ -65,6 +67,8 @@ static int create_files(struct kernfs_node *parent, struct kobject *kobj,
> >  						       gid, NULL);
> >  			if (unlikely(error))
> >  				break;
> > +
> > +			files_created++;
> >  		}
> >  		if (error) {
> >  			remove_files(parent, grp);
> > @@ -95,12 +99,15 @@ static int create_files(struct kernfs_node *parent, struct kobject *kobj,
> >  							   NULL);
> >  			if (error)
> >  				break;
> > +			files_created++;
> >  		}
> >  		if (error)
> >  			remove_files(parent, grp);
> >  	}
> >  exit:
> > -	return error;
> > +	if (error)
> > +		return error;
> > +	return files_created;
> >  }
> >  
> >  
> > @@ -130,9 +137,14 @@ static int internal_create_group(struct kobject *kobj, int update,
> >  		if (update) {
> >  			kn = kernfs_find_and_get(kobj->sd, grp->name);
> >  			if (!kn) {
> > -				pr_warn("Can't update unknown attr grp name: %s/%s\n",
> > -					kobj->name, grp->name);
> > -				return -EINVAL;
> > +				kn = kernfs_create_dir_ns(kobj->sd, grp->name,
> > +							  S_IRWXU | S_IRUGO | S_IXUGO,
> > +							  uid, gid, kobj, NULL);
> > +				if (IS_ERR(kn)) {
> > +					if (PTR_ERR(kn) == -EEXIST)
> > +						sysfs_warn_dup(kobj->sd, grp->name);
> > +					return PTR_ERR(kn);
> > +				}
> >  			}
> >  		} else {
> >  			kn = kernfs_create_dir_ns(kobj->sd, grp->name,
> > @@ -150,11 +162,18 @@ static int internal_create_group(struct kobject *kobj, int update,
> >  
> >  	kernfs_get(kn);
> >  	error = create_files(kn, kobj, uid, gid, grp, update);
> > -	if (error) {
> > +	if (error <= 0) {
> > +		/*
> > +		 * If an error happened _OR_ if no files were created in the
> > +		 * attribute group, and we have a name for this group, delete
> > +		 * the name so there's not an empty directory.
> > +		 */
> >  		if (grp->name)
> >  			kernfs_remove(kn);
> > +	} else {
> > +		error = 0;
> > +		kernfs_put(kn);
> >  	}
> > -	kernfs_put(kn);
> >  
> >  	if (grp->name && update)
> >  		kernfs_put(kn);
> > @@ -318,13 +337,12 @@ void sysfs_remove_groups(struct kobject *kobj,
> >  EXPORT_SYMBOL_GPL(sysfs_remove_groups);
> >  
> >  /**
> > - * sysfs_merge_group - merge files into a pre-existing attribute group.
> > + * sysfs_merge_group - merge files into a attribute group.
> >   * @kobj:	The kobject containing the group.
> >   * @grp:	The files to create and the attribute group they belong to.
> >   *
> > - * This function returns an error if the group doesn't exist or any of the
> > - * files already exist in that group, in which case none of the new files
> > - * are created.
> > + * This function returns an error if any of the files already exist in
> > + * that group, in which case none of the new files are created.
> >   */
> >  int sysfs_merge_group(struct kobject *kobj,
> >  		       const struct attribute_group *grp)
> > @@ -336,12 +354,22 @@ int sysfs_merge_group(struct kobject *kobj,
> >  	struct attribute *const *attr;
> >  	int i;
> >  
> > -	parent = kernfs_find_and_get(kobj->sd, grp->name);
> > -	if (!parent)
> > -		return -ENOENT;
> > -
> >  	kobject_get_ownership(kobj, &uid, &gid);
> >  
> > +	parent = kernfs_find_and_get(kobj->sd, grp->name);
> > +	if (!parent) {
> > +		parent = kernfs_create_dir_ns(kobj->sd, grp->name,
> > +					  S_IRWXU | S_IRUGO | S_IXUGO,
> > +					  uid, gid, kobj, NULL);
> > +		if (IS_ERR(parent)) {
> > +			if (PTR_ERR(parent) == -EEXIST)
> > +				sysfs_warn_dup(kobj->sd, grp->name);
> > +			return PTR_ERR(parent);
> > +		}
> > +
> > +		kernfs_get(parent);
> > +	}
> > +
> >  	for ((i = 0, attr = grp->attrs); *attr && !error; (++i, ++attr))
> >  		error = sysfs_add_file_mode_ns(parent, *attr, (*attr)->mode,
> >  					       uid, gid, NULL);
> > -- 
> > 2.42.0
> > 
> 
> And as the 0-day bot just showed, this patch isn't going to work
> properly, the uid/gid stuff isn't all hooked up properly, I'll work on
> fixing that up when I get some cycles...

Oops, nope, that was my fault in applying this to my tree, sorry for the
noise...
