Return-Path: <linux-pci+bounces-12576-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36556967B8D
	for <lists+linux-pci@lfdr.de>; Sun,  1 Sep 2024 19:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA4E7281515
	for <lists+linux-pci@lfdr.de>; Sun,  1 Sep 2024 17:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017E023A6;
	Sun,  1 Sep 2024 17:47:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6638F53E15;
	Sun,  1 Sep 2024 17:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725212876; cv=none; b=sxYPFo+TXDbLv4u2UHEAb5nlH8m6c7XWB/QN2kMGl/UAw41e3jSNgBg9HYxDjRtus0x4KvEIdHc9p0S3voGvb7vvjPTb7+n6aV2R0p9Bg3H6NVhpn2kCgE+EQMKKknBKnv5swwFNhVPuio9+AGQp+CprNv2FqW7dcpfNtKuixOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725212876; c=relaxed/simple;
	bh=Xmc/hEdWTjAatvH4xDGup5Qa9uRF6QYKHs5Vb3yKznU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ss3Bb+KBNeQCGfrzmFPEtbk8sGJvB7kCE5aMVIX/r+L/MuzpLYTZCmA5ToKQrReN/lt102wrsIzMS+wk/0Z2L4jmfLuuPewD54w7LT/zaLcH+yRzGnhyplmuUN4Jcwu9EWPN602RO0WrsfXfuwjsGtcz2YMNUxXbF5UKGHHYU+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7cdf2ac6130so1002598a12.2;
        Sun, 01 Sep 2024 10:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725212875; x=1725817675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJYJQ1zlbAg/HiswfyOpJTEd1H+q6QzgGzUjsdDbFPY=;
        b=UJKRPrJ0uNU+egfc8HnkDCL2uvkws3XZbNd5Zc4pmLEAHeZCEnSRWXflnaU5Q4TNQW
         GZTjBk3mYaK9v/G6hpKWMPv2XGy3mY5vArGAAC6MiMK0YefjMpUYV5IMmGIeHwkq2pgC
         c37YeTslwVGCFe+E+QIaV5ZsMaJRNRfyKQM3ooTGv9zRS90CpUjDzulKKXLmJNYEXaU4
         9waehK7uNXReodhM9KHVeDTfYh0RvOMcRsMpYDgdFfX5eDWTVsfjv38y8ZqVdp2obNsZ
         BDVpLrgGRlS3DkXRQvYbPFeS3QoxexBFVpPVpMKYYxHOF5qYWeizMYaxUR4OeDHE4DBZ
         03ng==
X-Forwarded-Encrypted: i=1; AJvYcCUv5CKwu6W3+mOdkrUkgFOHI8UYcMZ6orD1WBcaPXT+8Ao+KIwpFepRkFJ3aeAsz4IHzUaNUBq8PQ6U@vger.kernel.org, AJvYcCV8Y4Mk/FY80Obgw19kfpGyI/ykkr9PqNdy9sHNhos92e/qjrSQiblDnFh0YcJDanYDSAkXNAd0y0awXVZq@vger.kernel.org, AJvYcCVjl13GQmDvxGMsvSDVMDnVF9zRcDbZhkMrsyXPivtElGAB81U1cMHmuatGtXBVS2JyTXqMwCJSwlmI@vger.kernel.org, AJvYcCWTosf+r1reefsNdCXsQhKawJ8ZRIgHai7eSQmS2Ll3ByUQ3OaKu1J+qqn4cRmm27UCdOb0bVMzUIlFl92K6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNH+kGg5fWooOzQKeTyGciSLDg+3YFCLl06f28xx4+D6oKL1G/
	CM4ZtMwBY29cYIH9lzxWOt9qfzdHNbl2M0ut/DhDwomKVcZOyhPO
X-Google-Smtp-Source: AGHT+IEneXWt9Gk0g2RG61bxa1zZfsP3uwuDaYDhRSJVUYa7KkQxRn2HCtoVJzwC9/ELD2s3tYj9IA==
X-Received: by 2002:a05:6a21:3a44:b0:1c4:a49b:403 with SMTP id adf61e73a8af0-1cece5e24c1mr4521500637.46.1725212874415;
        Sun, 01 Sep 2024 10:47:54 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2051553648fsm54619285ad.172.2024.09.01.10.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 10:47:53 -0700 (PDT)
Date: Mon, 2 Sep 2024 02:47:52 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: manivannan.sadhasivam@linaro.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v4 00/12] PCI: qcom: Enumerate endpoints based on Link up
 event in 'global_irq' interrupt
Message-ID: <20240901174752.GL235729@rocinante>
References: <20240828-pci-qcom-hotplug-v4-0-263a385fbbcb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828-pci-qcom-hotplug-v4-0-263a385fbbcb@linaro.org>

Hello,

> This series adds support to enumerate the PCIe endpoint devices using the Qcom
> specific 'Link up' event in 'global' IRQ. Historically, Qcom PCIe RC controllers
> lacked standard hotplug support. So when an endpoint is attached to the SoC,
> users have to rescan the bus manually to enumerate the device. But this can be
> avoided by rescanning the bus upon receiving 'Link up' event.
> 
> Qcom PCIe RC controllers are capable of generating the 'global' SPI interrupt
> to the host CPUs. The device driver can use this interrupt to identify events
> such as PCIe link specific events, safety events etc...
> 
> One such event is the PCIe Link up event generated when an endpoint is detected
> on the bus and the Link is 'up'. This event can be used to enumerate the
> endpoint devices.
> 
> So add support for capturing the PCIe Link up event using the 'global' interrupt
> in the driver. Once the Link up event is received, the bus underneath the host
> bridge is scanned to enumerate PCIe endpoint devices.
> 
> This series also has some cleanups to the Qcom PCIe EP controller driver for
> interrupt handling.
> 
> NOTE: During v2 review, there was a discussion about removing the devices when
> 'Link Down' event is received. But this needs some more investigation, so I'm
> planning to add it later.
> 
> Testing
> =======
> 
> This series is tested on Qcom SM8450 based development board that has 2 SoCs
> connected over PCIe.
> 
> Merging Strategy
> ================
> 
> I'm expecting the binding and PCI driver changes to go through PCI tree and DTS
> patches through Qcom tree.

Applied to controller/qcom, thank you!

[01/08] PCI: qcom-ep: Drop the redundant masking of global IRQ events
        https://git.kernel.org/pci/pci/c/3858e8a5ea71

[02/08] PCI: qcom-ep: Reword the error message for receiving unknown global IRQ event
        https://git.kernel.org/pci/pci/c/95bebcbd657c

[03/08] dt-bindings: PCI: pci-ep: Update Maintainers
        https://git.kernel.org/pci/pci/c/99244b999dec

[04/08] dt-bindings: PCI: pci-ep: Document 'linux,pci-domain' property
        https://git.kernel.org/pci/pci/c/ada94d00620a

[05/08] PCI: endpoint: Assign PCI domain number for endpoint controllers
        https://git.kernel.org/pci/pci/c/0328947c5032

[06/08] PCI: qcom-ep: Modify 'global_irq' and 'perst_irq' IRQ device names
        https://git.kernel.org/pci/pci/c/bba1251edf85

[07/08] dt-bindings: PCI: qcom,pcie-sm8450: Add 'global' interrupt
        https://git.kernel.org/pci/pci/c/6efd853303a5

[08/08] PCI: qcom: Enumerate endpoints based on Link up event in 'global_irq' interrupt
        https://git.kernel.org/pci/pci/c/4581403f6792

	Krzysztof

