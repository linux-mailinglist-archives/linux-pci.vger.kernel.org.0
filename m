Return-Path: <linux-pci+bounces-1085-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE538154E0
	for <lists+linux-pci@lfdr.de>; Sat, 16 Dec 2023 01:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22C1BB226FD
	for <lists+linux-pci@lfdr.de>; Sat, 16 Dec 2023 00:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B39365;
	Sat, 16 Dec 2023 00:14:59 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899E5EA0;
	Sat, 16 Dec 2023 00:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5cd68a0de49so790650a12.2;
        Fri, 15 Dec 2023 16:14:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702685698; x=1703290498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/Tse2JpQM53tgTMU+ujwUWwujQBnwenRSj1K9g6jDs=;
        b=I3KR8xqd1n06Q8Tz6AYUqYxtcVMPlOwE/37oAaf6MXipmkMxt9YnWeml/kqbQUuFP6
         6SzeyI7ianGKvDFahhD9y1L1/26t2EddEaQP2dPt3nWKRMKjbWz37pnuC8wQjRlJzkK7
         6Nm7S2ZyCRWfAS28V4hOHvYkks154x3SiXAO2RPcXmjiopLaiHgPADT/xLpASasSown+
         vQW1h5gvTVRnzFP7Po4EuoRN6rDCkhZXt0ieN6dC4ZWun0Uqw3bfU8S0MJo48ldc7dKj
         noR3F8sGL3buHWiCHzLBJH0izlMqzVzW6zsfnzZImpAtKAc0rRVMWLXe80IH4UOdDDZu
         2lFg==
X-Gm-Message-State: AOJu0YwHag+Tuepq+XNGhIlMqapc+vsQd85MGhHpuqIVpvtkILDKD1zL
	P6jvsrVHF5nLDweM2Wt6xRc=
X-Google-Smtp-Source: AGHT+IElMnr7jeyV3KLfYtgH5nloy+nAE6pdj4lom6ZvIr/4jAl9554ZbQbph1yr8YphvCHbnfZ4wg==
X-Received: by 2002:a05:6a20:8e01:b0:190:2d3d:b08d with SMTP id y1-20020a056a208e0100b001902d3db08dmr17005165pzj.69.1702685697880;
        Fri, 15 Dec 2023 16:14:57 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 29-20020a17090a1a5d00b00280070a2613sm1262509pjl.51.2023.12.15.16.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 16:14:57 -0800 (PST)
Date: Sat, 16 Dec 2023 09:14:55 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: PCI: qcom: document the SM8650 PCIe
 Controller
Message-ID: <20231216001455.GE1570493@rocinante>
References: <20231128-topic-sm8650-upstream-bindings-pcie-v2-1-b72e2d13bcf1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128-topic-sm8650-upstream-bindings-pcie-v2-1-b72e2d13bcf1@linaro.org>

Hello,

> Document the PCIe Controller on the SM8650 platform by using the
> SM8550 bindings as a fallback.

Applied to dt-bindings, thank you!

[1/1] dt-bindings: PCI: qcom: Document the SM8650 PCIe Controller
      https://git.kernel.org/pci/pci/c/41f757713ac3

	Krzysztof

