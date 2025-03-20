Return-Path: <linux-pci+bounces-24253-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4EDA6AE32
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 20:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2259616C04A
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 19:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125C41953A1;
	Thu, 20 Mar 2025 19:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nZWQ2ktC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F83E1C5F2C
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 19:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742497635; cv=none; b=EDVx2IMfGCUhl5DtJV5JWbv+/AIowZZaR//grtpXu2kHD/l9E0fLtHLhYxMEmn5ZE4JJOJcACcdEB8lDknMUvPknk+r/ULqscWkH6Ubq41oxVKxHf2vQOQ1ISUnlZbMORL9EvQ12Mfhxp9yWhQXqpM3GZtni9d9Qj0ynLaNLLlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742497635; c=relaxed/simple;
	bh=HjnFDf5srSi8TnMMbNXv/ZM07arFtGVuLWBPzkF4SUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fhvubKOD4+TRcQud7SlOvx5wgqBTR4h6W5crdWdNYVvu45YM4SIy7VlAevvlpfgY9qes6DJdT1OjLvFdRMH00cUl+m3739Tilmnogv2x3/ZEztdTN9JB4jeTCyrB5Gu5RSTOsZkiJQTqI6MdRQhzohhMZCVVHfnPWvDfjtBKpAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nZWQ2ktC; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e5dce099f4so1638893a12.1
        for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 12:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742497631; x=1743102431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjnFDf5srSi8TnMMbNXv/ZM07arFtGVuLWBPzkF4SUA=;
        b=nZWQ2ktCNRUePd+hCNnJCvAzT3DuvNcqcFWk/dfsck0+dYcniIvVfV6/YcwvvYVnKK
         vgfB8Xs3guMwyVaKQYdkZYqtuCuFekBpuESV2chvv6T30LahN/OtFIK0kGP0lxzsi+V8
         q5/s4OiFq8viOEjEdbdS2yxOQbwpXTDoTTjenkIPqxtKRxjb+oCUSbqdrV0P1tzbEWnJ
         dJKLxy1/OPoD4IpNNeB69K4bhZrNwe89wEA1i2l8qzjZTY4+QhtwqsI3myO0v06dPWdn
         Az/C3on3Y+tUIJ4kH3xh1EPAbeh2z7HBiAT6xRRn0XScsx5v4Tm1ML06HMFxI62DL+ic
         0UHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742497631; x=1743102431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HjnFDf5srSi8TnMMbNXv/ZM07arFtGVuLWBPzkF4SUA=;
        b=dyOj1dsyl6zUeu38kKb4YTln7E3JARcf+iiaZHyPH0Wu/kdpOSfwK7D9jLdu20Txel
         oncYAFA+iK4YBOiW1qY289gaGPIFebXyx5vsaLsh1GUbthewkUDpDSdqLKW0nE92Diq/
         gPX1hp1LeoH1xnZhfDWoDTr6LixsVDeTeVZ1r/T/8YVebXNs/oq3ii0qXEdYRWWuQrkt
         plElLEZV2eCnjOOkp+uDWeWdpKmF0lkV76tfmMZY7CR4oC9ViXYdERbPF668zblkjmGl
         l8UHSg+eAP/A7e5ZEDvBNhV+0oyH4go7O0xhGazojnaayC4KKwEC5i68laJ19oYmhsE6
         3cJw==
X-Gm-Message-State: AOJu0Yxn/zPg86qc2rwv0opklz/UGi2Nel07X/7/vchpFu9t1Ic8RKVu
	UrfrpkBb9KUOt594Dw9i9y/1Go2fwcw2qFeJx/hTKuRaGXy76Y4Y86ZlNJs5Zp3b8pDA7YIExq3
	PttlM8r7ifpcyLwFtSCsRu0H7mIIAI8N4IW/I
X-Gm-Gg: ASbGncsFuoL2sXdB/irXfMpVz/OLt04vBHpGDkY6NXrTULft8xyIkl3UTgRoDZxjIn0
	/ftlKq5iNlCZNYxXDG6FOPcHFfrCxExmRL2S0Cz0v+Zm7okqqoBzrDm++Vkm7spbkIlWZMKaoLx
	IpgqJDr4xY7huxz8sbpLpeiBv4eKmEMbPLm1cqfep3OK5CRPWFXIFapjrx
X-Google-Smtp-Source: AGHT+IFgv/UV7XRpXNngh5B7q1Lg2Yrlm/I+Xd1mONg/ZBPfxB5TTWVli7PM90IlJ8+Dp0Worgwbr92N7UOw0tSIoao=
X-Received: by 2002:a05:6402:268f:b0:5e0:9252:3550 with SMTP id
 4fb4d7f45d1cf-5ebcd406becmr416545a12.2.1742497631408; Thu, 20 Mar 2025
 12:07:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320082057.622983-1-pandoh@google.com> <20250320082057.622983-4-pandoh@google.com>
 <93a5832f-3e64-40ce-b089-b94181e8ba09@oracle.com>
In-Reply-To: <93a5832f-3e64-40ce-b089-b94181e8ba09@oracle.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Thu, 20 Mar 2025 12:07:00 -0700
X-Gm-Features: AQ5f1JoOuz3xxSB1RktIy_5i2Q2B53eHUX40xTIH0w88FqAw73Dttmff9LiAO_k
Message-ID: <CAMC_AXXKqeQOVmNHZyY4L7+nxGiDsy9Wsex-cx6Sbwm7z5unCw@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] PCI/AER: Move AER stat collection out of __aer_print_error()
To: Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Martin Petersen <martin.petersen@oracle.com>, Ben Fuller <ben.fuller@oracle.com>, 
	Drew Walton <drewwalton@microsoft.com>, Anil Agrawal <anilagrawal@meta.com>, 
	Tony Luck <tony.luck@intel.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Terry Bowman <Terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 7:59=E2=80=AFAM Karolina Stolarek
<karolina.stolarek@oracle.com> wrote:
> As for the first one, I'd restructure it to chain all the sentences
> together. I'm thinking about something like this:
>
> "
> Decouple stat collection from internal AER print functions, so the
> ratelimit does not impact the error counters. The stats collection is no
> longer buried in nested functions, simplifying the function flow.
> "

Thanks for the suggestion. Will reword in v5.

Thanks,
Jon

