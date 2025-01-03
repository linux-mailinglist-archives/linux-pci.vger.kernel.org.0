Return-Path: <linux-pci+bounces-19192-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B54A00277
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 02:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28FDD7A1B87
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 01:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42C1137775;
	Fri,  3 Jan 2025 01:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R1fgvLUV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215AF11CA0
	for <linux-pci@vger.kernel.org>; Fri,  3 Jan 2025 01:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735868610; cv=none; b=ds6moU2omdwg1qbcT4EMpuRNnFEkms2ogRpIBemDdq4snZBB0js+DLWEtgGnnuzTKvOp97ouJhyadP9ZAWj71EKvJhLEyntf7zfAUEg9e0ogOeESPGZFaA9F/4aXBkN/WpQWKkqJLcehy43vJhPnCFglCgVpE29vQHWcOFVD4kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735868610; c=relaxed/simple;
	bh=vNndI9LZcwHH6Y3vWf9YNryxmY9fG8HSj6cNRYb3x1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJgyAqqHBq+gTF4vzR0jQBJ5PwKZAGFbdvbPPCQ5wSAHEC36ZMY37ZZT21quVxmJ2jCHHhNdKNFEHQxwsWRmvzqGuCdirfNoiXDD41zGcLplqwl8kmPzKZ8ApJW7JHr01VUhY3zruRyliFLnxkMJkUOZltp55XdZ0pYSayLk2XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=R1fgvLUV; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21649a7bcdcso159087155ad.1
        for <linux-pci@vger.kernel.org>; Thu, 02 Jan 2025 17:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1735868608; x=1736473408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Q7qrFoRRjNsCU67hKLaHi7leV6habWZWnDMjovAGb4=;
        b=R1fgvLUVSGBxwMBwKyWOcWrL6yaFVW71z5bJQDix+oY4VhfepD5HBrFvOmzLAD3WR1
         bZmCHjRriPsKq7W4nRT8ENzSM0FQ/wnJeb4PjzY75QrABVrEVKVzoxlPUOZ9DQRQyAF/
         dSC89NCJjoLk3IoQzwSFKU0uB0o+hUQ42bJYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735868608; x=1736473408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Q7qrFoRRjNsCU67hKLaHi7leV6habWZWnDMjovAGb4=;
        b=ntDdxFdP0PXlZf+VDqF8DVqXwqk7KPLW4UkrlvwyFhbSMxESPVG2l35vkqpHLuuvEP
         ADf578FX69JKRDVrMt1eREeYeIJKLnJ81DyXMrEV6lYAG21EWAxImP26YTjnyIeQBxA5
         t97G66JFI2+PvzzUyavsLFl8OfrdkcSRH275ouHODMVi3K4rh/nFFv1kk0B11tdpjIes
         IWGEMuLK42RvHuaBSWmxSj1KvaGjpsob7/JdgXpCQ+o4sffTLS7n5gdRe3VEhRvk6jTN
         iDosjZa3CEq4iB+hCuXeawhBlalGVhfctRfFraHGR/ZKHJpnch6VnKGBYdiLKm4urdJd
         ZXDw==
X-Forwarded-Encrypted: i=1; AJvYcCUppcWKX2VxBdd2YD8kf+BH8sRKF2iLMOYE72r15QdX4u8ypKZUt9V2KT+IuvopfBazgoMLxO6IekQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YylLZmhwhMKrUI8VsDkvZDKf5aOPK9BMPD3el4V94mLFo0Ha954
	XriOi7njnEKrovk9ydfmNOBC6FzOPkGwvXNlNh6k4qgOpqzMI3hQ9HdYYuX2ZDeRHOklOgZOOLE
	=
X-Gm-Gg: ASbGnctMHXZfCOjHhnOigKI/ClNLpgEEqSi30fykrn69ciRYTa9D9bAJo67S+h4LVT1
	zZIym66IJe2rna/PhjzvsiuSVURvIDFA8HNW4EcVYWC6PDpBkaGE6yW+IMLtbtkiUJB3xTYffjO
	ufoXF+7cgjMLQ6198nbSVHPe13drQoDLEs7C/5+93DryM0bVSxZj/pSJiPKtEirKpH7TMs+00Ij
	7Z848yURPhVmlswGVH+hVDWlpf4bPEHBtG2P1RnDCTQTnyIwFMOEhH5EKkdkD18Mnx/spPywXDB
	UmzZ+mbrQwQLj47vsnQ=
X-Google-Smtp-Source: AGHT+IEyokAoD80/sjdIV3JIQ3DSu4zM7TJboSZL78A6caQdKqnHUNCJTZLOydzxTxG7Tl874q/2mQ==
X-Received: by 2002:a17:903:230d:b0:20c:9821:69af with SMTP id d9443c01a7336-219e70c018cmr670912955ad.45.1735868608471;
        Thu, 02 Jan 2025 17:43:28 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:2f1b:db40:bb38:fa8e])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2f4477c84d0sm27287665a91.14.2025.01.02.17.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2025 17:43:27 -0800 (PST)
Date: Thu, 2 Jan 2025 17:43:26 -0800
From: Brian Norris <briannorris@chromium.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH] PCI: dwc: Use level-triggered handler for MSI IRQs
Message-ID: <Z3dAvgO3XEUaJfq_@google.com>
References: <20241015141215.1.Id60295bee6aacf44aa3664e702012cb4710529c3@changeid>
 <20241230171145.hsqynixmowjn77ki@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241230171145.hsqynixmowjn77ki@thinkpad>

On Mon, Dec 30, 2024 at 10:41:45PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Oct 15, 2024 at 02:12:16PM -0700, Brian Norris wrote:
> > From: Brian Norris <briannorris@google.com>
> > 
> > Per Synopsis's documentation, the msi_ctrl_int signal is
> > level-triggered, not edge-triggered.
> > 
> 
> Could you please quote the spec reference?

From the reference manual for msi_ctrl_int:

  "Asserted when an MSI interrupt is pending. De-asserted when there is
  no MSI interrupt pending.
  ...
  Active State: High (level)"

The reference manual also points at the databook for more info. One
relevant excerpt from the databook:

  "When any status bit remains set, then msi_ctrl_int remains asserted.
  The interrupt status register provides a status bit for up to 32
  interrupt vectors per Endpoint. When the decoded interrupt vector is
  enabled but is masked, then the controller sets the corresponding bit
  in interrupt status register but the it does not assert the top-level
  controller output msi_ctrl_int.

That's essentially a prose description of level-triggering, plus
32-vector multiplexing and masking.

Did you want a v2 with this included, or did you just want it noted
here?

(Side note: I think it doesn't really matter that much whether we use
the 'level' or 'edge' variant handlers here, at least if the parent
interrupt is configured correctly as level-triggered. We're not actually
in danger of a level-triggered interrupt flood or similar issue.)

Brian

