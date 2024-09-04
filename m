Return-Path: <linux-pci+bounces-12757-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC8396C134
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 16:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28E35281F93
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 14:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5320F1DC18D;
	Wed,  4 Sep 2024 14:50:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA451DB548;
	Wed,  4 Sep 2024 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461437; cv=none; b=e8W09um6d4dyA4oraafUKvJhk896ZIrmgJ1mZhXpogTSeUjnBS0Wkbq+cyMSxMou3jJEZFQH9XHOsnqeF1S48KpsKsKA+NAENBIzDvrgCcwRktFD91RRKfFmtKCILI4hLAlBCIVBeza4Z2B6Ycw3hQCH60PMkG6YWBZkI55SKZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461437; c=relaxed/simple;
	bh=IHDjp7R8AfdR7b9xx4X+wFFhr/egmeaUbj20wxLCXC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MuSVvN14Kdhyyr4B8TX8R3aTLwQZ2qfJQ+dvX9kAjcc9xyqxSvBnxJX296KzQ1fRumTJCypI+VB0WWDtXm8Mmyy87z+OR5U+VnPs9onOD4tem3/Q4bKqnxJYNYTbQG3//J8QonfvMHCd+vWnYP9aMa9kq5wqls/9unSKSqBkPSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-277f815e6dcso1721284fac.2;
        Wed, 04 Sep 2024 07:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725461435; x=1726066235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clRtuBeNO4C+TrySRj7UAKnUpGGK0qUAKzAQZEajEsY=;
        b=rpSHStHLzjDFEh9KDKVFd9822zGCJpYGJu5GGHyXhHN1qrKLwEIYflg9k1aokdhxlF
         JFUd/jp//J/Sk9wnp7jk3KhMrAwsnOqwgeHq10eQiggkCGj0IWHVmLUCiaKm77JpSYaQ
         oUZIw8QQKIFPfSCZ5Av6GtgY4NuPSsLCc5mEuAYWFAu0dekAV97uoz2dsiZWsAaTBouY
         GkuhWRlMzgdl1Uox9KFVAzQQZ0UK4Gv8//8cbE61BVerVoE0xZLiROtnfNLVmWb+cK8F
         H0fnA7gqVKLHrAZiUDrTgS9Ili1sxXRrEcjlEl4sPdQ7B9fRXRrV3Ysn7FTmdYaAheeM
         DsDA==
X-Forwarded-Encrypted: i=1; AJvYcCUQ4NNye2/G49YHthmGf0q6nwUEekkEaQk0MKJAwDUDOhOIavX0a7zbyZryrKoO0nM//iICw6zh1u29@vger.kernel.org, AJvYcCUoU2EyqsIkTHLudVFcT9J3OQNfoo1nC/aSF3aTrRPad+VtBoIC32CjXpPY56cEIYWyMUOwYhXEuuHHZcjB@vger.kernel.org, AJvYcCWbqONSjgOJJmXHUBS7xBEf5rBUKbzjDP1Kx0fjW9aJF2ht1pZXHqyU4Sa90wA044Ma81fJiCrphPnY@vger.kernel.org
X-Gm-Message-State: AOJu0YySFwT4ruLb9+SGuuzuZFMfJno0i+cd8h9RS8K5SUTWdwr0gnG6
	ykbteTlVGdSczobZwL5HZ2ifbZOEsf0LCGy8EfhPyNm8gSylPrHJ
X-Google-Smtp-Source: AGHT+IE2bhiFX0HeldKFR23jyWfRURDpvfYGpoQS8AJr/Afiy2UpJM6rB+lJP5by4vUx6dYbMZpB/Q==
X-Received: by 2002:a05:6870:b525:b0:278:7ea:99d with SMTP id 586e51a60fabf-27807ea3ddcmr9332024fac.41.1725461434859;
        Wed, 04 Sep 2024 07:50:34 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbdade9csm1728086a12.92.2024.09.04.07.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 07:50:34 -0700 (PDT)
Date: Wed, 4 Sep 2024 23:50:32 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: PCI: layerscape-pci: Add deprecated
 property 'num-viewport'
Message-ID: <20240904145032.GC3032973@rocinante>
References: <20240823185855.776904-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823185855.776904-1-Frank.Li@nxp.com>

Hello,

> Copy the 'num-viewport' property from snps,dw-pcie-common.yaml to
> fsl,layerscape-pcie.yaml to address the below warning. This is necessary
> due to historical reasons where fsl,layerscape-pcie.yaml does not
> directly reference snps,dw-pcie-common.yaml.
> 
> /arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dtb: pcie@3400000: Unevaluated properties are not allowed ('num-viewport' was unexpected)

Applied to dt-bindings, thank you!

[1/1] dt-bindings: PCI: layerscape-pci: Add deprecated property 'num-viewport'
      https://git.kernel.org/pci/pci/c/b9fe09a1b293

	Krzysztof

