Return-Path: <linux-pci+bounces-35270-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA46B3E501
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 15:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E9AC4E2B47
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 13:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E7D149C6F;
	Mon,  1 Sep 2025 13:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Icl8e9Vo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BD2198A11
	for <linux-pci@vger.kernel.org>; Mon,  1 Sep 2025 13:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756733469; cv=none; b=h5YIpSSGkxzIYBKY2QexL1mzWCmDB8AX/1lU1WbwZrWY7hPvJ7cqKHBWv0lGdYC658aFF9UXjF6UWdYb640PaFA/QTsfAr39XGvAawDS+AK8lzyLjYTtqY7qwzgWqUh+lUNsQbiVLVRsUXaa/SlCVbA0gZo4fYtgpGDwazV9SnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756733469; c=relaxed/simple;
	bh=lCpYxwNZ0fd3/4JdB2UP6w7/TzeFfxBQeM/QCFqRP3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SCKmD9K6TwZoqzVk8v+4kxhvTfPJeTncY6ZUNoK7T41gR4lAqyBzTwr+YHUsK97uecB1xZiit7IHB0FZn5l0ugXnk+uvtddsBD2HK1gPUFRdHLHJGWiBmwBd9gFFr93B3dT8zxsDfCa60ek0imXB7MbXtyVRdRSIwgrO3iHM99k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Icl8e9Vo; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-802dd2ae55dso3112585a.1
        for <linux-pci@vger.kernel.org>; Mon, 01 Sep 2025 06:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756733467; x=1757338267; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wCDjZSgl76mrff4NwHQBbFuq61Q1zOmaA8xgmtQ4BxM=;
        b=Icl8e9Vo+CCN/HQsblT8Yxly/YK+mCbUaDsBQQjUzAAexLHAq8Ex7Gi9+SQfk96woo
         SyDiTYWOfclLgdO3amCVcIuEWTs9BoeB/0IEcjlGjyRZfM9ZIb79v83al0hXgSxZLmCo
         EtcqOsOkY5wVS/WA7ERT4Y2TmvZPUcgu1JuVwhPswGeOU8yc/2qI6dG2o7c1aj7c74N8
         FmSVqJmWCGBUVhytDEXI6rVzazGlrU22FsGJoJKWkvhFhA6OBdRkOXxBpnGISHBo4xUQ
         sl4R71ejjgQtG0nGqu1yV1vMLQBdi1m5twNnn4Lb0l2X8yW9vO+LDsAmp8RGP/tgyETk
         i2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756733467; x=1757338267;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wCDjZSgl76mrff4NwHQBbFuq61Q1zOmaA8xgmtQ4BxM=;
        b=bSF8Ih15T75hjC7f8aK4HXBa5gjgXDjvn686Ak1yEiKDaboy5Be2NNaamNjDv5zzQ8
         uWSw8mfmT7rVSaxwoc4BvDw47RFmjbp+TLQdLebj8vHd8GHrpgdKeq64kH/cMQFMQvnw
         DtIk+4BVcE1YcoQKd4QDM2IyMEgc4rhLxphBwQS4A0s/Gf5/b26iVfE67Z9SDifoXzw5
         Ljc3XlJTwkgGudc2+3FDcWhwRrLmSmI886EY3tiMVbd68txixNm7vJfL2kcT8Cn9Zfds
         MaFC8w6yepN7bGSlba8w1to4Rm1SoUEfFVAIY7w9UGLNRjhCRswwbtKCOeLCHohXqhAB
         Ompw==
X-Forwarded-Encrypted: i=1; AJvYcCVGRpOqS77S0TP7EkXjqUVbDAKG0KTMNoDOZzNLVbgolriNhbppMs9evWMIID6c+YPeRKDaTONUmN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEeHLndeYw5vWQbRzmlIzdEQp7+cYezUYWMyKSduJUVGHj8LiH
	Mzl0kEJ4YAmg/ZNptbTs9iVjrWq7aMoXa2nd6a6cX3BR8W4JLlofSajHSyF+1j6Evwf0rayf70o
	j59BYkHMRFkXYjrLeyPCl5Y4l0Ea9Kl6sbhtUnaeIhQ==
X-Gm-Gg: ASbGncvBMVKAEIoxmBM7nsoSabPdgZeR5zpO5Z2irDklI4Eq/5ieRGbXWYDA8xPbF0q
	DZ5T9wilBsIcVfMio75jomcd9aBCnbieVqVZ+CFEuLTrms6e5Hwr5tHbUZEWietYmsP3VZ875E/
	K3ZVF2YNBZFbcHTOcFT/PnSGWsGVl2afB9mYMEcYondyzu22p3eBBmGx0yfBJdM7+ZiTr7euoeE
	bzP7sCua6PrewSGDm1FU+DKzhA=
X-Google-Smtp-Source: AGHT+IErB4PfzzopI14tCGiVeZs7a9//buOSDYOobMbsVWlDMHk7o0uJw941KlS7WlEBD+FlW1zvW/7hPA+tGMwbVWE=
X-Received: by 2002:a05:620a:4495:b0:7e8:5bb:b393 with SMTP id
 af79cd13be357-7fd808341d0mr758728985a.4.1756733466773; Mon, 01 Sep 2025
 06:31:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827230943.17829-1-inochiama@gmail.com>
In-Reply-To: <20250827230943.17829-1-inochiama@gmail.com>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Mon, 1 Sep 2025 15:30:55 +0200
X-Gm-Features: Ac12FXyONJJHG25VQtRqcoXABg35o0Wz0jSFgjK27pZDOrhzFTzQjZ7eUFY1fUI
Message-ID: <CADYN=9K7317Pte=dp7Q7HOhfLMMDAfRGcmaWCfvOtCLZ00uC+g@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/MSI: Check MSI_FLAG_PCI_MSI_MASK_PARENT in cond_[startup|shutdown]_parent()
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Marc Zyngier <maz@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Shradha Gupta <shradhagupta@linux.microsoft.com>, Chen Wang <unicorn_wang@outlook.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>, 
	Linux Kernel Functional Testing <lkft@linaro.org>, Nathan Chancellor <nathan@kernel.org>, Wei Fang <wei.fang@nxp.com>, 
	Jon Hunter <jonathanh@nvidia.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Aug 2025 at 01:10, Inochi Amaoto <inochiama@gmail.com> wrote:
>
> For msi controller that only supports MSI_FLAG_PCI_MSI_MASK_PARENT,
> the newly added callback irq_startup() and irq_shutdown() for
> pci_msi[x]_template will not unmask/mask the interrupt when startup/
> shutdown the interrupt. This will prevent the interrupt from being
> enabled/disabled normally.
>
> Add the missing check for MSI_FLAG_PCI_MSI_MASK_PARENT in the
> cond_[startup|shutdown]_parent(). So the interrupt can be normally
> unmasked/masked if it does not support MSI_FLAG_PCI_MSI_MASK_PARENT.
>
> Fixes: 54f45a30c0d0 ("PCI/MSI: Add startup/shutdown for per device domains")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/regressions/aK4O7Hl8NCVEMznB@monster/
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://lore.kernel.org/regressions/20250826220959.GA4119563@ax162/
> Reported-by: Wei Fang <wei.fang@nxp.com>
> Closes: https://lore.kernel.org/all/20250827093911.1218640-1-wei.fang@nxp.com/
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Any updates on this?  It pretty much breaks testing on linux-next for ARM.

Cheers,
Anders

