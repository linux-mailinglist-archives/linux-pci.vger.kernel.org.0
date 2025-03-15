Return-Path: <linux-pci+bounces-23810-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B07A625B4
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 05:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05E713BD821
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 04:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812B5A2D;
	Sat, 15 Mar 2025 04:00:40 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC522E3364
	for <linux-pci@vger.kernel.org>; Sat, 15 Mar 2025 04:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742011240; cv=none; b=V7Kzy71PJLp71RWJS9SDMtcv/RD+jJanklKkOSwC9Pv/YQXPBBkrIHqkqovFVUYAcTYxyP0uSeWNzVi9lajlsYRqp+6/l2PvBUm2K9wLwkpdL5du6psOj4B6JH2dhhKfiUNFnweMnH5cw08TaOQFtaA9qfXZyebxEhd97JVbmF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742011240; c=relaxed/simple;
	bh=2woC3DbyjNQW4/oTAgArm8ct8872r38LT1LJiBNQfuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYXfj+IHxlE15FxZafeVxotgdw03LNBCE8ldP/OoJcy1sJbzFbPB9yXuIzmk3kC1mAiRQkDyXss5yDi86k8gPbfE5snJ0sYjRMU/e+7RZXHH5/QShB2qOAFjPkttPmWZah0OLsw6Ilb/AtYeBaXDCRfKRi2iU0YAuCY9Mh00sts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-300f92661fcso482612a91.3
        for <linux-pci@vger.kernel.org>; Fri, 14 Mar 2025 21:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742011238; x=1742616038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4+qPDPuCstNLo/GcF5oRKkN5WGqyPb6TlEhsmHq4Bg=;
        b=L6uYil6c1fbRTku6DQ2qb1evyEYJM5rmY3B5KphaJriwnxj/IbvnZAAhYXGruL4mJe
         iqnRILHQIeHqSGSIan//hNM9nU3wWMlZ8jEl3n5pG+VE1UJ/OtxlVUuerkP71KgKiYQM
         DlWxGhyWUybg+oxiFeYC53E6XnKrgv/6uMrA375vS0Ee18iKjcLpEPeNW++y9m8PwOxL
         EcZ5TN70dx8cI9MIM6ix9YAe3BQBCEKMx4ZXGZpEwFuM+aJk1Jsykl7XfS5mB07ZOpvA
         147lAuXpzhI6ev9EBuryoeRzrE6DsTZYGBkILa/MIs7ncv/L9XJ1bZXBWsFSBkkjIHkU
         Kzzw==
X-Forwarded-Encrypted: i=1; AJvYcCV7o8BISCEJ7Va1q3niWrH8NbjygnJt1b6PvXjV7ZYKZxvfaZQ6QPEjT0A6PMRT9YWWMdi8deBfyjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWKOw9iB5xvWDv4l5uZpim5QTW4DTgmO40d+FwHLGevLqaFPRO
	x5cOTw9u+yaShbO54HA57KFPnZ1XKmLM35va63d9VcAmysXqY8rRXEvBhh2cI1Q=
X-Gm-Gg: ASbGncsBcT10O3JPgEivQ6CLqcxP2prwfMMpR7SUiR+fzdaADJK3+GUWxmJLddYteSk
	8v8RDWkOLyELbbhnwonaN00a0TxXxeA0D8fHrmlqzHTG2V/use+tTw/vjqxMA+mPeEadNk/kQqt
	xc4xygzm6j/mzeqpb57ljVIREixvyWIAAryz5EdDxgg1cRJY50y21D0VG7d3LXjVmu+X7d/K3Ma
	BAuawkWgohc1eq6Fv9qCcTzNvtg+XyNDaeZnj1gYkClveuoZs8Vzag31Y2CuzaVGmxjceYBDK3w
	cXtfpHbQRdSvqvBKyF7N8yjN/zlJhT3jwfhI9VvBEMyoiFa0pbwgKd/nXoFtH5HGpQ2qBODxCoy
	eJNE=
X-Google-Smtp-Source: AGHT+IFWzmbV5/zR9nbzhbecfW4czNyqg55fBOJekyEeIbSoHSEQYX3s3SluZQ1ia70Wa+HdD3fKPQ==
X-Received: by 2002:a17:90b:5387:b0:2ee:ee5e:42fb with SMTP id 98e67ed59e1d1-30151c9a276mr6130549a91.13.1742011238094;
        Fri, 14 Mar 2025 21:00:38 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-301539ec999sm1849652a91.14.2025.03.14.21.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 21:00:37 -0700 (PDT)
Date: Sat, 15 Mar 2025 13:00:35 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Huacai Chen <chenhuacai@gmail.com>
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	Jianmin Lv <lvjianmin@loongson.cn>,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH] PCI: loongson: Add quirk for OHCI device rev 0x02
Message-ID: <20250315040035.GA167520@rocinante>
References: <20250121114225.2727684-1-chenhuacai@loongson.cn>
 <20250314075328.GB234496@rocinante>
 <CAAhV-H7AnAnmPT73wQtx2gUitrLumc3NURvBWzJYj0UkNHw=oA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H7AnAnmPT73wQtx2gUitrLumc3NURvBWzJYj0UkNHw=oA@mail.gmail.com>

Hello,

> > Applied to controller/loongson, thank you!
>
> I'm sorry but since Bjorn has some questions, and I need some time to
> investigate, please drop it at present. Thanks.

No problem!  I saw comments from Bjorn, too.  Thank you for taking the time
to look into the concerns raised to refine this fix.  Appreciated.

	Krzysztof

