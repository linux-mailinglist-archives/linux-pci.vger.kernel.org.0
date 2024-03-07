Return-Path: <linux-pci+bounces-4592-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 225C3874822
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 07:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBCA6281C0A
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 06:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5321BF27;
	Thu,  7 Mar 2024 06:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/thGd/P"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929B2E546;
	Thu,  7 Mar 2024 06:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709792581; cv=none; b=a8vcs+ISiYRRv1TSnsiV0tmC6AVhRmmfRmgsipZWXiMKswgpJ0uspigbej1PQbrGuJ/9PkdJGgCKBLGYrZYwIVNY3VU/RBo8yZo6Yowf+YEI9arsZxmHxXa77ZwMNT+gWiIVr/xtYqapuBhkR7S7lnvBWpUE0vMRqYMzw0OgbXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709792581; c=relaxed/simple;
	bh=UNCTw5D9WsoqL1Hbw+KpFJE6iW6Jly3wtcYbjgHX2cA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DVDoEut6PV+tOOC7pzv/zoAUvZaSUP1+vqLecmCbTYNxAs9N77h1s6/Iy5kh+PLCmBYxpIMMQgEpJziDd2+VGeUjYG6oY535fxm1Xpsz2f9mgVq/3QRcjI/msMota9e74G4pSlNFV3TnYI1Ov8Muw7vXxzQWGkNbFA4XpQffsGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/thGd/P; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-566e869f631so555370a12.0;
        Wed, 06 Mar 2024 22:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709792578; x=1710397378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8p7oGzm5YEc17mr7Hc2mG+1f/a/Pw8VPdlVKrPJxZGk=;
        b=N/thGd/P7jXpCrZVAYWeM5jjSL/yr2JuE+kNBgexAto06k6+fT1XvuT4ULb4KnABQX
         03ku/tEqLZReqX5fx1tNpCGQ+vOIhWMZ/BKFmrBjHNqxqUJgVz9PL8POl9eFo/RVlgKZ
         vxFJ3opyUeAod03CkI5kzDJmLtK5q4VZt6qeyRRY8DYnfI2fViecW9SspNIlqt0VSQUr
         MtABxJdOwYp6/ij9tm+/m/dhdgh+oUcImID+b6QcqursuxPqAktut2Tji81PeTdOHm92
         W1kAZfSsoqIINTqmhWWTzrNgkWpZh1Rx5uvXC0/rFR2sisz7lGrg2wLYBRA1RwrTcbYh
         IW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709792578; x=1710397378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8p7oGzm5YEc17mr7Hc2mG+1f/a/Pw8VPdlVKrPJxZGk=;
        b=X7QpMsf5mF6wj60y5ygQgsRSlrcidPbfWK4Ytgfg/fPauwIT/LlH+8AfmBm1kUb5Ue
         JL1P4+gRa7O3SyePgJN6wpKa8kpYQWH6qzvc3ZNq9cQC/zOPjP3IeodAJ5M/z20GD2KR
         5RtAhuJcNA4EWV+JC2XgAO6kY8BFgVbCXiL2uPPkUwpCI7PZmPfyh82d4oRX4A/2mK4Z
         g+XZsLxW/HNyscfyab+6Hb5CBm8aNKjLB8rumg7gPCdqm9oNasYmB4CrckDAc873lpDa
         /Hc7b/E6QeGVIArrl8rC4u2znHHBrPOvevJrZzqX/Bkxsp8uhHM/dza7xOwvgVvyGZRd
         ia4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXvXxTqmT2qqoNAF31YbrWNggzsQ14vQyfiS+xGF/4bwNJW5hXdreLYPoXmljYWPwm7M6wXHxnDWw1aJaYRH9E1tXsjcG2/sb/L6ydT
X-Gm-Message-State: AOJu0YynblYJ5uD9ljMYMOjXr3UqQbudmQHwrwyWXFVsV31HJ4iLfqrL
	VB4aRTATchVXZ6ohzEuT10CZOhYUgUHc94rHgfKCnis24Tnz1qXnsXIvZqy4diAUxWhlIE3n8OV
	YEhp1BwYa02XZu5iNpMp5OzN8G88=
X-Google-Smtp-Source: AGHT+IHI2SHfXiqWU8/zvPFJBOEEmUOOTpTPSIppyIq62VsLjxVUHfbRijjg+TNUj82mGHJ6ZMsC1RSN12u4r0GRxUU=
X-Received: by 2002:a05:6402:2315:b0:566:b442:16cf with SMTP id
 l21-20020a056402231500b00566b44216cfmr12026391eda.13.1709792577601; Wed, 06
 Mar 2024 22:22:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307022006.3657433-1-aik@amd.com> <32ac2ee6-26b1-4f37-bd88-db1ef2a31267@linux.intel.com>
 <16120a31-c3d6-48a8-9355-7b063e28d242@amd.com>
In-Reply-To: <16120a31-c3d6-48a8-9355-7b063e28d242@amd.com>
From: Sathyanarayanan Kuppuswamy Natarajan <sathyanarayanan.nkuppuswamy@gmail.com>
Date: Wed, 6 Mar 2024 22:22:46 -0800
Message-ID: <CAC41dw9x8H2m=YB66+PA-GwiVkpCyT0PobdWvFXLHpAsQOE0ew@mail.gmail.com>
Subject: Re: [PATCH kernel v3] PCI/DOE: Support discovery version 2
To: Alexey Kardashevskiy <aik@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Ira Weiny <ira.weiny@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 10:09=E2=80=AFPM Alexey Kardashevskiy <aik@amd.com> =
wrote:
>
>
>
> On 7/3/24 16:06, Kuppuswamy Sathyanarayanan wrote:
> >
> > On 3/6/24 6:20 PM, Alexey Kardashevskiy wrote:
> >> PCIe r6.1, sec 6.30.1.1 defines a "DOE Discovery Version" field in
> >> the DOE Discovery Request Data Object Contents (3rd DW) as:
> >>
> >> 15:8 DOE Discovery Version =E2=80=93 must be 02h if the Capability Ver=
sion in
> >> the Data Object Exchange Extended Capability is 02h or greater.
> >
> > Does this change fix any functional issue? If yes, please add Fixes:
> > tag and probably CC stable?
>
> The issue is that before this patch the DOE driver was following PCIe
> r6.0 and it was not working on a device with DOE cap v2 added in r6.1.
> Is it "fixes"?
>

Since you are enabling support for the newer spec version, I think it will =
not
fall under bug fix. But it might be qualified for the stable branch.
It depends on
whether you want to support this device in older(stable) kernels.

>
> >>
> >> Add support for the version on devices with the DOE v2 capability.
> >>
> >> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> >> ---
> > Change wise looks fine to me.
> >
> > Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>
>
> Thanks!
>
> >> Changes:
> >> v3:
> >> * updated subject line
> >> * dropped "DISCOVER_" from the new field macro
> >>
> >> v2:
> >> * added the section number to the commit log
> >> ---
> >>   include/uapi/linux/pci_regs.h |  1 +
> >>   drivers/pci/doe.c             | 11 ++++++++---
> >>   2 files changed, 9 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_re=
gs.h
> >> index a39193213ff2..fbca743b2b86 100644
> >> --- a/include/uapi/linux/pci_regs.h
> >> +++ b/include/uapi/linux/pci_regs.h
> >> @@ -1144,6 +1144,7 @@
> >>   #define PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH                0x0003fff=
f
> >>
> >>   #define PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX               0x000000f=
f
> >> +#define PCI_DOE_DATA_OBJECT_DISC_REQ_3_VER          0x0000ff00
> >>   #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID         0x0000ffff
> >>   #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL            0x00ff000=
0
> >>   #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX  0xff000000
> >> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> >> index 61f0531d2b1d..c94c2b0767f3 100644
> >> --- a/drivers/pci/doe.c
> >> +++ b/drivers/pci/doe.c
> >> @@ -381,11 +381,13 @@ static void pci_doe_task_complete(struct pci_doe=
_task *task)
> >>      complete(task->private);
> >>   }
> >>
> >> -static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u1=
6 *vid,
> >> +static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 capver, u8=
 *index, u16 *vid,
> >>                           u8 *protocol)
> >>   {
> >>      u32 request_pl =3D FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDE=
X,
> >> -                                *index);
> >> +                                *index) |
> >> +                     FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_VER,
> >> +                                (capver >=3D 2) ? 2 : 0);
> >>      __le32 request_pl_le =3D cpu_to_le32(request_pl);
> >>      __le32 response_pl_le;
> >>      u32 response_pl;
> >> @@ -419,13 +421,16 @@ static int pci_doe_cache_protocols(struct pci_do=
e_mb *doe_mb)
> >>   {
> >>      u8 index =3D 0;
> >>      u8 xa_idx =3D 0;
> >> +    u32 hdr =3D 0;
> >> +
> >> +    pci_read_config_dword(doe_mb->pdev, doe_mb->cap_offset, &hdr);
> >>
> >>      do {
> >>              int rc;
> >>              u16 vid;
> >>              u8 prot;
> >>
> >> -            rc =3D pci_doe_discovery(doe_mb, &index, &vid, &prot);
> >> +            rc =3D pci_doe_discovery(doe_mb, PCI_EXT_CAP_VER(hdr), &i=
ndex, &vid, &prot);
> >>              if (rc)
> >>                      return rc;
> >>
> >
>
> --
> Alexey
>


--=20
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

