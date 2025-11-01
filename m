Return-Path: <linux-pci+bounces-39984-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0268EC272B1
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 00:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AC201B263B1
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 23:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3613D32A3FE;
	Fri, 31 Oct 2025 23:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kEU749Yw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622C823C505
	for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 23:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761952402; cv=none; b=cbaTc3k8f7jZTl6SpqG0hYGD6PN2ZfxXtuoCe8mcv3GPeqywBjdFhR/lOu1kyyic5CaVfeIpyPlWdRnLnmVy7jjLhTo2nnHAnPN8EROw61guV+005NWF2O8ShWaOoVNH53qzEF89nYTurNpeo+wN0tnfM0g4KQfeuKwS7lDtAV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761952402; c=relaxed/simple;
	bh=XWZsqJRZo0jc8TEwczUrIZCZrP8vjp3+VpCSsodHNDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fIjutscQeCpnFBq42vgGPaG0V9mdwINoLAO7B4bsO/YJ+9m1p17SMomMvPTn17Ehn+GOjMvG6S99/b+hXxU4FZF49XzbbppWy7LS48XBRjSM8d9Zd/KjAWdxQaxb143MYiJA/YdXTe5sN4Q6X5XdEVfw8UW21+f01vGY0nc78EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kEU749Yw; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-591eb980286so3090913e87.2
        for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 16:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761952398; x=1762557198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CduKhDs2d95anLLqO+pCgedfe9nkoQuIaYxFtLlvMAI=;
        b=kEU749Yw2luBSyqqeosBP2aguvxblfCIFQy0dCF+uFwUIPWuLzDHY8m+vc9S+svxtF
         ON96JnjkHmcJj+jr4y+TcnyxRPUnBSVGk9Kb8YQfquWuYdZZMzwhR+4ep+EmnGYbW1OZ
         wjGzSmDhQTlDpNMjqpgCXwC9lVCnmteiIS5C3r5CY+O/o7zgevmNkhAdcjW3lJ4m6RU1
         Y4U9LMudrBMj2kwmQItNr19AVN/P3f2Ux4Tk/4qbbs9bY1o4pjH0Xb87GC/PwQbGmYqD
         iE4DIdLAcsusXamwxNMXhe7bigmA+ElXLYDjkqf3dchNEL5sskAz32eeFZS7icmliiWr
         gVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761952398; x=1762557198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CduKhDs2d95anLLqO+pCgedfe9nkoQuIaYxFtLlvMAI=;
        b=Sut5kIA412lI/ALmE4E4RRKBi9A01o9/EUO7bjizKfv/DFKDnOk/cFqPVRr5K5Csls
         w/yuku2+V1x64ijeQebKqGsRLZXVTFx13fq5rCpRdw5ffFm5VDp0NsTp6gTXEC1D2WR0
         4UUo+N4fmhdtAg61plXF1HQdqgPdq0R6weQ58hUuSm0cW6fwe+ZCYAFb2DhvrwXukl7H
         S7aDh6VKA4nXP7iZ2Dr65hJGNWqtcqBg5FvIEcG3of9WPLonCVcNEM+dkQhLjjbLs0pf
         7aKKUqKNaTXTWi4keohp0H9xMwGOefDYT4DtWaHSIafuDLKxbv3EeIme5WtazB3uFmmO
         o7xA==
X-Forwarded-Encrypted: i=1; AJvYcCUomT4mIo/YZmgN0UZiMdki8Rjmql4dj6MQ9a3hOIJcyU8/y4CJltDBbNQGKNsPo/5S3qWyP/PoNAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVTbjQLfOo/AMSXvaCZDAGDIHJtTPrklnwICcPu/ZQqzktyI9I
	MhvsPsMJhpNmAp3KVoUZ4F0QeXnTB/xmnq1AhUJ4SOYijRGt2ZrWmvbxYLuMEqksvXDQGCswR4J
	twcZsAdi4uugaut+bvHxS2W8BO1Cr/OXOZ4TOAc07
X-Gm-Gg: ASbGncuXAlZr/5QADhXm0LKxU2fCqOi3tJ5/ZTA+OYcPbL66BQEe+AXGXgAujWItDbG
	3xjS8HrmOL5bZRAGQ8FxKlsZnctO+7Q1JWv433yQZXtMUzV4tTvUDG4I96kWyPQXIKrXNzxve8u
	xvcGg8mVsuX63FxMDajXeQg14TOe2nC55WBuyB2DsIa489k1F1ztO2FqyfNeoXmfuMlQ5CoD0jh
	KMfGNYZWGYvcimHYXnVvmBb9RbQEQbRtnBqDl0h+hGSiv08ogrwB8nuC4CX
X-Google-Smtp-Source: AGHT+IExErcOO2EIgmDaicMDUbGTWKxNreSKo2RDOW0/ULZPVApKfmIWoVK+h3uJ79oZ73j1I9/Rf0OSA92b1W105fQ=
X-Received: by 2002:a05:6512:3c92:b0:591:c8de:467b with SMTP id
 2adb3069b0e04-5941d542679mr1891506e87.40.1761952398324; Fri, 31 Oct 2025
 16:13:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018000713.677779-1-vipinsh@google.com> <20251018000713.677779-9-vipinsh@google.com>
In-Reply-To: <20251018000713.677779-9-vipinsh@google.com>
From: David Matlack <dmatlack@google.com>
Date: Fri, 31 Oct 2025 16:12:50 -0700
X-Gm-Features: AWmQ_bkA4phyOyQRm4wqvCBQ3eNh3dDXKfq4mZi3gYwoRKx7jeTWqc2Xmhrpb1M
Message-ID: <CALzav=c9yw2B=1Y6kK2ZuxdBCnwuTHyOyA4VGT8_rLv2Wg5r4A@mail.gmail.com>
Subject: Re: [RFC PATCH 08/21] vfio/pci: Retrieve preserved VFIO device for
 Live Update Orechestrator
To: Vipin Sharma <vipinsh@google.com>
Cc: bhelgaas@google.com, alex.williamson@redhat.com, pasha.tatashin@soleen.com, 
	jgg@ziepe.ca, graf@amazon.com, pratyush@kernel.org, 
	gregkh@linuxfoundation.org, chrisl@kernel.org, rppt@kernel.org, 
	skhawaja@google.com, parav@nvidia.com, saeedm@nvidia.com, 
	kevin.tian@intel.com, jrhilke@google.com, david@redhat.com, 
	jgowans@amazon.com, dwmw2@infradead.org, epetron@amazon.de, 
	junaids@google.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 5:07=E2=80=AFPM Vipin Sharma <vipinsh@google.com> w=
rote:
>  static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_handler *=
handler,
>                                         u64 data, struct file **file)
>  {
...
> +       filep =3D anon_inode_getfile_fmode("[vfio-cdev]", &vfio_device_fo=
ps, df,
> +                                        O_RDWR, FMODE_PREAD | FMODE_PWRI=
TE);

It's a little weird that we have to use an anonymous inode when
restoring cdev file descriptors. Do we care not about the association
between VFIO cdev files and their inodes?

If we wanted to have the cdev inode we could have the user pass a file
path to ioctl(LIVEUPDATE_SESSION_RESTORE_FD)? File handlers can use
that to find the inode to use when creating a struct file. This would
avoid the anonymous inode and also ensure that restoring the fd obeys
the same filesystem permissions as opening a new fd (I think?).

Pasha this would be a uAPI change to LUO. What do you think?

Sami, Jason, what are you planning to do for iommufd?

> +       if (IS_ERR(filep)) {
> +               err =3D PTR_ERR(filep);
> +               goto err_anon_inode;
> +       }
> +
> +       /* Paired with the put in vfio_device_fops_release() */
> +       if (!vfio_device_try_get_registration(device)) {
> +               err =3D -ENODEV;
> +               goto err_get_registration;
> +       }
> +
> +       put_device(&device->device);
> +
> +       /*
> +        * Use the pseudo fs inode on the device to link all mmaps
> +        * to the same address space, allowing us to unmap all vmas
> +        * associated to this device using unmap_mapping_range().
> +        */
> +       filep->f_mapping =3D device->inode->i_mapping;

Most of this code already exists in vfio_device_fops_cdev_open(). I'll
work on sharing the code in the next version.

