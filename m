Return-Path: <linux-pci+bounces-44951-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 194B9D24EF0
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 15:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68A3D30161EF
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 14:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998343A1E9A;
	Thu, 15 Jan 2026 14:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GiH8tlRc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6738F3A1E8C
	for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2026 14:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768487187; cv=none; b=r1lCDaIqjNh1S3u21kaYQDiZYyYS7MwOACLObqbo9s6B2h3qaXwEvFe/7jh+ung9dyTGGgXoPPcSBRgRxACC1qJVT7MZk0pLbynv0nDdFLqLg+YuBNvBIICj64prdvufFsN6P9NBBALVbUMrlxe0K3Aj3zz0fFHBlSaxkZ8m6cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768487187; c=relaxed/simple;
	bh=LSk4RfFwqmeD13QblWAUhreLPvsND2YlkvwhIHz8Lkk=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ccZ0+KoBJ2bJt/+BjtUTmOVl1/Yuw/lVPzEdZ8v6nLoZkEED3d8p/5A6ozCAaDtTnAUNUbpDHde5Sy747aRAc1dkwwwKYREiU+tH1goJpz+ziq+9yy7O5KrJ00gfl7N7uDD6bKIGiCRnCuF3UtfR6fYofUfydKBo2aNFcLaLA8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GiH8tlRc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9B1C2BC86
	for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2026 14:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768487187;
	bh=LSk4RfFwqmeD13QblWAUhreLPvsND2YlkvwhIHz8Lkk=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=GiH8tlRcbEYCjeUDESJJAsv2cBvlQxscslskXO6wl7y8D8XxdPqS38wSAjTrgtBJM
	 I5HuTcSQTtovAi88NA4wNvx5pAIVDl6mho770YAk7zCZ2MrbyCV5GwBji4dCqfOoN3
	 bObCASPNjfUUZnoiUsJwMWKG8Ltzayq/aAiYzFIf0bKstHjUXaEl2QquN4YYJU/niN
	 CRRoYiS56Y809e18R7UOd8YpXoPZyHJcKSsBteRjvETlVi9CFUUkMm92/o2WyzXruf
	 62ibq0u3wO/gTYQ7e0gbmNnOZkvZGgXxH3ik839RbqFSBaGuz+WFClxSvWXo94ZLek
	 TTHmJouTjNEsA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-598f8136a24so1205582e87.3
        for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2026 06:26:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXnFpYo4pFMy4l09QYaQHqtuaS9gKfBD5w61o/TWZcoUVyiDd3jLEAn/jNXHXMhbDc6ymW8dombaII=@vger.kernel.org
X-Gm-Message-State: AOJu0YydqVSeHIXOjJcvG1Qqs67ehg6EkJKVFD6xdyoqYkx9FTs/awob
	s6OXvH6Jetn2XCfog/6g6XisVRuco0vSUkdZ0pLJjZOsf35CzT55M+hEkiu9U9uEP0BvZY9a7aZ
	PYTXx21wjsWZACw48SKAqXMGEkhxnOFrbHACWeYv2dQ==
X-Received: by 2002:a05:6512:138d:b0:59b:7c03:f2ec with SMTP id
 2adb3069b0e04-59ba0f8a340mr2357697e87.41.1768487185888; Thu, 15 Jan 2026
 06:26:25 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 09:26:24 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 09:26:24 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260115-pci-pwrctrl-rework-v5-6-9d26da3ce903@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115-pci-pwrctrl-rework-v5-0-9d26da3ce903@oss.qualcomm.com> <20260115-pci-pwrctrl-rework-v5-6-9d26da3ce903@oss.qualcomm.com>
Date: Thu, 15 Jan 2026 09:26:24 -0500
X-Gmail-Original-Message-ID: <CAMRc=MfFcFm7c3Xj==N4680SdGwhB2WEfbetVdeTDXEJPBk0Mw@mail.gmail.com>
X-Gm-Features: AZwV_Qh3ZSKWX0rzFw6c-MIT7Mdbqlr5Buv6hz2PQ0rAfqsxnbrMsYF2rSd_XI8
Message-ID: <CAMRc=MfFcFm7c3Xj==N4680SdGwhB2WEfbetVdeTDXEJPBk0Mw@mail.gmail.com>
Subject: Re: [PATCH v5 06/15] PCI/pwrctrl: tc9563: Rename private struct and
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

On Thu, 15 Jan 2026 08:28:58 +0100, Manivannan Sadhasivam via B4 Relay
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
> Rename "struct tc9563_pwrctrl_ctx" to "pci_pwrctrl_tc9563".
>
> Move the struct pci_pwrctrl member to be the first element in struct
> pci_pwrctrl_tc9563, as it is in the other drivers.
>
> Rename pointers from "struct tc9563_pwrctrl_ctx *ctx" to
> "struct pci_pwrctrl_tc9563 *tc9563".
>
> No functional change intended.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Makes sense, thanks!

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

