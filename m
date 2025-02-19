Return-Path: <linux-pci+bounces-21793-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D72BA3B2CC
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 08:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DA883ABA70
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 07:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CF21C461F;
	Wed, 19 Feb 2025 07:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GXsCk5vt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB8A1BD9CD
	for <linux-pci@vger.kernel.org>; Wed, 19 Feb 2025 07:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739951362; cv=none; b=I5GjQWG6oNfb99ySzMYIO/ijsVd2e5jrrG7Hpv7hFkHBofsWHNZsEhMiE8ol4+2HE3N3H0skmYCdDYNr2RHakG5zicpUWFDvKm/ueJrok+R9mwJWyM92rW/IwriOuTXGxw8X+Y3UsLeJk58WJpgiGScBz16lG8mdJBsLwBSBJQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739951362; c=relaxed/simple;
	bh=9W51922lZcRv+WfFDa8r/ahBXeZgRii7HNNotr9H40A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AoZc86LntMyaQyhOfJ6Rd7owmkFjRi9TsWlRU65HhBPtizTRIfMj4xnwM5RpM0d2KkTD+jpiatrB10jA6kjT5Ere61Ge1RpB3f31ybB9YH/sNz0zDvtB7V6nQLmtX287qGUmysKqTYX5Sw6EMFozXaJ0PJLI7frykeb2aU/xtqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GXsCk5vt; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2210d92292eso102555025ad.1
        for <linux-pci@vger.kernel.org>; Tue, 18 Feb 2025 23:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739951360; x=1740556160; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9sOSWz9/b/A8wxbS7QG6N98UoPE8+0el0tVSZ986HeU=;
        b=GXsCk5vtZXWbfyUxd6XjAq2xuH65zsHjsXCvFr1C5CT3/RIJqmJKYJCWm+/bS1s1Pq
         ZV0uEGGiXETFK06QHk1SNbOPVZbmUTeG9Vt5VD9biKBZUtCPcx/E9p/w1ADwtUFHUFOv
         mDOmmc1V0hGySc9PydoflYRDMr5GydahqeXgECmJwSLRR1+A0J5T23y19mWC2GMjc1XD
         9PhTzb0hTz9fd52R54WraenDme75YJQcICBWAlr7l1GhqeGXqwkIbfp+0NzrrvBTQX1B
         wL3jo/e+1fCpGBf6/ecccVke7EHG1VSVL4eT5afGbwB8RV/m559dMDTqWXU6uQrL826B
         JScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739951360; x=1740556160;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9sOSWz9/b/A8wxbS7QG6N98UoPE8+0el0tVSZ986HeU=;
        b=BozvirQay3VRPM6jCrQvewwjD0zLtGcNoamqIATF0buwhokfHCS7k2ZUzT4uFlx+6I
         95f74Y7om5WY6EBPGSmfJanHdL25AFsjlr+22l8wyLkyUFwWz9nZFOEjNoht32cFDII+
         geTFoBudmtx7vhRclG9xpwRlUYPsePkQBHdpMI7B2t7vCmmSErWl/ozd3vJQpXe6meRX
         eWFOCexeZ9uK8Fs6MIhpcy2qEhtTM+jL+SBBu+vy7916QNNQF4iL8d9dbYnpgUBGYznu
         qfoWtgK7/hokU1iNOrSVvjUiUCqhkqNYuyXDT5sLfSmlD/YjpYKd8zE9FQQQdgErMs8x
         Y2Sg==
X-Forwarded-Encrypted: i=1; AJvYcCXMRi7vdBlqR/1GUK51B+4LLdkLh75whx/4u7g8IflNt0+9ZRqVIuI4wIhXFZ0UJpMFm0ENyZg+nBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbkPaJRoSczhtfkqBKguZbqB9in3jcYFGD5gjSAMMRkK4SKInZ
	aMqmlr7D0StkkFfdgxbZAd+l6REJf4gRRv5/OfQdLtg/u3JH0dbNtqG2VMzcg6nAPaZkVijKP0o
	=
X-Gm-Gg: ASbGncujHIdu/qxn8RcF6s41JXXrjKDPAI8TS/OMZ2lT84nU9quupCiVVUUkauyOP3U
	WRPGKIiBlrAVSHCpi/10vckc03mn+MhPr7+I3P34R/3XWWyAWqYDCIi19n3nPVkbxtFk8Xyjf/3
	0+uZkJtNkM1T1Ynh5vmwipquhrNAoyYqVWS3IFQPhg7Eddtft0gXVkx+wncO6pmczRkCekKsbeV
	47BN2t6dqR/nMq3H4QlS3rTxJf6Npjq4qAZaPxqHqKLv2RQrWwInyLkElrFIbGplyshMUkSw2JO
	zGI8c/k1ZaPxO3b3CZb/E3gumjw=
X-Google-Smtp-Source: AGHT+IFoGyzNx30oj5QPZ8kXyITKzcMTpTQ6sfoOeGpNaqW8WOSxc+hSdJl3P3R9gIDdbaeQkXzR7w==
X-Received: by 2002:a05:6a21:103:b0:1ee:c7c8:c9e with SMTP id adf61e73a8af0-1eed4e5240fmr4788072637.2.1739951360379;
        Tue, 18 Feb 2025 23:49:20 -0800 (PST)
Received: from thinkpad ([120.56.197.245])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732425467d1sm11672713b3a.12.2025.02.18.23.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 23:49:20 -0800 (PST)
Date: Wed, 19 Feb 2025 13:19:13 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Shradha Todi <shradha.t@samsung.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/4] PCI: dwc: Add PTM sysfs support
Message-ID: <20250219074913.e4rtyup3m3yv66po@thinkpad>
References: <20250218-pcie-qcom-ptm-v1-0-16d7e480d73e@linaro.org>
 <Z7Syf2LXEuKFToV4@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7Syf2LXEuKFToV4@lizhi-Precision-Tower-5810>

On Tue, Feb 18, 2025 at 11:17:03AM -0500, Frank Li wrote:
> On Tue, Feb 18, 2025 at 08:06:39PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > Hi,
> >
> > This series adds sysfs support for PCIe PTM in Synopsys Designware IPs.
> >
> > First patch moves the common DWC struct definitions (dwc_pcie_vsec_id) to
> > include/pci/pcie-dwc.h from dwc-pcie-pmu driver. This allows reusing the same
> > definitions in pcie-designware-sysfs driver introduced in this series and also
> > in the debugfs series by Shradha [1].
> >
> > Second patch adds support for searching the Vendor Specific Extended Capability
> > (VSEC) in the pcie-designware driver. This patch was originally based on
> > Shradha's patch [2], but modified to accept 'struct dwc_pcie_vsec_id' to avoid
> > iterating through the vsec_ids in the driver.
> >
> > Third patch adds the actual sysfs support for PTM in a new file
> > pcie-designware-sysfs.c built along with pcie-designware.c.
> >
> > Finally, fourth patch masks the PTM_UPDATING interrupt in the pcie-qcom-ep
> > driver to avoid processing the interrupt for each PTM context update.
> >
> > Testing
> > =======
> >
> > This series is tested on Qcom SA8775p Ride Mx platform where one SA8775p acts as
> > RC and another as EP with following instructions:
> >
> > RC
> > --
> >
> > $ echo 1 > /sys/devices/platform/1c10000.pcie/dwc/ptm/ptm_context_valid
> >
> > EP
> > --
> >
> > $ echo auto > /sys/devices/platform/1c10000.pcie-ep/dwc/ptm/ptm_context_update
> >
> > $ cat /sys/devices/platform/1c10000.pcie-ep/dwc/ptm/ptm_local_clock
> > 159612570424
> >
> > $ cat /sys/devices/platform/1c10000.pcie-ep/dwc/ptm/ptm_master_clock
> > 159609466232
> >
> > $ cat /sys/devices/platform/1c10000.pcie-ep/dwc/ptm/ptm_t1
> > 159609466112
> >
> > $ cat /sys/devices/platform/1c10000.pcie-ep/dwc/ptm/ptm_t4
> > 159609466518
> 
> 
> I am not sure what real means by only show these number.

These values are supposed to be consumed by the userspace applications to make
sure that whether the PTM feature is working as expected or not. For instance,
once the PTM dialog is established with PTM root, PTM requester's local clock
should be synchronized with PTM master clock. And these can be verified using
these sysfs attributes.

> It is quite
> similar to network 1588, ptp. There were already linux-ptp
> https://www.kernel.org/doc/html/v5.5/driver-api/ptp.html
> 

PTP and PTM are different even though both are meant to synchronize times across
devices. PTM is limited to PCIe hierarchy and the actual synchronization is
performed at the hw level, limited to PCIe clock source (core_clk in DWC terms).

> Can we use similar method to sync local timer to master? I think it is real
> purpuse of PTM.
> 

Actual synchronization happens in the hardware itself as I explained above.
Software is not intended to do anything (if not using any external master clock
source) to synchronize the clocks.

I think you are referring to synchronizing the global clock source (the one used
by the kernel) of the endpoint based on PTM. But I don't think that is what
intended by this feature.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

