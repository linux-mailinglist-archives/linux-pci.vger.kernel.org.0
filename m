Return-Path: <linux-pci+bounces-4693-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B1F87723D
	for <lists+linux-pci@lfdr.de>; Sat,  9 Mar 2024 17:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAD7F1C20BC1
	for <lists+linux-pci@lfdr.de>; Sat,  9 Mar 2024 16:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E154597A;
	Sat,  9 Mar 2024 16:28:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E6145BE2;
	Sat,  9 Mar 2024 16:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710001731; cv=none; b=XljvfSUkHf+ZzBbju0QKazP3GiQWFg8HhWLl1LUnn9DKQ4KtJOYhT7MHMuQ5jNjTQMlLZBCT+TLCCU69rt1GGKBZ7of020ohnXSG2BjRt6YadfJYBn0sUWC4igLuFl2yyFw9z4BlOwX1uvIq4S1vfdhdJoKtGPY8VKdSbN6QDi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710001731; c=relaxed/simple;
	bh=6628g/cN0oYeqYkNbQB+19Rpv1qNEmSQM/0TAMeMC+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETrfqzPHMoqMiJYaMoCVfWC9ILohLKxBZts0PifJNvj2f6tnfYijKeIVhg+ENkL5iqwmHxFVUjrlMwdl4aCi3YFM5v0stbssDiGa5fr0iDzQtcOqRUdibRHDypp5LCRz1FlX9BhQ9MflhzccwBLArO+fS2bDQydK70KfAOnzzvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e5dddd3b95so2252734b3a.1;
        Sat, 09 Mar 2024 08:28:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710001729; x=1710606529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2w5cwK8XbSFGxDqfK30osjQtmeJsKzNJ6zEPN2tluG8=;
        b=W9l7u4jSJPowTRGpoF5Y+WO8tV4eIvd1bgcwv3l0M39l4TmP6XbAJlDJWBNI9rAmy1
         6PlNnTUS+YUphz/Z0ciAhO+sE/PXrL/Oylo9SP5M65UX8KmmPjaPsz8bwQfSAc5416gu
         0nTJnFO8Yp4fo7eZ/jQq2F05DRk5Pyo/Npv0RPr1iE/JNb0z6s/wykDg73zH+tT1vn0Y
         x25kfOtNlJwpLAYPsrUGefPlGxopjd3+Jq9MqPxi0d8lI85oIPbxntdnnSf4CLDxaTTL
         gcM87ne1Xm8ILScOCh+D94/ur8QEdKgfyao8roLSbVGU2xxsmdujkbQAO0s+3QfrIkiw
         r5NA==
X-Forwarded-Encrypted: i=1; AJvYcCV1iu70V1P+yJ7oT3xedmSOAuTiMbcqDtSvikL5BJgk3CX6pA4QTZAwBQ6enxAsfNPN8zdq9EnDNPHobXDeD3wCGyWAgCNg79+Icub7Xh4ky4RXEc1DS8ixVPn0DRQNHTyuF4Krrl8eehmjwVwr50INJl0YMiyUOsZfMyaShr//txCOesNPK9dxP9FUCoMGVfggNtgldU4QjIUyWSLSU//bFfE=
X-Gm-Message-State: AOJu0YyaEQbdihbMryCmjcag2VlvlhwmSj4W9btjVQmL8n4QeuYY9cRP
	3gRFGZ2ias7YIga37fd4sRPE8YNtMFlf+94NjTAmCGnElHcSP/Lm
X-Google-Smtp-Source: AGHT+IHqN/pcJrFCPaAXhwmcfozIFaw2VgqoBy+kknbmBBKHZfUSfWAGeWwJYiinqWm4VxTDHkz/Nw==
X-Received: by 2002:a05:6a00:194d:b0:6e0:50cb:5f0a with SMTP id s13-20020a056a00194d00b006e050cb5f0amr4679946pfk.12.1710001729375;
        Sat, 09 Mar 2024 08:28:49 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id b125-20020a62cf83000000b006e34008d0c3sm1499013pfg.100.2024.03.09.08.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 08:28:49 -0800 (PST)
Date: Sun, 10 Mar 2024 01:28:47 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] dt-bindings: PCI: qcom: move to dedicated schema
 (part two)
Message-ID: <20240309162847.GB229940@rocinante>
References: <20240205-dt-bindings-pci-qcom-split-continued-v1-0-c333cab5eeea@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205-dt-bindings-pci-qcom-split-continued-v1-0-c333cab5eeea@linaro.org>

Hello,

> Please take this patchset and its dependency via PCI tree.
> 
> Dependency
> ==========
> This depends on:
> https://lore.kernel.org/all/20240126-dt-bindings-pci-qcom-split-v3-0-f23cda4d74c0@linaro.org/
> 
> DTS fixes for interrupts will be send separately.
> 
> Description
> ===========
> The qcom,pcie.yaml containing all devices results in huge allOf: section
> with a lot of if:then: clauses making review and changes quite
> difficult.
> 
> Split individual devices into their own files, so we get rid of
> multiple if:then: clauses.

Applied to qcom, thank you!

[01/03] dt-bindings: PCI: qcom,pcie-sc8180x: Move SC8180X to dedicated schema
        https://git.kernel.org/pci/pci/c/d5e74915cb23
[02/03] dt-bindings: PCI: qcom,pcie-sc7280: Move SC7280 to dedicated schema
        https://git.kernel.org/pci/pci/c/756485bfbb85
[03/03] dt-bindings: PCI: qcom,pcie-sa8775p: Move SA8775p to dedicated schema
        https://git.kernel.org/pci/pci/c/544e8f96efc0

	Krzysztof

