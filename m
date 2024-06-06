Return-Path: <linux-pci+bounces-8377-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5257B8FDCE2
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 04:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04041284626
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 02:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1501B964;
	Thu,  6 Jun 2024 02:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rrWvsm9e"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F15618C38
	for <linux-pci@vger.kernel.org>; Thu,  6 Jun 2024 02:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717641608; cv=none; b=Va/rCYpSV00eLUMKKKpnAjoTwHrEdvMAJ1FjdPmf5JVfqlc4SNIyBk67xr6rKy0EK+kUJQnv/MlUt4lG2asiKZRNwztZ5k98q9kfpQojb9SKtxyVpCpqjcdqW6HSLQ/etjSiR6lsdrr1OY1sYWeIxigcxBnZ5sVLL9Q0//EqkIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717641608; c=relaxed/simple;
	bh=+HVwrDUz1uIzC6eAqeuTCk2d0+1EGuGOkn8/Ej3k6j0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jy5N/LLILnVgAJOLmfG8VsRLyhg7ibK10TirHfs3iwU96YmDi1qnRA93nT5S+PKUgxkhO+MUPdecpcwOrlrxPLaI8/3Tq1sru0N7y93tP9Y2VYadE/yMa6wQrJKAz9Jrp9JH74w2eTv29UA5OghOWA6pFmPuU+Xsdk5//i+/S+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rrWvsm9e; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7025b84c0daso379547b3a.2
        for <linux-pci@vger.kernel.org>; Wed, 05 Jun 2024 19:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717641606; x=1718246406; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E7RsRy0RZ6BPhd0zOzb8Dzo505oEPiS2g4HyLE25t+8=;
        b=rrWvsm9esRY2JpCe2zBKQj/kFwVbN3hhCP4f0559wA48nA4TjPWb10ma9AoRzgvdpt
         66ayRrE7+EpIZcJ1e5OB/8P+4sHRob+QTZFflSWVG7ja3NoeWPr0HKiTmbNF7mjevVjW
         YZk8AScKO1Q0S4l09sIhHRhfKgqv7+0nh7PxoL2l/Thbi3b2R2oi4l0yL9R1jCf1KZeS
         t5k/F+YN8YW2MMhNaw+9JEaD5HkWLV3CcbSzXO5IPNqmS3jhDsLONdhc2Eh/V6MiF50F
         rW20/NVItBS758H1AZq2j1wT7QC5eHKCNaR7fNa7ct8N5GqcVTMflBmAZT1/kwsjluXN
         dP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717641606; x=1718246406;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E7RsRy0RZ6BPhd0zOzb8Dzo505oEPiS2g4HyLE25t+8=;
        b=Kh1s9WZlSIj7l8LNAdc++srvGSRVexiuRba/V12e1P3cHfWuFbyDayuEaE4doV1HTl
         LKFLrQH52IMYGudH1aIWzbRZlLOWkzro9+FovGHyP1tcNTt/T9XqhZ69fEPPMU+o1hP6
         8s8rnn0ovPgRvSWS5bogSaTxjCp3tpL6luMOraBz8sMx6fEHCIxnr0r1i8xJ+bs41e0r
         bb7Docvj1OGTS46eCMPz65XeSGuzVpB48/YvCvBtCl1Axc7Fp9PzG+GzIWWXtEIa2RZ5
         F6CkbrDDnGlNag02fPYK3mjPB7Y5amw3ODdr+GKb1JzFsp6swRcldG5s5g2Lz+XSSTQv
         BFAg==
X-Forwarded-Encrypted: i=1; AJvYcCWQ0oSKpAeHzom46Gxb+4tbJ0x7iY8buDEnvT/DEfq99pF1kpmcNq5P9sqxOsOfFr75heMjqIiTgvn4ApmGfly11OJJf/A5NDBf
X-Gm-Message-State: AOJu0YzHZbRMgdzZwpMlneh9KdQGFXVhWUj4Ft9CHewFoCxmRjgW2my6
	vQOL9GWCvlzuIU6JabkFrBwXDj83dlj77nJggzhDg2suuOgWmkLbgbFE60r76g==
X-Google-Smtp-Source: AGHT+IGpA/kk+BeFkPHH5bGzof1Qpi5uD41m75ShLL7asfGu6mBRHGaA8afzEPWZEG/p1xL2UzRqYg==
X-Received: by 2002:a05:6a20:3d87:b0:1af:e624:b9b2 with SMTP id adf61e73a8af0-1b2b6f3d0e9mr5552460637.19.1717641606234;
        Wed, 05 Jun 2024 19:40:06 -0700 (PDT)
Received: from thinkpad ([120.60.142.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd770c4bsm2518535ad.88.2024.06.05.19.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 19:40:05 -0700 (PDT)
Date: Thu, 6 Jun 2024 08:09:52 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Mayank Rana <quic_mrana@quicinc.com>
Cc: Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
	andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, quic_ramkri@quicinc.com,
	quic_nkela@quicinc.com, quic_shazhuss@quicinc.com,
	quic_msarkar@quicinc.com, quic_nitegupt@quicinc.com
Subject: Re: [RFC PATCH 2/2] PCI: Add Qualcomm PCIe ECAM root complex driver
Message-ID: <20240606023952.GA3481@thinkpad>
References: <1712257884-23841-1-git-send-email-quic_mrana@quicinc.com>
 <1712257884-23841-3-git-send-email-quic_mrana@quicinc.com>
 <20240405052918.GA2953@thinkpad>
 <e2ff3031-bd71-4df7-a3a4-cec9c2339eaa@quicinc.com>
 <20240406041717.GD2678@thinkpad>
 <0b738556-0042-43ab-80f2-d78ed3b432f7@quicinc.com>
 <20240410165829.GA418382-robh@kernel.org>
 <c623951e-1b47-4e0b-bfa4-338672a5eeb9@quicinc.com>
 <ee4c0b2b-7a3b-43d1-90b6-369be2194a65@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee4c0b2b-7a3b-43d1-90b6-369be2194a65@quicinc.com>

On Fri, May 31, 2024 at 03:47:24PM -0700, Mayank Rana wrote:
> Hi Rob / Mani
> 
> On 4/15/2024 4:30 PM, Mayank Rana wrote:
> > Hi Rob
> > 
> > Excuse me for late response on this (was OOO).
> > On 4/10/2024 9:58 AM, Rob Herring wrote:
> > > On Mon, Apr 08, 2024 at 11:57:58AM -0700, Mayank Rana wrote:
> > > > Hi Mani
> > > > 
> > > > On 4/5/2024 9:17 PM, Manivannan Sadhasivam wrote:
> > > > > On Fri, Apr 05, 2024 at 10:41:15AM -0700, Mayank Rana wrote:
> > > > > > Hi Mani
> > > > > > 
> > > > > > On 4/4/2024 10:30 PM, Manivannan Sadhasivam wrote:
> > > > > > > On Thu, Apr 04, 2024 at 12:11:24PM -0700, Mayank Rana wrote:
> > > > > > > > On some of Qualcomm platform, firmware
> > > > > > > > configures PCIe controller into
> > > > > > > > ECAM mode allowing static memory allocation for
> > > > > > > > configuration space of
> > > > > > > > supported bus range. Firmware also takes care of
> > > > > > > > bringing up PCIe PHY
> > > > > > > > and performing required operation to bring PCIe
> > > > > > > > link into D0. Firmware
> > > > > > > > also manages system resources (e.g.
> > > > > > > > clocks/regulators/resets/ bus voting).
> > > > > > > > Hence add Qualcomm PCIe ECAM root complex driver
> > > > > > > > which enumerates PCIe
> > > > > > > > root complex and connected PCIe devices.
> > > > > > > > Firmware won't be enumerating
> > > > > > > > or powering up PCIe root complex until this
> > > > > > > > driver invokes power domain
> > > > > > > > based notification to bring PCIe link into D0/D3cold mode.
> > > > > > > > 
> > > > > > > 
> > > > > > > Is this an in-house PCIe IP of Qualcomm or the same
> > > > > > > DWC IP that is used in other
> > > > > > > SoCs?
> > > > > > > 
> > > > > > > - Mani
> > > > > > Driver is validated on SA8775p-ride platform using PCIe DWC IP for
> > > > > > now.Although this driver doesn't need to know used PCIe
> > > > > > controller and PHY
> > > > > > IP as well programming sequence as that would be taken
> > > > > > care by firmware.
> > > > > > 
> > > > > 
> > > > > Ok, so it is the same IP but firmware is controlling the
> > > > > resources now. This
> > > > > information should be present in the commit message.
> > > > > 
> > > > > Btw, there is an existing generic ECAM host controller driver:
> > > > > drivers/pci/controller/pci-host-generic.c
> > > > > 
> > > > > This driver is already being used by several vendors as
> > > > > well. So we should try
> > > > > to extend it for Qcom usecase also.
> > > 
> > > I would take it a bit further and say if you need your own driver, then
> > > just use the default QCom driver. Perhaps extend it to support ECAM.
> > > Better yet, copy your firmware setup and always configure the QCom h/w
> > > to use ECAM.
> > Good suggestion. Although here we are having 2 set of requirements:
> > 1. ECAM configuration
> > 2. Managing PCIe controller and PHY resources and programming from
> > firmware as well
> > Hence it is not feasible to use default QCOM driver.
> > > If you want to extend the generic driver, that's fine, but we don't need
> > > a 3rd.
> > I did consider this part before coming up with new driver. Although I
> > felt that
> > below mentioned functionality may not look more generic to be part of
> > pci-host-generic.c driver.
> > > > I did review pci-host-generic.c driver for usage. although there
> > > > are more
> > > > functionalityneeded for use case purpose as below:
> > > > 1. MSI functionality
> > > 
> > > Pretty sure the generic driver already supports that.
> > I don't find any MSI support with pci-host-generic.c driver.
> > > > 2. Suspend/Resume
> > > 
> > > Others might want that to work as well.
> > Others firmware won't have way to handle D3cold and D0 functionality
> > handling as
> > needed here for supporting suspend/resume as I don't find any interface
> > for pci-host-generic.c driver to notify firmware. here we are having way
> > to talk to firmware using GenPD based power domain usage to communicate
> > with firmware.
> > 
> > > > 3. Wakeup Functionality (not part of current change, but would be added
> > > > later)
> > > 
> > > Others might want that to work as well.
> > possible if suspend/resume support is available or used.
> > > > 4. Here this driver provides way to virtualized PCIe controller.
> > > > So VMs only
> > > > talk to a generic ECAM whereas HW is only directed accessed by
> > > > service VM.
> > > 
> > > That's the existing driver. If if doesn't work for a VM, fix the VM.
> > Correct.
> > > > 5. Adding more Auto based safety use cases related implementation
> > > 
> > > Now that's just hand waving.
> > Here I am trying to provide new set of changes plan to be added as part
> > of required functionality.
> > 
> > > > Hence keeping pci-host-generic.c as generic driver where above
> > > > functionality
> > > > may not be needed.
> > > 
> > > Duplicating things to avoid touching existing drivers is not how kernel
> > > development works.
> > I shall try your suggestion and see how it looks in terms of code
> > changes. Perhaps then we can have more clarity in terms of adding more
> > functionality into generic or having separate driver.
> I just learnt that previously dwc related PCIe ECAM driver and MSI
> controller driver tried out as:
> 
> https://lore.kernel.org/linux-pci/20170821192907.8695-1-ard.biesheuvel@linaro.org/
> 
> Although there were few concerns at that time. Due to that having dwc
> specific MSI functionality based driver was dropped, and pci-host-generic.c
> driver is being updated using with dwc/snps specific ECAM operation.
> 
> In current discussion, it seems that we are discussing to have identical
> approach here.
> 
> Atleast on Qualcomm SA8775p platform, I don't have any other way to support
> MSI functionality i.e. extended SPI or ITS/LPI based MSI or using GICv2m
> functionality are not supported.
> 
> I don't see any other approach other than MSI based implementation within
> pci-host-generic.c driver for dwc/snps based MSI controller.
> 
> Do you have any suggestion on this ?
> 

Since this ECAM driver is going to be used in newer Qcom SoCs, why can't you use
GICv3 for MSI handling?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

