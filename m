Return-Path: <linux-pci+bounces-4336-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A061A86E605
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 17:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9103F1C22DFB
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 16:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879DF63D1;
	Fri,  1 Mar 2024 16:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="tBLPj4Ql"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45AD22097
	for <linux-pci@vger.kernel.org>; Fri,  1 Mar 2024 16:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311260; cv=none; b=KKAWPEaaE6F6E/G7F4FRM1ll7U7GpqkhErg1yzxvGAj2x+a2NQhY62uf/Vi0Xf3m5WJpNMIkgPscDKa7yNmZillLEvAEKu7LoaZIqD1Dbdb6OOKVqPmZDpmUmAKjzZGRJG4Lk95tnwraZpTm8vXInnBaGUx/ax2mhCZN/jEInw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311260; c=relaxed/simple;
	bh=umTXz3ZT5C8ePr1KzuYmsw8QvuSyN39VEUFqMYPBI90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fuF1jIU1HwWxSGTeUMamELWQovQn45yetJbENhT7g+szQ+9jVGdIjlnROT2FbvHcS0K2sEnL48H0cNpeeUFGetTJvS5mmPbziM3F9DV39owfx4xe6tlmt0AoLbquMl26dNRBzjbVuVQ7dQoZwVvhdrKyvvKWSbnhAoEROIRsAc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=tBLPj4Ql; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc6dbac5fd1so807538276.0
        for <linux-pci@vger.kernel.org>; Fri, 01 Mar 2024 08:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1709311258; x=1709916058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umTXz3ZT5C8ePr1KzuYmsw8QvuSyN39VEUFqMYPBI90=;
        b=tBLPj4QlU54jivbt5l2IjVuW0hCicPGJYZRxwK75dis7xDjpD/w/5oESVHJcVLMFin
         nKpcBJ3QavZpimHWLOhi0QeBywNzTB4shawGwSfql4FoYiSoKNcR1UGzvKCMvBOleTmz
         pCAjtOf6Mof3daG5NKVeqUdENhQU6b7k5ViGDK4cT/HcPmOQweAIKZtmuNZMgoGHOM9y
         YFJTCR9mNtkeTCb9zn9NtWqjnY27FKQ9/MXminTlocxi5+6YMnmzdrxCpUKPG3C0WwsB
         tRhTgRNdN6v6dXzogwUkgZPjz/cjVzIixk6P8luaR6tSZwI3t2T13gamgNAQNH8BKH+D
         HBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709311258; x=1709916058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umTXz3ZT5C8ePr1KzuYmsw8QvuSyN39VEUFqMYPBI90=;
        b=sLIDFKC3YHy3MyVkUeWgTx0nubS9JRL+r9eHX3UGeTiTwP+T71IDCUBiJdBpXXoE6b
         6C6ud1iLoN2/nxa9tMrRg3e7RZwHM51ovxD/4mbAab89giK1TeeO9h6W78x2yFH4TiU9
         FPgpAq85t03U6bFLbYoWF2N/4GqUKQ27gojCNFsITIhFDEAltaJWTPdHE8cux4ITh9Yo
         MhG3jNYNmBNqRx//p4xM2HkqXrAKQlqP6jfKa+VuGy9j6HmEfaJeeCPxoAUXdOvCXYYo
         zCBbUNpq3YQnNdJbc4mmYuo7XTgBfSphotaITuXl3k3gMc0gPiHCTK+5lftaz7xBpm2J
         1+PA==
X-Forwarded-Encrypted: i=1; AJvYcCVAdQoGimVnyV5r3YLC9jfG0wQV/MKoWJC6drbmGckJRd8LIcu+HQg5Xd1kC+dta1FxgX7XShQtUVGkRWgTM8TwS/uDi09AVPF2
X-Gm-Message-State: AOJu0YxWxZCdiWZR/9pLRSfH3bn8+HreFO7s/0cTKLiIfc/P8sCnbKuC
	jWAr/6mMdfJp5kBTIuwyjQEUuXTY9WiMvQ4QJZ5q3gjxPTpb1oKzIdJG0H/aqzEeES14SehlIVd
	fQn+pHxP0Y2NcKKHzvojgriBLcaI7Gw3PzQn36A==
X-Google-Smtp-Source: AGHT+IHXRFn/QAl4LlF978N1B1MGBJwuHJP+r4EDD9WxRcKB0FgCLphss5DFEjZedgGla55+Smy8fhz4NDuMrngyZ0o=
X-Received: by 2002:a25:8044:0:b0:dbe:9d18:31ea with SMTP id
 a4-20020a258044000000b00dbe9d1831eamr1826145ybn.1.1709311257708; Fri, 01 Mar
 2024 08:40:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216062412.247052-3-jhp@endlessos.org>
In-Reply-To: <20240216062412.247052-3-jhp@endlessos.org>
From: Daniel Drake <drake@endlessos.org>
Date: Fri, 1 Mar 2024 17:40:22 +0100
Message-ID: <CAD8Lp45=Kd4pG0RHhsTdg4p3-v+X3xfG=O_cH1OxOqJ4xPx=cA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] PCI: vmd: Enable PCI PM's L1 substates of remapped
 PCIe Root Port and NVMe
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, David Box <david.e.box@linux.intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Nirmal Patel <nirmal.patel@linux.intel.com>, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux@endlessos.org, 
	Jian-Hong Pan <jhp@endlessos.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bjorn

(Stepping in for Jian-Hong who is on break)

On Fri, Feb 16, 2024 at 7:25=E2=80=AFAM Jian-Hong Pan <jhp@endlessos.org> w=
rote:
> Power on all of the VMD remapped PCI devices before enable PCI-PM L1 PM
> Substates by following PCI Express Base Specification Revision 6.0, secti=
on
> 5.5.4.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218394

Curious if you have any feedback on this latest patch series.
https://patchwork.kernel.org/project/linux-pci/list/?series=3D826660

Thanks
Daniel

