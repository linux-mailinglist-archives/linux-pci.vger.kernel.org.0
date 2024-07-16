Return-Path: <linux-pci+bounces-10347-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A88A9931F9A
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 06:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E5881F21EBC
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 04:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA92A1755C;
	Tue, 16 Jul 2024 04:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gBu1KjmQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A74011C92
	for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2024 04:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721103268; cv=none; b=naxHoqaacEx1NCmkwlIy7rZCpyxkUuXkrBN7PY4kMUmM/F7YmMwdW7dgoRGXOzpGvZYr0Jz8Y76rbTjgpmOHTNi9q8f+bFlXyafmzXQmPkGyFuJIy3PMkktBFILjYAcRTl/1dW56Up141T/Kcmp2qzCT3TVxGgr9qreOiMZEvKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721103268; c=relaxed/simple;
	bh=Q6fMXng06sCrDolMimf4y00YzugvjyxcoCS6h0VSxQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9c8OPbGhtuPp3RretkEI2Njlhf6kOhtV7reLu0hhr5ffy8uT+K3v2No58WZUecsVgubiHt4wMCzFuGgvSaE5tKwKCQ1HS8imuY1h4Bf+SCU4+UP4gWUu8rPG3BT0Tc2QPslfGJFU+agDpj2thvtbLPrDYvIA1R42rOvvl9HwO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gBu1KjmQ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc07295bb0so18132155ad.2
        for <linux-pci@vger.kernel.org>; Mon, 15 Jul 2024 21:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721103266; x=1721708066; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m9fUUwB+okzBEhJbtku9Zj8uDK/lXGOdA1PyDueEIS8=;
        b=gBu1KjmQuB62d9UlWS/VeokmP5+zv3GsSu/mmJQOTtI4Rz+xs9Gkq57HFbDpLGKnnh
         NknJBaHOJ2ccXDqXtfb7uzl0hhOY5etn2rdlJup/X1UQlvw0mvvR5cSnEd0tKgTn4OAy
         LmBtmtMI1vJsIiwJ7O3wqikMbsNk6wR1AlCFhatndt3VxeEhaUI4pbz1UhVZY2vT2Fd3
         Xf/Nu3bkWYkHCnodBxAz2Kb6qlxm9THVWcldfZnY3x9LfVLibXj3PHiWTJhJmnXhGrZq
         Bax7TPE8LpS0xijXvE//AAd4IVm+YvnAzJjtgxkDvWuaQiPLg+ZTr9Ud6I1MPK2pMxY6
         45Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721103266; x=1721708066;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m9fUUwB+okzBEhJbtku9Zj8uDK/lXGOdA1PyDueEIS8=;
        b=h3Jp+p6WBr/sdBVqz9XJ7WyFp3rB6f0D+h5U0d3ZMyDZwqmoMea96v+IW38BZAWdfm
         yZc/F6HBDSGnvkygzLHz/L6XeAOMBEbjsGmB6n4yQZ2vubi8PxKFDPCHVT+NtR5lfLXH
         aokE0izB1FhvKctGi95X0NNtCIxi2viNcXlyal320JHuToQEhog9iR2b+3QmRq2+dcPN
         P5IyVptP+q6qct+bdtXWgl2HxNb2hzHgdLtdADg8ixIQH1ezLGq5P8ggIgmNuPev076T
         qhwzAUAFbLdqrP+LAzEgzD6wPdGWY5WE5NKcE2DzMhYqCRB2sdRrwWv+zPFM9N1K+x47
         Yefw==
X-Forwarded-Encrypted: i=1; AJvYcCUNJOwriT3ODVgQhzcv470G6xdZS/vp8eRCaDwGFtge2qsheVSrOi3UGSZa0oeP54wzwiocNxSs8TGjdTUTAhSMv8HESAcbTIba
X-Gm-Message-State: AOJu0Yz5JCirvOEMWf8G31YMBbvlyXo+n0kQSr8hgtAPdBXVMA8gBgD2
	msrIh2bQshFZ6S/ZWVN43/Do2FIf5cV9AlryDiGdDKPq7KVCoQk+tpk9/ORrqRlG+BVWRGhp41k
	=
X-Google-Smtp-Source: AGHT+IE0ztL8RIsOftGMZThcROohqiKseTO2JDvpmlkVCP+8b8LK1YIhEgA/osbAGwBzSst2Of6iGA==
X-Received: by 2002:a17:902:e54d:b0:1fb:43b5:879c with SMTP id d9443c01a7336-1fc3d9811d8mr5861235ad.33.1721103266544;
        Mon, 15 Jul 2024 21:14:26 -0700 (PDT)
Received: from thinkpad ([220.158.156.207])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bb6fdc9sm48665165ad.52.2024.07.15.21.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 21:14:26 -0700 (PDT)
Date: Tue, 16 Jul 2024 09:44:16 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 06/14] PCI: endpoint: Assign PCI domain number for
 endpoint controllers
Message-ID: <20240716041416.GC3446@thinkpad>
References: <20240715-pci-qcom-hotplug-v1-0-5f3765cc873a@linaro.org>
 <20240715-pci-qcom-hotplug-v1-6-5f3765cc873a@linaro.org>
 <5ea6d478-f2da-4b68-8987-79cc5dfb8c86@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ea6d478-f2da-4b68-8987-79cc5dfb8c86@linaro.org>

On Mon, Jul 15, 2024 at 10:02:18PM +0200, Konrad Dybcio wrote:
> On 15.07.2024 7:33 PM, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > Right now, PCI endpoint subsystem doesn't assign PCI domain number for the
> > PCI endpoint controllers. But this domain number could be useful to the EPC
> > drivers to uniquely identify each controller based on the hardware instance
> > when there are multiple ones present in an SoC (even multiple RC/EP).
> > 
> > So let's make use of the existing pci_bus_find_domain_nr() API to allocate
> > domain numbers based on either Devicetree (linux,pci-domain) property or
> > dynamic domain number allocation scheme.
> > 
> > It should be noted that the domain number allocated by this API will be
> > based on both RC and EP controllers in a SoC. If the 'linux,pci-domain' DT
> > property is present, then the domain number represents the actual hardware
> > instance of the PCI endpoint controller. If not, then the domain number
> > will be allocated based on the PCI EP/RC controller probe order.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> 
> The PCI counterpart does some error checking and requires
> CONFIG_PCI_DOMAINS_GENERIC. Is that something that needs to be taken
> care of here as well?
> 

Good catch. I excluded the Kconfig check initially during development as it was
selected by most of the architectures. But I clearly failed to revisit it later.

And yes, we do need to use the guard. I also missed freeing the domain during
epc_destroy() which I'll fix in next revision. Thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

