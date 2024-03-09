Return-Path: <linux-pci+bounces-4692-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC3C877234
	for <lists+linux-pci@lfdr.de>; Sat,  9 Mar 2024 17:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8FD2281980
	for <lists+linux-pci@lfdr.de>; Sat,  9 Mar 2024 16:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EEF4594C;
	Sat,  9 Mar 2024 16:28:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8988E383BE;
	Sat,  9 Mar 2024 16:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710001681; cv=none; b=WZrkiaPOjdHTGdqN0MnbYltiS7o8UDD1O9bakkMbXtzfeclOXAW8cKcUQgZGCrBZdipiWvbg+9ONKfjU6ZRQpEv7LZkoqKNUGa+VLcsjjUu1EKB7QBaus4zSeXnZnVLtwWiMBtLvU7zQhzGsNXJdXfJP5PVunGeJyL4sSl4lbZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710001681; c=relaxed/simple;
	bh=gawdx09fEWv77uFcSaCOqsu/CQ1Zy2ufMmqIGkv3hpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkpggEMqgHV/Dvb3pHfONm8DVplG7/ctzHQdFtv1cLAKHry8+OzNc4dB4JEvN0GcJ6sda1CtvEBbGgA0e/0Bv1pB1jGKtpP+OwQLZEpvObCi1mnazcBwZxJJIyR8i+H/rJKhVpHeXfthc0Tgy/EpHT1xR0ccI9ng/4Fpi/RQiZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e62c65865cso2642848b3a.2;
        Sat, 09 Mar 2024 08:27:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710001679; x=1710606479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XngN9Yh6PJNjzunlynrOgFFMvdhheJ+fAGDHAv8VoSo=;
        b=SMZrobtuuF9JlVPAPK+FN3GduyqAiyQ6HoA+tX8YlKbh/VxFuoUQqIUYma8MwX6Afj
         fY8zdQYIluP3/Wvfr/ANRlMSdyq07RrLRFOqd2gkzZ6VpwyoJ3+D/id01Lr29oWKEQvk
         oyuhav/qQypnqJ9cBm1X6JoZ5mMrDScwNxmqzkwE8r3IkX1zsnsSfWEuQgm01NGrBqkn
         1yCE108ukOgNFVjQN//JiYYr1RP/Bbv04WiaqwMhnVpuGTV5ZeRE9NMO8fDuo1wq+npC
         qHu56d0FMXqmsMzzJ0bLpgkkoZ6B9mSZMs4kH9tig4JOpJ3JGnvhVycThbF5cMRcH4IA
         T0OQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoaMrJjePz91t+IzcGDOOm2IvyrTdzHBOx+oqB3YCaNjRbwdwjlRxr2Kfze8kcQBF4uXElwHYMnyQ98Ctr/yD5db+kQrKD7Bg9oupCO5nJDr1WGxVyglKkUb/r4/PIzFGSrnVDPyVUYUSYyU8fFGHz4ckV8AmvhWl3mH5eTGfgAUQdLJCGOgEbEYPiaSHYszQ9/BiWAT7ZcL18zcbtRmZokmg=
X-Gm-Message-State: AOJu0YxUL6sTLLWewzQmMr4eyS305+zAVlpqBetQC+x1vyA6wFiK0iMu
	sjsH04l4eHUgmFd/dwujJu6DjWw50IOZXBoAg5bKfWL91u85SGa9
X-Google-Smtp-Source: AGHT+IEoZjJjChi0ytw88tfb9H2v1HQ/DS+m0c5yt85oP0DWVaiwKZ+/hEH5s3Ge0OK7urWxBkXZRQ==
X-Received: by 2002:a05:6a20:49af:b0:1a1:7cec:4c37 with SMTP id fs47-20020a056a2049af00b001a17cec4c37mr1751210pzb.52.1710001678747;
        Sat, 09 Mar 2024 08:27:58 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id x18-20020a17090aca1200b00298e11b600dsm1410796pjt.27.2024.03.09.08.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 08:27:58 -0800 (PST)
Date: Sun, 10 Mar 2024 01:27:56 +0900
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
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v3 0/6] dt-bindings: PCI: qcom: move to dedicated schema
 (part one)
Message-ID: <20240309162756.GA229940@rocinante>
References: <20240126-dt-bindings-pci-qcom-split-v3-0-f23cda4d74c0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126-dt-bindings-pci-qcom-split-v3-0-f23cda4d74c0@linaro.org>

Hello,

> Changes in v3:
> - sm8450: add missing allOf: to common schema, which also fixes issue
>   reported by Rob's robot.
> - Link to v2: https://lore.kernel.org/r/20240125-dt-bindings-pci-qcom-split-v2-0-6b58efd91a7a@linaro.org
> 
> Changes in v2:
> - Switch on SM8[123456]50 to 8 MSI interrupts.
> - Simplify SM8450 clocks.
> - Add Acks/Rb.
> - Link to v1: https://lore.kernel.org/r/20240108-dt-bindings-pci-qcom-split-v1-0-d541f05f4de0@linaro.org
> 
> DTS fixes for interrupts will be send separately
> 
> The qcom,pcie.yaml containing all devices results in huge allOf: section
> with a lot of if:then: clauses making review and changes quite
> difficult.
> 
> Split common parts into common schema and then move few devices to
> dedicated files, so that each file will be easier to review.
> 
> I did not split/move all devices yet, so if this gets accepted I plan to
> send more patches.

Applied to qcom, thank you!

[01/06] dt-bindings: PCI: qcom,pcie-sm8550: Move SM8550 to dedicated schema
        https://git.kernel.org/pci/pci/c/b8d3404058a6
[02/06] dt-bindings: PCI: qcom,pcie-sm8450: Move SM8450 to dedicated schema
        https://git.kernel.org/pci/pci/c/88c9b3af4e31
[03/06] dt-bindings: PCI: qcom,pcie-sm8250: Move SM8250 to dedicated schema
        https://git.kernel.org/pci/pci/c/4891b66185c1
[04/06] dt-bindings: PCI: qcom,pcie-sm8150: Move SM8150 to dedicated schema
        https://git.kernel.org/pci/pci/c/51bc04d5b49d
[05/06] dt-bindings: PCI: qcom,pcie-sm8350: Move SM8350 to dedicated schema
        https://git.kernel.org/pci/pci/c/2278b8b54773
[06/06] dt-bindings: PCI: qcom,pcie-sc8280xp: Move SC8280XP to dedicated schema
        https://git.kernel.org/pci/pci/c/c007a5505504

	Krzysztof

