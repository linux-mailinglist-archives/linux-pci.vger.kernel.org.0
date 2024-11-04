Return-Path: <linux-pci+bounces-15978-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB139BBAE5
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 18:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A00431C20830
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 17:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BBB1C2335;
	Mon,  4 Nov 2024 17:00:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E867762EB;
	Mon,  4 Nov 2024 17:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730739610; cv=none; b=gNqKJ64E7uo/8wNGZjRpw0EdesKO6KGAsFQOBG+IC31JZrCtQinOorMMg5VSPNkrXZZiTJ86NhFNEaAVMbzlv6595oK9GEAJPBcB5EJTr3Qy0oM2lG5kNkAMoOv/jYWHXH51LQ6u0wMVQGSQ87N1up5uQIQaXuVXBoSmhSBvuRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730739610; c=relaxed/simple;
	bh=c4j2AxiCBmK8TPRGxeBDDR2DRCu2KEePS5LYL/cGw8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtBVuC3yEMXLQiSoPR3LgEGoBNHxshPLH27jS+AUyPR66lTQf+6jPioLZm+qQXgQTMtRbRrf7gDhanV+89OC5FvzxxVHsd5YZ6SC4e2OItpUj3VFCJZykjY7IpidY3E9QbWZZKffORd/51cpQyqCpmj5UDnnuJvH42zw2d0xoNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e49ad46b1so3834005b3a.1;
        Mon, 04 Nov 2024 09:00:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730739608; x=1731344408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X40B+sMh1eGF1F0jxlLbQBcht+sGrnCIA4ApgNyX+v0=;
        b=WrKCbzv7DgFTRBwVQkQZV1bGFG5Swa7i5lHIpoXgCatJGzQQhSSOx63yR0IeEMQRHA
         qm9X5EGkkg3830G7qSrH1ik/OxhaM1NPfYe7IBSMgHqKq9ZLMuvbHHbAXWPFhPGjvRIy
         Mtin5x27SnjM98eDii5+7JDgVFidJPspBc36dbpfAsXUcm3rgeYXuQbkunOX6xyT0hra
         hEAadmu/jLkh9HGjFH/uwzaZDtd84ZYDn4SYKbmx6sQuD2dnervJkBsZlB7rBcxnrYdl
         eYjs+J664KnzxO+Sddm8BoQO+6lrrUkoDKz4+QVQtSv6VA2xTPWkh7kAPNFU+fyz/nUI
         C8Rw==
X-Forwarded-Encrypted: i=1; AJvYcCW30k446v/kIV+G69rGgsUf5pE3G0ItJWRTOsi4oIf0j5gM1sgqXSFYtJ9VJ4ZbR19sgduoPRA5ehZT5qg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKNVU0NaJRmm/JpYx2TU6g+5eHT7+dpDxgfhr34QVZNmMzw5ms
	UeQ28n0NnW1Dg8ZLGdHttTur8yDbr8uUHau1myWqSJ+uhUltya9ogjkjMVdQ
X-Google-Smtp-Source: AGHT+IFTmb9Csi7s44ZdeNILi3UIE6RcdAkVf+D6pNViSfkFFQF6wwO/W5zTeviYxlBEXREuuveNEA==
X-Received: by 2002:aa7:8f97:0:b0:720:aa27:2e55 with SMTP id d2e1a72fcca58-720aa2737f6mr20398086b3a.14.1730739608131;
        Mon, 04 Nov 2024 09:00:08 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2eb586sm7981636b3a.149.2024.11.04.09.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 09:00:07 -0800 (PST)
Date: Tue, 5 Nov 2024 02:00:05 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pci@vger.kernel.org, ryder.lee@mediatek.com,
	jianjun.wang@mediatek.com, lpieralisi@kernel.org, robh@kernel.org,
	bhelgaas@google.com, matthias.bgg@gmail.com,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
	fshao@chromium.org
Subject: Re: [PATCH v4 0/2] PCI: mediatek-gen3: Support limiting link speed
 and width
Message-ID: <20241104170005.GA4055778@rocinante>
References: <20241104114935.172908-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104114935.172908-1-angelogioacchino.delregno@collabora.com>

Hello,

> Changes in v4:
>  - Addressed comments from Jianjun Wang's review on v3
> 
> Changes in v3:
>  - Addressed comments from Fei Shao's review on v2
> 
> Changes in v2:
>  - Rebased on next-20240917
> 
> This series adds support for limiting the PCI-Express link speed
> (or PCIe gen restriction) and link width (number of lanes) in the
> pcie-mediatek-gen3 driver.
> 
> The maximum supported pcie gen is read from the controller itself,
> so defining a max gen through platform data for each SoC is avoided.
> 
> Both are done by adding support for the standard devicetree properties
> `max-link-speed` and `num-lanes`.
> 
> Please note that changing the bindings is not required, as those do
> already allow specifying those properties for this controller.

Applied to controller/mediatek, thank you!

[01/02] PCI: mediatek-gen3: Add support for setting max-link-speed limit
        https://git.kernel.org/pci/pci/c/ade7da14954a

[02/02] PCI: mediatek-gen3: Add support for restricting link width
        https://git.kernel.org/pci/pci/c/6e73c5898973

	Krzysztof

