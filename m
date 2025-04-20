Return-Path: <linux-pci+bounces-26300-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A187A946AC
	for <lists+linux-pci@lfdr.de>; Sun, 20 Apr 2025 06:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61FB718940EC
	for <lists+linux-pci@lfdr.de>; Sun, 20 Apr 2025 04:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A45B18DB13;
	Sun, 20 Apr 2025 04:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x0++PaRm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE5819E99C
	for <linux-pci@vger.kernel.org>; Sun, 20 Apr 2025 04:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745122509; cv=none; b=kThKj55FfisbmNuI0W7b5fzkDEQvWo8tl0a2dNNZZOEVm+FTkxkyuhPCwktmmpq0+8WXIJ9Y6RFZvEhAlOihKWVYoNAEPcHh3eq3IrmgPmTVqZx8T7FjDGgHNIl8x7gykxSwHt5xh2n+qq1/9kpJHFIWnB6AvN7qHiqMydThfLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745122509; c=relaxed/simple;
	bh=l/JQQddlhPynwDPY0hqUzEhGKbXSBZE37ftjqTkM7uw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tMS0fSTMuEA+Qh6px/C4PC0BmSf5LOqiGPrRDHhPFmo/WI+s8I+Sbne+fRETxNUfSiJ+m996w4q4G3SjboTd7q3S9NNCrjUWPhZyCyU4ZG7l1XsYiFCHj2G1pisUh4fhhLm+mPByed99kJbW7p2ZCNP5bLAFLTlFpUp9bcYncis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x0++PaRm; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22401f4d35aso33621465ad.2
        for <linux-pci@vger.kernel.org>; Sat, 19 Apr 2025 21:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745122507; x=1745727307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWq/yk6egdF/dXjQzH1qk63eH8P6QSiGPtgR+xWOm0g=;
        b=x0++PaRmLDoHAJ78CbRoeeO9R+zELfcHVkmVZ8WBOWNAcaFAhEWISbLWimo6WRA9bO
         HlMIs7fF/8kuwMRdXKFs8xWVMV+eHzqCwIm3m9PNX6IaJL3MKY0ac32kiC33DhJSGHjC
         uQ7GuwIxisQbaeId0vOxL/TyrX1LeF+vcAsAwc1h4Gj0OY5h4dwBd/SD9fs73qqpU3W9
         rnTeEaFbhW/hWTL1bk+M56LcOD6OppbnzG3/vwmL6zo/MqYkUj5vedlPLfXldCZjWlFf
         bENaQk7iIgvKOM0MbX/5wRNJHHinmrz7HJlinhfWb5m/CL8HPJMwivT8urp/Y82KzPyh
         SGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745122507; x=1745727307;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BWq/yk6egdF/dXjQzH1qk63eH8P6QSiGPtgR+xWOm0g=;
        b=QwpauLqhQN33MbA45XXL7fHeaMoAscLfk5XO3iva0C1op85H1jNrnQRbdSLX0u1C38
         0nvZZYuety8aLvHn7gjkijeKeQASzfgHId4ecUdsUSJLJ+FBJn/97U71N79JJku/4ySk
         HAE+VodDjJgXeJQ5+tzbMyErV4GtbEW2SZ2Dnud79VAkNnETZs/EUrmjxy+qGEFSk43Z
         FgQ2Vw8E321heXvSODHKT9sWwm9RjHwkeujCl5ia9xjw/LuiM6yPDjtZ6cPQ0UExWg2Z
         r/VYzRt4RabSD3vay6871Kktx8IhsTcMGrexhn+V5pFmUJOhgvHK6zEVSTE6lPpWZCam
         +JbA==
X-Forwarded-Encrypted: i=1; AJvYcCUNSQwPzrcj3C5uDdJnHml1YyOtZO2IREOFKMPvfXSvG+6WpLcjsXN1VVXuV8xZxkHYEvbBc/RLP/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg64NV6MdAIVYQ9chH9HCZ0VjcZ6E7xmDUriJKhND0hqaaxQ7x
	A0McwjHGgIGo/IOvxygjsLemyOeYnvdJwCwxuPwQNKu30H/ABJxcO2b0Tpv/uQ==
X-Gm-Gg: ASbGnctzzreqXK8kH1jsr54hyD7+nHgbHGmMEV31I4Z4rRY8hlDbFIHFaCGzMk6WmQ2
	wf8Jsh7iRKyuXsbpEufnSzqrMCNJiXxK/ucNFkGeVJ/6Yw1nBt3YxhFbjXE4NttMZh6UvOK2Psw
	Z9Y5PuJr2qt1fSZ23nmeNHGfU1PWOfoCgKaXh4ygQxVYJbKndf8CidkXZfymOh6sru5lIK9hsjy
	7v/UFKeCa9q5QCFVCFZKML56O2TPZ/QNlioxRqfhRCNO6IyVXF428u16zUGpdz5Zzc1a+IoXVHL
	99TUwf6/8/X6iFZWA/nXZgB16Ea4yiO2NAST0Yc2A+y1JfMZ3iAdLA==
X-Google-Smtp-Source: AGHT+IEwT70MqJZh1REZd2GwFUgsulJR3hGmpXtb4k2hyt7Uf4STg11Rb+IyyGIokskY4EblKXX3ZQ==
X-Received: by 2002:a17:903:1a24:b0:223:47d9:1964 with SMTP id d9443c01a7336-22c53607709mr128586875ad.34.1745122506897;
        Sat, 19 Apr 2025 21:15:06 -0700 (PDT)
Received: from [127.0.1.1] ([36.255.17.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50fde851sm41412575ad.239.2025.04.19.21.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 21:15:06 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: Frank Li <Frank.li@nxp.com>, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250404221559.552201-1-robh@kernel.org>
References: <20250404221559.552201-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: PCI: Remove obsolete .txt docs
Message-Id: <174512250279.7011.5486812509432679947.b4-ty@linaro.org>
Date: Sun, 20 Apr 2025 09:45:02 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 04 Apr 2025 17:15:57 -0500, Rob Herring (Arm) wrote:
> The content in these files has been moved to the schemas in dtschema.
> pci.txt is covered by pci-bus-common.yaml and pci-host-bridge.yaml.
> pci-iommu.txt is covered by pci-iommu.yaml. pci-msi.txt is covered in
> msi-map property in pci-host-bridge.yaml.
> 
> 

Applied, thanks!

[1/1] dt-bindings: PCI: Remove obsolete .txt docs
      commit: 7ab8db9042cb37222bebf77beeb1ff4df0789a84

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>


