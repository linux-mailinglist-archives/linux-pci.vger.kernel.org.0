Return-Path: <linux-pci+bounces-7609-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3715B8C8570
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 13:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BED8DB21801
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 11:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AA93CF74;
	Fri, 17 May 2024 11:18:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2B13B78B;
	Fri, 17 May 2024 11:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715944685; cv=none; b=aMigegvaP7zHkGKIcGp81equsYbFKRzW4kSXJQGXin8rVnjk2RDAhCf5m/XyXV2Gg8qYv4c65fFrpyzuoq8wboRVZhhTlot2wrlN7c6ysTUe/OvlRO7CfvkqqDN/cZFOFIx/5ZsV1nS9OWmyIQ7RE/H9+thCqjoiTSXYMVkJGkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715944685; c=relaxed/simple;
	bh=wfHpHnQqgnNSn7YCwv9m9HcQPovFXltGWKsPEmdAunM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKNQoF5QZtpEYFuOJyK2OgnaUbZ1kvtwBBFu4oodcFaDmVdmyN7e+Y1MfJEWZN2JvMNADmNO87o12Q1bkQU2B9PvF8vEf7T+ktqgWJxncPSqbQPlYQmmkRnjk4kwg7AooqnplQZ+5yR7nobouLS8UwTMbqDUEDfesLc1TOhPunM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f08442b7bcso4833645ad.1;
        Fri, 17 May 2024 04:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715944683; x=1716549483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sg/FBsZBDfXOHm/J/YMr0AFImmpjs5YKstuD+GBKpXk=;
        b=EJ27qeVpqHvCVkJmPAk1QVmtPNv/Lv8FdCPhUpSZzRUOLDC/FqVT1T/P/mBtQFs+3p
         fRv5M+r3DkpQ6fMNUKU8geEPc8wMGvP4VmtJ2u7iOPhhlA7mO5VeviAliNV0fp71F8UX
         AZSL7FZfNHQzQSzPJaNocMHnjwfXq744OptTNqV0bxfD/76Rpr9sU4+qKyGfn3FDTnF8
         +ca7b4CE+KLmxKUXZlztUwxvGeV2eU2FeAMPhxQPzd69oCZ01Y9kcY+mfZKRq/9bucvg
         836jvf0u42HyD5+0tH4hpGfbgaAjNCh5bfYxkY7lSrzM/a+0OKhkJ2VvTOnwNLw59W8L
         sUSA==
X-Forwarded-Encrypted: i=1; AJvYcCWdjCQj/k0YDYeisme+aEpwxHtpysRfnQ8xcx8XWWEqyKsVopRgVoBRZ4VRrrB8VjIysF+9e8yLXK8AQZ2HHgEVwEJZE0imrJrAHmmAqZqY6GjEo7PrAD05cNlojMYUkf3Hi04khhlkpPl039padiqrtrjudtPkCv2Ui4NwB6kh
X-Gm-Message-State: AOJu0YxBei53opMDCs/yudiU5E/bj/djPbbTvQikqJpymSTh/CVGOmRA
	SUB1+zlIFr0Gp4us4mkWujc8/oJo2ly+GTj6nTJXdbXX4fnWiJMC
X-Google-Smtp-Source: AGHT+IGLCMl5Tz+z4zgIma4FE1efOHYJkIWhZpHWnn6EOooX40/8TI3S0B+Ebm6UayoulagUE+YyWA==
X-Received: by 2002:a05:6a20:6f0e:b0:1b0:66d:1596 with SMTP id adf61e73a8af0-1b0066d17b0mr12990949637.57.1715944683500;
        Fri, 17 May 2024 04:18:03 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b67158c39dsm15203894a91.35.2024.05.17.04.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 04:18:03 -0700 (PDT)
Date: Fri, 17 May 2024 20:18:01 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc: rick.wertenbroek@heig-vd.ch, dlemoal@kernel.org, stable@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: rockchip-ep: Remove wrong mask on subsys_vendor_id
Message-ID: <20240517111801.GQ202520@rocinante>
References: <20240403144508.489835-1-rick.wertenbroek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403144508.489835-1-rick.wertenbroek@gmail.com>

> Remove wrong mask on subsys_vendor_id. Both the Vendor ID and Subsystem
> Vendor ID are u16 variables and are written to a u32 register of the
> controller. The Subsystem Vendor ID was always 0 because the u16 value
> was masked incorrectly with GENMASK(31,16) resulting in all lower 16
> bits being set to 0 prior to the shift.
> 
> Remove both masks as they are unnecessary and set the register correctly
> i.e., the lower 16-bits are the Vendor ID and the upper 16-bits are the
> Subsystem Vendor ID.
> 
> This is documented in the RK3399 TRM section 17.6.7.1.17

Applied to controller/rockchip, thank you!

[1/1] PCI: rockchip-ep: Remove wrong mask on subsys_vendor_id
      https://git.kernel.org/pci/pci/c/2f014bf195ae

	Krzysztof

