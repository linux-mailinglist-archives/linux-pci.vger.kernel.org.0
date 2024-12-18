Return-Path: <linux-pci+bounces-18740-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DAC9F7122
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 00:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2975B1884BE9
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 23:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4798B1A23A4;
	Wed, 18 Dec 2024 23:48:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0754192B94
	for <linux-pci@vger.kernel.org>; Wed, 18 Dec 2024 23:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734565707; cv=none; b=sVxdffawBdNPIvOFgZze9iDVKIVRywSat5230pTHjvXXbPe6DByKtBiikourFkmHrFfD8Rg0okoPnan/W4t8hfr0j/RapJwDMLW6pLb5HIsnsvHMrNBBX850uXR15TTzBBtQ0YzkuQBqi9fWzVuflnruwuztKfMqFsZY6ZXyYSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734565707; c=relaxed/simple;
	bh=HfS4HkkavOjFJSPbHxnUwqCIBdVcFzwyfZRLST8dSeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckuc1YRAvvIXGRMRn1QryIRpf72gPABD5GZgxyfWxYXOXLXZLkfXQtKXe0MKcTJq4+9c6AzINpvkyLMm8bkXmMBoxmw0Ky3U+0rFKj7We97oQ00QiYiDD8m2jIHsBkPuWhWbAoVFVwSMjAC6sFfcsN1MKFBQ/i5Dl9mu7TlnxtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7fc88476a02so81053a12.2
        for <linux-pci@vger.kernel.org>; Wed, 18 Dec 2024 15:48:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734565705; x=1735170505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1GdzYOL0rt+F8G7+IY5/+S5l2ckjfTZOfwuxE3vwUM=;
        b=lmDdECMpY/0TZdyFl2symLGZG6tunnyXMubpNneG43deEipqxAC/0l8xyy1Cbh8UK9
         NSn0HEZwAdeSoVc1UaB3ric+KFlxroXpudRUw+Sxmp19Cyib8gTqlql1q8mkryB3sq+F
         dSX877vkc9mQROwca1Z3IgBi5795QtASFJbHwCh3SgmFBMNr9jax7L439eddr44JTOQJ
         hvBYxPxcXMGRlqhv6+6VUA2Fa1H/Rtps/yPAuCTL8UWM1CQ8U5AN4ZrcRs/pLNRSgAJG
         7agD4Kv4SmEVQm9NDIP/AId4KDs90tbdpnfSgSV66/d0yn1+YRDthaTuAjqiO3mU32K2
         Xy9A==
X-Forwarded-Encrypted: i=1; AJvYcCVbNqpJpqzMzfuwvSHhov0dPpg8i0K77STzY+qzRGUONG/WhwWpkHWSigp9EBN833LSF+1HxfS9XUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzGJt5uGMrAyyouv1FUSp6ZznkxUVGO/D1njB63tbAh/2dpW7C
	NCZwB8InFHPOOZG3xCVe8afpjOKjb+18Oy5BG6SYmDK6pBKj7CHC
X-Gm-Gg: ASbGncvj2M2p1SRG9L57e8/pt1HRbZ9sIiGAB0HrKqyjMygHXxLOD841w/IhO5kfhqa
	M1eoAy5DRwTFapHsMdn1TaXlVTvyAxUnWsVFXQaPsOMtIhMsD9uSE3UlHCYt44evOp2hx00N7hz
	lci3zqvBb0BGicLzOMRMYxFhF52KQSu5gump+i39vyD7jsZDDv2H6LVCpdjWm5figDbq6KsbPyv
	T+0/YwQNzIUbLAOxF/mt5of59mr6e8JOzFYdsCnSC5gcYmDRbkhXgHs/k9OazpmU4Q47IhGzRfn
	0TUnXQX90mtRzq0=
X-Google-Smtp-Source: AGHT+IGT5p4SyFlKBMb4/0z/aBX7x/FlY15bek+esbKV0g8mB+rjbHK6hnqNhkqtaZ6gKiY1pF6oLw==
X-Received: by 2002:a17:90b:1f8d:b0:2ee:c1d2:bc67 with SMTP id 98e67ed59e1d1-2f2e91f1704mr7724713a91.16.1734565704926;
        Wed, 18 Dec 2024 15:48:24 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f44788450fsm60218a91.33.2024.12.18.15.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 15:48:24 -0800 (PST)
Date: Thu, 19 Dec 2024 08:48:22 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	Niklas Schnelle <niks@kernel.org>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH for-linus v3 0/2] Fix bwctrl boot hang
Message-ID: <20241218234822.GB1444967@rocinante>
References: <cover.1734428762.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1734428762.git.lukas@wunner.de>

Hello,

> In response to v2, Ilpo gave a heads-up that the first patch in the series
> was problematic:  A zero Max Link Speed is common in particular on Root
> Complex Integrated Endpoints, so there's no reason to emit a warning
> or assume 2.5 GT/s.
> 
> In the interest of resolving the regression before the holidays,
> I'm respinning already after two days and I'm reverting back to my
> original proposal to use 0 as lowest bit in the GENMASK() macro.
> I've amended the commit message with an explanation to address Ilpo's
> concern that the 0 may cause confusion because Supported Link Speeds
> ends at bit 1.

Applied to for-linus, thank you!

[01/02] PCI: Honor Max Link Speed when determining supported speeds
        https://git.kernel.org/pci/pci/c/bec4e3709ada

[02/02] PCI/bwctrl: Enable only if more than one speed is supported
        https://git.kernel.org/pci/pci/c/117a857baee7

	Krzysztof

