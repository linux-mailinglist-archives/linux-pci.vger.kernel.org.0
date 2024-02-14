Return-Path: <linux-pci+bounces-3437-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5215D854872
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 12:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1224B227B9
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 11:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF369199A2;
	Wed, 14 Feb 2024 11:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bD/BNpiy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5227D1863B
	for <linux-pci@vger.kernel.org>; Wed, 14 Feb 2024 11:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910450; cv=none; b=BmrqDEYfqltQTQpzjiS/X2MH4g/SfL4Ct/xo1pShSYf6PmbvSu1eqwBeWegSy+GmqOxYtziwTir8ZzKPua9kNQVT9OMNDlnBxsfTFw21j1oH0WGIpn/oQQbWEKi3rHB9kvR0Uu8PR9NRceDrXZAPdMG4WSTiI9GnXUwcz8/IYE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910450; c=relaxed/simple;
	bh=sJTbIVUz0Hg10hsxyj6838cKmbVkjkxwNJsJNNBj0m8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2MjNMWfcHTLBrFUeXnk9G8qfo75XuSd3qyuP72s3qh0Wy6PIcDbaZpH9Fx8EUU/+wxQRDtAzkmdvV3mh9K+uqu4pmSju2RSD3sOef0ArODDFmQBPcDcbQiFj/Fn7Px9yiZy49cnVIzrWGev4W2rXRePde2Q0Hhs1ZuDE3Jj5IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bD/BNpiy; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d70b0e521eso40669175ad.1
        for <linux-pci@vger.kernel.org>; Wed, 14 Feb 2024 03:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707910449; x=1708515249; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OCM1J87s8G9/OmkewnV82bTVzmX7HD7VMShjeCZE8Ec=;
        b=bD/BNpiy7mioZOpp/nN7Ir8qHbkIZPK4oR3AiVTf2boNOMUXjra28FQnV0sVLL9xiW
         vOt5XQxjg5Uy5GOm0PgBWfJhek3civ4GeGDuQGUzbc7XhhK7LXFFw24Feex9KMAiwNA0
         HTguOW7gQN0SpZFD+YgNapFAqBIzPB4KOgQNpOPGzEecEgXQ8L2tewLzFMD81cppYDdk
         po4ipFftTHK1gm650oDeklkjKsQjpPFHeKInq5v5DXm4sseJ7lDO+yCR0wRc1gPAD+Kf
         kj0nzvfdpqqyzyL8AQNVpWOnLe6RVw8bw4qzBeV/XH2GGgNZR65Pv0BvZnvTcAe1htQ0
         7ieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707910449; x=1708515249;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OCM1J87s8G9/OmkewnV82bTVzmX7HD7VMShjeCZE8Ec=;
        b=RnHrm1O0nkneJrCcXq5wxuf7dd9CvYGShiajc7HaIi/Cs7YcoV20WZX0Y2vZnBZYo4
         YRB6Dx7pdYqInm/CM/KPyAnjU+iE2tGt3QjfUoWpW89TadFSIvkm8oUsX7rTaR8ynoC6
         y8PmD0hq0UpjtPI894UFjF2Zkwfe0iNrTpgtNA1RfMeSygfS48NuZYSkpTDWRDf3QHAH
         fLUsHL/oqwIz9zbvNoDyg2/ORLqPPSUtwSCT0m3tqbPPdG0lOhakJXmjmdvqq7o1BQOT
         xX49RiJQREUURLTF/BYx3HNlYBBEXLHagFEmdO4Re1ffFjqs3Z7uZdKeA7VCABJTCw2t
         ZLGA==
X-Forwarded-Encrypted: i=1; AJvYcCUQKL26/I9+c4oNogEygDWpNKzTJTZsBWEU10m7ngN/QD3mdnsk1D6Ph2T4VYXEnQrghlYs2m7URij4Xo/5lbJTB06AZWParOBS
X-Gm-Message-State: AOJu0YyZieZ4aKVvidqbV/0MjAiwJNWvOu7BmxpVjFZNnOFE5XqZDEpa
	NUf5oK0ssH1/NTVukut7l9LofNb83HytuCNIQLPNCWVZRf52omsUKrnyLHGvyg==
X-Google-Smtp-Source: AGHT+IExSnqv+cwFQ2piISQpVOJgXzRn1ahWehPnGOiUscTX8nVN3iExrTYgPHldnGzf8zhL5fA9NA==
X-Received: by 2002:a17:902:ba82:b0:1d8:fb17:a1fe with SMTP id k2-20020a170902ba8200b001d8fb17a1femr2247033pls.48.1707910448685;
        Wed, 14 Feb 2024 03:34:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXbQN6Y5OTmeKcUhV2Vqie/s1dT4gMoVzhPVe7L+a52OBKlOQamjaY8zUxxcA5fcX0ghPK7z1XX7ebxxJxylpjMUZDpPUWzeOQET8UKEFh3RAo/6HGFe7LSUelUHR1rNBioPE5UiXp9tREDdtm79ZBKh1SinBMs2Qagq5Zgpe19KpowJehIbvUUXn1gB2/3R4LSnFod0w3GsEO0PdzK0R7cS2r79sZMEq+/aEoxZrJsg1bbTVkab9g+RBZr12p1GwSGUYvvp68Xyc1W1WJ4kD3Csovq2zrGa2CMsOKdxtwi5XXWq2KsYZajqnQnn4IJ5EUGkva6m1d9UU90SyW1pdTaIK7jcYaJ0ZOAmHepwpUISIGSpa56Twkvf7lfrcwMyHuD0fpn3tZT
Received: from thinkpad ([103.28.246.124])
        by smtp.gmail.com with ESMTPSA id o8-20020a170902778800b001d94a3f3987sm3506312pll.184.2024.02.14.03.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 03:34:08 -0800 (PST)
Date: Wed, 14 Feb 2024 17:04:02 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczy??ski <kw@linux.com>, Rob Herring <robh@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	quic_krichai@quicinc.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Add D3 support for PCI bridges in DT based
 platforms
Message-ID: <20240214113402.GF4618@thinkpad>
References: <20240214-pcie-qcom-bridge-v2-1-9dd6dbb1b817@linaro.org>
 <20240214102837.GA30420@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240214102837.GA30420@wunner.de>

On Wed, Feb 14, 2024 at 11:28:37AM +0100, Lukas Wunner wrote:
> On Wed, Feb 14, 2024 at 02:18:31PM +0530, Manivannan Sadhasivam wrote:
> > +/**
> > + * of_pci_bridge_d3 - Check if the bridge is supporting D3 states or not
> > + *
> > + * @node: device tree node of the bridge
> > + *
> > + * Return: True if the bridge is supporting D3 states, False otherwise.
> 
> A lot of kernel-doc uses %true and %false.
> 

Ack.

> 
> > +bool of_pci_bridge_d3(struct device_node *node)
> > +{
> > +	return of_property_read_bool(node, "supports-d3");
> > +}
> 
> What's the difference between of_property_read_bool() and
> of_property_present()?  When should one use which?
> The former has 691 occurrences in the tree, the latter 120.
> The latter would seem more "literary" / readable here,
> but maybe that's just me.
> 

of_property_present() just calls of_property_read_bool() and it is fairly new.
But yeah, the API name itself indicates that it is better suited for the
purpose. Will change it.

> 
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -1142,6 +1142,9 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
> >  	if (pci_use_mid_pm())
> >  		return false;
> >  
> > +	if (dev->dev.of_node)
> > +		return of_pci_bridge_d3(dev->dev.of_node);
> > +
> >  	return acpi_pci_bridge_d3(dev);
> >  }
> 
> This will result in an unnecessary test on non-DT platforms (e.g. ACPI)
> whether dev->dev.of_node is set.
> 
> Please use dev_of_node() instead of "dev->dev.of_node" so that the
> code added here can be optimized away by the compiler on non-DT
> platforms (due to the IS_ENABLED(CONFIG_OF)).
> 

Sounds good.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

