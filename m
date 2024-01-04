Return-Path: <linux-pci+bounces-1646-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33195823BF0
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 06:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BD101C20363
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 05:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20272179BA;
	Thu,  4 Jan 2024 05:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XEAWvMiy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788671A70D
	for <linux-pci@vger.kernel.org>; Thu,  4 Jan 2024 05:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6dac225bf42so78896b3a.0
        for <linux-pci@vger.kernel.org>; Wed, 03 Jan 2024 21:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704347436; x=1704952236; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Uf9xX6NGzjv1ISMlid2UcA3oN+qjOMTFEKHCEil84EA=;
        b=XEAWvMiyIvCSukO3FitDAFBdKhzLDI/tvLdqP20JJiSKYV0RUgF9RY4QOGwf2vcmOg
         B6xCMPebYroO3TAJOzXRNnMDXPiL1PncmhuM9r/a2+JcUgLIuOGoRsGMzzHCPKMCjOQ5
         eWrPuDkibkQGauMZhr0/sL3E006QsJboJ7LmdULTglMX9Kon/k5xM011qjeO+k/hwQNh
         Gr5nTFlsuvhuZOEbFiIkoq6FTHzg2eGeBTDOoM3/c66AWC2HztFweJpA3mMop1VJaTlH
         +X163fQX7Bajk39NDTQ5Qiz6agrfGOINFR5bMmckHoyGto6UvTqCaWXoQuYNwATOOBqO
         zIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704347436; x=1704952236;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uf9xX6NGzjv1ISMlid2UcA3oN+qjOMTFEKHCEil84EA=;
        b=ZkpWkyhPEebUYiFUx8njlQarAV6RPsCbynKwdnIewnAaAaCamKea5g39QD0iXRW61v
         F/LjBdmMiw3sfWZrOPNpvHGcOj7Je3F4aW3Jn192cmF0nyRoHFalMTu/k1aadx3Cla9o
         Snw7fUQVrLdpdzPFK86uGPqNz1+cpA7PWm9GjsTM4tH2QBt3pVMMR2hKXyyqsWHJ0Eup
         cHEK9tzlkCOzdk0+IMueFIBxeA1cR6+8mWosgLysRtFlRjiE+ziaSx4IfIfcI3Y6JIvT
         Hve0aOozKBSZLy4UcMMj9hke3Hb/wn1OLtGpZD7cslgB2unGTE3KvGDE+3YXWf2uP3/z
         yfHg==
X-Gm-Message-State: AOJu0YwVr3VGhPxtbn8rbgiOimDxxwQdIxql27rj43am+SG22zXLNEZQ
	i5OmXvQZSBCZvMGa+qIrk4A0HQFeXa2c
X-Google-Smtp-Source: AGHT+IH+YmP6TkldqOBQ8q7LpIRUpnAuB55Y4aNLVXHxOcIszacbpKTctAPDRpPE0LlZCjBp4X2MWA==
X-Received: by 2002:a05:6a00:2e81:b0:6d9:8d50:55d with SMTP id fd1-20020a056a002e8100b006d98d50055dmr157139pfb.47.1704347435731;
        Wed, 03 Jan 2024 21:50:35 -0800 (PST)
Received: from thinkpad ([220.158.159.72])
        by smtp.gmail.com with ESMTPSA id f22-20020aa78b16000000b006d0d90edd2csm23793210pfd.42.2024.01.03.21.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 21:50:35 -0800 (PST)
Date: Thu, 4 Jan 2024 11:20:30 +0530
From: 'Manivannan Sadhasivam' <manivannan.sadhasivam@linaro.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com,
	gustavo.pimentel@synopsys.com, josh@joshtriplett.org,
	lukas.bulwahn@gmail.com, hongxing.zhu@nxp.com,
	pankaj.dubey@samsung.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Add support for RAS DES feature in PCIe DW
 controller
Message-ID: <20240104055030.GA3031@thinkpad>
References: <CGME20231130115055epcas5p4e29befa80877be45dbee308846edc0ba@epcas5p4.samsung.com>
 <20231130115044.53512-1-shradha.t@samsung.com>
 <20231130165514.GW3043@thinkpad>
 <000601da3e07$c39e5e00$4adb1a00$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <000601da3e07$c39e5e00$4adb1a00$@samsung.com>

On Wed, Jan 03, 2024 at 11:13:20AM +0530, Shradha Todi wrote:
> 
> 
> > -----Original Message-----
> > From: Shradha Todi <shradha.t@samsung.com>
> > Sent: 04 December 2023 14:10
> > To: 'Manivannan Sadhasivam' <manivannan.sadhasivam@linaro.org>
> > Cc: 'lpieralisi@kernel.org' <lpieralisi@kernel.org>; 'kw@linux.com'
> > <kw@linux.com>; 'robh@kernel.org' <robh@kernel.org>;
> > 'bhelgaas@google.com' <bhelgaas@google.com>; 'jingoohan1@gmail.com'
> > <jingoohan1@gmail.com>; 'gustavo.pimentel@synopsys.com'
> > <gustavo.pimentel@synopsys.com>; 'josh@joshtriplett.org'
> > <josh@joshtriplett.org>; 'lukas.bulwahn@gmail.com'
> > <lukas.bulwahn@gmail.com>; 'hongxing.zhu@nxp.com'
> > <hongxing.zhu@nxp.com>; 'pankaj.dubey@samsung.com'
> > <pankaj.dubey@samsung.com>; 'linux-kernel@vger.kernel.org' <linux-
> > kernel@vger.kernel.org>; 'linux-pci@vger.kernel.org' <linux-
> > pci@vger.kernel.org>
> > Subject: RE: [PATCH v2 0/3] Add support for RAS DES feature in PCIe DW
> > controller
> > 
> > 
> > 
> > > -----Original Message-----
> > > From: Manivannan Sadhasivam [mailto:manivannan.sadhasivam@linaro.org]
> > > Sent: 30 November 2023 22:25
> > > To: Shradha Todi <shradha.t@samsung.com>
> > > Cc: lpieralisi@kernel.org; kw@linux.com; robh@kernel.org;
> > > bhelgaas@google.com; jingoohan1@gmail.com;
> > > gustavo.pimentel@synopsys.com; josh@joshtriplett.org;
> > > lukas.bulwahn@gmail.com; hongxing.zhu@nxp.com;
> > > pankaj.dubey@samsung.com; linux-kernel@vger.kernel.org; linux-
> > > pci@vger.kernel.org
> > > Subject: Re: [PATCH v2 0/3] Add support for RAS DES feature in PCIe DW
> > > controller
> > >
> > > On Thu, Nov 30, 2023 at 05:20:41PM +0530, Shradha Todi wrote:
> > > > DesignWare controller provides a vendor specific extended capability
> > > > called RASDES as an IP feature. This extended capability  provides
> > > > hardware information like:
> > > >  - Debug registers to know the state of the link or controller.
> > > >  - Error injection mechanisms to inject various PCIe errors including
> > > >    sequence number, CRC
> > > >  - Statistical counters to know how many times a particular event
> > > >    occurred
> > > >
> > > > However, in Linux we do not have any generic or custom support to be
> > > > able to use this feature in an efficient manner. This is the reason
> > > > we are proposing this framework. Debug and bring up time of
> > > > high-speed IPs are highly dependent on costlier hardware analyzers
> > > > and this solution will in some ways help to reduce the HW analyzer usage.
> > > >
> > > > The debugfs entries can be used to get information about underlying
> > > > hardware and can be shared with user space. Separate debugfs entries
> > > > has been created to cater to all the DES hooks provided by the controller.
> > > > The debugfs entries interacts with the RASDES registers in the
> > > > required sequence and provides the meaningful data to the user. This
> > > > eases the effort to understand and use the register information for
> > > debugging.
> > > >
> > > > v1 version was posted long back and for some reasons I couldn't work
> > > > on it. I apologize for the long break. I'm restarting this activity
> > > > and have taken care of all previous review comments shared.
> > > > v1:
> > > > https://lore.kernel.org/all/20210518174618.42089-1-shradha.t@samsung
> > > > .c
> > > > om/T/
> > > >
> > >
> > > There is already a series floating to add similar functionality via
> > > perf
> > > subsystem: https://lore.kernel.org/linux-pci/20231121013400.18367-1-
> > > xueshuai@linux.alibaba.com/
> > >
> > > - Mani
> > >
> > 
> > Hi Mani,
> > 
> > The series proposed in perf includes only time based-analysis and event counters
> > which will monitor performance (Group 6 and 7). The patch or framework that we
> > have proposed includes debug information, error injection facility and error
> > counters (Group 0 - 5) which are not included as part of the functionality
> > implemented via perf. In my opinion, these functionalities don't count as
> > performance monitoring or counters but rather as debug counters. How about
> > we take this up as a debugfs framework as proposed in my patch?
> > Or if others feel it can be taken via perf driver then I am happy to extend the perf
> > driver if authors do not have objection. Let me know what you think of this?
> > Meanwhile I will review the perf patches and share my feedback.
> > 
> 
> Hello Mani,
> Any update on the above comment? IMO, even though the perf patches and this
> patchset are both part of the DWC vendor specific capability - RASDES,  they
> cover different features. The perf file includes performance based parameters
> like time-based analysis and event counters for count of packets whereas this
> patchset includes debugging fields, error injection and event counters for count
> of errors. I think having a separate debugfs file fits more but would you suggest
> we extend the perf file itself? 
> 

For the error injection and counters, we already have the EDAC framework. So
adding them in the DWC driver doesn't make sense to me.

But first check with the perf driver author if they have any plans on adding the
proposed functionality. If they do not have any plan or not working on it, then
look into EDAC.

- Mani

> Shradha
> 
> > > > Shradha Todi (3):
> > > >   PCI: dwc: Add support for vendor specific capability search
> > > >   PCI: debugfs: Add support for RASDES framework in DWC
> > > >   PCI: dwc: Create debugfs files in DWC driver
> > > >
> > > >  drivers/pci/controller/dwc/Kconfig            |   8 +
> > > >  drivers/pci/controller/dwc/Makefile           |   1 +
> > > >  .../controller/dwc/pcie-designware-debugfs.c  | 476
> > > ++++++++++++++++++
> > > >  .../controller/dwc/pcie-designware-debugfs.h  |   0
> > > >  drivers/pci/controller/dwc/pcie-designware.c  |  20 +
> > > > drivers/pci/controller/dwc/pcie-designware.h  |  18 +
> > > >  6 files changed, 523 insertions(+)
> > > >  create mode 100644
> > > > drivers/pci/controller/dwc/pcie-designware-debugfs.c
> > > >  create mode 100644
> > > > drivers/pci/controller/dwc/pcie-designware-debugfs.h
> > > >
> > > > --
> > > > 2.17.1
> > > >
> > >
> > > --
> > > மணிவண்ணன் சதாசிவம்
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

