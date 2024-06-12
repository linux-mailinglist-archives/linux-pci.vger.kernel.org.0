Return-Path: <linux-pci+bounces-8627-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1800904B6F
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 08:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E7771F22AF9
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 06:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE1313CF9F;
	Wed, 12 Jun 2024 06:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UpnFpHEP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19B113CFB2
	for <linux-pci@vger.kernel.org>; Wed, 12 Jun 2024 06:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718172903; cv=none; b=SCCQH8SII0lw3DM7rwLarDGNkTYcTOx9/X4zjAgfwEOkAZIZH2DJUfQYF8Nc401dJzmlfMaWsnmHXgFLU34GoXHrTcuyMgGwoprsrImfD/IBoxgZHG+VG4gYFH+oAR6E4lgiSmosQyVMlAhoKwnug2k2Xgrhq2y236PM3WHusu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718172903; c=relaxed/simple;
	bh=i2ZIe4aBjQVeX3802b5SX9UqNgXJzpYb7raknpDn/pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CD3EZg3Kau5TWt0hU0bBrub1SUKwQOEpROWaB8jyyaYediPh+c7DR+nBshr3GYBK09CLw0tnuMN6SWjg2bWOnuN2Z1K3pGmS1IHnGnQSDTz20RTJbIIjz3ZMOU8zlFDzzbV4ttZkT8OE6YRDqmXLOIjmSkAdQtw8dL0utiKngS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UpnFpHEP; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3d220039bc6so2134758b6e.2
        for <linux-pci@vger.kernel.org>; Tue, 11 Jun 2024 23:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718172901; x=1718777701; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mxqWgg2v/hVgWMCH9L846X5qk5UWjlKSRMUhsZwMVok=;
        b=UpnFpHEP7SYJIJVHI0mP4vEMpRK6C5E9qar0/NKJwI4QgO+UBHQFiuDDULF06zlYGt
         dDmPxpPwdIjU9Lgwt+6tua1EXPHBFmHT6qtOS1Rt+bEQDIU30xbnp58gNfl6PRayX2hQ
         zEA+YfjP6mqp7eAnojMfgcIPq5HTpNdbirM4pM5uJdDjdlH9Q1fIOgvHbquMe+MGRwIB
         C5NZ0xUSLfnIF2owLn7jk09+QuG0JkntXkNx4Xz/MyIdMi/484AxKjk6AAKdJM7z3v0K
         tgA8gWnQei3GQSop+kyyfj4PqpQivrq5ounfdVAs1ySmeVXv7TNyb3rwpiANozgxYmEE
         R+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718172901; x=1718777701;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mxqWgg2v/hVgWMCH9L846X5qk5UWjlKSRMUhsZwMVok=;
        b=efk92XKPyqvhI5cJHxfpBMsYaD0csYCYH2l5QTQ43u8ZRI9Ra2EbkwdADV3pRVpfip
         4EzYjyxbQOrnzrnOyUFw8X7ViLivVmfB25aW4N84RZ+XemeOE3JQX20+NzNXEZiMqDmj
         iJVy7CHqTGDaoSh3+KyBP/niu0l0BFv/C+4kKR3JNAi+iMwdxSORuWMaVySQVsck4jQU
         p7AyQSejWmw7nqYfl+P1vaKQ6GUoX9AjjwA5RlAzmXF/BuzlF6PiGGjDFfIZs6Nj9AXJ
         c/iiESF+nCmbtnGPU9lNv5caAVqC6OfEaIhchidocsO7YA5m6UuMYTPCwm4/wVvjiiYO
         OgmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRlevWj5/BIzYxpUWbyr/b9BjXHkXVUmTu3YDuINj1JqLf4xBtHzpDYpsf6FrQ8s78riMoaBDkMtus/Ap0THp2iC/fzPAcyinD
X-Gm-Message-State: AOJu0YxhNnMDEwvkrpdc+uY2XfbE4PtZYLdLmxpXU4iAp9o0Y8RtfSkb
	7ZVIF7tm0PQhE82URtf9M7QKJkyQKez7VHAFX1zAz9HlYcaLjuFbw3OL9ccKmA==
X-Google-Smtp-Source: AGHT+IFxppmgGAwZZlpP35K5VTaKTEVZFBRJrQUxH5Xn3BfV36uFmqpVK6xRnkznoBcATBpU+IiVLw==
X-Received: by 2002:a05:6808:191d:b0:3d2:1839:a5bc with SMTP id 5614622812f47-3d23e126d05mr1169369b6e.29.1718172900897;
        Tue, 11 Jun 2024 23:15:00 -0700 (PDT)
Received: from thinkpad ([120.60.129.29])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6de224fa32csm9390805a12.44.2024.06.11.23.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 23:15:00 -0700 (PDT)
Date: Wed, 12 Jun 2024 11:44:54 +0530
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
Message-ID: <20240612061454.GF2645@thinkpad>
References: <1712257884-23841-3-git-send-email-quic_mrana@quicinc.com>
 <20240405052918.GA2953@thinkpad>
 <e2ff3031-bd71-4df7-a3a4-cec9c2339eaa@quicinc.com>
 <20240406041717.GD2678@thinkpad>
 <0b738556-0042-43ab-80f2-d78ed3b432f7@quicinc.com>
 <20240410165829.GA418382-robh@kernel.org>
 <c623951e-1b47-4e0b-bfa4-338672a5eeb9@quicinc.com>
 <ee4c0b2b-7a3b-43d1-90b6-369be2194a65@quicinc.com>
 <20240606023952.GA3481@thinkpad>
 <ab551d96-c27e-40b7-9534-9e4b3c8a5a3c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab551d96-c27e-40b7-9534-9e4b3c8a5a3c@quicinc.com>

On Mon, Jun 10, 2024 at 10:17:31AM -0700, Mayank Rana wrote:
> 
> On 6/5/2024 7:39 PM, Manivannan Sadhasivam wrote:
> > On Fri, May 31, 2024 at 03:47:24PM -0700, Mayank Rana wrote:
> > > Hi Rob / Mani
> > > 
> > > On 4/15/2024 4:30 PM, Mayank Rana wrote:
> > > > Hi Rob
> > > > 
> > > > Excuse me for late response on this (was OOO).
> > > > On 4/10/2024 9:58 AM, Rob Herring wrote:
> > > > > On Mon, Apr 08, 2024 at 11:57:58AM -0700, Mayank Rana wrote:
> > > > > > Hi Mani
> > > > > > 
> > > > > > On 4/5/2024 9:17 PM, Manivannan Sadhasivam wrote:
> > > > > > > On Fri, Apr 05, 2024 at 10:41:15AM -0700, Mayank Rana wrote:
> > > > > > > > Hi Mani
> > > > > > > > 
> > > > > > > > On 4/4/2024 10:30 PM, Manivannan Sadhasivam wrote:
> > > > > > > > > On Thu, Apr 04, 2024 at 12:11:24PM -0700, Mayank Rana wrote:
> > > > > > > > > > On some of Qualcomm platform, firmware
> > > > > > > > > > configures PCIe controller into
> > > > > > > > > > ECAM mode allowing static memory allocation for
> > > > > > > > > > configuration space of
> > > > > > > > > > supported bus range. Firmware also takes care of
> > > > > > > > > > bringing up PCIe PHY
> > > > > > > > > > and performing required operation to bring PCIe
> > > > > > > > > > link into D0. Firmware
> > > > > > > > > > also manages system resources (e.g.
> > > > > > > > > > clocks/regulators/resets/ bus voting).
> > > > > > > > > > Hence add Qualcomm PCIe ECAM root complex driver
> > > > > > > > > > which enumerates PCIe
> > > > > > > > > > root complex and connected PCIe devices.
> > > > > > > > > > Firmware won't be enumerating
> > > > > > > > > > or powering up PCIe root complex until this
> > > > > > > > > > driver invokes power domain
> > > > > > > > > > based notification to bring PCIe link into D0/D3cold mode.
> > > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > Is this an in-house PCIe IP of Qualcomm or the same
> > > > > > > > > DWC IP that is used in other
> > > > > > > > > SoCs?
> > > > > > > > > 
> > > > > > > > > - Mani
> > > > > > > > Driver is validated on SA8775p-ride platform using PCIe DWC IP for
> > > > > > > > now.Although this driver doesn't need to know used PCIe
> > > > > > > > controller and PHY
> > > > > > > > IP as well programming sequence as that would be taken
> > > > > > > > care by firmware.
> > > > > > > > 
> > > > > > > 
> > > > > > > Ok, so it is the same IP but firmware is controlling the
> > > > > > > resources now. This
> > > > > > > information should be present in the commit message.
> > > > > > > 
> > > > > > > Btw, there is an existing generic ECAM host controller driver:
> > > > > > > drivers/pci/controller/pci-host-generic.c
> > > > > > > 
> > > > > > > This driver is already being used by several vendors as
> > > > > > > well. So we should try
> > > > > > > to extend it for Qcom usecase also.
> > > > > 
> > > > > I would take it a bit further and say if you need your own driver, then
> > > > > just use the default QCom driver. Perhaps extend it to support ECAM.
> > > > > Better yet, copy your firmware setup and always configure the QCom h/w
> > > > > to use ECAM.
> > > > Good suggestion. Although here we are having 2 set of requirements:
> > > > 1. ECAM configuration
> > > > 2. Managing PCIe controller and PHY resources and programming from
> > > > firmware as well
> > > > Hence it is not feasible to use default QCOM driver.
> > > > > If you want to extend the generic driver, that's fine, but we don't need
> > > > > a 3rd.
> > > > I did consider this part before coming up with new driver. Although I
> > > > felt that
> > > > below mentioned functionality may not look more generic to be part of
> > > > pci-host-generic.c driver.
> > > > > > I did review pci-host-generic.c driver for usage. although there
> > > > > > are more
> > > > > > functionalityneeded for use case purpose as below:
> > > > > > 1. MSI functionality
> > > > > 
> > > > > Pretty sure the generic driver already supports that.
> > > > I don't find any MSI support with pci-host-generic.c driver.
> > > > > > 2. Suspend/Resume
> > > > > 
> > > > > Others might want that to work as well.
> > > > Others firmware won't have way to handle D3cold and D0 functionality
> > > > handling as
> > > > needed here for supporting suspend/resume as I don't find any interface
> > > > for pci-host-generic.c driver to notify firmware. here we are having way
> > > > to talk to firmware using GenPD based power domain usage to communicate
> > > > with firmware.
> > > > 
> > > > > > 3. Wakeup Functionality (not part of current change, but would be added
> > > > > > later)
> > > > > 
> > > > > Others might want that to work as well.
> > > > possible if suspend/resume support is available or used.
> > > > > > 4. Here this driver provides way to virtualized PCIe controller.
> > > > > > So VMs only
> > > > > > talk to a generic ECAM whereas HW is only directed accessed by
> > > > > > service VM.
> > > > > 
> > > > > That's the existing driver. If if doesn't work for a VM, fix the VM.
> > > > Correct.
> > > > > > 5. Adding more Auto based safety use cases related implementation
> > > > > 
> > > > > Now that's just hand waving.
> > > > Here I am trying to provide new set of changes plan to be added as part
> > > > of required functionality.
> > > > 
> > > > > > Hence keeping pci-host-generic.c as generic driver where above
> > > > > > functionality
> > > > > > may not be needed.
> > > > > 
> > > > > Duplicating things to avoid touching existing drivers is not how kernel
> > > > > development works.
> > > > I shall try your suggestion and see how it looks in terms of code
> > > > changes. Perhaps then we can have more clarity in terms of adding more
> > > > functionality into generic or having separate driver.
> > > I just learnt that previously dwc related PCIe ECAM driver and MSI
> > > controller driver tried out as:
> > > 
> > > https://lore.kernel.org/linux-pci/20170821192907.8695-1-ard.biesheuvel@linaro.org/
> > > 
> > > Although there were few concerns at that time. Due to that having dwc
> > > specific MSI functionality based driver was dropped, and pci-host-generic.c
> > > driver is being updated using with dwc/snps specific ECAM operation.
> > > 
> > > In current discussion, it seems that we are discussing to have identical
> > > approach here.
> > > 
> > > Atleast on Qualcomm SA8775p platform, I don't have any other way to support
> > > MSI functionality i.e. extended SPI or ITS/LPI based MSI or using GICv2m
> > > functionality are not supported.
> > > 
> > > I don't see any other approach other than MSI based implementation within
> > > pci-host-generic.c driver for dwc/snps based MSI controller.
> > > 
> > > Do you have any suggestion on this ?
> > > 
> > 
> > Since this ECAM driver is going to be used in newer Qcom SoCs, why can't you use
> > GICv3 for MSI handling?
> Yes, that is plan further as look like we have limitation on just SA8775.
> So I see two options here:
> 1. Update pcie-host-generic.c without MSI based functionality, and leave
> with MSI functionality differently on SA8775
> 2. Also possible to make pcie-host-designware.c based MSI functionality as
> separate driver, and try to use with pcie-host-generic.c driver. That way we
> would still use existing MSI related code base, and able to use with ECAM
> driver.
> 
> Do you see using above option 2 as good way to allow SNPS/DWC based MSI
> controller functionality with ECAM and Non-ECAM driver ?
> 

IMO, it is not worth splitting the code just for one platform since you said the
future ECAM based platforms will not require DWC MSI.

But if you have a strong requirement to use upstream DWC MSI for SA8775, then
you can do the split.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

