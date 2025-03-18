Return-Path: <linux-pci+bounces-24014-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB7BA66CDD
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 08:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2D5319A34DF
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 07:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4362B1F0987;
	Tue, 18 Mar 2025 07:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gHLMemDd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B26C17A309
	for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 07:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742284166; cv=none; b=smq3hnzHObLbFAiqq+Dp6Sou1sJ6qMmoG405mcbjLGJfgPRQiouOe+HC9vrR43x2bXy/0lrsxc8SUehSUQ3SsaQ5kemPDqcq3crmgnqmw2gRHsC31JE6188cjYVJGbNewHecr3Fcge0T0hAyFLdZ1blcMfN7Av2eGZZKxPthBj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742284166; c=relaxed/simple;
	bh=3esxDzO1vXxe0Pp8AngxqXrndMvDlKWTXyN6Qrtc1LE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0T15tqCaKr6ZQW1hFbFcrr28cyfSqAt7ParCUlqSf1je+izZrUeP8ptM9gOQxjZNpxQV43BA/4Qft+/4bX8USaefART4BwpHi4g3SN3rvdTcsAz6khECq/Q9tnVoMU1sSMvXoq7tpgvIlV7lXtcNYTL1vqIBlEh4JvkNnaqXnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gHLMemDd; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-225fbdfc17dso40457285ad.3
        for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 00:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742284164; x=1742888964; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4gk6oJcdXjJrwsMImt/znJgOTOwkBmDOkZsDuxU3Rxs=;
        b=gHLMemDdw6wvNEPLA0rw/ywI2g3U4wN00pFrPSqsddWtos6sABylGbL22MRuP2MXmR
         ixVonI3BT84RjsjOSy4lkDa4Wr7CKlUROt86Sa22J/lQyDkUhMZvL4g4jyGv/F/v4S1e
         B+0NL0IcZ89frjYKEMnLdzPmDldKDIuqZw74WPhYJnqVHMOziqOIo7f5dL3GL9NhEt4e
         CK9DqZWtqperSYUE9Xq88cLKWBIU+3fk+CIqMcyxzCR4W6TM4zmAk4mn23KZ/1CQf2Ot
         GW3qijhVh1EaaM0yea66Og6fiYnTjWBFvRC4qMlkQNYxMwst4E+6BSlW0n7NggyDC933
         HA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742284164; x=1742888964;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4gk6oJcdXjJrwsMImt/znJgOTOwkBmDOkZsDuxU3Rxs=;
        b=L1VGWyWFdx8FFuwGwJ284i3PnHdctr5QUJ0wyvBFjkufcW9SHEscueYQjQHvRya0AW
         dexskyxilqgUd6ZWePbYmRX8Uu+r6qiVoKnP4qIvOc6Cu3szn4PabKi5JmmspLUn5i/h
         CbQrsRDkZqe5Y9Vhbl4gpRjsK8QkLUccvG1EinzqhlHAYEtPtroblRYR8Ma83azvkJHf
         YO/SO5XtBKVtqTiIR6Fpo/5o9PIqFkAOq10cLdomx3uQlP2w5s3IdY74byp7ucy+6L7c
         t8czkSRtsBm3cD5C9x5VJZDP+fkNfsEJY8tI/8Cxtrndz5DGfrpC6exljV3fDVMI2ZUo
         y5JQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnVH+WYAqrfwHHLfvXT18HYcBEVFCJW83sjo/uJVcLWPeUyi3hlIYzlcZo0YzwzEcPt6AB6yvshg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYvQY73maADAEUtwRjFuG6q2j9dnFrv4OajIvQry5NEl1sR4Ne
	9uM0UqutQ4qgRdPdNLmVqybletca6DNqP9knQH/mJdlVvuk7UINaGJaxfzibBg==
X-Gm-Gg: ASbGncsDC9ZkQleFIQqAx2XN69pGouIf8DP7J7AUN5+hxJ7YJX5C6dVQEvCuncJbw0d
	V8WTz6tMsxpzHkNYY9WysRE7/DdzHSHQpv3Vin+4TYT1rBHfb3XmN8xr2SYr1E+GgcSWj6CQWzx
	E+qX45uQwavZf8pd699x78crlMu34a2FycbBuOCWpu6AnBUl1i8NJt51bpob13PEwj4SES681iR
	umO/vWm5rmHeoOZzGG4VlJPoeY+GMtLoaqHvLMMupd3VMG5gNfS6nbIcpSsLiLqqm/zOgvq+eRS
	r4ENKg2XFcwccPzq6KcDCPb77Vez7sctFRYWmlngsVDRa12+DU0NZhGL
X-Google-Smtp-Source: AGHT+IH069HRnLK7GJqqbw6Dd1HNX+3REq1qkSJVtn6/nxb/rYTa5SmZP93qVfdUgG49SQLEkOhpBg==
X-Received: by 2002:a05:6a00:9a7:b0:730:927c:d451 with SMTP id d2e1a72fcca58-7372246dacbmr21313065b3a.20.1742284163790;
        Tue, 18 Mar 2025 00:49:23 -0700 (PDT)
Received: from thinkpad ([120.56.195.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711559fbdsm9171304b3a.59.2025.03.18.00.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 00:49:23 -0700 (PDT)
Date: Tue, 18 Mar 2025 13:19:17 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, vigneshr@ti.com, kishon@kernel.org,
	cassel@kernel.org, wojciech.jasko-EXT@continental-corporation.com,
	thomas.richard@bootlin.com, bwawrzyn@cisco.com,
	linux-pci@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com
Subject: Re: [PATCH 1/4] PCI: cadence: Add support to build pcie-cadence
 library as a kernel module
Message-ID: <20250318074917.inhspuuypxmaioqe@thinkpad>
References: <20250307103128.3287497-1-s-vadapalli@ti.com>
 <20250307103128.3287497-2-s-vadapalli@ti.com>
 <20250313174416.n3c4srf6hb2l3bvg@thinkpad>
 <20250314065444.fmvhyqmuefnm4mcq@uda0492258>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250314065444.fmvhyqmuefnm4mcq@uda0492258>

On Fri, Mar 14, 2025 at 12:24:44PM +0530, Siddharth Vadapalli wrote:
> On Thu, Mar 13, 2025 at 11:14:16PM +0530, Manivannan Sadhasivam wrote:
> 
> Hello Mani,
> 
> > On Fri, Mar 07, 2025 at 04:01:25PM +0530, Siddharth Vadapalli wrote:
> > > From: Kishon Vijay Abraham I <kishon@ti.com>
> > > 
> > > Currently, the Cadence PCIe controller driver can be built as a built-in
> > > module only. Since PCIe functionality is not a necessity for booting, add
> > > support to build the Cadence PCIe driver as a loadable module as well.
> > > 
> > > Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> > > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > 
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > > ---
> > >  drivers/pci/controller/cadence/Kconfig             |  6 +++---
> > >  drivers/pci/controller/cadence/pcie-cadence-ep.c   |  6 ++++++
> > >  drivers/pci/controller/cadence/pcie-cadence-host.c |  9 +++++++++
> > >  drivers/pci/controller/cadence/pcie-cadence.c      | 12 ++++++++++++
> > >  drivers/pci/controller/cadence/pcie-cadence.h      |  4 ++--
> > >  5 files changed, 32 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
> > > index 8a0044bb3989..82b58096eea0 100644
> > > --- a/drivers/pci/controller/cadence/Kconfig
> > > +++ b/drivers/pci/controller/cadence/Kconfig
> > > @@ -4,16 +4,16 @@ menu "Cadence-based PCIe controllers"
> > >  	depends on PCI
> > >  
> > >  config PCIE_CADENCE
> > > -	bool
> > > +	tristate
> > >  
> > >  config PCIE_CADENCE_HOST
> > > -	bool
> > > +	tristate
> > >  	depends on OF
> > >  	select IRQ_DOMAIN
> > 
> > Even though this was added earlier, looks like not needed.
> 
> Thank you for reviewing this patch.
> 
> drivers/pci/controller/cadence/Kconfig has the following:
> ...
> 	config PCIE_CADENCE_HOST
> 		bool
> 		depends on OF
> 		select IRQ_DOMAIN
> 		select PCIE_CADENCE
> ...
> 	config PCI_J721E_HOST
> 		bool "TI J721E PCIe controller (host mode)"
> 		depends on ARCH_K3 || COMPILE_TEST
> 		depends on OF
> 		select PCIE_CADENCE_HOST
> 		select PCI_J721E
> ...
> So PCI_J721E_HOST selects PCIE_CADENCE_HOST which in turn selects
> PCIE_CADENCE. As of now, none of these configs are enabled in
> arm64-defconfig, and they also will not be accepted as built-in modules
> as it will bloat the Linux Image for everyone. For that reason, they are
> all being converted to loadable modules, and their configs will eventually
> be enabled in arm64-defconfig as loadable modules.
> 
> Please let me know if I misunderstood your comment regarding the quoted
> change not being required.
> 

Yes, you misunderstood indeed :) My earlier comment was about IRQ_DOMAIN symbol
which looked like not needed at all.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

