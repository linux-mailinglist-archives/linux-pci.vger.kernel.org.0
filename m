Return-Path: <linux-pci+bounces-26275-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB974A942B0
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 11:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BD1319E366C
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 09:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025733FBB3;
	Sat, 19 Apr 2025 09:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tbH3kEGF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811A71BCA0E
	for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 09:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745056441; cv=none; b=ds/7i79cfzJ7au3gsUw+Pv2eQw97+u+A1vy7S0AMsFxrxOR7BbdHQrCPMkiZKC6SVELEcSQcmxqPwaoOaENfM1G+BaCu+qq4flV5pTtTLn3w9DdotGH/RyBlgrJq5fbWCcAGUleK2qbvyXbT579wJNnqVi/iHTZggMAI6fy0Afs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745056441; c=relaxed/simple;
	bh=ILbRT/qRg9I8w+76+daOLvD2JyO9K0fujjCnP2kSBRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k/jipLabbux73+S2+66pCQxA6IKikMx8N4DtKkgIwq1a6YCSlGL0J6t4DRpWS7FwlPhER5qxXFFV7kgC6uwu/BDOkVIV93tNVLZdpXZF5NL00BgTqrQ8+ESTPL3n0k/tytdzKfF2kmBQAPv8v8vabD9SpzWrmCr7mqCjg4mHY2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tbH3kEGF; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-30863b48553so3060675a91.0
        for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 02:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745056440; x=1745661240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9yKVzIA+FhMTC4rrM4hDlH+jkyt/OHi/VKWuwVsMN8=;
        b=tbH3kEGFBukkIE3DK6NLzjyBiKq27mDo/fNqIZ33TQPrgHhbfk+BX7YUdYQ+3gOJmy
         /22UY+j+OGrnJoO7awla7VaMvuOw8vM7l8l7ty5StU9h0hGdv05Mk92+BAADaZt/UEsw
         YYv8XWHO33pHS05V2g8gBrfeoBbOPScWk+zalFi2DujPN34wHvH0COZyuFCmpxs0oTVf
         J4RnpK4TxlWXCQL7s5yxGucLDDGcPLgzEylaxw5MMLy/lNjj9R1gCQjHciQcJVfljXv0
         qLuASlUBGq6rooxjL/xX60EC9CnaY3hbuRlsOK1HZZPQbQMi3bTykrmdkYCGVlol/ea/
         MYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745056440; x=1745661240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9yKVzIA+FhMTC4rrM4hDlH+jkyt/OHi/VKWuwVsMN8=;
        b=HQJTKXbH3yySUQyoER2nH9s7sigMJpoAZSy4nuRjVrDB4V4YO7TyIFyRl51dhQ4sBu
         9x7SDqF7bu8sS7p1FLPjNmX8Ml+mBbQ4aF9iuf/bK13fHyXALvj1adyHAk/osBgEXoQz
         UT227oRrCUtoPgYXT1u08StzFI2jUSZIxl7Ro3s2KWpfO5Cg4T/H0Iiabsj8qoPu6Ljc
         EyAz4BeKRfXlWKjAqfG5p8lwKZmTOEuQsG5YAlVRU96KG97MPGNalPDcUsLdIb5ORFK7
         tR88BRNfKD0fAXZ6I474QM9rk2YQfzUfNvZBtSDPYJN5Cona57NMwxvgt78KR92s+3SH
         oZGg==
X-Forwarded-Encrypted: i=1; AJvYcCV3/COwcHeJxeEOFgCEnNPopGEHOA7ZBkjYXlwCzjVGb0obn132s2eq4Mds4A+GbE/eaxhn/ezXxkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYp93DJGrHI2+lgppP+oD6C/06N2c5wCQz8sNPKX8tA/ozGz1E
	JAB73kDqtpta4t+d6yXVlvzLEHGdL/tIqkdlh55G3AcdSB+X9vVTRQhWMoQN7Q==
X-Gm-Gg: ASbGncvtYvaJljQ3ZhjMXt1pkoqgXyc+o+CNhfm7Z+37SfpvkqQ5TAXy+xU0CTBBkhF
	zbTUD6QEeeFRHsqiVeQPnGrU9hnWhL+ycyu6AZZ2ywI7JEJbWMhOCBgmXiZpWrLYRifGQiB5asv
	QN0B2qdZUe+hENX8aUXiw/+C6Kku8oghGtuQD6fVUnm6OZrK6l8alOZ9/EU1360ZCqY6sIxhale
	iUUiomxIUcav3CuVeylWDIFfknOxUsGWTkGrgd3cXkVm4pLx5/qWEmCjBOh1UaYAv6Aq1D/uBJp
	PY9P2zX9opHDnGd8YHywK5BRyTCwk93uyLvF3fuz+Y2Y7xY+DG8TIQ==
X-Google-Smtp-Source: AGHT+IE/nEJy748pRZBsgQs1pUuc+KJsoas+6d1SDGbI9MhgwRJ1z7aHS2ich2UbQnlsP6+skuAA/w==
X-Received: by 2002:a17:90b:524d:b0:2f1:2e10:8160 with SMTP id 98e67ed59e1d1-3087c36108emr8133093a91.11.1745056439818;
        Sat, 19 Apr 2025 02:53:59 -0700 (PDT)
Received: from thinkpad.. ([36.255.17.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087e05db51sm2695542a91.43.2025.04.19.02.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 02:53:59 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: heiko@sntech.de,
	Kever Yang <kever.yang@rock-chips.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-rockchip@lists.infradead.org,
	Rob Herring <robh@kernel.org>,
	Simon Xue <xxm@rock-chips.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/7] dt-bindings: PCI: dwc: rockchip: Add rk3562 support
Date: Sat, 19 Apr 2025 15:23:48 +0530
Message-ID: <174505638863.29894.12853512494056448618.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415051855.59740-2-kever.yang@rock-chips.com>
References: <20250415051855.59740-1-kever.yang@rock-chips.com> <20250415051855.59740-2-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 15 Apr 2025 13:18:49 +0800, Kever Yang wrote:
> rk3562 is using the same dwc controller as rk3576.
> 
> 

Applied to pci/dt-bindings, thanks!

[1/7] dt-bindings: PCI: dwc: rockchip: Add rk3562 support
      commit: 1d6d956497ded6ae02faff74ac493adefddc2c73

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

