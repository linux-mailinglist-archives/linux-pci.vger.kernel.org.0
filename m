Return-Path: <linux-pci+bounces-7549-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4828C7218
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 09:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12835B20C7B
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 07:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2560F3D967;
	Thu, 16 May 2024 07:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AC/g7Ror"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7974328DD1
	for <linux-pci@vger.kernel.org>; Thu, 16 May 2024 07:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715844905; cv=none; b=dQoi5sk9fZRxgLokW7PoWL7VN9z5Cv91uussSE4lrgC14vvmEwsu6e9Qskf8sIQGyBhnU6lW+Hgee9bdroAW5mokQh6I7wHS9B/XXDK7MuNGJH1S+RM0n+RLKryAJZlOBalq1oi3oh0HWowgSRmgud/qcbEozNhUJTdYqc4zVnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715844905; c=relaxed/simple;
	bh=ZMACuTR3vRKSoU4pHT19THsZk5hrQ3AyoJYvIvgJUUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oeb5ix9nuNpNH45rMqxGQMV5NxxKPEtc+jkyLV1gyD5BjV9jqKNOJiy40hSP6Be8ZIz9HUQ3haGiYmQaPtRAPbTEVaBJdm5/ZiMTXQJPqxJzY7tndyIXHvFwD+vylHUzFOjKw8Vp/CYMmo6JajqdzftYFHyuXEnte0g3U2DxI60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AC/g7Ror; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-351d309bbecso736134f8f.2
        for <linux-pci@vger.kernel.org>; Thu, 16 May 2024 00:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715844902; x=1716449702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RosNd3B/hfPPJgEd8do/IrHkaPKjQ1tjjKxBt5s2vzw=;
        b=AC/g7RorFPd04Pl/gyEXV+Rljc9/h+JehxgabfwoadJwDtDdNw6Z2Ue5GgE70HauPv
         OyineWSiFfGBtCbQDJdMRno6zfC8rg/KCzzApEm87A7N/jhAjkPLliOy2/XzFdiOU7d7
         UPsL87v2DQ75ASG1cCsELAk7kNtkez+xydX5wJqQDKsd2ZekFJ9AUO/rZo5yw/b1rRzT
         D1989pV60JQI5w4Opms5yJlwiaVuq2ricM6m003AJATOiZUz4ndsnrbbEUqE2OR3Y9KQ
         Ewvu2ke2k3+8TE8yfJgljF2Qc2EbjhfCW3F3fTyXCi3E1Ppvy9/XhsLPesOWgm8RhfpY
         Jy5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715844902; x=1716449702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RosNd3B/hfPPJgEd8do/IrHkaPKjQ1tjjKxBt5s2vzw=;
        b=F3VzkKBksB1BJoPeFPEIBBhxJ+gqRaXgQGFm2SBvLOv06mRpOrOkjyuZWHeglfLXFN
         HqQscC8pyTwj8AVKXNGUCIoWs+0svOI4ZLEgJMMZLNIRwtl/i27AKg3zBnIoWIPysxN7
         RVdSr4kFzdiJnYLjvnjcC0q3NxnP5+yn7WezOzf4XKUwlun1pZ+UZ8qQRpQnrSS2iaQE
         7s1dPsq8gPdOpW/05rJ2fLdTxwpMsTZt7ZHwjFqkX4YaTedfNx9l8d9561Qb0xES1ZKR
         UohVFY199KK4UhTxCcJV0bJhzCvvNQ2+twkBs7P83fugYx7pbZwM7NNgOlAOesRQiV/d
         aTtw==
X-Forwarded-Encrypted: i=1; AJvYcCVTWRfHFg6BUUetwauwVIGreRbYFWT+KbnHfpiLws9M7eMYZ6Xu+VZyYpw2EdiAW9otKYIME0AkvQJXQlUeyjN4g3QUCREFITLO
X-Gm-Message-State: AOJu0YwahdiTmUy8BY9zWm23iR5UcQtgvLV9OpP5c5d6YcYoX1IQDTa8
	mkC/W8f/IXqBd1PDzIj4ri6STs48yxV0l+jM9c2BB/tqWHbiCmO3DRiBoFakAf8=
X-Google-Smtp-Source: AGHT+IFyT+2cX3CUvKGm2EXv4WIaX+r6Q5SkjvFFmDYOtCk8+G42oZ2PPreRy/IsRw9tSFPb0TzkOw==
X-Received: by 2002:a05:6000:a88:b0:34c:e62a:db70 with SMTP id ffacd0b85a97d-3504aa63447mr17873757f8f.67.1715844901762;
        Thu, 16 May 2024 00:35:01 -0700 (PDT)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fe004eae9sm244071795e9.1.2024.05.16.00.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 00:35:01 -0700 (PDT)
Date: Thu, 16 May 2024 08:35:00 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Vidya Sagar <vidyas@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"liviu.dudau@arm.com" <liviu.dudau@arm.com>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>, Ketan Patil <ketanp@nvidia.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 0/3] Enable PCIe ATS for devicetree boot
Message-ID: <20240516073500.GA3563602@myrica>
References: <PH8PR12MB6674391D5067B469B0400C26B8EC2@PH8PR12MB6674.namprd12.prod.outlook.com>
 <20240515185241.GA2131384@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515185241.GA2131384@bhelgaas>

Hi,

On Wed, May 15, 2024 at 01:52:41PM -0500, Bjorn Helgaas wrote:
> On Wed, May 15, 2024 at 06:28:15PM +0000, Vidya Sagar wrote:
> > Thanks, Jean for this series.
> > May I know the current status of it?
> > Although it was actively reviewed, I see that its current status is set to 
> > 'Handled Elsewhere' in https://patchwork.kernel.org/project/linux-pci/list/?series=848836&state=*
> > What is the plan to get this series accepted?
> 
> I probably marked it "handled elsewhere" in the PCI patchwork because
> it doesn't touch PCI files (the binding has already been reviewed by
> Rob and Liviu), so I assumed the iommu folks would take the series.
> I don't know how they track patches.

Yes I think this can go through the IOMMU tree. Since patch 3 is still
missing an Ack, I'm resendng the series next cycle.

Thanks,
Jean

> 
> The merge window is open now, so likely they would wait until the next
> cycle so it would have some time in linux-next, but that's up to them.

