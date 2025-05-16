Return-Path: <linux-pci+bounces-27864-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92ED7AB9D43
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 15:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35635505D84
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 13:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1777260A;
	Fri, 16 May 2025 13:28:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B7A5CDF1;
	Fri, 16 May 2025 13:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402096; cv=none; b=ZPMtdm/Cu47lnwImxh3HezhqSIkxWpq+dPckr0x56vI8riXFUN3vJ+U8hhMrESwOvNQ8izGwJOzPB4FsqZmFY8sD6jFYNrjKzftZaWg3Qd0BbHUdrulKu4rWHXi3u7NLFIsAyj8PjRgXYCfmHqjN9qsyRtEUszLahQ0szxZMDgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402096; c=relaxed/simple;
	bh=K3Mri+3mKdcXJmgWsJ5BPT9+NHh6gPs8IQSFgn0Ww0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSGC4mfKMLJ1fUgALkbsbK6bMdm351+wjNc+X8VKmWkE+pOXAMQa5Xj0o+I9nMQ1CIfOVWW2hawg/fOZsE3DD6mqmfYxqTbuMBKl8a1iKzjcVBbJ+NoQarXqUJb89e6KtJkryVHLcI4cTMU2FNZ4TQBzBsqrf96tf7YII2MJCKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74294fa4bb5so2902527b3a.1;
        Fri, 16 May 2025 06:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747402094; x=1748006894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lxnk5Xg0HoZixKR0uUNtrpbpAmw4XxOJhKZyPHpd9qc=;
        b=Hl/sBo4m31/d0FwbJDEUTM2S5Vzwz+RfYYLiIpP5mz33y6FtCdrQWRDxTZWH0NiM1b
         /JPVsfONIuASy+PSuy9GFy8wFKYStipnmUo0oIWHzy3wwpzRs8n6m0oIi1llZi9/GbxS
         kACQjN/bdwKeYPtfr4sDW7GQ6OAp8fYKAjSZbTBZRH7XKLy6FQDDCeTVHhewqfeOq4dr
         RTif48Cv/yRim+Ob9F+Bl9JCzvJ+k843QwQkS3MggzQs2wptNrn76f+mGbS00dRgJUYJ
         yIsXS6xFX4KApNG6qH3j/x3AZBvNf0KvvgaHie24suiaY/qH7d8FJ5eM/g9Om36vCoCu
         PWjg==
X-Forwarded-Encrypted: i=1; AJvYcCVF6ZXrV1Azkd1l01WzVndhs66PV0OfDVScaq9XIY9VtpqPGccwPJEK+u+fqutbQ3snYuVbLRiD7+iYw7Jn@vger.kernel.org, AJvYcCWApkijU9UCbcQaZcQUeyhj/kvenLi2Mj2hTtowGX8lXdVohb3lcAaNtlen1g/PvAGnN3JvK6gS/OM=@vger.kernel.org, AJvYcCWTNkTJULh/L1l0ipUrkDodcNH386Qvn1xATqZGrS+f9BN8DQGQdCg3DLxas+IDGMbS85Cz8UV7QwtL@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7FurrJP5OhFZyFwp3BuOJrq7p52QPNdB/kmq5ONRW7qbW5X//
	DWCA0YwfqstdkfGqzPIuPrpD1N4v85M7v5wEiGxtZKOXl7uhzJXUeWgy
X-Gm-Gg: ASbGncvw25y4KLtG4zzqvFXCFG+sivD/NflhCU5hV7T6YSRflUhoo0QiVtvCWGdVALi
	t7WH4ZtPK7T97e97ghq/SabpHW6LNfLBJZ/08xs2rOezPygcnWsBHcb+1BLjqGe/3obKDyHjNe1
	lz45VMLO9INhUWHe10Ok2IG7a9pdz9/WZqmXlmkqcvZ5Li/j1rQUol8pT0KM0AUcPDEuIriYh7o
	V25bInRVhk6WRRYitO+qNiKsOb1bFXCysXkQSaLoDRQsnNBSiaGtMxq6NPXWvEytlIF//iUAGYv
	PeKocZ9IS87RbJNsu35/9L39cGnxI4Phv1INOQ/XnJ83Bbm4xemOmCo8L1u38/Yr4Q8Zdm+t0Ip
	Byvdfa8TMWw==
X-Google-Smtp-Source: AGHT+IEHkuGefvWoBY+p8sOtRyAEKJgSr03lGawkXgJEdTBtBOyug/BtxaivjhWxH4dl6SD+WQkCHg==
X-Received: by 2002:a05:6a21:502:b0:203:ca66:e30 with SMTP id adf61e73a8af0-216219edf88mr5305508637.37.1747402093928;
        Fri, 16 May 2025 06:28:13 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b26eaf5a2cesm1537079a12.9.2025.05.16.06.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 06:28:13 -0700 (PDT)
Date: Fri, 16 May 2025 22:28:11 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: phasta@kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/7] Docu: PCI: Update pcim_enable_device()
Message-ID: <20250516132811.GB2390647@rocinante>
References: <20250515124604.184313-2-phasta@kernel.org>
 <20250515124604.184313-4-phasta@kernel.org>
 <aCXk2eDUJF2UbQ47@smile.fi.intel.com>
 <e44d880e842440d51c14f38df1d20176694e0d57.camel@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e44d880e842440d51c14f38df1d20176694e0d57.camel@mailbox.org>

Hello,

[...]
> > > pcim_enable_device() is not related anymore to switching the mode
> > > of
> > > operation of any functions. It merely sets up a devres callback for
> > > automatically disabling the PCI device on driver detach.
> > > 
> > > Adjust the function's documentation.
> > 
> > Is the "Docu" prefix in thew Subject aligned with the git history of
> > this file?
> > 
> 
> Seems its "Documentation: ". Can fix.

Has Andy been sending his review off-list?  Or something is broken on my
side...

Philipp, if you have a v2 ready, then I would love to pull it, while we
await for more reviews, just to get enough soak time and allow for the
0-day and KernelCI to run their usual tests, etc.

Thank you!

	Krzysztof

