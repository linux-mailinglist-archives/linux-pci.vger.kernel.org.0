Return-Path: <linux-pci+bounces-21635-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF23A388C4
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 17:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D0D83A477F
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 16:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE1615666D;
	Mon, 17 Feb 2025 16:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtWOrk6/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35ED21ADD3
	for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2025 16:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739808017; cv=none; b=rRt3/IeVQq2yTg/CgIojqPRQ9nyaycVAhbuhlNDcnTd58jPKwdAzfV3iRsLR26wCt9CqAcMO58VONKALwb7NKpFLiIzmt9hH0snTIFm1Usk9j01mW4mVYGVYBA0nnz1QpIU39NxuKT9fziDtY/siSQlcTj6jrMIYM/Ck0iDyDYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739808017; c=relaxed/simple;
	bh=Y0ojYpZAKDPexG2BiUyStjFiHltHtvwtQSc2W4A51To=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EngI9AS97rfzefFvHVhxgpsOBVI9bkc4qbdsrBH8cZtF2ODd7Noat49s7UcSUXZejfP8YFePj4g7bOJHzf04BDkrbuQzzx0zsa5TsGTlKENrd4SfgEeEkSAMEX3cK0IXtDF0YRXCsF+TJyxenM15R6bFswCJMVuhtMsURBEivQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtWOrk6/; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fbf706c9cbso1096009a91.3
        for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2025 08:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739808014; x=1740412814; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ueTj5ZO31uXjyv/62G6E104VecareS4hLbaJX3FHHb0=;
        b=WtWOrk6/RNRDF/ncsZw99RicZAur+V+ObTwGV8uJGAbY06NyE5iGAMW2q7xmn0F2sb
         LqSghjw+A3FitWufAWtxyruGxJvN3MyU0+he/QaVEW3HASU5beindMDyTjd5Hm9MINlr
         jhvQsGc/gP6mQbXItdKLodXG5ckNlfowXq5nWSfD6T7FEEy02B9rgg/OqrWTAkhYbK5e
         m5wRym4kr9jogJ3gptrT52PMcIuhmUDulqmux13WPHwr77qOwGEqw41KRarS8qtMMJp/
         0LXCxqFw2wfYWotwtg8L137Q1SsnyURAMvSHLCURpJxpZ1hySFSf/NkETUrH055BqsNp
         /2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739808014; x=1740412814;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ueTj5ZO31uXjyv/62G6E104VecareS4hLbaJX3FHHb0=;
        b=m6QcxC5CXuPktOakIRVsEV4goa2aR4F3XuCq9g+1+FqC1AQTVESDY/L3fqLLseTqGy
         VRBhUSdJnwAxhKiYeuaREObo2B2fbVY8gFOxKo3t2A4UWO2a1O9q/YEZSItEGMPi71gK
         miG4DU6JEdlnFYlApeQ7TdBKtdkYhdG0K/IiAtLJNsZ2i2yUrVr6PAodBNhT0iIO9WTF
         R7Mpn8vwPmiiKidRhBgz7rXgJDM5XfeJx5slEuXtS5/WKELy6H95yxttaN9RAoyb4vJW
         +hhL1fKPYjkpQd7m0Lfnd8YczTEENiFcyus3K3w6oDihD13ZG8eyBQHV+muGOsuqmI64
         +FRg==
X-Forwarded-Encrypted: i=1; AJvYcCVSmBdbkiBny8ZycBmYAE6rXbuTzqoJveGrB9MFzAcuu/eozFg2xVgBLd0T5Z75yGW8ug40oHxIj3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo62P1T+bt0zN0pDiVr0+Vc8tLtS6pV+bCIfcYKgQ6Yomu61bf
	hVS9WqDx1CBMbwrfZyxTGju+Zy9pM4UM7OBfYfvFVayeQJ8I9dEdE3Yak/30LDY2xwjh9vn6VC+
	gBKDb+yO8pcy0gy2vL4SnDZ+Cjm8=
X-Gm-Gg: ASbGncurVZtWaRj+vWR/tXAKYhwWmrIv8nuUlZWA4XLzRAgtN2PvG3GRgncu/sBcAot
	uuS0E4NbL1xA/Ifnggzx9RjGQDK0Ffliw+OtaHiGm3ULZnGgfh5gNw86eGmc+Cv3Khy4SgjPY
X-Google-Smtp-Source: AGHT+IHO9/ak88DCQz1bcYSUoj5Y5QgAVWei+EhPjy+Pwmflvp2i1lowLTD/lmvhwbzrTOmOncULAnttHlaPdegO07I=
X-Received: by 2002:a17:90b:4c46:b0:2ee:f59a:94d3 with SMTP id
 98e67ed59e1d1-2fc40792d5bmr6279923a91.0.1739808012618; Mon, 17 Feb 2025
 08:00:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217151053.420882-1-alexander.deucher@amd.com>
 <1654fb6c-e0e8-4dde-8554-7058cf73503d@amd.com> <CADnq5_NUEuMFsd__w1eGBWALxcQwtX7sa2Sn53vDjaxrqNuhPQ@mail.gmail.com>
In-Reply-To: <CADnq5_NUEuMFsd__w1eGBWALxcQwtX7sa2Sn53vDjaxrqNuhPQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 Feb 2025 11:00:00 -0500
X-Gm-Features: AWEUYZmGoN9BY0F6L8OwbUtyHoHkrVjfUrEeojzRF-byVv_RMIaipxzCHHwLogY
Message-ID: <CADnq5_NEhv-E9ZxHvxhBtFb_cBkPqMfu-nsQfEknO30tNBjA2Q@mail.gmail.com>
Subject: Re: [PATCH] PCI: fix Sapphire PCI rebar quirk
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, bhelgaas@google.com, 
	linux-pci@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	Mario.Limonciello@amd.com, Nirmoy Das <nirmoy.aiemd@gmail.com>
Content-Type: multipart/mixed; boundary="00000000000091e707062e589e83"

--00000000000091e707062e589e83
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 10:45=E2=80=AFAM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> On Mon, Feb 17, 2025 at 10:38=E2=80=AFAM Christian K=C3=B6nig
> <christian.koenig@amd.com> wrote:
> >
> > Am 17.02.25 um 16:10 schrieb Alex Deucher:
> > > There was a quirk added to add a workaround for a Sapphire
> > > RX 5600 XT Pulse.  However, the quirk only checks the vendor
> > > ids and not the subsystem ids.  The quirk really should
> > > have checked the subsystem vendor and device ids as now
> > > this quirk gets applied to all RX 5600 and it seems to
> > > cause problems on some Dell laptops.  Add a subsystem vendor
> > > id check to limit the quirk to Sapphire boards.
> >
> > That's not correct. The issue is present on all RX 5600 boards, not jus=
t the Sapphire ones.
>
> I suppose the alternative would be to disable resizing on the
> problematic DELL systems only.

How about this attached patch instead?

Alex

>
> >
> > The problems with the Dell laptops are most likely the general instabil=
ity of the RX 5600 again which this quirk just make more obvious because of=
 the performance improvement.
> >
> > Do you have a specific bug report for the Dell laptops?
> >
> > Regards,
> > Christian.
> >
> > >
> > > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1707
>
> ^^^ this bug report
>
> Alex
>
>
> > > Fixes: 907830b0fc9e ("PCI: Add a REBAR size quirk for Sapphire RX 560=
0 XT Pulse")
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: Nirmoy Das <nirmoy.aiemd@gmail.com>
> > > ---
> > >  drivers/pci/pci.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 225a6cd2e9ca3..dec917636974e 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -3766,6 +3766,7 @@ u32 pci_rebar_get_possible_sizes(struct pci_dev=
 *pdev, int bar)
> > >
> > >       /* Sapphire RX 5600 XT Pulse has an invalid cap dword for BAR 0=
 */
> > >       if (pdev->vendor =3D=3D PCI_VENDOR_ID_ATI && pdev->device =3D=
=3D 0x731f &&
> > > +         pdev->subsystem_vendor =3D=3D 0x1da2 &&
> >
> >
> >
> >
> > >           bar =3D=3D 0 && cap =3D=3D 0x700)
> > >               return 0x3f00;
> > >
> >

--00000000000091e707062e589e83
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-drm-amdgpu-disable-BAR-resize-on-Dell-G5-SE.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-disable-BAR-resize-on-Dell-G5-SE.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m798rc7j0>
X-Attachment-Id: f_m798rc7j0

RnJvbSAzODQxZGQ5MDQ4NDQ4NjA4NjNjNDg5Nzk2NzEwZDJkOWZlZTA1YmNiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IE1vbiwgMTcgRmViIDIwMjUgMTA6NTU6MDUgLTA1MDAKU3ViamVjdDogW1BBVENI
XSBkcm0vYW1kZ3B1OiBkaXNhYmxlIEJBUiByZXNpemUgb24gRGVsbCBHNSBTRQoKVGhlcmUgd2Fz
IGEgcXVpcmsgYWRkZWQgdG8gYWRkIGEgd29ya2Fyb3VuZCBmb3IgYSBTYXBwaGlyZQpSWCA1NjAw
IFhUIFB1bHNlIHRoYXQgZGlkbid0IGFsbG93IEJBUiByZXNpemluZy4gIEhvd2V2ZXIsCnRoZSBx
dWlyayBjYXN1c2VkIGEgcmVncmVzc2lvbiBvbiBEZWxsIGxhcHRvcHMgdXNpbmcgdGhvc2UKY2hp
cHMsIHJhdGhlciB0aGFuIG5hcnJvd2luZyB0aGUgc2NvcGUgb2YgdGhlIHJlc2l6aW5nCnF1aXJr
LCBhZGQgYSBxdWlyayB0byBwcmV2ZW50IGFtZGdwdSBmcm9tIHJlc2l6aW5nIHRoZSBCQVIKb24g
dGhvc2UgRGVsbCBwbGF0Zm9ybXMuCgpDbG9zZXM6IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9w
Lm9yZy9kcm0vYW1kLy0vaXNzdWVzLzE3MDcKRml4ZXM6IDkwNzgzMGIwZmM5ZSAoIlBDSTogQWRk
IGEgUkVCQVIgc2l6ZSBxdWlyayBmb3IgU2FwcGhpcmUgUlggNTYwMCBYVCBQdWxzZSIpClNpZ25l
ZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCA2ICsrKysrKwogMSBm
aWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kZXZpY2UuYwppbmRleCA1MTJlNjQyNDc3YTdlLi41NmZkODc0YTIyZGU4IDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCkBAIC0xNjYyLDYgKzE2
NjIsMTIgQEAgaW50IGFtZGdwdV9kZXZpY2VfcmVzaXplX2ZiX2JhcihzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldikKIAlpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQogCQlyZXR1cm4gMDsKIAor
CS8qIHNraXAgcmVzaXppbmcgb24gRGVsbCBHNSBTRSBwbGF0Zm9ybXMgKi8KKwlpZiAoYWRldi0+
cGRldi0+dmVuZG9yID09IFBDSV9WRU5ET1JfSURfQVRJICYmCisJICAgIGFkZXYtPnBkZXYtPmRl
dmljZSA9PSAweDczMWYgJiYKKwkgICAgYWRldi0+cGRldi0+c3Vic3lzdGVtX3ZlbmRvciA9PSBQ
Q0lfVkVORE9SX0lEX0RFTEwpCisJCXJldHVybiAwOworCiAJLyogUENJX0VYVF9DQVBfSURfVk5E
UiBleHRlbmRlZCBjYXBhYmlsaXR5IGlzIGxvY2F0ZWQgYXQgMHgxMDAgKi8KIAlpZiAoIXBjaV9m
aW5kX2V4dF9jYXBhYmlsaXR5KGFkZXYtPnBkZXYsIFBDSV9FWFRfQ0FQX0lEX1ZORFIpKQogCQlE
Uk1fV0FSTigiU3lzdGVtIGNhbid0IGFjY2VzcyBleHRlbmRlZCBjb25maWd1cmF0aW9uIHNwYWNl
LCBwbGVhc2UgY2hlY2shIVxuIik7Ci0tIAoyLjQ4LjEKCg==
--00000000000091e707062e589e83--

