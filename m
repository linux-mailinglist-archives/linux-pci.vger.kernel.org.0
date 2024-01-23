Return-Path: <linux-pci+bounces-2481-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1F9838EB8
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 13:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0EF91F24F88
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 12:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC465EE66;
	Tue, 23 Jan 2024 12:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qz+L/Ufn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632704BAA8;
	Tue, 23 Jan 2024 12:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706014084; cv=none; b=DRlb8jKjXxybrLY7y4yT9nfEGzttXRG1OgW+RcxVcPsJVC8oSJZGshMuqhevRKF/mWDtFVaOn8wv7Vhu90a5jhrMz6YoaeEOVrJmbpsh9iV6SotqtHkxKLr8T3Casx9aC4yvjwH3HwxiCVphkpQH+Dc0BqVs5rUxEgZjiTVKnNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706014084; c=relaxed/simple;
	bh=jQBWyqg+eDaLHOQqBbFHO+U/e5jGD9ts371IA0/qpJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pp62hKyT7AqouHXtk98BpVYqDqRSFeH+UnS3Ln2x7cAfhZfAt9o/10VLLSaC0gDjhDCIIACvWeVjZCVlZ8REhWTxnRBDmemQLbU8cD1BrOAPL9uQOW2sAhrcbmLtZYyWo28t0GX0hb2TAA4kigROci33WBkmrXvqLE/Yg6EQF+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qz+L/Ufn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D2CC43390;
	Tue, 23 Jan 2024 12:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706014084;
	bh=jQBWyqg+eDaLHOQqBbFHO+U/e5jGD9ts371IA0/qpJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qz+L/UfnUVtUah4p51KdgGi2yK2MHnjL9c3LmuDBjEaqXwSy/tzRz1jD2OHuJYMiQ
	 E6AE1l/hvdGCBV/k95O2kZv72+HjgroIWLaehfP1ym3rr4c5lL/uzTcdD/vC+UAQaT
	 Z0VIQ8SFEoyN54n834VNBGIYIYLQQgDxk8LUj2x4=
Date: Tue, 23 Jan 2024 04:25:38 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Alistair Francis <alistair23@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com, lukas@wunner.de,
	alex.williamson@redhat.com, christian.koenig@amd.com,
	kch@nvidia.com, logang@deltatee.com, linux-kernel@vger.kernel.org,
	chaitanyak@nvidia.com, rdunlap@infradead.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v6 2/3] sysfs: Add a attr_is_visible function to
 attribute_group
Message-ID: <2024012321-envious-procedure-4a58@gregkh>
References: <2023082325-cognitive-dispose-1180@gregkh>
 <CAKmqyKMMKJN7HU_achBc8S6-Jx16owrthwDDRWysMZe=jymnMA@mail.gmail.com>
 <2023083111-impulsive-majestic-24ee@gregkh>
 <2023083139-underling-amuser-772e@gregkh>
 <2023090142-circling-probably-7828@gregkh>
 <2023100539-playgroup-stoppable-d5d4@gregkh>
 <CAKmqyKOgej1jiiHsoLuDKXwdLDGa4njrndu6c1=bxnqk2NM58Q@mail.gmail.com>
 <2023101113-swimwear-squealer-464c@gregkh>
 <CAKmqyKMX3HDphrWHYcdnLEjMwe1pCROcPNZchPonhsLOq=FoHw@mail.gmail.com>
 <CAKmqyKOOSBF7qDpqAp6nn3+3wAnaGmqu88Fk3KY58fmgQ-44Jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKOOSBF7qDpqAp6nn3+3wAnaGmqu88Fk3KY58fmgQ-44Jw@mail.gmail.com>

On Tue, Jan 23, 2024 at 02:04:14PM +1000, Alistair Francis wrote:
> On Thu, Oct 12, 2023 at 2:31 PM Alistair Francis <alistair23@gmail.com> wrote:
> >
> > On Wed, Oct 11, 2023 at 4:44 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Oct 11, 2023 at 03:10:39PM +1000, Alistair Francis wrote:
> > > > On Thu, Oct 5, 2023 at 11:05 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Fri, Sep 01, 2023 at 11:00:59PM +0200, Greg KH wrote:
> > > > > > On Thu, Aug 31, 2023 at 04:36:13PM +0200, Greg KH wrote:
> > > > > > > On Thu, Aug 31, 2023 at 10:31:07AM +0200, Greg KH wrote:
> > > > > > > > On Mon, Aug 28, 2023 at 03:05:41PM +1000, Alistair Francis wrote:
> > > > > > > > > On Wed, Aug 23, 2023 at 5:02 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > > > > > >
> > > > > > > > > > On Tue, Aug 22, 2023 at 04:20:06PM -0400, Alistair Francis wrote:
> > > > > > > > > > > On Sat, Aug 19, 2023 at 6:57 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Thu, Aug 17, 2023 at 07:58:09PM -0400, Alistair Francis wrote:
> > > > > > > > > > > > > The documentation for sysfs_merge_group() specifically says
> > > > > > > > > > > > >
> > > > > > > > > > > > >     This function returns an error if the group doesn't exist or any of the
> > > > > > > > > > > > >     files already exist in that group, in which case none of the new files
> > > > > > > > > > > > >     are created.
> > > > > > > > > > > > >
> > > > > > > > > > > > > So just not adding the group if it's empty doesn't work, at least not
> > > > > > > > > > > > > with the code we currently have. The code can be changed to support
> > > > > > > > > > > > > this, but it is difficult to determine how this will affect existing use
> > > > > > > > > > > > > cases.
> > > > > > > > > > > >
> > > > > > > > > > > > Did you try?  I'd really really really prefer we do it this way as it's
> > > > > > > > > > > > much simpler overall to have the sysfs core "do the right thing
> > > > > > > > > > > > automatically" than to force each and every bus/subsystem to have to
> > > > > > > > > > > > manually add this type of attribute.
> > > > > > > > > > > >
> > > > > > > > > > > > Also, on a personal level, I want this function to work as it will allow
> > > > > > > > > > > > us to remove some code in some busses that don't really need to be there
> > > > > > > > > > > > (dynamic creation of some device attributes), which will then also allow
> > > > > > > > > > > > me to remove some apis in the driver core that should not be used at all
> > > > > > > > > > > > anymore (but keep creeping back in as there is still a few users.)
> > > > > > > > > > > >
> > > > > > > > > > > > So I'll be selfish here and say "please try to get my proposed change to
> > > > > > > > > > > > work, it's really the correct thing to do here."
> > > > > > > > > > >
> > > > > > > > > > > I did try!
> > > > > > > > > > >
> > > > > > > > > > > This is an attempt:
> > > > > > > > > > > https://github.com/alistair23/linux/commit/56b55756a2d7a66f7b6eb8a5692b1b5e2f81a9a9
> > > > > > > > > > >
> > > > > > > > > > > It is based on your original patch with a bunch of:
> > > > > > > > > > >
> > > > > > > > > > > if (!parent) {
> > > > > > > > > > >     parent = kernfs_create_dir_ns(kobj->sd, grp->name,
> > > > > > > > > > >                   S_IRWXU | S_IRUGO | S_IXUGO,
> > > > > > > > > > >                   uid, gid, kobj, NULL);
> > > > > > > > > > >     ...
> > > > > > > > > > >     }
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > added throughout the code base.
> > > > > > > > > > >
> > > > > > > > > > > Very basic testing shows that it does what I need it to do and I don't
> > > > > > > > > > > see any kernel oops on boot.
> > > > > > > > > >
> > > > > > > > > > Nice!
> > > > > > > > > >
> > > > > > > > > > Mind if I take it and clean it up a bit and test with it here?  Again, I
> > > > > > > > > > need this functionality for other stuff as well, so getting it merged
> > > > > > > > > > for your feature is fine with me.
> > > > > > > > >
> > > > > > > > > Sure! Go ahead. Sorry I was travelling last week.
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > I prefer the approach I have in this mailing list patch. But if you
> > > > > > > > > > > like the commit mentioned above I can tidy and clean it up and then
> > > > > > > > > > > use that instead
> > > > > > > > > >
> > > > > > > > > > I would rather do it this way.  I can work on this on Friday if you want
> > > > > > > > > > me to.
> > > > > > > > >
> > > > > > > > > Yeah, that's fine with me. If you aren't able to let me know and I can
> > > > > > > > > finish up the patch and send it with this series
> > > > > > > >
> > > > > > > > Great, and for the email record, as github links are not stable, here's
> > > > > > > > the patch that you have above attached below.  I'll test this out and
> > > > > > > > clean it up a bit more and see how it goes...
> > > > > > > >
> > > > > > > > thanks,
> > > > > > > >
> > > > > > > > greg k-h
> > > > > > > >
> > > > > > > >
> > > > > > > > From 2929d17b58d02dcf52d0345fa966c616e09a5afa Mon Sep 17 00:00:00 2001
> > > > > > > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > > > Date: Wed, 24 Aug 2022 15:45:36 +0200
> > > > > > > > Subject: [PATCH] sysfs: do not create empty directories if no attributes are
> > > > > > > >  present
> > > > > > > >
> > > > > > > > When creating an attribute group, if it is named a subdirectory is
> > > > > > > > created and the sysfs files are placed into that subdirectory.  If no
> > > > > > > > files are created, normally the directory would still be present, but it
> > > > > > > > would be empty.  Clean this up by removing the directory if no files
> > > > > > > > were successfully created in the group at all.
> > > > > > > >
> > > > > > > > Co-developed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > > > Co-developed-by: Alistair Francis <alistair.francis@wdc.com>
> > > > > > > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > > > > > > ---
> > > > > > > >  fs/sysfs/file.c  | 14 ++++++++++--
> > > > > > > >  fs/sysfs/group.c | 56 ++++++++++++++++++++++++++++++++++++------------
> > > > > > > >  2 files changed, 54 insertions(+), 16 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
> > > > > > > > index a12ac0356c69..7aab6c09662c 100644
> > > > > > > > --- a/fs/sysfs/file.c
> > > > > > > > +++ b/fs/sysfs/file.c
> > > > > > > > @@ -391,8 +391,18 @@ int sysfs_add_file_to_group(struct kobject *kobj,
> > > > > > > >           kernfs_get(parent);
> > > > > > > >   }
> > > > > > > >
> > > > > > > > - if (!parent)
> > > > > > > > -         return -ENOENT;
> > > > > > > > + if (!parent) {
> > > > > > > > +         parent = kernfs_create_dir_ns(kobj->sd, group,
> > > > > > > > +                                   S_IRWXU | S_IRUGO | S_IXUGO,
> > > > > > > > +                                   uid, gid, kobj, NULL);
> > > > > > > > +         if (IS_ERR(parent)) {
> > > > > > > > +                 if (PTR_ERR(parent) == -EEXIST)
> > > > > > > > +                         sysfs_warn_dup(kobj->sd, group);
> > > > > > > > +                 return PTR_ERR(parent);
> > > > > > > > +         }
> > > > > > > > +
> > > > > > > > +         kernfs_get(parent);
> > > > > > > > + }
> > > > > > > >
> > > > > > > >   kobject_get_ownership(kobj, &uid, &gid);
> > > > > > > >   error = sysfs_add_file_mode_ns(parent, attr, attr->mode, uid, gid,
> > > > > > > > diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
> > > > > > > > index 138676463336..013fa333cd3c 100644
> > > > > > > > --- a/fs/sysfs/group.c
> > > > > > > > +++ b/fs/sysfs/group.c
> > > > > > > > @@ -31,12 +31,14 @@ static void remove_files(struct kernfs_node *parent,
> > > > > > > >                   kernfs_remove_by_name(parent, (*bin_attr)->attr.name);
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +/* returns -ERROR if error, or >= 0 for number of files actually created */
> > > > > > > >  static int create_files(struct kernfs_node *parent, struct kobject *kobj,
> > > > > > > >                   kuid_t uid, kgid_t gid,
> > > > > > > >                   const struct attribute_group *grp, int update)
> > > > > > > >  {
> > > > > > > >   struct attribute *const *attr;
> > > > > > > >   struct bin_attribute *const *bin_attr;
> > > > > > > > + int files_created = 0;
> > > > > > > >   int error = 0, i;
> > > > > > > >
> > > > > > > >   if (grp->attrs) {
> > > > > > > > @@ -65,6 +67,8 @@ static int create_files(struct kernfs_node *parent, struct kobject *kobj,
> > > > > > > >                                                  gid, NULL);
> > > > > > > >                   if (unlikely(error))
> > > > > > > >                           break;
> > > > > > > > +
> > > > > > > > +                 files_created++;
> > > > > > > >           }
> > > > > > > >           if (error) {
> > > > > > > >                   remove_files(parent, grp);
> > > > > > > > @@ -95,12 +99,15 @@ static int create_files(struct kernfs_node *parent, struct kobject *kobj,
> > > > > > > >                                                      NULL);
> > > > > > > >                   if (error)
> > > > > > > >                           break;
> > > > > > > > +                 files_created++;
> > > > > > > >           }
> > > > > > > >           if (error)
> > > > > > > >                   remove_files(parent, grp);
> > > > > > > >   }
> > > > > > > >  exit:
> > > > > > > > - return error;
> > > > > > > > + if (error)
> > > > > > > > +         return error;
> > > > > > > > + return files_created;
> > > > > > > >  }
> > > > > > > >
> > > > > > > >
> > > > > > > > @@ -130,9 +137,14 @@ static int internal_create_group(struct kobject *kobj, int update,
> > > > > > > >           if (update) {
> > > > > > > >                   kn = kernfs_find_and_get(kobj->sd, grp->name);
> > > > > > > >                   if (!kn) {
> > > > > > > > -                         pr_warn("Can't update unknown attr grp name: %s/%s\n",
> > > > > > > > -                                 kobj->name, grp->name);
> > > > > > > > -                         return -EINVAL;
> > > > > > > > +                         kn = kernfs_create_dir_ns(kobj->sd, grp->name,
> > > > > > > > +                                                   S_IRWXU | S_IRUGO | S_IXUGO,
> > > > > > > > +                                                   uid, gid, kobj, NULL);
> > > > > > > > +                         if (IS_ERR(kn)) {
> > > > > > > > +                                 if (PTR_ERR(kn) == -EEXIST)
> > > > > > > > +                                         sysfs_warn_dup(kobj->sd, grp->name);
> > > > > > > > +                                 return PTR_ERR(kn);
> > > > > > > > +                         }
> > > > > > > >                   }
> > > > > > > >           } else {
> > > > > > > >                   kn = kernfs_create_dir_ns(kobj->sd, grp->name,
> > > > > > > > @@ -150,11 +162,18 @@ static int internal_create_group(struct kobject *kobj, int update,
> > > > > > > >
> > > > > > > >   kernfs_get(kn);
> > > > > > > >   error = create_files(kn, kobj, uid, gid, grp, update);
> > > > > > > > - if (error) {
> > > > > > > > + if (error <= 0) {
> > > > > > > > +         /*
> > > > > > > > +          * If an error happened _OR_ if no files were created in the
> > > > > > > > +          * attribute group, and we have a name for this group, delete
> > > > > > > > +          * the name so there's not an empty directory.
> > > > > > > > +          */
> > > > > > > >           if (grp->name)
> > > > > > > >                   kernfs_remove(kn);
> > > > > > > > + } else {
> > > > > > > > +         error = 0;
> > > > > > > > +         kernfs_put(kn);
> > > > > > > >   }
> > > > > > > > - kernfs_put(kn);
> > > > > > > >
> > > > > > > >   if (grp->name && update)
> > > > > > > >           kernfs_put(kn);
> > > > > > > > @@ -318,13 +337,12 @@ void sysfs_remove_groups(struct kobject *kobj,
> > > > > > > >  EXPORT_SYMBOL_GPL(sysfs_remove_groups);
> > > > > > > >
> > > > > > > >  /**
> > > > > > > > - * sysfs_merge_group - merge files into a pre-existing attribute group.
> > > > > > > > + * sysfs_merge_group - merge files into a attribute group.
> > > > > > > >   * @kobj:        The kobject containing the group.
> > > > > > > >   * @grp: The files to create and the attribute group they belong to.
> > > > > > > >   *
> > > > > > > > - * This function returns an error if the group doesn't exist or any of the
> > > > > > > > - * files already exist in that group, in which case none of the new files
> > > > > > > > - * are created.
> > > > > > > > + * This function returns an error if any of the files already exist in
> > > > > > > > + * that group, in which case none of the new files are created.
> > > > > > > >   */
> > > > > > > >  int sysfs_merge_group(struct kobject *kobj,
> > > > > > > >                  const struct attribute_group *grp)
> > > > > > > > @@ -336,12 +354,22 @@ int sysfs_merge_group(struct kobject *kobj,
> > > > > > > >   struct attribute *const *attr;
> > > > > > > >   int i;
> > > > > > > >
> > > > > > > > - parent = kernfs_find_and_get(kobj->sd, grp->name);
> > > > > > > > - if (!parent)
> > > > > > > > -         return -ENOENT;
> > > > > > > > -
> > > > > > > >   kobject_get_ownership(kobj, &uid, &gid);
> > > > > > > >
> > > > > > > > + parent = kernfs_find_and_get(kobj->sd, grp->name);
> > > > > > > > + if (!parent) {
> > > > > > > > +         parent = kernfs_create_dir_ns(kobj->sd, grp->name,
> > > > > > > > +                                   S_IRWXU | S_IRUGO | S_IXUGO,
> > > > > > > > +                                   uid, gid, kobj, NULL);
> > > > > > > > +         if (IS_ERR(parent)) {
> > > > > > > > +                 if (PTR_ERR(parent) == -EEXIST)
> > > > > > > > +                         sysfs_warn_dup(kobj->sd, grp->name);
> > > > > > > > +                 return PTR_ERR(parent);
> > > > > > > > +         }
> > > > > > > > +
> > > > > > > > +         kernfs_get(parent);
> > > > > > > > + }
> > > > > > > > +
> > > > > > > >   for ((i = 0, attr = grp->attrs); *attr && !error; (++i, ++attr))
> > > > > > > >           error = sysfs_add_file_mode_ns(parent, *attr, (*attr)->mode,
> > > > > > > >                                          uid, gid, NULL);
> > > > > > > > --
> > > > > > > > 2.42.0
> > > > > > > >
> > > > > > >
> > > > > > > And as the 0-day bot just showed, this patch isn't going to work
> > > > > > > properly, the uid/gid stuff isn't all hooked up properly, I'll work on
> > > > > > > fixing that up when I get some cycles...
> > > > > >
> > > > > > Oops, nope, that was my fault in applying this to my tree, sorry for the
> > > > > > noise...
> > > > >
> > > > > And I just got around to testing this, and it does not boot at all.
> > > > > Below is the patch I am using, are you sure you got this to boot for
> > > > > you?
> > > >
> > > > I just checked again and it boots for me. What failure are you seeing?
> > >
> > > Block devices were not created properly in sysfs.
> >
> > Strange. I have tested this on a QEMU virtual machine and a x86 PC and
> > I don't see any issues on either.
> >
> > >
> > > Did you test your patch, or my modified one that I attached on this
> > > email?  That might be the difference.
> >
> > I'm using your modified one.
> >
> > Are you able to provide logs? There must be some driver that is
> > causing the issue. I can try to reproduce it if I know where it's
> > failing.
> 
> Hey Greg,
> 
> I wanted to follow up on this and see if you are able to provide more
> details for reproducing or if you are able to look into it?

Last I tried this, it still crashed and would not boot either on my
laptop or my workstation.  I don't know how it is working properly for
you, what systems have you tried it on?

I'm not going to be able to look at this for many weeks due to
conference stuff, so if you want to take the series and test it and
hopefully catch my error, that would be great, I'd love to move forward
and get this merged someday.

thanks,

greg k-h

