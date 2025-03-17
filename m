Return-Path: <linux-pci+bounces-23984-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E61A65D10
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 19:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4FF41894BF8
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 18:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1511527B4;
	Mon, 17 Mar 2025 18:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m3gWHrZV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4881A0BCD
	for <linux-pci@vger.kernel.org>; Mon, 17 Mar 2025 18:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742237077; cv=none; b=obkN7sNozqS+zZ6h7X1Gw1E3Mw/cbfsI9g516yczhHlxqIdSu7IxXojNuYXKbWzWpUEoSWUnPWGHuYb5Vux2jhhajatmCJANl4agakfwvtTHS5QKAPNEcmr1e+r1+fFFRwMVaTApK6557L2THRQ5Fqnd5Qj+5WGwEVnAOOfBxJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742237077; c=relaxed/simple;
	bh=9iOXAs2PFt3YwJampbSJRtPXBI4s7pqVxzc8QTfv/EU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DcWymOla93Ko/jJscaLME4TiSBpTeDaczodRnOTkqO8hie0DV3blxBpQgLC8OSm7dGwrYIEUxDu7Lre2HNcF8unga4sD44t37rjc32f7WYVHub1o70I75VD7uvTqM1e+W6UXs85Hp0GnDjozAC6hkKeBH0VW2Jwe0PVbtXOdjs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m3gWHrZV; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22359001f1aso42111625ad.3
        for <linux-pci@vger.kernel.org>; Mon, 17 Mar 2025 11:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742237075; x=1742841875; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oR3+sjzXfF1kJu70R/WOS6OhxjSB2FVGl0MhcctQyD8=;
        b=m3gWHrZVN+5WRiJmJyXiBIUVN0+g6de0QDYfaFmZZQiXDeHdr+PH4ee/RNF+UfzqRo
         rN/jhhO61+/pOt5JyzcrECGkWsoWwGbeuVB3WZeE1pREW3HeSSJI27dZSOM1a4qh0Z6g
         Xg53snEUJGQ/WaGfm8tZkb8UnXDblgNGg2pzT6mzhZosK2cU/1NOsEjqc/I5fd9qoWKB
         3W0hBWu8VVj8WAeid9ff4WuerDCdSbDRfpe3H0uyFQtvHdkToqNKkjhEzCHUK6pF568S
         hFDlAddtbrKr2YNXzUQl6vnzlWWz+d/FDnZoS506XD3kPuE98JKXbPJRjssg+EJQbSfH
         EuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742237075; x=1742841875;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oR3+sjzXfF1kJu70R/WOS6OhxjSB2FVGl0MhcctQyD8=;
        b=kF9ODrACf3BnaPzNgaqC5PTWivZmzC1PPBUiCUMFAsXzkoidgvk0HVGrik7ilWtbm5
         m19ThFc+15sjUA+12RoA5A7Emtr4SgEmR3oC5+hHK4MEPaeazT3JWoeuJQyiOaZpYg1b
         DLd6JO1pn6AZo3IxTVm9cf+lAVjRUzO7JO8X02J77jfIZFwM3+Sxv9zDC6nSWPNRhxji
         1hHYNgZdSvUEj8+D9Ra9/ri3Y4mc1OecZ0cO32/mIaow+IUAMdxzELYtnzmb9mXwWfcl
         s+2ruOj4oFrIzqQUNFngybYdzLi1hSuGEygCwH32HKzmvWSmV0lkMDAYM/T7PuSzcRD3
         cfhw==
X-Forwarded-Encrypted: i=1; AJvYcCV1HxYyv++LFxCQIgDtd/jZi+co9kzKX6qZSTBfHigaE8rhLes4z3hD9U4zkcylTUAg7ukpE1SGnTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOg+58tJ+CAh+6G5rlsMmvWHQxOb/ZrQUEZ9feH1dv3BWijVbE
	+AmQCH4d1328JCgL0n7dSAXPessZup2/98/H65FN5Txo1oFMCLedyQvwvdoLag==
X-Gm-Gg: ASbGnct+kIqHtaidepJG0T6G9g8kTE8FfRmATSsdnKWRTqohSpiJLKgbHcVMU6F/hxX
	9yaAnO8EIneJ7kjp/J6JWRNUF1YNj+TUXDkl9CY4HTFKdoTVZ/gJCMHlHNePQD6TKhT2N+pcHTm
	QYeZ96uv3S40rjbGEQ6MO+TNlck7BPPjkCZ4CCBlI77wsh57lnZpx2tMCWWbHaMkzpW3NBOCw9W
	1r2d0nsGq3S7/od4JaMnpsEBxpBmF1rWf/hoUVdmGvsw00cHxLYHNnIbyGt6vv2tOx2+ra0CRu+
	TXHsAtMpd5eNyhW/G/Wa6pZyvC8Jy9dFLz3j3eti2km5XPuU3b19lKpNm/2Fbm2WQw==
X-Google-Smtp-Source: AGHT+IGISBTwHnOEY2bEJPR+BTe1q1qlpEiRYXNfbcGJ9ZaqciEpkdDRztt/9NPlZLzrMm9yu+GByw==
X-Received: by 2002:a17:902:e5c7:b0:215:94eb:adb6 with SMTP id d9443c01a7336-2262c5edffemr7634215ad.40.1742237074779;
        Mon, 17 Mar 2025 11:44:34 -0700 (PDT)
Received: from thinkpad ([120.60.130.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68884fcsm79360525ad.16.2025.03.17.11.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 11:44:34 -0700 (PDT)
Date: Tue, 18 Mar 2025 00:14:27 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Tony Lindgren <tony@atomide.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC NOT TESTED 0/2] PCI: dra7xx: Try to clean up
 dra7xx_pcie_cpu_addr_fixup()
Message-ID: <20250317184427.7wkcr7jwu53r5jog@thinkpad>
References: <20250313060521.kjue4la47xd7g4te@thinkpad>
 <20250317173008.GA933389@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250317173008.GA933389@bhelgaas>

On Mon, Mar 17, 2025 at 12:30:08PM -0500, Bjorn Helgaas wrote:
> On Thu, Mar 13, 2025 at 11:35:21AM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Mar 05, 2025 at 11:20:21AM -0500, Frank Li wrote:
> > > This patches basic on
> > > https://lore.kernel.org/imx/20250128-pci_fixup_addr-v9-0-3c4bb506f665@nxp.com/
> > > 
> > > I have not hardware to test.
> > > 
> > > Look for driver owner, who help test this and start move forward to remove
> > > cpu_addr_fixup() work.
> > 
> > If you remove cpu_addr_fixup() callback, it will break backwards
> > compatibility with old DTs.
> 
> Do you have any pointers to DTs that will be broken?  Or to commits
> where they were fixed?
> 

Any patch that fixes issues in DT and then makes the required changes in the
driver without accounting for the old DTs will break backwards compatibility.

> > You should fix the existing DTs and continue carrying the callback
> > for a while.
> 
> Any insight into where these existing DTs are used and how long
> they're likely to live?
> 

There is no fixed rule in this afaik. Just like we continue to support old
hardwares, we need to continue supporting old DTs for some time. The best we can
do is provide some warning so that users can update their DTBs. Then we can get
rid of the old DT support in the driver after some time.

That's why I asked Frank to add the warning previously.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

