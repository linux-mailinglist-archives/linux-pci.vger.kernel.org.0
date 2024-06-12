Return-Path: <linux-pci+bounces-8640-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 215E8904CC2
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 09:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 379ADB2025C
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 07:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CAE16D312;
	Wed, 12 Jun 2024 07:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="eNd5Ceix"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E792916C844
	for <linux-pci@vger.kernel.org>; Wed, 12 Jun 2024 07:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718177103; cv=none; b=P5rmFcXmo++OBDt4M1McvKR9gucYnr/k5sMT/B7PeKLwvJj4ODTE3pjtOeTCyKyl5glCLfkHgmUKbxg/yTObDKDIysHXYjmkbmVI+M3QhEi2GsJbm5qawNUUey/0UiBn+4lZsIjJELUM0dH/IHIFlVKR5paNtwnFtr7E5oQpOBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718177103; c=relaxed/simple;
	bh=GV8vhLk5W+15Fu37cvfJGGkkE6AbEn/05xw+plQAHrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hxHJ2CDfghp1HuJ+cCIwSaG/DnJxUSUwhQCM/asB4leyXr+2t3wZWbd3RPDYSiq3LTjR0NhV8IO+v//BDsCFLSmPNdjNT6FC/MWwwf/M/mbe0mv4Nd4oYHztQLydw2gnHE3Doum+EFCBh5FoSOb/Q7CqtLrZhuQKd+HLockUHe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=eNd5Ceix; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-421757d217aso45465425e9.3
        for <linux-pci@vger.kernel.org>; Wed, 12 Jun 2024 00:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718177100; x=1718781900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZZ648vF2hGd45hekWosmU80qN8L5wlOVqhbijLkjGE=;
        b=eNd5Ceixs5u/g3v6ODZjFyxjAEDPzadGTSf/6GUQL7AfM8wJycLhpqO50pAS875tqF
         pg+mNBSeEF7bXrFHJo9gihBclpdBSOEVmvXZIOw+od0s+EhKU7y+XEdx8FQsmCZL/V9a
         LeEY2OVP4QZOeFICVlJxoNQ61YWf5BHY63T+p624Daf1A8qank+N2v3o0rZSAykbW9W5
         +vylme+bJks+NgvEyucWZ7G8dgWY3kT7Q4sJWubMgbPALPNtJsFcGzKYrP82VtCdiQs7
         nh6saJxbGvhw+xi0l05gHc3uU/GxIAy12BRCGYvNigqyXA9PnY/DtWXlj0c4QURYFkpB
         C6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718177100; x=1718781900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZZ648vF2hGd45hekWosmU80qN8L5wlOVqhbijLkjGE=;
        b=M2tkGIbp1861XbrSK5NkoL4QsNnnCzoVQE3B+XLZN81L0P7qItb2alAdO2lMT1Zhkk
         AK5VtHc3LSoyX43Hl0gnlFdg/h0TxDdnHPBfsIpkLAr7lpI8Dc/6mS5uKYxHQi1fzD9+
         d7JcM1CSF5kRoQEStHNEVF3fQko4J6AuVxF0zW7gWS5g99MsTv08Y/zvH9IRHqqv2hme
         tkZvutj1TliOb9yVcxV/ceZLoWlkYN6NZCEHO/jFjH4qaXj/20tliSSeY3TfobMqcZBF
         Wl/7t17YC991cFkh3nDpO5EoK/YdgFMFLiLkc4Ebv5AwSacbiUV2BB4eDgmIBMO6h7Fp
         risA==
X-Forwarded-Encrypted: i=1; AJvYcCWG080wIl40zrs0HrxiVOQe1rJQ88lKZuUAhzah9h19kyX7uAtbAlxFCgOPJvFkvE3NAHG/mWxC/THsVIxWSA0Gt5ZuBzWrKOlG
X-Gm-Message-State: AOJu0YwrrCb8JJuPjWUBSpv1lOZKK4Ey07BRbhl07GL5UlkPs+1nqHUP
	oc4jlfMi3Pfc08IKCu9e9kOC0CE1KLlLXMW6hRmkPmtfYn7pwC2p88+Gv4FJaTA=
X-Google-Smtp-Source: AGHT+IHzJQZOo7VhfwHUIA0Rvt2UNlF28rgiuiNCV0gXUegLqiznXfYjxQF2KbE4ePZs0+9rQ3O3JQ==
X-Received: by 2002:adf:e6c1:0:b0:354:eb62:365a with SMTP id ffacd0b85a97d-35fdf7adcd2mr650626f8f.25.1718177100076;
        Wed, 12 Jun 2024 00:25:00 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:8d3:3800:a172:4e8b:453e:2f03])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0f551c20sm11692172f8f.69.2024.06.12.00.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 00:24:59 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Saravana Kannan <saravanak@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Amit Pundir <amit.pundir@linaro.org>,
	Xilin Wu <wuxilin123@gmail.com>,
	Alex Elder <elder@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v9 0/2] pwrseq: introduce the subsystem and first driver
Date: Wed, 12 Jun 2024 09:24:56 +0200
Message-ID: <171817709104.16429.1270997690165832044.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605123850.24857-1-brgl@bgdev.pl>
References: <20240605123850.24857-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 05 Jun 2024 14:38:48 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Hi!
> 
> These are the power sequencing patches sent separately after some
> improvements suggested by Bjorn Helgaas. I intend to pick them up into a
> new branch and maintain the subsystem from now on. I then plan to
> provide an immutable tag to the Bluetooth and PCI subsystems so that the
> rest of the C changes can be applied. This new branch will then be
> directly sent to Linus Torvalds for the next merge window.
> 
> [...]

Applied, thanks!

[1/2] power: sequencing: implement the pwrseq core
      commit: 249ebf3f65f8530beb2cbfb91bff1d83ba88d23c
[2/2] power: pwrseq: add a driver for the PMU module on the QCom WCN chipsets
      commit: 2f1630f437dff20d02e4b3f07e836f42869128dd

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

