Return-Path: <linux-pci+bounces-44953-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 68673D24F3E
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 15:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D81F430996EA
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 14:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8913A35C8;
	Thu, 15 Jan 2026 14:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9z1KC8j"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5C93A35C7
	for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2026 14:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768487258; cv=none; b=Tk13ruBM/7/R7LxQtfPBewSEqc5uAOoJgYgduvT97AOOk/lAaUEPraJGRrEUlAdAfhCHuF8ulYM6tQcK0mLQ2m16eutyjbLFTppe+4UsJ+TTNlRNvcqofd+K9iqLA1bFCbj/U8gksHvhIeiYneFbUGvTG6bpnp2oec4zUt48SOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768487258; c=relaxed/simple;
	bh=jvPb3lrGzvQY4eXmn3nFfcrCHXN1JWep9zU2aZLbhWI=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o7CdBcRY2viwxpdnSz+QfJ83R5b3H8GmPbeZxWIh066mA9qbgT7vp6+bomZuhYHGgeLgzsvy1rNGCDM/pM4c3rxw//uM50kVp06JmcGF6TT4gOQWVkxIQ3eP2YJKILY2K3JHTdd0fvv4coRdbZSMacKpsBoFtiCjr1/YLC8AFpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9z1KC8j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B829CC2BCB0
	for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2026 14:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768487255;
	bh=jvPb3lrGzvQY4eXmn3nFfcrCHXN1JWep9zU2aZLbhWI=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=k9z1KC8jMi/9MUCq142fQyP/tcGcUo3N7oGTRcBnIwvUCKw7Or4Q8yGZZ2hB3eyAX
	 jaW+x0k0lqQGC2uC7LL7cP61XNAi9151Hgv6d+lQqlF/HantMAKsz+mWNbhupvUR43
	 Kb+Xo8iDZ4kRdI+8ZHASuBMnzm12csKj7h5SG+HSrUD9ZQ2WvBlu9dGaxcn0wRfToU
	 RnLKdMOfebvg5FkqklVJRu2yTvPxR91I3uIGVnJL956bPOHE1rzRwydGspc30L73Yt
	 lFmNMXgpRckKzYka289y+67qnz2Vvr2NDRi+4bv45PmeS25X8WfkP/IdJ3fZw8TwdH
	 KZP3zrlFEhCUw==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59b7882e605so1363448e87.0
        for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2026 06:27:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUESaCWj2OqAP7IXcMu585vhypzvEaE84em2B4do3IIscifjHsiJCwjLC0Xc5twps/KtSGjZG9MezM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQl6/3Snr8JJzptGhKmjXefm+LDaQD8Vy5Fy4Z/aKX/3VC5tp5
	O1ELhFXRzpOfT7cSBo/otLLRXmSU8r+sPdizOZDNgqssEhNXNshUnzMn1vWc9StBThGd5HsOQeE
	nFzfHN087oBbrHRm29UFc+PZciSVvdoe0F9L1bO9yEw==
X-Received: by 2002:a05:6512:23a5:b0:59b:811f:cfb1 with SMTP id
 2adb3069b0e04-59ba0f81f8bmr2290889e87.34.1768487254417; Thu, 15 Jan 2026
 06:27:34 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 09:27:32 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 09:27:32 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260115-pci-pwrctrl-rework-v5-8-9d26da3ce903@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115-pci-pwrctrl-rework-v5-0-9d26da3ce903@oss.qualcomm.com> <20260115-pci-pwrctrl-rework-v5-8-9d26da3ce903@oss.qualcomm.com>
Date: Thu, 15 Jan 2026 09:27:32 -0500
X-Gmail-Original-Message-ID: <CAMRc=Mf8okkzRAAW2m4XnGQxzTE0tJT1kmg9AvPp-4LpEXL6hA@mail.gmail.com>
X-Gm-Features: AZwV_Qj2AXUr43FE6yjbGbv7tF91o4DACTtZ4l_6-QI5wb48h1KQ3mkWwIA-Fzk
Message-ID: <CAMRc=Mf8okkzRAAW2m4XnGQxzTE0tJT1kmg9AvPp-4LpEXL6hA@mail.gmail.com>
Subject: Re: [PATCH v5 08/15] PCI/pwrctrl: pwrseq: Factor out power on/off
 code to helpers
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

On Thu, 15 Jan 2026 08:29:00 +0100, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> In order to allow the pwrctrl core to control the power on/off logic of the
> pwrctrl pwrseq driver, move the power on/off code to
> pci_pwrctrl_pwrseq_power_{off/on} helper functions.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

