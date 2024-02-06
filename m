Return-Path: <linux-pci+bounces-3129-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D51A84AD43
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 05:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 604791C22B0F
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 04:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE4B6E2AD;
	Tue,  6 Feb 2024 04:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/tf2aEE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59970745D9
	for <linux-pci@vger.kernel.org>; Tue,  6 Feb 2024 04:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707192437; cv=none; b=txO5VPrrd3rh6b9e9E2ePwJ5iy5HpJpV4tQxYTOvE4pa8bP6UviSrQxs4lFKBUqtnqfe9h+Fu6oM0qKA8afP9K/zS0o65phlYnM4vKGIsEBlwPXblTC19rLzttT5b4v5N8llOti/QONZ/N9T2vWVCDS/YFjnoJZORpIOWHc4m/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707192437; c=relaxed/simple;
	bh=zokrW1f+16Qg+2O8GRlxfpab3AIL9zNH/c3bUo5qOLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p7XoNtLvAFqHZpqExW27jh7rX0q/rZLZXGGnlIYx0yw8b1ZdgTUQC7DB+yVkogeI+RXolskGN3Xczsob+qzTDazVqUnIfhR5EGpYVf3mq0yjIoV/2/aynM1aiSbwkyXykxLPhxmXjwZVX10dhS+2kAYONfkc4EIbaUD2xplFr0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/tf2aEE; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-467570ba746so1078215137.1
        for <linux-pci@vger.kernel.org>; Mon, 05 Feb 2024 20:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707192435; x=1707797235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LW8pqMVD9kMk/xl/hCgGyjJMUF2ET14pjFyj3oVX3yI=;
        b=e/tf2aEEK0l+rV6qHJVsZOcE5QoHDBJMoniQWQQC3RITUJfTGYf2TEUWyJXu5u9NJA
         lXdMUT4rq6F8asIkIWTh+m6xVnm+VRZJuIn7xoNJXTJx4Kg9fTBT2xxevY9jOD+ODMvG
         ZD8uwXkxsQrVd9lG2yHIetjq2kf75+SmEZft3Wjs2zmrDAO0oYOKijFN5NtBfCSPpd/P
         00MiWiybmir+KVKyXoNxjpQhNHz6YxkUND0AyrrB5PPbEB+Fl8m6ehv2jPZ3QrjvO+DU
         yOR5xu9gAHyz8ZaIW7o4ydXvhCdujRKZ0tB7XP8NrFzVR/79ZrK0++Uw3fL4r69V1enn
         0Vkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707192435; x=1707797235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LW8pqMVD9kMk/xl/hCgGyjJMUF2ET14pjFyj3oVX3yI=;
        b=TtgJZMpBSiALQrZpqyFtWnmSyjdqHhtXIJ72WFFJi1ne6TlVcT7UDucc5N856l8iHg
         64AScVipZicKIr7wyVxn78gwjgE9zuixX8onOkTRAXQ8WTurzJwaxaXK6GmY1HQRaFKi
         y6wrSmZnPfan6ti9B5rA7jMtA5vsxgoJ7PBsuIlCI0M0BhZaI6HEZGDxqvf/FG9RAoLp
         UhLRz3IYJWTJ8CJbGRSj/1YAc1UwyVhpwSX3xrQtwO4SMAbueEJythcx8hJnTjlY7+fz
         XWQViz85zz6jTa20c49kR88C6hAagbWGPQGQf68r9WyU3PmInvxqTSJWPWBTaY/99xvH
         xzdQ==
X-Gm-Message-State: AOJu0YwqRNaKJcY+HYGp1wvRT3yE2oeB4OzLnCEONdFEih+V0i0fADfO
	pzVOO5iS9tksva8332aQSPX5qOXh7Bi80OZQFdn2/xtwjpj4QO3WQw1o89aSLQJxIuy2VBtAMbx
	SHJlA4c5TehHfefZIbPeGAa8oR6A=
X-Google-Smtp-Source: AGHT+IFXAyTAq6+HgttUCGuwfa3I5MWdijdZ+pBGJAtbU7u4KQj6751ktnifUKthEkKr++iTuZ2sNfpGSOO10Z4BflQ=
X-Received: by 2002:a05:6122:925:b0:4c0:3cfc:6752 with SMTP id
 j37-20020a056122092500b004c03cfc6752mr1616796vka.1.1707192434963; Mon, 05 Feb
 2024 20:07:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAgyjC9ttHQxodPsVcrNKx2_2T9FTy_E6wZf_u3QbqGGs82P_w@mail.gmail.com>
 <20240130192856.GA527632@bhelgaas>
In-Reply-To: <20240130192856.GA527632@bhelgaas>
From: aravind <aravindk20@gmail.com>
Date: Tue, 6 Feb 2024 09:37:03 +0530
Message-ID: <CAAgyjC9t3iJmZML7x87dzsnSnSCfMcg48rfdxxP_G4NXnXD5tw@mail.gmail.com>
Subject: Re: memory access to mmaped pci sysfs file, does not fail when the
 pci device is removed.
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel
      Could you please comment ? Is there a way to clean up
mapping/unmap for the process when sysfs files are removed on pci
device removal?

Regards
Aravind SK

On Wed, Jan 31, 2024 at 12:58=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> [+cc Daniel (author of 74b30195395c), Greg]
>
> On Tue, Jan 30, 2024 at 08:50:10AM +0530, aravind wrote:
> > Hi,
> >  I am facing an issue in v5.15 kernel due to " [PATCH v7 12/17] PCI:
> > Revoke mappings like devmem "related changes.
> >  Whenever a PCI device (4f:00.0)is removed while being accessed from
> > user space (mmaped (sys/bus/pci/device/....4f:00.0/resource0)), no sig
> > bus error is raised. in earlier kernel v5.2, a sig bus error used to
> > get generated for this scenario.
> > In v5.15 5 kernel , value 0xffffffff is returned when the device is
> > plugged out or it is reset.
> > if the device is removed through "echo 1 >
> > /sys/bus/pci/devices/..4f:00.0/remove") command. user space code is
> > still able to access device memory no fault is generated in this case.
> > not sure if this is expected behavior. as the file which is mapped is
> > removed .(/sys/bus/pci/.../resource0)
> >
> > After making the below change in v5.15 , I am able to get fault for
> > above scenarios. (device removal or unplug/reset.)
> > Please let me know if this is a new feature introduced to handle
> > mmaped memory access holes ? and allow to work inspite of sysfs files
> > removal.
> >
> >
> > diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
> > index d019d6ac6ad0..5f9b59ba8320 100644
> > --- a/fs/sysfs/file.c
> > +++ b/fs/sysfs/file.c
> > @@ -251,7 +251,7 @@ static const struct kernfs_ops sysfs_bin_kfops_mmap=
 =3D {
> >         .read           =3D sysfs_kf_bin_read,
> >         .write          =3D sysfs_kf_bin_write,
> >         .mmap           =3D sysfs_kf_bin_mmap,
> > -       .open           =3D sysfs_kf_bin_open,
> > +//     .open           =3D sysfs_kf_bin_open,
> >  };
>
> If the change above makes the difference, I guess the change might be
> related to https://git.kernel.org/linus/74b30195395c ("sysfs: Support
> zapping of binary attr mmaps"), which appeared in v5.12.
>
> I agree that SIGBUS when accessing MMIO space of a device that has
> been removed sounds like a better experience than reading 0xffffffff.
>
> I don't know enough about the VM side of this to know just how
> 74b30195395c makes this difference.  Maybe Daniel will chime in.
>
> Bjorn



--=20
Aravind

