Return-Path: <linux-pci+bounces-13200-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FE0978B88
	for <lists+linux-pci@lfdr.de>; Sat, 14 Sep 2024 00:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1361286911
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 22:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CEB154445;
	Fri, 13 Sep 2024 22:51:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E447489;
	Fri, 13 Sep 2024 22:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726267864; cv=none; b=GWady3KHBjyghuBOE6OX4NJ5dsGzNQ9I95K/qe2ZjduKRCM+M0GfaEdWJR0W7kuT/K7sUsavt6OfVGEdu00GI4vCnuBoJlypqb2n8Eip9oa4soFd+ebr8mhIhe9RFQilVg5SM7TEpBtM/SIo1/ybMoKDlml0IbWGHmdwr+6ahfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726267864; c=relaxed/simple;
	bh=MYvaynuQXdhaobfMDJqfv7VSxUQdajXeA4Ka9WdxXs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrWRTexdpZ0c4lBH5WJ2jQo5aMAlvFXvUTxIyWTenUD2rXIAvgXp5kGeZjrlCzMw+ju/u475ebApvoZqIdLR+hux/8j81JiUvIiGhwUq+bPtso7+u3hVhOk6HdNEA0oB6nx/oyjW9nCrTpaHcoWf6ZErdVfjEW/xnm5ul9DZ5Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7178df70f28so2106267b3a.2;
        Fri, 13 Sep 2024 15:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726267863; x=1726872663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bR6Kqm9GodMbVB1wefHw9RQp6Qz3m/Z4U+1kjOSQpXk=;
        b=s2T95NqFeQWvxZafOXDgGCzS8tfqK5Xyp7KLLM8tKzPADLugCN4Qnm+jXjmxCl/C36
         HXKmGVnDgIF2uQj7/7YzEEBJc6eKf+S5yMH2UkwGuaLMN9zOLo/VTCQGj2IwCOd1dnyQ
         5XVqr9XVMqw6+xfLd58xM++u/jKNV6+kW4b8trLR5CeJ2I29AzG9TXyu1hxDf5/8OSch
         XRke3rxpKYp8XfiJrWnf35tcN7yS6AQo3OFf7LnYjqbahGcSxFHOzOxUfUWOFhsQ5rKh
         EHRrqlWXTpQm+lA5fx0/AE64U6TB2jrLitCHmeJmkyTvArQQ6EC5byGx2oP3M+9CuALc
         HY5w==
X-Forwarded-Encrypted: i=1; AJvYcCVjb4kXuicyG3ljjkC2UG+bMt2J+8qMDcChWV3S8oiCHJWtHQIMMEOh7Is+aSv5F/6k8BkLqMZ/1JwlCsg=@vger.kernel.org, AJvYcCWM79ZVsLnsDPqZBs9/p4iUHSp0DLAOnYfl/66sv557CrjN3dPgTTSTBYGNdbPgpjD0SKYiHLZB@vger.kernel.org, AJvYcCXVCf5N7s7k4RKS5OMidqyHWqBgUSL+ale2+Dk3v/DcC2Rt4twwGrPll8uMhGXn/oxxAr5+deGB5Bjqew==@vger.kernel.org, AJvYcCXmsYFi7ODlnQGewuv5x5WfzotBtQPaMxUNCQmNQxoz6mrQkRzIWz9vBeVW2j31UM8Z20/yYi4AKilM@vger.kernel.org
X-Gm-Message-State: AOJu0YyTKm6Sytl4ou3QDUI5TcSS11LoUVJyoZvZwGYChgVbw/7NEIBb
	TzQvv5k2rDO0vanH7T8CIPaWGsvqpkJ+Aq2T4N3kanRmfNvpVB1o
X-Google-Smtp-Source: AGHT+IGSzg0JTLmcVRyt73N3xHythdE8MghhASiBSCuxRVsDHg+VJR0+EvGCRrJWXlazo/36fFs26Q==
X-Received: by 2002:a05:6a00:2381:b0:706:700c:7864 with SMTP id d2e1a72fcca58-7192605a15emr13846030b3a.4.1726267862602;
        Fri, 13 Sep 2024 15:51:02 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db4998ec8fsm169385a12.58.2024.09.13.15.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 15:51:02 -0700 (PDT)
Date: Sat, 14 Sep 2024 07:51:00 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, robh@kernel.org,
	vigneshr@ti.com, kishon@kernel.org,
	manivannan.sadhasivam@linaro.org, j-keerthy@ti.com,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org, u-kumar1@ti.com, srk@ti.com
Subject: Re: [PATCH 0/2] Fixes for the PCI dra7xx driver
Message-ID: <20240913225100.GD635227@rocinante>
References: <20240827122422.985547-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827122422.985547-1-s-vadapalli@ti.com>

Hello,

> This series is based on commit
> 3e9bff3bbe13 Merge tag 'vfs-6.11-rc6.fixes' of gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs
> of Mainline Linux.
> 
> The first patch fixes conversion to "devm_request_threaded_irq()" where
> the IRQF_ONESHOT flag should have been added since the handler is NULL.
> 
> The second patch fixes the error handling when IRQ request fails in the
> probe function. The existing error handling doesn't cleanup the changes
> performed prior to the IRQ request invocation.

Applied to controller/dra7xx, thank you!

[01/02] PCI: dra7xx: Fix threaded IRQ request for "dra7xx-pcie-main" IRQ
        https://git.kernel.org/pci/pci/c/03f84b3baba7

[02/02] PCI: dra7xx: Fix error handling when IRQ request fails in probe
        https://git.kernel.org/pci/pci/c/4d60f6d4b8fa

	Krzysztof

