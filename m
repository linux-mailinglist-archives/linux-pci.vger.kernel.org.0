Return-Path: <linux-pci+bounces-44949-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC84D24ED2
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 15:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6FEC630049D9
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 14:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F633A1E82;
	Thu, 15 Jan 2026 14:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSEIw7uV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B5139527C
	for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2026 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768487117; cv=none; b=f64CVfG8NgHjIHG+GSdYKSUcRucPuoDXeHsxUgrr56lU9ZlQe6I42xXZiqqWHeNcIeWJYvvspLYQ+YOi24fk7LCwD5Y92DBxRj0waOQGGagoOaY9/xh/gQRZk7kGX9mUUOiRn7BvkocL88TFtAEgFLV82di+P3asFdNi6j6RdV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768487117; c=relaxed/simple;
	bh=wjL2E9ZDu/VaNlHENbb+X0oEOZiKgPzvILTznItKO+4=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rXfPDAxji7wg1QVDtXxgo0U15j6n0k0s5e9wHjD4AAKSiIZqkRKyjGCdSNcj5iGd7Q11kS33ocMMm7SgvRbKUXU8oaFPd78sdp6RTOivTIgLwYx9WSDlkYSRvmjQELSIjevsEOfYFcdUwEITdN+kkBjbDTKNnzXqY82+1NRo/CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSEIw7uV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C926AC2BCAF
	for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2026 14:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768487116;
	bh=wjL2E9ZDu/VaNlHENbb+X0oEOZiKgPzvILTznItKO+4=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=WSEIw7uV9E7WitI9guqao3LJMhkly5cpVOIglVhURPIfgIvp/Tmg3cos6t+o1dN/1
	 6JsiKPAd9GRsGz7r49b5w2mMbcv4tLlIQanHZRqtIuTqD/f0r5NRIqcUVrGmx7pUXW
	 Qsabn9SijjRIBB6GJMtzCpKQaXEQ28dbpsfvTB6Pnw1b92EGIBlXWduBwUThux4h5/
	 YI+4IsNwQlA7i33ZVUu5lehwwb9yaUupGVabEGYP1PlK5YFdbhwRsUMPF79QEJpxqv
	 PeUGVxgubXM1xr+RB/WVKY6+HpIZjuldRO12Zr7RIkmX14P3AvTgo+weUEB7gMu53b
	 GBWZmqpiZNScw==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38304020185so8666391fa.2
        for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2026 06:25:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWKuII5V7EWnYCSNSifnCg/45rmLIN6RSEf64ScJcT0bBmCmLRKwR/edgAncYOs/nk/zReQ96WUm1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXSb4rxDO+rp9+YdjjSkOG6Gkx4Y87DhMIxjxP7fAxZagWB+CN
	yUAECSJelTH9K9diO1Ta0e+BXqhkEkEUHcMNoW3QT3FG755Qy+LLHhl6YTF9BTE0JoZDra0pvwv
	IfLd/TDh6yZ6ZrMjqh3rUEBkbimThkDhKORQczU8Ydw==
X-Received: by 2002:a05:651c:210d:b0:37b:b8c0:b5e1 with SMTP id
 38308e7fff4ca-38362f93d72mr22039841fa.27.1768487115470; Thu, 15 Jan 2026
 06:25:15 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 09:25:13 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jan 2026 09:25:13 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260115-pci-pwrctrl-rework-v5-5-9d26da3ce903@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115-pci-pwrctrl-rework-v5-0-9d26da3ce903@oss.qualcomm.com> <20260115-pci-pwrctrl-rework-v5-5-9d26da3ce903@oss.qualcomm.com>
Date: Thu, 15 Jan 2026 09:25:13 -0500
X-Gmail-Original-Message-ID: <CAMRc=MeqFB+sv51DAjtGO4vZNmLcLA6g+B3QF0nJGV-TfBWJ8g@mail.gmail.com>
X-Gm-Features: AZwV_QgtCt88AEqYS5vg7YS507XqeedfZWClMUThWZD62wT7I1xzqxO2u7aWGHY
Message-ID: <CAMRc=MeqFB+sv51DAjtGO4vZNmLcLA6g+B3QF0nJGV-TfBWJ8g@mail.gmail.com>
Subject: Re: [PATCH v5 05/15] PCI/pwrctrl: tc9563: Add local variables to
 reduce repetition
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

On Thu, 15 Jan 2026 08:28:57 +0100, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Add local struct device * and struct device_node * variables to reduce
> repetitive pointer chasing.  No functional changes intended.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

