Return-Path: <linux-pci+bounces-22003-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84022A3FBBB
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 17:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E522881CCF
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 16:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8419B1F2361;
	Fri, 21 Feb 2025 16:29:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DDE1ADC6F;
	Fri, 21 Feb 2025 16:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740155343; cv=none; b=Hcazws1uIr2ryFE6uW9BLnR56lGF47uQPKzZXMi+hUo3Pq6r1B3I0yPevdycXX4UrlVtUAZnmgWXoFGWr6uI+r8vWWYQ7/DKki8rPanRRLpJP1b9oySFnrGmCTvUOSdadQ9I28mt6U/HFwjsZXMTeyixSv7x8knRe15P2ygM7F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740155343; c=relaxed/simple;
	bh=2ATtzT02wCwcEbZK1lFLROTj13r4al03IL2WJgZYNMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjiu5WM1wiv0MM7O89j1HN4ZZEOU6egE3QO+qiFhdwb1qN4oklzUQC41toU7fVkAHfnlAxKL5s0+IwSkPOPgP7mJryr3cKq0rYj51kk2neAxzEkpXpOWQfbsTcwSLQG1IeF5RFdwX2UQkP+cvGSZHODGb6qj3Dtr23NLP526gW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220bff984a0so46447265ad.3;
        Fri, 21 Feb 2025 08:29:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740155341; x=1740760141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=auYo1q28WZyuHNh2pfR3G8yFEtkgsHI7ZygRzgYrpuw=;
        b=wH0zSG9v27XemUDMBn8nKhGNCIdu6aEA1yuTkz/8CQStlE79EGoUKl0AN7ZaKlywSE
         IaCY+q+wtjERMDEMXHoWedgGDkZrKE5OBjQJnNt4bhYocTrDH+ca94HO9d9dijDuhdyX
         tYcM3pmmtwMayAOC3X4rJxlRy7Mg6eAPCscxlx09Lvk7Wk5jmfQdBRMkjYVMHB8c6mL0
         3Y/bubeQJl6WrKXoX0KTbVNZuhJon41kyApysUdJl5Ca+7OJjty3KjFPAgyXyekTZosq
         PB0tvCuelQamy0nPJKErNU1MWUX0BBYicJrLlKGkpsekENF35xTY2mkPFzhoSccNnfum
         /3eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFcRR2G38TZEW0UkYu7Ub+aKNOEEIGqMe/Av9Ic2u24RWH44cs0w2Mgo+XO8ysjehYA2irxKfpQv3Z@vger.kernel.org, AJvYcCWyp9dfo4QZoDaTYHgHQ+PZGjVxURM1V1HYggcBuierXnJgq3LBPHJtxGHQVoONBRZF2JB6ZIzJ5xMp@vger.kernel.org
X-Gm-Message-State: AOJu0YzAdHJsv48wR5FPT/gG5Y1MianSI6UIGuByW+wkopI8GB70zBGd
	pfu9n81Qg6aHaRaCZWZqdSebWTuEpAH8cVHZ2V9xq4QsO2/ThTAB
X-Gm-Gg: ASbGncuvQ+SNMPLhk63qCwyDInszsMKkB9uCRY5EjWoNSV6n6IeOwa4PfD0F9XE0OHa
	UlFg6J2SQt2oQPa/XSpV9vkoPFp782ph21Pm0WDxTwEJjlzwdT7I1eT0ZZj+33qboord3U5aize
	mDBGr/ClbyJf/EWFrMtjxeEtVZ39z0+S8KBADHC+eP3k/z9uLWNe8Smj3dRCO5s7Ezel1vUKynC
	OrQoiEuQTLBKcCTGzXFGLGzs6Gc/ugoSFaB7zAyUMt7Jhx5q454P4va6aEcQjiQhyOAZFOPTO4Q
	mHqqySUvlUYxKrFu5TPKWanxqXUDYrswmclqiVTNfixsTXEcsfPNkxtTJmuY
X-Google-Smtp-Source: AGHT+IFnKdGjvlhZUCgvom/r84nNQnNYczGg1sVtsp3HGbrc13BuFoyVtD/Y/b8wcoZfazYzawaYOA==
X-Received: by 2002:a17:902:e5c2:b0:221:7b4a:475a with SMTP id d9443c01a7336-2219ffe1401mr54015415ad.52.1740155341168;
        Fri, 21 Feb 2025 08:29:01 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d5349061sm140095945ad.5.2025.02.21.08.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 08:29:00 -0800 (PST)
Date: Sat, 22 Feb 2025 01:28:58 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v5 -next 00/11] Add PCIe support for bcm2712
Message-ID: <20250221162858.GE3753638@rocinante>
References: <20250120130119.671119-1-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120130119.671119-1-svarbanov@suse.de>

Hello,

> Here is v5 of the series which aims to add support for PCIe on bcm2712 SoC
> used by RPi5. Previous v4 can be found at [1].
> 
> Based the series on linux-next because of vc4 gpu node in bcm2712.dtsi.

Applied to controller/brcmstb, thank you!

	Krzysztof

