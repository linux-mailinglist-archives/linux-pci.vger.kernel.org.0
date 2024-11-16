Return-Path: <linux-pci+bounces-16987-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCBA9D0085
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 19:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771921F233A5
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 18:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAC719046E;
	Sat, 16 Nov 2024 18:38:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E97BC8C7;
	Sat, 16 Nov 2024 18:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731782317; cv=none; b=M0I22QE7UIYMWDWA4aNnKifmUf3EGebC3TzL7iYbpWw7Ze5j/QprJLs5M6hq0HNLWCEstBykl0FJNefCOojbpPcspcDxLaRAZ32meNumvplT3yUHnl72+zhta316RNkqBEXkZFc8D7rxS3U0HTBGAJXsS1B/MlVrU+NwR497oJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731782317; c=relaxed/simple;
	bh=0xsa1eGWQQgTpaUzAt7FclYb503yUFZilXozrXeqdQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPichG7gTfY58faU9+aeSrNmkPRu68IxNTdUxRs1yiz4pybgWw55rgB6I99u0yVeyrtITOgsy+y9o+D/8JIruT3SpHlxM5mqzQT7ggka4Fyoj/UOxGYKC7w7X91oLyEOwx2ib2CfmSzCgON8em39pc4ZsT9zT99ZtoHKg2jTfsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21207f0d949so1352305ad.2;
        Sat, 16 Nov 2024 10:38:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731782315; x=1732387115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5m7/YJOxEzK1/4/FwXTk3K3jZblGH0VWaE85X96sFhY=;
        b=gQO10+QXdvdIo6AoMPUP6eZ4nzNuGzUp5JlMQQbkkqQ3VQv+AGwRU2b7dK7g1VoanB
         HtfJYG82Zltei/IDofNv8n2bw0ZF+6Dwk/rQXf6uycrVjKks+JUZFzrAXeMqrZ8aEDeR
         jSJt2ikfOMUJuUrsBzvvgKcHZYjWEJpbdlAiw9ZoT8maaAMZYV57C2S0C96lZeFA+Ix/
         K1H4eb36UU9y1HGYHE/fm51RgdRbfjoGkQVEQ60uw/UNshsaptK7LkV5xLgOAJqYUvkZ
         /J6vK9eueepRZc7+JHeyf3bwNz91fLyvwGzhvL+c2Cp/XAFwOWlDpY9htwzvmNP7rr0P
         wwhA==
X-Forwarded-Encrypted: i=1; AJvYcCWTOXYb1/1uKYAa1qYpxJl5MkmiGk0F4/ZVf0JbmDylNpXd9PIsST6wBuZVfwl2wvs3pv2dpbj7Izws@vger.kernel.org, AJvYcCX0TECSvTnrF32m/dhSRnBFL7RPDFJch4I05xFDc+6RupyYb0aLJLHg7KEld9wZdulJFBtqfdCFsgaCnlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzW0q0vc94Cw3jpSAP3IEfMzKjl9E7eYq0KziDvqZsRri9ehDr
	t+skGNkkKxiJJEnE1oBqrleIbmcp5Om2vpnz0sTpHvswPyzHtKye
X-Google-Smtp-Source: AGHT+IEK0WhGqYxfVSmvxqa2UNwiRzUdq3ZzNmIj2MvqMTWnckxT+tV8qZHJRs9Uw5aIyeaVFpvApg==
X-Received: by 2002:a17:902:d547:b0:212:500:74e with SMTP id d9443c01a7336-21205000ac5mr13252825ad.11.1731782315325;
        Sat, 16 Nov 2024 10:38:35 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771c0dfcsm3425214b3a.106.2024.11.16.10.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 10:38:34 -0800 (PST)
Date: Sun, 17 Nov 2024 03:38:33 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Use of_property_present() for non-boolean
 properties
Message-ID: <20241116183833.GC890334@rocinante>
References: <20241104190714.275977-1-robh@kernel.org>
 <20241115071708.nh6tnscmq5khr46o@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115071708.nh6tnscmq5khr46o@thinkpad>

Hello,

> > The use of of_property_read_bool() for non-boolean properties is
> > deprecated in favor of of_property_present() when testing for property
> > presence.
> > 
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> 
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Picked this tag, too.  Thank you!

	Krzysztof

