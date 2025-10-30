Return-Path: <linux-pci+bounces-39757-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F4DC1EA73
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 07:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 285F919C3876
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 06:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6C7332912;
	Thu, 30 Oct 2025 06:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhmnJkVK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2962F5A31;
	Thu, 30 Oct 2025 06:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761807567; cv=none; b=IrwnqTORsKobLL+l6SK6r9XUItJfO7yY+GBTTfZe2eoGVnymuALHNUQXsq4ZmjoLtkkDdYr+/pdlivKEe+H7PVDJXu5/SBp3aQMS/mHP0PVWH8knFV23CisnaHgfdsrMv0nJy7W/cm1CIXPIzOvKGflbx/DsP/D6N7lebGRsA88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761807567; c=relaxed/simple;
	bh=pi8QZz8S06COfBDFE8/Wpju4Uxk040gn3MFwKckdEto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqpyGsq+i4SluLS67Rz/4WbWQbecLwvhUTiRxjUHdcnSZNW5DLak/ALCvbtmZEH9u1V+KYVMu+Ns+T6UiMhrEbxxkWuehwn6R2BfwaKUGMyDWmn1QotFppqYP30cs0UYOsa6lNfm1uKJYwIj43zvAdXY8TsBv0zYgHhEzlHZcfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhmnJkVK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0E0C4CEF1;
	Thu, 30 Oct 2025 06:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761807566;
	bh=pi8QZz8S06COfBDFE8/Wpju4Uxk040gn3MFwKckdEto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NhmnJkVKTHbBxaT7RKKAvihXDYVkKZTqdRc275vGNS+rmMVNBhbtesYJfRqH2+zl/
	 IFwOhgN66c5WX+1v4IkEt+UG/Nut2agoPKlZOuPXaAxPc2DteTkczciDDQ4Ln7SUgY
	 ISFfSelEN0gqkD71+7GPvwvmIqEEJaHo2cIZdmVpcRyi/JbG8jjp8FgusMRyAFtu4h
	 tJ/w1KS6EOWEbxQ6cIMFmkhw62p0wGrKF+QyzJu/9LcLlCql4dRik77uMr/PXI36n1
	 Xw0kjvpGSJMFSPKGDhRcbLzs8k8ziJTTO/YygdpdqSbzCC17GglqJuFpCtRwGhAgrM
	 jd5w2NUv30xDg==
Date: Thu, 30 Oct 2025 12:29:06 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, chaitanya chundru <quic_krichai@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, quic_vbadigan@quicnic.com, amitk@kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com, 
	linux-arm-kernel@lists.infradead.org, Dmitry Baryshkov <lumag@kernel.org>
Subject: Re: [PATCH v7 7/8] arm64: defconfig: Enable TC9563 PWRCTL driver
Message-ID: <lf3mihjdk5twfn54z4sfqf7kpp5drxkr4sk24d3zzh6pxsnvii@2micimqjfvuc>
References: <20251029-qps615_v4_1-v7-0-68426de5844a@oss.qualcomm.com>
 <20251029-qps615_v4_1-v7-7-68426de5844a@oss.qualcomm.com>
 <CAMRc=McWw6tAjjaa6wst6y3+Dw=JT8446wwvQ0_c5LHHm=1Y-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=McWw6tAjjaa6wst6y3+Dw=JT8446wwvQ0_c5LHHm=1Y-Q@mail.gmail.com>

On Wed, Oct 29, 2025 at 02:15:37PM +0100, Bartosz Golaszewski wrote:
> On Wed, Oct 29, 2025 at 12:30 PM Krishna Chaitanya Chundru
> <krishna.chundru@oss.qualcomm.com> wrote:
> >
> > Enable TC9563 PCIe switch pwrctl driver by default. This is needed
> > to power the PCIe switch which is present in Qualcomm RB3gen2 platform.
> > Without this the switch will not powered up and we can't use the
> > endpoints connected to the switch.
> >
> > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > ---
> >  arch/arm64/configs/defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index e3a2d37bd10423b028f59dc40d6e8ee1c610d6b8..fe5c9951c437a67ac76bf939a9e436eafa3820bf 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -249,6 +249,7 @@ CONFIG_PCIE_LAYERSCAPE_GEN4=y
> >  CONFIG_PCI_ENDPOINT=y
> >  CONFIG_PCI_ENDPOINT_CONFIGFS=y
> >  CONFIG_PCI_EPF_TEST=m
> > +CONFIG_PCI_PWRCTRL_TC9563=m
> >  CONFIG_DEVTMPFS=y
> >  CONFIG_DEVTMPFS_MOUNT=y
> >  CONFIG_FW_LOADER_USER_HELPER=y
> >
> > --
> > 2.34.1
> >
> 
> Can't we just do the following in the respective Kconfig entry?
> 
> config PCI_PWRCTRL_TC9563
>     tristate ...
>     default m if ARCH_QCOM

I believe the driver is supposed to support all Toshiba TC9563 switches, but
since we have some hooks for toggling PERST# and they are only added for QCOM
platforms atm, it is OK to select the driver in Kconfig.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

