Return-Path: <linux-pci+bounces-4199-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3641986B77D
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 19:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8E01287F2E
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 18:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8110571ED0;
	Wed, 28 Feb 2024 18:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lYFf6KHl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E0371ECE
	for <linux-pci@vger.kernel.org>; Wed, 28 Feb 2024 18:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709145914; cv=none; b=LIPTErqG5Oglw8ZlvQVmH6Gqtbin9H5TS0GQpQQDVWYx1D2bIOG9GlgFIkiN1E4c2HP07/+eNwxxC0VBBGfjTfPc4+Bn/ovJhRsJXpTMHx7PZNfZx51QuPGAueLc7XmNNeYcSJbZJbJm8h7AlLTRLkdM0H65sIqA+ZAC/6BL5og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709145914; c=relaxed/simple;
	bh=tfeJbESdHwCRiJmb+nGrhsGDmZP4I3V1Y9CR+GdIuGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eaz0uAUURYt6+Mi+hAbEHyyQtsLsZSw8bRyQh/MVcI9PCuKKAN9/0SqWTdZ96ofRbdH9WVkchVYuvJ1RGcVge8yLvl4XAiuFsBS+bOmCsvlBFSlWgQ1DYzfnXAak0xjFVfanfzBx68aXn96FVhQtgDaSqK/Kmf+RtUzEqbso+oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lYFf6KHl; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bbbc6bcc78so5146b6e.1
        for <linux-pci@vger.kernel.org>; Wed, 28 Feb 2024 10:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709145911; x=1709750711; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RzQmdvXzv3fqOwj7M3m9jyec11aZq1OJPIRSOPiWyS0=;
        b=lYFf6KHlAB9AmxZN1zEssculH71yKd7PVnIdxqBojnoOvqAGuNDTJIgyJrOC7SgCpG
         vCR32SNYiKAEATD2EssfimvQxR7jpVRVsfknfFCRWSnFRKj+oA/RhO0gL+Ay+k1kxPQl
         +vOod8BZ/7RtZ0cDp2kBSUhZEpUsQOBlHWbar5oZtI0HrglV3A9wHzIK4O1A2qEc+70I
         L6pevnU7CdT48IQroezGxskrcdN8FwNA/4l36L6iMJFNr3LY8VQEs1uv6lQAwThl3GXQ
         EZ2iLrs9sjObLN0WF5ZZcv8N3NRrcAhNRLInLD7bH9Z42/EVoxPkQBXxu+Y0+cmi+jdN
         Q4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709145911; x=1709750711;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RzQmdvXzv3fqOwj7M3m9jyec11aZq1OJPIRSOPiWyS0=;
        b=qQbdF8kDvnTu45qBNKaAElvCTKfqyM4/OizNsroApJ7tPYDGFR7Z9ODC0f7LYHCI31
         zLNRloDR42uCUn1gTKPl38Dr8KAwQpHz4P9AqlDct8+1VN8k1cv9mZe1zxa8wwk1vSKY
         iA65cDvJBj8a1IEl/JgZAvTDh+CttJrphSWu5HasRe2aAj6Fk6bAthlbQLj7nkkYyMOp
         XO/R/rir6VKsE5mFUutzyeBbzL15loQMiYLRCqYHwYXty63h/JsBpjv1hvDTgYkCt8nB
         47G4N+Q9dBL8SVfohA6XGegELr/4F8I3y/J0iGZNLq50XnAuOSSUcYtzgWD4b8rw93XX
         vfLA==
X-Forwarded-Encrypted: i=1; AJvYcCX5O9fz9upoHuLCvPWWJ7JWXegqcQZYDi0rceHcYMEgrSGYQWR+sib6fEesv+f3c+KN0DHMpOgrRd4VdQBZ1BmKuw/TF8xTROl6
X-Gm-Message-State: AOJu0Yx8hjp6F1ZZkGm+6ybmlZQSmoldIRCrpf4wgPyQRcDfuiO8pJL0
	GYp5QtDz81rZRraHsE3TGRJSnnyU8xLVpg8+2NuWFxmOoUrZb7HwKwXqBW04vg==
X-Google-Smtp-Source: AGHT+IHMwRLa0xap97N0tSChSXaeXcab7vfUOIxDTsnB4jz8A4Vrsl3DTWV7JbzlXmnu1yjprFO0Kw==
X-Received: by 2002:a05:6808:157:b0:3c1:559b:4290 with SMTP id h23-20020a056808015700b003c1559b4290mr5294337oie.42.1709145911563;
        Wed, 28 Feb 2024 10:45:11 -0800 (PST)
Received: from thinkpad ([117.217.185.109])
        by smtp.gmail.com with ESMTPSA id x12-20020aa784cc000000b006e50e79f155sm22120pfn.60.2024.02.28.10.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 10:45:11 -0800 (PST)
Date: Thu, 29 Feb 2024 00:15:02 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mrinmay Sarkar <quic_msarkar@quicinc.com>, andersson@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	konrad.dybcio@linaro.org, robh@kernel.org,
	quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
	quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
	dmitry.baryshkov@linaro.org, quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com, quic_schintav@quicinc.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 1/3] PCI: qcom: Enable cache coherency for SA8775P RC
Message-ID: <20240228184502.GC21858@thinkpad>
References: <20240228171412.GA21858@thinkpad>
 <20240228173907.GA278736@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240228173907.GA278736@bhelgaas>

On Wed, Feb 28, 2024 at 11:39:07AM -0600, Bjorn Helgaas wrote:
> On Wed, Feb 28, 2024 at 10:44:12PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Feb 28, 2024 at 09:02:11AM -0600, Bjorn Helgaas wrote:
> > > On Wed, Feb 28, 2024 at 06:34:11PM +0530, Mrinmay Sarkar wrote:
> > > > On 2/24/2024 4:24 AM, Bjorn Helgaas wrote:
> > > > > On Fri, Feb 23, 2024 at 07:33:38PM +0530, Mrinmay Sarkar wrote:
> > > > > > Due to some hardware changes, SA8775P has set the NO_SNOOP attribute
> > > > > > in its TLP for all the PCIe controllers. NO_SNOOP attribute when set,
> > > > > > the requester is indicating that there no cache coherency issues exit
> > > > > > for the addressed memory on the host i.e., memory is not cached. But
> > > > > > in reality, requester cannot assume this unless there is a complete
> > > > > > control/visibility over the addressed memory on the host.
> > > > > 
> > > > > Forgive my ignorance here.  It sounds like the cache coherency issue
> > > > > would refer to system memory, so the relevant No Snoop attribute would
> > > > > be in DMA transactions, i.e., Memory Reads or Writes initiated by PCIe
> > > > > Endpoints.  But it looks like this patch would affect TLPs initiated
> > > > > by the Root Complex, not those from Endpoints, so I'm confused about
> > > > > how this works.
> > > > > 
> > > > > If this were in the qcom-ep driver, it would make sense that setting
> > > > > No Snoop in the TLPs initiated by the Endpoint could be a problem, but
> > > > > that doesn't seem to be what this patch is concerned with.
> > > >
> > > > I think in multiprocessor system cache coherency issue might occur.
> > > > and RC as well needs to snoop cache to avoid coherency as it is not
> > > > enable by default.
> > > 
> > > My mental picture isn't detailed enough, so I'm still confused.  We're
> > > talking about TLPs initiated by the RC.  Normally these would be
> > > because a driver did a CPU load or store to a PCIe device MMIO space,
> > > not to system memory.
> > 
> > Endpoint can expose its system memory as a BAR to the host. In that case, the
> > cache coherency issue would apply for TLPs originating from RC as well.
> 
> What PCIe transactions are involved here?  So far I know about:
> 
>   RC initiates Memory Read Request (or Write) with NO_SNOOP==0
>   ...
>   EP responds with Completion with Data (for Read) 
> 

The memory on the endpoint may be cached (due to linear map and such). So if the
RC is initiating the MWd TLP with NO_SNOOP=1, then there would be coherency
issues because there is no guarantee that the memory is not cached on the
endpoint. So, not snooping the caches and directly writing to the DDR would
cause coherency issues on the endpoint as well.

- Mani

> But I guess you're saying the EP would initiate other transactions in
> the middle related to snooping?  I don't know what those are.
> 
> > > But I guess you're suggesting the RC can initiate a TLP with a system
> > > memory address?  And this TLP would be routed not to a Root Port or to
> > > downstream devices, but it would instead be kind of a loopback and be
> > > routed back up through the RC and maybe IOMMU, to system memory?
> > > 
> > > I would have expected accesses like this to be routed directly to
> > > system memory without ever reaching the PCIe RC.
> > > 
> > > > and we are enabling this feature for qcom-ep driver as well.
> > > > it is in patch2.
> > > > 
> > > > Thanks
> > > > Mrinmay
> > > > 
> > > > > > And worst case, if the memory is cached on the host, it may lead to
> > > > > > memory corruption issues. It should be noted that the caching of memory
> > > > > > on the host is not solely dependent on the NO_SNOOP attribute in TLP.
> > > > > > 
> > > > > > So to avoid the corruption, this patch overrides the NO_SNOOP attribute
> > > > > > by setting the PCIE_PARF_NO_SNOOP_OVERIDE register. This patch is not
> > > > > > needed for other upstream supported platforms since they do not set
> > > > > > NO_SNOOP attribute by default.
> > > > > > 
> > > > > > 8775 has IP version 1.34.0 so intruduce a new cfg(cfg_1_34_0) for this
> > > > > > platform. Assign enable_cache_snoop flag into struct qcom_pcie_cfg and
> > > > > > set it true in cfg_1_34_0 and enable cache snooping if this particular
> > > > > > flag is true.
> > > > > s/intruduce/introduce/
> > > > > 
> > > > > Bjorn
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

