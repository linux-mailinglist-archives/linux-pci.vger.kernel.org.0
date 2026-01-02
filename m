Return-Path: <linux-pci+bounces-43940-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C3ACEEB48
	for <lists+linux-pci@lfdr.de>; Fri, 02 Jan 2026 14:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78A203007236
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jan 2026 13:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADDD312814;
	Fri,  2 Jan 2026 13:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdzZRQ+/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A783115AF
	for <linux-pci@vger.kernel.org>; Fri,  2 Jan 2026 13:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767362203; cv=none; b=FlEbdmrp+sPAxNuyzLILgtv33KQVlBGxE+9VgJEJig2aeTFhQaYy9SNEo2lu/YFYHvZISusyx+l1xjXgxmFx1gaAHPURmsMcYLVh8kTP098zxKIbLdL0SqW4AZR+alx6uFOZQhUE1lbF7QoXsO25NAfaOy+gX8mb5+9+qUB0SLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767362203; c=relaxed/simple;
	bh=6nmAtUvDXlpIMStP0lxWmzvUn//2B4cLH2obY3jV+Fw=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bf/lxBbip265j0cTaLicTaSLyRATBdv4fknhFD9CnshsmhBTlvagdVbas12bMBE9iOvb3/d7wLW7QTQy/YQM7rlRWPb5uY+qybr5kF9QpkjVC/v63wAOjtm2/j2TefZJ8n9d7zzyrEAdiSu4EbmCYQvsP3hOxmyhk//ZdCarEIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdzZRQ+/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3077BC19423
	for <linux-pci@vger.kernel.org>; Fri,  2 Jan 2026 13:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767362203;
	bh=6nmAtUvDXlpIMStP0lxWmzvUn//2B4cLH2obY3jV+Fw=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=UdzZRQ+/9dgXZUFsLx+lPFgcmWHhJncLYWeLX6o7RZJOAFPIeuTrO9wWenJlYs51i
	 MSnQTeY2gbt6M9p6EIBZQU5mQgu1LrWdoPq8Hqy1P/iLSYSFT5wozEToptaCthjZ/b
	 pMZTv2SDDFNp63ynBJL/0yjqe1Kp5A3h7k+izdol7wSZvvi1B7NQFAu+sF9CTkE5N6
	 qQndCPYDGRN5wT7pH2WGS+t4QlR01EHx3FD5T2JXOONR5FbxBhMQZfU6muqYxgbuXC
	 YRFhLwrip+oLmuDYqwnTn2OFsXKP14Z5MqkA6i2MuuF0I+9E4JELXebTSUIhE5ZdmB
	 1E3PPjRCauHqw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-598f8136a24so13484414e87.3
        for <linux-pci@vger.kernel.org>; Fri, 02 Jan 2026 05:56:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWZ1m2I4Z9DKM1cX283Bnq6HorULSn3RIPnzme2TbJyaxklquARp3e04TtJgYye1vQhLXPPBybYxvc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2RmxynbJ8jaB8eWyhHVfre1PimhnS1ldsYIyIgMYawTT7Lkp9
	GfxZyZq5MomxRWrmaK/yafZvb6wx3wJAt3dGj+G99m/5yRzI9xl9jcESpblmWc+kpdmdY3xtKqr
	SSJolz9gLZZ5kFVNRZl13zQzKpxnPfmkHAuptG1OUPA==
X-Google-Smtp-Source: AGHT+IHbJRT10iJ8Ak+Wsm5BDh3uPRRFKk/XUyc+k0NxlTKK8UAxgyBEh4tlC6adoDsL634lGOLqtu+nPTma7wF292Q=
X-Received: by 2002:a05:6512:104f:b0:59a:1240:dec3 with SMTP id
 2adb3069b0e04-59a17de0950mr14250256e87.52.1767362201812; Fri, 02 Jan 2026
 05:56:41 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 2 Jan 2026 13:56:40 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 2 Jan 2026 13:56:40 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20251229-pci-pwrctrl-rework-v3-5-c7d5918cd0db@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229-pci-pwrctrl-rework-v3-0-c7d5918cd0db@oss.qualcomm.com> <20251229-pci-pwrctrl-rework-v3-5-c7d5918cd0db@oss.qualcomm.com>
Date: Fri, 2 Jan 2026 13:56:40 +0000
X-Gmail-Original-Message-ID: <CAMRc=McHOJ0FZTtvQeVqzqfd39eMP6z65ds3AAg2Ewb=Wn+zRQ@mail.gmail.com>
X-Gm-Features: AQt7F2pfT0VNDkPFZ7iI3z9WUnQNhfb4QdUHgY0JAHU__nJMn_kAvn44n1p_q3o
Message-ID: <CAMRc=McHOJ0FZTtvQeVqzqfd39eMP6z65ds3AAg2Ewb=Wn+zRQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] PCI/pwrctrl: Switch to the new pwrctrl APIs
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>, 
	Brian Norris <briannorris@chromium.org>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Niklas Cassel <cassel@kernel.org>, 
	Alex Elder <elder@riscstar.com>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Chen-Yu Tsai <wenst@chromium.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Dec 2025 18:26:56 +0100, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> Adopt the recently introduced pwrctrl APIs to create, power on, destroy,
> and power off pwrctrl devices. In qcom_pcie_host_init(), call
> pci_pwrctrl_create_devices() to create devices, then
> pci_pwrctrl_power_on_devices() to power them on, both after controller
> resource initialization. Once successful, deassert PERST# for all devices.
>
> In qcom_pcie_host_deinit(), call pci_pwrctrl_power_off_devices() after
> asserting PERST#. Note that pci_pwrctrl_destroy_devices() is not called
> here, as deinit is only invoked during system suspend where device
> destruction is unnecessary. If the driver becomes removable in future,
> pci_pwrctrl_destroy_devices() should be called in the remove() handler.
>
> At last, remove the old pwrctrl framework code from the PCI core (including
> devlinks) as the new APIs are now the sole consumer of pwrctrl
> functionality. And also do not power on the pwrctrl drivers during probe()
> as this is now handled by the APIs.
>
> Co-developed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

