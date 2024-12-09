Return-Path: <linux-pci+bounces-17914-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 937A39E8F77
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 10:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26C49283CEA
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 09:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7ABB216E3E;
	Mon,  9 Dec 2024 09:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xPX+yPSb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFF1216E2A
	for <linux-pci@vger.kernel.org>; Mon,  9 Dec 2024 09:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733738091; cv=none; b=EmdkPeRriTjh+ffEsdZ9AYswnYVnLKryANLp3LKN8c679Kqlwk/l9Dbb77OcFESA8/06B2YPHDUNGHo/xEJsbumJXIcGVRWy3ArGDCoblntrmEqbf9gqQ4PC3NurglksMZa1vD7/t2orfoCXYDkHHPr42DSqOIvdVKlJuSA/ZMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733738091; c=relaxed/simple;
	bh=brSlrdl20T89H2oF3r14Lo+1EPhuh5vxJjI9q622k/0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=pmfvKPw0yKr3i524VpzQvbEidLLhMShGyJjGhYDYEsramupDNCtfvoIuakKyOpzvVEerNnIDvs/OZWy2IDXXVURnriQgL7gXypjSpK3FYLP992+y/eXu3xksZRK/m4ENYEwTCgoPEgadmue18nxxue7D3DCQbZjxT3RXQEd9eeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xPX+yPSb; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-724ffe64923so4742956b3a.2
        for <linux-pci@vger.kernel.org>; Mon, 09 Dec 2024 01:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733738089; x=1734342889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lY7hPuoQ1eszRWP8btpBTOZvUIP/hTknYJ2k91/KJYQ=;
        b=xPX+yPSbKjCEXC+UJvG0cIjr50hIH1Q2stPMgIxf90z0RbeCbv+F6KSltEVoGt2S6i
         z+AftMkm78s61OYSehh1sIz3NKtmWjmCYC/nV4FsxYw5hZ9hvLBAKFZ+ao2lO8TSyZLB
         aEwqQu7JURJyh1hbqnhbkyvsNeIfw3l3anohXjpwKX07ABAh6Nh/S1aoI07Z3QM2fwEO
         ExWWku5yucGLEcH1zLU2Rf3vYK3zH8XZErWca+6eLmnbUkXmyl0U/JcRL0lP5XXGDs8i
         9t6458w0dOAmrNdy+z2jLVGC+wCBSG2zITfa0KPFMj2HHW0pSPTonLL2nw1vrsQc2yiY
         uesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733738089; x=1734342889;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lY7hPuoQ1eszRWP8btpBTOZvUIP/hTknYJ2k91/KJYQ=;
        b=VPAMhwHdNsnLkaNgP2jmHyBEul1K2BCedyeJGtRZIli77gIIOP70svBECr1jxn2YIm
         j9wFm24LJYn97RW5tP8ha1JljS4NycakV0DPuiwwVu1nCasysHntdy85huVqC1+HhXmQ
         s0L1XRMTVGFJBar3RJtnc0t4bDh0R+Kxrf5Q1+2ePHQaFMGdOutu/RGlh6fqkeOgN7Hj
         i73QVQHTKmwUZxmp/FtrjCG2VQfH3l6bXkPn2wL0BchRgg2IZpPXZ+YF8sjvZ1UFxi8h
         RPOnD7FbzkYkBTFKJjDf/Qb8dfgOfReqim5y0xX1Km6x43eDp2aRabBQdMxdKA8nvPgL
         qYSA==
X-Forwarded-Encrypted: i=1; AJvYcCU/L9tRKwjoHcyzzYqW4tlw4AYU8THEC38LBKvTxEvDWdeqmXAMP14sD7hD9jawK3jgdyIJ7G2iMlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPHkQzKYqzTRy9bcnDlMwJBwiDYoNKQNSAnpJFlP+TOPolTpqh
	3JGZSWgjvH5qitHQxEj2RKxcjq6xfxhFgVZ83EUdV/+/zB/clAwJgo1JmaGhfw==
X-Gm-Gg: ASbGnculGiUndGCiGMVaJ1aHrVz0St9EbBpOgC8Kl+tjaYxR8bqJUXj6AkCJAGpB8UV
	2KXWjBr46aMjIXPmS2Stu0bY0Ad2bp9RgtUFwRcX5TEIB7asnaU/SwIHUz9kd0KGPJNycT7FW30
	vxsG7R4T+di+WRNkHhey/0xvwNn/U1NkcFLDYX+HQDggRN8iXA6XbiiJrRXGpgruYGiScFkO4e5
	hIbba8OJB6TSffnwVdR1pM23n25JarYvM7T3eCsepN4FVMfow==
X-Google-Smtp-Source: AGHT+IFntcqxaX3TaBgS9jyGem5/YtIrpH0Uh1RVsUOPf21x3pzvR9H4bLckULF1udKYYjc2IlTGeA==
X-Received: by 2002:a05:6a00:189b:b0:71d:f4ef:6b3a with SMTP id d2e1a72fcca58-725b81bdaebmr20355312b3a.21.1733738089497;
        Mon, 09 Dec 2024 01:54:49 -0800 (PST)
Received: from ?IPv6:::1? ([2409:40f4:3017:99ae:8000::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a2a90339sm7357513b3a.105.2024.12.09.01.54.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 01:54:48 -0800 (PST)
Date: Mon, 09 Dec 2024 15:24:45 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
CC: Bjorn Helgaas <helgaas@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
 "Simek, Michal" <michal.simek@amd.com>,
 "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
Subject: RE: [PATCH 2/2] PCI: amd-mdb: Add AMD MDB Root Port driver
User-Agent: K-9 Mail for Android
In-Reply-To: <SN7PR12MB72012B3F617DCE9BC398227C8B3C2@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20241127115804.2046576-3-thippeswamy.havalige@amd.com> <20241129202202.GA2771092@bhelgaas> <SN7PR12MB72011B385AD20A70DB8B56338B352@SN7PR12MB7201.namprd12.prod.outlook.com> <20241208125858.u2f3tk63bxmww3l6@thinkpad> <SN7PR12MB72012B3F617DCE9BC398227C8B3C2@SN7PR12MB7201.namprd12.prod.outlook.com>
Message-ID: <E73C5B2C-A594-49DB-9AF6-F2E3FDE972A4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On December 9, 2024 3:14:15 PM GMT+05:30, "Havalige, Thippeswamy" <thippes=
wamy=2Ehavalige@amd=2Ecom> wrote:
>Hi Sadhasivam,
>
>> -----Original Message-----
>> From: manivannan=2Esadhasivam@linaro=2Eorg <manivannan=2Esadhasivam@lin=
aro=2Eorg>
>> Sent: Sunday, December 8, 2024 6:29 PM
>> To: Havalige, Thippeswamy <thippeswamy=2Ehavalige@amd=2Ecom>
>> Cc: Bjorn Helgaas <helgaas@kernel=2Eorg>; bhelgaas@google=2Ecom;
>> lpieralisi@kernel=2Eorg; kw@linux=2Ecom; robh@kernel=2Eorg; krzk+dt@ker=
nel=2Eorg;
>> conor+dt@kernel=2Eorg; linux-pci@vger=2Ekernel=2Eorg; devicetree@vger=
=2Ekernel=2Eorg; linux-
>> kernel@vger=2Ekernel=2Eorg; jingoohan1@gmail=2Ecom; Simek, Michal
>> <michal=2Esimek@amd=2Ecom>; Gogada, Bharat Kumar
>> <bharat=2Ekumar=2Egogada@amd=2Ecom>
>> Subject: Re: [PATCH 2/2] PCI: amd-mdb: Add AMD MDB Root Port driver
>>=20
>> On Mon, Dec 02, 2024 at 08:21:36AM +0000, Havalige, Thippeswamy wrote:
>>=20
>> [=2E=2E=2E]
>>=20
>> > > > +	d =3D irq_domain_get_irq_data(pcie->mdb_domain, irq);
>> > > > +	if (intr_cause[d->hwirq]=2Estr)
>> > > > +		dev_warn(dev, "%s\n", intr_cause[d->hwirq]=2Estr);
>> > > > +	else
>> > > > +		dev_warn(dev, "Unknown IRQ %ld\n", d->hwirq);
>> > > > +
>> > > > +	return IRQ_HANDLED;
>> > >
>> > > I see that some of these messages are "Correctable/Non-Fatal/Fatal =
error
>> > > message"; I assume this Root Port doesn't have an AER Capability, a=
nd this
>> > > interrupt is the "System Error" controlled by the Root Control Erro=
r Enable bits in
>> the
>> > > PCIe Capability?  (See PCIe r6=2E0, sec 6=2E2=2E6)
>> > >
>> > > Is there any way to hook this into the AER handling so we can do so=
mething
>> about
>> > > it, since the devices *below* the Root Port may support AER and may=
 have
>> useful
>> > > information logged?
>> > >
>> > > Since this is DWC-based, I suppose these are general questions that=
 apply to all
>> > > the similar drivers=2E
>> >
>> >
>> > Thanks for review, We have this in our plan to hook platform specific=
 error
>> interrupts
>> > to AER in future will add this support=2E
>> >
>>=20
>> So on your platform, AER (also PME) interrupts are reported over SPI in=
terrupt
>> only and not through MSI/MSI-X? Most of the DWC controllers have this w=
eird
>> behavior of reporting AER/PME only through SPI, but that should be lega=
cy
>> controllers=2E Newer ones does support MSI=2E
>
>Thanks for your comment, Yes our platform supports platform specific Erro=
r=20
>Interrupts over SPI=2E
>

My question was specifically about whether your platform _only_ supports S=
PI or both SPI and MSI for AER/PME=2E

- Mani

=E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

