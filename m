Return-Path: <linux-pci+bounces-1081-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D77B8154AD
	for <lists+linux-pci@lfdr.de>; Sat, 16 Dec 2023 00:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 776AA1C240F2
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 23:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9DF18EC8;
	Fri, 15 Dec 2023 23:55:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C7445BF1;
	Fri, 15 Dec 2023 23:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5c6b9583dcbso1040757a12.2;
        Fri, 15 Dec 2023 15:55:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702684540; x=1703289340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5a73P8Z2lUUO9uonNb1xntoA8P+1UF6W+MLVA6xuoQ=;
        b=G3DLZtDXgT2r2wUrYhoJhDtKwN7b6HHHPFqKyw5NY3r9/1Qvp8W5AgCHts4j+L7Bh6
         d1L3gaQYylHamJv63neTHXsPfxC2/oKz+UaeHNtM2mOWaqY948bPIsCo5NEy27t/Ul2Q
         p5vRak4jqyuLwmvnkYW1xMptOnhG4rR3IkRtYzyGVDNFuNvf1xT02u4GwtrHEbkCgb7l
         usnLYc/dMjSNIdGIjf5tWatKdQLQ9dEFAU4uDjZNlY061QRkusAjaVimDTynw2qijEkz
         6BZBe8nFSOHjfUCG3f+eBSTJWbya2z/YUrAba1aXub7B4hg26SpqFMAz9IscndWSQSw5
         8z0w==
X-Gm-Message-State: AOJu0YzkzbzmHg5h2ilfOAHx6dCg8BWAMEmVs/477FtK57igtQ5F+UhL
	amQbFL/Fa3k5y8TIFeQnnYk=
X-Google-Smtp-Source: AGHT+IEy7wgEW48bdoKoHAehQFxnzd1CZkeTDN+7v1Lu6/U1kj4wf7olTFqJLNKy8Y8AK3FUdsaT8A==
X-Received: by 2002:a05:6a20:7d8e:b0:18f:c81c:4484 with SMTP id v14-20020a056a207d8e00b0018fc81c4484mr15647305pzj.29.1702684540426;
        Fri, 15 Dec 2023 15:55:40 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id pa8-20020a17090b264800b0027df6ff00eesm15708471pjb.19.2023.12.15.15.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 15:55:39 -0800 (PST)
Date: Sat, 16 Dec 2023 08:55:38 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: PCI: qcom: adjust iommu-map for
 different SoC
Message-ID: <20231215235538.GA1570493@rocinante>
References: <20231208105155.36097-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208105155.36097-1-krzysztof.kozlowski@linaro.org>

Hello,

Applied to dt-bindings, thank you!

[01/04] dt-bindings: PCI: qcom: Adjust iommu-map for different SoC
        https://git.kernel.org/pci/pci/c/4791c44c0a98
[02/04] dt-bindings: PCI: qcom: Correct clocks for SC8180x
        https://git.kernel.org/pci/pci/c/f2ab5a2455d9
[03/04] dt-bindings: PCI: qcom: Correct clocks for SM8150
        https://git.kernel.org/pci/pci/c/a711253d5f70

The above will go through the PCI tree.

	Krzysztof

