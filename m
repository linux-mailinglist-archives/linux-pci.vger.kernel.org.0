Return-Path: <linux-pci+bounces-34183-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D853B29CF4
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 11:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE96B4E6A1B
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 08:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8544530C348;
	Mon, 18 Aug 2025 08:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="joLgrfFF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0307630BF76
	for <linux-pci@vger.kernel.org>; Mon, 18 Aug 2025 08:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755507467; cv=none; b=IRQVBLwym2Ca5P+G2zHlrlhzwhwf//kkTiP6zVUlKB0wrgrQ+LktMNTjmPC5dqcnzgOK0SMbA/UAB04JyRPXJ0Ec/FDdDRBb1NwT3gfznKq7QTp6HBMRXIDj1SfGFLusWsM4CLCrup0r7Ski0QOJRBwZWHIyEa0FOpVCff8YS+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755507467; c=relaxed/simple;
	bh=U8a6I0ZFus0vFy7ECIXwDx8gidXc8/GABtP4Ugbvj3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHMzqhcECwNOQtd+yeAa5SwfvHSPjxK4cDMZxlOU0vEljxrkGsCmeqeDm0CklZjmLJDGEDF27G1yZd1dZZrUpzGrF6/jP8BbbbxnKSKD/fzuHlq2jRU7QGPtKBRr6TSHT1d52eozSJs4riB3WtnyCEzIygQGE0DSD0Fdm0BJFao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=joLgrfFF; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e2eb09041so3122410b3a.3
        for <linux-pci@vger.kernel.org>; Mon, 18 Aug 2025 01:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755507465; x=1756112265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qe8G70eom6/4JetV7QH5UUKrtlBYh00PHg/YyriqGHk=;
        b=joLgrfFFDMF16c+OlfLqbc5LYzBoGzeW35Vcb+Ih/6SmgZvK9rQ4GB3Igx7zk1SRSa
         7Cqb/mOpzGIfuC7Url08iHGhfnTCVeYaKIP1OhAjkwPwiTfnr3phCpTazRTH8UCGXQpR
         yik3oTCKDfUpW2MvVykzbXPiZmo4vtPkRIJlPSXA7paAFCztpx3TMFZ6n2+Se6oyFUIo
         3GGczL2lrkSXMpMfRc78QdGFIewHmM9F84mgpkuS80Vu6ob6/8wfSRgTJS9L12OU3SfF
         yOa6SBNYgxZk2Meg/9pL29vhWKK/P+gqydI47mS0dVdbN8tmZBHo59Cz6gQe02qDHJR/
         7zFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755507465; x=1756112265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qe8G70eom6/4JetV7QH5UUKrtlBYh00PHg/YyriqGHk=;
        b=v8cMZvpytuo6TyB6bGmkN7IcFDiC5AJuc0gKKM1fx5QH1v2B3Ee61q+0paAcdwXmA8
         +pDodmbknbpzdCYyTOCEr8zBUWunOOqrQa5r6nf+E8Tt0QxLOENGbiTdwZfuqFTG1tSr
         3USQN2si9FvNxJ0xxeaeKry17Z7eQcLs7gspVNqxEFImq2HB1UIEcl/ssdJUMQzwOwGn
         gJdLNYgWqfldW6lNSCBDvQwR/sWl+fY1xkZE37LWoCQzenGHUV/Dknded8X4m4Gbv2T6
         OYKc2Q7eO4v2vWp7WyMo412lnl8wvUZTDescDGbtTMVjq9w+ldgoQasV49uvduCDgol2
         duEw==
X-Forwarded-Encrypted: i=1; AJvYcCUIqZsPA+XmxpWtsIADsOZkI+Nlh9ltwvxQTh/0kVAzCwiKsHK3IKUTCaPWzFxgZ3XQQdIklNop1zI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4ORt70LbG4vomjf0aZof9uPnnYecF9FpqVgyytm6bTPhGWY3i
	bztsw/+4kQ171oT77txpzr06dCQ6m5WILDkPH/obRwgDczk1xfBLexYVWV1G34c6cbg=
X-Gm-Gg: ASbGncuAYuQKYuzI9rcPrAy5mWwsvi8F40NEbrc5H9/zgW8kKG4sVzU+fSZxlfBvuqo
	RtAQizMU1//zU+t4m+g7GYqNB4JEQqWYMtnNhDZVIHVR0D4HGR0NQYNo873OY/T9vTSq4opOaIq
	rwSSG4ySAqinqzyeqp0MyscKyvqKOZiw6TB8xmBoSxuhY/rclgfKI96jcIVHtd7pLupxJFRG1NQ
	Y+OcpPqJEvN+rw0YRiGJZVtpjBZEHQWVAk6TobgGikuesVwa58Xx6PC9HxkBvPEevYXpivWGBUh
	nxf50GB1h6Tjf9gT0hwrw88a3m6srdnS8U61oYNpWsF6rLTTAWYKF9zJYEx+2ATXJ8QAeZyBo/9
	2go0elYrwVdnw8+WCwBFusel8
X-Google-Smtp-Source: AGHT+IGpOHn1sY/HqKXMp8oqym8EA0mZNqXhfzJusUYFoebvw0MYrgm3dTzw/LGlv+S50fD/of1ijQ==
X-Received: by 2002:a17:903:228a:b0:234:a139:1206 with SMTP id d9443c01a7336-2446d916185mr159740845ad.40.1755507462625;
        Mon, 18 Aug 2025 01:57:42 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446cb0dc22sm74615795ad.66.2025.08.18.01.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:57:42 -0700 (PDT)
Date: Mon, 18 Aug 2025 14:27:40 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] PM/OPP: Support to match OPP based on both
 frequency and level.
Message-ID: <20250818085740.czv5lpbktpmj7cit@vireshk-i7>
References: <20250818-opp_pcie-v2-0-071524d98967@oss.qualcomm.com>
 <20250818-opp_pcie-v2-1-071524d98967@oss.qualcomm.com>
 <20250818085517.dj2nk4jeex263hvj@vireshk-i7>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818085517.dj2nk4jeex263hvj@vireshk-i7>

On 18-08-25, 14:25, Viresh Kumar wrote:

Also subject should be: "OPP: Add support to find OPP for a set of
keys" or something on those lines (I was more looking for the OPP:
prefix).

-- 
viresh

