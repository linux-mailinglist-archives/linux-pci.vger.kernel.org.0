Return-Path: <linux-pci+bounces-42580-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB60C9FB33
	for <lists+linux-pci@lfdr.de>; Wed, 03 Dec 2025 16:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2389430141F9
	for <lists+linux-pci@lfdr.de>; Wed,  3 Dec 2025 15:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAD9308F13;
	Wed,  3 Dec 2025 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="RPuBiTOs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9C6314A91
	for <linux-pci@vger.kernel.org>; Wed,  3 Dec 2025 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764776799; cv=none; b=Lx056W9mJFXXnaJInwlolfB2n7iUjG+eeMkYepguICrfuzlDR0RzCnHZeqtGyIq0segUg8wpZ9CdOYPH38dxFc6pULxvVa9MybU//xUxfIfUApyKMoaC2UXLmmYRIb+R9eHtBVpCbhupX34s0nyk+CsD3eNL/qR13+Om0HAxp1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764776799; c=relaxed/simple;
	bh=9uir/666rpQjmBYhCBNN8Z50ojDfoysJShMBhMIvQsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sO5ba8w/+epAN6V83f5g/HZCMbI3yLP7ONz3AOi7cCZoNr+dMueKO1E7jmQMw3rfNoxBvnNMrfW1Azln0j30DzIxIgVmrr3+B2cMIWOBMvZozrrkaSo+tfe02bFfeYt62rBstsBUVaivslKAfnBkzLSzyIAfhvfMZ4QJqK23XBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=RPuBiTOs; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-640c6577120so12068364a12.1
        for <linux-pci@vger.kernel.org>; Wed, 03 Dec 2025 07:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1764776795; x=1765381595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9+8lbWW7UfBnkxY4lDzkEZXob5kb6NM+epeeBGpeEM=;
        b=RPuBiTOs7KpiqRqrubW5HNI3+bOkiKAnnuJpRV3yNivcQTEdTmVhe6fJg0QZfny5zX
         9qp9LYCMEPxmeju79QkWQmUakbmG3IS3sGH/lVW6L5xRF30gugTy+lnhbUkOvk3Rzb6F
         IGcZOZEOrR/yRkSpUSqh0C++3bdYvXnfu7AXPrrpmTXxysi1kKuO/tLtf653xnH1x43Y
         jcLQda1JQewqC3+vTGyU0Uc2FXoiPStx5Q7849+LvARff60NxnmpNq8t5uLCsRAO5Jsy
         /QXENCbg2YloU2FcYk/sKGqNb9A5yrrLuBZ3DVc0YArIUC0+xrbor0jH34nN2hPKM4UE
         gfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764776795; x=1765381595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+9+8lbWW7UfBnkxY4lDzkEZXob5kb6NM+epeeBGpeEM=;
        b=xCORsZPmK556G7V+Fm0lgdNfy1GUzg24ycRDjXwP2ZjDPwUcJwomltBtrUa4S+z4V+
         K6ONl448QNVfpoHrWICxmfaLJnJlEiWF+8CWMJ786/QJY5REMEy3ARUpDyDb+DtAxqeV
         lTQ3cG8b7hHxN9DNNFTtukmzmzSsPLk2uNZgm83SkAb4lamroqsLAVaMIA8ets6349fp
         TJ2BDnrlMmtNnC8sLsI2Iz3P5sIeBWzhOjSL22mV+oIy11mhgvGa/hann5kWgWPZ9ve8
         yjbkDBu2D2sjFb+SWdG8SVSOkwOVYry3XgHdvqd9aFLczyCihltVucsW7zu6vVZboAbu
         LJ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/+uLFdDW0GPRxS0QIgtbbIhFlDO3C/MsIMtQ1BOm0zVsqF1AexI+MhdA47tYRf0zii87R7/Yei8M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkm7uwdUJBrocLQFlSjDz7qBIjBhl3Yn1ArkCJPe9KxIJb55lp
	VtD8Beht487a/Z6uplpXWvHNUt08vQItO26dUdvTO6cU0BsDRlCDiideCQUHw6uULfBw1FUwn3R
	9rSX9Bi96mUkcYouthuq3ZXcbSt3XJ/azK4ZyHdrj0g==
X-Gm-Gg: ASbGnctLSwjpcUkNsLOs3ZaSxyI/Oahi2Ek0RZrJ9sI8PnpcdhNhXxeRlYdM8St59iM
	TK/fqHUgvuiRQGHscA2P9dHiugq+LF0Fzf0FjCk/+7DK4HSypLRQZRfVqRG9is+bPY4PLbEt3Vo
	YYsb80oMSUocP8FKk9t+ZMrlofuOl/2QzTewl48RVHS9jxzEo1XWHWuXb+kO8Lyg+W1VfaB+MTh
	ZRB/ezSUBR0PW9wiDag5hF3nDMPqcoQqaq+Jw+uBdM5rsxLmzWWTId7JgA/ANjeqJNddv4D33em
	Orc=
X-Google-Smtp-Source: AGHT+IGyn0ZoI8pnyfMT3Hgwa/ZmVlJuxPqhedn0kEIs7IARp51p1LPogEX5qh/GHEMfhaPEnDrEDUE80IOGohrR3b4=
X-Received: by 2002:a05:6402:35d4:b0:647:7bfe:da8f with SMTP id
 4fb4d7f45d1cf-6479c2fdc7cmr2790012a12.0.1764776795508; Wed, 03 Dec 2025
 07:46:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126193608.2678510-1-dmatlack@google.com> <20251126193608.2678510-7-dmatlack@google.com>
 <aTAzMUa7Gcm+7j9D@devgpu015.cco6.facebook.com>
In-Reply-To: <aTAzMUa7Gcm+7j9D@devgpu015.cco6.facebook.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 3 Dec 2025 10:45:58 -0500
X-Gm-Features: AWmQ_blDyRfBySet4UyQnBKlT3DfSfdMfA_YKiXzQts7qaw09jP9-UbQNlazg68
Message-ID: <CA+CK2bDbOQ=aGPZVP4L-eYobUyR0bQA0Ro6Q7pwQ_84UxVHnEw@mail.gmail.com>
Subject: Re: [PATCH 06/21] vfio/pci: Retrieve preserved device files after
 Live Update
To: Alex Mastro <amastro@fb.com>
Cc: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	kvm@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Philipp Stanner <pstanner@redhat.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 7:55=E2=80=AFAM Alex Mastro <amastro@fb.com> wrote:
>
> On Wed, Nov 26, 2025 at 07:35:53PM +0000, David Matlack wrote:
> > From: Vipin Sharma <vipinsh@google.com>
> >  static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args=
 *args)
> >  {
> > -     return -EOPNOTSUPP;
> > +     struct vfio_pci_core_device_ser *ser;
> > +     struct vfio_device *device;
> > +     struct folio *folio;
> > +     struct file *file;
> > +     int ret;
> > +
> > +     folio =3D kho_restore_folio(args->serialized_data);
> > +     if (!folio)
> > +             return -ENOENT;
>
> Should this be consistent with the behavior of pci_flb_retrieve() which p=
anics
> on failure? The short circuit failure paths which follow leak the folio,
> which seems like a hygiene issue, but the practical significance is moot =
if
> vfio_pci_liveupdate_retrieve() failure is catastrophic anyways?

pci_flb_retrieve() is used during boot. If it fails, we risk DMA
corrupting any memory region, so a panic makes sense. In contrast,
this retrieval happens once we are already in userspace, allowing the
user to decide how to handle the failure to recover the preserved
cdev.

Pasha

>
> > +
> > +     ser =3D folio_address(folio);
> > +
> > +     device =3D vfio_find_device(ser, match_device);
> > +     if (!device)
> > +             return -ENODEV;
> > +
> > +     /*
> > +      * During a Live Update userspace retrieves preserved VFIO cdev f=
iles by
> > +      * issuing an ioctl on /dev/liveupdate rather than by opening VFI=
O
> > +      * character devices.
> > +      *
> > +      * To handle that scenario, this routine simulates opening the VF=
IO
> > +      * character device for userspace with an anonymous inode. The re=
turned
> > +      * file has the same properties as a cdev file (e.g. operations a=
re
> > +      * blocked until BIND_IOMMUFD is called), aside from the inode
> > +      * association.
> > +      */
> > +     file =3D anon_inode_getfile_fmode("[vfio-device-liveupdate]",
> > +                                     &vfio_device_fops, NULL,
> > +                                     O_RDWR, FMODE_PREAD | FMODE_PWRIT=
E);
> > +
> > +     if (IS_ERR(file)) {
> > +             ret =3D PTR_ERR(file);
> > +             goto out;
> > +     }
> > +
> > +     ret =3D __vfio_device_fops_cdev_open(device, file);
> > +     if (ret) {
> > +             fput(file);
> > +             goto out;
> > +     }
> > +
> > +     args->file =3D file;
> > +
> > +out:
> > +     /* Drop the reference from vfio_find_device() */
> > +     put_device(&device->device);
> > +
> > +     return ret;
> > +}

