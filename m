Return-Path: <linux-pci+bounces-2690-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 429C683FE47
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 07:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECD7D1F2235C
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 06:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC084C3C3;
	Mon, 29 Jan 2024 06:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p+ivSyOF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32E84E1C5
	for <linux-pci@vger.kernel.org>; Mon, 29 Jan 2024 06:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706509423; cv=none; b=mLoa4TTiEZvb6OI3i+SUT9fjSL6VP3a47oBr/UGCEG67AYv2Nui78Mp+09jiIuH9We2QKk/N2KXIr4//G4FxFsDz2g6VVJgEuXTLsJLjfplWLM4xMZGipKiBKVJL6VepbFvhArbYLNxXragIdIklTUj6Tb+300qtVQFZAm1ogMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706509423; c=relaxed/simple;
	bh=QnJKnsRkVDXdGmWZkT4oELQjgb6KthKPIBmNXS5eqC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajD+Mlqtai9zvcp1fbkTzGUJN6UlhI+vFaLP2ytk7dBuVu36qgT6u3zt1sM/SUCVW8UPxjYXot5ROtSdqBpHzr5nNPllcYXTKSIOQS4MeA8Q7KorGSOlHL38OLG19WiOjj6dbaEchjLw5bNKzseJMihZr2TvU+zW4LV2hJDQn/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p+ivSyOF; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ddd1fc67d2so869338b3a.2
        for <linux-pci@vger.kernel.org>; Sun, 28 Jan 2024 22:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706509421; x=1707114221; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ss4w7mLHEeCw3oX1UOUj7w3wGfveusrLCyQT92Vp2lQ=;
        b=p+ivSyOFXPmZL4jw4N1vWL0UmIgbOBt+j+4rgPqRYq06SJc3zdt6ZVLT3/hqdZlbFY
         k2JlgNHhxXihi8ZpLbn+H1r3bz3HIUvF4GYEVLMZULRnGIheLu7d5pRBanoUb/t8JTQ2
         UAytg/Dlc55oRTecxd/p+ntIv4rLXJh8guqkkbhUT3/I7NHSIM6hKHaH1nxCExuCXHvX
         6scML0c/mpbxw3Bhf4R1Y8xKOtiiVJyA1Qw8dAivJgcGiD3cgjvXv1CKuDbAe2pjCW66
         2qdbgwcQ/jZw4chI7Xr6OLpg2HXdvmE6MAkwC2CQyljkASd1k3RPkOe51ken2dyik5V9
         RphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706509421; x=1707114221;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ss4w7mLHEeCw3oX1UOUj7w3wGfveusrLCyQT92Vp2lQ=;
        b=UWx6z9Ofhoi5jDkUFK+pwww+ZK7PHBra8i4bEAzfqQ62SfGd7M72KC1brlRVw3P/8P
         23dQwjFHzKKvqg/DTLLjhoGvSIdD4+HqlQAWjjbrM5Dw7v4ZvXuf/VcQ3sageagtT0c+
         bINYUyRZigzUENyneQTG6c4VUKms3Uht0yR2vQVkQiZJYpZls+18/jv2/SHe85/alUqX
         gowxfmkgmOfXHDdhjil121wMKACUMaRbugsus7aeGkSHmibqF10qp3w6x4B8Epl30FKO
         dezuKt4qUP3/9r5oLvYzpPzmxc1+71YTUw2s7uIySCLfSb3+IplK33B6LHPjbF64QWeu
         vygA==
X-Gm-Message-State: AOJu0YygeRNvGkmG/bYIqMvKBuVhNSli2oFl0I0TPQt4Lq8tIpB5USCA
	kkSyM2mlPi8fBQd7jcMeo7bKA7cwAWJqQV85kyHAXigbEX7uX5IkajuPFMnAIw==
X-Google-Smtp-Source: AGHT+IE9ufub5vl9bpXZVPoc2jXGLyupRye3jMuFk6+26G7Ggpjx8C45ZQJrDQEgwlcu3Hsxja1Afg==
X-Received: by 2002:a05:6a00:4b53:b0:6de:1d0b:ae29 with SMTP id kr19-20020a056a004b5300b006de1d0bae29mr1103912pfb.0.1706509420972;
        Sun, 28 Jan 2024 22:23:40 -0800 (PST)
Received: from thinkpad ([117.193.214.109])
        by smtp.gmail.com with ESMTPSA id m13-20020a62f20d000000b006dbd341379dsm4987110pfh.68.2024.01.28.22.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 22:23:40 -0800 (PST)
Date: Mon, 29 Jan 2024 11:53:31 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Ajay Agarwal <ajayagarwal@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Manu Gautam <manugautam@google.com>, Doug Zobel <zobel@google.com>,
	William McVicker <willmcvicker@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 0/2] PCI: dwc: Remove the delay from PCIe probe path
Message-ID: <20240129062331.GA2971@thinkpad>
References: <20240124092533.1267836-1-ajayagarwal@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240124092533.1267836-1-ajayagarwal@google.com>

On Wed, Jan 24, 2024 at 02:55:31PM +0530, Ajay Agarwal wrote:
> dw_pcie_host_init() waits for the link to come up regardless of
> whether there has been an attempt to start the link. The 1 second
> wait time is wasteful. Get rid of it if .start_link() is not
> defined.
> 

Where is the changelog? Reviewers will first take a look at the cover letter to
understand the series. And this doesn't convey full information (history).

- Mani

> Ajay Agarwal (2):
>   PCI: dwc: Add helper function to print link status
>   PCI: dwc: Wait for link up only if link is started
> 
>  .../pci/controller/dwc/pcie-designware-host.c | 12 +++++++----
>  drivers/pci/controller/dwc/pcie-designware.c  | 20 ++++++++++++-------
>  drivers/pci/controller/dwc/pcie-designware.h  |  1 +
>  3 files changed, 22 insertions(+), 11 deletions(-)
> 
> -- 
> 2.43.0.429.g432eaa2c6b-goog
> 

-- 
மணிவண்ணன் சதாசிவம்

