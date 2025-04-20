Return-Path: <linux-pci+bounces-26296-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F1FA9469C
	for <lists+linux-pci@lfdr.de>; Sun, 20 Apr 2025 05:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 319073A2936
	for <lists+linux-pci@lfdr.de>; Sun, 20 Apr 2025 03:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7387A3B2A0;
	Sun, 20 Apr 2025 03:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eNlxmfaN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDECC2AF19
	for <linux-pci@vger.kernel.org>; Sun, 20 Apr 2025 03:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745121468; cv=none; b=O3RYZAzh56bj5MZkrNycjYUn2stOalKJy6w/PTCFuK/IZZEbZeLqo7SZxQYk3D0Mv5QK332kEtfUEewpTGDSxSgP3C6FD0xU0U8cUZTPnM+xhOs2NIjG/DKHQjGbxAHlWtLN+481kGUSsmWOnX7UPgUY5ZGxLYwwFEmpA0HeftE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745121468; c=relaxed/simple;
	bh=PnU5VSLjWELsGb55dW1Y0Mr//1GNiwQfxXI4Qvxz49o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TGxdhG13mYSGlwix74rMETSWIssHYMxJQhMqVXoMg5OBAVInu9HpgdYDtbsyCSFX6XV+3G7X67qhYCunVsdPDo4Xrqk3pk+cVFY3pIFAr3/1F924PyV5ovjWRR75wkPR9ZXGA4z6/I3hh6u146SzZP5MoqM1pztL7DTE9aTLaGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eNlxmfaN; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b0b2d0b2843so2248315a12.2
        for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 20:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745121466; x=1745726266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d05aik5hC6LDlC1wwpArorOkpaXXSmFvs4JQTlxeA8w=;
        b=eNlxmfaNRnpovhlhP+Y5UsPDDcctj/PZEofhDfrnzj3oJNlv8pwh80EoBrTK97xZN4
         jU2Nx+ipPrgpUIWLUhFQ8qnBjJAj/IiKzfY7pkSEeZzhlcQra4wlq+PES1o2hVtGvB9K
         UlPqAkVCD7tvE8+jmbfndI5nO6nNBL6dg0LneRYWQwchTX4WVIMtRw/8dS6WzL8so/r2
         IyAIglgIM4FFunCPw+zxhyAXzLlqFee/ZUwAfrxgsQs+SmDmPd1fwvzD7gjeVuxSXKsd
         f4kw3Uu1XPGylI/EGp4pCuG7ZGhP2vRsQEX0l2VAKGakMG+A9cm7caTw5zbIf5R/GDSQ
         WIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745121466; x=1745726266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d05aik5hC6LDlC1wwpArorOkpaXXSmFvs4JQTlxeA8w=;
        b=IrcIQNRzMEJbtFiaU6jdUgxOpye3dCh4baFFem71pFN5MkzhLi8ZbqfxsvLYZwgpZo
         YivZE5M+hjCoUqw8OclRUtQdcvSP2xrVAQmlKaYV3vqT/2QpxqojVNn1u8MqC8dxfpME
         CzmFhrnQGXbB2xKs3dFHSNqgtEGAmwtQmMYZUQlOPxAU930u8+LdqUgDLVNBb9wgi4co
         O1v7pHuDJfpsRhhTYJMWIwXoslF7eccqYTVuFEgPGH1d2XakatisbMZDXHB0lIKeI4EF
         MZYIIYWuzn51NDiCmF4Mh4CBSCZRAQoyqgveMcTZ4n6nKwfyUncnzP5SrJ6an7gclTLP
         ijLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDZvoydxIwDOSOu4ksDUXEebdMEWkqcNDEaUZVzpPkIlkAQtPEN6pR76Ge+9lQbhBuILzyjSuBQic=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEL8iRa90nSAaMEPGyK2xvcwG0/ashW3JeKXsA32RCXl0iOoD8
	ejt2zsQgc3VUDX1Q9VpJ6eEtUrimBmQlaSeO9WIgt0xHc8KlisS9Q9pkguWFF9iMwreUMEgmQtw
	=
X-Gm-Gg: ASbGncuD9nsY5mJ8CIWNY/7sv/eowOtFwEcqlDh8ZOzrwUYOGut23y2w4OGPJVp2t+y
	hKUFqHGmOk/7mnTw7HT3vEsyJsWMmyp2gwgXq01eJ2/iKrdhtLNiamYThqsJn7t7MYmH+oh6JVQ
	uI5Wpf1JPYilHo7xy2tI45E+/RgPzkXNBQYbvJA3aAWKELiVHftWQxyPN1ZyjQvf3DPsFW4Tw7h
	8QG/G+ZAbxL7Ev0syTU/t9zXmETreVwkST4cZxXwrhS9oiizy2NFMuVkS/yQtth1qFWYqCqsKWG
	YLbXH0JKcYsQ68jOgE8qxXS8guUcn5eI7dDN0aZ4tvJ4wuRxv6+i
X-Google-Smtp-Source: AGHT+IGqRmfFnfaKAG1NQHv5VKFPsQHr8AgFIidnjypNgyYAdT7Q7hhn0ht2DNSI6WuV2LK9EtuJpQ==
X-Received: by 2002:a17:903:1a30:b0:224:1074:63af with SMTP id d9443c01a7336-22c5360c9d8mr122251965ad.34.1745121466025;
        Sat, 19 Apr 2025 20:57:46 -0700 (PDT)
Received: from thinkpad.. ([36.255.17.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb4ba5sm41382555ad.120.2025.04.19.20.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 20:57:45 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RESEND] PCI: rockchip-ep: Mark RK3399 as intx_capable
Date: Sun, 20 Apr 2025 09:27:32 +0530
Message-ID: <174512144432.5058.6969526836746985984.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250416142749.336298-2-cassel@kernel.org>
References: <20250416142749.336298-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 16 Apr 2025 16:27:49 +0200, Niklas Cassel wrote:
> RK3399 can raise INTx interrupts, as can be seen by
> rockchip_pcie_ep_send_intx_irq().
> 
> This is also in line with the register description of
> PCIE_CLIENT_LEGACY_INT_CTRL, section "17.6.3 PCIe Client Detail Register
> Description" of the RK3399 TRM.
> 
> [...]

Applied, thanks!

[1/1] PCI: rockchip-ep: Mark RK3399 as intx_capable
      commit: a7d824b2df0d8b9e19c334594cdbffab97ff8d66

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

