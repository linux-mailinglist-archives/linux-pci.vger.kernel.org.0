Return-Path: <linux-pci+bounces-44946-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB03D24EB7
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 15:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE2363008E15
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 14:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A763A1E67;
	Thu, 15 Jan 2026 14:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gi7+W0Kp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853343A1CE5
	for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2026 14:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768487036; cv=none; b=X7BQwxNByIamr7TUXEkuRbFvGjYJOZk/L0ov7cOU9iTnIS8haCDgX1vLHwTu7VhTTpSpYKbJxm+K/q7oMT2EBzYEAbV75+8B3l+L1DQzyOwe29L6csZNSIPrx0g5rA03P3NobtpuomuOBWDHbHbz9CwVB9e1sWqkMnAsaTMDKZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768487036; c=relaxed/simple;
	bh=7BQtydNjSN5/eq8tWt+2dOhYGz0PlAjtHidfuvX/tts=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S2mXjxD78iDbrbMFbgp9FvUKKd5SHsYFK61s+BrHIuNz1GfE2O7iDyX3MDZdFYvqsPve60zVad0DFmB5xigYWIonLaVoyYQnx/F5xol73UHKnvt+mW9gW5pLgW/ovfqhx33cGOJPqigDlJ00VEUoYGxXgHhOH0N/qV0Xnzlezz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gi7+W0Kp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD64C2BCB1
	for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2026 14:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768487036;
	bh=7BQtydNjSN5/eq8tWt+2dOhYGz0PlAjtHidfuvX/tts=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=gi7+W0KplmbNhyfRP+W9oDDjSDaZPQX6W2qVggvzBUuOByusH75Cq1nIyLHjKGIlv
	 0dO8/QpGo4JJ89U0BZEvJFrsjQllC2ariTQ9Sv+PTNo0tcA75tow2pF/KOMsoKqvf+
	 P9xt5dzcFMqrSLDmjruBiTlRci5T7P82wYqseXUM/nFxkmnkm26VI75h9GiNJiApa0
	 KrgM06Ytkr7QSyRBu4mdOfj8qD+IrmRiDM0xvfvBvlMU1wR+pOyoDp5hqw9Qeh9Jht
	 +U6wqEr+kHCco+rGXtLQWRgIIFiadddfwXVMVg8bpv81BqWW6npABuFNUA5vlht7Zp
	 Su2u9onTitQ1g==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59b7073f61dso1220776e87.2
        for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2026 06:23:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXVvghH+Pv7IWZwEPJtf3n8NfEYixxZ7MuZoMRepnVDNmvMkwC+2fbvfgzTKI5K4rlIaAv4MmmY8hQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YySuLnhMAFiVcBCQKTY0pEgICn8vhMYP2AHc/BiwBLR4irEhuHy
	X5ZTZKj3egXvvUkXxNNM2Y+LeB6zWHReKRwcAphUBQBYdBxTNimetPWMsLfJIoDnQ0+/GccIzB2
	2bCI6ZNlXYPbjb719n0P0tWv1VKMa9ZXUXnCQUHJJXg==
X-Received: by 2002:a05:6512:2249:b0:59b:7fe7:eed1 with SMTP id
 2adb3069b0e04-59ba0f93961mr2163848e87.28.1768487034745; Thu, 15 Jan 2026
 06:23:54 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 09:23:53 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 09:23:53 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260115-pci-pwrctrl-rework-v5-1-9d26da3ce903@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115-pci-pwrctrl-rework-v5-0-9d26da3ce903@oss.qualcomm.com> <20260115-pci-pwrctrl-rework-v5-1-9d26da3ce903@oss.qualcomm.com>
Date: Thu, 15 Jan 2026 09:23:53 -0500
X-Gmail-Original-Message-ID: <CAMRc=Mc0XNa=n86thH+jVMzgfBUvusbVon6Z+3_Q89BkCmDeQA@mail.gmail.com>
X-Gm-Features: AZwV_QiUsTxYNS6Jr1kdpjMkCk4fYgccnMXMh0syqhhdhEUhVK9UOxC0jXuFgIE
Message-ID: <CAMRc=Mc0XNa=n86thH+jVMzgfBUvusbVon6Z+3_Q89BkCmDeQA@mail.gmail.com>
Subject: Re: [PATCH v5 01/15] PCI/pwrctrl: pwrseq: Rename private struct and
 pointers for consistency
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

On Thu, 15 Jan 2026 08:28:53 +0100, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Previously the pwrseq, tc9563, and slot pwrctrl drivers used different
> naming conventions for their private data structs and pointers to them,
> which makes patches hard to read:
>
>   Previous names                         New names
>   ------------------------------------   ----------------------------------
>   struct pci_pwrctrl_pwrseq_data {       struct pci_pwrctrl_pwrseq {
>     struct pci_pwrctrl ctx;                struct pci_pwrctrl pwrctrl;
>   struct pci_pwrctrl_pwrseq_data *data   struct pci_pwrctrl_pwrseq *pwrseq
>
>   struct tc9563_pwrctrl_ctx {            struct pci_pwrctrl_tc9563 {
>   struct tc9563_pwrctrl_ctx *ctx         struct pci_pwrctrl_tc9563 *tc9563
>
>   struct pci_pwrctrl_slot_data {         struct pci_pwrctrl_slot {
>     struct pci_pwrctrl ctx;                struct pci_pwrctrl pwrctrl;
>   struct pci_pwrctrl_slot_data *slot     struct pci_pwrctrl_slot *slot
>
> Rename "struct pci_pwrctrl_pwrseq_data" to "pci_pwrctrl_pwrseq".
>
> Rename the "struct pci_pwrctrl ctx" member to "struct pci_pwrctrl pwrctrl".
>
> Rename pointers from "struct pci_pwrctrl_pwrseq_data *data" to
> "struct pci_pwrctrl_pwrseq *pwrseq".
>
> No functional change intended.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

