Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAC77C4909
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 07:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjJKFLP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Oct 2023 01:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjJKFLN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2023 01:11:13 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818CF9D;
        Tue, 10 Oct 2023 22:11:07 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-457584c824dso1683957137.0;
        Tue, 10 Oct 2023 22:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697001066; x=1697605866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aW1Hz0Z+3/smmQhOE3f0Qiy+qN8uHKaVmirfLTm8Gb8=;
        b=K0zvsfcinTGhcsjh8T7fsrFbawG2fP3U86vdSLPqS+Yw4cU+vfajOr+bc3wxIL6dZ6
         Nfq4q2zh0jyIvIHQ8Kfyjpz9ZZ6u86M/01eyUl+OOo1kA8w1g5YSZ/HE5LV7PTR89cVS
         9XGzdNZTiygTFMxpl+3orAxr7KfaS8Mc0+2ZADthtpY9/lwrxajuV7k/x6ei68DlfRTW
         ZbyHnOpCSe9XVnh5tIsWjHEzT4ZmhHWuR7VnY9q99FEVC+k3tPzE3yS1bxSjQTjf+F7J
         uL5kbHqBgsz8usIvW0CDkppnVdwK+yiAjasRKbWjruISQrvFnZiPKuF6YUDDETJUeOKC
         Qerg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697001066; x=1697605866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aW1Hz0Z+3/smmQhOE3f0Qiy+qN8uHKaVmirfLTm8Gb8=;
        b=vOJDIfylohXAkvjBGPg91tY+1+c3fQ+cgOzAGnwx2b3y/xCxyDnPmQSoIYCTjUXjOk
         mSDQViymwJTzqvrPQ9+nWUpzPgMG+Wr6cAPAdiV+mxcWBwXwLrUX1l3p80VtxMaqeyNu
         GPQGOkPmk0JagQx9kUdyx32Gnk5CDgLyepxgfpy7Z8G6dtnWDQ7khMzXnZ1kHq1JRBRK
         sG24QNUim2+oXnd9WDA4OlW839Js6ORR0P0XSyYwLUscMjapgDWb8bR7EFmoc3GDw9TG
         mvbzx0yfwZmjl1skv1SlCOdHI8fNZ5PnWwsGuPcaNBjbIr5dd2re4JCpTVYF95ruhMnU
         J+EQ==
X-Gm-Message-State: AOJu0YwwOtXhw/84mAUd3sCK+sUQ1TcIiRYYdZeEkhUE9CKfGPnLM1H5
        HDFSroHghJQ5L+ruXnmCx469q8R/92Vb8J7xIds=
X-Google-Smtp-Source: AGHT+IFM5+OHy0nAyrzW75uzlf8nIEhVIlmY1u9rI3HHxJNuMzDqCX6Mwhfp1A9RyrJM0iqK3THm04kyI1lp4qs9EIQ=
X-Received: by 2002:a67:fd4b:0:b0:452:8452:8a90 with SMTP id
 g11-20020a67fd4b000000b0045284528a90mr19123735vsr.0.1697001066492; Tue, 10
 Oct 2023 22:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230817235810.596458-1-alistair.francis@wdc.com>
 <20230817235810.596458-2-alistair.francis@wdc.com> <2023081959-spinach-cherisher-b025@gregkh>
 <CAKmqyKM+DNTF1f0FvDEda_db792Ta4w_uAKNTZ6E3NkYoVcPFQ@mail.gmail.com>
 <2023082325-cognitive-dispose-1180@gregkh> <CAKmqyKMMKJN7HU_achBc8S6-Jx16owrthwDDRWysMZe=jymnMA@mail.gmail.com>
 <2023083111-impulsive-majestic-24ee@gregkh> <2023083139-underling-amuser-772e@gregkh>
 <2023090142-circling-probably-7828@gregkh> <2023100539-playgroup-stoppable-d5d4@gregkh>
In-Reply-To: <2023100539-playgroup-stoppable-d5d4@gregkh>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Wed, 11 Oct 2023 15:10:39 +1000
Message-ID: <CAKmqyKOgej1jiiHsoLuDKXwdLDGa4njrndu6c1=bxnqk2NM58Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] sysfs: Add a attr_is_visible function to attribute_group
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Jonathan.Cameron@huawei.com, lukas@wunner.de,
        alex.williamson@redhat.com, christian.koenig@amd.com,
        kch@nvidia.com, logang@deltatee.com, linux-kernel@vger.kernel.org,
        chaitanyak@nvidia.com, rdunlap@infradead.org,
        Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 5, 2023 at 11:05=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Fri, Sep 01, 2023 at 11:00:59PM +0200, Greg KH wrote:
> > On Thu, Aug 31, 2023 at 04:36:13PM +0200, Greg KH wrote:
> > > On Thu, Aug 31, 2023 at 10:31:07AM +0200, Greg KH wrote:
> > > > On Mon, Aug 28, 2023 at 03:05:41PM +1000, Alistair Francis wrote:
> > > > > On Wed, Aug 23, 2023 at 5:02=E2=80=AFPM Greg KH <gregkh@linuxfoun=
dation.org> wrote:
> > > > > >
> > > > > > On Tue, Aug 22, 2023 at 04:20:06PM -0400, Alistair Francis wrot=
e:
> > > > > > > On Sat, Aug 19, 2023 at 6:57=E2=80=AFAM Greg KH <gregkh@linux=
foundation.org> wrote:
> > > > > > > >
> > > > > > > > On Thu, Aug 17, 2023 at 07:58:09PM -0400, Alistair Francis =
wrote:
> > > > > > > > > The documentation for sysfs_merge_group() specifically sa=
ys
> > > > > > > > >
> > > > > > > > >     This function returns an error if the group doesn't e=
xist or any of the
> > > > > > > > >     files already exist in that group, in which case none=
 of the new files
> > > > > > > > >     are created.
> > > > > > > > >
> > > > > > > > > So just not adding the group if it's empty doesn't work, =
at least not
> > > > > > > > > with the code we currently have. The code can be changed =
to support
> > > > > > > > > this, but it is difficult to determine how this will affe=
ct existing use
> > > > > > > > > cases.
> > > > > > > >
> > > > > > > > Did you try?  I'd really really really prefer we do it this=
 way as it's
> > > > > > > > much simpler overall to have the sysfs core "do the right t=
hing
> > > > > > > > automatically" than to force each and every bus/subsystem t=
o have to
> > > > > > > > manually add this type of attribute.
> > > > > > > >
> > > > > > > > Also, on a personal level, I want this function to work as =
it will allow
> > > > > > > > us to remove some code in some busses that don't really nee=
d to be there
> > > > > > > > (dynamic creation of some device attributes), which will th=
en also allow
> > > > > > > > me to remove some apis in the driver core that should not b=
e used at all
> > > > > > > > anymore (but keep creeping back in as there is still a few =
users.)
> > > > > > > >
> > > > > > > > So I'll be selfish here and say "please try to get my propo=
sed change to
> > > > > > > > work, it's really the correct thing to do here."
> > > > > > >
> > > > > > > I did try!
> > > > > > >
> > > > > > > This is an attempt:
> > > > > > > https://github.com/alistair23/linux/commit/56b55756a2d7a66f7b=
6eb8a5692b1b5e2f81a9a9
> > > > > > >
> > > > > > > It is based on your original patch with a bunch of:
> > > > > > >
> > > > > > > if (!parent) {
> > > > > > >     parent =3D kernfs_create_dir_ns(kobj->sd, grp->name,
> > > > > > >                   S_IRWXU | S_IRUGO | S_IXUGO,
> > > > > > >                   uid, gid, kobj, NULL);
> > > > > > >     ...
> > > > > > >     }
> > > > > > >
> > > > > > >
> > > > > > > added throughout the code base.
> > > > > > >
> > > > > > > Very basic testing shows that it does what I need it to do an=
d I don't
> > > > > > > see any kernel oops on boot.
> > > > > >
> > > > > > Nice!
> > > > > >
> > > > > > Mind if I take it and clean it up a bit and test with it here? =
 Again, I
> > > > > > need this functionality for other stuff as well, so getting it =
merged
> > > > > > for your feature is fine with me.
> > > > >
> > > > > Sure! Go ahead. Sorry I was travelling last week.
> > > > >
> > > > > >
> > > > > > > I prefer the approach I have in this mailing list patch. But =
if you
> > > > > > > like the commit mentioned above I can tidy and clean it up an=
d then
> > > > > > > use that instead
> > > > > >
> > > > > > I would rather do it this way.  I can work on this on Friday if=
 you want
> > > > > > me to.
> > > > >
> > > > > Yeah, that's fine with me. If you aren't able to let me know and =
I can
> > > > > finish up the patch and send it with this series
> > > >
> > > > Great, and for the email record, as github links are not stable, he=
re's
> > > > the patch that you have above attached below.  I'll test this out a=
nd
> > > > clean it up a bit more and see how it goes...
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > > >
> > > >
> > > > From 2929d17b58d02dcf52d0345fa966c616e09a5afa Mon Sep 17 00:00:00 2=
001
> > > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Date: Wed, 24 Aug 2022 15:45:36 +0200
> > > > Subject: [PATCH] sysfs: do not create empty directories if no attri=
butes are
> > > >  present
> > > >
> > > > When creating an attribute group, if it is named a subdirectory is
> > > > created and the sysfs files are placed into that subdirectory.  If =
no
> > > > files are created, normally the directory would still be present, b=
ut it
> > > > would be empty.  Clean this up by removing the directory if no file=
s
> > > > were successfully created in the group at all.
> > > >
> > > > Co-developed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Co-developed-by: Alistair Francis <alistair.francis@wdc.com>
> > > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > > ---
> > > >  fs/sysfs/file.c  | 14 ++++++++++--
> > > >  fs/sysfs/group.c | 56 ++++++++++++++++++++++++++++++++++++--------=
----
> > > >  2 files changed, 54 insertions(+), 16 deletions(-)
> > > >
> > > > diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
> > > > index a12ac0356c69..7aab6c09662c 100644
> > > > --- a/fs/sysfs/file.c
> > > > +++ b/fs/sysfs/file.c
> > > > @@ -391,8 +391,18 @@ int sysfs_add_file_to_group(struct kobject *ko=
bj,
> > > >           kernfs_get(parent);
> > > >   }
> > > >
> > > > - if (!parent)
> > > > -         return -ENOENT;
> > > > + if (!parent) {
> > > > +         parent =3D kernfs_create_dir_ns(kobj->sd, group,
> > > > +                                   S_IRWXU | S_IRUGO | S_IXUGO,
> > > > +                                   uid, gid, kobj, NULL);
> > > > +         if (IS_ERR(parent)) {
> > > > +                 if (PTR_ERR(parent) =3D=3D -EEXIST)
> > > > +                         sysfs_warn_dup(kobj->sd, group);
> > > > +                 return PTR_ERR(parent);
> > > > +         }
> > > > +
> > > > +         kernfs_get(parent);
> > > > + }
> > > >
> > > >   kobject_get_ownership(kobj, &uid, &gid);
> > > >   error =3D sysfs_add_file_mode_ns(parent, attr, attr->mode, uid, g=
id,
> > > > diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
> > > > index 138676463336..013fa333cd3c 100644
> > > > --- a/fs/sysfs/group.c
> > > > +++ b/fs/sysfs/group.c
> > > > @@ -31,12 +31,14 @@ static void remove_files(struct kernfs_node *pa=
rent,
> > > >                   kernfs_remove_by_name(parent, (*bin_attr)->attr.n=
ame);
> > > >  }
> > > >
> > > > +/* returns -ERROR if error, or >=3D 0 for number of files actually=
 created */
> > > >  static int create_files(struct kernfs_node *parent, struct kobject=
 *kobj,
> > > >                   kuid_t uid, kgid_t gid,
> > > >                   const struct attribute_group *grp, int update)
> > > >  {
> > > >   struct attribute *const *attr;
> > > >   struct bin_attribute *const *bin_attr;
> > > > + int files_created =3D 0;
> > > >   int error =3D 0, i;
> > > >
> > > >   if (grp->attrs) {
> > > > @@ -65,6 +67,8 @@ static int create_files(struct kernfs_node *paren=
t, struct kobject *kobj,
> > > >                                                  gid, NULL);
> > > >                   if (unlikely(error))
> > > >                           break;
> > > > +
> > > > +                 files_created++;
> > > >           }
> > > >           if (error) {
> > > >                   remove_files(parent, grp);
> > > > @@ -95,12 +99,15 @@ static int create_files(struct kernfs_node *par=
ent, struct kobject *kobj,
> > > >                                                      NULL);
> > > >                   if (error)
> > > >                           break;
> > > > +                 files_created++;
> > > >           }
> > > >           if (error)
> > > >                   remove_files(parent, grp);
> > > >   }
> > > >  exit:
> > > > - return error;
> > > > + if (error)
> > > > +         return error;
> > > > + return files_created;
> > > >  }
> > > >
> > > >
> > > > @@ -130,9 +137,14 @@ static int internal_create_group(struct kobjec=
t *kobj, int update,
> > > >           if (update) {
> > > >                   kn =3D kernfs_find_and_get(kobj->sd, grp->name);
> > > >                   if (!kn) {
> > > > -                         pr_warn("Can't update unknown attr grp na=
me: %s/%s\n",
> > > > -                                 kobj->name, grp->name);
> > > > -                         return -EINVAL;
> > > > +                         kn =3D kernfs_create_dir_ns(kobj->sd, grp=
->name,
> > > > +                                                   S_IRWXU | S_IRU=
GO | S_IXUGO,
> > > > +                                                   uid, gid, kobj,=
 NULL);
> > > > +                         if (IS_ERR(kn)) {
> > > > +                                 if (PTR_ERR(kn) =3D=3D -EEXIST)
> > > > +                                         sysfs_warn_dup(kobj->sd, =
grp->name);
> > > > +                                 return PTR_ERR(kn);
> > > > +                         }
> > > >                   }
> > > >           } else {
> > > >                   kn =3D kernfs_create_dir_ns(kobj->sd, grp->name,
> > > > @@ -150,11 +162,18 @@ static int internal_create_group(struct kobje=
ct *kobj, int update,
> > > >
> > > >   kernfs_get(kn);
> > > >   error =3D create_files(kn, kobj, uid, gid, grp, update);
> > > > - if (error) {
> > > > + if (error <=3D 0) {
> > > > +         /*
> > > > +          * If an error happened _OR_ if no files were created in =
the
> > > > +          * attribute group, and we have a name for this group, de=
lete
> > > > +          * the name so there's not an empty directory.
> > > > +          */
> > > >           if (grp->name)
> > > >                   kernfs_remove(kn);
> > > > + } else {
> > > > +         error =3D 0;
> > > > +         kernfs_put(kn);
> > > >   }
> > > > - kernfs_put(kn);
> > > >
> > > >   if (grp->name && update)
> > > >           kernfs_put(kn);
> > > > @@ -318,13 +337,12 @@ void sysfs_remove_groups(struct kobject *kobj=
,
> > > >  EXPORT_SYMBOL_GPL(sysfs_remove_groups);
> > > >
> > > >  /**
> > > > - * sysfs_merge_group - merge files into a pre-existing attribute g=
roup.
> > > > + * sysfs_merge_group - merge files into a attribute group.
> > > >   * @kobj:        The kobject containing the group.
> > > >   * @grp: The files to create and the attribute group they belong t=
o.
> > > >   *
> > > > - * This function returns an error if the group doesn't exist or an=
y of the
> > > > - * files already exist in that group, in which case none of the ne=
w files
> > > > - * are created.
> > > > + * This function returns an error if any of the files already exis=
t in
> > > > + * that group, in which case none of the new files are created.
> > > >   */
> > > >  int sysfs_merge_group(struct kobject *kobj,
> > > >                  const struct attribute_group *grp)
> > > > @@ -336,12 +354,22 @@ int sysfs_merge_group(struct kobject *kobj,
> > > >   struct attribute *const *attr;
> > > >   int i;
> > > >
> > > > - parent =3D kernfs_find_and_get(kobj->sd, grp->name);
> > > > - if (!parent)
> > > > -         return -ENOENT;
> > > > -
> > > >   kobject_get_ownership(kobj, &uid, &gid);
> > > >
> > > > + parent =3D kernfs_find_and_get(kobj->sd, grp->name);
> > > > + if (!parent) {
> > > > +         parent =3D kernfs_create_dir_ns(kobj->sd, grp->name,
> > > > +                                   S_IRWXU | S_IRUGO | S_IXUGO,
> > > > +                                   uid, gid, kobj, NULL);
> > > > +         if (IS_ERR(parent)) {
> > > > +                 if (PTR_ERR(parent) =3D=3D -EEXIST)
> > > > +                         sysfs_warn_dup(kobj->sd, grp->name);
> > > > +                 return PTR_ERR(parent);
> > > > +         }
> > > > +
> > > > +         kernfs_get(parent);
> > > > + }
> > > > +
> > > >   for ((i =3D 0, attr =3D grp->attrs); *attr && !error; (++i, ++att=
r))
> > > >           error =3D sysfs_add_file_mode_ns(parent, *attr, (*attr)->=
mode,
> > > >                                          uid, gid, NULL);
> > > > --
> > > > 2.42.0
> > > >
> > >
> > > And as the 0-day bot just showed, this patch isn't going to work
> > > properly, the uid/gid stuff isn't all hooked up properly, I'll work o=
n
> > > fixing that up when I get some cycles...
> >
> > Oops, nope, that was my fault in applying this to my tree, sorry for th=
e
> > noise...
>
> And I just got around to testing this, and it does not boot at all.
> Below is the patch I am using, are you sure you got this to boot for
> you?

I just checked again and it boots for me. What failure are you seeing?

Alistair

>
> thanks,
>
> greg k-h
>
> From db537de5a5af649b594604e2de177527f890878d Mon Sep 17 00:00:00 2001
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Date: Wed, 24 Aug 2022 15:45:36 +0200
> Subject: [PATCH] sysfs: do not create empty directories if no attributes =
are
>  present
>
> When creating an attribute group, if it is named a subdirectory is
> created and the sysfs files are placed into that subdirectory.  If no
> files are created, normally the directory would still be present, but it
> would be empty.  Clean this up by removing the directory if no files
> were successfully created in the group at all.
>
> Co-developed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Co-developed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  fs/sysfs/file.c  | 16 +++++++++++---
>  fs/sysfs/group.c | 56 ++++++++++++++++++++++++++++++++++++------------
>  2 files changed, 55 insertions(+), 17 deletions(-)
>
> diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
> index a12ac0356c69..9f79ec193ffe 100644
> --- a/fs/sysfs/file.c
> +++ b/fs/sysfs/file.c
> @@ -391,10 +391,20 @@ int sysfs_add_file_to_group(struct kobject *kobj,
>                 kernfs_get(parent);
>         }
>
> -       if (!parent)
> -               return -ENOENT;
> -
>         kobject_get_ownership(kobj, &uid, &gid);
> +       if (!parent) {
> +               parent =3D kernfs_create_dir_ns(kobj->sd, group,
> +                                         S_IRWXU | S_IRUGO | S_IXUGO,
> +                                         uid, gid, kobj, NULL);
> +               if (IS_ERR(parent)) {
> +                       if (PTR_ERR(parent) =3D=3D -EEXIST)
> +                               sysfs_warn_dup(kobj->sd, group);
> +                       return PTR_ERR(parent);
> +               }
> +
> +               kernfs_get(parent);
> +       }
> +
>         error =3D sysfs_add_file_mode_ns(parent, attr, attr->mode, uid, g=
id,
>                                        NULL);
>         kernfs_put(parent);
> diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
> index 138676463336..013fa333cd3c 100644
> --- a/fs/sysfs/group.c
> +++ b/fs/sysfs/group.c
> @@ -31,12 +31,14 @@ static void remove_files(struct kernfs_node *parent,
>                         kernfs_remove_by_name(parent, (*bin_attr)->attr.n=
ame);
>  }
>
> +/* returns -ERROR if error, or >=3D 0 for number of files actually creat=
ed */
>  static int create_files(struct kernfs_node *parent, struct kobject *kobj=
,
>                         kuid_t uid, kgid_t gid,
>                         const struct attribute_group *grp, int update)
>  {
>         struct attribute *const *attr;
>         struct bin_attribute *const *bin_attr;
> +       int files_created =3D 0;
>         int error =3D 0, i;
>
>         if (grp->attrs) {
> @@ -65,6 +67,8 @@ static int create_files(struct kernfs_node *parent, str=
uct kobject *kobj,
>                                                        gid, NULL);
>                         if (unlikely(error))
>                                 break;
> +
> +                       files_created++;
>                 }
>                 if (error) {
>                         remove_files(parent, grp);
> @@ -95,12 +99,15 @@ static int create_files(struct kernfs_node *parent, s=
truct kobject *kobj,
>                                                            NULL);
>                         if (error)
>                                 break;
> +                       files_created++;
>                 }
>                 if (error)
>                         remove_files(parent, grp);
>         }
>  exit:
> -       return error;
> +       if (error)
> +               return error;
> +       return files_created;
>  }
>
>
> @@ -130,9 +137,14 @@ static int internal_create_group(struct kobject *kob=
j, int update,
>                 if (update) {
>                         kn =3D kernfs_find_and_get(kobj->sd, grp->name);
>                         if (!kn) {
> -                               pr_warn("Can't update unknown attr grp na=
me: %s/%s\n",
> -                                       kobj->name, grp->name);
> -                               return -EINVAL;
> +                               kn =3D kernfs_create_dir_ns(kobj->sd, grp=
->name,
> +                                                         S_IRWXU | S_IRU=
GO | S_IXUGO,
> +                                                         uid, gid, kobj,=
 NULL);
> +                               if (IS_ERR(kn)) {
> +                                       if (PTR_ERR(kn) =3D=3D -EEXIST)
> +                                               sysfs_warn_dup(kobj->sd, =
grp->name);
> +                                       return PTR_ERR(kn);
> +                               }
>                         }
>                 } else {
>                         kn =3D kernfs_create_dir_ns(kobj->sd, grp->name,
> @@ -150,11 +162,18 @@ static int internal_create_group(struct kobject *ko=
bj, int update,
>
>         kernfs_get(kn);
>         error =3D create_files(kn, kobj, uid, gid, grp, update);
> -       if (error) {
> +       if (error <=3D 0) {
> +               /*
> +                * If an error happened _OR_ if no files were created in =
the
> +                * attribute group, and we have a name for this group, de=
lete
> +                * the name so there's not an empty directory.
> +                */
>                 if (grp->name)
>                         kernfs_remove(kn);
> +       } else {
> +               error =3D 0;
> +               kernfs_put(kn);
>         }
> -       kernfs_put(kn);
>
>         if (grp->name && update)
>                 kernfs_put(kn);
> @@ -318,13 +337,12 @@ void sysfs_remove_groups(struct kobject *kobj,
>  EXPORT_SYMBOL_GPL(sysfs_remove_groups);
>
>  /**
> - * sysfs_merge_group - merge files into a pre-existing attribute group.
> + * sysfs_merge_group - merge files into a attribute group.
>   * @kobj:      The kobject containing the group.
>   * @grp:       The files to create and the attribute group they belong t=
o.
>   *
> - * This function returns an error if the group doesn't exist or any of t=
he
> - * files already exist in that group, in which case none of the new file=
s
> - * are created.
> + * This function returns an error if any of the files already exist in
> + * that group, in which case none of the new files are created.
>   */
>  int sysfs_merge_group(struct kobject *kobj,
>                        const struct attribute_group *grp)
> @@ -336,12 +354,22 @@ int sysfs_merge_group(struct kobject *kobj,
>         struct attribute *const *attr;
>         int i;
>
> -       parent =3D kernfs_find_and_get(kobj->sd, grp->name);
> -       if (!parent)
> -               return -ENOENT;
> -
>         kobject_get_ownership(kobj, &uid, &gid);
>
> +       parent =3D kernfs_find_and_get(kobj->sd, grp->name);
> +       if (!parent) {
> +               parent =3D kernfs_create_dir_ns(kobj->sd, grp->name,
> +                                         S_IRWXU | S_IRUGO | S_IXUGO,
> +                                         uid, gid, kobj, NULL);
> +               if (IS_ERR(parent)) {
> +                       if (PTR_ERR(parent) =3D=3D -EEXIST)
> +                               sysfs_warn_dup(kobj->sd, grp->name);
> +                       return PTR_ERR(parent);
> +               }
> +
> +               kernfs_get(parent);
> +       }
> +
>         for ((i =3D 0, attr =3D grp->attrs); *attr && !error; (++i, ++att=
r))
>                 error =3D sysfs_add_file_mode_ns(parent, *attr, (*attr)->=
mode,
>                                                uid, gid, NULL);
> --
> 2.42.0
>
