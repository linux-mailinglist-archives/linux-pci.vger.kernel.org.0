Return-Path: <linux-pci+bounces-26886-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA69A9E41A
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 19:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44EF189C0A7
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 17:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBE91EBFE3;
	Sun, 27 Apr 2025 17:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MC/M4XRb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E221DE881
	for <linux-pci@vger.kernel.org>; Sun, 27 Apr 2025 17:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745775068; cv=none; b=AjMzGALDlQAKTl6utGZGnroez1+9xq5U5hxsitNkbuZ6QilJjMC7g449v0PvBRJyqGAIl9PIp5xiSEkbjCQGSxyqm8Ly+m3AHPy0z9gQXO1ELjdW58ORu1Jn942M90tsVbV0gotAMJXNwhYuRkdY3QvJhbzgvYZ+DHo10CuipRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745775068; c=relaxed/simple;
	bh=MV8BXgH2DrsVfLUkF+qFTQ43T/1n0584JK4ESCera+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=csOlv2ppqiRdvBdNoAdfeIbVAp/fGjQ/N4dvZcoBoTub9IEpnZQYE6nHUjEPwEbN8pPfoJAQ7rfsd3An2cE7c0gXnAvl/Ffk4NkQFu2SfM/Qaf0E/YtcLJQw2ef+UDDm3APjmqGer/zzHqNsxvXRIuSB1EQH3ELO83aQQP2sPLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MC/M4XRb; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-736ad42dfd6so3375272b3a.3
        for <linux-pci@vger.kernel.org>; Sun, 27 Apr 2025 10:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745775066; x=1746379866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SoBsemGgaytW/8rZ1RitMi6CJ1WOvsFRPpJ+sFYMGyg=;
        b=MC/M4XRbuGfRcx+oRPjmBuCHZGuqLOOokLGuaMShl1DkEGRWjxrqlAfljhnkpNtbdV
         V1+qglpTJv1+FWv0iJGomYKYb+5ybf9z4Sf7mJaYoo431Hq6mA1GDM4PL80eKRECu56A
         JIF81j8mmgOHoni7FKnRKAt7x5UelqSoL50GpzP/cPSJbwuH9m+KcW+NyCwgW51zYiH3
         yU340Ox4e6H8aAsf9/TV3rMRMab/nKcfE/aqn3gioNM8lC1EbhJKKVgiSCIjIvkzBCuW
         FpXlqfLGDhnkXfXSpXeGvoMPh/mEcDSyh5HEpk10v4MjY7N1SxUDBdOS6jc6gQgcYAPc
         x04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745775066; x=1746379866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SoBsemGgaytW/8rZ1RitMi6CJ1WOvsFRPpJ+sFYMGyg=;
        b=ghhdADNgdJ3A8TzqWT6fDoQy7uWljyGuPM2TDQg8fl9SjRNrO2q4gyZaBOuYAZJRsC
         Ap7fcwkDJHuxV9dkL2/Y166m9JFvKsMj/g9ofuE7DnE77SAQ7agL4xrAJ1wtvF4tMWSi
         uMyWsqgRCDWgdtjyUQdGAThq+Kzp/6EjRg0XgU2A1caTguqRiTSP/h86lC8hm68b11TR
         nwNoMPYyFUhziAE2GoaRrJgBuyAXoZUhlobl+ptjqMV7Ox/euwFETH8C7M+fqVFOAtnY
         nT7e8hhgynEAj0GZBZ4kPHeKrVGBWU3qQ2BL1uaHK7vh1oRCFvHEx3OMGTpnUYzG0hA3
         D+uQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHCQ+fDQJG+HC0OMgqhwI0XsrzFY16nasMnKc0Vc4/ukIRqStG1LL+QA769q2tRZ68Uvv/Ax14rdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy39mhVKTvCV/hAPHLmctn7hlbOaxfvdp/zS9mVBz7gPfl1s1gr
	AZOl9ONfaN4fsZ4qOs5rpr3ihHZ5CMVK24tylm556tBNSV3p0cvxpwjU2EElVg==
X-Gm-Gg: ASbGncuMXLzkIws/nOsJkYFL6rcMsJk5MlV66Ky9aiaF8ov0mfryLFkPTWZ6Trcn+iE
	YZsDcM9Wy6TEkPuCJgXQ2QD/hylMIHFy7kuFew2hFp7genVJqsyJfNlQnHkOPWd0REPlAR2QhDZ
	AucXzh6lOOTjEjCTTk3DSecE5ruh72XfEUsiPs1kNGRvgY4+63Y0CoZhUOWqh8uKq8ortQXoN7A
	xlALylcna6rMDJqH4yGZGV6ib2Zakm+OBDK9cYWuTMHWOjKFFgUhwyvsaN3GV2nAnG/xcHgoxHU
	1+2SXF2xkQ3F45V1v4tAAcMDPy/Fa3jtqi9yakvUvlvowUV/IqGy
X-Google-Smtp-Source: AGHT+IFvoBhvOQtuWsxWf90w/u7lLk5I5p38IZQNxar5PLccdleT2TxPb53uycEjiK2wT5Hb+izfJQ==
X-Received: by 2002:a05:6a21:6704:b0:1f5:7ea8:a791 with SMTP id adf61e73a8af0-2045b6f78dfmr13244374637.10.1745775065819;
        Sun, 27 Apr 2025 10:31:05 -0700 (PDT)
Received: from thinkpad.. ([120.60.52.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25967766sm6414771b3a.82.2025.04.27.10.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 10:31:05 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wenbin Yao <quic_wenbyao@quicinc.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	krishna.chundru@oss.qualcomm.com,
	quic_vbadigan@quicinc.com,
	quic_mrana@quicinc.com,
	quic_cang@quicinc.com,
	quic_qianyu@quicinc.com
Subject: Re: [PATCH v2] PCI: dwc: Set PORT_LOGIC_LINK_WIDTH to one lane
Date: Sun, 27 Apr 2025 23:00:55 +0530
Message-ID: <174577504939.89301.2622778096391890243.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422103623.462277-1-quic_wenbyao@quicinc.com>
References: <20250422103623.462277-1-quic_wenbyao@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 22 Apr 2025 18:36:23 +0800, Wenbin Yao wrote:
> As per DWC PCIe registers description 4.30a, section 1.13.43, NUM_OF_LANES
> named as PORT_LOGIC_LINK_WIDTH in PCIe DWC driver, is referred to as the
> "Predetermined Number of Lanes" in section 4.2.6.2.1 of the PCI Express
> Base 3.0 Specification, revision 1.0. This section explains the conditions
> need be satisfied for entering Polling.Configuration:
> 
> "Next state is Polling.Configuration after at least 1024 TS1 Ordered Sets
> were transmitted, and all Lanes that detected a Receiver during Detect
> receive eight consecutive training sequences.
> 
> [...]

Applied, thanks!

[1/1] PCI: dwc: Set PORT_LOGIC_LINK_WIDTH to one lane
      commit: 1f7b788a088ee202ecb2eada6bc34d38d63fea19

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

