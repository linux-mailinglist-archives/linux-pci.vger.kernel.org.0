Return-Path: <linux-pci+bounces-26299-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A041FA946AA
	for <lists+linux-pci@lfdr.de>; Sun, 20 Apr 2025 06:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 288F21747AD
	for <lists+linux-pci@lfdr.de>; Sun, 20 Apr 2025 04:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F6E19C542;
	Sun, 20 Apr 2025 04:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IFOuQoHP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE26191F79
	for <linux-pci@vger.kernel.org>; Sun, 20 Apr 2025 04:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745122504; cv=none; b=fnLg01NHFJmf1dtR5PEhB7CDCt8f40yIo/T8aUXu6R//8FcpzSw3aaHXrpcRjlvaKy5aBCEiuHhA1QMW7SRchNhGWn15Xy7wQsLnyHgbAbpRcr8YqP++eUkx3Y0y8UByzxv/stQ1QIhjfQlw1PY2CsWK708/bT2EQYyU/FvVblc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745122504; c=relaxed/simple;
	bh=5wxG/PD3y1gNjGB7AK6b5PlI67QEyByu1d/flv9JTpI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NB+dzz9UDSxxsILJmt8UuoKRhYMNJqH1TcFKWSLEV1s44aBccJL+B+Hd362CtoBTg0D8DBIrXlVwO11/QGsy1iB8IbVG4m1pxHrwT8JSYws+HCRUuXB6ZwFZ1pjmy8VDuy/lEj69RLmkg7QGsVgNb3um8XXcZwG57RLrGop1w6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IFOuQoHP; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223f4c06e9fso26547645ad.1
        for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 21:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745122502; x=1745727302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2HXiX0Llqkid7BbKxFHITtAYArqMyUNvEqqrLum1r4=;
        b=IFOuQoHP5cMJfaiJsVCYWSMhTh/Q+0G4JBJFmslnIcreFrb9GvFsP/k9RwHUvx5z7d
         OODekzgM77emRXLqa8ka7dwwjA4MOoocFFck6cEUU/CdrJb6PSsk9ns6G855q/FcKAoj
         TUyFQFi2XxoorOhq8dGYnaVp2miD8/zc99mLaA2uJG2rDvAD912RMDZ+E+2fj0l8vgz5
         aaYuqIeOPp7EWfo1uj4hm7kr308BPG/pKSZUa96CdR4NiPqmZEBZuw/tj2azFNopA+yf
         VyMyk5GNLLR2GOWXmw1eY5+quVktvkrNabI3Ql5QRBLShVww3itsDSPtV5GzLPJvQkkI
         7kYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745122502; x=1745727302;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q2HXiX0Llqkid7BbKxFHITtAYArqMyUNvEqqrLum1r4=;
        b=q5/vF97ofsq5w4SoUr8rmNB3L8Cfxgij1JdK/qdWe5i2BMXRAxtCnso877AD5f7UYZ
         sUQmjNL5dovCHlpUJatrmSTMFyhhaYNNgLRDgwIolHSsl+jur22uXjy1IMbAKOrimCTT
         sN9+PC6YWJaFzrB3040xNZKHMiRfxme2t9wDmGEjdevui75KSp32zMKxEn2c8HIVt64m
         rkCSPprE0Pp9odEVxXoQSFVQuSfwmHfO5COTSf6Fpc1CLEeGvUkAVBVU9IRdKbjbFBOb
         trXguwJOJqSMkDuxKEg0C+Oh0TDGvqhWA4ullPjP14rVPskSPyZA8fcVh+1HYjhJgQIO
         2ejg==
X-Gm-Message-State: AOJu0YxGMNHJCqQ+zvXBxHIeAB5kWq7Og3h7+vCL2ObBth97bPS3PF/t
	J5OfVwOxKCSs5SIISDoInEJK70sL0Uq6UPiLlUWbDIL99NqzZeqXc4KThAkpyw==
X-Gm-Gg: ASbGncvLICKP7MZLqvAgPg0F+bCeyfi3D7b2tGxt6CP6dOOFKKY623WK27jT9F90mHQ
	0Uk5CI1veQFLgC912RYn1M/IjHiyFFfWqgAo8WxZ3zvA/bDXqke+rkoaY+xEBwjYxF1wn1bIwCP
	/FL8M7aKFf6K/zRJuOEHf7JKpTmps58eCm1QODOeoJyg8NN13SDeS4Q9C5Dp7qMppTrEfrmfE2u
	WBBrFueKedLwQZwQ7d7pFa3P8ftEg8Z+/xWcThs/Be3XcMv1PaM8ZHh4n33AHLqgGCWcGEudVQy
	YIEAqC7Z4cPY0auJ9xTPs4+ZXR11Zg9j03u/0tUJCl+QSdyRfjRKEw==
X-Google-Smtp-Source: AGHT+IEoRogqNsHUePuqqRRfsSxmfzIJqF8/P5aLwK+/NB/DXV9xoYPlMraILqGL7x+DlXFdEmPRaA==
X-Received: by 2002:a17:903:2f81:b0:215:742e:5cff with SMTP id d9443c01a7336-22c53ef1653mr122737365ad.16.1745122502501;
        Sat, 19 Apr 2025 21:15:02 -0700 (PDT)
Received: from [127.0.1.1] ([36.255.17.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50fde851sm41412575ad.239.2025.04.19.21.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 21:15:02 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250414214135.1680076-1-robh@kernel.org>
References: <20250414214135.1680076-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: PCI: Convert marvell,armada8k-pcie to
 schema
Message-Id: <174512249875.7011.12246888223550931495.b4-ty@linaro.org>
Date: Sun, 20 Apr 2025 09:44:58 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 14 Apr 2025 16:41:33 -0500, Rob Herring (Arm) wrote:
> Convert the marvell,armada8k-pcie binding to DT schema. The binding
> uses different names for reg, clocks, and phys which have to be added
> to the common Synopsys DWC binding.
> 
> The "marvell,reset-gpio" property was not documented. Mark it deprecated
> as the "reset-gpios" property can be used instead. The "msi-parent"
> property was also not documented.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: PCI: Convert marvell,armada8k-pcie to schema
      commit: 82f48c8c83f576edb2614c49d0980f8d65eb4772

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>


