Return-Path: <linux-pci+bounces-26283-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F12A94350
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 13:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E32F189B7D6
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 11:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77701D63DF;
	Sat, 19 Apr 2025 11:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="REuvkCqC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055CE1D63D8
	for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 11:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745063553; cv=none; b=lY8f4kcnh6uDgbuwFl9Q8HWHzi62x5Td2ja0XzZ8knEU9VMwwVaDCeLys7m5Zjp21HC2vsdChCxLA7/KwE6Hmacz11a1wdvd4k5eUOXyzSNMNR286yEQjbjVA/cMQsWJhrSBc9AElipuGI3kyfwiagAOJKdaqnogZ4HTuN0KgGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745063553; c=relaxed/simple;
	bh=qKCScRiTrGJSBiUpLn/HDVoJJ2eR6y7zraiOMMUk6Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mSN+/W2DhL6ncvEYq0C4XFEgGUJFqiIS/lvoKhZV38xrcNqte8Bo4NsaFBBOZ7ZXZqT+G5f8GMCDi2BE404ZnNemGqcYUqkeDoWfc6iVzGHbJzR2LhykdizMMRE0uQ8s1JPzr/+RKd0G34LskEJoGMFea4jx+q51+1peo6snqyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=REuvkCqC; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ff6e91cff5so2561809a91.2
        for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 04:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745063551; x=1745668351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=px0hPaEeyRW/CvDRRPztfyMotj+Xv6y6UjJ57CxB080=;
        b=REuvkCqC+bkJf3FkdwKvz7NnPzp7LeYZohW7O064oLAp8+MWRt/gtvsxlhnssOSu6r
         Rz8CR74D1ymUyIJr4L30zOoBW3Lyg29Y1WHiFvRV3h7j/jOiU0pqTPQMoLj5AtoBElMB
         0zoXfFWTzFX+ifWTWp1Y+VfEqWF3WTJtemMgZx3u2AcFe0Y7t9AmvgRGfnmhPHfIqLpA
         RQg/IWFTgx+cXNUPR+rYSVzxmAt3x7w/TJjQe7cuB4Gx4kdYUmrUge6ZjPGqaxRPJD+b
         jcc38qq0LAQxwL6epRiSl1h3acH4k0o/O1Tx0rqo61MARYg7FXfwFtcz2DRR/cA0OII0
         3dDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745063551; x=1745668351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=px0hPaEeyRW/CvDRRPztfyMotj+Xv6y6UjJ57CxB080=;
        b=n8I7rsM+tTZDP2kR4gXrzrhyh/cd+nqVVbV3AkHI0ifGahPfV2DoaT+gHShDscTv4S
         GzgQdjsMl/CBPE6x+sBQeURaivU3RMU2Zs6ZjwbWrz6Nr5hzF8E2YCvvT7AAf4aTOnE5
         wwY9yRiqnWQrbQPohS+rzfLlcQVBRmlBYar/kQoVPfcvwSMYXf4ciO0NSVs3V4fem6kP
         mXOJk3G9McwLPOl0K0o+lx0Z4T03925ydT2NkH9k3HTGUARrEZ8ZknRDV5Eb5T4trEhy
         7MsCAwF1/NjKkqD+ssAnCY7VgMz0SqXJ3UvP5Ksv3dE/pOcjFiO4TYwJBAFVURRSWSql
         76dg==
X-Forwarded-Encrypted: i=1; AJvYcCVNKr22ilOHkcAFyss35OXB8S7uxFcM6HEZq2IUDbydmU5URNvVoNrueMvRz9M6i7NLiF2Gc+m8Xco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz702jw/sH35n5lEViPvLvkxjIjHKjURvKdXukQ0e/Gzp8CW1cs
	cDbHILV917VqK9OEywlPFeb+MSZEsCe18L/Fbb7NqQIziBbhx//kzErBryqmAA==
X-Gm-Gg: ASbGncuRBe9miHh8EWLOKHtplWoTSuJEFoVkx//g2dpn8V1Ry+RPC13WLfCsq0bV3Ic
	PUJ8OnHlu4uBZaGaHoBA9vpbWRK+rdRKF/494ty3Gp7a63mEq+7c26PnxB3lb/IvVXAv+LnRKrE
	btNx1k8RdCLrF0eATHkGEqH64u7ZCaCOw4r2n3p+GfRCIo5hSOz+4w4Yn6ZOHfDo6fDo6rIyem8
	TmApaXwKYYQ9wytZZu/+azvizhNRfxEH5lWW15w95NktMxGjFFuX3hn8XeeZ+W3V9cMN5Ut1tqb
	XhuWM1sKqG457fNLWumED5gV9ESJGZvBYpf9m436JM5EZQl/DKr6Cw==
X-Google-Smtp-Source: AGHT+IGxohOcrVLT2HpkDYi9xceN2Uhz9oDZW+ezY0LfwsFn53P6RbFmjao2TeMC0K8cXhOK65CtbQ==
X-Received: by 2002:a17:90a:d010:b0:2fe:7f40:420a with SMTP id 98e67ed59e1d1-3087bb69218mr9255068a91.17.1745063551225;
        Sat, 19 Apr 2025 04:52:31 -0700 (PDT)
Received: from thinkpad.. ([36.255.17.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50ece2f8sm32069075ad.189.2025.04.19.04.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 04:52:30 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Anand Moon <linux.amoon@gmail.com>,
	Jensen Huang <jensenhuang@friendlyarm.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: rockchip: Fix order of rockchip_pci_core_rsts
Date: Sat, 19 Apr 2025 17:22:22 +0530
Message-ID: <174506353387.39503.4719676281195371261.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328105822.3946767-1-jensenhuang@friendlyarm.com>
References: <20250328105822.3946767-1-jensenhuang@friendlyarm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 28 Mar 2025 18:58:22 +0800, Jensen Huang wrote:
> The order of rockchip_pci_core_rsts follows the previous comments suggesting
> to avoid reordering. However, reset_control_bulk_deassert() applies resets in
> reverse, which may lead to the link downgrading to 2.5 GT/s.
> 
> This patch restores the deassert order and comments for core_rsts, introduced in
> commit 58c6990c5ee7 ("PCI: rockchip: Improve the deassert sequence of four reset pins").
> 
> [...]

Applied, thanks!

[1/1] PCI: rockchip: Fix order of rockchip_pci_core_rsts
      commit: 84d79f3304645d6e87b936d2bf8b8310798efec2

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

