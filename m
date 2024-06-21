Return-Path: <linux-pci+bounces-9091-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 543BF912DFE
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 21:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2DD5B27693
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 19:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C059717B4F8;
	Fri, 21 Jun 2024 19:37:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6DA17C7D0;
	Fri, 21 Jun 2024 19:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718998668; cv=none; b=uoLujswBTru3z/WNKt/6lqqZUuTIrCpQ3oazKzuqExTsT+3LwtxdLNotF9Nd0CFw0lMwOSLuuhKVwvD7NaOhZLMbfEP8Zor03awLQXSac4YoB+oHaPE7ZmlBSpcJW3QYycSu32IgPXUfkIPErZje5DB9LtbSQKvbJ1RxdvG+xWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718998668; c=relaxed/simple;
	bh=Z6XDvtd/xm4xSg8Kzfwtsmbr9qvvXnf1QYMN9sGi2k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3I8zIHqOtzkW3Zz1foPfRFHETafmXtVRcRH5thYVtFMqpG/0PA52+74eTQNAju/PrLWqjrml5AzYuFV/6Wp/5baTRnm5pne9zzG3IMIHakZPzWRtZlJwP0Q45bv4lnCSaklThFSyfAzxxxinBU67/ntGZuKP1xOiipJqHTY//I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-37613975e20so8888245ab.2;
        Fri, 21 Jun 2024 12:37:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718998666; x=1719603466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sXQhvL9a6CYV2VK3wKh6O5gxH2nHkFbrE11g//vArPo=;
        b=KPHaaBT1LMxQLIT4qrJNsjC+lg8V94zRvKp9SWweVsgJAc2bk1mqTe56NOpi+nBi8V
         ASUVXmFspc1vbid9akyRDEkgw7nS3BW7XL6/FmVEXWgjVzqdkcNC/6nOcPd749CWAzZX
         Zrv2F63MpyNCR4GQxu95fpGlJPGEssKBbnqQb7EpVHDdmjhIN5YmD8VSIaK7k1sCRBMf
         +zqk/ZlzPd2bIPa120aZ+3FJ3rOHMcnCPhSxyFOLD1eJ79tAl7k9qDEc6hmx57hDHmWj
         7g6LOEKwTuf3ExBdzpVOJbF2BUTQ5KQM94SmEC6zDUkMNQ2rtd8z9V/Ykr/5Spgt7Eib
         Myyg==
X-Forwarded-Encrypted: i=1; AJvYcCWlQBCeRa+f/1GAeABhmRcCkdLoTk3InGb2ixDCRhf6qjVg5UX2LTQyl9nZAva7Dba0icKNZtmRvPB/1IoL6Vrp2bVm+qx4sTB841Wo25K1D9ryYIf7CPC6AFRazTFCLHA3boHa6bJxoGBec0VvTEobTCubDrxGY3MQK7SlzPjp++QGGeCLARs50ARsx7RyyslI5YKVJb0YvqqNf0V05//o7AKsYw2YXrFF3Yglutd558upLGkXiHXeqFTw5oGOp8pxE85ZWgjFD5liEMBWySfUGpLadxsEe0EXNuQVeMqV7fQ9
X-Gm-Message-State: AOJu0Yy4m+4WgmgVHw3UiKJ/+/RFiKwqlB555k/jJG3S0Xs9OY5Es944
	re6wSH8+1MsxZTXCUt9UoPGZCSu+YJkfoA1yCgEIN80Pd4JRr+va
X-Google-Smtp-Source: AGHT+IGlUL9QwPxUHX7nV3tXeYRMDnq/je2PsJ3NCGAtSFvVXOze8EobQXpZtTE4zHujIy0ctpA41A==
X-Received: by 2002:a05:6e02:1c85:b0:375:a185:f00f with SMTP id e9e14a558f8ab-3761d709758mr109157335ab.22.1718998666403;
        Fri, 21 Jun 2024 12:37:46 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716b3ee8c95sm1492640a12.31.2024.06.21.12.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 12:37:45 -0700 (PDT)
Date: Sat, 22 Jun 2024 04:37:44 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@axis.com, linux-arm-msm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
	mhi@lists.linux.dev, Niklas Cassel <cassel@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 0/5] PCI: endpoint: Add EPC 'deinit' event and
 dw_pcie_ep_linkdown() API
Message-ID: <20240621193744.GA3008482@rocinante>
References: <20240606-pci-deinit-v1-0-4395534520dc@linaro.org>
 <20240610065324.GA7660@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610065324.GA7660@thinkpad>

Hello,

> Applied patch 2/5 to pci/endpoint! Krzysztof, please apply patches 1/5 and 5/5
> to controller/dwc (patches 3/5 and 4/5 are already applied by you).

Applied to controller/dwc, thank you!

[01/02] PCI: dwc: ep: Remove dw_pcie_ep_init_notify() wrapper
        https://git.kernel.org/pci/pci/c/9eba2f70362f

[02/02] PCI: layerscape-ep: Use the generic dw_pcie_ep_linkdown() API to handle Link Down event
        https://git.kernel.org/pci/pci/c/14638af66309

	Krzysztof

