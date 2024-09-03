Return-Path: <linux-pci+bounces-12662-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4E1969F59
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 15:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE3361F24341
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 13:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A3D1CA699;
	Tue,  3 Sep 2024 13:45:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C403A23D7;
	Tue,  3 Sep 2024 13:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725371156; cv=none; b=HaTYVElFwwHPnQarFcs4IFQ7mk42gWFvVFw1mAFkpV31O18gKBMHTHkErzMVlcp1msvpDLEJM/DYEYGNCr+Qobp/ppj/+vbW1v6EwvkhJiGwDglFZHIPWkI15RtcZYK28v2DNNSycDB52hYHMVLOZcscwt6bhyZbZp/pa7H98UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725371156; c=relaxed/simple;
	bh=6dvYyG7Lk4Mq8ENQFSL8w6iBN1/Q+IhdQJgYGstFrHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIpLvmrZMjzeVHsh7y1/O3S1iMih0AUhxiKZHTDeQaeXEru/vzZP/NnrX884OMeIuDE/ONGhqwMtF5nECn2NH0w6H1tVSZMK93hwevXN2zLqwJnuKctFG+XzIr2XDrJV98sLgCBZDMDLe3yIQ7BUjJOtWzCmM6nYbSb/Ly/wJEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7141e20e31cso4340756b3a.3;
        Tue, 03 Sep 2024 06:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725371154; x=1725975954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYOAtKnoAGXP2+8BC1os9BAhNBSXrRiYgGPXZKA41ec=;
        b=xDt0Q4Dnu2Vs6ft4tvJxDMTt0giVEnrDeQpszucNboV8x6j/cK7eBx1I2c/RjIL9Pp
         BH2L6utuh97Xh9ItAuJXGky8VrRSQ6XKt4ElMaZGRfOAhjCCpV3RraFmSftuIoIX2pT9
         4m5AasP8Jt1k8zLrFIkKCELpj1dwJIQLp8zpjKHlv5vKrbtdUF/35gIgJe9jqzsJ4STY
         7QiEfcr9D4nOkBMUUiF19AGkmXa1Mu79Ma8/igAid562jinT+4gdvDOiW4uNmbltTPY/
         1vBY2E7EaC7u2oJeawva3xEydfRihVgxofOeIZ21eCMLOHxQU7g0pbRoIZwZs96Bc5Q2
         XfRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl9d7Xkq2QB5195BhbzVeIWd22It3xLMlqk0ST5L8Viu23D+4oy7QWCuLoIgPANTnnSsaRlpR7Knl9@vger.kernel.org
X-Gm-Message-State: AOJu0YzqupzJ09QZJeYZn/eNz13y8BS0KJ9ZwPB9Q42bnD7fhvAjFMU3
	+XZ9r+jQCjtB1UCdT1qe8pu3UlHfQ2ZUfPbd0/xYWr9dA9tt29ES
X-Google-Smtp-Source: AGHT+IFRTbt4L+MgTBuRglEwGKCkDyb1NmD5ZyL59zHUq7QvBrYsy/ljTjbd2mFlKvLYwZfhOb4dgA==
X-Received: by 2002:a05:6a21:e91:b0:1cc:cdb6:c10c with SMTP id adf61e73a8af0-1cecf757e4fmr14195523637.37.1725371153943;
        Tue, 03 Sep 2024 06:45:53 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e5576d0esm8538780b3a.3.2024.09.03.06.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 06:45:53 -0700 (PDT)
Date: Tue, 3 Sep 2024 22:45:51 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-pci@vger.kernel.org, ryder.lee@mediatek.com,
	jianjun.wang@mediatek.com, lpieralisi@kernel.org, robh@kernel.org,
	bhelgaas@google.com, linux-mediatek@lists.infradead.org,
	lorenzo.bianconi83@gmail.com, linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
	nbd@nbd.name, dd@embedd.com, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH v4 0/4] Add Airoha EN7581 PCIe support
Message-ID: <20240903134551.GA1403301@rocinante>
References: <cover.1720022580.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720022580.git.lorenzo@kernel.org>

Hello,

> Introduce support for EN7581 SoC to mediatek-gen3 PCIe driver

Applied to controller/mediatek-gen3, thank you!

[01/04] dt-bindings: PCI: mediatek-gen3: Add support for Airoha EN7581
        https://git.kernel.org/pci/pci/c/c6abd0eadec6

[02/04] PCI: mediatek-gen3: Add mtk_gen3_pcie_pdata data structure
        https://git.kernel.org/pci/pci/c/dc869a40d73e

[03/04] PCI: mediatek-gen3: Rely on reset_bulk APIs for PHY reset lines
        https://git.kernel.org/pci/pci/c/ee9eabbe3f0f

[04/04] PCI: mediatek-gen3: Add Airoha EN7581 support
        https://git.kernel.org/pci/pci/c/f6ab898356dd

	Krzysztof

