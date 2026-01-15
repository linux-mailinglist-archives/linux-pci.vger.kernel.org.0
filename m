Return-Path: <linux-pci+bounces-44947-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 277ECD24EBD
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 15:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDDC23012BE3
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 14:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1393A1E6B;
	Thu, 15 Jan 2026 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpRM+PSG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CE23A1E69
	for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2026 14:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768487060; cv=none; b=XlF3FIu+JbasP/s6q+lxqXOefTxK8XTc6ElQKwATaRQroLLweXBuE0du0fiyJwBOMOoR9iqoZkLDjeUboVR3ZutDXTM4X4cXMRSA4gB2bz1aauX1UosbHmcyaFJwofYXR9sXtDhM9MPu6+oYP2YEP+57+L3eFzmwN8BK2U0KvpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768487060; c=relaxed/simple;
	bh=4calEypt34POw5p9b+ydat+6ZyY0coE6usshj/qabps=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z4S19aDPe3NdUki+7Mg1H5Y/ukojolXKUpGvXn3If0NmFtd0OFIfwTj152yHAvmEBqq+5X5Q7JFBfGqb2kSjHqxm60FcCgHC+ETlMFaItrFnLxacCWhAsyQgPLwn2opKvetXv8hxLI+K9GBLoO5VNcZ10Pc6zb2UltJig4p8UJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpRM+PSG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4966C2BCB0
	for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2026 14:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768487059;
	bh=4calEypt34POw5p9b+ydat+6ZyY0coE6usshj/qabps=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=dpRM+PSGBW56JY3nhZAAfzoC5x9K455BY2aKK/VXf8fQK8n/VKc2zmwn84sKPp472
	 PtKEEuDXBffIXOUjDcLmKhZ48yUAFasewEUFunEVw5FBvyfaiEa13D7YxajH1IPpT3
	 tKQ5jKjN/998jcyHuURSKfqG/VI52k2iGmn22Ag04uIvyKRNjI1lZ9PpNIhQkq48U8
	 SwNO37Ahg9oyI57yZZsE+dyI7pzx+oqAFqvfFn0VYMBLBejMbHCItVpOXyyTzYUngd
	 DpxfCkhFy2SKWYAh2FCgRrV5wF2hQPuoe39gzCqdlEIZL/wPD5rBMw7/zO8WfyouPy
	 lscle/i778s/g==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59b7be7496dso1071086e87.0
        for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2026 06:24:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWLSK5S+QlkuG0QttX0bB3CybDo/kjZBZDX6Bg3TGdsSYZxoh++emSzaaAcHEDI/mmzFjqJLTiherA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXtuMipmmMrun+hxkc7ho796FRNWOS6tg1nsFbGYKXGLqY02Um
	GOGjSlVl9iytkCZ9brkdT0pRoS5LZLal77Tc+VrLNt4ZK+bYB5PnYrUE+cF6XYQ66Ma6ieLKqwS
	zanksnzIL/wDC7wCJUrQ4rBjEGtEdfOiBeQSGmJn8mw==
X-Received: by 2002:a05:6512:3e28:b0:59b:6fa8:bc80 with SMTP id
 2adb3069b0e04-59ba0f78bfamr2247715e87.32.1768487058383; Thu, 15 Jan 2026
 06:24:18 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 06:24:17 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 06:24:17 -0800
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260115-pci-pwrctrl-rework-v5-2-9d26da3ce903@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115-pci-pwrctrl-rework-v5-0-9d26da3ce903@oss.qualcomm.com> <20260115-pci-pwrctrl-rework-v5-2-9d26da3ce903@oss.qualcomm.com>
Date: Thu, 15 Jan 2026 06:24:17 -0800
X-Gmail-Original-Message-ID: <CAMRc=McHcj4CZnKvgDJW1+kJ+v8aVoB1uYKJonCHzCFrOMg+cw@mail.gmail.com>
X-Gm-Features: AZwV_QikWfMfRv1UXaJ0zOBkJkzkPy3Cq4t9qWixHsmbz8UUoJqZHaYAuiWCPoo
Message-ID: <CAMRc=McHcj4CZnKvgDJW1+kJ+v8aVoB1uYKJonCHzCFrOMg+cw@mail.gmail.com>
Subject: Re: [PATCH v5 02/15] PCI/pwrctrl: slot: Rename private struct and
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

On Thu, 15 Jan 2026 08:28:54 +0100, Manivannan Sadhasivam via B4 Relay
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
> Rename "struct pci_pwrctrl_slot_data" to "struct pci_pwrctrl_slot".
>
> Rename the "struct pci_pwrctrl ctx" member to "struct pci_pwrctrl pwrctrl".
>
> No functional change intended.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

