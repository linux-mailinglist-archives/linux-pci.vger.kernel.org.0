Return-Path: <linux-pci+bounces-26270-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A07A941E9
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 08:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D87693BFE68
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 06:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D0E15B135;
	Sat, 19 Apr 2025 06:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rGD1hFqv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173763232
	for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 06:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745042629; cv=none; b=Akwess4U6aQ0DOmSMyG51+ng2lHejqrpo1DUbgTh47OiV/2ENeuxl4b20uH1RVGMW5KGIIWM06cdChrZYjVTRTrE31Y44QCZoc8s7twvAuspoxVPAh6TC9tytvjF5SfTSeDdOynx0267TNbex1KESzG6Irj9DUl18DT2jH4KFPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745042629; c=relaxed/simple;
	bh=dBw0csETq4Oax7D/gIJsoGLgmtl6zPN0tQTFG8GjEtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QYh4Qpz4VzNn5D01BnUryQ1vcHmzpNBnu3J0uCph3GuwZEflAqKn2mUtZ8KbvzXSCVJh1mwqQU6n4RUEj9dzU0JJQd7d8/quwAdqO4RNqIQg1ER+Ujd+1h5bMXddQqETlcsfys84zs4L8TOwd0l9mgp/TGC4GmgEL7lMV6WoKK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rGD1hFqv; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-224100e9a5cso29738855ad.2
        for <linux-pci@vger.kernel.org>; Fri, 18 Apr 2025 23:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745042627; x=1745647427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lTgQTvZYqN0TLCj43/V6Q2NyHBYHePk/+H2FCWatKs=;
        b=rGD1hFqvX+Qm6W1NKqWPKkkt1ZWZso6vUSwToAeQtLPVmc0f4UXf1eiLnelAbpyFE1
         w4r/Xhmmnp3hsZ2Zq/QKL9U15uIr1ifSkhEzPDvlgC1lsbEy22YwZlbnWI2E/0dIoPhu
         4ONYm2bnYZnJkfAOBNCteg/sZ8OYHUp7tOZfSAaPPbyr3FJXhgGcM/UtAXJrdW0+Ivii
         1Hm/xEEOhsrussOzGVNRb1AaGRpKRTZVYsdWxpFdSUlPYEzLAros98ddZ7zP/rxhw9ya
         reYIHc9XrTbphu3gXEWGVWstuCI870N1Pm3XIQZky46qCavtj5yaAGrC0nGIDxnbLHKW
         rpxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745042627; x=1745647427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2lTgQTvZYqN0TLCj43/V6Q2NyHBYHePk/+H2FCWatKs=;
        b=vDJOUh0dbagFud9ZZYFzSuvi56QdMUQ+QQBcDeww30VN6Wok3g8wQpHhat/nblvLa0
         WkhLEISYQcb470K9Dl0zBrqsID/cWvaFaMOi1rORdJq78F9xCtIZrGpsYQEkNO0yST5e
         /5ew9JoLLoBrzLaUMtBPV8SrdcFmv0VEm+0gl67kPIlucFR4mpSD4pvI8CEVNRQhvWoC
         7QXRm122dLR7ifahOOO9JxGSh+u/zFDUkdwwEt6QYi0fUAv+MrW09RW1uGOrjo/OAL16
         cCA9zivQF37RS+x2EFar3YA7fobUQEaSpWTqOTD73CC0PUbLQJWVRPdpASVURwE+4XNy
         sItA==
X-Forwarded-Encrypted: i=1; AJvYcCWC71m7jqH72CGWo3zYbUOsgTw9y1j+hyQ17sSG3ipGUt2FO3wg/TT2dhTEaFwju4NkyptOwimYKoE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn5gBCo77ge24QIY23PGNNTW4DGqCpJ0iVIWAaoq/n5yrYgntw
	9NEPXi7muldLAJAKZzItIbgL3bYgljgDRivPV4VX+suSOS2xM1HmeFzOpEDtMQ==
X-Gm-Gg: ASbGncu5tHGT4LJYvd9dcDNgNg0c/gmI4ZYFkhxOtCRqdk/hxkppaj0x62PFxO2gEBJ
	A059Pd4oXfsA7Uno7YhfyWHHL47wZebKOoRyBn/RLT1i+nEjzV8AoV35SzhSQzha9/jrNsh/VzE
	oPux7s9Gl//Hl/cTlmHHdmggWztaMyas4A0BsNqhXZsWjb4J38pxvfO58q1SOWZxC4mmgCdTZVc
	7K+kjzZ5KMBp3ivW8nHd33zJpXX+E28TwJYOO7BuNv/0RGfaaLbujU72n9don4Z8lXlc6iL0KMO
	pX3G2h8oBUU0PAAhXVtzkcmvOp8nlTnvntSoAALp+/4OOTR8dnmiu2r2jGgmcaES
X-Google-Smtp-Source: AGHT+IHe7z+mwljypPJwxHYQDW6Or2SxhxqJIzdabeYhZVRypfM4toLH9er4he0mUfYtnDMuCNfesQ==
X-Received: by 2002:a17:902:e546:b0:21a:8300:b9d5 with SMTP id d9443c01a7336-22c535a7ec7mr65152705ad.23.1745042626951;
        Fri, 18 Apr 2025 23:03:46 -0700 (PDT)
Received: from thinkpad.. ([36.255.17.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8bf7ecsm2609173b3a.31.2025.04.18.23.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 23:03:46 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rob Herring (Arm)" <robh@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu: Use for_each_of_range() iterator for parsing "ranges"
Date: Sat, 19 Apr 2025 11:33:32 +0530
Message-ID: <174504243663.11666.13632057141942882562.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241107153255.2740610-1-robh@kernel.org>
References: <20241107153255.2740610-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 07 Nov 2024 09:32:55 -0600, Rob Herring (Arm) wrote:
> The mvebu "ranges" is a bit unusual with its own encoding of addresses,
> but it's still just normal "ranges" as far as parsing is concerned.
> Convert mvebu_get_tgt_attr() to use the for_each_of_range() iterator
> instead of open coding the parsing.
> 
> 

Applied to controller/mvebu, thanks!

[1/1] PCI: mvebu: Use for_each_of_range() iterator for parsing "ranges"
      commit: 506d34571e2f204c991aefe3f1300175907594e3

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

