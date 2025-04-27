Return-Path: <linux-pci+bounces-26887-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4CDA9E41E
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 19:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23788174060
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 17:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985F31DF26A;
	Sun, 27 Apr 2025 17:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mj8FXkbf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0448F15530C
	for <linux-pci@vger.kernel.org>; Sun, 27 Apr 2025 17:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745775541; cv=none; b=pJedBWak/tlDE/dLt5f/V1JTdkI//mE6hBmsuiKSUn83oBgP0ylCLzOOXlDOier5bP+WADG8Y5MuvdGonZGZr/aRY3WdKxmJoBsnDKf3h4cAEH53LesQgJOjC2/4w8G+eY/Ic7D83lO9ScbxQbxsl1EpUjweob6+80973G6efHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745775541; c=relaxed/simple;
	bh=xlOkb+AA7EeoOdc+SBv2SlUBLZ444ktBXbA5itkBKrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mgFgJ5+FNjXxvcTu2vGH7wQTmnTahdQQbSBlUAUcMYNwfQUlZfngM5vPVI8tnuJ41oOX8YHGaeWOvh4xirfNj0ctZAYSgBgIwQx8a7lwIGbSL+E73un3M2pI/OAEfKl8Ag3Gp7X9PapV16gT1NMG9AIXXsMhWDWNNZbQUOLzOsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mj8FXkbf; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-227914acd20so42374715ad.1
        for <linux-pci@vger.kernel.org>; Sun, 27 Apr 2025 10:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745775539; x=1746380339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQlOF7pnuoHcV4tUzU9FAAnsi+yiSpTmFNxdSuCGH2w=;
        b=Mj8FXkbfunkSE18HhuzSHu4wNXue46L4eyK1um4fP0zZA+/wZIxQtCehMiy3k8HWK5
         zTr6skiGx8KaOMWhEPCIcbZYvp4qWAS2N6hgeSf3J7hlEr6HphBMtXj40hClGxVe3PWi
         2hyKdt4hg98/OceoiFc49UwHcVR++anQVqQ341lwGAKZVgfdjbz39dTyizOMXh8X2Pe4
         h3kdal2AMuWC7EKs6GbcJt8XoHrxcni9W77GGcjb6tfmk/xQxNNk2UpEUTMBUa+VX6fc
         Knm+RaCnAFhxW98wwbYvD4npZ2u0yQLpsdnm+QmFym2g4htklIQq8RhgIcpcn1TAENoj
         LOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745775539; x=1746380339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQlOF7pnuoHcV4tUzU9FAAnsi+yiSpTmFNxdSuCGH2w=;
        b=Nmh4hL8JDBwN997+ebjeC0k6s9gx7ANGLTivnfIrpjic46ZxNLQ9k/PfoxBnV0C1Y9
         5Ibz7zHwc+xbslOv/CW8XwHx/fa1q44MZe044RHZcmaLu8hubOzEVTEzeLo58SXFMw/0
         wqS2yFydNRJdHtjBQ4VhURNKttp+Hcbyz+L+/3OD0vpKm3Yau7WCut/x/YHIvTQAzVWW
         OWQmxwO1gI13IFQDxWqBUNbEn3T0F9Y4itqFDt13fIFaTV1VvcU5HB96A2xFOVgclKOj
         4zZltHiLMk74ZjWQKYP/ByoXG1fO46rnzqfj1Wdy5r/D6aiWgTP/QKw5wBiTGeTMTzJY
         1Gsg==
X-Forwarded-Encrypted: i=1; AJvYcCVGs5EAW9BYgpwrgCRPfN9LRmUZs3tbdiyhH/0iX2ifOzv3k85pF8vSY3mA+YNF/WyCs/FzmtfRskA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPxmxkQqcUW6mJ0zmgzarC5zebuVypcITbTciKYZaHmR2WWmCR
	5VqKKswkv/8RhhmFkdJgFyzoaS1DcP4+js3ktL4HcUyjN3brmVf+p1qCV/WcZw==
X-Gm-Gg: ASbGncsV1MVbjkorRDwoSNOLK/YOATiaOlZGF4ybt+Y2ps4DP5OL2BVRhI1BaEakzXM
	+hb2FWBBFhO22o5SzbSeU5RBR+qXwSRBSut+Ajv+EebsiYAX8EgDPeO5B8mQRgqiSCZ28M44iFQ
	Zg8hkF+gsnVld06r2shdihkMPBxKGV7B29Qh72cHsQOwfqpsRoAeT7F7ZwTQoTZP6/Saoi4TPdZ
	TXzvZZrDjI9uH+MK1GuwpGcGG6XDf8B+kavkHeWXgrS2Innmrr6SsfGryjakpMMgmG5oOinIWsR
	FYRk6xFDZ1GT4GcuR+mYPhX5kU/i/pKvGe1sIyuM8EC/oM+AuUVo
X-Google-Smtp-Source: AGHT+IEU5IH9SCIsyt0qXj4mqk3Sr5u/bdn7eIkZRJYO1TNJJ8pz73ALG1a7lc4tKhheycKSRkIO8A==
X-Received: by 2002:a17:902:d4c2:b0:220:ff82:1c60 with SMTP id d9443c01a7336-22db481b546mr195207145ad.14.1745775539333;
        Sun, 27 Apr 2025 10:38:59 -0700 (PDT)
Received: from thinkpad.. ([120.60.52.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4dbad7dsm66569285ad.60.2025.04.27.10.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 10:38:58 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Diederik de Haas <didi.debian@cknow.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Dragan Simic <dsimic@manjaro.org>,
	Rob Herring <robh@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] PCI: dw-rockchip: Fix function call sequence in rockchip_pcie_phy_deinit
Date: Sun, 27 Apr 2025 23:08:49 +0530
Message-ID: <174577552237.92328.3418257212908173284.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417142138.1377451-1-didi.debian@cknow.org>
References: <20250417142138.1377451-1-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 17 Apr 2025 16:21:18 +0200, Diederik de Haas wrote:
> The documentation for the phy_power_off() function explicitly says
> 
>   Must be called before phy_exit().
> 
> So let's follow that instruction.
> 
> 
> [...]

Applied, thanks!

[1/1] PCI: dw-rockchip: Fix function call sequence in rockchip_pcie_phy_deinit
      commit: 286ed198b899739862456f451eda884558526a9d

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

