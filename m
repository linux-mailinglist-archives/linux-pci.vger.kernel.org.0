Return-Path: <linux-pci+bounces-22953-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E009A4F83E
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 08:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C623D3A6754
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 07:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DD71EF0B4;
	Wed,  5 Mar 2025 07:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzz1qEpJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2067E78F24;
	Wed,  5 Mar 2025 07:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741160930; cv=none; b=G20iCxnf2Z8sp9GFTaAkVEe1Jhh5VlL1wjFNIqY039RKnScP9Bylimqlk7eGKqNlImbA5P/UikapoPhOXPDXimGjb20lEHHBPlZzVNapf6+hLqUWLyhYoL4n2HS1qG1K/wQFmFHSgDThHL5ZcCCmkTshaA3Dp0037uS4pWBmX7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741160930; c=relaxed/simple;
	bh=OUCqZ6jMMZxBf9sqcmDm9unaPoc0Cv7q8uEblBwG+q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHOIdx93znecOKCBu/pFRCiuBbCGSEZlcAzN8FIirrSoP5BompCZztI2vrFqklOhBHUtF3Npy8Wn+wDXispmbZ0r/aDzW+/coZlIyU9NlVrMTpVEL7dmFg/WB0C9o6y3SYTP89Q7NNOfJCfOCQ4kzwDFm2ogpldymFsDNxvVs+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzz1qEpJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037BDC4CEE2;
	Wed,  5 Mar 2025 07:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741160929;
	bh=OUCqZ6jMMZxBf9sqcmDm9unaPoc0Cv7q8uEblBwG+q0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hzz1qEpJvAZIrMHA8YdBhYwQcClYq9e1oLRPfh7ueEqokk+eWiYidSDPkcIrrYipN
	 pKTwIh9AcpeILhk2kIaMXgr39B9b953rmYZAzw9nmKzzdHgCchOauJ0HrCB0T7zN+8
	 46liGS3NnWAbqu+d22MFm7NEDp0k6FWYWm24TYQa8n1O0cxTi5MEUPHOCXdloGQxXB
	 MXimGPjGz/eGcxpkdNI0xy8gK76DX+jMGuMDDnO23Xk0Dd0ic36lti1ADfk8kNBGpz
	 pdR5sdFCvhxq388VfA7tLI/Cy7TzDHN50GlVkPXxhlDcvlbSbIpyPt1bfZR+oCHbyo
	 QejNR0w3xVXYQ==
Date: Wed, 5 Mar 2025 13:18:38 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	chaitanya chundru <quic_krichai@quicinc.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Jingoo Han <jingoohan1@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicnic.com,
	amitk@kernel.org, dmitry.baryshkov@linaro.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 09/10] dt-bindings: PCI: qcom,pcie-sc7280: Add
 'global' interrupt
Message-ID: <20250305074838.yjhvpqrm4xrzta2y@thinkpad>
References: <20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com>
 <20250225-qps615_v4_1-v4-9-e08633a7bdf8@oss.qualcomm.com>
 <20250226-enlightened-chachalaca-of-artistry-2de5ea@krzk-bin>
 <t34rurxh5cb7hwzvt6ps3fgw4kh4ddwcieukskxxz5mo3pegst@jkapxm6izq7p>
 <Z8f++i4MFku8ODKf@trex>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8f++i4MFku8ODKf@trex>

On Wed, Mar 05, 2025 at 08:36:26AM +0100, Jorge Ramirez wrote:
> On 26/02/25 10:29:43, Bjorn Andersson wrote:
> > On Wed, Feb 26, 2025 at 08:32:42AM +0100, Krzysztof Kozlowski wrote:
> > > On Tue, Feb 25, 2025 at 03:04:06PM +0530, Krishna Chaitanya Chundru wrote:
> > > > Qcom PCIe RC controllers are capable of generating 'global' SPI interrupt
> > > > to the host CPU. This interrupt can be used by the device driver to handle
> > > > PCIe link specific events such as Link up and Link down, which give the
> > > > driver a chance to start bus enumeration on its own when link is up and
> > > > initiate link training if link goes to a bad state. The PCIe driver can
> > > > still work without this interrupt but it will provide a nice user
> > > > experience when device gets plugged and removed.
> > > > 
> > > > Hence, document it in the binding along with the existing MSI interrupts.
> > > > Global interrupt is parsed as optional in driver, so adding it in bindings
> > > > will not break the ABI.
> > > > 
> > > > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml | 8 +++++---
> > > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
> > > > index 76cb9fbfd476..7ae09ba8da60 100644
> > > > --- a/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
> > > > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
> > > > @@ -54,7 +54,7 @@ properties:
> > > >  
> > > >    interrupts:
> > > >      minItems: 8
> > > > -    maxItems: 8
> > > > +    maxItems: 9
> > > >  
> > > >    interrupt-names:
> > > >      items:
> > > > @@ -66,6 +66,7 @@ properties:
> > > >        - const: msi5
> > > >        - const: msi6
> > > >        - const: msi7
> > > > +      - const: global
> > > 
> > > Either context is missing or these are not synced with interrupts.
> > > 
> > 
> > I think the patch context ("properties") is confusing here, but it looks
> > to me that these are in sync: interrupts is defined to have 8 items, and
> > interrupt-names is a list of msi0 through msi7.
> > 
> > @Krishna, these two last patches (adding the global interrupt) doesn't
> > seem strongly connected to the switch patches. So, if Krzysztof agrees
> > with above assessment, please submit them separately (i.e. a new series,
> > 2 patches, v5).
> 
> um, but without these two patches, the functionality is broken requiring
> users to manually rescan the pci bus (ie, via sysfs) to see what is
> behind the bridge.
> 

It is not *broken* actually. The series is for enabling the PCIe switch and the
'global' IRQ is a host behavior. So technically both are not dependent on each
other.

> shouldnt the set include all the necessary patches? 
> 

FWIW, I have submitted a series that adds the IRQ for most of the arm64
platforms:
https://lore.kernel.org/linux-arm-msm/20250227-pcie-global-irq-v1-0-2b70a7819d1e@linaro.org/

There is a possibility that the above series could get merged before this one.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

