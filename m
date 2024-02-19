Return-Path: <linux-pci+bounces-3707-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A5D859DBE
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 09:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC7851F231B8
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 08:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6728324A0A;
	Mon, 19 Feb 2024 07:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="VVl8JQpi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271A824A19
	for <linux-pci@vger.kernel.org>; Mon, 19 Feb 2024 07:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708329431; cv=none; b=qLISLnbpWzKym2+4fRLtcsrwx80exOWxgkTUBOrlL9bryahzOFQoW7aYsw4ieeXOsv6H5gDNVxCRrJWWRgyY/2AlblErP9RvNkVgp2BDRMnayn9i8ARXWS06LHcHohgn4UbDi579BP4mTjgHPyOfAEp7jS7QKfcjth8pB0lLgms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708329431; c=relaxed/simple;
	bh=Oey3ZN4EIWUJzNAo3Boteeg+KwnzJ3oRelbiZ+NcSGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fj3wAcZOPwGktE0u98fmDjZtntCgze0OiDJ7i+CFdxVek2mLXRpLvWGsxpiL0DgsdQiemFPrbIE5IrTU2iOL1DWJ0XF1VAb3TIj7CcXanRBDsnyOEHfKK5LdjWiX2xnL8PUwVFFoAiIYrUrf8Ec8c9Eepp0yCLSzNo038yyPCkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=VVl8JQpi; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7d5fce59261so2632454241.3
        for <linux-pci@vger.kernel.org>; Sun, 18 Feb 2024 23:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708329428; x=1708934228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oey3ZN4EIWUJzNAo3Boteeg+KwnzJ3oRelbiZ+NcSGs=;
        b=VVl8JQpietD6ymCw8P666kr9JYEJOP/6jeXxWYk9wcv7MiDlOZHDq7j78X8ip5RtIL
         oGOg9zYfQV0Sd4wVp+AvOhyd1zR/usG2RKVc8dc9MV8tXFrH2CeZQ0YWWa9evUyQJQ/s
         drcPWv7qhkki+1T1yyXOIwpaLakGZoChRSfvzccCuQY3XjVtz7jCXViDDBb1vrPa2K8Y
         +EcJXvaxSF6pM2Uk9/oetGyr/zPuk4PGPok/1+mdFuioVNYGLnilS9zjbbOY1YFcZHCB
         B15hP2Ev/V3gsUF7j4dhNYeKiiKrTNge27kTORfRqqI7x30iJgnGqpsogtpL9MH66rbC
         tBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708329428; x=1708934228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oey3ZN4EIWUJzNAo3Boteeg+KwnzJ3oRelbiZ+NcSGs=;
        b=LrEna8nnbCIHzMezpcznPojV4nAOBY3KsfVQ69DX26b0y77ifNrvBpcal0k2fcQ+fJ
         y/VuztKKyL4TVNEZmtO9XhG6NsyWKHmclBgV2QdHge5iyEUt7T5iYH9qJ/JXg8d/rtkg
         LR6AQnLtJT+2CKCHta7A3R+TSTN1YgWk3OjrOdZineQnbmxMeCxQqP+4Jaftr7sAk73h
         XuhfOZOXHM2/dAJUSGubXfpisYwk+mBgiBfZUtEE/jpkHeVqWXWZVKS3qGQnyOWUBZkm
         AQaSP0Lt65WScIRViSQ9XKljMcpMknNQBUGS9b9MsIEQyw70NWXBUlwQOYbDWOFVuv7C
         YZKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeXOnXWao/DXdKr6//9g0uIxMnjjUXuXTeAIFEtT8lUycE8v1kuqzz7hnYAoxcojqscC+aemh1N9IUyNjr9JuFimq9e8CazfxG
X-Gm-Message-State: AOJu0YxBB7m7ysHXvL82Yk0BG68RWuAZ7XNc6otLwbWc9RycVMa3ywAV
	jURO7l6Z+/pxjIaVd7ZEXhA+sjBpRxRAy3pAvNKiH0JY0HWAlAoz97sPiL3MvH6+B/vfarYv8IU
	5CnM18Eqm8OLjrXVSyiTLHDpqU0CLdWGK2OuUJA==
X-Google-Smtp-Source: AGHT+IGkQijUvXHSNfPb2HxhHlZq4HKDdG92W7zvsTAzBpVd1PSmvpJBFeiTOYN7sqVAKs/Q5f+Y2wj1Qp78qPvhlpQ=
X-Received: by 2002:a05:6102:409:b0:470:4cfa:c814 with SMTP id
 d9-20020a056102040900b004704cfac814mr2022895vsq.24.1708329428140; Sun, 18 Feb
 2024 23:57:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216203215.40870-1-brgl@bgdev.pl> <20240216203215.40870-3-brgl@bgdev.pl>
 <71e9a57e-8be3-4213-9822-45dfc5eb7ceb@linaro.org>
In-Reply-To: <71e9a57e-8be3-4213-9822-45dfc5eb7ceb@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 19 Feb 2024 08:56:57 +0100
Message-ID: <CAMRc=Md1PzoZFDWHWRufktmMiBE0Dp7eYhecpwuaS3AW-Y_g=w@mail.gmail.com>
Subject: Re: [PATCH v5 02/18] arm64: defconfig: enable ath12k as a module
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kalle Valo <kvalo@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Saravana Kannan <saravanak@google.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 8:31=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 16/02/2024 21:31, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Build the ath12k driver as a module for arm64 default config.
>
> This we see from the diff. Please tell us "why", e.g. "Board foo with
> Qualcomm baz uses it."
>
> Also this should not be in these series. It only makes the
> power-sequencing patchset bigger, without any real reason.
>
>
> Best regards,
> Krzysztof
>

Got it, I will resend it separately.

Bart

