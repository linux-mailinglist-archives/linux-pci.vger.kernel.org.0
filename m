Return-Path: <linux-pci+bounces-30870-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B65AEAA7B
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 01:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79ACC3BE498
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 23:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505A221CA02;
	Thu, 26 Jun 2025 23:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MF9sDX6M"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5E41DED7B;
	Thu, 26 Jun 2025 23:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750980088; cv=none; b=kmNqn8KX9HW7P1H6pEU3NtRi6GWfM8IWgLi4zSfBhAWXd67A+pZUKvEtJd6o5DpJpuunLPeXezFQqB8UHIiwvcIQK6xcHwKu7hnXOLTBmyhQTYWQHkdMqKXnWgyE9lllo37h5fTTicxp/mQBt0QCihhHP9CJNcWkm0VMKqAswKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750980088; c=relaxed/simple;
	bh=Q3nGv1yo1n6sdq6f5OTIFrtqvILRNdbS9JPFdTkNb4M=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Xuw6vuy45Cs7ceO2NdzV6G27rqq/ldA0/f6achcBY9HdGRV125y8dYrybx0vvoZkmgc+qvaAA+Y2/l1Q0eXpiDKuE3Sf/aVU9HW16+g3xUXzmOMEe6ulsMj+pK9uS/r2L//Lil1n0/u46hZhwFyMNkEHAWLRX3MuL4H4iyZH2ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MF9sDX6M; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7494999de5cso1112557b3a.3;
        Thu, 26 Jun 2025 16:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750980086; x=1751584886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NhGLtqLzXEo4D9aPX6yevO8SSkLzLzne+BivULMO8DE=;
        b=MF9sDX6MApXy+fW6b4XW9RamO/ru+W6hKGnAAGOBF0HPhCKfSj1ozhVHvT/iSoW7fS
         Y6zei+iUQRhDVPmHF1kNfKH3yzBbXl1X6+R2VaSDj/Jznr9X6zWt05HY9ZkUXrj41TBe
         40t3HpGRnyArnpLXQqAOBrSbTVVUJ5ZnaHhhhJpgXZ22bICbVX6xWr+9IN6R5Q6YI79F
         y86UVP18a4+JqzQFcUaPpSmksSXu6ejJpU+Z90msGind2kpNijTxnvQu++vgoRDSCWux
         CkETW2u88wYMQvM/90ViDrJhdtrdrgvtiEorp2+QlTfQ5QVEN4Qaw2Okk4tbn4rvDgVJ
         Zc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750980086; x=1751584886;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NhGLtqLzXEo4D9aPX6yevO8SSkLzLzne+BivULMO8DE=;
        b=S/4SGYsWKxcq5skTM+x7W0v5X4ZchSHQHEQzw208qH5G14qtENf7Zw8o04HU3bgfU2
         4xl4AHcLQXzgDpZvGRsMdt90WcCi6al8PO6BWFUX4nP307ZYaM022tdL7iXZd2dZITQC
         rT9wF1xZ4UdiPhsB2OBL8KnLL1hckdL3eWXBWRolHhwzzNNdE9/CD6OFJxDg9749u3mJ
         CG1ESzHOFj3DetKqGh3uZXpHGwWydNeEzPszdTI2Q4+W28TlP3r/FbsYEZcHo4iJEcLU
         ecnRyCQlMuwpgp78sHD+Ig9ozZeD4iwbzLnhCNPqi5ddC+tNthISh4P6h2Nrozm1Vu77
         WeAg==
X-Forwarded-Encrypted: i=1; AJvYcCUjjyrzblf0aMBfrFyHiXgN17JdPmAm58qzdz4DumikC4mPJuk4hRLp5IatayXvUwFg8hDhHe11@vger.kernel.org, AJvYcCWD9I3AfiQEz4npQaYKa+lrzeZBzQwpVmhqIkZXE8/F69t6vMPXz1IxOgsQwQU49vmA3EtlAcfMh92F@vger.kernel.org, AJvYcCWIX6pSyHefl6cV/VQdIADZrQFrzAY+ZqvVWxBH55QIcuiXbGYRhKbb57oBIPUzLF+U7Dv5bKFBau2+@vger.kernel.org, AJvYcCWMv6OmfTKyzOg14vKxwnz/3OIwJGb9vKX1PGGpAdyFKRu7PtRAdRyg9VjSyOA6LdrZiirqkH9srz6ygSVpo2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyHnqXjP7/9ou1MnJd7y2h1RCqeRmpsRrBZAUZBuZ6lLmxbfA2
	kUyO6106Pt1WULnT+2MWRnHMczE64UAP639JIcgSEqJ/mO0Cauv9cRWu
X-Gm-Gg: ASbGncubu5ZYQyxsw4Z6yNFQ+31z/KkKEYAqbHGMlqWln6JfUqMkaYstb9pRaXlFchV
	S7tOKHVz+s68Q2xElanYdf170k27MiiUf3TbZsFy5Y1EpMiTpcg2Q6qqPZMl/WBlX4jG6oBUTYm
	f27m+j8O8E1QK5GXommZH0LyIhG9qvtoo/eX1z+3kb8eYCaBMmTYTLQMv5lko0B/qAWMAGeeU6p
	VIi/CEHZBgURIeReZDHbDW1PDHHRbQ5g5Myk4HHS2hO2Vlbydb0QpybgNjcO11GLOnWmhCVDVPm
	7xrcxYFqFAUaSt0psAVseUCbHOwdxU+6hRx0BlohG+T5Bm8UGN32+4vgqOyzmIVlytZo0xYH2v0
	ZZ10=
X-Google-Smtp-Source: AGHT+IEgVBxLC8ftPFFqIGaEQHG0r/elOwjK2mBDxK14ymVCHywbe6l17EqzlRJKqihZM0Hp26HcUQ==
X-Received: by 2002:a05:6a00:9a3:b0:742:aecc:c47c with SMTP id d2e1a72fcca58-74af6e8bb5cmr1409468b3a.7.1750980085736;
        Thu, 26 Jun 2025 16:21:25 -0700 (PDT)
Received: from [127.0.0.1] ([116.206.223.154])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af557b27dsm714099b3a.84.2025.06.26.16.21.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 16:21:24 -0700 (PDT)
Date: Fri, 27 Jun 2025 04:51:19 +0530
From: Bandhan Pramanik <bandhanpramanik06.foss@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, ath10k@lists.infradead.org,
 linux-wireless@vger.kernel.org, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_Instability_in_ALL_stable_an?=
 =?US-ASCII?Q?d_LTS_distro_kernels_=28IRQ_=2316_be?=
 =?US-ASCII?Q?ing_disabled=2C_PCIe_bus_errors=2C_a?=
 =?US-ASCII?Q?th10k=5Fpci=29_in_Dell_Inspiron_5567?=
User-Agent: Thunderbird for Android
In-Reply-To: <E8A26FD9-13E3-474A-87FF-ED8D27A1F27B@gmail.com>
References: <CAEmM+Qi-Waxk5qcR+nfip-QGXaKk0-Kq7QSq890e9oYOPjW+bA@mail.gmail.com> <20250625202014.GA1585022@bhelgaas> <CAEmM+Qg+xxMfXb=704OfwYLou7Mh_BNaTevLaGfiG2peZotJoA@mail.gmail.com> <E8A26FD9-13E3-474A-87FF-ED8D27A1F27B@gmail.com>
Message-ID: <3214E8BE-0A5D-40E7-A4DC-C1027CD052EC@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Just a small update: it's not the fix=2E Back to square 1=2E=20

On 26 June 2025 11:23:14=E2=80=AFpm IST, Bandhan Pramanik <bandhanpramanik=
06=2Efoss@gmail=2Ecom> wrote:
> Hello everyone,
>=20
> I think I found it=2E I used irqpoll and I didn't experience any hiccups=
 with my mouse performance=2E But the Wi-Fi was still malfunctioning=2E
>=20
> To linux-pci and linux-acpi:
>=20
> It's an ath10k problem, sure, but there's something definitely problemat=
ic happening if, in the normal state, these Wi-Fi bugs hamper the touchpad =
movement=2E
>=20
> To ath10k and linux-wireless:
>=20
> I tried out "options ath10k_core rawmode =3D 0" along with "skip_otp=3Dy=
' and the Wi-Fi seems to work perfectly as of now=2E It might be the fix, i=
t might not be either=2E But I think there's something more important to as=
k: Are there any good resources/documentation on referring to what the diff=
erent key-value pairs mean? Like, what's the exact documentation through wh=
ich people arrive at "rawmode=3D0" or "skip_otp=3Dy"?
>=20
>=20
>=20
> Bandhan
>=20
> 

