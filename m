Return-Path: <linux-pci+bounces-44952-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7D6D24F0B
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 15:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78707302BB9C
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 14:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CC93A1E84;
	Thu, 15 Jan 2026 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wg0iaeUN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C9D3358D0
	for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2026 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768487234; cv=none; b=cT/rVTg6tB0711BgJ8wdnFdSO2yHzCmCsFj54nMsEKSjAbLqH5WN0KRrojpAhhxX9sBNVgKdgf8iv+VRMyya+d/6uOb34XV8r2l2Ygok/Qo6Xe6zdvdVNnuF3Z7zxBy1wg48JhcW1eQ80xNZD/vMuitlpiQMk585H9zEMMq+UCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768487234; c=relaxed/simple;
	bh=hr7QNTjbJ7IbVKrfC2Q1lmNet+E6QNkqp3bI2b51nxM=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NrxiItYirwQjxvWPa+YvCa/sD6p34YN8uyH0WJ/9w9Lkj8a9npyRxFsP3DS1/Q8X3jlbhNGkMgjOYARcWPITrlYV7nPPbfBGUmgv0yBiiuhhCnKf74bqkR3r0enPMkfk/g7RoKtbMLiZsOKBE+MhRw3kKZZwZ2KX93txNQxpGkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wg0iaeUN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D644C2BCB2
	for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2026 14:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768487234;
	bh=hr7QNTjbJ7IbVKrfC2Q1lmNet+E6QNkqp3bI2b51nxM=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=Wg0iaeUN2iHWt+UmorAVHcubVFP32WU6cL63TZaGyie4dG/miqnpmRq0mLXqn4EiA
	 HhxYAb+ry+AdMEc6E2gr4cCjt9QSg5HV9NG1WGyS/YNsEjTiASzJKVP9Hn4Il7ySam
	 Z8upC96MXl/5X4vIaGUIsR9rKUAXptF5trinHPbfzimu50cusdbwXMbjaGLlsDTOZk
	 yVJ0eH5xt2R7DxQYEVeKCJooesfxHLIYvLjgp+Q6GqAiya4RCqjO0n0zgE9Wz/QNCH
	 4zaeulknxjQJL3NGt+0m94AvMlNLqXXKA7iF7M43auF4Osmr88ByfNT+io05wOr1nH
	 Xc2Q74Crs09lw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59b79451206so927713e87.1
        for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2026 06:27:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXdJC9KBaGQq8AgcCtIInfK7b5f9Drfjus98h9g2vo+BTPF9FK+hQMSX0N+TBU/AhnbHX9Ttg5nY9M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/rqWJzVIhbqt1qO73RWijOrxuBfYxBqNYjKH9r26z/wNiPsCo
	9RBwvDz7G2xFvPxbLZMH/Glj9Uo22E4phqHz+SePBA2GqhxaIOJBFbEGdV2+78u/te/5F7fe54o
	cHk2//NPzypUumUH1UYPRhohZ96HeHWxpKARWFKcY/g==
X-Received: by 2002:a05:6512:3ba7:b0:59b:9a8d:22c4 with SMTP id
 2adb3069b0e04-59ba0f67f24mr2512539e87.17.1768487232989; Thu, 15 Jan 2026
 06:27:12 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 06:27:11 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 06:27:10 -0800
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260115-pci-pwrctrl-rework-v5-7-9d26da3ce903@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115-pci-pwrctrl-rework-v5-0-9d26da3ce903@oss.qualcomm.com> <20260115-pci-pwrctrl-rework-v5-7-9d26da3ce903@oss.qualcomm.com>
Date: Thu, 15 Jan 2026 06:27:10 -0800
X-Gmail-Original-Message-ID: <CAMRc=MeiDkSwQPdKAPjJBx3MyCG980DJGoCeETN8MKDUA74bkA@mail.gmail.com>
X-Gm-Features: AZwV_Qjs8n5as3g8jqWfcfoxBixbtPzlztd6e03QEebheSDt3AZ6aro7l-YP_Ks
Message-ID: <CAMRc=MeiDkSwQPdKAPjJBx3MyCG980DJGoCeETN8MKDUA74bkA@mail.gmail.com>
Subject: Re: [PATCH v5 07/15] PCI/pwrctrl: slot: Factor out power on/off code
 to helpers
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

On Thu, 15 Jan 2026 08:28:59 +0100, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> In order to allow the pwrctrl core to control the power on/off logic of the
> pwrctrl slot driver, move the power on/off code to
> pci_pwrctrl_slot_power_{off/on} helper functions.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

