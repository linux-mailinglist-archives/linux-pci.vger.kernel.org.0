Return-Path: <linux-pci+bounces-12406-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5880F963B0C
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 08:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFA98B25E77
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 06:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB911662E8;
	Thu, 29 Aug 2024 06:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i+YbH/Rn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB80D1B813
	for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2024 06:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724911810; cv=none; b=DH9xumjjJQwUMM9nHV9SzrwB0iEDWQTx8RoZ1Jo3Gbh8SfwCQPupQx0R1olufi5PQzcdrxEOzu/ottATG845EpHUe2yv05uYfqbf+0ysGUnfVQESKNnxid1wImC/wHUwwPTTfXa6TYNkLWoBQrIyj77l6zl41CavH12qbPQJO1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724911810; c=relaxed/simple;
	bh=3bQ+v33PjOKDL9PyUk6KQGaBLaRWM0mqrTwclvm68lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbq6VwhQpc8gJzouqC+YatGFGFsqQemdwbGH7twsCVFH6f/qaDQZ779qwixJ755PfNulyurE1CkX4ZRZfM6hM0iRT3WsNxHg7y1pBXVCmaxv4uJ2r954LZ3zrSuAO5HLNJSjnZYBnLfxnlYL9n+Z5x0QsOmNnwtfpIq9hLf5Bas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i+YbH/Rn; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d3e46ba5bcso206608a91.0
        for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2024 23:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724911808; x=1725516608; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0S52URaWMDTEnPWLvS3GnkbpfxFe9f5JxTrAT6HvQTI=;
        b=i+YbH/RnAiE2jX9jXjk0tk9Gte1YN1/RP2NPZ2Q1+tBn7TzjPrdqy9znWbhguwatEc
         Ib3azPnKqMe/xWBpDauje/qO8ipUKawQ6WJFDYnGm4vTwHGP8CcFGJ7LkotqXZQ6nyFe
         x1G3aBSixx/Qe2FoixBqmGEDr4/82NTRmsduEXSKINk+DY/AxUa89plUlzcPH2q4AB1k
         ktktrMx7DpZqzTkXXw62pRYqhXkZ3/aP2OVPVv9zK487Fng4nvIXDNDeS39N5WGH3x4I
         81hkqYuR/QXygkpnDvVwoXVuBxXBLm34gjUVcVYp5YOJP+hqdwAqBjTHvKC59/GmlsDq
         j+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724911808; x=1725516608;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0S52URaWMDTEnPWLvS3GnkbpfxFe9f5JxTrAT6HvQTI=;
        b=IlWFZ60gXLaFNlw95HjViSLs+7+63rOmpJViQZr0J8kkV3T+BG7XxqHEyAS9xV0xKE
         rKvS1fnunt987jAHON/LACRevXtl3l4AORniLF5p5G18lpaCJEtGEWJe+bZNgQh0SMGS
         SvyifwobonXdMMlwcBZn8u7HOL3i4LipZSvnAYaefVuQxVZVCf17hEj9uIvLAHeMtvlR
         jIYzYhqgA8PY78XGHhDwtow6yVUajRyuLrJALqlOysYxS3tuSsWx0ZTyskMr3U6yRfAV
         6r50pGXRxPIevTCQ3ebVnPczwOZox2/EwqyAnyXrW43oYrPVJereVlazlJivvZycBBLy
         ez5g==
X-Forwarded-Encrypted: i=1; AJvYcCUF/VKVKE/7f+7uJei5qQA47G5ZqSowh4eqkEpe2p2JmLPDY5PP76xgQyIi2XN5c7nbBn0qeAwOHnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOa7BtHeZCepb1oqRt/cztQ5eLCoVT5vSPHBt+Qj3Mvb0ntJ8u
	JqLOrSL9b42WMmEaYbH5i1jigoME2bPulEg/V4oSMTligPQNyWRhOCwE3V5Bag==
X-Google-Smtp-Source: AGHT+IHq23McC5oZ60h+7dTKZjifE8qRlzQ52Z2bRO1Fu/U8Hkfvwty0xa3nQqHlPpP/n6ZufuFhXw==
X-Received: by 2002:a17:90b:3449:b0:2c7:c7e6:eb89 with SMTP id 98e67ed59e1d1-2d8561ce61bmr1698289a91.23.1724911808153;
        Wed, 28 Aug 2024 23:10:08 -0700 (PDT)
Received: from thinkpad ([120.56.198.191])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8445e801bsm3052040a91.15.2024.08.28.23.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 23:10:07 -0700 (PDT)
Date: Thu, 29 Aug 2024 11:40:03 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Oliver Neukum <oneukum@suse.com>, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	lukas@wunner.de, mika.westerberg@linux.intel.com,
	Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH v5 3/4] PCI: Decouple D3Hot and D3Cold handling for
 bridges
Message-ID: <20240829061003.v2oghhp6buncosdo@thinkpad>
References: <20240820060008.jbghpqibbohbemfz@thinkpad>
 <20240820234504.GA231828@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240820234504.GA231828@bhelgaas>

On Tue, Aug 20, 2024 at 06:45:04PM -0500, Bjorn Helgaas wrote:
> On Tue, Aug 20, 2024 at 11:30:08AM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Aug 19, 2024 at 02:44:43PM +0200, Oliver Neukum wrote:
> > > On 02.08.24 07:55, Manivannan Sadhasivam via B4 Relay wrote:
> > > 
> > > > --- a/drivers/pci/pci-acpi.c
> > > > +++ b/drivers/pci/pci-acpi.c
> > > > @@ -1434,7 +1434,7 @@ void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
> > > >   	 * reason is that the bridge may have additional methods such as
> > > >   	 * _DSW that need to be called.
> > > >   	 */
> > > > -	if (pci_dev->bridge_d3_allowed)
> > > > +	if (pci_dev->bridge_d3cold_allowed && pci_dev->bridge_d3hot_allowed)
> > > 
> > > Are you sure you want to require both capabilities here?
> > 
> > Wakeup is common for both D3Hot and D3Cold, isn't it?
> 
> From a spec point of view, moving device from D3hot to D0 is a config
> space write that the OS knows how to do, but moving a device from
> D3cold to D0 requires some platform-specific magic.  If that's what
> you mean by wakeup, they don't look common to me.
> 

I agree that the wakeup mechanism differs between D3hot and D3cold, but I'm not
sure about enabling the wakeup capability of the bridge if only one (D3hot or
D3cold) is allowed. So I went with the requirement of having both. Otherwise,
how can we differentiate wakeup from D3hot vs wakeup from D3cold?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

