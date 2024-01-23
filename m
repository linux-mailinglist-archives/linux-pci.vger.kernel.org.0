Return-Path: <linux-pci+bounces-2453-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEF283863A
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 05:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F79728C686
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jan 2024 04:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA26A1848;
	Tue, 23 Jan 2024 04:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAIHJxr3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2D617FE;
	Tue, 23 Jan 2024 04:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705982683; cv=none; b=FrwHL+69pZzFDEVOSV25OOxjSHvP/8H6KDBwIBV+zG8j3TucmvAA4wUM2zd4FCbW7LQUj6TcHjhf0UszaIx5Y+/7QN93WdiCJ40l83cMv/vcv0qDqeAiiI6O3bWCVQ3ISxDMW91SkVBTTw7Rk9i8dIGHQkZ7kabVnHOFBW15+/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705982683; c=relaxed/simple;
	bh=tG7RFssnxbFsUJ50LPvI1lohXq0n9lLaoMbBnKMWR8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bXB29j4f+w0iN1Y2/sWx+6NYaPLfI2Pxw7bycwDRvo05mrA/aBtmDExbmPcXSP30dAd2zXIUfjDiX7RrKnGhfluRnmJjHZfFSAq3UlUMcx0zoacZtrBZ0pc6i08u8n0HAqYYlCVaqNZwQhrvuA/Sdel4XtfzHkG6AuMvPR1GxZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAIHJxr3; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7d2e16b552dso780889241.1;
        Mon, 22 Jan 2024 20:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705982680; x=1706587480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezMdSZJKz9uA+eMcqlKVnMmppUiFOed2hXWje11o5lQ=;
        b=VAIHJxr3lG1D4Aog7Guw3DXn5v1JlvZQScGTxTRfh5/cRENpPEcElz9tgjUN8xT74P
         d/yLJ5/fyoYS7K6B0y0p6PX+xyfb2zlwUzNbFbUiPcZDMMXYGqdhUpGa4zq9A0UGnuBR
         XA4DsryKQYm2EpZWgD4rENQBouASnloEgonGlOqIoxRksqsRqlOkl8onczCPCU+xjiUc
         5ajWLi4/HO/NXBrF9eYEh8RSUViVUNGjde5NChm8y6JDT+dElGVqwS14J9cko8j0m4qT
         jdziasO6/UieVYWmJC7fzfScoTzyhRxD8AlW3nzyipr4OSlrJvHdsEh0BdbJTYHuhLj9
         tIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705982680; x=1706587480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ezMdSZJKz9uA+eMcqlKVnMmppUiFOed2hXWje11o5lQ=;
        b=WNWdprgzt5VGjqiNC3trpyP04y5inxRJ77y+5LK5B/3myS/Dc6hOkRhhnXi+apCWPa
         QbDV3DSiUgBNF0mhnvFPUKg6g13H0S2Va0ekM4IQVO0WzyZaVntcJfiz76PRWFwhiYsu
         NwHvJCnAU7fQ9az7yssdYFTpF7mFWTw4j3vd8nKb2/Yf9wQ/0dv2vZr66lDjhsHk/dbC
         gBF+8opVZECzWG6RMifs5WX8guVRCYAIDVSs9L2TaymaN6dQcndXDt6rxCNHyP0HE64o
         P7JfdU4YfavEvrPoR9ZuCkFWzycbCgxTvA19RrlOaCMyH8bp1jp/s87p8wE7yb9OWiGd
         CzzA==
X-Gm-Message-State: AOJu0YxO0cbzigQ1Gn2aTKslqOUAi7yuHnCdpb5IoloSumh1WecE6SsV
	Mpo4zfUr9c9S0tNuexS8mcMreCBn6SHScqCoa08v4QzXEC2K44Lw8RXlBu7hVrukzWyd0P4mEat
	H3/Pry9M0A5Mqdkq38gN4mQMm8tc=
X-Google-Smtp-Source: AGHT+IHkpKiFNaQ0iPzvFdnTjt81uKJNsg1l2WScqVXes9u+Xwc4kBmkun0kcPmsrLr+3I3TuViW8ISlgdwx6wTd7lo=
X-Received: by 2002:a67:fe8d:0:b0:46a:f85e:46ec with SMTP id
 b13-20020a67fe8d000000b0046af85e46ecmr163979vsr.13.1705982680497; Mon, 22 Jan
 2024 20:04:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230817235810.596458-2-alistair.francis@wdc.com>
 <2023081959-spinach-cherisher-b025@gregkh> <CAKmqyKM+DNTF1f0FvDEda_db792Ta4w_uAKNTZ6E3NkYoVcPFQ@mail.gmail.com>
 <2023082325-cognitive-dispose-1180@gregkh> <CAKmqyKMMKJN7HU_achBc8S6-Jx16owrthwDDRWysMZe=jymnMA@mail.gmail.com>
 <2023083111-impulsive-majestic-24ee@gregkh> <2023083139-underling-amuser-772e@gregkh>
 <2023090142-circling-probably-7828@gregkh> <2023100539-playgroup-stoppable-d5d4@gregkh>
 <CAKmqyKOgej1jiiHsoLuDKXwdLDGa4njrndu6c1=bxnqk2NM58Q@mail.gmail.com>
 <2023101113-swimwear-squealer-464c@gregkh> <CAKmqyKMX3HDphrWHYcdnLEjMwe1pCROcPNZchPonhsLOq=FoHw@mail.gmail.com>
In-Reply-To: <CAKmqyKMX3HDphrWHYcdnLEjMwe1pCROcPNZchPonhsLOq=FoHw@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 23 Jan 2024 14:04:14 +1000
Message-ID: <CAKmqyKOOSBF7qDpqAp6nn3+3wAnaGmqu88Fk3KY58fmgQ-44Jw@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] sysfs: Add a attr_is_visible function to attribute_group
To: Greg KH <gregkh@linuxfoundation.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
	Jonathan.Cameron@huawei.com, lukas@wunner.de, alex.williamson@redhat.com, 
	christian.koenig@amd.com, kch@nvidia.com, logang@deltatee.com, 
	linux-kernel@vger.kernel.org, chaitanyak@nvidia.com, rdunlap@infradead.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 2:31=E2=80=AFPM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> On Wed, Oct 11, 2023 at 4:44=E2=80=AFPM Greg KH <gregkh@linuxfoundation.o=
rg> wrote:
> >
> > On Wed, Oct 11, 2023 at 03:10:39PM +1000, Alistair Francis wrote:
> > > On Thu, Oct 5, 2023 at 11:05=E2=80=AFPM Greg KH <gregkh@linuxfoundati=
on.org> wrote:
> > > >
> > > > On Fri, Sep 01, 2023 at 11:00:59PM +0200, Greg KH wrote:
> > > > > On Thu, Aug 31, 2023 at 04:36:13PM +0200, Greg KH wrote:
> > > > > > On Thu, Aug 31, 2023 at 10:31:07AM +0200, Greg KH wrote:
> > > > > > > On Mon, Aug 28, 2023 at 03:05:41PM +1000, Alistair Francis wr=
ote:
> > > > > > > > On Wed, Aug 23, 2023 at 5:02=E2=80=AFPM Greg KH <gregkh@lin=
uxfoundation.org> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, Aug 22, 2023 at 04:20:06PM -0400, Alistair Franci=
s wrote:
> > > > > > > > > > On Sat, Aug 19, 2023 at 6:57=E2=80=AFAM Greg KH <gregkh=
@linuxfoundation.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Thu, Aug 17, 2023 at 07:58:09PM -0400, Alistair Fr=
ancis wrote:
> > > > > > > > > > > > The documentation for sysfs_merge_group() specifica=
lly says
> > > > > > > > > > > >
> > > > > > > > > > > >     This function returns an error if the group doe=
sn't exist or any of the
> > > > > > > > > > > >     files already exist in that group, in which cas=
e none of the new files
> > > > > > > > > > > >     are created.
> > > > > > > > > > > >
> > > > > > > > > > > > So just not adding the group if it's empty doesn't =
work, at least not
> > > > > > > > > > > > with the code we currently have. The code can be ch=
anged to support
> > > > > > > > > > > > this, but it is difficult to determine how this wil=
l affect existing use
> > > > > > > > > > > > cases.
> > > > > > > > > > >
> > > > > > > > > > > Did you try?  I'd really really really prefer we do i=
t this way as it's
> > > > > > > > > > > much simpler overall to have the sysfs core "do the r=
ight thing
> > > > > > > > > > > automatically" than to force each and every bus/subsy=
stem to have to
> > > > > > > > > > > manually add this type of attribute.
> > > > > > > > > > >
> > > > > > > > > > > Also, on a personal level, I want this function to wo=
rk as it will allow
> > > > > > > > > > > us to remove some code in some busses that don't real=
ly need to be there
> > > > > > > > > > > (dynamic creation of some device attributes), which w=
ill then also allow
> > > > > > > > > > > me to remove some apis in the driver core that should=
 not be used at all
> > > > > > > > > > > anymore (but keep creeping back in as there is still =
a few users.)
> > > > > > > > > > >
> > > > > > > > > > > So I'll be selfish here and say "please try to get my=
 proposed change to
> > > > > > > > > > > work, it's really the correct thing to do here."
> > > > > > > > > >
> > > > > > > > > > I did try!
> > > > > > > > > >
> > > > > > > > > > This is an attempt:
> > > > > > > > > > https://github.com/alistair23/linux/commit/56b55756a2d7=
a66f7b6eb8a5692b1b5e2f81a9a9
> > > > > > > > > >
> > > > > > > > > > It is based on your original patch with a bunch of:
> > > > > > > > > >
> > > > > > > > > > if (!parent) {
> > > > > > > > > >     parent =3D kernfs_create_dir_ns(kobj->sd, grp->name=
,
> > > > > > > > > >                   S_IRWXU | S_IRUGO | S_IXUGO,
> > > > > > > > > >                   uid, gid, kobj, NULL);
> > > > > > > > > >     ...
> > > > > > > > > >     }
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > added throughout the code base.
> > > > > > > > > >
> > > > > > > > > > Very basic testing shows that it does what I need it to=
 do and I don't
> > > > > > > > > > see any kernel oops on boot.
> > > > > > > > >
> > > > > > > > > Nice!
> > > > > > > > >
> > > > > > > > > Mind if I take it and clean it up a bit and test with it =
here?  Again, I
> > > > > > > > > need this functionality for other stuff as well, so getti=
ng it merged
> > > > > > > > > for your feature is fine with me.
> > > > > > > >
> > > > > > > > Sure! Go ahead. Sorry I was travelling last week.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > I prefer the approach I have in this mailing list patch=
. But if you
> > > > > > > > > > like the commit mentioned above I can tidy and clean it=
 up and then
> > > > > > > > > > use that instead
> > > > > > > > >
> > > > > > > > > I would rather do it this way.  I can work on this on Fri=
day if you want
> > > > > > > > > me to.
> > > > > > > >
> > > > > > > > Yeah, that's fine with me. If you aren't able to let me kno=
w and I can
> > > > > > > > finish up the patch and send it with this series
> > > > > > >
> > > > > > > Great, and for the email record, as github links are not stab=
le, here's
> > > > > > > the patch that you have above attached below.  I'll test this=
 out and
> > > > > > > clean it up a bit more and see how it goes...
> > > > > > >
> > > > > > > thanks,
> > > > > > >
> > > > > > > greg k-h
> > > > > > >
> > > > > > >
> > > > > > > From 2929d17b58d02dcf52d0345fa966c616e09a5afa Mon Sep 17 00:0=
0:00 2001
> > > > > > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > > Date: Wed, 24 Aug 2022 15:45:36 +0200
> > > > > > > Subject: [PATCH] sysfs: do not create empty directories if no=
 attributes are
> > > > > > >  present
> > > > > > >
> > > > > > > When creating an attribute group, if it is named a subdirecto=
ry is
> > > > > > > created and the sysfs files are placed into that subdirectory=
.  If no
> > > > > > > files are created, normally the directory would still be pres=
ent, but it
> > > > > > > would be empty.  Clean this up by removing the directory if n=
o files
> > > > > > > were successfully created in the group at all.
> > > > > > >
> > > > > > > Co-developed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.o=
rg>
> > > > > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org=
>
> > > > > > > Co-developed-by: Alistair Francis <alistair.francis@wdc.com>
> > > > > > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > > > > > ---
> > > > > > >  fs/sysfs/file.c  | 14 ++++++++++--
> > > > > > >  fs/sysfs/group.c | 56 ++++++++++++++++++++++++++++++++++++--=
----------
> > > > > > >  2 files changed, 54 insertions(+), 16 deletions(-)
> > > > > > >
> > > > > > > diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
> > > > > > > index a12ac0356c69..7aab6c09662c 100644
> > > > > > > --- a/fs/sysfs/file.c
> > > > > > > +++ b/fs/sysfs/file.c
> > > > > > > @@ -391,8 +391,18 @@ int sysfs_add_file_to_group(struct kobje=
ct *kobj,
> > > > > > >           kernfs_get(parent);
> > > > > > >   }
> > > > > > >
> > > > > > > - if (!parent)
> > > > > > > -         return -ENOENT;
> > > > > > > + if (!parent) {
> > > > > > > +         parent =3D kernfs_create_dir_ns(kobj->sd, group,
> > > > > > > +                                   S_IRWXU | S_IRUGO | S_IXU=
GO,
> > > > > > > +                                   uid, gid, kobj, NULL);
> > > > > > > +         if (IS_ERR(parent)) {
> > > > > > > +                 if (PTR_ERR(parent) =3D=3D -EEXIST)
> > > > > > > +                         sysfs_warn_dup(kobj->sd, group);
> > > > > > > +                 return PTR_ERR(parent);
> > > > > > > +         }
> > > > > > > +
> > > > > > > +         kernfs_get(parent);
> > > > > > > + }
> > > > > > >
> > > > > > >   kobject_get_ownership(kobj, &uid, &gid);
> > > > > > >   error =3D sysfs_add_file_mode_ns(parent, attr, attr->mode, =
uid, gid,
> > > > > > > diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
> > > > > > > index 138676463336..013fa333cd3c 100644
> > > > > > > --- a/fs/sysfs/group.c
> > > > > > > +++ b/fs/sysfs/group.c
> > > > > > > @@ -31,12 +31,14 @@ static void remove_files(struct kernfs_no=
de *parent,
> > > > > > >                   kernfs_remove_by_name(parent, (*bin_attr)->=
attr.name);
> > > > > > >  }
> > > > > > >
> > > > > > > +/* returns -ERROR if error, or >=3D 0 for number of files ac=
tually created */
> > > > > > >  static int create_files(struct kernfs_node *parent, struct k=
object *kobj,
> > > > > > >                   kuid_t uid, kgid_t gid,
> > > > > > >                   const struct attribute_group *grp, int upda=
te)
> > > > > > >  {
> > > > > > >   struct attribute *const *attr;
> > > > > > >   struct bin_attribute *const *bin_attr;
> > > > > > > + int files_created =3D 0;
> > > > > > >   int error =3D 0, i;
> > > > > > >
> > > > > > >   if (grp->attrs) {
> > > > > > > @@ -65,6 +67,8 @@ static int create_files(struct kernfs_node =
*parent, struct kobject *kobj,
> > > > > > >                                                  gid, NULL);
> > > > > > >                   if (unlikely(error))
> > > > > > >                           break;
> > > > > > > +
> > > > > > > +                 files_created++;
> > > > > > >           }
> > > > > > >           if (error) {
> > > > > > >                   remove_files(parent, grp);
> > > > > > > @@ -95,12 +99,15 @@ static int create_files(struct kernfs_nod=
e *parent, struct kobject *kobj,
> > > > > > >                                                      NULL);
> > > > > > >                   if (error)
> > > > > > >                           break;
> > > > > > > +                 files_created++;
> > > > > > >           }
> > > > > > >           if (error)
> > > > > > >                   remove_files(parent, grp);
> > > > > > >   }
> > > > > > >  exit:
> > > > > > > - return error;
> > > > > > > + if (error)
> > > > > > > +         return error;
> > > > > > > + return files_created;
> > > > > > >  }
> > > > > > >
> > > > > > >
> > > > > > > @@ -130,9 +137,14 @@ static int internal_create_group(struct =
kobject *kobj, int update,
> > > > > > >           if (update) {
> > > > > > >                   kn =3D kernfs_find_and_get(kobj->sd, grp->n=
ame);
> > > > > > >                   if (!kn) {
> > > > > > > -                         pr_warn("Can't update unknown attr =
grp name: %s/%s\n",
> > > > > > > -                                 kobj->name, grp->name);
> > > > > > > -                         return -EINVAL;
> > > > > > > +                         kn =3D kernfs_create_dir_ns(kobj->s=
d, grp->name,
> > > > > > > +                                                   S_IRWXU |=
 S_IRUGO | S_IXUGO,
> > > > > > > +                                                   uid, gid,=
 kobj, NULL);
> > > > > > > +                         if (IS_ERR(kn)) {
> > > > > > > +                                 if (PTR_ERR(kn) =3D=3D -EEX=
IST)
> > > > > > > +                                         sysfs_warn_dup(kobj=
->sd, grp->name);
> > > > > > > +                                 return PTR_ERR(kn);
> > > > > > > +                         }
> > > > > > >                   }
> > > > > > >           } else {
> > > > > > >                   kn =3D kernfs_create_dir_ns(kobj->sd, grp->=
name,
> > > > > > > @@ -150,11 +162,18 @@ static int internal_create_group(struct=
 kobject *kobj, int update,
> > > > > > >
> > > > > > >   kernfs_get(kn);
> > > > > > >   error =3D create_files(kn, kobj, uid, gid, grp, update);
> > > > > > > - if (error) {
> > > > > > > + if (error <=3D 0) {
> > > > > > > +         /*
> > > > > > > +          * If an error happened _OR_ if no files were creat=
ed in the
> > > > > > > +          * attribute group, and we have a name for this gro=
up, delete
> > > > > > > +          * the name so there's not an empty directory.
> > > > > > > +          */
> > > > > > >           if (grp->name)
> > > > > > >                   kernfs_remove(kn);
> > > > > > > + } else {
> > > > > > > +         error =3D 0;
> > > > > > > +         kernfs_put(kn);
> > > > > > >   }
> > > > > > > - kernfs_put(kn);
> > > > > > >
> > > > > > >   if (grp->name && update)
> > > > > > >           kernfs_put(kn);
> > > > > > > @@ -318,13 +337,12 @@ void sysfs_remove_groups(struct kobject=
 *kobj,
> > > > > > >  EXPORT_SYMBOL_GPL(sysfs_remove_groups);
> > > > > > >
> > > > > > >  /**
> > > > > > > - * sysfs_merge_group - merge files into a pre-existing attri=
bute group.
> > > > > > > + * sysfs_merge_group - merge files into a attribute group.
> > > > > > >   * @kobj:        The kobject containing the group.
> > > > > > >   * @grp: The files to create and the attribute group they be=
long to.
> > > > > > >   *
> > > > > > > - * This function returns an error if the group doesn't exist=
 or any of the
> > > > > > > - * files already exist in that group, in which case none of =
the new files
> > > > > > > - * are created.
> > > > > > > + * This function returns an error if any of the files alread=
y exist in
> > > > > > > + * that group, in which case none of the new files are creat=
ed.
> > > > > > >   */
> > > > > > >  int sysfs_merge_group(struct kobject *kobj,
> > > > > > >                  const struct attribute_group *grp)
> > > > > > > @@ -336,12 +354,22 @@ int sysfs_merge_group(struct kobject *k=
obj,
> > > > > > >   struct attribute *const *attr;
> > > > > > >   int i;
> > > > > > >
> > > > > > > - parent =3D kernfs_find_and_get(kobj->sd, grp->name);
> > > > > > > - if (!parent)
> > > > > > > -         return -ENOENT;
> > > > > > > -
> > > > > > >   kobject_get_ownership(kobj, &uid, &gid);
> > > > > > >
> > > > > > > + parent =3D kernfs_find_and_get(kobj->sd, grp->name);
> > > > > > > + if (!parent) {
> > > > > > > +         parent =3D kernfs_create_dir_ns(kobj->sd, grp->name=
,
> > > > > > > +                                   S_IRWXU | S_IRUGO | S_IXU=
GO,
> > > > > > > +                                   uid, gid, kobj, NULL);
> > > > > > > +         if (IS_ERR(parent)) {
> > > > > > > +                 if (PTR_ERR(parent) =3D=3D -EEXIST)
> > > > > > > +                         sysfs_warn_dup(kobj->sd, grp->name)=
;
> > > > > > > +                 return PTR_ERR(parent);
> > > > > > > +         }
> > > > > > > +
> > > > > > > +         kernfs_get(parent);
> > > > > > > + }
> > > > > > > +
> > > > > > >   for ((i =3D 0, attr =3D grp->attrs); *attr && !error; (++i,=
 ++attr))
> > > > > > >           error =3D sysfs_add_file_mode_ns(parent, *attr, (*a=
ttr)->mode,
> > > > > > >                                          uid, gid, NULL);
> > > > > > > --
> > > > > > > 2.42.0
> > > > > > >
> > > > > >
> > > > > > And as the 0-day bot just showed, this patch isn't going to wor=
k
> > > > > > properly, the uid/gid stuff isn't all hooked up properly, I'll =
work on
> > > > > > fixing that up when I get some cycles...
> > > > >
> > > > > Oops, nope, that was my fault in applying this to my tree, sorry =
for the
> > > > > noise...
> > > >
> > > > And I just got around to testing this, and it does not boot at all.
> > > > Below is the patch I am using, are you sure you got this to boot fo=
r
> > > > you?
> > >
> > > I just checked again and it boots for me. What failure are you seeing=
?
> >
> > Block devices were not created properly in sysfs.
>
> Strange. I have tested this on a QEMU virtual machine and a x86 PC and
> I don't see any issues on either.
>
> >
> > Did you test your patch, or my modified one that I attached on this
> > email?  That might be the difference.
>
> I'm using your modified one.
>
> Are you able to provide logs? There must be some driver that is
> causing the issue. I can try to reproduce it if I know where it's
> failing.

Hey Greg,

I wanted to follow up on this and see if you are able to provide more
details for reproducing or if you are able to look into it?

Alistair

>
> Alistair
>
> >
> > thanks,
> >
> > greg k-h

