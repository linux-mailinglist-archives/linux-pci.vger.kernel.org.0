Return-Path: <linux-pci+bounces-23323-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C62DA59714
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 15:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B12E167DCD
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 14:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BA622A4EA;
	Mon, 10 Mar 2025 14:09:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726141BC3F;
	Mon, 10 Mar 2025 14:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741615741; cv=none; b=L8BugTsz/FccTSSWgv7dnDRtEg5uvNpTdJfJUeemUVI6jenknCBY6lxB7cjTgKjCMbzcP7mSHklmYgLN4h0Ft0Fqx58DCC7tARzWX0lQAnRO89CWh1Jf5f+moaYDja0dfTUvgGuSoT+czSbTf2dyEMdniNejLH/GN+86390kDXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741615741; c=relaxed/simple;
	bh=G9UCyT4l2O7OPqWEYczeSa9LdWLjRYlkeGLEDf74u7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mc0shlOdz9w+qxiLPfDTxMNatFZD+sfJcelJ+rE/FlPqXGRpxsD3v75WUExy171DxRrRoBe6ESkKxIUaGJqTxryAm6HtIYz8XQHUvso+pA2vYygEvRAvNtl9/59su/hEvyLuj2Cv/5KUgL0rhmq/SnTRKY5rnZJP6OL0wxdmLnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ff187f027fso7050155a91.1;
        Mon, 10 Mar 2025 07:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741615739; x=1742220539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5h3SYBfql4omWneWaJdQkRmE/9NSxl9a8mqADi7ZGk=;
        b=PhPfgQEPOiUfrw6Vv3llUrXq7MvGgsiU5bMW7+KUEMsdT/KdqzE/b79kfqhq81fdYW
         JfjhD8AWhX/MBtwRGoJ1zTL6FN3SuYVJGPvEL7+zDQW3lgzA1eMUjZHofAxmEkARgMn7
         oQKHh/Zkq8pBNGqaL+T7MqWBMmUzN8bBbftDeHp0iPPCa8lCkqej2400oIyt2xV3fYsH
         psTixxlo/CSY9ZiLkMtYstv+rFlctRkIDX9L3VPe/0ZwVOE2mNAILgUhiyGZQqHsuBzs
         V4eOvwySCV+pn5DbQH9ZEVSneqvR5zCbgKqSw54ZnwBS+iy7K/Ug6zBEBHyXOicMHaCw
         xtPw==
X-Forwarded-Encrypted: i=1; AJvYcCUPwyVK3U7kGIXsrd+BDYQfLNxJuexmIQFLbMt+ccOAyVsB85EU3A/kF2aAV9uk7VkL7VZkhdjrT6s=@vger.kernel.org, AJvYcCVRfN3Mvd1OLjH9gtOJEzB9P9BdpClEyx1P9oJxfWOvlM7Ad8r0gy0U/cv2etciOrdet4onZMKJuh926Zc=@vger.kernel.org, AJvYcCXCRHr+ahsw2eH2PIOpFzPP+au/Z4Y2mCOseHW+OIAt9yoFVaEqu2fkrX8vChia7FJ2gOSsynWE3jy7@vger.kernel.org
X-Gm-Message-State: AOJu0YzULJ0UdxbRRaNsT2J1CxKvVEX6PLWJGrB1AVMkcJNFb1y5O1UJ
	6lU98vXnDyKI4UaGtcfY18XRZHIqmmemp+mxFJCDhDI+Tyixbkch
X-Gm-Gg: ASbGncu7hnPckFA6JpaZrxfcuQPOTTo6XVqFf6/fsgyikVvx7XK48FArb74kmv/5sP4
	e/Gtj+wBSnW4WLz51tOtzNEcHGZF+EtfnBaQ/gzVYOEjghDK8nKyTd0qFgUv5S+gDTWQJKldFZh
	txBwmXjZ1i/9cUws8e0RZuMH9pVelHj50l++K15e6vJ1FoxcxJ+BmG8vyLWF4Zr1Re0Uar4QgHw
	RlRfQXnnAvern8zmiFj0OjSAw5i7GdOmIpeuLM+/Rs1pljgPK1GsobF/c1ugcbpKB542qbjyZzo
	Gui3Tdi6bbf16rJcnx5VQWgoh9ECKo40fiFnJuxOPW9X8hJHDtURenwdL3nd6yg14YtX185yWa/
	o/MU=
X-Google-Smtp-Source: AGHT+IGM03p5/Tv4OSxiEnrj/kqKi0xIfZxggxmIHwKPrBc3mn2mA+uLMTqTyaovlOHrDWE4UWWstA==
X-Received: by 2002:a17:90a:dfc8:b0:2ff:4a8d:74f9 with SMTP id 98e67ed59e1d1-2ffbc16c85dmr14827875a91.10.1741615738498;
        Mon, 10 Mar 2025 07:08:58 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2ff6933997csm8012298a91.9.2025.03.10.07.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:08:58 -0700 (PDT)
Date: Mon, 10 Mar 2025 23:08:56 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: webgeek1234@gmail.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sumit Gupta <sumitg@nvidia.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Vidya Sagar <vidyas@nvidia.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/2] (no cover subject)
Message-ID: <20250310140856.GB3334010@rocinante>
References: <20250224-build-tegra234-v1-0-39e4e912f968@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224-build-tegra234-v1-0-39e4e912f968@gmail.com>

Hello,

> When Tegra234 support was added to existing Tegra drivers, many of them
> did not have the matching Kconfig entries updated to allow building for
> the arch. A few of those have already been fixed. This series fixes a
> couple more.

A similar patch has been posted earlier.  Have a look at the conversation there:

  https://lore.kernel.org/linux-pci/20250128044244.2766334-1-vidyas@nvidia.com/

Thank you!

	Krzysztof

