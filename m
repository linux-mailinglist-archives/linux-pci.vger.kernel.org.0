Return-Path: <linux-pci+bounces-22880-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E61BA4E898
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 18:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 503D419C0AC5
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 17:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68CE2C376C;
	Tue,  4 Mar 2025 16:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UUN9EUgK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D2E2C377A
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 16:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107497; cv=none; b=Oy4xYNJyoSZgwn4JJehi7sM8hPRPiuOCB4NQW7/d1Cr6sPOsZ6r0TsWN2Ji+JIAyafkty98G9xgSmF1LOaz/VcrjGJvDA3USlHCtID4i7Sy/pmzZXz0smWAje0qBpKPWAAgfR4IBqGjOshBMP0sbd4FDAzdAOS0BS9lzJ7QgsHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107497; c=relaxed/simple;
	bh=xXx7LimoRaGxZZSbMjRDlhzEtcIeeTGSh9Q0GrBdkxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7XGSfEE0c86+PhjItWHAMqHVvfPKiWTwamiws9zEQMKh5hp1GAA1D3RIj4qhnXyJ3POR6oUHVzTv51WtanJal+6id9fzc1MzIZ7c8XP1uI75t1EaaKvGtSbnkBMmI4IQp27LRtEHvaCsASg/VIX96/C3Wf1Ow0ASGNPXo/TxR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UUN9EUgK; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223959039f4so61737695ad.3
        for <linux-pci@vger.kernel.org>; Tue, 04 Mar 2025 08:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741107495; x=1741712295; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JXuDlePk3z76NmB3njzb/zW9m0v0y70IIgcfh0HFsS0=;
        b=UUN9EUgKHa0X/OazVwo0MsnuQd/ZuM4ngr/iEYWOl4u4n6hmkdrki7vTgoau7eWsbA
         7trlWz8gJEmjjkWd8A8/JE30TAhXkJKWiUzUrA5H5P5Wv3g6/3OCK+FNYZXjR+Ui0UA2
         Bsv3oEbuSoz+dwuLH6T5911/1VBPnIkROLmjSHbwv6WlYd6AlTJ5vdJQy271SHxjzt1d
         468BzHSBE2Fdyqlb/woY/HdwwixCikGRclHe4uk9R69BNLpwWAEMOhz4suVlniGv0GZF
         g2lAAP051Z9y8R+nDBoTAQE+2KiWcoGEwPwpNEhjDfZcLBD8xYv8nBmt1GgfRD6J/jnj
         rQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741107495; x=1741712295;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JXuDlePk3z76NmB3njzb/zW9m0v0y70IIgcfh0HFsS0=;
        b=vuf4HVlqb89Wq4SPDYOUHRSEvQojh+h864CZjN0gsR+JZqztFQrQJzgz9/Z/jUVc/N
         gzUQq8BDG1FlGZ7x//LF4tjbbnSfOneNvKdK6HJwb4tZuAjZgwbOlXzgoIFRsrLjnwEK
         TVu6vqGkmbDmobb0NLW+OgT8a6nx19kjBN+woKlwCXwYOmfN8EniR+61OtSOAfnmYNuI
         fFG+k2+ud/7JfmHldFcK5ejK7qVYNlgtjh/A5ogdtTrw+xbqJ1aGZLUKejO/myYnPRrW
         At6ADyHjarG9ru8GogZWGedQoa/QFcw3Md6fsUxmWXHhFamoSBAEFhRHmqXoKR6AfK5x
         XO9Q==
X-Gm-Message-State: AOJu0YzfnPA34r72ss/tLZyQ9te76HpytJ/Co+FBgcqNppNd0bAD/NCI
	jxrUDanFd83cO8ZFlQ7gW31HlW0q09MKpKNol+iGcIXZUMRnP6nIoDPsh6dWYg==
X-Gm-Gg: ASbGncucxkg4CsvoFOhfohYsh8etGYEw7l8FWQeHF6creX3N0yx6YyxnsRqG/jzwwyU
	WiYjRTw8ZjkrLqD3gND3BMH0hITdKb/px198TvDQAe4M7vUL15jI7f6TmeilbK7RpIDpx3Y/abx
	o9A4kbp0wAjtmcZUEyj769CKBBA0pujo0x2xbVVoK19H58ufPdbSUW4a0f0CiwVtszLNYH+dd70
	1Arfc0RDAyVNWGre7HV1z9wtZNneaCeEL1taogn4KoKVw3UNeNCVrPQGgnivnJwz/MGyLQ18D4a
	RwKVGe3tw9HYpmwkHO7VfljhEXeMIokeUFl8jbTbFGRtNHkaCJ7kiMs=
X-Google-Smtp-Source: AGHT+IGwnc/vs2CObgIuDM6UnQPGGyTdY/HL1MplDIozj/pFYdjiWAd6nq0u34IHMKPLJhyLx/VbEA==
X-Received: by 2002:a05:6a00:66ce:b0:735:d89c:4b9f with SMTP id d2e1a72fcca58-735d89c4ee0mr21649526b3a.0.1741107495305;
        Tue, 04 Mar 2025 08:58:15 -0800 (PST)
Received: from thinkpad ([120.60.51.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe2a5b1sm11112782b3a.23.2025.03.04.08.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 08:58:14 -0800 (PST)
Date: Tue, 4 Mar 2025 22:28:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 6/8] PCI: brcmstb: Use same constant table for config
 space access
Message-ID: <20250304165808.t46fh6fwpardheup@thinkpad>
References: <20250214173944.47506-1-james.quinlan@broadcom.com>
 <20250214173944.47506-7-james.quinlan@broadcom.com>
 <20250304150838.23ca5qbhm4yrpa3h@thinkpad>
 <CA+-6iNzOWU1qLfmSiThdYXX0v5RkbUYtf52yk6KXm6yDDNRUnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNzOWU1qLfmSiThdYXX0v5RkbUYtf52yk6KXm6yDDNRUnw@mail.gmail.com>

On Tue, Mar 04, 2025 at 11:37:14AM -0500, Jim Quinlan wrote:
> On Tue, Mar 4, 2025 at 10:08 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Fri, Feb 14, 2025 at 12:39:34PM -0500, Jim Quinlan wrote:
> > > The constants EXT_CFG_DATA and EXT_CFG_INDEX vary by SOC. One of the
> > > map_bus methods used these constants, the other used different constants.
> > > Fortunately there was no problem because the SoCs that used the latter
> > > map_bus method all had the same register constants.
> > >
> > > Remove the redundant constants and adjust the code to use them.  In
> > > addition, update EXT_CFG_DATA to use the 4k-page based config space access
> > > system, which is what the second map_bus method was already using.
> > >
> >
> > What is the effect of this change? Why is it required? Sounds like it got
> > sneaked in.
> 
> Hello,
> There is no functional difference with this commit -- the code will
> behave the same.  A previous commit set up the "EXT_CFG_DATA" and
> "EXT_CFG_INDEX" constants in the offset table but one of the map_bus()
> methods did not use them, instead it relied on old generic #define
> constants.  This commit uses them and gets rid of the old #defines.
> 

My comment was about the change that modified the offset of EXT_CFG_DATA. This
was not justified properly.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

