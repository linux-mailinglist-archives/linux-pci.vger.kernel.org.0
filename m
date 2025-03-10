Return-Path: <linux-pci+bounces-23378-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9F5A5A5AB
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 22:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 131C43A7720
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 21:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FC91DF72F;
	Mon, 10 Mar 2025 21:07:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918631DF73B;
	Mon, 10 Mar 2025 21:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640871; cv=none; b=Dt7pDuMv74Fa/NMAbamTIRh+c8O42ltJsyxBeu3m2quoRJrqffo3Q/70PVmtaO0ap3BGxpSxH6YjtiGBQKIk5O9qqcOp2ACDCM11foZNyBn5TX2bwJ4Ev24EIpO09pO4THuJyOuq3L/C0OewUKy5yT5H2muvIMcZzvHci7fpvt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640871; c=relaxed/simple;
	bh=QnQz6XBkpBOMKQ6PwrmcAnUjIKRFzxIkV3rImnzlsjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uf3h//OmnoEYIOkcq3FuO5ORJObj+Yue3mmywwUZsv+G7Guxcsl7ImZZ3fNaCJU8nj4F8f+ZqLDyEuGNsoOvy2tqQo/ygIjLS77WybzUbjdJLzm6fnAn5dqm6GjCB3hdRXbLinXvd11OqsgFKznC9fVnXbZ4N42vX8DmpIFZWFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ff694d2d4dso6732450a91.0;
        Mon, 10 Mar 2025 14:07:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741640869; x=1742245669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1AJb/5nJjGuAi7KNzBsrlIYLjJOf6yj55dAqxN2Vz8=;
        b=YUp3K+Pxd7wDt/K84SvDT6FMs26gWvKxrKaLmRj7MQxNVvRipZBU39WXR8mBd7acM3
         mUg84AnTaN8/bNjtpodBMmOttZYHB8yzS18rnNNhyURN94qmaFDHD7X6thF9dv7svWOh
         Fy3FnEdKuHyX4Hra4cKPZf/oREPaS5xHREjo1Z9rBVyFTtlXCT8bTK7H2bbuzCszrwd+
         nRcTmCREKTPPUpXiN5EY7Fi2boSIROzt2a5yGAlr5pxsQ8BNMbs4Lqf7M9IlfVLexlyk
         7qRumo3JDlxAJjvrl1GsGOw6j7ChUii3xBq8ZSxmMvrtXyh3YLLm6zYyywXJjbHY4xAx
         Etrg==
X-Forwarded-Encrypted: i=1; AJvYcCUK8aGQOB1yCB5pkFYWqqEkl7b8q5LGI7FQJfvlK2tupUobh/2t4uyni5wj4UHAqOyRYSu9yEhNSi+z6VQ=@vger.kernel.org, AJvYcCUyBPE4D+trUegn/iejf/biVQn7w08k4TsJMkhZbrxtW4qT4lKi8r06JmelVbYsdv+Ex9zj1h7p@vger.kernel.org, AJvYcCVg9qfYxcMED93Embc1vIqnKRUH/k1Gg3ILGDiEi4ahD1++fie6CjZBG8XlgVLSe90ll/JX+mVpEmux@vger.kernel.org, AJvYcCWdu6BaBdadKHTsdhIpDm4ipPkcDZk6+jhe3mxeyKdJ2KC+pKTW/uHAsT3ydgbMH5AGZB6BEA2RN8Yj+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWutSt6QlmMj78b6QsmC7d8YUhnp5OtnoCYt9Hm6JGlO6RG4r4
	L6W5hMLjwhpGdao4+lFOcWBR0QYfSF0dugLZDpKpKTxt08HjdkUn
X-Gm-Gg: ASbGncveQvfWjWrnxx0s2grPFGsmSyi7XV03cDfBJ4h2VRPb5mqn11srqlBaj+AW7q7
	9SCXoHWEVwvCO2J8aNZHTx/IEukHde+IszGjab9lPXGVCtTSWXuAWT1WGm9/4jPSR83LFAYlVuA
	B2bxbNPkfq0jC4pdyA8fFP1Og+Wf6B7/ffaHQTCc71VU8vkBiZ3GbgRg7hpjS5Ot1eKJ++36HMD
	r5Xv+/5+lxXpgvdxQRfxvmsYlrvdQsONskjQOeRQVNUF9jzoZw/CussD3C5TDaFasdYtOp/Xsjt
	+xJqBOQ8TomxAcdhnhJiJesEndykXt8Dzm+KLL0+brab3JOspP0afrqAxCML/tuGcdatvpepedj
	qN+A=
X-Google-Smtp-Source: AGHT+IGc1KBuVi32oJuLLXoUmcYMGQ+dxMVqfvMg27687+GtmjFcAnXL+mt7Wixdqbol46Ej6Gut0Q==
X-Received: by 2002:a17:90b:4c44:b0:2ff:4e8f:b055 with SMTP id 98e67ed59e1d1-2ff7cf14526mr24048537a91.35.1741640868746;
        Mon, 10 Mar 2025 14:07:48 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-300fe40c28dsm706225a91.33.2025.03.10.14.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 14:07:48 -0700 (PDT)
Date: Tue, 11 Mar 2025 06:07:46 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, vigneshr@ti.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, rogerq@kernel.org, linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com
Subject: Re: [PATCH] PCI: j721e: Fix the value of linkdown_irq_regfield for
 J784S4
Message-ID: <20250310210746.GA2377483@rocinante>
References: <20250305132018.2260771-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305132018.2260771-1-s-vadapalli@ti.com>

Hello,

> Hence, set 'linkdown_irq_regfield' to the macro 'J7200_LINK_DOWN' which
> expands to BIT(10) and was first defined for the J7200 SoC. Other SoCs
> already reuse this macro since it accurately represents the link-state
> field in their respective "PCIE_INTD_ENABLE_REG_SYS_2" register.

Can you confirm for me that the following use the correct macro?

  333-static const struct j721e_pcie_data j721e_pcie_rc_data = {
  337:	.linkdown_irq_regfield = LINK_DOWN,
  
  341-static const struct j721e_pcie_data j721e_pcie_ep_data = {
  343:	.linkdown_irq_regfield = LINK_DOWN,
  
  347-static const struct j721e_pcie_data j7200_pcie_rc_data = {
  350:	.linkdown_irq_regfield = J7200_LINK_DOWN,
  
  362-static const struct j721e_pcie_data am64_pcie_rc_data = {
  364:	.linkdown_irq_regfield = J7200_LINK_DOWN,
  
  369-static const struct j721e_pcie_data am64_pcie_ep_data = {
  371:	.linkdown_irq_regfield = J7200_LINK_DOWN,
  
  375-static const struct j721e_pcie_data j784s4_pcie_rc_data = {
  379:	.linkdown_irq_regfield = LINK_DOWN,
  
  383-static const struct j721e_pcie_data j784s4_pcie_ep_data = {
  385:	.linkdown_irq_regfield = LINK_DOWN,
  
  389-static const struct j721e_pcie_data j722s_pcie_rc_data = {
  391:	.linkdown_irq_regfield = J7200_LINK_DOWN,

I am asking as some use LINK_DOWN, so I wanted to make sure.

Tht said, the following has no .linkdown_irq_regfield property set:

  355-static const struct j721e_pcie_data j7200_pcie_ep_data = {
  356-	.mode = PCI_MODE_EP,
  357-	.quirk_detect_quiet_flag = true,
  358-	.quirk_disable_flr = true,
  359-	.max_lanes = 2,
  360-};

Would this be a problem?  Or is this as expected?

Thank you!

	Krzysztof

