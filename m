Return-Path: <linux-pci+bounces-27644-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D23AB5804
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 17:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 156AB19E6436
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 15:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363FB1DED77;
	Tue, 13 May 2025 15:04:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC1B28DB53;
	Tue, 13 May 2025 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747148667; cv=none; b=II1C9W/igJV3FnBqh5/0fNgbsXrt9nOhw5mJPWGaFv5VNhD9Ei2n58YjoepGOkXiPUkvk2nYaSG25fiVS2lJOZVHBcvuzG521trp4V634ub4mhQD1eXaEdmZdHCr0fIngiYXtU3/Xz1ii0j9vxnmo8t3N4LgbOTT6rGO0E8L3rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747148667; c=relaxed/simple;
	bh=RkUh+s6deg6gPcK3fK6glFz1looBnCJWsFsl7Qvnfts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHPFjWCiQ23q5Ou/5NuOkfchiQM0RJ8JOG1HIn5mv/ROnSsXnEbvdtb9wjzTYjbpNNVPnI5EMdTCUpiXmmdyFAIhxEoHnqGZS1BAG2/JZx1NhIfr5zSsIMF4SYTK8By8dcz+Odl1EWxGUi2ydmNEzCgA61ne4RtTtj74srzKv/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7426159273fso2480891b3a.3;
        Tue, 13 May 2025 08:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747148665; x=1747753465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yITWs07K4GdavqdUe0XT9i4Ry3JhIjDHh3ktnQPXkFs=;
        b=l8v/FeBl2bUHTTwkE96M9SStSEAjIoZJhpMkzTjp8z1fUdx5KV3OvL4nC8J0PFUYKr
         Cm+17wGpR+KdKGqSHug9k1aH/bbPd3UimSNSQ9sb6RgaAA0+Y5MwuM9FLXcweUz2V4ir
         bHgM9Ukti1Tkcau5plZsBEtPXAV0RDgQ5KDJP1a8LjArtQboiB17UGPd3rvHke32rzWb
         CSS2Z/YxvFUCCdLQXjdqmdqG3xnugOF75bhXhCVTvW3RhlVE0H7zZmlMSB7XS1SVoIpv
         j/0sskV0s6brBzRviEOcceyplHgvqdeDeYXwaopbUHE6x7Y3iaplp9F1UK1BxFz1QpiB
         isVA==
X-Forwarded-Encrypted: i=1; AJvYcCWGAKnbPnpDi4fd9hMJrVsBbdGmTM4PbdVNV61cPuq6Uez4G77dYeOLQ82/4BEjpa7udPy1n0mfG9jQih4=@vger.kernel.org, AJvYcCWlI9I2ogbr739Laro1Gs2XbJCOmutkfEEqGcnDD6uWp7rySP+CGynD1w1Uju0oQ+XB3u3RJmxoVBYY@vger.kernel.org
X-Gm-Message-State: AOJu0YwowI1XIS8gaidSIhaDI2mXObtZUvv9ioWRJB6ganDf/zIjHfQ7
	goFUE6/KSmshniePeaMTGvuuzk9twjXctEREp7m5UzD7IJLlHNsy
X-Gm-Gg: ASbGncvJ/tOHz6TNLpdjTCk9bszAGSHv5HLW7LDDdMB8n3gLYMmEPyXqXf92OO+jAIA
	XNj7LnY45Q8+HX8Qt0BKryqzvDvsbxeXzYYxv/+eKFUpIwKmEm9zorb3BJswy9QE8/VPGAMgvLb
	mNl9L6egkOswGeal6g2CaiUDyHdt+szJPnNDGcdkV1JAk4OgElqMbacCrnN26HpLuyX9bYeFCkL
	vxWXw3EsY8JgGI0bjh2sk8hxibLQf2k/cXTaLmLmg4TZD+kne50D5rNNyks0v0Sj21xtbKOXB9E
	28XpUpcJIY0kh/aMvM9OHV54ipqUYu994483GpX7c3IeVjtysJKrmxc7X8F7jmufEY5RgAT5Z6i
	Kjc1JooqZcA==
X-Google-Smtp-Source: AGHT+IHblYMGwrTD7z8+lgZaTlwQn1iS/NrxXTYAilYUHSke8XvAoOxB+q926Nzz3ptze40Lg/5+5A==
X-Received: by 2002:a05:6a00:2353:b0:736:3ea8:4805 with SMTP id d2e1a72fcca58-7423bc5da8emr25200215b3a.7.1747148664715;
        Tue, 13 May 2025 08:04:24 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-742377046e8sm8208640b3a.11.2025.05.13.08.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 08:04:24 -0700 (PDT)
Date: Wed, 14 May 2025 00:04:23 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	manivannan.sadhasivam@linaro.org, cassel@kernel.org,
	robh@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2 0/3] Standardize link status check to return
 bool
Message-ID: <20250513150423.GB3513600@rocinante>
References: <20250510160710.392122-1-18255117159@163.com>
 <20250513102115.GA2003346@rocinante>
 <ec54f197-acfe-43f4-b5dd-d158d718c8e9@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec54f197-acfe-43f4-b5dd-d158d718c8e9@163.com>

Hello,

[...]
> Sorry, this is also the first time I have done this. For other patches in
> the future, I will do this in the new version.

See the following:

  - https://lore.kernel.org/linux-pci/20250513145728.GA3513600@rocinante

While I cannot speak for other maintainers, I am going to change the
approach to the "RESEND" patches that I used to personally have.

But, if in doubt, it's always fine to send another version.

Thank you!

	Krzysztof

