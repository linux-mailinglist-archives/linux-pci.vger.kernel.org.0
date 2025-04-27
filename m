Return-Path: <linux-pci+bounces-26879-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 021EFA9E3F6
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 18:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E76B7ABE4D
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 16:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0361519AC;
	Sun, 27 Apr 2025 16:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jRWTLAjw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5E6149DF0
	for <linux-pci@vger.kernel.org>; Sun, 27 Apr 2025 16:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745771758; cv=none; b=qxFOt7J3m+5XUQaEcwvszTXuRSncsSELouE0tCv5nY1z9prCtzw8T3Z0B/GGNhVq28IFddWlPwPTSgcjH7+EGfZDIGlWW+7vVCnGTiHD1p14zgNORidMmIXXe0tBfTfINNlC4tATLC+kBp/Te4ig3AG3v7wrboQxbRA3/fhX61A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745771758; c=relaxed/simple;
	bh=xKZTa8Jy7yRLXDMe0tk99VhR+7Dd1SQty7lWFn9NEtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YEKa2uSzp6vvP7iawlPCYxTIQV7xFsODUD082MarZ0QFnNy944Wmuq9Q3czaIKcKQ10bnRaeW85n45BCqVxv0qDPCo4n61orjhSQkC9i7bxeapY0kR8tnCwmUkdXFikvFu1n0JsMQ5Gbx3DVyQNzwSpw0iDveYd2PeLvqdTS0wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jRWTLAjw; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22438c356c8so43502955ad.1
        for <linux-pci@vger.kernel.org>; Sun, 27 Apr 2025 09:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745771756; x=1746376556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ik+PKrYUz12n/bOV4S3ZmMhIipJ7tfQZAjp79yKcBVw=;
        b=jRWTLAjwR7+yIIFdXZCWKcDJm5uERUTR+tQKR3BOM5YFKwsnaVaxUbUuTvoCIasZZq
         ViPJhCzsK4HjeyuEDI5pZt2OZElIy1R60K36mlshOkjppMrJvkW+HxP7znMj8mGdcuCO
         +Qooo3T24r87Tv8rjBAznlAwm7G58L6gLSPOyug4O6Gv1fZDD7IN41qbNoEDnZKLI5S9
         CSsEqbfbQs/Nw+wCHrXqBoXc/pT4WxHNXOkGXrip8kwO5LL3ta3kXnoUTX7g9djdiGHL
         9Ts2vGzAgtLO4BV9ut7CmMsT0plGg7MpFRtfCPWnwtkKUwxZvHp8QbWSL9oDYfBD8FT+
         8AKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745771756; x=1746376556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ik+PKrYUz12n/bOV4S3ZmMhIipJ7tfQZAjp79yKcBVw=;
        b=TYWzW2tfmzuThCiDYMl7HfZwtyWUUt3BlnHheMzJtwLY+KvnvpvpXCmLeL4V8JwM1u
         jjSLPKEAl5CUzX8iIoCc9MfHrMRebR6PIxA1u2rdM9pSHLh9I4/Crc0GQ2dtBqD90fnQ
         +txnvkhilx/80TjQv9NSqRPh1GCGH+QtaPwUe9ukbUK3ODXNP89i+MabhgnKoNZCsays
         qkD+kmkbxDsS5djy2O9WYUbKJDb1AC5Nq2cG+sp5mLLaiRQG41CqBq15eBeANX+1EXFX
         soQ+YTUu3mIc8XkrOnpme84nLtykhImtavHiCiSiZFcqZjRS7FkJBQbcfhtU/cfL7prr
         houg==
X-Forwarded-Encrypted: i=1; AJvYcCVD+xBRBtzzBxbERa3urejVY2oP26FZMXZjQYLKjzHrqxCL33KxHWyuyMoRL3lnHnEas/qX1OiKq6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMioFWhgliLLWC0V/BeL3geExBkGgO5femAu472DHypT7mKavq
	j3ZGhQDbBuU1MDoxnXPu9J/MtBkOU7N6o2NK8ZnM5JbX6miUHugshisvIvwtKA==
X-Gm-Gg: ASbGncvhaVqBXsR+gmhgK9Hx/eZIlslizt6xtSxQWtPqZSqAVe7h/dUHFvjvtU3F8oY
	vOotRswge79N/bcS7kJNDj2Wds/So+1J+/PYZdtIlK9km2FtXBugYGg8ouU1xAa3Ie7i6EUgRJ9
	YtBjX8U/RsEhrE8AcbFxSvc8ZJXcpW0kekPHtFBZ/shElg16BOI+DUdBxZ4c6r5SnxIcr2cG8MN
	A8l0sIVU7h+qIlkN6mPus7oqNk6ZY1M3/i5cMw2sPx2njYbLwRsWlo2gHgIXDjP24u8mKH7pN6J
	mO3YUejv1InX5vF8zMdy+W/VKstBNQ5Vxp/nK7mSTzODvmuNIDrO
X-Google-Smtp-Source: AGHT+IEAjFA93KKywEnB4RlSwgSRb34pemnKDnzT+Il8EQ2sIWnFIevqhAIcyqRFAwl1jP0V/maVcQ==
X-Received: by 2002:a17:902:ef0b:b0:224:1005:7280 with SMTP id d9443c01a7336-22dbf62c74dmr150793215ad.38.1745771756017;
        Sun, 27 Apr 2025 09:35:56 -0700 (PDT)
Received: from thinkpad.. ([120.60.52.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309f7851e0asm5329424a91.48.2025.04.27.09.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 09:35:55 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Zhiqiang.Hou@nxp.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	Chen Ni <nichen@iscas.ac.cn>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: ls-gen4: Use to_delayed_work()
Date: Sun, 27 Apr 2025 22:05:46 +0530
Message-ID: <174577174111.84046.1840850940994966437.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250414074241.3954081-1-nichen@iscas.ac.cn>
References: <20250414074241.3954081-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 14 Apr 2025 15:42:41 +0800, Chen Ni wrote:
> Use to_delayed_work() instead of open-coding it.
> 
> 

Applied, thanks!

[1/1] PCI: ls-gen4: Use to_delayed_work()
      commit: 5e2664f9e108f66046869ed4990043421919465f

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

