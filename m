Return-Path: <linux-pci+bounces-26298-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4617A946A7
	for <lists+linux-pci@lfdr.de>; Sun, 20 Apr 2025 06:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA1923B70CD
	for <lists+linux-pci@lfdr.de>; Sun, 20 Apr 2025 04:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A9315A848;
	Sun, 20 Apr 2025 04:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UIZfs1Wd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CC07DA93
	for <linux-pci@vger.kernel.org>; Sun, 20 Apr 2025 04:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745122501; cv=none; b=h8wSfDaX1xo9pOYT2QqNVoSjuyFoO2UVTnHZr5p9AmokB3u/GjqY8OKLB8JTwUF4dxYQdTbIJBVHH+hktHRdCwZ40a6J+u8xdNbF+74nynmq9ysn6Nf7qErv/WEsUD9PN5vInRaJmxFsjB2p8NcUXmENK1CXIFdQtuq8w/Afqk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745122501; c=relaxed/simple;
	bh=vrRK6sdxshe7zgreO0icrsIYu2dpEpBfv0a9U6CA3F4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nHeaO8XL4MCTABbhgnCiPullrNLbsnIO7aymn5dWmO8kbh7tobdnbU9Vlmk/SVH6jnt8r54ulCwSLaXHq0tw/rZb0zUNKo5V+g19RVPBHmV1b1webdN+5pph0umNRQd2Wbppsnkke1LrIsHwmaLDtASbLzeWGwUNOsE++T4jDB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UIZfs1Wd; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22c33e4fdb8so31606495ad.2
        for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 21:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745122498; x=1745727298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gq3eOM5hE1X8uoAe1U581S6eQD3BQ0s7OjJBWEqkBA4=;
        b=UIZfs1WdDR9JtkVUbr5TbTnMtycy+qaNUk8P8qe+zVgKa47nQrTQ99U5WE3ySOErbf
         uofyCPBZRB15GxCeIv4wkcaIH/XCZN7yxY0o5kbkw/XFU70rsgwC6yNCGN5pVSa6PPDN
         vR0PwxNJT3xT7tsV4G4IHUmFoozpFb5jnDkpCx63liPu+xVF2fNUKK1DMzbv57Cx17JR
         lhx2I5BFC4ldGP7qqMTHTx3EO9QCuhD3+9rOTcyQprgTvi+qjY0VAFUKPsPgd5ZuNeMm
         4ge0cY00iEnA4VML1g5V80Dp2jkAQtfHTA/qIPOFa0MdCVb4lq+dJEnph9ClMh3PAVWO
         0Jpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745122498; x=1745727298;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gq3eOM5hE1X8uoAe1U581S6eQD3BQ0s7OjJBWEqkBA4=;
        b=EqWBDde43kYHWhCZ2jgukZsR5K0NdcTL+vayuaKdgkI9CVD+RR52AXG8T7vqOZUHgk
         qcZMOHq8+e2ajBx4MDFqz8byCRiunLtooSN8Vo+R9XW6tvRywa274o6kQpb+Xa0Ywy35
         +c5UGHhsOF3VxPohF59/GW3/o6Smr/306fU3HaPHqu87GaXIFGY/ACArn/WO7C1ZG1ay
         OJrhzg9phj8WFmGdvHoK0RlnoPZmZQwKPGoflWWCNb5xlf9NN0og/qkEgLQzxSvmvn4v
         021v2ruNfwQVsNZAIygyJ6yZSi4U+GkBZbg+MUCpaCSPZnB6c5/h09+lK3cQ05NatwBw
         PwEw==
X-Gm-Message-State: AOJu0YwrfGNVzs85EuP9azlyL489ultBgw7wLXchGX9tgcXzyiHBMx4F
	rqFzRLT0kvihyTd+bGTTU06hub/+MmA+YW+hXSjQTW4IvVjG1TGWEa+qCLZXdw==
X-Gm-Gg: ASbGncuEbqqe47uq8qmLkWoJVdNXns9C5iAGpKIBKYCX3KdR3bt+1sngc332eo6NPWu
	Db33KqU5Lsq3WnYPtXrapJWNCuFTaMdIVJvtpj3kjr8pg90TH0GF9cojYIvWWZVOYTuqmY/bw6m
	vtP0YomGkkXwziQXEcRRbgOYfYsZ8FZWYdvco0kyLpT++UnhoL1D34aLUTXo1FdlwqOKuB2E466
	y/GjB1G7YZoN91i2W/Imrv9ZwQOIRrYYqm7lmOAn4koKb9AZQ5fnJeci4Zc98nULk0e+CwynMFj
	EJACStq2OLkO5kBYz+D5hwS/WJCCHMnG+a1oSc+Fp3MR8R8JRWkMLZJfkMpcouVH
X-Google-Smtp-Source: AGHT+IH0Ul9myETUjE6RsaTKjYuEftn6ksNt+XFLIBnkXHJ5m5w5McMSLkUMSv1HgvljYu7WrWw3XQ==
X-Received: by 2002:a17:902:ecc7:b0:220:d79f:60f1 with SMTP id d9443c01a7336-22c536151f7mr112689605ad.42.1745122498412;
        Sat, 19 Apr 2025 21:14:58 -0700 (PDT)
Received: from [127.0.1.1] ([36.255.17.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50fde851sm41412575ad.239.2025.04.19.21.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 21:14:57 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250414214157.1680484-1-robh@kernel.org>
References: <20250414214157.1680484-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: PCI: Convert Marvell EBU to schema
Message-Id: <174512249494.7011.2708584951288197679.b4-ty@linaro.org>
Date: Sun, 20 Apr 2025 09:44:54 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 14 Apr 2025 16:41:48 -0500, Rob Herring (Arm) wrote:
> Convert the Marvell EBU (Kirkwood, Dove, Armada XP/370) to DT schema
> format. Add "error" to interrupt-names which is in use, but missing.
> 
> Shorten the example from 10 child nodes to 6 as the additional ones
> don't add much value to the example.
> 
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: PCI: Convert Marvell EBU to schema
      commit: 761aebd2d783a068afd7c81925dc8be9df58bf2c

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>


