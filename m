Return-Path: <linux-pci+bounces-10720-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2646293B1AA
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 15:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3A3D1F24893
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 13:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1CD158A03;
	Wed, 24 Jul 2024 13:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ptC4AZJy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E95383A9
	for <linux-pci@vger.kernel.org>; Wed, 24 Jul 2024 13:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721827909; cv=none; b=LE8Wu4uoyCdRJjSodPBFS2EOxutbQmOdwZsYXAYnbqUnoX1Oxx85JVPgdlPd5xZo5qj9CErVRy6QJrqFqsMbMgXcnJtVFUnqxyXAvEwHVsATcZpeFvjESwvqX0YlTQMQS2i0Zz19mUE3/aoZ+aE9KR8KR7BhMlKT+lNHr3MmJy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721827909; c=relaxed/simple;
	bh=uYCjH62094fWSixlswCV1RaLX7VIn9OqXvSaZojUorI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YM2fGPRsfL4N3x7SL/B1LatxZGRKbwbPj52xb97FGiqn/n+1L8eOKJO9oZuqX6tBKd4ZdT3W3oW+YiZw9XEC8AsO8KEXB8nYdrfUCCE8ccRy9Rui61EoKe0VH09ZTo1jtqXAcg1KUQD4ttrYxihCN7ZzBDTAH7yRGQZOsYnLHXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ptC4AZJy; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fec34f94abso4435475ad.2
        for <linux-pci@vger.kernel.org>; Wed, 24 Jul 2024 06:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721827908; x=1722432708; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=An58Dm8uzaKKX2Id+IrUBFJsqsLXfX4o2DrHskK6/IE=;
        b=ptC4AZJybq12bXHiJWB1ty4tX2lxSPCjdhFrKYUOkdR4yvUtAhM47/YV6DrihbSP+R
         2bYtorfQuAhCn2TGYXhNHGiHdJ8lSQmAZ2NaZd3vYuG8T8OWnSj8BiCLytXFZrZQhIhl
         b46GL33qpPsx81c+7FqQGzHx3IUmzwXCeLpbfgwiG41QPUfrKt/ZmCUee9sTszZ76FBT
         R+5iur67m/z8WZ7VJRJDi17InXnp4y9f0oNdBxsSOEoEBR0NPVZ1vPqmpnITyzZMlLDS
         wTWwEW1pDxp858MmRpT4x4c2x9/Nu2VTEet5FDTxM6jmfJApwCo/gnaSreWVyoV8nZhz
         b0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721827908; x=1722432708;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=An58Dm8uzaKKX2Id+IrUBFJsqsLXfX4o2DrHskK6/IE=;
        b=UNqFLrrIg4tZXwCH9PvNEqyiWS3wsU0gBgzUJ0Sq4ni1qk8pqzUbtyECuTA9BXm9PG
         tt/fIop8QyoIaioHHue65smTzvR8TNrteoC+0iLdnVCj7f82iRqIemL+5kf/tInCQsva
         EgNGe//QlC1eP9ehocDWYku87J6PlibUcLTajqHmmiduHsTOmx82Qn4I+IM++ID7B1Le
         s7gOgstPzth+WtKx4iw3LKptGnOZgJ+lPk2hra8PqEkAlykacfBP/sPWHBKfMBrQvnHn
         +2vyWecKG3ZusRN607OQvTXlXwPnFoBOEVuLyvwzanIdeMZeHI/C7mcPs88Cj1kT9hHW
         4O7g==
X-Forwarded-Encrypted: i=1; AJvYcCWEZ1h1enuAvfELsUfFXiG33l0/mPVCSs6wTRRCW8C0gpB/RbLVctaKnXfjQqPP4f2lzzUv9MZeuQT7ko2kEDI6j2/BL5JGLhs4
X-Gm-Message-State: AOJu0Yx/qV2n3LvT2h7syr9o8JaRDww6wTz8jz2B/fRe1b+rLR/6jJUV
	LRrORje54uNJ2xSdgtsCrXMyOM59fle3STU842PbRkXUrYkMQTJV0Ki+uy84jQ==
X-Google-Smtp-Source: AGHT+IHb0kWbPKxJXE8j3XbcKOASOVLyTWt8KuLbfjyutzlEHgdUE9xCdNY9SBRwTe6WQGUXPhg2RA==
X-Received: by 2002:a17:902:cec8:b0:1fd:9c2d:2f17 with SMTP id d9443c01a7336-1fdd220ad6dmr32143095ad.44.1721827907808;
        Wed, 24 Jul 2024 06:31:47 -0700 (PDT)
Received: from thinkpad ([103.244.168.26])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f291f05sm94155675ad.90.2024.07.24.06.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 06:31:47 -0700 (PDT)
Date: Wed, 24 Jul 2024 19:01:39 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Mayank Rana <quic_mrana@quicinc.com>, will@kernel.org,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com, cassel@kernel.org,
	yoshihiro.shimoda.uh@renesas.com, s-vadapalli@ti.com,
	u.kleine-koenig@pengutronix.de, dlemoal@kernel.org,
	amishin@t-argos.ru, thierry.reding@gmail.com, jonathanh@nvidia.com,
	Frank.Li@nxp.com, ilpo.jarvinen@linux.intel.com, vidyas@nvidia.com,
	marek.vasut+renesas@gmail.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	quic_ramkri@quicinc.com, quic_nkela@quicinc.com,
	quic_shazhuss@quicinc.com, quic_msarkar@quicinc.com,
	quic_nitegupt@quicinc.com
Subject: Re: [PATCH V2 0/7] Add power domain and MSI functionality with PCIe
 host generic ECAM driver
Message-ID: <20240724133139.GB3349@thinkpad>
References: <1721067215-5832-1-git-send-email-quic_mrana@quicinc.com>
 <rzf5jaxs2g4usnqzgvisiols2zlizcqr3pg4b63kxkoaekkjdf@rleudqbiur5m>
 <a87d4948-a9ce-473b-ae36-9f0c04c3041e@quicinc.com>
 <CAA8EJpq=rj-=JsYpPmwXiYkL=AALf-ZPQeq9drEoCkCAufLdig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA8EJpq=rj-=JsYpPmwXiYkL=AALf-ZPQeq9drEoCkCAufLdig@mail.gmail.com>

On Wed, Jul 24, 2024 at 10:12:17AM +0300, Dmitry Baryshkov wrote:
> On Wed, 24 Jul 2024 at 06:58, Mayank Rana <quic_mrana@quicinc.com> wrote:
> >
> >
> >
> > On 7/23/2024 7:13 PM, Dmitry Baryshkov wrote:
> > > On Mon, Jul 15, 2024 at 11:13:28AM GMT, Mayank Rana wrote:
> > >> Based on previously received feedback, this patch series adds functionalities
> > >> with existing PCIe host generic ECAM driver (pci-host-generic.c) to get PCIe
> > >> host root complex functionality on Qualcomm SA8775P auto platform.
> > >>
> > >> Previously sent RFC patchset to have separate Qualcomm PCIe ECAM platform driver:
> > >> https://lore.kernel.org/all/d10199df-5fb3-407b-b404-a0a4d067341f@quicinc.com/T/
> > >>
> > >> 1. Interface to allow requesting firmware to manage system resources and performing
> > >> PCIe Link up (devicetree binding in terms of power domain and runtime PM APIs is used in driver)
> > >> 2. Performing D3 cold with system suspend and D0 with system resume (usage of GenPD
> > >> framework based power domain controls these operations)
> > >> 3. SA8775P is using Synopsys Designware PCIe controller which supports MSI controller.
> > >> This MSI functionality is used with PCIe host generic driver after splitting existing MSI
> > >> functionality from pcie-designware-host.c file into pcie-designware-msi.c file.
> > >
> > > Please excuse me my ignorance if this is described somewhere. Why are
> > > you using DWC-specific MSI handling instead of using GIC ITS?
> > Due to usage of GIC v3 on SA8775p with Gunyah hypervisor, we have
> > limitation of not supporting GIC ITS
> > functionality. We considered other approach as usage of free SPIs (not
> > available, limitation in terms of mismatch between number of SPIs
> > available with physical GIC vs hypervisor) and extended SPIs (not
> > supported with GIC hardware). Hence we just left with DWC-specific MSI
> > controller here for MSI functionality.
> 
> ... or extend Gunyah to support GIC ITS. I'd say it is a significant
> deficiency if one can not use GIC ITS on Gunyah platforms.
> 

It if were possible, Qcom would've went with that. Unfortunately, it is not.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

