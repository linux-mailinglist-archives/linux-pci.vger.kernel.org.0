Return-Path: <linux-pci+bounces-15891-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 600C39BA80E
	for <lists+linux-pci@lfdr.de>; Sun,  3 Nov 2024 21:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91D411C20CD1
	for <lists+linux-pci@lfdr.de>; Sun,  3 Nov 2024 20:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F2118BBBD;
	Sun,  3 Nov 2024 20:53:35 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D6D83CD3;
	Sun,  3 Nov 2024 20:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730667215; cv=none; b=AdzOOnPhtd4aWM61fVzfFa1ftWqacBkbPF2F2j8tsPdjyaxn3F8lq4EtpnOmScW2eBE2y9g9mnI5j967wcIzdk53GzDZPFGrj3cgCb60AF1xt1H42+LYFVXmvHJX04NwGssVF5nCN+Xq4lGkB5FmorbAc6dGvra2yNzmxH9wHpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730667215; c=relaxed/simple;
	bh=ZWYCQQ51VNGgkG/ayFISd1Iy4D0oOcizhMsB9SzyMoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNrvuEK2wNkhy5KPZFJf0tbsmwF2NDrJfWZtDWTwKVQ3ZNI7ZoQCr1ZzhXaiyXI6Ljdsi/G9axegLklztAk/h9QuXJxYGxw1HfQK8Zvqy+Zi/h03yvQX4QDU4FfJQkkBOlMnc7Joqb9pHsbhl98DsFjKIZ/iZrX/UImsoNpHLV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71e70c32cd7so3245381b3a.1;
        Sun, 03 Nov 2024 12:53:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730667213; x=1731272013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InjzJWxwQf1lmaUOg5rdT3QQjnZuPbY63EFFbzsRveo=;
        b=UCX5FZ/ARJ9fUGRDErv6WpEdIOTcACcoNGYWg4u4Kyj4mL0zsv75XWXl1lmFwwPCQG
         fbESQ1BStvP+tfqWF+lhc0WAmbm/dlpv2n3E8NBHbOaKMmRJITLrGdHWa76J3KG0P6pV
         Io2Jp40LVTpIQuNzw1aJfrnSGnQoD4Ap2Hn3XwRrKsJwyOJDIWjMBtLFiHyJTenI3+uT
         O5434mOOSHKM8vTGuLiIAw2qCo4mtQ3g7PS51eIRgey3q3lVaXUCxT66kkmQ9+06B2XO
         POOi4MJtPo+ADK+5cE8y3vf/5RgO0Z2PdizaCg0UliptSDO1gXmNMn28xOCQSloRVP3T
         i9MQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFax9ry2G9W2Ifs9S74omI2Q+5tOEtOXcsg4bBHZ1fKXFvliBtZl5Jlx+7xwVIkd5myWAuk15zbm84CvY=@vger.kernel.org, AJvYcCVLm0xSOyGAr+cDgzzmIolX1+rDLP4y7Ebb9tmYLnLd8zz8WLTJi5nEfk/CU2oGXTHGQeC6bDHjuTYtIjcy@vger.kernel.org, AJvYcCW2ehvsw/xzxi7yXbpERyywCOiL/bZtUWWmQNEY9bNQE0ws/ibIMDhm1XuY7Sex4rxKfpOo6+b0Ulwk@vger.kernel.org, AJvYcCWW152Sop0uoDfbtVONC/fKsaT6k0eAP61R9Fz59mpCSWOtkC/4gXOmHXFtx9YZqpaf1GMXoeu6bEtDW6Na@vger.kernel.org
X-Gm-Message-State: AOJu0YwbCDQ2mqAy4tkal1vlljsftfCMlwT3BxIfpiyCHkQUWOJIOZQz
	xLd3CgwimPiO8m7Rfm4IBNaRb6Owz85P2dvzpI39dxF6yREQWBru
X-Google-Smtp-Source: AGHT+IHupF8efOyDp7E1SVzfTrPRVCc42EJestRDTVJ2U870NUJIU5+bitobgYTeGa9U5qW2FEm3AQ==
X-Received: by 2002:a05:6a20:e30b:b0:1d8:abf3:58be with SMTP id adf61e73a8af0-1d9a8402d5emr41221754637.21.1730667213369;
        Sun, 03 Nov 2024 12:53:33 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1b8f9esm6139630b3a.8.2024.11.03.12.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 12:53:32 -0800 (PST)
Date: Mon, 4 Nov 2024 05:53:31 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: manivannan.sadhasivam@linaro.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thierry Reding <treding@nvidia.com>, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: qcom-ep: Move controller cleanups to
 qcom_pcie_perst_deassert()
Message-ID: <20241103205331.GG237624@rocinante>
References: <20240817-pci-qcom-ep-cleanup-v1-0-d6b958226559@linaro.org>
 <20240817-pci-qcom-ep-cleanup-v1-1-d6b958226559@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817-pci-qcom-ep-cleanup-v1-1-d6b958226559@linaro.org>

Hello,

> Currently, the endpoint cleanup function dw_pcie_ep_cleanup() and EPF
> deinit notify function pci_epc_deinit_notify() are called during the
> execution of qcom_pcie_perst_assert() i.e., when the host has asserted
> PERST#. But quickly after this step, refclk will also be disabled by the
> host.
> 
> All of the Qcom endpoint SoCs supported as of now depend on the refclk from
> the host for keeping the controller operational. Due to this limitation,
> any access to the hardware registers in the absence of refclk will result
> in a whole endpoint crash. Unfortunately, most of the controller cleanups
> require accessing the hardware registers (like eDMA cleanup performed in
> dw_pcie_ep_cleanup(), powering down MHI EPF etc...). So these cleanup
> functions are currently causing the crash in the endpoint SoC once host
> asserts PERST#.
> 
> One way to address this issue is by generating the refclk in the endpoint
> itself and not depending on the host. But that is not always possible as
> some of the endpoint designs do require the endpoint to consume refclk from
> the host (as I was told by the Qcom engineers).
> 
> So let's fix this crash by moving the controller cleanups to the start of
> the qcom_pcie_perst_deassert() function. qcom_pcie_perst_deassert() is
> called whenever the host has deasserted PERST# and it is guaranteed that
> the refclk would be active at this point. So at the start of this function
> (after enabling resources), the controller cleanup can be performed. Once
> finished, rest of the code execution for PERST# deassert can continue as
> usual.

Applied to controller/qcom, thank you!

[01/01] PCI: qcom-ep: Move controller cleanups to qcom_pcie_perst_deassert()
        https://git.kernel.org/pci/pci/c/7d7cf89b119a

	Krzysztof

