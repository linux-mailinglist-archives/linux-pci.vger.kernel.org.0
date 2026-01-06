Return-Path: <linux-pci+bounces-44112-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0E1CFA10D
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 19:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8A043129EB4
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 17:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5313559CC;
	Tue,  6 Jan 2026 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcP9BVfR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6773559C0
	for <linux-pci@vger.kernel.org>; Tue,  6 Jan 2026 17:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767720579; cv=none; b=qQ3pDb79xN7xf3UL1T4P3r1A47+3BM3I283rADxSOtTyIl0ezrraX0jFLWYiCkGkbCd02HioYbMBJAiIj8UzdAvyXd5ECV0eolqbLGyn1n8I79k39NH3rxb4BgQpfcVwzbhKzIIMp3jjQ4gXl71as4oXkYouaJp66f7V7ZYxqKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767720579; c=relaxed/simple;
	bh=lZGEKdFUb9AcB7WNwQ+ORABBKfepwE38XMx2EGdcaLA=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=CYxKbG55KHsmXZmtcknPbqbIi1o+KtbXjfdhg/qLOMPxGVi6ruh8WLYzOzbN4rbZ83qSvTC5uZQcXaBVQtF6V33yIY4LExIdHCW3zHLlTjGHcKZ6s6/pfYKsuMYUxkNcyMMvLX63OvvfCY583415yGmSm+AUXN3hrDhENxEBn/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcP9BVfR; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4eda6c385c0so8013681cf.3
        for <linux-pci@vger.kernel.org>; Tue, 06 Jan 2026 09:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767720577; x=1768325377; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ev2z+ugntRfBhi0MLQnaloAEfBXhuJAFXxFLLDkUT7I=;
        b=TcP9BVfRMqa0Lj2ijIpH3GwnUheka7mfmy7mb1pZiOidSvlAgzVvCqXrmoR3X1ZbKe
         7yDVpsgcug5kMvFRWN8MEGzYLllXUlQCLZ+xgxTAqmrq4HsKCo/+TE1LM+1s8+2kMAIK
         /U6UnItDHlh/1sA7yijRYVHAViEPLMphEHRvw5NGmluZyxog1vOq2Gl2QtjCcX/XncNU
         HG2ijQMR/8sQeV/vLGmyBFxhubrQUGYRIkhTmRmo3N3k88lBncVEZrzqigwPcyTCNxb3
         RkWjjVaogUH05zZ+SOce6X5UjUF3FZgofFlWeKDbata7Lc8UikHgMNJXdXW1N0V5G09w
         Sd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767720577; x=1768325377;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ev2z+ugntRfBhi0MLQnaloAEfBXhuJAFXxFLLDkUT7I=;
        b=DRcLC+qXvfq5DWNZubKF1ExFbZughMB0VTdIEektA6cKTac0cxjXWekJr6zvwugTwj
         ymyIK1ene9GE4zrHUPIMpqoIrHki8A995XNpVlmXuSM8Iqmcl5he81zv4N3xhI4IeYQ+
         gxwNk+UPVmq2pE/metJyF3Ug9ZvoFTR4oPvffE2FUCYQ8sm0kVGjbeshTpx5D0ur6MeN
         tPNN+Bw82RgjycpxzEkgQVTjeC3swIPPbjSv3XAqjwVtIPh5+Qp+iUH7u51R6s+URO0E
         pljBlz8XED1YWGK69t194fBN+c9635yPKHkNMprcAMoEPHLiBJ1RAeurm73a9/k06WVc
         z/sQ==
X-Gm-Message-State: AOJu0Yyr4vZYlfTo3nmAGDlwm3Qz1HqWFNrFMKZpYF0ss6KoPIAf2RWu
	SFOfVeztWScWI4PEilTBaUvlaw3AuQQvS1xSSYooTprozVk6KvANULSt
X-Gm-Gg: AY/fxX691Iyi9En737cMixPDqeem6qCW1R0MDs+57kSEtS/EtyrFuXkBMrDQ0E30UNu
	Xda0zJKPkXNceSVEmwbrW1QyqeeKEYNfi98nwil9Gxc6kuotU6mJ01MCLE3WOIB0YrXHW85xCJa
	w8I3TUlirHTmgA5FGVs7ytil+2gikbTgzg8WI0vfalJk/0+FnkDhmZvJlNmYm4IpJLuWr/TCAoL
	rVCa58ZVJ5V0uCP02gUaPECgsAUCdr0pQhs/11VGH+ms9hakdbcdDcB9pM0nubZ2viKB0uvJeXG
	XKOrjNVpgGebaFXUnGOnmWNzZb16da+17sO6piWvOUGi6EtYYViWqSDkySB/FHFGJTmkjGkQFEM
	63Nv8A3gbU9tN1cUuCyNF0Jrutoz4xQX5dZ6soZIXwErILV0LMOYSmtX0Y8enAZVcfjjmjazg6x
	mi4AhYMjG1PTAfbWNtwG2EXv+pAuBDWmlCKO3il3KFV7XzR1juRoW/QQ==
X-Google-Smtp-Source: AGHT+IHJ1nl1mxcz6HJDOIFhwyOzQJmst8hsU57AC7I4tqS/qzt3tqz13wKOdTI+77LEYoHxCPbCzw==
X-Received: by 2002:ac8:7dc1:0:b0:4f0:2f0c:e91d with SMTP id d75a77b69052e-4ffa782419dmr51056441cf.73.1767720576676;
        Tue, 06 Jan 2026 09:29:36 -0800 (PST)
Received: from smtpclient.apple ([2600:4041:45af:2c00:7ce3:4443:846c:ff7c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8d38e12sm15016421cf.3.2026.01.06.09.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 09:29:36 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Patrick Bianchi <patrick.w.bianchi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: PCI Quirk - UGreen DXP8800 Plus
Date: Tue, 6 Jan 2026 12:29:25 -0500
Message-Id: <7415E3FF-6A70-4836-B609-29F88747D0F8@gmail.com>
References: <20260106102354.4b84b4a7.alex@shazbot.org>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>
In-Reply-To: <20260106102354.4b84b4a7.alex@shazbot.org>
To: Alex Williamson <alex@shazbot.org>
X-Mailer: iPhone Mail (23C55)

Yes. I used the exact code from Post #12 in that thread and it has been runn=
ing stably for 3 weeks and through multiple reboots of host and VM.

-Patrick Bianchi

Sent from my iPhone

> On Jan 6, 2026, at 12:23=E2=80=AFPM, Alex Williamson <alex@shazbot.org> wr=
ote:
>=20
> =EF=BB=BFOn Mon, 22 Dec 2025 18:37:32 -0500
> Patrick Bianchi <patrick.w.bianchi@gmail.com> wrote:
>=20
>> Hello everyone.  At the advice of Bjorn Helgaas, I=E2=80=99m forwarding t=
his
>> message to all of you.  Hope it=E2=80=99s helpful for future kernel revis=
ions!
>=20
> I'm not sure what the proposed change is, but the comment at the end of
> the previous message seems to be leading to the quirk_no_bus_reset
> patch proposed here:
>=20
> https://forum.proxmox.com/threads/problems-with-pcie-passthrough-with-two-=
identical-devices.149003/#post-803149
>=20
> IIRC QEMU will favor the bus reset if the device otherwise only
> supports PM reset and interfaces like reset_method only influence the
> reset-function path rather than the bus/slot reset interface available
> through the vfio-pci hot reset ioctl.
>=20
> Disabling bus reset appears reasonable given the corroboration in the
> thread and the fact that the device still seems to support PM reset.
>=20
> Do you confirm the quirk you were testing is:
>=20
> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ASMEDIA, 0x1164, quirk_no_bus_reset=
);
>=20
> ie. vendor:device ID 1b21:1164?
>=20
> Thanks,
> Alex
>=20
>> Begin forwarded message:
>>=20
>> From: Patrick Bianchi <patrick.w.bianchi@gmail.com>
>> Subject: PCI Quirk - UGreen DXP8800 Plus
>> Date: December 20, 2025 at 9:56:10=E2=80=AFPM EST
>> To: bhelgaas@google.com
>>=20
>> Hello!
>>=20
>> Let me start this off by saying that I=E2=80=99ve never submitted anythin=
g
>> like this before and I am not 100% sure I=E2=80=99m even in the right pla=
ce.
>> I was advised by a member on the Proxmox community forums to submit
>> my findings/request to the PCI subsystem maintainer and they gave me
>> a link to this e-mail.  If I=E2=80=99m in the wrong place, please feel fr=
ee
>> to redirect me.
>>=20
>> I stumbled upon this thread
>> (https://forum.proxmox.com/threads/problems-with-pcie-passthrough-with-tw=
o-identical-devices.149003/)
>> when looking for solutions to passing through the SATA controllers in
>> my UGreen DXP8800 Plus NAS to a Proxmox VM.  In post #12 by user
>> =E2=80=9Ccelemine1gig=E2=80=9D they explain that adding a PCI quirk and b=
uilding a
>> test kernel, which I did - over the course of three days and with a
>> lot of help from Google Gemini!  I=E2=80=99m not very fluent in Linux or t=
his
>> type of thing at all, but I=E2=80=99m also not afraid to try by following=

>> some directions.  Thankfully, the proposed solution did work and now
>> both of the NAS=E2=80=99s SATA controllers stay awake and are passed thro=
ugh
>> to the VM.  I=E2=80=99ve pasted the quirk below.
>>=20
>> I guess the end goal would be to have this added to future kernels so
>> that people with this particular hardware combination don=E2=80=99t run i=
nto
>> PCI reset problems and don=E2=80=99t have to build their own kernels at e=
ver
>> update.  Or at least that=E2=80=99s how I understand it from reading thro=
ugh
>> that thread a few times.
>>=20
>> I hope this was the right procedure for making this request.  Please
>> let me know if there=E2=80=99s anything else you need from me.  Thank you=
!
>>=20
>> -Patrick Bianchi
>>=20
>>=20
>>=20
>> C:
>> /*
>> * Test patch for Asmedia SATA controller issues with PCI-pass-through
>> * Some Asmedia ASM1164 controllers do not seem to successfully
>> * complete a bus reset.
>> */
>>=20
>=20

