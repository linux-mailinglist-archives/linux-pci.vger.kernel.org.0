Return-Path: <linux-pci+bounces-26282-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D4EA94324
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 13:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF71D1896F85
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 11:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152D81D63D8;
	Sat, 19 Apr 2025 11:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tY6MTNu7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8126B1D514B
	for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 11:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745062766; cv=none; b=CWiyy2U2kwXamcLRVpGySGhN2m5lfhfzgidCSwOS6LSJ2eQ7Eyz/1nkqhwl25K1iGe+hikLnp06+dNA+Gnz30g8ZVNWYNaUBEaT+L3E3oMy4Gep+98fN7V3wk6Wq2EGVrYSeGfpj1Avj5bxYT3pSt84yXpnLwP8P1YF26h2JcyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745062766; c=relaxed/simple;
	bh=2A2UVdf1mOcrhJ3bRj8He0+tcBB9zyGlXLSlatqP2BU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JbvwzvVxq3OTsKxewOwlqsWnjWLWiW+sbujFxvBYALHtc1MS2z7XARNmCUKy8P93yPumqpBYHLxvGa5Orgow+ixpsuXv6jIkv95k0d6MABrlqwLWo4k/yqaMxmKys6crnH04L8bXvS8l85DMuo5hy+Q1OhlKMb5mOuptAXWsycc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tY6MTNu7; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22423adf751so28779675ad.2
        for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 04:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745062764; x=1745667564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naTUGcRXI+92SJRUmQQLlU7HwQfEquV8J8DD6ubm8Vw=;
        b=tY6MTNu7/6mzKzOBarm9fKvJYplmrU6vun/LaZwV6CjFV1gb2kOMidgZAMwoXisBia
         R7ab43bojby/NbCf42GB9hB6fXyykw57SRuRjodS9aex5OAiAS7NyrZrvaoWk2V4k7KB
         a+RMkrHtkGVgdajCbk++GF5Ab4v9GYqovBPUC+3oHVEIo9gBk7ECnZmEQRVMUqlDNOya
         yEJShJUiWM09M5N3Glmq/oeMobVayLEaPvHnNHRKewGKqYDNIST+2UYnZKM5iHRw7abE
         AWUo6YL2XqwpxglxJ1a2ryOrIq5Xmk8BtRctySVoLh535445hxtx4JMQI5ooDnhaJphf
         XOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745062764; x=1745667564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=naTUGcRXI+92SJRUmQQLlU7HwQfEquV8J8DD6ubm8Vw=;
        b=FslqaJfVl3WTstZ/O1StXZU0pznXTyIlr9qeZJtAIRQ31a1D9hA5dBcpWj9kyHS7dt
         pp0w9S88NGf9Sk/O9Xai+qvhDlAMERVH5cHdKsEvt4jughus30ik8WSdvQNElRNxxU9q
         tp9B7Vx6ubJxIJwmwSOSK+Hmtf65aOW84jBblPgrSwG0m3BDefSAMJSpQq23oDDp2pcU
         +RSZZQ+u2k7QpNY1Ys6/zlKzKEcG+/jUZ0FXjNCOT4PAa9vOylc+HpcXS8PxALI4CkUP
         s6rBdUjMjwl0givAiZiXrUgt81ACJX2l251PW6kb1mRPOQ9sQf+jYg1vmPtM1qi3oHlF
         4/Hw==
X-Forwarded-Encrypted: i=1; AJvYcCXJmBiv9aKqy1YUG8tBa/4/+kg4muxz9cHQxYQU00jEHCCRbfkjD+FX0wjPX9oMTBikGy+PDg3Ls5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwlKq+bB4BGoxgk1+UylsVXXf3kZYQVGBHDNLyt5xdBCUkOV1N
	26IaSRKcEfl3nqUNgwo2r1dlYZi/jaEuSk4LP3BCMMaHtZRgP+9G/efI3D+S4g==
X-Gm-Gg: ASbGncsmJowFVuS2fQ94374S/hssCBCl2coMzrY0zV2Sfap/xTRP93OicQKFiQTU4Xv
	9M8AsqzqzV/Qn8ggIj+Xth6tp9CRnFxffK7xAtrXIBQ/Qih5Kdh+gI/7NUM7+jSl1lzxiQBOTZe
	hd/e10h6S4vl7zSmUm3Ez4kgeg01AwThmMJ0VV4ZnDfg1bS0VZRyMtqoeRPkv7Pp71zdQiZCy5v
	+PBchSbuVn6HhkSxgzYg8TbeRKcSy9yXrIaAuGxucZT0rARRlOXeqVWJxuYkQNxb++Hu6qJENoq
	F+Y28460WsvVaKovcAJPk1VHz5OK14VY6MN892OYxAjGYNUAy5kll78BxBZYT69H
X-Google-Smtp-Source: AGHT+IHODxROKgoJD0x5IRy4FMJDEfuxg+Ej21GAqp+g5b67FWig1NSQdI9leulQiZTNSUnH9Te6Kg==
X-Received: by 2002:a17:903:19f0:b0:223:5945:ffd5 with SMTP id d9443c01a7336-22c5360be53mr95211775ad.32.1745062763804;
        Sat, 19 Apr 2025 04:39:23 -0700 (PDT)
Received: from thinkpad.. ([36.255.17.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaeb632sm3249763b3a.172.2025.04.19.04.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 04:39:23 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Jerome Brunet <jbrunet@baylibre.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Subject: Re: [PATCH] PCI: rcar-gen4: set ep BAR4 fixed size
Date: Sat, 19 Apr 2025 17:09:14 +0530
Message-ID: <174506274083.37422.16454115819729459708.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328-rcar-gen4-bar4-v1-1-10bb6ce9ee7f@baylibre.com>
References: <20250328-rcar-gen4-bar4-v1-1-10bb6ce9ee7f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 28 Mar 2025 15:30:44 +0100, Jerome Brunet wrote:
> On rcar-gen4, the ep BAR4 has a fixed size of 256B.
> Document this constraint in the epc features of the platform.
> 
> 

Applied, thanks!

[1/1] PCI: rcar-gen4: set ep BAR4 fixed size
      commit: ca0c5fd2282eff988738539f80b8eb4e1f81a342

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

