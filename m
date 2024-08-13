Return-Path: <linux-pci+bounces-11655-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A95950DC9
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 22:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94B031C22324
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2024 20:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA6E1A4F30;
	Tue, 13 Aug 2024 20:25:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FB8187F;
	Tue, 13 Aug 2024 20:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723580700; cv=none; b=rON8gHJgZ/zmlivCfgYucYq8Fmi9OOlNTjD18bx1KXAVEX+5MvpY+h+KL7QS2E5XcQTGh01breKc0af4H6cXwU4VnMRygz+YdbNwjY5+pZGedUTvpsiPyL2RJEXsTRlq0gsgZxBqpgQ0+k0qOkDAq6w/KomMv4tmSjL+eElD8K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723580700; c=relaxed/simple;
	bh=wIlDKCsXJeboUMZrJ2Sm5A0TPgoxDqbV7n7P7xIrOt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPnM902kR7A/oQ8A8kLp6xJmo8M8W+9oI52by+pBv53ptWbFBV9uJL8+eurpkJDmJgKC6s/7u2nKOqc7W4IdWQ967iDp7WWywtaT0yuohiInBkbMBPp2EDk7l9ov5Asz0svzIsGZ9WV+hGLgzUQ1m9YXNgIkpiNTWpn5y+CAo7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fc491f9b55so42692315ad.3;
        Tue, 13 Aug 2024 13:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723580699; x=1724185499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=quenUURw5ynby1W81kTijG5HkfqC+NVKxViDT2ifuPM=;
        b=jiaiee+SftN2qhu1/g9pwB7LCaQo4Cl24WmxOz6hb+lhsVH+tzK0/6jOR11/Qi9pGx
         9MC53OtNvvZge/9V5vvJnb9TIyUspCLTT1aBbfkrx22YuN9PG3snabQQrhkBcR5WbzAB
         YlCvVNBjm0T7aAdtDRXFq1b2elBpTYqfdzjDjxdRNaYXFRGgtP0KBu9963KB04Vn6dAG
         ntJ4+uUjjja5zEd+rcrt5MA9ssjm0P2juCClVtXIYs93jTlkzRDMUrOqicDWZ8VUHyii
         Io0IH1x8zPzmdwzOGHZdVWGXTqZUa5bmnd+UiZJjuAhFtobCwAyhvaFXWy5yoY9lH5xm
         msOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfGta0Vnn/QCFRAN1VC7j28tzsDvZMbfzqCu3JSgVNgpbeRNHJvsD0KKQJOHJ3C2vxYjhZeWJDVCiYMHVCfm5OYBkPITWd1Iw4h1Sfa1jzQlMfs8vGEr9g4qfOXVMeAh1wLLDJWAvpJcc7T16PDjbhTBUdGDUbTZvcSYsy3oGPGMOOU3KyJA==
X-Gm-Message-State: AOJu0Yz+7zY48+bfbWX49dkjq86Sp0DRM4zMlnB8Y16Cc5KRchiI1QTC
	Rp02td8C1FKqCGgX9qIJbTK+TN1sUimKZxq9j1HU7XlHd4eK3HLP
X-Google-Smtp-Source: AGHT+IHjC5oISJgD63ifwG0y1Rsh5mWlxcPUysXZovkhKV60+/TBUDV6LteGjCltHKwtSHuxIFnv6w==
X-Received: by 2002:a17:903:2305:b0:1fb:6d12:2c1c with SMTP id d9443c01a7336-201d63b3e4dmr10758675ad.19.1723580698764;
        Tue, 13 Aug 2024 13:24:58 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201d7c01f75sm967545ad.200.2024.08.13.13.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 13:24:58 -0700 (PDT)
Date: Wed, 14 Aug 2024 05:24:56 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Use OPP only if the platform supports it
Message-ID: <20240813202456.GB1922056@rocinante>
References: <20240722131128.32470-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722131128.32470-1-manivannan.sadhasivam@linaro.org>

Hello,

> With commit 5b6272e0efd5 ("PCI: qcom: Add OPP support to scale
> performance"), OPP was used to control the interconnect and power domains
> if the platform supported OPP. Also to maintain the backward compatibility
> with platforms not supporting OPP but just ICC, the above mentioned commit
> assumed that if ICC was not available on the platform, it would resort to
> OPP.
> 
> Unfortunately, some old platforms don't support either ICC or OPP. So on
> those platforms, resorting to OPP in the absence of ICC throws below errors
> from OPP core during suspend and resume:
> 
> qcom-pcie 1c08000.pcie: dev_pm_opp_set_opp: device opp doesn't exist
> qcom-pcie 1c08000.pcie: _find_key: OPP table not found (-19)
> 
> Also, it doesn't make sense to invoke the OPP APIs when OPP is not
> supported by the platform at all. So let's use a flag to identify whether
> OPP is supported by the platform or not and use it to control invoking the
> OPP APIs.

Applied to controller/qcom, thank you!

[1/1] PCI: qcom: Use OPP only if the platform supports it
      https://git.kernel.org/pci/pci/c/d0fa8ca89100

	Krzysztof

