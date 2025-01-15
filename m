Return-Path: <linux-pci+bounces-19870-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E0BA12251
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 12:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C37E41683FA
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 11:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517431ACE12;
	Wed, 15 Jan 2025 11:17:55 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6B6248BAF;
	Wed, 15 Jan 2025 11:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736939875; cv=none; b=kcSBej3X3etvuePpAAevgkZ7Wy/67aCK0VhADIOuPHU0ytKsuABtPNK1AMR8lgwGm1HJJjWkLyCinEfcneMrYr3MfQ8oje43D8V2ZXYp8zdqwUDOpzPNRZg7DExlNuE6nBz4dPGvzrGisKwE+ItZT1Dbo50fk2m0JGjTR/02wvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736939875; c=relaxed/simple;
	bh=cfI4GEfVwAe103HIGu21/plS6/k1VqOFLXDVEvFHko4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szJFmVQ/FrW1FJkg/PTqSGPT8pqqO45efvI8w6uLC3VVKjaDQ1+pq+0n517A3Yoszhje57lslnjaVpzEPrGmdtoJUqDzSNZ66XrPq55dT5JcFUqJQBlEwtdmYV/+LeWLCfkLO40KCFMXj1gxSbTyUCM6a+vvXvvToVuREO3GRrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21636268e43so155044835ad.2;
        Wed, 15 Jan 2025 03:17:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736939873; x=1737544673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ICinAMFGu+buf9AzcGZW8K8RxvHIsO44sPnWsdevCI=;
        b=t08x1hmeAQSUXopEh9mPVBmvIRwt018vvFYMhIvrbJpwDFkrgq47wNNCk3SnwIhxZb
         2+ezq2Qh4ZK86KgsQHR/F12ZCTlTSjn3P+laAWLPld5QjqU7KZUgIYeWUKU7YoxUo2UZ
         3i1F6xmHy/1tYq3x8ShoOy6+d7/kXX/6R3Yhg73qtDeMzA3G01tL7UoFtpv0LlkmWq4j
         KTFtov5t0DUEA3yCZTKt+JNd2UwYBNhy+Q2W2hl5f4VUvUjn0Scorbfd7tTY+0vBeV9p
         4f7FZWLMmPAVAQo1fNV2Mo3VHPsSGpd/2cf7AlK3U24lNEm67AzUEhakxkyERFfpO/HM
         uS3w==
X-Forwarded-Encrypted: i=1; AJvYcCU6kq2ZF8GaRIkVZ7TNUaCKvwukaG0pHfOTaJbNOqH8JqyZxeJLM5m9JFFdOaRFdMNv8E0W6WAeey4/96yq@vger.kernel.org, AJvYcCVMP8CUTLz5XqXZmVl0vtd/Syuyh6IKsbaD/50Mx5betZMhM959/wE+IKiR5KA6AWFaqrbNhr6jv7k=@vger.kernel.org, AJvYcCVmPAyPici9rHwbcvK3PptePbaHyEUc0KoM1PCZ/yliijtLdZUQOXZc0Il8+n4Zt780quxR9+wzdulM@vger.kernel.org
X-Gm-Message-State: AOJu0YxT3hG00mwiKFI10nExRB0IMFf+TVdZeFlqSKZJ5ZaID6ChWPZ1
	AO2fVNW12X1UVZ22+lsKsvY2cUTGdTEgEHDuejVKarYkAa79hhplqRPkU7WA
X-Gm-Gg: ASbGnctBt4kkSL1489ftlCnYb8KzLzqmHssm9sed4Ora02qXmS6661VjNa1k0q1npeR
	XzH2F2ekDA+ktUkkOSI2Ld4V6Wpi8SNM6EMCuhGnOb9WlQ3h8TWjDhiylB1PCq0XzY2JFGNKmCU
	8BiOcXRdmXnShSXqIsdewi+uHoK0yGFsayOK9mWj50h03oi57+IJtuyr67b1Ww8V7JWykTOTwob
	nJytJ0qzyhGGjiweUPQL+bs6Vaoc4+RSkrNBuKdGtUh9P8sSbIrV2+av/SsSyc+o1XRRKgssy08
	/hNeOU51ZwCSWQY=
X-Google-Smtp-Source: AGHT+IFXnhLXXQp0Tpt5mBMjFFgTend7rfnRp1COcazF6tnNF50kFGLbf/BIY/uMG2fLtZYy1Fipnw==
X-Received: by 2002:a05:6a00:b90:b0:729:597:4fa9 with SMTP id d2e1a72fcca58-72d22032690mr39304760b3a.22.1736939873240;
        Wed, 15 Jan 2025 03:17:53 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40658fcfsm8853038b3a.111.2025.01.15.03.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 03:17:52 -0800 (PST)
Date: Wed, 15 Jan 2025 20:17:51 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] Documentation: Fix config_acs= example
Message-ID: <20250115111751.GD4176564@rocinante>
References: <20240915-acs-v1-1-b9ee536ee9bd@daynix.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240915-acs-v1-1-b9ee536ee9bd@daynix.com>

Hello,

> The documentation used to say:
> > For example,
> >   pci=config_acs=10x
> > would configure all devices that support ACS to enable P2P Request
> > Redirect, disable Translation Blocking, and leave Source Validation
> > unchanged from whatever power-up or firmware set it to.
> 
> However, a flag specification always needs to be suffixed with "@" and a
> PCI device string, which is missing in this example. It needs to be
> suffixed with "@pci:0:0" to configure all devices that support ACS in
> particular.

Applied to config-acs for v6.14, thank you!

	Krzysztof

