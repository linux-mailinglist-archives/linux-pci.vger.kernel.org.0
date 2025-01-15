Return-Path: <linux-pci+bounces-19876-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23113A1228C
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 12:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC5AF3A5132
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 11:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E89A1EEA5F;
	Wed, 15 Jan 2025 11:28:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44BE1E9910;
	Wed, 15 Jan 2025 11:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736940513; cv=none; b=pOE6CXmXSbST+u/Me6hK6MOXn+lMan+dXyuJq673AnEf5cNdJNm1UIc2OumoXj7IBH1j5UyS1qa6RzV72erdPGOA5iVvxqFWEAKdvHMlny67lnFJeZ1nW65/6+L6xR7nIkdLhOjjAbLMo6hEuDPNvuaBRqdmZaHMPq65q9sqe/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736940513; c=relaxed/simple;
	bh=xlKJ3oOxgwww590AxrLAQwFpBs8b4TlyOoOdJv7+Btw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1OswTYWdHKbNLTNL+Lt7koIsJVXO+EDfzD1MGRfOeJr5G7FYf5AYQHhYa+mUFp7A1WDEXsYF/c6PW3s3TuyPYI7hDGP6Or9KEpa8oOlplh4uLmWKzo7jnlOCA+vrTaqNbkpOJ1FoO77M7zGUgKKuzYJbhVWqQlmbmBWAaigRug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2167141dfa1so13238145ad.1;
        Wed, 15 Jan 2025 03:28:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736940512; x=1737545312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pqp/xKYJlk6xjm9oXtg0IyK09CAv3plZIRx1yYheMC0=;
        b=X1DSiH4FZxXt89uuHggRGcXl3AN076tBRK2hA5MGyh4DeTB0/z1hdS1HS9G00UmOHy
         GfJNtiAzstBdPrdPNeAE3zAQhyaK3CeorYhDhALyIBcGTBUQd6wYHi0hR+BwMvMKa5+P
         wLPReYDxZ7fQ4MhfSBt3esYPkQL6VoDKH1qOwe6OwNIVjUAPUWxr+yIsVWYufDyKtTj9
         3MC/oZNn8sOwYTcZdnbD7TwBaQuJzkLZy7oma9Lj+uMR9/WfZAaB+7e28no4tfyOyBfY
         fmjoJxy+KXjppsBACfVnMc9cppVzorTbdl+Iu9ukXgPCTC78jLJzcGsXMBjQ7U0LB0zT
         cwHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXksX7TF8kymXmxzdj/EiIwjavolL7KX/HPswY642V4RIYSNdJDlERlZ+uiiwB+JZlvPbJ0p0Lz32IZRpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzERMvwh5xqvaxbs/heh/WBWGt3q0k4+whvMYAmvUqyxkf7WFTp
	pBvTDFd2cjot7cgNm9xI/ZHgo87A1U8iRzfpZ2Jgcchmo51qWRav
X-Gm-Gg: ASbGncudrc0rSFzMCt+4l2oFFQbp0ZugULAAf3VjJSte76hNlz7WJyP6ebnMAvRD24a
	x//GSDEuV2UaUdmlU0awT4BgKIAFW3gKU0YcYczWfWowuBeyZjjA6pCbDyFY1Xe7hTx+PM2tvtf
	666YFWYLoKVhZvo+ZEjLama1wCMDlJZEg0lgtJeXZGvw93Lz7vQDFGK2CdctkqQNnle8y5FLHMj
	fnMAPh+KFr5AmWltd0NqKRsJJ6TiSDWWssWic+wDebGxkv0/yvn1BxeFMn8HohL5pGxvGRGNPfp
	Im28rcAvgcSkm0Q=
X-Google-Smtp-Source: AGHT+IEKdHrLd7CdKz/bzUdcA2Iy0TnBTOOXFKEtiOmjZ3qwUkKfa5EV0XWzkjB574DaqoYFs4zJVg==
X-Received: by 2002:a17:902:c40b:b0:215:ba2b:cd55 with SMTP id d9443c01a7336-21bf0b76a12mr38927045ad.2.1736940512009;
        Wed, 15 Jan 2025 03:28:32 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f2199ebsm81265345ad.143.2025.01.15.03.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 03:28:31 -0800 (PST)
Date: Wed, 15 Jan 2025 20:28:28 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	cassel@kernel.org, lpieralisi@kernel.org, heiko@sntech.de,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] PCI: dw-rockchip: remove redundant dev_err
Message-ID: <20250115112828.GJ4176564@rocinante>
References: <327718207d3cd72847c079ff9d56eb246744c182.1736126067.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <327718207d3cd72847c079ff9d56eb246744c182.1736126067.git.xiaopei01@kylinos.cn>

Hello,

> dev_err is redundant because platform_get_irq_byname() already prints an
> error.
> 
> cocci warnings:
> 	drivers/pci/controller/dwc/pcie-dw-rockchip.c:454:2-9:line 454 is
> redundant because platform_get_irq() already prints an error
> 
> so remove redundant dev_err.

Applied to controller/dwc for v6.14, thank you!

	Krzysztof

