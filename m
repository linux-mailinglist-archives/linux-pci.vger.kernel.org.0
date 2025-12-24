Return-Path: <linux-pci+bounces-43640-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 582F7CDB6BB
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 06:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0904C3009C25
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 05:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF5F2D7DE8;
	Wed, 24 Dec 2025 05:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEzs6za+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF23F329E7B
	for <linux-pci@vger.kernel.org>; Wed, 24 Dec 2025 05:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766554737; cv=none; b=jj85JfuQjBMo6RdJvXyzwmOy/ag9T2a1Vf98BADxvlDSigIOkHrDVvmJurqOppdINPaxfWZLfKa93QtrSAgfDwNpec/csMcd2dGmGu64NJLUX+8muQr53s/x4KJFHUgXG4s9b/VoaQhcIk4pcyuw+nOnfAHDeXcrwAWXbJ/4v5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766554737; c=relaxed/simple;
	bh=gYJuqgstKIh0GJjfHL+Z+Y8jqbQuzP2SNZTadlMrpwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZY18Xv3zEnyJC06XaDA+TkUaf7qqxiu+juWqv1bgNQu15iNnJS/Z5CT/dgvJ/h6OxWTLwESjgtNLcwG5YEUsWgtZZTO3y7bjkn43GXuPXBaNFBb8ugFQM6co8al+tPcwBFM+WAjuxG4zVp9xI5iXZfRKdC+tngFg4CtqiNIFJ/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEzs6za+; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-37b99da107cso55430391fa.1
        for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 21:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766554732; x=1767159532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYJuqgstKIh0GJjfHL+Z+Y8jqbQuzP2SNZTadlMrpwc=;
        b=HEzs6za+cUrXJh+kQooA9bq6BhJMRFof2QyHck4FC1VqXCAP58wB/1/6XTp2lmRQJE
         uvcmHO7ZFIJ0nDIztrO7Yq3JKHF8E8P3F10LFIE2lGKDUgARP2QSyHfMAW+mOnH6mK9B
         33/wpwWC8ccfbHQ8I9h/erK7CjqwYj7h53FsgdHDt4xJfTvsFAWdA/PYcMkVLRg+xK0k
         GvvP9LJzFwSHoZfS2VvKuA7Vn+PwufBwygPMsn/w+B4O+YuzMoek0a+Sdo7AY3pJMAbV
         5ZCqiDFxJZgZqVPDHjIEynp5LVGOh5AmF8pPY4Ir6xQ66LfEoiAJcwhkSCEhoXb++2Am
         Yvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766554732; x=1767159532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gYJuqgstKIh0GJjfHL+Z+Y8jqbQuzP2SNZTadlMrpwc=;
        b=OEdO7gGO8dwCLwgBD13IMH5bNcOd0sk8RKRr0YyDWN5Mer0RcrUiQJQK9fbP72ihzL
         J1CLWRaRPpB8+oRPiosEdpEKZsOYenuSKyl1CBuvk91zBCXLauiNeZD4Yjrc0MCKyyDc
         KJeEnuE4ri7FgFOz08wZWlILROvQzr0SGrJdZ2RsfV8hnUP3jjnh3BjjNfh4e4CptEAB
         kJPk0LeDZlQpI+FhfBaix+u95h257zDHQBIWL1H8jNXQr5QXiL9qj3KhgQJliYd5/Yd2
         V3vPmB6aLOIPiaSKAo/5Cbvk5UFCXNHW9jSZbVkvJz6S1TBy/pTeMI32RLPzMrZgTeJ4
         0P8g==
X-Forwarded-Encrypted: i=1; AJvYcCVfXGAr4UM5vt4o/rJTg2WeinKzVK+eNjwzx4hPjB9b9IkTIX6zZOAENOsEY1iM1GJ1C+5jfqxx7oA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwliGnGEhljsF2YtcN1O6+iVzFVOqu9TeFwFwm4KZvlmoOK95tR
	X9YhV9Z5x51hpgiezNKZuvFDMTy9psD6q1IN+dnZ3g6RPzNWV5/p9LOcm/ci2uV7OXBAoiTjQAT
	fgOJirf0yIATFhw6P+eEE2UunwNlBqT8=
X-Gm-Gg: AY/fxX6AKdoox+T+YZJFeWr8cC4Xs3gNmR1rIh8pQxCjb5H37YTnMFo8Gqnurjxnoeh
	Z+Zs7G8DzIKR12w3GTbflfxsXgdcBIjxX8/LiPRe4nniNXWCZ1v5zj9TC5hIcBU2VrI7oFqVlG0
	N0LlBtiwWeGQGQnCN3KX1HZtVptq/+480eRjI+vOmGb2a9agZYAvYt6agfBAw0TFyYPHc9ZDKUP
	vqmCxXxdCJ1rT+lZcnHUcbaOW7uEsywTXYl1VaK+EaYAoHEGJnmUw/TgElygwFzs55JC6+Se8WP
	oM8CDRE=
X-Google-Smtp-Source: AGHT+IEhBbHKWWQqJ0bLZ90EcsrdJcWpLU40nsZoqwzQPtLYH3hGZjtotZ2t+Nq21znTqVIk5zZUzbsS4uHKvlFDmMM=
X-Received: by 2002:a2e:be20:0:b0:36d:4e3b:f1e3 with SMTP id
 38308e7fff4ca-381215967a0mr50931101fa.13.1766554732253; Tue, 23 Dec 2025
 21:38:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763415705.git.geraldogabriel@gmail.com>
 <eaa9c75ca02a53f8bcc293b8bc73d013e26ec253.1763415706.git.geraldogabriel@gmail.com>
 <CANAwSgQ726J_vnDKEKd94Kq62kx8ToZzUGysz4r3tNAXvfAbGA@mail.gmail.com>
In-Reply-To: <CANAwSgQ726J_vnDKEKd94Kq62kx8ToZzUGysz4r3tNAXvfAbGA@mail.gmail.com>
From: Geraldo Nascimento <geraldogabriel@gmail.com>
Date: Wed, 24 Dec 2025 02:38:40 -0300
X-Gm-Features: AQt7F2qOfdS6yP1-vW3vU0Wj_YVm_E2b3cZOlrdQ3B5k7vwUx3LT0aqmG2BtcdU
Message-ID: <CAEsQvctSY7-RQEQF2TmJU2qKPZOe9TC5g-7Jat0LQKRHYz_6dQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] PCI: rockchip: limit RK3399 to 2.5 GT/s to prevent damage
To: Anand Moon <linux.amoon@gmail.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Johan Jonker <jbx6244@gmail.com>, Dragan Simic <dsimic@manjaro.org>, 
	linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 24, 2025 at 2:18=E2=80=AFAM Anand Moon <linux.amoon@gmail.com> =
wrote:
>
> Hi Geraldo,
>
> On Tue, 18 Nov 2025 at 03:17, Geraldo Nascimento
> <geraldogabriel@gmail.com> wrote:
> >
> > Shawn Lin from Rockchip has reiterated that there may be danger in usin=
g
> > their PCIe with 5.0 GT/s speeds. Warn the user if they make a DT change
> > from the default and drive at 2.5 GT/s only, even if the DT
> > max-link-speed property is invalid or inexistent.
> >
> > This change is corroborated by RK3399 official datasheet [1], which
> > says maximum link speed for this platform is 2.5 GT/s.
> >
> > [1] https://opensource.rock-chips.com/images/d/d7/Rockchip_RK3399_Datas=
heet_V2.1-20200323.pdf
> >
> To accurately determine the operating speed, we can leverage the
> PCIE_CLIENT_BASIC_STATUS0/1 fields.
> This provides a dynamic mechanism to resolve the issue.
>
> [1] https://github.com/torvalds/linux/blob/master/drivers/pci/controller/=
pcie-rockchip-ep.c#L533-L595
>
> Thanks
> -Anand

Hi Anand,

not to put you down but I think your approach adds unnecessary complexity.

All I care really is that the Kernel Project isn't blamed in the
future if someone happens to lose their data.

Thanks,
Geraldo Nascimento

