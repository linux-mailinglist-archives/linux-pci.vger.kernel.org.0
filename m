Return-Path: <linux-pci+bounces-26291-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9310FA944C1
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 18:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8F52178107
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 16:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EA91DF977;
	Sat, 19 Apr 2025 16:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HAdYTFpU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF9B80034
	for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 16:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745081685; cv=none; b=s+Zsx2q0gdi9JlEGgzhJwkWOPuwn77LCCYblNGRuyQFlPTeX2Z6W89A/nRxvb1yyTJn8d02IWbPGJy6LwV+QDbXpcLH+55ACbm1QzljoRY6d5fo7SBXh+6ShMzbUFB6ZQeaKRcyhUqt4vcZlfwfATaL9F/aK6TDoz9sq6zM+lTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745081685; c=relaxed/simple;
	bh=gpFzt9a0/L009rwgmaXycDOg9jsGrSoOkzkXV3bFgNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lzUdTWZAJr6OGlRNX+beo3j6zc2S5gedFvAEVqEzlEbrDF0+6wT0XllraprryuV10MLKMTL7VFrLYuLROqS+3o/v+MP37R/OzyhoytznmSKz2B0Pgaj2QkbkC6ZTFxxxZVi4FhLlKebvkFYneV3+hUdPtZ7JNi83Rl8IVZ/jMC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HAdYTFpU; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b041afe0ee1so2432522a12.1
        for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 09:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745081683; x=1745686483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m93ArCqGj/VL7itXbB4s74bjvMX+c/h5RtG0prz3w/8=;
        b=HAdYTFpUx06hV+zq/NWZ1RxR6KkQD5OhmRYCljXlCbrnZUm6FD92rDUJBXaKRVkznQ
         jA6ng3gC8x94ii5uyLckqo27rfaqB5gd4WPnySTydxyHklN2rsCnIoAL7CRd9JeTXVNB
         P5mMLSgqvfNc9J1HLx1rWq2xcvUXjT1OAxgBtOJ7/5PSr3Xim0j7jOfV1dTCS6aI3uky
         ipi0tT33TKxwO4yJpKe3MIYuqtdQA9q3Os0SHy/uLEI/PHOrsnKSJ2eHej2IzQLswu3H
         asYc1i6QbyRjLqeWS8t7qb+o1Hwz/iNFoev1ScXGMD6mJXWCxvc/jbKZa6xOFYJBvv4K
         SQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745081683; x=1745686483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m93ArCqGj/VL7itXbB4s74bjvMX+c/h5RtG0prz3w/8=;
        b=QTNrNOSMGKkA0l5u3NN4DW7pxTlQKvFowfyxSSU9QRFxvRIsSA+F1NPFtI4YB95Fqi
         KENrdmfOHQlb7Blof8qzYn3ekKT94x5+EK60xb/MeJJlV7z5EQUxLDylIs0m/k1KVpAC
         aQViDAkz/JX5sz77EFk5g0F2qRUOr/colztBsLlWiB0xDxk0qJYXAfDI6dMvXiIyT3RI
         VUFuG0qs4mtuA03ZyJqX3U+c3i1u7NmqnlpBk6OEJdQlucxNHPGt8f2VnyuryZToIVhq
         WKVjZeew2ZUcmnmCF/4DpKJ3NIkAlFyFOtMgVyQXG1hmUMr3TTUUqHsOaxxnycIqU1Ja
         aWww==
X-Forwarded-Encrypted: i=1; AJvYcCUrjFYyPEYxoxIm8rpKzgCSsldayoJr+fU7Ya6EYOeYc5akwj2KSkkV/4GEZ6e9PZ1xI0ka6scpuas=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjKX1/D7G/A/g0uIoWR0/ogd3d2GTjWGg1qOtxrW4nCf907Uap
	o+ljy3q97+Su8kibrU6ZFe0jNDO5uZ6p90aY2Kq2l5tVR/sJGvlLm4YNy9nuHg==
X-Gm-Gg: ASbGncsYWJl4qRPAjpwj75mpqO/dptEh9FpzX+bPY7buYh8bIq2MrqTiw1yFJRI6ueQ
	ec1E7/IeXX53Jax/rRiphrDV7rZBatIAE2oaTQaTXLEAcPemJR5l0EzyGhgmzce/Z5N0AvIAIF4
	p6ZssU2aRYaHn+gosJf6y7/w859DcI0IqiftWXbNgqmm09Een1RmplSYeDDamNT3l9bXJ8JdrP9
	3ebzwrtfnhaYnnApGRjEXQwLht79C2LDnSdDnWC7taJM1H34rdhziEtbS9kcRvDrxEtAo1pwgIY
	nAHD78Pg6hU3FbSLcWwKj19X9RNPVwyNtfJPGT5Ci3oIkXE8/KvDNg==
X-Google-Smtp-Source: AGHT+IHCBR39x7sDCmGPm0DAtebsJb1E3Rb4vSoppQGMXGzbrScjvVjdiiA/UY71hEB2ck6zvFVsPg==
X-Received: by 2002:a05:6a20:12d4:b0:1f5:6f95:2544 with SMTP id adf61e73a8af0-203cbcd5e44mr8909123637.33.1745081682802;
        Sat, 19 Apr 2025 09:54:42 -0700 (PDT)
Received: from thinkpad.. ([36.255.17.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfa59cd6sm3480086b3a.86.2025.04.19.09.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 09:54:42 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: lpieralisi@kernel.org,
	Hans Zhang <18255117159@163.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	s-vadapalli@ti.com,
	thomas.richard@bootlin.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rockswang7@gmail.com
Subject: Re: [PATCH v2] PCI: cadence: Fix runtime atomic count underflow.
Date: Sat, 19 Apr 2025 22:24:32 +0530
Message-ID: <174508165327.58233.7858938812683501667.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250419133058.162048-1-18255117159@163.com>
References: <20250419133058.162048-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 19 Apr 2025 21:30:58 +0800, Hans Zhang wrote:
> If the call to pci_host_probe() in cdns_pcie_host_setup()
> fails, PM runtime count is decremented in the error path using
> pm_runtime_put_sync().But the runtime count is not incremented by this
> driver, but only by the callers (cdns_plat_pcie_probe/j721e_pcie_probe).
> And the callers also decrement theruntime PM count in their error path.
> So this leads to the below warning from the PM core:
> 
> [...]

Applied, thanks!

[1/1] PCI: cadence: Fix runtime atomic count underflow.
      commit: f8015b6a0db95ce09aaacb236746f33b7a540a3e

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

