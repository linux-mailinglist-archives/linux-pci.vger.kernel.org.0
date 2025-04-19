Return-Path: <linux-pci+bounces-26281-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF59EA94321
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 13:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CD107AF8FA
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 11:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707A41D5CE8;
	Sat, 19 Apr 2025 11:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="epcTpPMC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE271922C0
	for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 11:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745062549; cv=none; b=I4EEM35pQL9J4kpgD+k2vswhubnMv4TXOFL1O4WF6uOlEOv2oVVoGDP2KgHvpOZkslmCN0wiOPI1+oTZxmllZJXbCk63+KScdgXx5WW8D3yuQIASk+8+6s9fYwb50iyJ8I2w8FUcPBivQ/znFSkHJxgFzfq+psRQVcBU3Ph5PeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745062549; c=relaxed/simple;
	bh=P9tqwhHMVnrLVHGyw0rO+0pqyRE8vhdeoUEsDHyWUwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OSmhmE9fZfjbCL3E35tOtW0Vkeb9Tq1+mf27gLiVunMAHH1qT/Na5sJOwJDAlkiAVUp3DxmLpr2RwLE2YG3VI0XKJiavA1ZYTwMQpAGlzwNNoGAErgD9VH0pQBiGeHSK6V4X+U5D4DQbMBJWG+TuFuR5vuOhI5a1W9vEaEuvfzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=epcTpPMC; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so2298993b3a.0
        for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 04:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745062547; x=1745667347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOQB0CfnACTH9btXGksImz/Bb/gsN8Vilrarvj+IkF8=;
        b=epcTpPMCecLiYLN/vvQJTDyqUw/fvGdOhoxQpnO9e259ZtiHlFzWE6+/kTwyhB8xbI
         mHYHYUjoZx4gDkxGA7cshDhto8MVCaDH7GK/Fb1mYEYVzt43EbwwgVtLHSNLQPgN//aK
         uHSnSQwgyGn0lmteiHMe0kCa9Xwm3DUAPaIAu7aL5NB3b5M3Oyt3TMT42KLchNAn6q0D
         WYXKXMQ8OWDJ2spvJ6BNuUU0wpWal6eyHLUJvB7cvbHOsv2+Ker9MupBXeT0n5PrLwA2
         lu8x2vsgD1jlDU2m+CesyCtdkT1xT22DSFE/8Nb0jxDdggAdSQ6sCNBf3phDY0WUN2Mg
         iZ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745062547; x=1745667347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MOQB0CfnACTH9btXGksImz/Bb/gsN8Vilrarvj+IkF8=;
        b=sTSoZQ3xTuv9qPOhy+7fa2j9cVEPPP8s4sHBK3OGfHaAnb9lQMTE5lqfCx/qqE/lnA
         /oHeAFNp2xxEDfmdr/Mfv02RwyVfzMixHtbxp25DoGL3VLRSF9dFJwPHh1kCPK8qMYKO
         MPNZLlPtdOkZNvRmPmSLGeFKPrEcbDQ5I0SosMQ9CwE9FZ3Hq6MTYO2sFXtaAKLBYb3O
         33oF6bELeCPcBysarylmYABdGlnub0XvE8DsBziVCe4oTgW7m4WeNNyrRv3mREWtoTEf
         8UN1MNpU1ZperlVT2mqNBrKKlYDgEgXdiuEowsup4qWG8MICrJx+SbDOjWcY6a63XwRy
         5e/w==
X-Forwarded-Encrypted: i=1; AJvYcCWROuc4hVRFgaCJTh6gTmSc3ibHuiGRL5uYjsgmSxfpi3iwKkaAwIdd2sOxgE9++vOBByb9EMkcdM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIT9Clk2VNIGxzZV6BzoydgtARBsn1by6sYK8SU1gRYD14H8m6
	0wpZQTMTXJPFts4kO6ECCc11rdpPY9H1vN7XtdaHUCtHR/1TW6DTZm1OceUmtQ==
X-Gm-Gg: ASbGncssYmkRrxkIogRO1yK8H0RhrafPs8rCx7ZuFVT2l/Vy8IVP8frNglrcrsnhMWY
	e1bciecvhCJq6gPq3P1Mh+0jkIgw1rBLv8U2nTB3tp+IpFujf0H0L4j6I12k0VaflLefvdnmyST
	Uar3d5Jnr2qUg7fJuMC6gQM2/ZRLgmfVfNibs5zf8TiPRIClpFxl3+XTzUGE7sSRCDsfuMuPdY/
	3wlsv6lLchCMgeaKMOwHgmU83USblnKy2evltI3dMVfuFvIlu5G6sfwKm21VY9d9N3c9CLbUT9E
	OiisILgX1gy2f4Min+Mb4I1qW0mR22mMMtPPp8qaQM912MA1mAoqbsr1NOUFpwfb
X-Google-Smtp-Source: AGHT+IGCM+3I80JA+fktzJ6AOpYl4TuGcM59V0sIzl9Rp8Wbr/2ZN2X0j6onHQC7TRSSw8S7bfKA/w==
X-Received: by 2002:a05:6a00:44c7:b0:736:a8db:93bb with SMTP id d2e1a72fcca58-73dc147bbe4mr6963805b3a.5.1745062547148;
        Sat, 19 Apr 2025 04:35:47 -0700 (PDT)
Received: from thinkpad.. ([36.255.17.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaa8104sm3094614b3a.123.2025.04.19.04.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 04:35:46 -0700 (PDT)
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
	Sricharan R <quic_srichara@quicinc.com>
Subject: Re: [PATCH v7 4/6] PCI: qcom: Add support for IPQ5018
Date: Sat, 19 Apr 2025 17:05:34 +0530
Message-ID: <174506248858.36993.16776911962965372493.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326-ipq5018-pcie-v7-4-e1828fef06c9@outlook.com>
References: <20250326-ipq5018-pcie-v7-0-e1828fef06c9@outlook.com> <20250326-ipq5018-pcie-v7-4-e1828fef06c9@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 26 Mar 2025 12:10:58 +0400, George Moussalem wrote:
> Add IPQ5018 platform with is based on Qcom IP rev. 2.9.0
> and Synopsys IP rev. 5.00a.
> 
> The platform itself has two PCIe Gen2 controllers: one single-lane and
> one dual-lane. So let's add the IPQ5018 compatible and re-use 2_9_0 ops.
> 
> 
> [...]

Applied, thanks!

[4/6] PCI: qcom: Add support for IPQ5018
      commit: d17ce83fec4abf4e2b11c6c2268f095e35a220d4

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

