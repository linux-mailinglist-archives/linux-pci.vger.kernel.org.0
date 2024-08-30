Return-Path: <linux-pci+bounces-12534-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D98B1966A14
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 21:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17A0D1C21E63
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 19:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448C91BE228;
	Fri, 30 Aug 2024 19:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XekhFN/e"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7F71BAEDD
	for <linux-pci@vger.kernel.org>; Fri, 30 Aug 2024 19:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725047434; cv=none; b=DhKEd45I5HcnCKNOZPa26tk1kHooddW3FIWo6+NauJOqS52wn5tmn6cgSALQ1eyIzriGWGFm2Ta0FTsonyXegsiWWHeswZao7uyFTd8LAvb/ldjvkbtbORztiQfx+8uuGxDcNH/drn7YGgDK9g4uOw3GUQ44p9/sFi5IuFc19PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725047434; c=relaxed/simple;
	bh=yXNmqAtLWS5NlIPRIhOiDrjJJPBlvX+h51JTFVleZsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBMnng1CGv4lQd4fU6mwFbNzXP5yGlBCV6gI0+39g1t7ALOHkv+5GtV0USdA5I9lleTbjuRDUAhayhJw160fC05dxfbtzvJKjljTJOMUyA9lUNwcZDZRbeWKuWOw+6ugDtcwXSkMNS8FF6R6uuQ2qmQOgdQkIwxuxgtFzkRlRD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XekhFN/e; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-714226888dfso1839757b3a.1
        for <linux-pci@vger.kernel.org>; Fri, 30 Aug 2024 12:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725047431; x=1725652231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6QlsYvzYMyoJ1Ksug9tyv8g6XTQnvNg8jtnf6sK7fQ=;
        b=XekhFN/eDLLhULgj+9yt+QR+Z8hd5PxKNrD99xDYp/sxEGJSYOG3IQlu3T0pogDAWs
         /xQDJJeggNAdXJ1XA+rv9d7JtE6SIiob89+FJ2LGDNwmtuu/kQys5sPtub6TPiFPS5Lh
         N8q5V7fZZQ/aCUnmpwRi7umO7NARDQaDHKXaoh5DP8ycTuy5IPhEz2VFbCOyF4umuO+8
         Gvemy0goURud/zXa9fWQ6ly/rEYt4OZWFd5fOb0LCL1ekwVv7A8YRd5uwGj2wv+VqbNc
         +AaoppnfB531dAEpzMSeLTfSXHXyvr9eCpTJt8lnHONJPSEC1lqH+GInCAVnofjVoCpt
         W0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725047431; x=1725652231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6QlsYvzYMyoJ1Ksug9tyv8g6XTQnvNg8jtnf6sK7fQ=;
        b=IV/QiYhUndd3VExOAGRN1Qmz46km6awLStQ5XYxAVMMeWdDvjVWdRQlRRjJHn/UiKr
         P8O/wTBc25pBbX5lFSeTbR/oAUQ0Tje7kU3LEs6ynwr9umA9HDwtzu7iLqudV2r24U2T
         U7ObxdailyWJy64ihPywee64hwSzX2kD0DoBebQFS9mjDIKLRp6DRc57Dn66SgxLTuGD
         VvMeneGJFQyHgAfOYJnP8L+C7B7B97BbLjP1/nVFdbHHCk8GSgkXoJoYHWT/Z6bY1l4l
         9nK2qB2XTgz2caiybtN1gK5lr+uoQkCGdeb0rXS4dfiKfz/96MlUCvhagumWreUr/27T
         UMaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLBzbpwHfut+IDzUxYlAUGa+WW/piev1qCNPit8Trt8K/N39VKTf+h7mBNHf6KITCpCtLkjhu6wmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVt0xmXycAI7csp7pcl3+KU4Gm3zo9vqKgZAY8qEwaV3u/m9v2
	cwxGc6f7EvSDiYzgShiVaqEsiTLik9Wuwm9xQ0tot58/QqHs1611bGxbUB2aDn0=
X-Google-Smtp-Source: AGHT+IEcm7YmlJtxqZsF4YzOMKYXwtY0ArLtbfsQjCm0ebmHvrq6+/sfSJC7izruBGlFJ/auiUixHg==
X-Received: by 2002:a05:6a20:9c9b:b0:1cd:f065:4eec with SMTP id adf61e73a8af0-1cdf06555a8mr2551415637.41.1725047431173;
        Fri, 30 Aug 2024 12:50:31 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e7423c2sm3296998a12.17.2024.08.30.12.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 12:50:30 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: s-vadapalli@ti.com
Cc: bhelgaas@google.com,
	j-keerthy@ti.com,
	kishon@kernel.org,
	kw@linux.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	srk@ti.com,
	stable@vger.kernel.org,
	u-kumar1@ti.com,
	vigneshr@ti.com
Subject: Re: [PATCH 0/2] Fixes for the PCI dra7xx driver
Date: Fri, 30 Aug 2024 12:50:30 -0700
Message-ID: <20240830195030.3586919-1-khilman@baylibre.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827122422.985547-1-s-vadapalli@ti.com>
References: <20240827122422.985547-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This series is based on commit
> 3e9bff3bbe13 Merge tag 'vfs-6.11-rc6.fixes' of gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs
> of Mainline Linux.
> 
> The first patch fixes conversion to "devm_request_threaded_irq()" where
> the IRQF_ONESHOT flag should have been added since the handler is NULL.
> 
> The second patch fixes the error handling when IRQ request fails in the
> probe function. The existing error handling doesn't cleanup the changes
> performed prior to the IRQ request invocation.

I tested this patch on v6.11-rc5 using a am57xx-beagle-x15 with a SATA
drive connected to the eSATA port, and confirm that this allows
booting again.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

Kevin

