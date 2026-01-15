Return-Path: <linux-pci+bounces-44954-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D32D24F2A
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 15:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FE363013EFC
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 14:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE3D3A1E6D;
	Thu, 15 Jan 2026 14:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6JLwjQ5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBAE350299
	for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2026 14:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768487344; cv=none; b=RUXzeLpZBAaEfZMMXRNk5JNtOK2a0CuGKSdCf9J0SKiDXM23fPt/mtNW5I6rT6Elulso4FpUm+SuvM/iw4GRVG3MB3OJLj6NmfU4Ez9Uff6Uv8heYiwofCGDcINturNrouo+f+9VBkkQR9mJz9Fq87pGPl/CjT+0q6YZc4Exzz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768487344; c=relaxed/simple;
	bh=f7g2xb8a7bQ7d5++spiGugEdEC0YCIciYuW0HVyY+MA=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KNmBKwSEF2tF31DZ1gPl7kYbpP01SZS+HyMCIctwUu/eKQfuUGPu1Nd6M+Gsi79WXtDG4hRfglLFjUFIHlhyDX0VMwSvOlSIcufA/0TIlJ7O9n7mb+OJsaqXI3cAx9wpDUndIscXMFSdsR9WgYDqr5leNouXyuusf1KVhHH7U/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6JLwjQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B529C2BCB0
	for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2026 14:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768487344;
	bh=f7g2xb8a7bQ7d5++spiGugEdEC0YCIciYuW0HVyY+MA=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=Z6JLwjQ504l/8JKq7VjJn9GcS7wSR1nhk8gEhQZRwygyyoUNcMAV6N0La5zufZY4A
	 QgFBejW1Rp0XIf2EX+tteChexPBc5en3mhfV/l3okluZFrPvTVyhbX3VwA0nfDRYGe
	 hjJzyUH+7lMQwoTJiRYZtwYs5VhmZU/GnxJqQFmtFdf1Je01TGZ4l2mFU/gjwmW/Ks
	 Ux/Vee/Op0RrpWuXLUQ5S+1DZrYEPE5KdQzna+LfCmhCHlYUOF6JyCh0d1C9fZ9Y/1
	 ujt9SvkBRooR9sPAN2cmbNVJp72nf9cmrljs+RPiVrfIHjI+kgnFo4vM9gdOLQ92Np
	 4L8PyXBjpylZA==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-382fb2bb83dso5566991fa.1
        for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2026 06:29:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWk/PMF4c0dUpOhfwZFAV2mTIn+mPmhObQ2e6e74GEuFJU/6sD5Ri3EncIdaLhIUheA8xmU98D9aPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeODFNBaOsHvrWArek/wAxILs/d0FpzGAQRfN20z8e+WnF8KRq
	kkMdTbWFUt5/LdWQiSK4RsXwbE3+K1HkzcE94GPMQQJFLk5JTtZf52QkJY6pmKrvPCA24SMeeql
	h9ejVF5WrV3p7CYgVCdD/kjYJnTekKzVgIrhB0U9EFg==
X-Received: by 2002:a2e:a588:0:b0:383:18fb:fdee with SMTP id
 38308e7fff4ca-383607e30fbmr20861351fa.44.1768487342670; Thu, 15 Jan 2026
 06:29:02 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 09:29:01 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 09:29:01 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260115-pci-pwrctrl-rework-v5-13-9d26da3ce903@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115-pci-pwrctrl-rework-v5-0-9d26da3ce903@oss.qualcomm.com> <20260115-pci-pwrctrl-rework-v5-13-9d26da3ce903@oss.qualcomm.com>
Date: Thu, 15 Jan 2026 09:29:01 -0500
X-Gmail-Original-Message-ID: <CAMRc=McOaOHAa7_A5YLdoRaRpF+mDgybt-4OTHGBBF462NebkA@mail.gmail.com>
X-Gm-Features: AZwV_QhEH4-ZyPjnWZSZ9c8qpypyVCvzSSIk21VemLSqVCRsWi0CbODFZNlPwQg
Message-ID: <CAMRc=McOaOHAa7_A5YLdoRaRpF+mDgybt-4OTHGBBF462NebkA@mail.gmail.com>
Subject: Re: [PATCH v5 13/15] PCI: qcom: Drop the assert_perst() callbacks
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>, 
	Brian Norris <briannorris@chromium.org>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Niklas Cassel <cassel@kernel.org>, 
	Alex Elder <elder@riscstar.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Bartosz Golaszewski <brgl@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Jan 2026 08:29:05 +0100, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> Previously, the pcie-qcom driver probed first, deasserted PERST#, enabled
> link training and scanned the bus. By the time the pwrctrl driver probe got
> called, link training was already enabled by the controller driver.
>
> Thus the pwrctrl drivers had to call the .assert_perst() callback, to
> assert PERST#, power on the needed resources, and then call the
> .assert_perst() callback to deassert PERST#.
>
> Now since all pwrctrl drivers and this controller driver have been
> converted to the new pwrctrl design where the pwrctrl drivers will first
> power on the devices before this driver deasserts PERST# and scan the bus.
> So there is no longer a need for .assert_perst() callback in this driver
> and in DWC core driver. Hence, drop them.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

