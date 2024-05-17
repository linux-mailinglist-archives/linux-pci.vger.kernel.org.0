Return-Path: <linux-pci+bounces-7635-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F55D8C8AC6
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 19:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 307351F25A59
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 17:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9AD13DBA7;
	Fri, 17 May 2024 17:19:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C958513DB96;
	Fri, 17 May 2024 17:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715966378; cv=none; b=WwVJ3mei3U2XGdHMlYnvw64XV+uFhsVTyb8nODi8a271shCPOfu+iRbqfjuFypGFBxXrLRy0mgc75wFbQWqddGYWaSrbbCUr4F9+vGOV5CZgw/QmjegoTmCeSSLey9jhyybM2cq6jE/1FlyeEkAy3A3UMa8PF/85Wu5FE3ORIPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715966378; c=relaxed/simple;
	bh=ciQHWHWKLiE9ln0ZC3UWfT6EA6AoskxoqHok4ux6Uz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5l2dor66O6CsQI+k/LD2lQ+o0dOA3sk44s5CqpsRt4KyWWDB6uhNs+QxqYMC31S+oKNQQeQJZ5f3wBEE6nLzuEQvoksGaYgx6baFx1MWuZBt5YD85CsqDoNQeixd3Hck82yX7hWM4bkwYc7myurtdwsAEJtTEX+BZ+abUM7sv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-36c67760b1aso9219925ab.1;
        Fri, 17 May 2024 10:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715966376; x=1716571176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UB6XKV9wUgi+qhn8POruaJiArXAXEVQlYUUEYIplrXg=;
        b=W4ydx+Oo0e+bfTdIQSW3741ghcVswD1jtPINLAjheAvOOcO3BMpyu8cqDpJkfQ2i6D
         LswvLpzD8fMPOIq5JshlttOHwaeL3/+fz/rWOcOhdrw1XDbfeCCFrV4Qv7yzhEch5DPU
         QtrPkBTzB1Pow4H+yJWkcyN3fhQdYIobuY3F8mcq0pHjMyt9CMdWMEg/mbJXhgqR/PGM
         XJbzNq+3WiKHT/obr6SB3zNPhiRqcYSmTcw0CWlMTgaF9tLQao46VY71grMWEvPGFYad
         Iov+9xLosVRUShWAP0YhUju0F2ju1jytZeFwb7qe28qFL4qLgikrwMhBJWD6XQM+MsvT
         xFGg==
X-Forwarded-Encrypted: i=1; AJvYcCVkJI4gU3Lbjhu4IfuPHVnR6a9bAjzuu8cwtfNeBA/4Y0StDxsetAiEmEhV6a3ejXyAKJGCkNTfDFuzGzCRoLrS977+fCdudTEarOfmoeakNuoI1/Kf4ju8rr18Dfmxft+E+6yNUhpn5SmO9QywX8NbQJhph/gg7nI84xCfMxJ8rTI/w0TYn+eXVIrO/rEJT4ipgCcmic4NOcK9FstbU0fdeDaKUyUScDU7
X-Gm-Message-State: AOJu0YwQRBL0da/lMJ6W7+vwxcLy33vUcqMRHYhGnQv7kujHD05vSPKT
	AzJWZGMLlh5U8MWyvlcW7XSYYBuujBa3p24yZFSoxAEBqLNSTRNe
X-Google-Smtp-Source: AGHT+IFSBSh/ZT51IHpa0NW5wG46MrevAidSm8SjYN/yFK1UTWIjyOexN1WYN/rUphWHZey1PHbEeQ==
X-Received: by 2002:a05:6e02:1d1c:b0:36c:4cc4:59db with SMTP id e9e14a558f8ab-36cc1484ed3mr263255705ab.5.1715966375818;
        Fri, 17 May 2024 10:19:35 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-660447e832dsm1263375a12.28.2024.05.17.10.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 10:19:34 -0700 (PDT)
Date: Sat, 18 May 2024 02:19:33 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Frank Li <Frank.Li@nxp.com>,
	Mrinmay Sarkar <quic_msarkar@quicinc.com>
Subject: Re: [PATCH v5 0/5] PCI: dwc: Add support for integrating HDMA with
 DWC EP driver
Message-ID: <20240517171933.GI1947919@rocinante>
References: <20240318-dw-hdma-v5-0-f04c5cdde760@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318-dw-hdma-v5-0-f04c5cdde760@linaro.org>

Hello,

> This series adds support for integrating HDMA with the DWC EP driver.
> 
> Hyper DMA (HDMA) is already supported by the dw-edma dmaengine driver.
> Unlike it's predecessor Embedded DMA (eDMA), HDMA supports only unroll
> mapping format and doesn't support auto detecting the read/write channels.
> 
> Hence, this series modifies the existing eDMA code to work with HDMA by
> honoring the platform supplied mapping format and read/write channels
> count.
> 
> The platform drivers making use of HDMA should pass the EDMA_MF_HDMA_NATIVE
> flag and provide channels count. In this series, HDMA support is added for
> the Qcom SA8775P SoC and the DMA support in enabled in MHI EPF driver as
> well.
> 
> Testing
> -------
> 
> Tested on Qualcomm SA8775P Ride board.
> 
> Dependency
> ----------
> 
> Depends on:
> https://lore.kernel.org/dmaengine/20240129-b4-feature_hdma_mainline-v7-0-8e8c1acb7a46@bootlin.com/
> https://lore.kernel.org/all/1701432377-16899-1-git-send-email-quic_msarkar@quicinc.com/
> 
> NOTE: I've taken over this series from Mrinmay who posted v1:
> https://lore.kernel.org/linux-pci/1705669223-5655-1-git-send-email-quic_msarkar@quicinc.com/

Applied to qcom, thank you!

[01/05] PCI: dwc: Refactor dw_pcie_edma_find_chip() API
        https://git.kernel.org/pci/pci/c/51d8f92534df
[02/05] PCI: dwc: Skip finding eDMA channels count for HDMA platforms
        https://git.kernel.org/pci/pci/c/f9eeafd85ef6
[03/05] PCI: dwc: Pass the eDMA mapping format flag directly from glue drivers
        https://git.kernel.org/pci/pci/c/6823373030c8
[04/05] PCI: qcom-ep: Add HDMA support for SA8775P SoC
        https://git.kernel.org/pci/pci/c/c5a9a5eebb3b
[05/05] PCI: epf-mhi: Enable HDMA for SA8775P SoC
        https://git.kernel.org/pci/pci/c/fd745ddc8edc

	Krzysztof

