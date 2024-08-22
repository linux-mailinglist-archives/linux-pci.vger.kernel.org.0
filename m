Return-Path: <linux-pci+bounces-12038-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E661895BF5D
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 22:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F6BF283DA6
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 20:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDAA1D04BB;
	Thu, 22 Aug 2024 20:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="LOjtHvXy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DE61F957
	for <linux-pci@vger.kernel.org>; Thu, 22 Aug 2024 20:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724356882; cv=none; b=LSJN+Nol+KFIN1NEc6J+JAlOl6XRvz+JXeobHRKzrRHvSRI8Cmkb0XV93YuO7JLcKA1tagfkUKRU0ra2BEqiXBdumjsMbzIQviRYj945+6fyQyysZ588O4kYtFUqcXFlm0kk/2T+0ZWy74mkaicXloo17bW27kOPFDgWhsqFR2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724356882; c=relaxed/simple;
	bh=QarGgRQr+gI4+f2UfWJ5gh3yFj+scMNLwIR1YGzkv0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJ2qRhoMdHIB+1U4Bgqd21NXjBaOKP2HkPSOB8n/WNUw5cORiqp8557102jDVwEP0N3X9Ye/Aq7bSs685TmLJxN2+qG/4hrjMIsOJ9UsIhWe1rNpG7kqGA1Gm8+9I+yMcBm1QTRpLRW89jOikH6YAeRDZzsnMqrtlflb/l0+/+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=LOjtHvXy; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53345dcd377so1629164e87.2
        for <linux-pci@vger.kernel.org>; Thu, 22 Aug 2024 13:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724356876; x=1724961676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgHWaDNWmiIFNd4ncEUg8oQiBFdIcEtIv7xdX5ZNjFc=;
        b=LOjtHvXy+rN1UtIpdtm7iR9qPnhFoUQAc9rPis7Ig9k197ufGSCS6fboQq80sLJ/Qy
         2EWQkOUBfZxw1dw1AqXSchqakfiQBK43zHUIuPXTpeP04OvXFGOWyK6bXebGFfflsEvi
         OIG8Lof7+dmaXb6H8pIGpoUQJuao4LqR8/KMR0WjSwhaJ3jS44XFoU7QCkREGrOdz434
         Ea/gsaTZUEVxrRKoyjB02X109OVyvpyNHwoFbCPtJrqO3IetL6dw9UW1AfiU7dNm8Kz/
         h+pZqBpKIGmTyvqIv6zEZYXnsMnRc/iF1YqyOTLLPp8OTWMQEfIpPd5mQZPEhQAqbxX+
         7aiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724356876; x=1724961676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OgHWaDNWmiIFNd4ncEUg8oQiBFdIcEtIv7xdX5ZNjFc=;
        b=HDbhYjUI5/iNlc+fJB2nCzz+2mUXWTkssLEzFQhpk1nnNz5fBpUgt1ObjF5cSKqZ83
         rYhgbi3NBOk8c2qU4lo6LdfVpcUY046NlMUhIl1Aa7eKEyrGq+Efathw/+7W6xDqtHe4
         z0QA/El6bWyOYNMPdEn6J7GpuI4MM51bxZ/hOEf4QZWo/2LecrvYrlI0XdDjHOqxXRP8
         k6Re8A3FErF/c8YeWdeE/9NJPcLibR99qZMSB0zxaq29VgbhwfdMs2JJUw3iYqEi52Hu
         pB17qeNQTqVb1lIpEhseU/LLHJ8Ln1xk7dt/U7vCo+hhv4BuQANuRNO9iZr9oyRCtXeY
         iy0A==
X-Forwarded-Encrypted: i=1; AJvYcCVxY88RnjtIhScQqfIPOLJlByvfzb2GiQe5Ksaw6n5AmnRxO40RPwLxOHddaf2aGWtPucqETHTyZvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFQPWS0kPbDBwBFQLkPRGnQpATxtcGvyUii5bgPleUCcaP1O4u
	2SfqIB3YVr0Imr4qW8O7GrLFMYkzsnDLaPtExtrNDu/+5ypNieJ51vtPjB2xemDIAf8RMSAEj88
	0fWgfvhHOc6kshDWJ3AEkxGFcgyPghCcT1C18WED4/TJ5dayR0l59Ww==
X-Google-Smtp-Source: AGHT+IGDx6yb2VS9q05wWF0GDGcpEIDi1TSv52Or1xmRG3FDdwv89W2uTgFzK7JYmPGZ3u/3WrZX+wNo4dihHvHt45k=
X-Received: by 2002:a05:6512:ba7:b0:52b:c0b1:ab9e with SMTP id
 2adb3069b0e04-5343875589fmr46511e87.5.1724356875411; Thu, 22 Aug 2024
 13:01:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMRc=MeWFs+M+2kpotRqmcbPgXx8xCWEa-DqatGxWUAcixQb2g@mail.gmail.com>
 <20240822192838.GA346474@bhelgaas>
In-Reply-To: <20240822192838.GA346474@bhelgaas>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 22 Aug 2024 22:01:04 +0200
Message-ID: <CAMRc=Mcrrhagqykg6eXXkVJ2dYAm5ViLtwL=VKTn8i72UY12Zg@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] PCI: Change the parent to correctly represent pcie hierarchy
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Krishna chaitanya chundru <quic_krichai@quicinc.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, cros-qcom-dts-watchers@chromium.org, 
	Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, andersson@kernel.org, 
	quic_vbadigan@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 9:28=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Tue, Aug 13, 2024 at 09:15:06PM +0200, Bartosz Golaszewski wrote:
> > On Sat, Aug 3, 2024 at 5:23=E2=80=AFAM Krishna chaitanya chundru
> > <quic_krichai@quicinc.com> wrote:
> > >
> > > Currently the pwrctl driver is child of pci-pci bridge driver,
> > > this will cause issue when suspend resume is introduced in the pwr
> > > control driver. If the supply is removed to the endpoint in the
> > > power control driver then the config space access by the
> > > pci-pci bridge driver can cause issues like Timeouts.
> > >
> > > For this reason change the parent to controller from pci-pci bridge.
> > >
> > > Fixes: 4565d2652a37 ("PCI/pwrctl: Add PCI power control core code")
> > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > ---
> >
> > Tested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Bjorn,
> >
> > I think this should go into v6.11 as it does indeed better represent
> > the underlying logic.
>
> Is this patch independent of the rest?  I don't think the whole series
> looks like v6.11 material, but if this patch can be applied
> independently, *and* we can make a case in the commit log for why it
> is v6.11 material, we can do that.
>
> Right now the commit log doesn't tell me enough to justify a
> post-merge window change.
>
> Bjorn

Please, apply this patch independently. FYI I have a WiP branch[1]
with a v3 of the fixes series rebased on top of this one. Manivannan
and I are working on fixing one last remaining issue and I'll resend
it. This should go into v6.11.

Bart

[1] https://git.codelinaro.org/bartosz_golaszewski/linux/-/tree/topic/pci-p=
wrctl-fixes

