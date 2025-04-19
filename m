Return-Path: <linux-pci+bounces-26280-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DA5A9431D
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 13:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D5A0189524A
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 11:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C6D1D63D8;
	Sat, 19 Apr 2025 11:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZKJfcrWy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9101C3FE4
	for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 11:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745062533; cv=none; b=Dzq18BgVLU92V1SgzsI7mKuW+eJF2O6+EnPSCLQKeGMzmrWi8vAwRTUOAady4+0KkTkKN9LrxQbJhkZuNL1yzC8BbUjNUnmQIkLUm7mgHWpC8Y979v+OvAFdNmAGlqZycBnOsGgclIr1MYfPrC3WiHs8kKZmPkEyGtQ0kf3JhMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745062533; c=relaxed/simple;
	bh=hSrFgG5GCJ1EOixVEk2PIVd25zGJ4lE+rWDW8ZzPJxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M3IhUqm8T6tyK2455L2HRzWoxdbazpG3kLrEsRErr7M7JZQBHd7pUlNcosuBfwGos9nqnPWky37TaljkwcM5x6JJ1AIBiWnH3Uo3hEJ7xtmwl0k3V6GUQL7OxGHA469QBWXuThYQEA11yLmWwMad1poiYZ581Yai4b0ADyOSkZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZKJfcrWy; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-73712952e1cso2515442b3a.1
        for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 04:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745062530; x=1745667330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EqEfCzVm0s9gbAWdrawTqBLk3GajDKRamX+SOKwoyMA=;
        b=ZKJfcrWy3rkpMfLUIl476Hg5K3R4kgNxgF0tVUEinRjtU4A2ufm548BQCtul2ppPUR
         NfGBpDS32EFgmLKz9JFlPSNQ5IX8odxklTSr+vgrC0eHQqiNFIJpIfvkbZBDsoluH/Fz
         Cjen+ZO+47bmVuMjIz/yM4E+YvW21XR4FYved5gR7jZ/fD4HJqq39Ubq5zhLU7Nm1+AU
         II+qLPV78/hjU2DswHZCXiBW5XabDx6K+PMJ97KOxZm2WIAf2XEGv+m75b39cZnlwBcQ
         cbpB/MJKYaZ487FTQdNj8EDtHV6eh3ErnO3SAhRQJF493g5dYKkzLAMoFkGQy2fGdtWs
         wghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745062530; x=1745667330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EqEfCzVm0s9gbAWdrawTqBLk3GajDKRamX+SOKwoyMA=;
        b=dgImXYsnJHOfgjmQ3+lu+rwrqeNWxUSMXrUWeQG8s9nI6+elWsXNoKDFQrugeMnOxD
         bDsSvMpSXrK8PBhGXBiqhnjwABFJum3L6x+vjYHGUh9+l7ATHidw1B/QBkkVGYTS4cRg
         SG7pyPKBB894qlDpJQGldhamulsZd0OqEXr8xXUhe8w5wbewI+OKXf+enAsCpAQjyhvj
         2yt7CpndSJ1xt8uHM7jpPTh0uaSIwvPRlt7PXh0mN/fC3CU4rN1/kz6qXId3ismNw+u3
         tPprR+QXjsZfn9fNIz0GkTknMXgFg51jQ2HsQXyq4HBEWIwzgJTzaDm+vEo8naAFeuHb
         GV3A==
X-Forwarded-Encrypted: i=1; AJvYcCW7F53Oweco35EzU3m97JZiWTpZHA+/NV4xN5s4n+W9zxanO2kdkWjGJGcYtJO6m5qBDw7kMpHQd8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4iyQCFXtABkEkGaXEV82zGbpLncIOK22bGtelOgBLofFeA+/l
	Sgm7nL31s4RU3/in2vkffyj26YomWUfEc+aGiyaC8MlnoK3LgPhymnn7W9HXxA==
X-Gm-Gg: ASbGncvX52Gw+SAB8EvWVjHb0pQpktAhCETZ3EpsAwxNGBNrOREyyOZsQzEBWDyb1Jt
	P/9JG27jYjNglx1SPRD6BahYoL8CNRYu9aqgfUMjX7MI4QNoaKn2QCiQzcLWAENtygUefTVK22D
	xmfJPuwmsZVUOzTyDcZCKulnqtZFg1EGkDWlrxZPfkL+ur0WZIXyHE4Y4dJ84TDF0Ycgc+gXINF
	URCg8zW9QQshncVbReNs+o00sqsP/JlRN4rm5vQLJKaSw96dKY1Bwud5+vZULhb7IMNgSWUsIp+
	HzGFVKbwqbkftGFGbT8Mg4Jx76aupaE22s+FgxW/3So3+QfFppM4iA==
X-Google-Smtp-Source: AGHT+IFKbXf8oiV98tgt3cEpHu3Ind6E5MOTHI2okQE5l7xhF/QuhKO27dk6PSwPkrsC8Rn2xyTTFw==
X-Received: by 2002:a05:6a20:d485:b0:1f0:e42e:fb1d with SMTP id adf61e73a8af0-203cbd4513fmr9527773637.36.1745062530611;
        Sat, 19 Apr 2025 04:35:30 -0700 (PDT)
Received: from thinkpad.. ([36.255.17.167])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0db139eecdsm2705742a12.22.2025.04.19.04.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 04:35:30 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nitheesh Sekar <quic_nsekar@quicinc.com>,
	Varadarajan Narayanan <quic_varada@quicinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Praveenkumar I <quic_ipkumar@quicinc.com>,
	George Moussalem <george.moussalem@outlook.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	20250317100029.881286-1-quic_varada@quicinc.com,
	20250317100029.881286-2-quic_varada@quicinc.com,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v7 3/6] dt-bindings: PCI: qcom: Add IPQ5018 SoC
Date: Sat, 19 Apr 2025 17:05:18 +0530
Message-ID: <174506248856.36993.6558804848056183191.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326-ipq5018-pcie-v7-3-e1828fef06c9@outlook.com>
References: <20250326-ipq5018-pcie-v7-0-e1828fef06c9@outlook.com> <20250326-ipq5018-pcie-v7-3-e1828fef06c9@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 26 Mar 2025 12:10:57 +0400, George Moussalem wrote:
> Add support for the PCIe controller on the Qualcomm
> IPQ5108 SoC to the bindings.
> 
> 

Applied, thanks!

[3/6] dt-bindings: PCI: qcom: Add IPQ5018 SoC
      commit: 5ae42cdeb1d23fc604fb6c8a23cff35a4a47b10e

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

