Return-Path: <linux-pci+bounces-24458-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A21A6CF40
	for <lists+linux-pci@lfdr.de>; Sun, 23 Mar 2025 13:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19CE43A964B
	for <lists+linux-pci@lfdr.de>; Sun, 23 Mar 2025 12:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428F7623;
	Sun, 23 Mar 2025 12:38:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15BE8837;
	Sun, 23 Mar 2025 12:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742733488; cv=none; b=e8kB6EuFG4455dokc/wE5SLnuNzBHoiWJLwRIrngb1FusN8iQ9J1xTMc8ZLoJsNGE/S/AyqqZ+TKVcopaJxdV9iBlV/BnJCDg9Jwa2G+MkCU9c6ASjzm3eLgkLeWKKCZ7IL/t/uzDFtquqVhIaBH1IBema76V6csOW9JwbTza8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742733488; c=relaxed/simple;
	bh=gA8XX+4Wy9hIS4lNmW/BtZEXbkmSjEyOc1jU+4viVgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3rkgch4/qReyy5j8Vk7snuF5UQ3JjLgJiH2bND1Us/r326LZN7KI9Wfce48hH1ZYTTHB5bBO5Ce4QiVuHu05hjexlArf+ajQyV4dVovWk38rxWLvkiWtoFgR3tORNzWN3Nyb/XcmTYXm1lfMcIfo1COS/oJhjAIDEZrmqRo84k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-301493f461eso4171040a91.3;
        Sun, 23 Mar 2025 05:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742733486; x=1743338286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HnWB9RWsVBWnpOBg5WEW3ASvl2XaM92u6YTY3vFQTs=;
        b=rJS/6JTn9hFhtxbB5Dj571H0qOwVW9pbNmqbYISVOnfWBu7+Nhs5zDrLJ9dUqEJ4IS
         fShaOsnQiZGBqZEZ/l/A9AIbIoYY5pH9Lap/ER4r6cOaCMRmzxcbns2HYaHvv1S1s/IH
         qdKN8gpbPsZbsyxakpA2VjeRWgj3z1aassiIJSSM6PMbFwlw4NF46UUjniIxIvfdw7yS
         /dwn2rpyfbVgIjefxtkn65t7SGg2fu9Uh4St1VJAbIN96QbpTxLNj3JS6ML31MOACzqN
         gpjSYqBT6+se4A/sJuEITs8i+pG1YCOjuMHS+qKfSy6+ad1NprHof5OMwKXnF0LL3DSL
         CyUA==
X-Forwarded-Encrypted: i=1; AJvYcCVGsxH9hyjPhpqg7vHtAuvRao5UC3Qi45zWBF+OgddViCLsPoXRfMpb5zppgZQPHQd6udXPyzfZq3C+JmfDl8M=@vger.kernel.org, AJvYcCW39MoNU0L/z6C1UzwDn1EYKDdSliUu/bCKkI3bCAgazKzSmi7irJ8VVyUPExLqx4o50fuas1/aB2TmxMz6@vger.kernel.org, AJvYcCWm4i60D09tEZDTgGQTS42/zMcLgdVGXGCtegI6EHvG/W3co0K6s4tdjut68GzoHtje6OwKmz5LF6/w@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/F/ZPiUA5f5HvNaenep1FD/tQw3bJEbp7SvkxOj8zKt68PKtb
	a9v2X0nPtMcVrGQjOtBX7B5Vz44iQvoRGK6cOpv0i0+olRI18mJK
X-Gm-Gg: ASbGnct00aQP9Dewsv3QTPyhdhioFA6Sdfoe6Ds5jF58pBENoSxWsBIDTiFnsLwwz+c
	JLRUwkABTHoEhuP8v4e/rtEN+WWDvSByEN4SDuqhAnZDkJPBCycSNUL8DKZhVROi0r+6qHylnCd
	GpiNWhqwLbrimR/IsBNjI/51v7Z6Gb/fFE0UxORklolkSG4y9+Ii+rYMUm5L6eRAOewtbPmCAgl
	h8sQm5VF3ahIDODymxd9lZDBBw0IV/kubag8rvV7m0EQzxLIcdZVec/1DudVzUyGvbPhwTPuqMS
	gH5TfIpmaqRfdVFFkLwiU3mkdCRpmvGJmwf+mPzQNcXDcaEPspaGUJW6LCPEDzeXq9GjRMXIzH+
	csmw=
X-Google-Smtp-Source: AGHT+IHrLv6luYgfmwyuvu1tJl/93WMsciSS4yr4NNbis4gxiGP2i8SnSlB7c290PtylAh3xnlTSFA==
X-Received: by 2002:a17:90b:3d8e:b0:2ff:5ec1:6c6a with SMTP id 98e67ed59e1d1-3030feaadb4mr17480277a91.18.1742733485859;
        Sun, 23 Mar 2025 05:38:05 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3030f7e9d86sm5844767a91.37.2025.03.23.05.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 05:38:05 -0700 (PDT)
Date: Sun, 23 Mar 2025 21:38:03 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] PCI: brcmstb: make const read-only arrays static
Message-ID: <20250323123803.GG1902347@rocinante>
References: <20250317143456.477901-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317143456.477901-1-colin.i.king@gmail.com>

Hello,

> Don't populate the const read-only arrays data and regs on the stack at
> run time, instead make them static.

Applied to controller/brcmstb, thank you!

	Krzysztof

