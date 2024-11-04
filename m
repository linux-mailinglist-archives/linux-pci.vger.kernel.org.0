Return-Path: <linux-pci+bounces-15980-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2649BBAF6
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 18:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 744641F21D06
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 17:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F961C9B68;
	Mon,  4 Nov 2024 17:02:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE941C8315;
	Mon,  4 Nov 2024 17:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730739753; cv=none; b=AyWoE0p+sfjupNTotlcO4LEEW1D6/59tLapG23pFKkq3hcsD7RcOlPuRiAzgwxSoMcpcveKF1hKeRvAASzbDZZ6DO3qzuwg7y4MZa2sHwnj1t+lBx+1iMwxIqnanec1H4WysITh5P1PGxfxIIE+nmWd+whU00N7zgthWpz/b6VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730739753; c=relaxed/simple;
	bh=FUAmzJQokXIilKtGylKNmbl49NYmqnYgsB1F30UCmMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j754qKYFCGWd4xLHquDx88xdRLa+lm4a1Sbty3Pk7BuOS9dR4j0qCqGdRTvNCjXxijJRNfNpo9A1Gpel77mwfkpCuLi2XOs2UYMVYCrVxdpjF+8j38cfM17mecGO88ETFsueAlRFcMpWNVrJ8AkvfLwoAzagQmbQE6vPAqRY/o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20bb39d97d1so41525765ad.2;
        Mon, 04 Nov 2024 09:02:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730739751; x=1731344551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUaqYPQBom3i3u/a7qeeh7UaJt4FVAg2tfUFfji99rs=;
        b=QP6h52npDgKf6Hv7UAzMbfNKcVm3oUe0L9hSoRtxUeBn5hZ+n88UiyA5lytgHKdBI1
         5ZmIVGJCbBYUhcDwbZioheAf8wYrc1yzZWrvcB56Dmy1sxWDSDxv4qTXr/7icP38whd/
         lwwA7eP9Pca7m3qa9xVmlOOIxeaUUg++f0AFuzQWQzDZw4X+OhEUW+0XFSjAxniSh3fQ
         Z8V+m/gSDJhRsj/DZdDzHR05DU1TrM775ED0f+CMRcljW/Mdjyex3IMNYpftChDibiUC
         TYWV44Ou765YSJm+5FwlVqD5DiWKIRCZn2DMhSgP3OCQ2ghOjzOOmJQSxTzuVgURD7JT
         q+rw==
X-Forwarded-Encrypted: i=1; AJvYcCXSGt29fZBu7RzcdnqCRylUT+PDonQ/5OA/OzV0xzzY3WtauwIYssM3JoaXk7ttFx3q9AY0k3SMaGcYRWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX67SBCUIk2leIcqc9pH7Cu+FGbKWBRBAm6kH8CDPChXt+5xPE
	k9ThKh8s2qXdeH58LoN5inm7tdq54yQhh/4pxPrYVLgxcW1uY+jB
X-Google-Smtp-Source: AGHT+IFb59G7c0c6LtAW+eFwRHDEioTFdbtbcVJx/y76Cx5c5DKoXHLI8G5B+DhlD1xdKyYaLYMoBA==
X-Received: by 2002:a17:902:db05:b0:20b:8a93:eeff with SMTP id d9443c01a7336-210f76d6845mr260100015ad.37.1730739750977;
        Mon, 04 Nov 2024 09:02:30 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d3bb8sm63610785ad.246.2024.11.04.09.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 09:02:29 -0800 (PST)
Date: Tue, 5 Nov 2024 02:02:28 +0900
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
Message-ID: <20241104170228.GB4055778@rocinante>
References: <20241104114935.172908-1-angelogioacchino.delregno@collabora.com>
 <20241104170005.GA4055778@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104170005.GA4055778@rocinante>

Hello,

> > Changes in v4:
> >  - Addressed comments from Jianjun Wang's review on v3
> > 
> > Changes in v3:
> >  - Addressed comments from Fei Shao's review on v2
> > 
> > Changes in v2:
> >  - Rebased on next-20240917
> > 
> > This series adds support for limiting the PCI-Express link speed
> > (or PCIe gen restriction) and link width (number of lanes) in the
> > pcie-mediatek-gen3 driver.
> > 
> > The maximum supported pcie gen is read from the controller itself,
> > so defining a max gen through platform data for each SoC is avoided.
> > 
> > Both are done by adding support for the standard devicetree properties
> > `max-link-speed` and `num-lanes`.
> > 
> > Please note that changing the bindings is not required, as those do
> > already allow specifying those properties for this controller.
> 
> Applied to controller/mediatek, thank you!
> 
> [01/02] PCI: mediatek-gen3: Add support for setting max-link-speed limit
>         https://git.kernel.org/pci/pci/c/ade7da14954a
> 
> [02/02] PCI: mediatek-gen3: Add support for restricting link width
>         https://git.kernel.org/pci/pci/c/6e73c5898973

Angelo,

I made some small changes to the code, per the suggestions.  Let me know if
you are fine with these, or not.  Thank you!

	Krzysztof

