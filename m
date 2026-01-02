Return-Path: <linux-pci+bounces-43942-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 159DACEEB63
	for <lists+linux-pci@lfdr.de>; Fri, 02 Jan 2026 14:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 165FF3007C9C
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jan 2026 13:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EAE312819;
	Fri,  2 Jan 2026 13:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l14sNxua"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2490831280A
	for <linux-pci@vger.kernel.org>; Fri,  2 Jan 2026 13:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767362334; cv=none; b=KC9j5q+kiuDR+yfHMIYk7001f6cPL6uMIweZeF4fxx81lGBvcbflCIonHeXH32L++O/ECAKQLCQ8NobyA2NhEzm0PG9mZfLc7/FAQtlZuU4H4gKqTJ5R9VX62XsZ8Tz9ugRWQLHePzO3IdDAQ8SX3OEEm8djj9aT4tMuFLbE+VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767362334; c=relaxed/simple;
	bh=wvqmsm8pwa3AcXMU+cWN4gAqApP3IKcmeV46IKeFCAQ=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=myI2eIVS7oKGsHsCk6avRL6UmvDJ0mIVAFeXObFgT6hVvW16vqyGzdES+M0HUUN9ysaZtvr3UKNBSHmV/BqmsGW35mJm72XHHCVxK6fl7ueIBUmCeocac6+Niap1tBCI6UnhApP6iqU+ZXZuzyDhK5Xmtp33u+Seo5ZcO6iToq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l14sNxua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC584C116B1
	for <linux-pci@vger.kernel.org>; Fri,  2 Jan 2026 13:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767362333;
	bh=wvqmsm8pwa3AcXMU+cWN4gAqApP3IKcmeV46IKeFCAQ=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=l14sNxuaJO8/XmzNJV8iYPdNofMkI01PUZtaLkV/KYhRHfJfjOr8MzdSedZtqo/jz
	 FXsr5NQUrd6K2Q90z4Yrre0ZNby3ol4QZXcVB30i9cUIehw6v23lHkyqn7crstQwp8
	 rHHoLIyAfZ/znpLwKm72Q5XmH9z6NaY2kHEfjyv2G/0D9pIpADNGTPTFMEiouzONnX
	 jZkZH5KtFR1T9kFg6reRC3R5zYI2kjHbO0iXFTOzvzhXivQ4z+6EiG6K/0iy0gu5vn
	 /xGJH7+a/v5bXPkpe+NCJSzYRZfvp4iKs3Qp6j4AVRK08Zx3S3fST2l4TwjxZbtfEP
	 uZtGcQBg+xFaQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5959187c5a9so10417339e87.1
        for <linux-pci@vger.kernel.org>; Fri, 02 Jan 2026 05:58:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVsfmudVkZSXafcFVdJZgC271C8WwGupjDqN59hNNBrvMMvAKM0v4506/ombO06Dre0RcV7Fd+vw2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdHZlBBIGEky5VQu7sztaxjJDs+ww5IugaHEhiqDnzxrSuhNaX
	MfF/3I4aakvyDQbpZfe9xyFZaUeavYDy/wc6SHvh1hOw+fBNlNRdMVPcKGeLAFeRH27ObqvqNWK
	LESTmvJp+BklpO1uSuYOeRyRmGJ6kymg9Uwk8UHGhgg==
X-Google-Smtp-Source: AGHT+IEvS+aGJMddAA3oPXNEoUA6VHabHEFpBL+2G2ttizxV6sDCdsjpLtEqPjr+jFaLnQ0sgFn7F9Q9vSSkaOKIsEI=
X-Received: by 2002:a05:6512:3e05:b0:598:eb05:c5af with SMTP id
 2adb3069b0e04-59a17d595f1mr14405321e87.15.1767362332504; Fri, 02 Jan 2026
 05:58:52 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 2 Jan 2026 08:58:51 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 2 Jan 2026 08:58:51 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20251229-pci-pwrctrl-rework-v3-7-c7d5918cd0db@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229-pci-pwrctrl-rework-v3-0-c7d5918cd0db@oss.qualcomm.com> <20251229-pci-pwrctrl-rework-v3-7-c7d5918cd0db@oss.qualcomm.com>
Date: Fri, 2 Jan 2026 08:58:51 -0500
X-Gmail-Original-Message-ID: <CAMRc=MdAs_r6YaOoSEE_tS=FLU-wJud=W_DkyZ=uKYEi=T6WWQ@mail.gmail.com>
X-Gm-Features: AQt7F2pO-62B4zO-Wlx0FLP2VFFgiND1pcHAWAUPTvETnJo82ZxurbYa1GW3r60
Message-ID: <CAMRc=MdAs_r6YaOoSEE_tS=FLU-wJud=W_DkyZ=uKYEi=T6WWQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] PCI: qcom: Rename PERST# assert/deassert helpers
 for uniformity
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>, 
	Brian Norris <briannorris@chromium.org>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Niklas Cassel <cassel@kernel.org>, 
	Alex Elder <elder@riscstar.com>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Dec 2025 18:26:58 +0100, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> Rename the PERST# assert/deassert helpers from
> qcom_ep_reset_{assert/deassert}() to qcom_pcie_perst_{assert/deassert}() to
> maintain uniformity.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

