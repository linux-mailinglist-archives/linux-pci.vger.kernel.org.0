Return-Path: <linux-pci+bounces-4712-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B77877810
	for <lists+linux-pci@lfdr.de>; Sun, 10 Mar 2024 19:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C1471F202A3
	for <lists+linux-pci@lfdr.de>; Sun, 10 Mar 2024 18:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3A8200DD;
	Sun, 10 Mar 2024 18:51:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1834539AD5
	for <linux-pci@vger.kernel.org>; Sun, 10 Mar 2024 18:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710096712; cv=none; b=E+vVoE/uFjYtTab9kMmYzbnfLRRuHc8Be/mUCDCJr3pBlBzMGORliln2ZkTUbFz7JUAVLw0JMMBT+zAHkNc3RkfQO4qyfwVkRl8yVO4V5yi/sxhyOpQ0w/LTlqJjJCb84EP70RBhvvhzKurbiAhqkoZ+zIKuT0q63GARCAuQsI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710096712; c=relaxed/simple;
	bh=gpJYcZAqHZXYAL3xiwjeB0bCf8k/B0nLu80lgS4FraY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbFC9u0mpgYa86Q/fO7XXy6cKDFc6BgkOP7tgkSPDMpqK/W7ROdCosbL853GpV2wAtBVKVRh0tmh50AwjNKfOxYs3G7QcEPDVb6HqlMZ6sFQ8l8Fo8vE0d8UsJzHTtNVBul/vmsgXBGVXPPysixjMLLTa6ZjHYIJbm+v2yR4kMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4132b04d735so45025e9.1
        for <linux-pci@vger.kernel.org>; Sun, 10 Mar 2024 11:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710096709; x=1710701509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=beW9h7nVpsHWDV+bR+YHIZbD3xhNNllIEvrndz0rE5Q=;
        b=FBLg4FbiTeMiMt40bGba0ADd2ezgJx5BjilzvoKIcSQOGaT4rEdMb6pg4Sd2opLPKJ
         ENaolwHQnceYx/+MWGhXdJarLjTS1I762h/nFPdXDhz4PHR0saAwO0+4Q44RsD2NNWRd
         fj/g/a1lWNWvUg7dDw1BOmbV61xYanH8c9Q2ocXLjbMSpxSpGCiKaIyjqnRhy2vSn0kY
         uinYbzEuHoiShtVGU9q5hMG9XLcCORCaO6S3RRp5m6vsc6ryiNbrqh5N4Kff58fq73bC
         39xdODqEnXquASfTNFBzRwRZlIA8U2AiLdzRx6ZAGG6opdnJJWQSEg9fyXiXPGM95OX0
         50Lw==
X-Forwarded-Encrypted: i=1; AJvYcCWeJBet8h46XE/x9ykQlTInslIFTcAT862BOW4Ir1OOX3tcEns/9ToRYRg0MSwKupF6z4JZDtRx7SGbj+xQ8BeR1Ysrz/06swsE
X-Gm-Message-State: AOJu0YzhoohJxTxMDgHhCg0pRoWcmux1uVQDbVVOtskLUR+tNBx2y0MS
	E5obXcF7JD+xzmMRJPQeX6z65sM6iy8FZ5FyzRheveK38d2p24ts
X-Google-Smtp-Source: AGHT+IEKnDGlheH7eBS0Trm1bD3QBo6nvU1rMACl+WjMVbx3D+qaISwx1s6VC9Gqil1gAhnSnkJsJw==
X-Received: by 2002:a05:600c:19cf:b0:412:b42c:8ff1 with SMTP id u15-20020a05600c19cf00b00412b42c8ff1mr3865761wmq.21.1710096709151;
        Sun, 10 Mar 2024 11:51:49 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id hg6-20020a05600c538600b00412c8117a34sm6435067wmb.47.2024.03.10.11.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 11:51:48 -0700 (PDT)
Date: Mon, 11 Mar 2024 03:51:45 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dwc: endpoint: Fix advertised resizable BAR size
Message-ID: <20240310185145.GF2765217@rocinante>
References: <20240307111520.3303774-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307111520.3303774-1-cassel@kernel.org>

Hello,

> The commit message in commit fc9a77040b04 ("PCI: designware-ep: Configure
> Resizable BAR cap to advertise the smallest size") claims that it modifies
> the Resizable BAR capability to only advertise support for 1 MB size BARs.
> 
> However, the commit writes all zeroes to PCI_REBAR_CAP (the register which
> contains the possible BAR sizes that a BAR be resized to).
> 
> According to the spec, it is illegal to not have a bit set in
> PCI_REBAR_CAP, and 1 MB is the smallest size allowed.
> 
> Set bit 4 in PCI_REBAR_CAP, so that we actually advertise support for a
> 1 MB BAR size.
> 
> Before:
>         Capabilities: [2e8 v1] Physical Resizable BAR
>                 BAR 0: current size: 1MB
>                 BAR 1: current size: 1MB
>                 BAR 2: current size: 1MB
>                 BAR 3: current size: 1MB
>                 BAR 4: current size: 1MB
>                 BAR 5: current size: 1MB
> After:
>         Capabilities: [2e8 v1] Physical Resizable BAR
>                 BAR 0: current size: 1MB, supported: 1MB
>                 BAR 1: current size: 1MB, supported: 1MB
>                 BAR 2: current size: 1MB, supported: 1MB
>                 BAR 3: current size: 1MB, supported: 1MB
>                 BAR 4: current size: 1MB, supported: 1MB
>                 BAR 5: current size: 1MB, supported: 1MB

Applied to controller/dwc, thank you!

[1/1] PCI: dwc: endpoint: Fix advertised resizable BAR size
      https://git.kernel.org/pci/pci/c/72e34b8593e0

	Krzysztof

