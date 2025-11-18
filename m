Return-Path: <linux-pci+bounces-41484-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EEAC67E4E
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 08:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 915604F2E7C
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 07:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08297301035;
	Tue, 18 Nov 2025 07:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGMh+znm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBCE3002DF
	for <linux-pci@vger.kernel.org>; Tue, 18 Nov 2025 07:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763450254; cv=none; b=I6M26S67AW8ibywsfElwpY5kehSMXVIVruiUiQj0YjvI3fN0ULECzikj+wX71AH0IZs1OtTwWwh3cSpE2jjoBGG744fhbv4TR+SJRsBtA8DTi8sB3vb5SjCt4/5777hGj74UqDSG6/wt35OYQV/ILu2H89jQDt3WcMLvloRPtu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763450254; c=relaxed/simple;
	bh=7L8uQUhYhVxy3DBDUcYwUUGjQQ/0CkZ24E4lZ1HLg3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArB12ntf2pIto4yoEHee2v+kKeWl2QY80i64N40LXv1pPllRVvwPsyXHo9RtA5sn4/iIswcAXz3T116CyiOQ/VNLu5KBq2qlonfzxWwT4Im9EFBu1aOybB4PVBKsH2cy9XBFKGNLKYjm+zdWoQn5cLZl8t/L4ysEi98IvyYrgCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGMh+znm; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b553412a19bso3810734a12.1
        for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 23:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763450252; x=1764055052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1h/LtINK8q4zriSv56jSMYuYj4wBO4XsX7/xajbaKQg=;
        b=NGMh+znmLr3n4cPnKdjY7aGkdy6HbRT1IMFoVe517upwdAb3g+f7xTn9SmkeIimAf9
         FYNjA0gHB4PzsyiqvH10ghy7nf2XnJf+i5/XzJs/o4llG4LoE/9xNYbZIf5M/8siHclR
         HuJM6Ffq4tY7Yj/Pc1hdcvzAp1Xc0eG5HEUiMOnvU5Yxj9zcUiMAYalhRQGWbDOW8RcA
         Hxp9kjQ7Qave3QxQCp9+Z92dSTargq1TjpaYr88jbJbPgA4dqC/pZf/Rm+IHU2JGuI3n
         8Ne+8ooPDWJ0HxcxzGojYRUMhuRbSdI5b4L5RZ3j/YjxOATm8NdRkXXq7Cj7mDCWZ1kJ
         J0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763450252; x=1764055052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1h/LtINK8q4zriSv56jSMYuYj4wBO4XsX7/xajbaKQg=;
        b=XMabpAymzFJ3om7LN7WygR0PT+V6rzJ+hxs/kqfMFCtwDxy+XagPS5VXpY1FRm7R/m
         UAp9zJqSC1orNJtNUuSIhjw0HYlt5kSE1nGe89MoZc0nM7sSCTnNZRt1ZckG0iZ5VVIW
         1oa9KCxuIitn2rM/4losYAEW9kCb/UhmYTDQ6fDp0652aYHrK5vmMqGHCSk/b+CsKOLJ
         jLuQfbmk859P9QTgZcNzoCT4nJQiNoLWvVwmWIlAvGx5hPc9m9u2JJCf8p4ohhFl4GvD
         DoEe+lqZBwXcEot46HnZGHVDUvQnnlDmutAaCa0yUv1tPFClhEI6sGlUEUeE3EYqeq6j
         vRAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE/E5ZplbL1PZEcGSLvko61pWKMDXFvR5SBlxeKDZTwiFfDLZpJuLrF46N5hrvdpc0bqg4pocJK88=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrmjK7roXhgvAXl4hRI1G9C5Md7fuF7ZnUI1WAIQC8m1+Sq+0G
	s40+cHZmRS7v0zd3wyrcUZOhBgbfVz6PTxeVUwPRDL138kc1etXDnIN5
X-Gm-Gg: ASbGnctiK+IMmShMafg/xC3/cUig6tLCDwzBR3WETfGlulDlhaH0zmBzQXAqD82SWwd
	m+ageDMDZNj7HniE0L2zjVwBmqdnzfHpHzDQGncAHS3UooAO/3AanE85WAc/b2BOlolsfLt1JQN
	tG8BZcuXDMtwjVbvm2nYZ097hAyb/eWuTbnOFKksYUyH12TBndaD+kOWjuuo2A8Z9mdKOX4Zpvt
	i32QdU1Z4izM/YmeppTCXdAT6eEunTbvH8ZIFmr7CBEn1HbToTnOZwhJB8Ngrkai2T5YQcDuo1Y
	efkoL+D8td5rxiqlysDfYc2krwYwYRmZ2Ep/c7S/Bti6ikk+UGFw7adR2MFwHzPvQJjIv9xXGTl
	F717JY3gmlG3GdDkYXa+nrNIgrCOWuMATTYLs8Rqe7H6ejokgp4B7DNFNDeSCzUNBwXJn8+BtYQ
	==
X-Google-Smtp-Source: AGHT+IF7vM7dWQA7a8j5a3/LMB+ij9tgBYk+NU42Vt0dswOO93rmrv5IDEUmNpYrednFhDvN1YDVVQ==
X-Received: by 2002:a05:7300:ce8e:b0:2a4:3593:6453 with SMTP id 5a478bee46e88-2a4ab88119cmr5119698eec.3.1763450252407;
        Mon, 17 Nov 2025 23:17:32 -0800 (PST)
Received: from geday ([2804:7f2:800b:b822::dead:c001])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49db7a753sm54420555eec.6.2025.11.17.23.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 23:17:31 -0800 (PST)
Date: Tue, 18 Nov 2025 04:17:25 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Jonker <jbx6244@gmail.com>,
	linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/4] PCI: rockchip: 5.0 GT/s speed may be dangerous
Message-ID: <aRwdhbt0AcLQ1LgF@geday>
References: <e5d5c0dc-81d6-ae0e-7552-c2e4fb39bb0a@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5d5c0dc-81d6-ae0e-7552-c2e4fb39bb0a@manjaro.org>

On Tue, Nov 18, 2025 at 07:45:45AM +0100, Dragan Simic wrote:
> Technically, you shouldn't have included my Reviewed-by tags in some
> of the patches in the v2 of this series, because the patches were
> either modified significantly since I gave my Reviewed-by for them
> in the v1, or they were actually introduced in the v2.
> 
> However, I checked all four patches in the v2 again and everything
> is still fine, so just to make sure, please feel free to include for
> the entire series:
> 
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>

Hi Dragan,

Oops, sorry about that, and thanks for calling me out on this matter.
I'll definitely bear this in mind for future submissions.

Glad it worked out in the end.

Regards,
Geraldo Nascimento

