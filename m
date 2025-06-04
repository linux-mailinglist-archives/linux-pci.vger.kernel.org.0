Return-Path: <linux-pci+bounces-28963-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE0BACDD85
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 14:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86CD03A5E0B
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 12:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E594528F518;
	Wed,  4 Jun 2025 12:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XBHP5Tl6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A04A28F500
	for <linux-pci@vger.kernel.org>; Wed,  4 Jun 2025 12:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749038931; cv=none; b=UbT0ztWpAdiZ6P1a+3C1dmzU9W7MuKnKhffffvPhg6FOFp8CJKm5Z/nMZE8cNPfXTSJfD2wUMgZ2CihRzCAE8yMFWbY/xSlADlt3eISrwPAjYs1rRupFm+Tl13MS9iGGxIV9KGwYYTq7ZDELL7+oLk3o9RfI2Z5hzfd8DPYADa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749038931; c=relaxed/simple;
	bh=JN0Vgk9KPnL+EATlO51MQ+wdhcln9wimpUD//DwZ7Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GzUWuQYlxi46ePcOFXqt4q6ah9bxUQA7ocARfzGODNgO58DajaE7wHVYBNO9j5Z1idL6MBKsfr+njNk+GGUl29lK14kH6FhDuedKgGbpCev0ybUeD04qRTyRlSanSwwXEj9/EyvzWXy0Skw8QDP4mLUfUc9MqD2oiTWkjFg4SRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XBHP5Tl6; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso5099911b3a.2
        for <linux-pci@vger.kernel.org>; Wed, 04 Jun 2025 05:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749038930; x=1749643730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63gUF31R/njodbawtioVjbMgNLq35VUnPeZiigQnoG4=;
        b=XBHP5Tl62ppMUCi92qAnrBB2yXKx/oKJPBhoW1Cab3BcRBPibXkh/4nVs/8YBgLOul
         u8JNgbvJlj1vJm6xyIGjCWXfAyOG2S2Splbit86SmQuikb97QYExH5dM/bwd1FXAsQIc
         zQamA5y1Rljz3Q+X2DGaeFXzB99VGenVMSSwXcmumGJHdurSNFAfDipkBvp/tewDFyb2
         nYvA1LUK3bpW2bjsu8JQVVU2mIYzIMSxr3ciPuzExbqQ5OqQnJlS3FiAgthIbK5TFslM
         3hEXx7k+OXWOM2pw99QrOfsd0HbNenC7f6hUvmI4A6Xheu6sR36s5Gw45sf6BSMkpb8V
         YtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749038930; x=1749643730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63gUF31R/njodbawtioVjbMgNLq35VUnPeZiigQnoG4=;
        b=hkK/1VAhT3RV3DHXVd39W8zXnuSmtE25LdppKC3Bi+FVBQA6SYUkKHck3z1tMeruYt
         oW77O59pmyKVLiGAOtMBXGxjL1XxO3T6cTDP4942pqbD5KKBldPgLtl1HIfe+Kqbbr/0
         XtU9bM605ULxQhebwAlDb0XKvpB0Sd5p6mUy4lEBCJIef5kdGeKI3TmhzRMY6hTKQh6g
         cGjaNnnZ4bp9DODl4KD/qykIY4jZZULpce8/5xX5Qn8qJGMP5OlCaUhU7dqYg+cb9Y39
         G1xvIJloNle6jTNQ3MBWC8OH1cMkrjLigtJlo7usYesOFeeyIul8n1VY6WOxc2jHh+zG
         1mwA==
X-Gm-Message-State: AOJu0YxdCw5SdZ23gqyULeER/Z9i9mLoe0jPPmLOfQNcVwQT773+Ldkl
	YPHjNmMwgKOteydPucZEuO+EU5xZ58daASQZPIFqBTxBtcCh+hM5Jvq5G18AlmaIfA==
X-Gm-Gg: ASbGncvz6M0tIaldGFtuCwN6kzwkw3hWCVWc861c2jQOpOjwo8Ins0cx1QiV7wu4xmi
	/kbOiDWJAKnve1JXODXT5voDWf0FEzLsAgJMPhirzzAbjEFlwCC/SUgcPKMPaDUJReIH7tNC7NZ
	tQ65P952wC9KTia88NatOd0GgZDedeUaB/NQ6SSBb1AVXUB/x0BRYkHBO1sHGfgjweCKKySmtx7
	9a5BNZn9IZWFvrQqPAajcydqQ97xaJnrMXK++6YdBdfFhDDZacBiSwQa6Yg6VrbY8SDa4jSdH+X
	K43nVKqonTWxK1cK/MOL6SkU/q8nXE6rUSEUfAv5l+QcVCDCNpVG5i8AYCNT/cb+tbbkbp4Zty4
	=
X-Google-Smtp-Source: AGHT+IEI24fmQiYs+KkyGzQenyiA9iVsVnj+bFctMQWy7u0aVJs7US/+jOggPfA1S66IRlVRaTETtA==
X-Received: by 2002:a05:6a21:1:b0:1f5:8dea:bb93 with SMTP id adf61e73a8af0-21d22a6d45dmr4274308637.7.1749038929697;
        Wed, 04 Jun 2025 05:08:49 -0700 (PDT)
Received: from thinkpad.. ([120.60.60.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affafaebsm11034942b3a.87.2025.06.04.05.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 05:08:49 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/2] mailmap: Add a new entry for Manivannan Sadhasivam
Date: Wed,  4 Jun 2025 17:38:31 +0530
Message-ID: <20250604120833.32791-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604120833.32791-1-manivannan.sadhasivam@linaro.org>
References: <20250604120833.32791-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Map my Linaro e-mail address is going to bounce soon. So remap it to my
kernel.org alias.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index a885e2eefc69..1e87b388f41b 100644
--- a/.mailmap
+++ b/.mailmap
@@ -458,6 +458,7 @@ Maheshwar Ajja <quic_majja@quicinc.com> <majja@codeaurora.org>
 Malathi Gottam <quic_mgottam@quicinc.com> <mgottam@codeaurora.org>
 Manikanta Pubbisetty <quic_mpubbise@quicinc.com> <mpubbise@codeaurora.org>
 Manivannan Sadhasivam <mani@kernel.org> <manivannanece23@gmail.com>
+Manivannan Sadhasivam <mani@kernel.org> <manivannan.sadhasivam@linaro.org>
 Manoj Basapathi <quic_manojbm@quicinc.com> <manojbm@codeaurora.org>
 Marcin Nowakowski <marcin.nowakowski@mips.com> <marcin.nowakowski@imgtec.com>
 Marc Zyngier <maz@kernel.org> <marc.zyngier@arm.com>
-- 
2.43.0


