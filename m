Return-Path: <linux-pci+bounces-33144-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E38AFB155E6
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 01:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14BA04E8270
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 23:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0CA28541C;
	Tue, 29 Jul 2025 23:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="coHoJOXW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF4C28469A
	for <linux-pci@vger.kernel.org>; Tue, 29 Jul 2025 23:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753831366; cv=none; b=FtPZ3azT+yNAPk+JrV8WyfhxVLDllw0JeP0gCIlAxSXbCO0sIhBUkD5GmFEVaoI8AVD4WbaregqZ8xPyCxEJZKcgmj28cr0CsJQS9zKwYbv+kB88MUeIS0rqaXCwf0uN3Pj+yUwhGhGwKp/nxHGFH68VvtUVWBKmA17wlk3L2PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753831366; c=relaxed/simple;
	bh=5+SxyYSHlUovT7nMO8KUUry70XX33hvq1YMeYnlBo24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBS/GNjaJVY/G7ZqBUlx+UYZNgKqdf5VTi6vQfGViAws9nUvfqnU5IIJTeYtTXOSXbsaYDsPK0G25oqNyK9x7YczxEIpUcrMxIebJ0G9WkTWNz6LC/0tq9nsjUiruYT63hKcs0PolhcARXWy4wgpIo23AzQEECfc3O2SBOz//LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=coHoJOXW; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4aeb2e06b82so17517081cf.2
        for <linux-pci@vger.kernel.org>; Tue, 29 Jul 2025 16:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753831364; x=1754436164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=evOEy7fuRGdGypQDmd9QZXrLo8EABIsGfXRQCCvlWq8=;
        b=coHoJOXWAP9YmFUnuG+hSl/2tzfR1NsSPLc6VTr6Hel3vE896TjetO0zgl4vKS9pCI
         srDt5dotyXfW/EFBmiN7hLMOCZUBKxiUXcnulS/fHP+rPQt383WtK+oi1RO8W6fCDD5W
         7DXCRRpM/7ywfGIrGiTGZ615Ztle3BT901Donf57f3h2SsJ/KlzqsyNAalm+KwDbcDP/
         OWsFbCgqTZaFofNMX6yMuLcpnzV497HOHt0EvOP7xoA4tFpdxV30NDMdvJ59eSVtEgh4
         cpolx7hZWY9JJilDc3/5JnaKEwHkoGzdmCLVpJInpZLOZROpGbQ+gFK7i+HNyC6g0/mn
         rYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753831364; x=1754436164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evOEy7fuRGdGypQDmd9QZXrLo8EABIsGfXRQCCvlWq8=;
        b=MlOxn2fnsx/gtzdOYrygFTT6/XBNKweEmVxz72EVmUOf8Yb834SzGDgDgoqT5IC7ud
         OjJ2WpDBiLv52Y9ruYkZ9bShZuyRwOYehRvgbduX4tJ88eI/AnsT/K+mBIUFMl04Vty0
         Xj6pwYjmW+SxNHGrhjNF23obAgO53luc70QB3sOs5Qhr0KfYlzPKXMsxkuUvPmGaZIAr
         XAnG6WVIVwbkpwPV0XUzX/JSIvp5W2pIZ75JnyPPqKl/bMVW8kD1CaD9aepUDeoxlfGb
         t1OsYbNS5Y9A8Szdw9Whm2C08YPClwB2ohIl+W5GWCBnqGGTAe/Kx7ZTHrGcwPRUrOCM
         AnoA==
X-Forwarded-Encrypted: i=1; AJvYcCVRh40EXFoIgLIJQVldgNhTGBrOlIe/ipLZtDOHKIDXZp4iaavZV6dPR2KzWtfbfOMRdiTYAk04xS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhj+8xoZpNpYIJ5XpSspTJyCM1dbQAgJXptZtIW3DpOe7LjZCq
	1DGze/ARPjeyep4eUDmYnJWyLDoTf+zSACQnUt7aBcbf+EXjkzkn6FQtLBiHYBMViMs=
X-Gm-Gg: ASbGncsKBcOa7ODzJZduy+gkVNgJadc3AEEBKmIR9Ay2Zkb47Yg+iKkIRzKBPr3pgKD
	KgRYMeK+m1SfEdtXAbKjBTwfo5lOqRDcU5BZfZAPYkBfbFYsbwRMEdMFScD+1qmStCAtNoCZDrZ
	vYKPD3vvfe7MPDI7aWW6glhBz2MOC2d8yxsmECK6yI23XvGnLKdgyB1H/AKdpohWPv8EiDuvXw2
	g4gw8ZgGXv4niXI3/cJw6bd+gt3cE9CX523KCmVlEnF1YuLyyrcxY18hEiA4/I1susQ4DE4esqB
	Tne76LaXhY7WWPFcwZHWoIvyAX12h8X2ZKUHwnV/WqjcpCCjI2uO8HTENm9KZbgPamgrwfLI0/J
	Cz2wHUyc/Ytl8mBVoMv4ttfdx02qebicny4Krwf8OGsBGWevrLjgxixrxMm9bS2nKX75yxZr151
	MI+Kk=
X-Google-Smtp-Source: AGHT+IEp29JmYKPTEUTfX9T0WcQPt09uHVFFYXFI1jbMPkfOwjEBLhDqzXpFec1njO1HN+oSVaPRoQ==
X-Received: by 2002:a05:622a:8f:b0:4ab:95a7:71d7 with SMTP id d75a77b69052e-4aedbc7919dmr24915231cf.53.1753831364093;
        Tue, 29 Jul 2025 16:22:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ae9951a6casm56688261cf.13.2025.07.29.16.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 16:22:43 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ugted-00000000MjD-0XUr;
	Tue, 29 Jul 2025 20:22:43 -0300
Date: Tue, 29 Jul 2025 20:22:43 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 12/38] coco: host: arm64: CCA host platform device
 driver
Message-ID: <20250729232243.GK26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-13-aneesh.kumar@kernel.org>
 <20250729182244.00002f4f@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729182244.00002f4f@huawei.com>

On Tue, Jul 29, 2025 at 06:22:44PM +0100, Jonathan Cameron wrote:
> > +}
> 
> > +static void cca_tsm_remove(void *tsm_core)
> > +{
> > +	tsm_unregister(tsm_core);
> > +}
> > +
> > +static int cca_tsm_probe(struct platform_device *pdev)
> > +{
> > +	struct tsm_core_dev *tsm_core;
> > +
> > +	tsm_core = tsm_register(&pdev->dev, NULL, &cca_pci_ops);
> > +	if (IS_ERR(tsm_core))
> > +		return PTR_ERR(tsm_core);
> > +
> > +	return devm_add_action_or_reset(&pdev->dev, cca_tsm_remove, tsm_core);
> 
> So this makes two with the one in Dan's test code. 
> devm_tsm_register() seems to be a useful generic thing to add (implementation
> being exactly what you have here.

Pelase no, this is insane, you have a probed driver with a
probe/remove function pairing already. Why on earth would you use devm
just to call a remove function :(

Just put tsm_unregister() in the normal driver remove like it is
supposed to be done and use the drvdata to pass the tsm_core_dev
pointer. It is easy and normal, look at fwctl for a very simple
example.

devm is useful to solve complex things, these trivial things should be
done normally..

Jason

