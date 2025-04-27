Return-Path: <linux-pci+bounces-26862-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8924FA9E2E4
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 13:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F158518986A9
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 11:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748072522A8;
	Sun, 27 Apr 2025 11:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jd4oxdYl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A5C2522B3
	for <linux-pci@vger.kernel.org>; Sun, 27 Apr 2025 11:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745755060; cv=none; b=pTaGpvVoVbnJzkf/NYum0df0gDutfCbAISTn7TJuGriWgnRrxmJLXaMVzMW7eGUWf7oFk6zxeewCaHI48NU/mn7G/Fw47wPsw0fCybrSb+/gXVGNKRROMp6JsXmcYCUCeeqAgdxy5AsbUhbnjyzD35RSNlxU99Ga2xwHNosJiiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745755060; c=relaxed/simple;
	bh=PBjPcyuMpEZLQB0/vy9bfQ0v8f/kjSCCYbtmIsssx3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P/+n6TbDyjckNm6Yq6Ro8wTpjps0ENfJ6lj5Zw7PLl5hCIWvhJB8kaJszLqkeiORIYRqWAhaqE5B6/rVLVdcTP4caVt/3I9ILhiBz8R45/rzepR6NmSSCtm3oKwtsnSmaScApgkFSchMJ0VDRQzlaOE+/4cl9/oxK9MSs+cgHJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jd4oxdYl; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22435603572so43310635ad.1
        for <linux-pci@vger.kernel.org>; Sun, 27 Apr 2025 04:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745755058; x=1746359858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RUGcbbLGFA1723YUU8ZP07EgO2qAswkxsFY9VKy3CQ=;
        b=jd4oxdYl7a3NsbJR/n601htvltqlVFMHsf1khc22SANgvMJh8j2exWQ8ae0qOAFFIl
         1U9BRsmRjkyVdi6upAgIROnSo6uQ42/Ji5OW4F23kRmwl2iCzGfqgXAF1Jlm9RjgKsbk
         y0HxAI/cR7AeNNL14bSyDbnxEZrsyHW2/BLGXPxACsDmRb9RBX4/xWJWgG1zWMSoREQf
         t25BBI8L4RuEi3mBX8TzrdPLSqo2AZOi/jHNtZGXdVnmrwEjUfo3s9CkTpQoor1bdx1p
         oP1BaA5VOGId6zPlwFhfE/xBpZWVZM8o5f5mvNsAWoO4uc93jD9i+CbwjAS7zKoq9BZV
         b0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745755058; x=1746359858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8RUGcbbLGFA1723YUU8ZP07EgO2qAswkxsFY9VKy3CQ=;
        b=G/OMurpAbdihr8N676d5ofQliYg2/Ud4EzwT4c5gQQA4SGEZ+kxNXL3ZjVGxI96KiM
         qrQNAJ5H/yM6rf72As81G3282neuOol3iPWfxKkNnJ74N0uM6/vUqb72JfQTa8J0XBdJ
         3LXEGChBHigHaf826iDIq5Fk1RdmPjJZolSAt2Zk90h4UzHlE0knpPAXIKlXcrm123Sj
         F0E+4egxfk9FedjBzlI2iPMM/wF23u4qJtxaPLaV0JPUqo9ppu+DWgjmGvPKRTIpOG7B
         6C82irNqceiFl4IPvN+XtNgxMC+buBLL6OXZmGFRZTd78+j8dvTs9XtFhFI6BLjX9ay5
         BziQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUsf3mYQWKUrcXmkovI9MjCiACt7+SEeWNIkz2zwCR3cLvUxNaFVbPxC9ekicB82f67R1FcNKo1Ug=@vger.kernel.org
X-Gm-Message-State: AOJu0YyudUTtbeT2XSqRqLha4yc3WF4bYP1WsK9C9YA6mTic1dKftAb8
	sArwWtLougoolhLnjOx3lQ2dPKNphZUJjm6qR55X/nTt7KH7KTpatfowg3KKfA==
X-Gm-Gg: ASbGncuCyckMH3VC6Bp91YRLA+3jcpe2BXckL93vGSuKWdmDIkbBXzpRJy/ZVw6pmsD
	90+7V9aK2la4tDAEgV23JjTQRyg2IBrmr7JLaWm2dFQLXosQLmQOm6HaC26/9tjnZjCO34gL1rl
	4U8leVuQfXTMB92++YibSueg+3DHE/lSIClfsStKMtpO0vjjjNMUf6Eaowkj/ggvhy7KwvFYa19
	LO2GUdKz1FDTwnKL4JewWLjsPdfcmQ/0RTfafolv9bbsvbMmijOYYp7Nt2+T7OLhUFs66dGYxFX
	mI+YFicCzr1a/+xKo1bnsk85hQ3xrga7h97uNaKa1+VQGKrndaCgwu8=
X-Google-Smtp-Source: AGHT+IF5v/6Ko/fvCwFf4ZE0KXGbwqh1gFSaF2rE1KE1z2Bwiq95JPxzfmr1/BPwNIqto7+dgvX58A==
X-Received: by 2002:a17:902:da8e:b0:225:b718:4dff with SMTP id d9443c01a7336-22dbf7487ffmr128283355ad.53.1745755057990;
        Sun, 27 Apr 2025 04:57:37 -0700 (PDT)
Received: from thinkpad.. ([120.60.143.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5103259sm62956035ad.185.2025.04.27.04.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 04:57:37 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	Richard Zhu <hongxing.zhu@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v6 0/7] Add some enhancements for i.MX95 PCIe
Date: Sun, 27 Apr 2025 17:27:28 +0530
Message-ID: <174575498081.15979.12453799870165824890.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250416081314.3929794-1-hongxing.zhu@nxp.com>
References: <20250416081314.3929794-1-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 16 Apr 2025 16:13:07 +0800, Richard Zhu wrote:
> Add some enhancements for i.MX95 PCIe.
> - Refine the link procedure to speed up link training.
> - Add two ERRATA SW workarounds.
> - To align PHY's power on sequency, add COLD reset.
> - Add PLL clock lock check.
> - Save/retore the LUT table in supend/resume callbacks.
> - 3/7 relies on "arm64: dts: imx95: Correct the range of PCIe app-reg region"
>   https://lore.kernel.org/imx/20250314060104.390065-1-hongxing.zhu@nxp.com/
> 
> [...]

Applied, thanks!

[1/7] PCI: imx6: Start link directly when workaround is not required
      commit: 9c03e30e3ade32136fed5a4ab7872dcb205687d3
[2/7] PCI: imx6: Skip one dw_pcie_wait_for_link() in workaround link training
      commit: 4a4be0c088e3029a482ef8ac98bb2acb94af960e
[3/7] PCI: imx6: Toggle the cold reset for i.MX95 PCIe
      commit: 47f54a902dcd3b756e8e761f2c4c742af57dfff0
[4/7] PCI: imx6: Workaround i.MX95 PCIe may not exit L23 ready
      commit: ce0c43e855c7f652b6351110aaaabf9b521debd7
[5/7] PCI: imx6: Let i.MX95 PCIe compliance with 8GT/s Receiver Impedance ECN
      commit: 744a1c20ce933dcaca0f161fe7da115902a2f343
[6/7] PCI: imx6: Add PLL clock lock check for i.MX95 PCIe
      commit: 047e8b6b3bc3e6b25bfa12896a39d9fb82b591be
[7/7] PCI: imx6: Save and restore the LUT setting for i.MX95 PCIe
      commit: e4d66131caaf18d7c3c69914513f4be0519ddaaf

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

