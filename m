Return-Path: <linux-pci+bounces-4707-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3D98777CD
	for <lists+linux-pci@lfdr.de>; Sun, 10 Mar 2024 18:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7DD01F210A9
	for <lists+linux-pci@lfdr.de>; Sun, 10 Mar 2024 17:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB59A25605;
	Sun, 10 Mar 2024 17:45:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C71B21115;
	Sun, 10 Mar 2024 17:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710092746; cv=none; b=e8/I4fv+sjYdR4hx3q0bPAor2djXiIx4cpSO/3ogMHHOSIoDzGitY8ZhSqwilq9fF9nyHTFF3dZSZeyDdlZrpfqF9X8mQ+qDfBsG8RsXZQqjh0xcUrZXepyrgotHUUXeuGoUWjiNxc2oVjLine2OeGHjrBu7OMnCcDQpuUkj9Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710092746; c=relaxed/simple;
	bh=hrQnUxJLirdyrN46Viu7HBOjLYptBIcrVHgHTEz5FvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBWaLukqt2onftfdiVIkmb4hiMpV1AJbbdFWtNHFBo7+E8jTBe8dXRwyq9Xf8yGT9oMkGO8mBzqsMVBlG4LW/jlBt5sv7+4cLO1Nn9fEjcMG958iTsHsX59j70118KWeBWefw429hR8vgrBR/wfWaSuxxAI2uM8P2L0+0vE1fCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6ddf26eba3cso2824790a34.0;
        Sun, 10 Mar 2024 10:45:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710092744; x=1710697544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7iPTCl8r4EkA4EfZ5hPRJf4v1rg1K2hUgK6qm67XQU=;
        b=pq65PE40YWaeoc1lsDTD4P9ekbP5WOqEdGE8FYI8IvfCSjHU2wYEXirtpw2tqK+fkl
         ZPMU2Bu8e3yKBhabnM9/aCtJYsthTk4t0+snwJlASXm8Nwi7a3/tzN6TeH77CoUlENBn
         ywIrpX9fu+eAo5CbppmCghyGR2r5n+dfqiDXwdazI7+8DEdbGLOGiK7To1u69VixBWMl
         srR1XGMQiKMWrYs/MEge+AHYtyndUJDobo3eaQQAZ8XDbAsvYwpXMJyBskx/GcRqk36w
         uRcVh1Lu+1I15X5iT0Fu6FqdCf0rVF/7F+eZJiI8KcDuNCrC+gC17H3vmBfSAlpVxl8R
         kEog==
X-Forwarded-Encrypted: i=1; AJvYcCXmSVxQBQAL1uJRKncLR8/nNRJxwUnZEiarhTklSzyWk9x/rdAIpYqpB7Jc25wnrZRek8mwdeQr/nlxyKIEip6LwWcH27xIDoaaRn5OZzXHyEcKeoP0I2xw26OB+yapOxbRg/5vyXsBzGrFLrGqL+9dlJlUp6R+4ZxQ5Lx7DIm7Kg+95F4fhLI2Chq+FATyrfZyztIQq2S7grtWk76znA==
X-Gm-Message-State: AOJu0Ywvd0OS3NIHgRf+tuYM8Ur7QQ7WZDNx8m9BH1US33Ux7Nu/cvMa
	NKHb4YNZSkQfeGdNmVVDMD8++f4IArEPLbfYFVe687ipKCdlqyV5I/oC7W+xWLYw+A==
X-Google-Smtp-Source: AGHT+IEcfNjhsv73rREw3FDt64vqTpH5i74RFUwWehwR6mOMV0r1WNXFeD8Aop5kBWRwiJ04EI+nvg==
X-Received: by 2002:a9d:69cc:0:b0:6e5:5cd:6b08 with SMTP id v12-20020a9d69cc000000b006e505cd6b08mr6147920oto.32.1710092744079;
        Sun, 10 Mar 2024 10:45:44 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id c13-20020a63350d000000b0059b2316be86sm2733363pga.46.2024.03.10.10.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 10:45:43 -0700 (PDT)
Date: Mon, 11 Mar 2024 02:45:41 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Enable BDF to SID translation properly
Message-ID: <20240310174541.GA2765217@rocinante>
References: <20240307-pci-bdf-sid-fix-v1-1-9423a7e2d63c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307-pci-bdf-sid-fix-v1-1-9423a7e2d63c@linaro.org>

Hello,

> Qcom SoCs making use of ARM SMMU require BDF to SID translation table in
> the driver to properly map the SID for the PCIe devices based on their BDF
> identifier. This is currently achieved with the help of
> qcom_pcie_config_sid_1_9_0() function for SoCs supporting the 1_9_0 config.
> 
> But With newer Qcom SoCs starting from SM8450, BDF to SID translation is
> set to bypass mode by default in hardware. Due to this, the translation
> table that is set in the qcom_pcie_config_sid_1_9_0() is essentially
> unused and the default SID is used for all endpoints in SoCs starting from
> SM8450.
> 
> This is a security concern and also warrants swapping the DeviceID in DT
> while using the GIC ITS to handle MSIs from endpoints. The swapping is
> currently done like below in DT when using GIC ITS:
> 
> 			/*
> 			 * MSIs for BDF (1:0.0) only works with Device ID 0x5980.
> 			 * Hence, the IDs are swapped.
> 			 */
> 			msi-map = <0x0 &gic_its 0x5981 0x1>,
> 				  <0x100 &gic_its 0x5980 0x1>;
> 
> Here, swapping of the DeviceIDs ensure that the endpoint with BDF (1:0.0)
> gets the DeviceID 0x5980 which is associated with the default SID as per
> the iommu mapping in DT. So MSIs were delivered with IDs swapped so far.
> But this also means the Root Port (0:0.0) won't receive any MSIs (for PME,
> AER etc...)
> 
> So let's fix these issues by clearing the BDF to SID bypass mode for all
> SoCs making use of the 1_9_0 config. This allows the PCIe devices to use
> the correct SID, thus avoiding the DeviceID swapping hack in DT and also
> achieving the isolation between devices.

Applied to controller/qcom, thank you!

[1/1] PCI: qcom: Enable BDF to SID translation properly
      https://git.kernel.org/pci/pci/c/b9bc750e1193

	Krzysztof

