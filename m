Return-Path: <linux-pci+bounces-19937-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1E3A130FB
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 02:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4B53A413A
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 01:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E33449652;
	Thu, 16 Jan 2025 01:57:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F8CCA4E;
	Thu, 16 Jan 2025 01:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736992671; cv=none; b=kSm7GlploAQM89gG7TiCCulPrOCnzj6tr0WW7ZnasjDIX2d8V9ws8DgC3bchtOCOzZNQE+GrAGRqzu1mCd6Vhy4VCmfkHwaOfcYzxth9D9yvMK4IjDICBDSYRk1FDwXDguEQH3+0en1Oro4kJRaWC4kgYqvq/kn14/ySJWFzDz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736992671; c=relaxed/simple;
	bh=b0+FM0AZacD38mIYBRYoMoYI5QfZ28k0KCMFpcOA0co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aC0tCc9PfFOIu1b19FyEtsABcOe3fihZo+HwB2Iu4FOSWDM3CceDWgoV2hCV9JyMyfa9ESmJgczyxMZrvFobb2yWREqFfpzpXcP2+dlzeHRVAB+J6+P8v0IIrokN46fQRDvncv9jK4/gWVvvUf9iLJPOBoHCRPDhsZVeLVPKJko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21654fdd5daso5778495ad.1;
        Wed, 15 Jan 2025 17:57:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736992670; x=1737597470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6hIQQdkcr6RhX/odHqB0xx/En9dMpWdJ9Q+teQgBnX0=;
        b=Yet3UnV6akK3LjseltLPm3Zi8GPqwz/h2VAaIs/hAlt9rtS9it4efJSypMZBnhn4i+
         3QFg76a8799j+sRfnmIaEM9UKCr/CWin9HM8QoqL/K4rpuq1nHP5LX3LSJLQgwqvTrPE
         UxZ/XzrCJKPuCKj0B+tw03ItungX7jQbr74ZNiS3F3TWRUToH3MCKui1/A4rJHBD5K3Y
         LiHQL1SCp6DWcYL89OHxgAmmN4GTJWvFlXC4Cy0eu25/OxNQp8l9Ibkh8CdERl2em67m
         1w7vve5gKTB1GV190sANUfnopAre4JrHxMoZBH9h226eH8vi/jeiigwWtUElVLKPm+l2
         jTRw==
X-Forwarded-Encrypted: i=1; AJvYcCWj9czpxeet3HEus0NuJ6XmZzS2kdzjOIUrDFyj+R6cuI1uATcSA84rwubFRdlVP2AhTJkWCqncfdkZ9NWz@vger.kernel.org, AJvYcCWuigcZXhfu9lfH2GIIqqU/izu4g+2+BjY6hkyxHJ/8UrjiiUaJRmT34Y35PiM5f1dQ4n3dP8Gh9KbF@vger.kernel.org, AJvYcCXmyjO1YUVzTbOABJJe5qBEba+GMfWL8BaPmSd42dUMkdHc97XYPzUzAOsXyEoihFgBbA26ffSWicMoxGwS@vger.kernel.org
X-Gm-Message-State: AOJu0YxPDgw0+JVfa3c4YN9eNjgSUKQsjQRGt5QzTlXO/MLqCVlFxpmJ
	gIc8IoVwzyE0zrGczKTy6TabY9j8yLdlG3qtWgO7jEhSL5z0wX3n
X-Gm-Gg: ASbGncsnfcKcMbkbgEWIDSHm6f9MBUpzzGqBiW3xjuLT6OB9PwSBUBlu2goSQMl4ieV
	aGBaM0KPWMd5J6qcIygIrmVbmjjdIL5pisbdUtcU74Y5rkKA5HGzElp91QSA7DecZ2boX8Z6+rW
	w/gQCpmDpGegJSTDEn/w5GaJ2u9VER0YBFk3AzZocu8XAosEbYYYh9WTJDOX7lFKHPSm2y0ZjT+
	IZdF4COHtzVsbWue+mGJOEQLguqR3EPVXFpbjkW7M3mFb1S/++ZzqNO5jAAFu7eDBaz8YAExlFC
	DVYrNgfKUUNEc3M=
X-Google-Smtp-Source: AGHT+IEYuDaKngFd6JtTbSao26F3b3tTw+qkbUTAGhKxDNKR2wX6vHNAECHSF/PqZdOeZ1EPU1V75Q==
X-Received: by 2002:a05:6a21:3399:b0:1ea:ee89:5d9b with SMTP id adf61e73a8af0-1eaee896015mr15952702637.21.1736992669964;
        Wed, 15 Jan 2025 17:57:49 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40681bd0sm9801454b3a.150.2025.01.15.17.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 17:57:49 -0800 (PST)
Date: Thu, 16 Jan 2025 10:57:47 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Konrad Dybcio <konradybcio@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	andersson@kernel.org, quic_vbadigan@quicinc.com,
	quic_mrana@quicinc.com
Subject: Re: [PATCH v5 0/3] PCI: dwc: Skip waiting for link up if vendor
 drivers can detect Link up event
Message-ID: <20250116015747.GD2111792@rocinante>
References: <20241123-remove_wait2-v5-0-b5f9e6b794c2@quicinc.com>
 <6f815dd0-f111-6f7e-16dc-80b0dad7806a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f815dd0-f111-6f7e-16dc-80b0dad7806a@quicinc.com>

Hello,

> Could this series be picked up?

Sorry for the delay!  We should be good for the v6.14 release, hopefully.

	Krzysztof

