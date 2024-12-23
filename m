Return-Path: <linux-pci+bounces-18970-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970C49FAF5E
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 15:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0007F7A2666
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 14:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7441B0F35;
	Mon, 23 Dec 2024 14:18:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7F41B0F27;
	Mon, 23 Dec 2024 14:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734963491; cv=none; b=KXOOZvHAWR3eVARPlC90Z6zF7woPBAc2CsJYEY/1Xg4PaC81Vt/ezRaPOXDFypVSQeRgrnr3G33jkB05891JW6eQiLF6J0YlTZYWSlwMVnWFlrr1rQOvzDa871oVWh4O06vVJ4fS24JQ4OAepiJck6sxOGVoC9Imu7AEs1FQ4yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734963491; c=relaxed/simple;
	bh=saPzCb03vmUKPGBpgKt2b9cCJwEV3sNZOncXm76Dmgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiaSEHcgmx04Idjt+ZY4GiqCOZFem4A/3xy9/jwc2Rpfr/XMnsHHuKXN9dD4p0ak5hUS5EgASE3hNZYyvfhZhqATrHYsbce8LnozWpsuPVderEWeY3LZFODVZi9SBnqc6Z4cdweXSAo2RYZ1z7q9WRo6A8PmPyUKMMr1aofccrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2164b662090so34284495ad.1;
        Mon, 23 Dec 2024 06:18:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734963489; x=1735568289;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ULyKc7BaFBov8XvSS8Fc/ZiZcJcVRa+PV+hStUeCV4=;
        b=VFUcBxL4pq7OioCXVPr3pAZY3qvbnioz+dExiz/SBfBnLi7poNyDUu+W71M84G49qj
         d/ZzOA2koDcqXaFnSF+u8bqdRXiS9UE3hQZCXDZOdtOqmp+C2wv0auB9DVYJcY3RAT6n
         +BPkgOAOo+/WBF/YOGRP5ViDQFG8d6NSMdXJ9IkbIxUl99mTWiVDU9ywtiGeFMl39smL
         vCx68GDbVgWDOj3T5GGp/dA1kKmU+4k+plwNS2KiXgwXGomdGchM2Lovg9URornhPAp9
         Asc33Zoqx4lIiHnAOcs+DQIVlRxq9TdTFSPUOg0cn4qLJ/zAqR1UHogvY0xUzuCzlxWD
         hBxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUG0isf7UnWJn9P/DicvF08IahZYK3olBbroxsg6wsB/MO93EN8hNDgXj9kgjv6oNib7cChvMb21KUd@vger.kernel.org, AJvYcCUslXICFHVYI6IxPYilLjuAII9X0H5yQ4tEDG32QdEv0RXTjjhs67E8UMVzbqUiq0SaQ1wO2xXCEy4=@vger.kernel.org, AJvYcCWsTx5qYmfcz3NFXEW6o7famR1qL+Tbv2pI8GG8N3Cgh6gaRmNlpSNMJYxv5QmZ329aTsxLgB/wzq4CU3JLqyShZx8=@vger.kernel.org, AJvYcCXzWiFzA8DJjXOj3HxK8157St5rayo1y0R7C+V3GabATDuv6LVfPMk5ApfconYv5C4aztQhEl2KldyshF3Z@vger.kernel.org
X-Gm-Message-State: AOJu0YxxiaVpW2p0tyYoGtzQBO5YHrrC37l3S8Z+nF89Ad6oefbtqQOM
	ZpQAYGTyVEosRjGUE+/8An5L0ALE4HlkLTpsdOhAyDYAbtvpWfzM
X-Gm-Gg: ASbGnctErxJ7ezT0vdBqSs/Cgs2XRaOi7HeOxe/fethQhyUAwuisSkbERI+1rM05g1u
	7cAWDU83fSyglclMv680QHv1OsqLPJ1SYCj/4/02zeELT03mWGRA68Zs02EalkHtv1cWM8HHQyi
	jPETL8if+Xv05yz2aoMaPxcXsM6kfOdqpi8eJhUSQwke9YM/te97kULSneX9ag77ZbzzAw73KMm
	s8OJTnX2fMa0DK2OELiANdKkUR1O5CgEUXb4eqSLa8KZoMd6mitru3q5XxBSt+KpdYGYIETxo14
	XYwNjfIo1H128HI=
X-Google-Smtp-Source: AGHT+IEsnlz4mPE8jueX1x89jlq0C0eIXgwZmReztfvY5cxV9abureUI6eHDpct2UFToIIV6d9foAw==
X-Received: by 2002:a17:902:e886:b0:217:9172:2ce1 with SMTP id d9443c01a7336-219e6ea255bmr181376795ad.22.1734963489177;
        Mon, 23 Dec 2024 06:18:09 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca04ce7sm72205685ad.283.2024.12.23.06.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 06:18:08 -0800 (PST)
Date: Mon, 23 Dec 2024 23:18:06 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>, kernel@collabora.com,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v5 2/3] PCI: exynos: Switch to
 devm_clk_bulk_get_all_enabled()
Message-ID: <20241223141806.GA1864738@rocinante>
References: <20241217-clk_bulk_ena_fix-v5-0-aafbbb245155@collabora.com>
 <20241217-clk_bulk_ena_fix-v5-2-aafbbb245155@collabora.com>
 <19eca5c3-cedb-4c5f-9b70-9c25c8387414@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19eca5c3-cedb-4c5f-9b70-9c25c8387414@collabora.com>

Hello,

> > The helper devm_clk_bulk_get_all_enable() missed to return the number of
> > clocks stored in the clk_bulk_data table referenced by the clks
> > argument and, therefore, will be dropped.
> > 
> > Use the newly introduced devm_clk_bulk_get_all_enabled() variant
> > instead, which is consistent with devm_clk_bulk_get_all() in terms of
> > the returned value:
> > 
> >  > 0 if one or more clocks have been stored
> >  = 0 if there are no clocks
> >  < 0 if an error occurred
> > 
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> 
> In case you missed the previous requests, we need your ack on this patch
> so that Stephen can apply the entire series to the clk tree and drop the
> obsolete helper.

Please, take the following:

  Acked-by: Krzysztof Wilczyński <kwilczynski@kernel.org>

Should be sufficient.

Also, sorry for keeping you both waiting.

	Krzysztof

