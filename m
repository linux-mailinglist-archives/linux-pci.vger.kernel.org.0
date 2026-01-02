Return-Path: <linux-pci+bounces-43925-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 757A9CEE1B1
	for <lists+linux-pci@lfdr.de>; Fri, 02 Jan 2026 10:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F32213005FD0
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jan 2026 09:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128EA2D6630;
	Fri,  2 Jan 2026 09:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6JVKA9i"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF17C4C97
	for <linux-pci@vger.kernel.org>; Fri,  2 Jan 2026 09:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767347585; cv=none; b=slheYc0MwtgzGdWv5Ib762IioKWlpzyx3aXdTY8C771FXD9SCuTWHI7XSQZOnDF1jLTL4AFiBB7sjg+MbMNUzbv83/vIw/4R8ZEJmCdOXo2+h/lYBXuj68/CC74r64pG0CIvyLMZC64JAQ2K32J/V6XadjqZPxNz2oL4/gy39uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767347585; c=relaxed/simple;
	bh=RABTphJbjveLyb+ZVfbZhXGTF+2TZRO1eYngRdD2ACU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NMsPTMV25xXUyVloKXL+K1DgExDMaRl8VKoBuzfQC9c3HXieETrL9OJ/y5e+Jq+vQr8lBQ3+wyUjlgNQTOLLo7rdlw485cQW+0ly7DNhsXCZ5d4X4Q2tyCiW1vDB++4bceiVj6Sy/qrHbdLhCldxVkIpEmRfAsPp0dPip1YohwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6JVKA9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59345C16AAE
	for <linux-pci@vger.kernel.org>; Fri,  2 Jan 2026 09:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767347584;
	bh=RABTphJbjveLyb+ZVfbZhXGTF+2TZRO1eYngRdD2ACU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b6JVKA9iBHqMJ2WEl/TJWYBUGGPQG6CxgRpKvjEQA54ozS/+drXSYxg5qcJGt66pl
	 S8HEWS2B2ItLgOBw5Ev15Iw0zR4xpBt2WcODMA/TB6hbCFIsYG9aKu/0fqDRbm9tYg
	 BnHl5VWG6ejaJEcJmwJDNX9EWDQjJ2qAF2IPvxZIOld6oS3YTpdi4AWyDtlPow45Rl
	 fAJFQrcdE58Ox5m/4IGgyr718uqt9yfIcQUAWpGsl3t4s5oVwFGcPfK2wxWWlCD3hB
	 ayPw7b2YeUM89z2DZy9/h/T+l4b2FzZimXdFJEs6xVsnqbChJaFLfv78LMSqiFm89p
	 3lIUatnr1ah8A==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-597d57d8bb3so9819167e87.3
        for <linux-pci@vger.kernel.org>; Fri, 02 Jan 2026 01:53:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXJWF/K0ZSifGyTVrSacyCdxEutAOCmDb+rK5ldx7ZstOn8s10sc9pbFNmFE2aiRGBFMTkkyMcLFDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf1oryeHkhkV7ZUgXzBkuGl63fIxWkcZ9JuwwB8KxzmUtPUfDD
	tjMGA69RknPEqAUkpV38/SHhZ6/+R3tKFTmEzfFV3+ZCl0NfaoopEc67dpvpU1XHp9LQw778mzQ
	oXaRinztcLUYeTuTkrzC1R7qPWzyZl83ZNHPij2U3Xg==
X-Google-Smtp-Source: AGHT+IGbECLOdZOOC0s2WEHaaJW0az647jTqeIVtGicekW9VDB0ZTWEU8u1EUtypGYoR7HcDicw4i/ecZGCd4Ioj9Bw=
X-Received: by 2002:a05:6512:3c9a:b0:599:eee:8f63 with SMTP id
 2adb3069b0e04-59a17d093f1mr13859081e87.14.1767347582990; Fri, 02 Jan 2026
 01:53:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <39e025bd-50f4-407d-8fd4-e254dbed46b2@linux.dev> <20251219172222.2808195-1-sean.anderson@linux.dev>
In-Reply-To: <20251219172222.2808195-1-sean.anderson@linux.dev>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 2 Jan 2026 10:52:51 +0100
X-Gmail-Original-Message-ID: <CAMRc=MdpJqfNzwp4aOSDJAaLmwBPJ6FfNN1pNzeZaXCtyry9mg@mail.gmail.com>
X-Gm-Features: AQt7F2p2XsoJwFkhUajo7FMNK25yZHddCe-8r-tvrHRa1sDCy05D5PEngPIpFjo
Message-ID: <CAMRc=MdpJqfNzwp4aOSDJAaLmwBPJ6FfNN1pNzeZaXCtyry9mg@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI/pwrctrl: Bind a pwrctrl device if clocks are present
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	Chen-Yu Tsai <wenst@chromium.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Brian Norris <briannorris@chromium.org>, Niklas Cassel <cassel@kernel.org>, 
	Chen-Yu Tsai <wens@kernel.org>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Alex Elder <elder@riscstar.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 6:23=E2=80=AFPM Sean Anderson <sean.anderson@linux.=
dev> wrote:
>
> Since commit 66db1d3cbdb0 ("PCI/pwrctrl: Add optional slot clock for PCI
> slots"), power supplies are not the only resource PCI slots may create.
> Also create a pwrctrl device if there are any clocks.
>
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

