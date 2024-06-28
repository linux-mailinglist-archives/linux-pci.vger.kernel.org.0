Return-Path: <linux-pci+bounces-9422-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3044791C7BB
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 23:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB201C20DD8
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 21:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80C176046;
	Fri, 28 Jun 2024 21:00:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA771CF8D;
	Fri, 28 Jun 2024 21:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719608452; cv=none; b=ubwN0xJeDjrVhW6ZsLSMSe7fGlIwDPFTIAvv06szM4ueEn/FxxE46KQOGoeoTrDzPEFqLv9TY9RF9XbdDQK3AGFh99/0GJsaHJFv8X2rawfWQHKbvcntLFhkaaGfYBApqoQVqy4udRsaTVzIjGUWYNslkBgsOtImUId8KgK5yz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719608452; c=relaxed/simple;
	bh=4ENreLtp0JXG6KC4XZho83qrfg7AYsbJoo/otV6WhxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jp0zfpYwMQ84sDUqk2XlaqRb09fdSWFsVkkJPY0ipTh2I4fzHxdMxhlU8YP38sFaD9kyHNOiToWKpP8k0jCS4D15lHSLXttP1puj7oQO96uFU7xAgwpbRcCaSKnafehuqTyLmx3hTNITNiSS/3aMzvLJdFIMV25+LFLxlf3KgEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-71910dfb8c0so696675a12.3;
        Fri, 28 Jun 2024 14:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719608450; x=1720213250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXeehienu24I1oRun6Bc8GBlxqPh5TZvh3eBHievpzY=;
        b=IA+MSDg0D4IGKNMNQTq7Q8wGNTnesIXkCRQLRLZ+o23JDWmZX8GY5g2XZrrhhu921G
         2VIkGSWrjXkT+N/zN5/iy8zgkKwQVzbMYV5DCWbkqXIOe45PVqFBXGcHCuMH1mtYRraU
         jaKl69t/rRSQfCNGJ34NSAnoLxwtPcpyhG660cmpQRsZwT9ZmFw8j2G31DTwBCgj94Ng
         OHVzgmy0mVKFjRkV2eXpseNk6/7XfGKnmhc8f6KI3Uc2BP6BApyspsreVVnVYmAliUrr
         2WqTYx1FpNY4O1WaFRXgJwF4pb3VBroncGwD5KUlcHRVvEBq+5b8FHag8rbrcKBQfe0e
         xP+g==
X-Forwarded-Encrypted: i=1; AJvYcCU3ZEEde3S0rP+zwKKzTM8uVvZeyACNIuHSwdeB+duGt2bcbe0LglJI8ZRMOxPF3dxuqv+cEZuokj9KAco4apr0Pv9fOhmjCveM5SNurO5I1yAUSRo8qXQwMi2o9+qzzWU6JGHNyOBYolGkeFWm56WNFkWQqOFDJPhNP/TF+0NJyvTYcv3X2fJIy6yKWTsXIDuiGpsbl5rfIVhrNqMuSZJU+5c=
X-Gm-Message-State: AOJu0YyGqlIzOgCXIg+MOJkiM/xLjAKj+e6JkGJQGs7pR+BX56xn9RC0
	TWfXx3I7MOUs3TtUcWmEfMyobYJ/VQ7RRv+Lj+hTDNMW0phIO5q85eTj35GRVGeliA==
X-Google-Smtp-Source: AGHT+IHw9iXrkQkLoNi1yZuF3G48W5le7cMVZ4zcoBmI7mhMnaaPbYHs2pihEzHYqtk8Kceiv93yzw==
X-Received: by 2002:a05:6a20:8c8a:b0:1bd:2d53:35d5 with SMTP id adf61e73a8af0-1bd2d539600mr9998932637.9.1719608450326;
        Fri, 28 Jun 2024 14:00:50 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7086207ed02sm1809877b3a.95.2024.06.28.14.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 14:00:49 -0700 (PDT)
Date: Sat, 29 Jun 2024 06:00:47 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>, quic_vbadigan@quicinc.com,
	quic_skananth@quicinc.com, quic_nitegupt@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v15 0/4] PCI: qcom: Add support for OPP
Message-ID: <20240628210047.GB2206339@rocinante>
References: <20240619-opp_support-v15-0-aa769a2173a3@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619-opp_support-v15-0-aa769a2173a3@quicinc.com>

Hello,

> This patch adds support for OPP to vote for the performance state of RPMH
> power domain based upon PCIe speed it got enumerated.
> 
> QCOM Resource Power Manager-hardened (RPMh) is a hardware block which
> maintains hardware state of a regulator by performing max aggregation of
> the requests made by all of the processors.
> 
> PCIe controller can operate on different RPMh performance state of power
> domain based up on the speed of the link. And this performance state varies
> from target to target.
> 
> It is manadate to scale the performance state based up on the PCIe speed
> link operates so that SoC can run under optimum power conditions.
> 
> Add Operating Performance Points(OPP) support to vote for RPMh state based
> upon GEN speed link is operating.
> 
> Before link up PCIe driver will vote for the maximum performance state.
> 
> As now we are adding ICC BW vote in OPP, the ICC BW voting depends both
> GEN speed and link width using opp-level to indicate the opp entry table
> will be difficult.
> 
> In PCIe certain gen speeds like 2.5GT/s x2 & 5.0 GT/s X1 or 8.0 GT/s x2 &
> 16GT/s x1 use same ICC bw if we use freq in the OPP table to represent the
> PCIe speed number of PCIe entries can reduced.
> 
> So going back to use freq in the OPP table instead of level.
> 
> To access PCIe registers of the host controller and endpoint PCIe
> BAR space, config space the CPU-PCIe ICC (interconnect) path should
> be voted otherwise it may lead to NoC (Network on chip) timeout.
> We are surviving because of other driver voting for this path.
> 
> As there is less access on this path compared to PCIe to mem path
> add minimum vote i.e 1KBps bandwidth always which is sufficient enough
> to keep the path active and is recommended by HW team.
> 
> In suspend to ram case there can be some DBI access. Except in suspend
> to ram case disable CPU-PCIe ICC path after register space access
> is done.

Applied to controller/qcom, thank you!

[01/03] PCI: qcom: Add ICC bandwidth vote for CPU to PCIe path
        https://git.kernel.org/pci/pci/c/18f331d9c6db

[02/03] PCI: Bring the PCIe speed to MBps logic to new pcie_dev_speed_mbps()
        https://git.kernel.org/pci/pci/c/4bf3029dc2a1

[03/03] PCI: qcom: Add OPP support to scale performance
        https://git.kernel.org/pci/pci/c/78b5f6f8855e

	Krzysztof

