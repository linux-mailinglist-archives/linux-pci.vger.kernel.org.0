Return-Path: <linux-pci+bounces-1555-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4163C82004A
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 16:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB1481F22C6F
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 15:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4EB125B3;
	Fri, 29 Dec 2023 15:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="YuW/8oMr"
X-Original-To: linux-pci@vger.kernel.org
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCA2125A4;
	Fri, 29 Dec 2023 15:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Received: from [151.217.64.190] (unknown [151.217.64.190])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id DAFBA16395D;
	Fri, 29 Dec 2023 16:36:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1703864192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y0xq10+Biw3ZEd5W/yZjtFohwA0ukqV+GjZogCbByW0=;
	b=YuW/8oMriElR1HoxkYjcY/58gjB7Wlf9l40FZ4tV8hlPy9oCAlOJsRN7jJ3IYHEa3/igPl
	39BKV33NuseR95fQ9/fZxWbNK1sFTG3OP6kBhqFfBRim5lDeuh1+CIRXftGCch4RR1i9El
	nYjoOebKWa0wIcWpCMqvBkUI1KeVZqo=
Message-ID: <dfc4f26c-74fe-47b3-af96-e97765082f4e@ixit.cz>
Date: Fri, 29 Dec 2023 16:36:31 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
To: krzysztof.kozlowski@linaro.org
Cc: agross@kernel.org, andersson@kernel.org, bhelgaas@google.com,
 conor+dt@kernel.org, conor.dooley@microchip.com, devicetree@vger.kernel.org,
 konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org, kw@linux.com,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, lpieralisi@kernel.org, mani@kernel.org,
 manivannan.sadhasivam@linaro.org, robh@kernel.org
References: <20231120070910.16697-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: qcom: adjust iommu-map for
 different SoC
Content-Language: en-US
From: David <david@ixit.cz>
In-Reply-To: <20231120070910.16697-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> +    minItems: 1
Hello Krzysztof,

the driver will accept 0 just fine, so I think this definition may be wrong.

I sent just generic "dt-bindings: PCI: qcom: delimit number of iommu-map entries" which doesn't care about the numbers (in similar fashion as other bindings having iommu-map).

Tell me what you think.

David


