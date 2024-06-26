Return-Path: <linux-pci+bounces-9312-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAC9918548
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 17:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A55551C230CA
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 15:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC0118A94F;
	Wed, 26 Jun 2024 15:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="1CFGL6q/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9121891AD
	for <linux-pci@vger.kernel.org>; Wed, 26 Jun 2024 15:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719414445; cv=none; b=rxu98iSFMfaXzB7D/21XQ68YnclySpjpE92H1mJMMCskvzTjqvmgSdJGuR4k1Hn/TTG60Oiy2+wyHHe4hoNGb5qcdarAQKhLdJ99e53SdvII4KIMzijtXap0fHGKj6hA7QzSVyewznnz0oOe+fjO4+XXRKrVYI4eAscg4r1HCpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719414445; c=relaxed/simple;
	bh=wXPMzNtNlpsPJeeERAGhiFsCceMNMb3huYtSRM1DPwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QOVOsxYOCzLzL1T7VA6h5eWojoUFOW1Ub4dUFTHcPvCYdZC5ZclUgxLwTpgZRN8f1Dkhv9HY7hTRsTuZdjz2FXUToM3DDF9aPMPK2oLciCDEHVgP/1syQETk03P28R9uVV56wV3zBdXvq2XArZkRHfqnAzXIOYhHzz+0kgbqj5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=1CFGL6q/; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ebe785b234so75157851fa.1
        for <linux-pci@vger.kernel.org>; Wed, 26 Jun 2024 08:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719414441; x=1720019241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPxOJfkJIWCY4sqntkOf7FIbvrW1HVZyYX7BT4XYMJ8=;
        b=1CFGL6q/2aGvnWYJoCUN9Ar1l28aj+2En5Px8PWW+ij3f5viv8qy+/fFR+X0jO2yCm
         r5xKYAtR4LGz5U8Gntx7YRB52OuwsZmhrkvQyK1+bkM993ny10m03o/BcCC/4f70/kZ1
         SOv7bvPypXzBq8XZcaK7Ch2EgIxLKWukydROY5MUs42nSz64/VMwp4nNm32uNV8z8LSt
         o8JXBdXJhQfkj9pkbeNPAbp0qokI5L7Tx4UwOej3Bn+4lkZPuTzKbd+E9FEqx2G0LM6J
         CWqOmwHd9LwauHu5N47AZXc8s6AAKgn0qrRQ1DTYs6yWR7Hmalfy22zD9lOlv5EAsACw
         ZuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719414441; x=1720019241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KPxOJfkJIWCY4sqntkOf7FIbvrW1HVZyYX7BT4XYMJ8=;
        b=JxfaPkSmW1RucOJPv335zmML+rahilEfjO92UsygWQfuZyWFmOu/CwlEmc6YVzeJpw
         f6Yh3tpffnSTtlXEOGD0H1s+vn2w9Ms5qeDCgWx4ZU/kT7fNE8r0HGxrU/F6qTr7Gv2S
         Cpw8icNnc56CG3TiVx33yobAj1og8dtKQxRfZyuAH8mFGCw71GlLRij8RuDEcAkIg6M9
         V+a5XFt53osJl05X8V2K257jqB3TuBhZNh2l3fQWLWR5Wp9DnA7UuBAcg1pUNylcndgC
         EPfXpYi+ammbvYfqvbRDgrkzTpBzMKxTSYmd8ZrSromEIu5DScW2Ovp4LpRBKtmhfr8o
         aNvQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1ulSYbqerrCJFsAfSk2kg1Iw2bsaHYKcIl5wmrdrPiJWfRbNmtC0Zq9XGtXdZhfv/pjUHxYqYafI0Zvatdv0jZs16hMrQtt8P
X-Gm-Message-State: AOJu0YzVGyvQZ1z8yYSBwEf4drYj3AVBOUUnDC/yB9Vb3K5GytI4boz/
	B402V2pZdUIq8N9nvEXfMp8GEVMKXN5hr2lVxg64y2++k1pnDD0dqQaJSsONGle51VK/h4EUBzz
	4ERciEFjnklcaYBOhU96rZOfqOBzRMxZUrvd4HA==
X-Google-Smtp-Source: AGHT+IEUkNjLlmTxavRfhMndMCySdn3PbAFz1s6PnS1Bxg+VsA4owIRUUH76BL6HCSdoGMnwFnx4HSaROo7ZAfFCFEQ=
X-Received: by 2002:a2e:9f10:0:b0:2eb:fc08:5d83 with SMTP id
 38308e7fff4ca-2ec59389fffmr76705281fa.44.1719414441210; Wed, 26 Jun 2024
 08:07:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626-qps615-v1-0-2ade7bd91e02@quicinc.com> <20240626-qps615-v1-4-2ade7bd91e02@quicinc.com>
In-Reply-To: <20240626-qps615-v1-4-2ade7bd91e02@quicinc.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 26 Jun 2024 17:07:09 +0200
Message-ID: <CAMRc=MeAz8yT_-YR8dSW+hZrezbhsTcc+oSdCO=+sZ84M=fkmA@mail.gmail.com>
Subject: Re: [PATCH RFC 4/7] pci: Add new start_link() & stop_link function ops
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Jingoo Han <jingoohan1@gmail.com>, quic_vbadigan@quicinc.com, quic_skananth@quicinc.com, 
	quic_nitegupt@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 2:38=E2=80=AFPM Krishna chaitanya chundru
<quic_krichai@quicinc.com> wrote:
>
> Certain devices like QPS615 which uses PCI pwrctl framework
> needs to stop link training before configuring the PCIe device.
>
> As controller driver already enables link training, we need to
> stop the link training by using stop_link and enable them back after
> device is configured by using start_link.
>
> The stop_link() & start_link() be used to keep the link in D3cold &
> D0 before turning off the power of the device.
>
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  include/linux/pci.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index fb004fd4e889..3892ff7fd536 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -803,6 +803,8 @@ struct pci_ops {
>         void __iomem *(*map_bus)(struct pci_bus *bus, unsigned int devfn,=
 int where);
>         int (*read)(struct pci_bus *bus, unsigned int devfn, int where, i=
nt size, u32 *val);
>         int (*write)(struct pci_bus *bus, unsigned int devfn, int where, =
int size, u32 val);
> +       int (*start_link)(struct pci_bus *bus);
> +       int (*stop_link)(struct pci_bus *bus);
>  };
>

IMO stop_link() should return void.

Bart

