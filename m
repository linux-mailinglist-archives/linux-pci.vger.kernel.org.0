Return-Path: <linux-pci+bounces-15110-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E00BD9AC517
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 11:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19F371C202E7
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 09:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5669315CD60;
	Wed, 23 Oct 2024 09:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HNczZDfw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D8D15B122
	for <linux-pci@vger.kernel.org>; Wed, 23 Oct 2024 09:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729675389; cv=none; b=aIC5TrTcc0cj0+URvgwl8mw3N/kYtHXHh3e772yLA79iHXAkBJYL9xB09jkehkJmF3Tk3UhFtes6DxROwo7GlWECNcROq0NfVnm38Z0YttkgtUHQHRcJMaHCchzILrhNx7NspSuZfrPG9UdGjVS0Cblbr1B1YMzSNUa8mWMjE1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729675389; c=relaxed/simple;
	bh=FV1ZLlJ6ihzrtTWl6CBeIqu9ifr35Cm5491ANjcacY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PaoXo3wB09u7c/MKIhrIxNVtNVV2TISOh7a9RBfiz1RJdKpDnuA13jUByEbaVIiPzO1DNjsZt7yfNRVeLxypMWRifT2GnAh9MaJThrxRi+NAy+TgQ56sqHRQ2bvKwSfPcLh9IQSAHpP/FaRTduYbgjkoqizFXZdA6KkYvsippMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HNczZDfw; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e305c2987bso62474707b3.0
        for <linux-pci@vger.kernel.org>; Wed, 23 Oct 2024 02:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729675387; x=1730280187; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FV1ZLlJ6ihzrtTWl6CBeIqu9ifr35Cm5491ANjcacY8=;
        b=HNczZDfwjAo5JDmhShhuyai5ZYYuijJ1u0CJVAJY9sodKBZTseExmMtSMrhNO7kNgt
         CJKyk5Y0Ss71oGwC6G8uUdnUo9tIpS9xSD0fQa5Fhbf3pF/GhpQezYC9YvJCg2X/gBxw
         JJuS5A8S3Rhadeum/yvr/EhmEPwuoP2zpL382APom+OMQj3Q8RiMne5m/s08a0QrggR6
         p7X6mgiFxVPOxQU94+0DKxyiEysYZLc/7HwMsfIRZcsKzgp0zFw0Nqjd3HuL4r9nSlA4
         xPMjE+5tN+i7d52jhgtGtZIwLjv1ShEudNFYNpo9vIEZE75y0SNBJvEAQWxRc7VXses1
         URuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729675387; x=1730280187;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FV1ZLlJ6ihzrtTWl6CBeIqu9ifr35Cm5491ANjcacY8=;
        b=uLcs6HczwKlmjXiMHBQX6Aw2Trzq8K3+KymX+7iljsCIP6rLjI4pi7sO69/CeYtcXC
         89UVTS58l9gCM5GGwBYUKC31gKJdtRH/nGFBSfCSBcWWegjTHQAhGg+qcA7gDpL+SOlf
         1QZShzS5VNEAOFdodwL+yEsKgE8Ln5k4x1/NmYrScVN+/BrOokbN9ZZL2pIsVQfcWGEG
         YmZuw/m2xW1ZVoa0AeUt6Afz6FWy3yrcM4v9dRaT1LQ69N4gW4fpOxjbH00LddwV4r5O
         IcxbB6u8pIhcg9nw09njzMyTCJ7FeVV0No9X4rKY/c4fmbrDpg1IL/yC6CXRKl+FuvRx
         yjCA==
X-Forwarded-Encrypted: i=1; AJvYcCULLIkI4K+Y08cRUTk69fD84GdH29+FlbzFGEFw8GYxnK1MIYDng3RyhJtmoD7qpxPi9groe+t0w40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5i41mQb/lk5dCXZf6e7c0pRBCVmz66eKnURhK4sGxL6yN7sTA
	g7TFH5U1hbAb4oJtwMl8CZUFUK/SPa+bxuSHZ3vIbyc/M6LkBIGDAyhY8srbt4vwapFrubDYSfg
	o3uBRtnVGFsRXhxBVKHVM2k2LfO90XWSHYY6V9w==
X-Google-Smtp-Source: AGHT+IGwT/XQGTi9q+W4JK6054qYIT+LVrJhEVBeHkw3KiZ6r1s0bvwN6zFNuF2/oxMRtTdC06ygKUosK4CfLjZmk4w=
X-Received: by 2002:a05:690c:2b10:b0:6e5:ac5f:9c43 with SMTP id
 00721157ae682-6e7f0fda834mr15598017b3.39.1729675386754; Wed, 23 Oct 2024
 02:23:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022-pci-pwrctl-rework-v1-0-94a7e90f58c5@linaro.org> <20241022-pci-pwrctl-rework-v1-2-94a7e90f58c5@linaro.org>
In-Reply-To: <20241022-pci-pwrctl-rework-v1-2-94a7e90f58c5@linaro.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Wed, 23 Oct 2024 11:22:56 +0200
Message-ID: <CACMJSesnFjFuUhWnM2ecNP2S-eNCT-Gx5pGF-eb748gXRNRgsg@mail.gmail.com>
Subject: Re: [PATCH 2/5] PCI/pwrctl: Create pwrctl devices only if at least
 one power supply is present
To: manivannan.sadhasivam@linaro.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Johan Hovold <johan+linaro@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, stable+noautosel@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Oct 2024 at 12:28, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.linaro.org@kernel.org> wrote:
>
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>
> Currently, pwrctl devices are created if the corresponding PCI nodes are
> defined in devicetree. But this is not correct, because not all PCI nodes
> defined in devicetree require pwrctl support. Pwrctl comes into picture
> only when the device requires kernel to manage its power state. This can
> be determined using the power supply properties present in the devicetree
> node of the device.
>
> So add a new API, of_pci_is_supply_present() that checks the devicetree
> node if at least one power supply property is present or not. If present,
> then the pwrctl device will be created for that PCI node. Otherwise, it
> will be skipped.
>
> Cc: stable+noautosel@kernel.org # Depends on of_platform_device_create() rework
> Fixes: 8fb18619d910 ("PCI/pwrctl: Create platform devices for child OF nodes of the port node")
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

