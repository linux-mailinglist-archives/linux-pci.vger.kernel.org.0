Return-Path: <linux-pci+bounces-9913-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3C7929E53
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 10:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 720D01C21542
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 08:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5D728DA5;
	Mon,  8 Jul 2024 08:33:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3648E1C287;
	Mon,  8 Jul 2024 08:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720427601; cv=none; b=RLB27BWREAEbSvispyiXJP746fl3IBwPwcXSrvErbYo6leYB11ZlZ1uK33krnk/NHi1hrdTHm+Lny95xEM7EusU8SOuUwvtr6ajQnjO9Qvbp2VGAfFS/FpDuK7Pe13Tjzn4FM3oFX8I363uPXTpWgymrhqBFV1TOIe728iBIJsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720427601; c=relaxed/simple;
	bh=M1s9gHRLneMSQKfM915SxnU4cfflNxs9yEQE6srfUn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PhWLNaVPjsrSSz/cjak/0M60aAM+zhQKqccnN/YBa6x0UmLL8bU/viDpYmT2tAhr+dexduDz+CuUD2LtetYkitvyBcwXLb6pKgIplO9SVcLjTptP7t1VRgPOpIN3WE/VM5EovLWHp9BJI4lkMgrkTf3IlPyENDMVNLT7gG1rj3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-706524adf91so2910077b3a.2;
        Mon, 08 Jul 2024 01:33:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720427599; x=1721032399;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0sIr2o1x1jHhG08Gxd7uCxXV5IgNE724QrJblm21mGY=;
        b=MDdQOymGI3/mJ85Bl/2WqO+YdkOuTzbalMNmmctUszPzEv+EWAz8VSiOlYAxi8Z7Rh
         YrEOZAiYx36eHrB6zbzKNFcBnu3HEbm1UGhbVRzAGewW5tEC8ClpTMpGFUY+Xo+t1pxB
         u7RdQ1rHlbzkOAY5mr+FKZ53WZOvMi5tOepEFXPwnO2MuO/lrLqS5SDoyzBNiFvdE6wo
         iVGBHQAIqUJGlCx66sW2l/rg2iBUneueXaYt/tkDwK4PnCDOYFB6S4y+0F5aGopeB1ro
         eUbnGDxj3mBPgP6T5MNEfoUrj0bG7Jfr6tsu24P1bNt203NC+ygulYXK9tJ8gkX4XXFw
         ASvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyx9I+9z4Mj7bYwxoQ3+GCNEFhrR+l0Advs7BPvj92TlaVhFqSCFLtcZEGUFmFigf/ghoPqfQtbzIw1awBA6pzDKZfoi7HwCWZ1q0eKzbRBZEm2EFcEt/EnSt3JLNamiGmVhrHESH7
X-Gm-Message-State: AOJu0YxKDijMkRhyNEFUgd0cX2jbOaNJRjTHjrsKmZyx94Nhz4eUehGz
	14GDoJA2y+fx56WNnB4FW09PyomH9AJe57NCE2Ts4bkcgN4/+5MIkdnyZWZBlMz3Ag==
X-Google-Smtp-Source: AGHT+IG42SMDWCUIqzHYgHqAqKv15PH1bKNfDrHBp5TpRaEQlqiNwfPOdKKljZuU/3N862VSQcbv3Q==
X-Received: by 2002:a05:6a00:3306:b0:704:37b2:4ced with SMTP id d2e1a72fcca58-70b00945e6emr15157016b3a.11.1720427599443;
        Mon, 08 Jul 2024 01:33:19 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6a6f0817sm12386061a12.27.2024.07.08.01.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 01:33:18 -0700 (PDT)
Date: Mon, 8 Jul 2024 17:33:17 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Lukas Wunner <lukas@wunner.de>, Bert Karwatzki <spasswolf@web.de>,
	caleb.connolly@linaro.org, bhelgaas@google.com,
	amit.pundir@linaro.org, neil.armstrong@linaro.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Praveenkumar Patil <PraveenKumar.Patil@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2] pci: bus: only call of_platform_populate() if
 CONFIG_OF is enabled
Message-ID: <20240708083317.GA3715331@rocinante>
References: <20240707183829.41519-1-spasswolf@web.de>
 <Zoriz1XDMiGX_Gr5@wunner.de>
 <20240708003730.GA586698@rocinante>
 <CACMJSevHmnuDk8hpK8W+R7icySmNF8nT1T9+dJDE_KMd4CbGNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACMJSevHmnuDk8hpK8W+R7icySmNF8nT1T9+dJDE_KMd4CbGNg@mail.gmail.com>

[...]
> > If there aren't any objections, I will take this via the PCI tree, and add
> > the missing tags.  So, no need to send a new version of this patch.
> >
> > Thank you for the work here!  Appreciated.
> >
> >         Krzysztof
> 
> I don't think you can take it via the PCI tree as it depends on the
> changes that went via the new pwrseq tree (with Bjorn's blessing).

Aye.

> Please leave your Ack here and I will take it with the other PCI
> pwrctl changes.

Sounds good!  With that...

Acked-by: Krzysztof Wilczyński <kw@linux.com>

> After the upcoming merge window we should go back to normal.

Thank you!

	Krzysztof

