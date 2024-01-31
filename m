Return-Path: <linux-pci+bounces-2853-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5332A843454
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 04:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A1CD286DBB
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 03:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB07CEAC5;
	Wed, 31 Jan 2024 03:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUknGrsh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5545518623
	for <linux-pci@vger.kernel.org>; Wed, 31 Jan 2024 03:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706670243; cv=none; b=ZVyJTk8haEF8dqpGi8eSbMCtxjm/J0GvA6iLqYEp3A0EBg6GsMOWAbfziSoM6J6VV9dF1f8rPCPBxpCZAKQw1GMfFLewUwys8W8O8mUdV5kM0d8GDJs9eaFabor1PYnV6uajW29Dgl9zwMemBDHQ5B58A0a6TnMs/t3TweO7EBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706670243; c=relaxed/simple;
	bh=XW3RkLwU3RnICL0oSlLgJnoTpotC6aUY9xlkDPz+nH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h64Hue8LbcXewVIoDnkNm5iPtWJQhVRS/eIHb4P3jVTN98MLmtAeHzqIJTcfB6GA/dDHRSaTeaY0w394Afwqi7sCmscYW2Q5SM62Chc3axXCTX5MASSYVQ0hRl+SiIg8cFq9y8LUnXREGSnh4vswemL4oBLCMsa2KV+JcEL8cMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUknGrsh; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4b7e4a108cbso640333e0c.1
        for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2024 19:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706670241; x=1707275041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCE0VCmBjMQbQLUP7km1QuNcCCbnI1403YQrpW5aJug=;
        b=IUknGrshIL1j565sxIk6HUZoAAQ+q2jwyDwpo5tMZybdivm6Ka30TYR5rk+eRlRUQC
         ErHgOSFapuy1z7M1uwIAUSbpIp4s1DzNZIN5EyP5r/Q5+ngyTCd2IWRSpsD1CoLwUXkR
         1f8Oz9Q+gWi+Cn6B/FjLS6eVfT6TxcbT529wYtMLQ9sqAt1URBDzZJFuT57nTrQoAk63
         KVSxv8P5xzmMuFH3RXynCZqN+E9tfsPOLZvVXseOfvSNdMGbRwo3qHf8ViKc0hv5CZ4s
         3UxUpl3nHZeM4r64UVjFNjdvJ+Ny/x3T1H1/0cb0GP+Fb/4/+GCUfbmnIJn3JLMG+eTv
         HKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706670241; x=1707275041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MCE0VCmBjMQbQLUP7km1QuNcCCbnI1403YQrpW5aJug=;
        b=belG3LyICX+nhpNcaJ9yc858mUlvgtRUDCJg9Owk/erkFcrWoSvRx+u6k9piVFypI9
         ExNJsBlbsE47NkXBIfIQun8lGq2F9m1XckY+xzYpCRXzCPIwY8o4qr79Ur8NJ+5+J1PE
         iZZN8oxEp+zzucNEQkc6BfDEDt4/hn38KT+pTwGdDLCYYOYBTC/u8huhcL4PsvNAqlSO
         11sRIstxXj/LKYiE8GetxUI2YuuVcX3pLuHAbwCQxXHE09Viioe3cD6oJhQu0SrzNip3
         5clhoAT3/xy94DmZUcutiRNymksehuY4QNH4irM+fIX9xfdt/uncZ59/ugZ6GnJ1RMLE
         IFGQ==
X-Gm-Message-State: AOJu0YzN6PIVDHBr7s92pUWfq3Jg9o8ZLYTym3+vsLC3qIXDJTysXiiD
	db0tNSwEIQPFDChwKsumVIPxNjeiwAD+cxB+aIODo85b9y0j9VM79hYdoDLBCwzHVTKqjLgAvyx
	fTxr6xtagXbbMsKQ/OK1EtGPJOxI=
X-Google-Smtp-Source: AGHT+IE/DPiPkxHwI+Uf6GLfOwGEFezcuxNnMd+AxOxsjcSWR95Qybm6vndzmo4AaTiVeulSig+LQVMuMf768Dta38U=
X-Received: by 2002:a05:6122:a20:b0:4b6:e3fa:7599 with SMTP id
 32-20020a0561220a2000b004b6e3fa7599mr370426vkn.0.1706670241022; Tue, 30 Jan
 2024 19:04:01 -0800 (PST)
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
Date: Wed, 31 Jan 2024 08:33:49 +0530
Message-ID: <CAAgyjC8Mfe8oZXCmo15wYMyoGUcDMbp0SUowbnU3rz3L6FOZsw@mail.gmail.com>
Subject: Re: memory access to mmaped pci sysfs file, does not fail when the
 pci device is removed.
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
Thanks for your response.
Adding few more points.
The patch mentioned above is making a difference. as part of open.
iomem file inode is being used for address space than sysfs file.  For
this reason mapping is still intact in spite of removing sysfs
nodes.(/sys/bus/pci/device/.../resource0).
To support "CONFIG_IO_STRICT_DEVMEM", revoking iomem like it is done
for /dev/mem, it is being done for sysfs path as well. which is a way
to map BAR to the user space and access it.

[PATCH 42/65] resource: Move devmem revoke code to resource framework
PCI: Revoke mappings like devmem :
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=
=3Dlinux-5.15.y&id=3D636b21b50152d4e203223ee337aca1cb3c1bfe53

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

