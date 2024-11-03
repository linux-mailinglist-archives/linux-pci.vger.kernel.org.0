Return-Path: <linux-pci+bounces-15886-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 630039BA7F9
	for <lists+linux-pci@lfdr.de>; Sun,  3 Nov 2024 21:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AB981F21503
	for <lists+linux-pci@lfdr.de>; Sun,  3 Nov 2024 20:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2501189BB2;
	Sun,  3 Nov 2024 20:33:53 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682FE13CA81;
	Sun,  3 Nov 2024 20:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730666033; cv=none; b=ti4VvUpXBoSlcCmiYd4Pl+VVX/tIhL3ZlvSVHPpoA6H0BCyZU5ICwUU6kXBqHwskvPxLoykU2LVtxdSxEfkl+PQbJ6j77iBkAIc5AkZzvBIXvgNvFahYQ8SnInVLbEL4FSs4UDJxIHu32ge8xzq9DlmIwK8fDXDg3hCuCBsVfc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730666033; c=relaxed/simple;
	bh=zyKOX1l9EDUUW1CnR4CP0Y8Xy5LN2KHQ1PxZ2Q8CNuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ld2d/zy7d7AVPylyekvoTpMSAsgiJM/bO80YAsFezK8xsQMQdsqhZl0+IgzzUSMeMR9v6qU02DpRAK/eoj8FGkqjOcgEafelLnmySBV7/vTQwS3h84D/H3nnonjk7L4Zxjx47nWD1qTfvhGLv2YV1OGlf0x+LXCb6Pz96QwBWOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7203c431f93so3006859b3a.1;
        Sun, 03 Nov 2024 12:33:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730666032; x=1731270832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8QpXUygT8E3xJqn9zK+Q/xiZQlIIE8OfSERVNNTif4=;
        b=wTwEmkmx1ul3VsNKHvLu32GY5zwBgvqdaVoVKfo17wKvCsR+9gN6YlqlrCLm0IbFtw
         x6JYZeJwEwNM0DxzYRase4DaXbSXBBKKxA+B5ml1AR7aCTIrjj6FbeCEf20jld6PNBe8
         vYJxU4P7YpPuicc6AVG2xkhi3f9OuDYnJvkKRDkKw4uqdWnotOf6RUykilgVjW9BIO9S
         Sq0T/dGkaSFtuPvtesbSFh8ulC21NjlWjvJAqz4xU9eYWT1mSNRKQYK/jezeZ2OTkG1I
         AACd41kD5kDijPaQNruSWc1tvdTPhztooGOWSOx6jPECFVjXvoynSOt9ilhzIObNVzmR
         x7NA==
X-Forwarded-Encrypted: i=1; AJvYcCUXAzJuHAUNsoDerGRCpLDM/GxwrMt3MAsvmOlZFUGYiwMd+qVkTudxv0sJC9lTk0hmUUFfPOZmIkfkM1fiug==@vger.kernel.org, AJvYcCUwOEwiSYbhi6vSXR5FraBJZeN5EmXxkFONhm6KR4dZgMJSUG7I+dbXC220KKhv77AYnxL527A91Lga@vger.kernel.org, AJvYcCXIoQX5XiEBkuO+fpKm4vS/JrhbW9v/wtPqt/SUsPNlqsEzEnE7h0198A4pNImwNOKRqWth5+X//tbn@vger.kernel.org, AJvYcCXZhAqRWUXIK7pL33CjY3vzLrFiB0IB/bbT5JhFXBBbm3At+cXRZ3ejrj0TfN2IS34Vki0n1+3CjCMSSWFJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzOGNvzhmt+tBLO2lwaLi2eegHovSRso0ku9Cl/Z84K8ptLILBo
	gyYg0eYN57ZAcHmeahP0K0uaS9ab7UqswkJX17WG+lA79nPiLFIf
X-Google-Smtp-Source: AGHT+IGzzwYBTBG4rFNV5xILV5YIzjBZZZKs3ztrovEKzIUWSy9GwthWVItvL5JATeaIF996p4ANbA==
X-Received: by 2002:a05:6a21:6da5:b0:1db:dc9d:47e9 with SMTP id adf61e73a8af0-1dbdc9d486amr1352422637.32.1730666031635;
        Sun, 03 Nov 2024 12:33:51 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1e5e11sm6019125b3a.50.2024.11.03.12.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 12:33:51 -0800 (PST)
Date: Mon, 4 Nov 2024 05:33:49 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: qcom,pcie-sm8550: add SAR2130P
 compatible
Message-ID: <20241103203349.GB237624@rocinante>
References: <20241017-sar2130p-pci-v1-1-5b95e63d9624@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017-sar2130p-pci-v1-1-5b95e63d9624@linaro.org>

Hello,

> On the Qualcomm SAR2130P platform the PCIe host is compatible with the
> DWC controller present on the SM8550 platorm, just using one additional
> clock.

Applied to dt-bindings, thank you!

[01/01] dt-bindings: PCI: qcom,pcie-sm8550: Add SAR2130P compatible
        https://git.kernel.org/pci/pci/c/d38cc57c14ff

	Krzysztof

