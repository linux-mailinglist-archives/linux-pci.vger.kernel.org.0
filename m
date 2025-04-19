Return-Path: <linux-pci+bounces-26271-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B891BA94201
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 08:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF8F7446F43
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 06:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F7216DC28;
	Sat, 19 Apr 2025 06:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CjYh+aDd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E312A86338
	for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 06:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745045705; cv=none; b=EgrnOi3uKLw9dyEbF6J4y6rhpbTTrn05FrwwAFX1tA6Jm93oy2UgisXpazZtOAQbWzAGx+KBk8RsUeZ/csZdBiwhgXSQMdg1jl7QzstOA4ArZpI3osrsVfaNKGBNBbj1aBQkSF/n6iGZD3ChVQXIuLCarebO131w+6sSIyYvxLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745045705; c=relaxed/simple;
	bh=7V8yw5J+1i1mhYMW7TfQ/SiJZ+3ro2qr9nOVTet9OK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZNWm9y4UOiPkhrhb5IQwNhRW28F3MuMPd7XY73c7Mr52WXmUvsUhhzgkqpb2RCJ8EewXsVBzz0leBCkrAcgvJkp/xK+bn05eJwekTUK4XarZAZ6j7AzdCG+8FxCbuPQ4ZxmPUgBRkVGu8z+Agh4o4gfLVZOsVYr7w7LnPq8/Ebg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CjYh+aDd; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3035858c687so1877193a91.2
        for <linux-pci@vger.kernel.org>; Fri, 18 Apr 2025 23:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745045703; x=1745650503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TICD64AIOfQs/ZYDCIR8qIZ9IkU5scdShX781+egCtQ=;
        b=CjYh+aDdsGaFzFCww/y1+WE/ILdbPlvJIS4u2LADV5HY5o+/yePU7RAFGHDe13afQh
         tVOYTE7fVZPkhuP/tpJ3JPAfDNOyfqw0XvvcoVx9bNx4pFTJM7b6m+5SJN/G75NXLf+r
         qOazSH9n1UMrg4brq7ugh/BCbI5SuFpPw58N2tXt6a+Sd9nxM1/fq9s+3S57X9CO7TqJ
         ovu0DcEMQXqsOjur2i8yilgdfk+3N/TTxA1jt1/Mwr5pUmSanLFOGNBOSPLdq72LXcS9
         SdZPlr1kLCq47CpzYPJXg2uV4TGsotzdVStTxMlbGVY4FdggR+C/feORJ207YYUCCy/t
         lQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745045703; x=1745650503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TICD64AIOfQs/ZYDCIR8qIZ9IkU5scdShX781+egCtQ=;
        b=IGlpP6sU91YP7E0XuauEq6Hn+kLvH30j/3+v0oVWyNfejhA19TG1wBu8uD5t2kYipy
         X6huRK948PnltILVudmpPiSQjN+Y7q6DA6rhkccQgZncPMIgQ4cvnD3NGa0htI/Eox41
         JdY0cfXtjkhMJYg9kkHJao1gJqlGH9lpVjiIKdNxxgplTui0g7w95mFtrbLJue1dOxr3
         rvJ1vp9aDCGOHry3TOod3GKyX7RKA34HeVxMKQhpuanfhJVmcRP74+yrFa6V6Mcx0pCm
         P++Rq2RhLX/AYR806FlM4TdpJJO2OkPQCYdVMAbCrV3Jlgl7IqIgZ9b98kCD5ENDEqmJ
         hZvw==
X-Forwarded-Encrypted: i=1; AJvYcCXZciLPN3uBNm+S0YwHYGXIlLlL/9Vaxvdh1zjzrSZEU2sJPBORh9+K8Ra/si7wlsfiR7WZAkTUL3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwerwP80g82ivd/oi4UbpCc9lIFU2qVpm8YrCUmXSedtHuFxrX5
	DnEIZBB8emgPuxSq+vVDBr5NuQoUYT56+I2Oger4cVCgFRraL0o1hLkSvzxg6Q==
X-Gm-Gg: ASbGnculD8fb9cjB47Ps3mw2QlVYyDDH8FZK0CxZ44szl3fYkDPvVI6NfbD/sTDG0+M
	eJnjEfxlK9ngnaNHN7HROIrwVz62F7noAj6VzPgr/MhwXfeXpukzeaAmYx0pPST7kfXSDZHdQU4
	eXmdYo0KT5oVxG9EN67NQ7A5wuLwZDjfGVvWJe4MrHVjmyiL622bs/LBfgWyNaPTq/bd96bCQng
	6bzZRhYl0oNLP3VyK46XwmXoQwXPjKJ3G2j/sbQp03H3OBs8XbuF1KOwcZuZB7kTx0KmeyUeVdK
	g5MbVYxhGzpr1jGUeSmeA+WrboIPnULtiKHMr+gCTFukB4VnoDVBxQ==
X-Google-Smtp-Source: AGHT+IEF+s5cUaANZHoNtJTxHRWI2o+ROo6OeQ0i0fU+x5mBKy6gzJ99hJDGFllQSCcfHn9Y0iJK4Q==
X-Received: by 2002:a17:90b:5827:b0:2ee:f076:20f1 with SMTP id 98e67ed59e1d1-3087ba53cd7mr8741809a91.0.1745045703223;
        Fri, 18 Apr 2025 23:55:03 -0700 (PDT)
Received: from thinkpad.. ([36.255.17.167])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087e1149bcsm2380251a91.41.2025.04.18.23.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 23:55:02 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	quic_mrana@quicinc.com,
	quic_vbadigan@quicinc.com,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v9 0/5] PCI: dwc: Add support for configuring lane equalization presets
Date: Sat, 19 Apr 2025 12:24:49 +0530
Message-ID: <174504563258.14560.1691218790091373846.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328-preset_v6-v9-0-22cfa0490518@oss.qualcomm.com>
References: <20250328-preset_v6-v9-0-22cfa0490518@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 28 Mar 2025 15:58:28 +0530, Krishna Chaitanya Chundru wrote:
> PCIe equalization presets are predefined settings used to optimize
> signal integrity by compensating for signal loss and distortion in
> high-speed data transmission.
> 
> As per PCIe spec 6.0.1 revision section 8.3.3.3 & 4.2.4 for data rates
> of 8.0 GT/s, 16.0 GT/s, 32.0 GT/s, and 64.0 GT/s, there is a way to
> configure lane equalization presets for each lane to enhance the PCIe
> link reliability. Each preset value represents a different combination
> of pre-shoot and de-emphasis values. For each data rate, different
> registers are defined: for 8.0 GT/s, registers are defined in section
> 7.7.3.4; for 16.0 GT/s, in section 7.7.5.9, etc. The 8.0 GT/s rate has
> an extra receiver preset hint, requiring 16 bits per lane, while the
> remaining data rates use 8 bits per lane.
> 
> [...]

Applied to controller/qcom, thanks!

[2/5] PCI: of: Add of_pci_get_equalization_presets() API
      commit: 2f12e20457a27599b6e1e1b0f08e6175e37c7e05
[3/5] PCI: dwc: Update pci->num_lanes to maximum supported link width
      commit: f1eb5da4d28b3788049ef98428b395fbab3478fd
[4/5] PCI: Add lane equalization register offsets
      commit: 165d80061e771390da26a29d362ceff96ab75da8
[5/5] PCI: dwc: Add support for configuring lane equalization presets
      commit: 3b35b43825f4e906d46519908dfff76a58d58bbb

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

