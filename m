Return-Path: <linux-pci+bounces-43938-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B134CEEB06
	for <lists+linux-pci@lfdr.de>; Fri, 02 Jan 2026 14:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4987130076BB
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jan 2026 13:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C152D8393;
	Fri,  2 Jan 2026 13:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOmDCOES"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02608634C
	for <linux-pci@vger.kernel.org>; Fri,  2 Jan 2026 13:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767361346; cv=none; b=uGdy5uqmBlSlQjZI+J/5wgjDjjcE3hdUAIqv0Odm5gZO5Ufuj6+KBXayqi/nPjuF+83plzjQee2gTTUk5xiCJSDmSU4wxl++FkjN/bgAU19MTxFg7p6fGfivGfE3nXJT2qbVkcojYh8ZUrankKfLGoOn3l50etHTYIc9VSHuHS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767361346; c=relaxed/simple;
	bh=QiDbzp86OV3z2nQyUC9ZSUVCTpZMqOOFmDhGBEdF0rM=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OaMJX3eIjXpR/O9zWmZ1em0BhjPtHvsA3Y4HvmLwGEzf5x6QQySBvxN2vkIZDwrfaQDWMnjOrDuC9GS1503Du15aal9yiEtCTRVI8HMxpMhs/d6SKHcfE/bkpwOSudo2+aneWfOoDAlcsCMgT+xxbu7IaZki4xzn8FnarTApwkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOmDCOES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80177C2BCB0
	for <linux-pci@vger.kernel.org>; Fri,  2 Jan 2026 13:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767361345;
	bh=QiDbzp86OV3z2nQyUC9ZSUVCTpZMqOOFmDhGBEdF0rM=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=MOmDCOESvgZvn+ifjH+LGySpJaAPb9+QWHap++YPOs1gQi2ZjLeI4I8lMT5saspH8
	 SBwcqAbSLudXngqOa2Bl7RZ37i30afoBv16DZgIVd2T4g6v0ajU/q4M8K3dJnpz8Hv
	 587bI7dRAs/3JfgyDVRJXfIJ+A5WjaW06kAHep9D9qIpUnAjdW11ZdO9q8ZuHI5RMa
	 6cx3jOilS0TEq+W1dcMPWrIF+q4d6Vr2sCYxQDWVA+rDWmjOBjCRjQ1JX0RtNIPS1+
	 cLXkV3AAxVBtwHVzyOxWUy6/+ASNUQlphHBSVVe6J7Aq5jK4t2jkNmWQrezcUpkm9f
	 kKol0luXprRMw==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-594330147efso14143953e87.2
        for <linux-pci@vger.kernel.org>; Fri, 02 Jan 2026 05:42:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXQHuB1UAL40PlV3NxGUJsHU57e2DmDPPRhKdIO9SWkKSmk9vpgCQtDStriSNwa4hvEHTgCPD+1X28=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb9IyLDPMn28poknCY0bW13tdUmOwQHwxRwi+oipIPXfPh2s3O
	oDhawUzBL5HkzBp3LJ3OLktO8s8IcCVV0UxVv2plxlfP/F+/aXzAXJhGPctxVfitRUC3d5fdrmm
	qWUUTQtf1yA5tuqaYIWMKRnFPgbu+w05/Na6bTgecig==
X-Google-Smtp-Source: AGHT+IGIcl+tQnzZyIQ2EQINe1SwzJ0awYFUootTV9cZBCixeoA2aPtRm1nCrUjFdIlmzOh7EKI+cIsHpsAnfU2vxGo=
X-Received: by 2002:a05:651c:211f:b0:380:c72:d495 with SMTP id
 38308e7fff4ca-381216e11c8mr144853711fa.32.1767361344053; Fri, 02 Jan 2026
 05:42:24 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 2 Jan 2026 13:42:23 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 2 Jan 2026 13:42:22 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20251229-pci-pwrctrl-rework-v3-1-c7d5918cd0db@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229-pci-pwrctrl-rework-v3-0-c7d5918cd0db@oss.qualcomm.com> <20251229-pci-pwrctrl-rework-v3-1-c7d5918cd0db@oss.qualcomm.com>
Date: Fri, 2 Jan 2026 13:42:22 +0000
X-Gmail-Original-Message-ID: <CAMRc=Me0P=k+_x34eioKHhjdKApAqJ_5BD_gaEMAzF=Nundg7A@mail.gmail.com>
X-Gm-Features: AQt7F2pMTDzs-dKRByK2NKQ68tOfmNo9Q8YeKt5yT69D7P1BrThAh4OfifpsU2M
Message-ID: <CAMRc=Me0P=k+_x34eioKHhjdKApAqJ_5BD_gaEMAzF=Nundg7A@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] PCI/pwrctrl: tc9563: Use put_device() instead of i2c_put_adapter()
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

On Mon, 29 Dec 2025 18:26:52 +0100, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> The API comment for of_find_i2c_adapter_by_node() recommends using
> put_device() to drop the reference count of I2C adapter instead of using
> i2c_put_adapter(). So replace i2c_put_adapter() with put_device().
>
> Fixes: 4c9c7be47310 ("PCI: pwrctrl: Add power control driver for TC9563")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Huh, these are indeed confusing APIs, the find vs get variants.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

