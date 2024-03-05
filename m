Return-Path: <linux-pci+bounces-4529-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E032872441
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 17:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FA3D1C24BBC
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 16:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D14D127B4A;
	Tue,  5 Mar 2024 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XWfVFMT/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB841272CB
	for <linux-pci@vger.kernel.org>; Tue,  5 Mar 2024 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709655950; cv=none; b=NEeRHMqy5V0EWwsCn32C8+klbU7ZUPPZpHKOOShNMKpi3QGFCvTF+NsEeVJ36f4UA/qZ5TBiVIf17ROf10DbUl8TKDQiL5a6G/h4H0yztyBWzrL7aUT5sF9IDbTiw4XfvKESdoSTedzo7tgVSpLTZynniRbrKtL2W36E/wYaW3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709655950; c=relaxed/simple;
	bh=u/pBcGdJNPy9GTN2WKt/IQxwveir6L4doIc+92jhijQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMWvs/EOHHQ2jXYtmPVD9p/MSMevdaYBS5dvAYhagLzEv+ulWv/2nZl0XX1elXrkE3AsZuRYEs7RhSkPk3Cxa1nd39lCLzFfSBEHUJ6qqGslcOR3sn49B29/d4HTzSY2iBdUESKpIbEnfacpJxvArb0kd+4tYfbaUTHTbcHZcjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XWfVFMT/; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42e63a658e1so19685081cf.3
        for <linux-pci@vger.kernel.org>; Tue, 05 Mar 2024 08:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709655947; x=1710260747; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9UPKxf02rz4hGt6Oub9gI1fBspCgrGZYi6mUwmt5XWE=;
        b=XWfVFMT/bLClvIGVF8TcPQ36nwDojEbWkpRHDvxTTncPszNOydWuO9Z1J6gwsP0QkT
         botUtG+ulNAQFMpo3KS394Ynha0GrZUS77PeWh3R7ypUNJe3HRCegW1DziMXPIX4rHYy
         muMJ8kYuKMDsDDc1IGzgRMLna9pO1nITnbTa6cRzghrg84HfALaWAwzPb92kN3vwFBvd
         eUzJcG+40GUkPzAw6tmKS2CHswIrMbs3zV5edebSJElAip9LnLxhOY5DFQx3v2Jj3qr7
         B2EuAJF6wYCAzbcI5Z+mGcwieXXgJwNOyZIZUFoIevDFZVUTBz0dZmwuZOkyfVc8RiYB
         rtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709655947; x=1710260747;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9UPKxf02rz4hGt6Oub9gI1fBspCgrGZYi6mUwmt5XWE=;
        b=PCqfstvRXiYV+gKm4JdxYC5LSAOTDESUVIq0mYpoMC20QsrlMdZSs8khJfG+mDrL5b
         /+L3d8f4HdXqUS7yudL/NHmGBIkzMIZV4BL6rHdSPxLzRE6odgbUseMQ/WIPtJWRl8x3
         AWsJ7vzpnd98THlGLsJxopjfYQ6GW+o851oBpLuxnSY1fi4VjveYB84NBCc1bhFGYaMD
         //voz+TdsfT84FlpxguWZJIwgsqgTwlj6OJxUOM8HE6L+wbDeY8JYU1TSGGyl4srBoCt
         +Izhc00wweFtW2s7qQ7KUPwkTTf9oaImu04VMO1yzVNctvfT1XIq5Om6nwxWJ91Zn8jw
         KTLA==
X-Forwarded-Encrypted: i=1; AJvYcCVjZ7HmQrdizwnBmQ9nFi4imSwJepBGQ//+1VvTpuaUwW/UKzdkFQOgoBLG/gZiMuYt9yR6epxGpbpGdq38lScSXXfwKh8f2u29
X-Gm-Message-State: AOJu0YzpTYwFFz6Nh9EN9oLS24ZzDzTukKHQNcqRmBjbHcz9iyW+p8jY
	6IJ+MKMz8aAya5IxSbQtGixOK8/i2VPOHTiM8369DGG4wKoIhcAkBlRc5XfN4A==
X-Google-Smtp-Source: AGHT+IHUYx1wCgqyKCP1MFEvMpjb+x+twuiJx66r+tbjofs7IvOG/bbiO0L5lne/nsuIbGNV0YUYrA==
X-Received: by 2002:ac8:5c12:0:b0:42e:f031:f2a0 with SMTP id i18-20020ac85c12000000b0042ef031f2a0mr2846401qti.14.1709655947432;
        Tue, 05 Mar 2024 08:25:47 -0800 (PST)
Received: from thinkpad ([117.248.1.99])
        by smtp.gmail.com with ESMTPSA id dq10-20020a05622a520a00b0042e703a8d74sm864252qtb.56.2024.03.05.08.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 08:25:46 -0800 (PST)
Date: Tue, 5 Mar 2024 21:55:37 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczy??ski <kw@linux.com>, Rob Herring <robh@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	quic_krichai@quicinc.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3] PCI: Add D3 support for PCI bridges in DT based
 platforms
Message-ID: <20240305162537.GA8339@thinkpad>
References: <20240221051958.GA11693@thinkpad>
 <20240221182000.GA1533634@bhelgaas>
 <20240222094052.GA25101@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240222094052.GA25101@wunner.de>

On Thu, Feb 22, 2024 at 10:40:52AM +0100, Lukas Wunner wrote:
> On Wed, Feb 21, 2024 at 12:20:00PM -0600, Bjorn Helgaas wrote:
> >   1) D3hot doesn't work per spec.  This sounds like a hardware
> >      defect in the device that should be a quirk based on
> >      Vendor/Device ID, not something in DT.  I don't actually know if
> >      this is common, although there are several existing quirks that
> >      mention issues with D3.
> 
> My recollection is that putting Root Ports into D3hot on older x86
> systems would raise MCEs, which is why pci_bridge_d3_possible() only
> allows D3hot in cases which are known to work (e.g. Thunderbolt
> controllers, machines with a recent BIOS).  It was a conservative
> policy chosen to avoid regressions.
> 

So pci_bridge_d3_possible() is only checking for D3hot capability? If so, I'd
rename it to pci_bridge_d3hot_possible() and also 'bridge_d3' to 'bridge_d3hot'
to make it explicit.

Since the default value of 'd3cold_allowed' is true, I believe the code expects
all devices to support D0 and D3cold. Please correct me if I'm wrong.

- Mani

> I don't know if similar issues exist on non-ACPI systems.  If they
> don't exist, platform_pci_bridge_d3() could just return true for
> all devicetree-based systems.  Might be worth testing if any systems
> can be found which exhibit issues with such a policy.  That would
> obviate the need to specify "supports-d3" in the devicetree.
> Quite the opposite, ports which are known not to work could be
> blacklisted.  Of course if it turns out that's the majority then
> whitelisting via "supports-d3" is a better option.
> 
> 
> >   2) The platform doesn't support putting the bridge in D3cold and
> >      back to D0.  I don't understand this either because I assumed DT
> >      would describe *hardware*, and "supports-d3" might imply the
> >      presence of hardware power control, but doesn't tell us how to
> >      operate it, and it must be up to a native driver to know how to
> >      do it.
> 
> I think we're putting devices into D3hot first before cutting power
> (i.e. putting them into D3cold), so knowing that D3hot is safe is
> basically a prerequisite for D3cold.
> 
> Thanks,
> 
> Lukas

-- 
மணிவண்ணன் சதாசிவம்

