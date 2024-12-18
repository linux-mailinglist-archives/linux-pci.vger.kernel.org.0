Return-Path: <linux-pci+bounces-18676-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 324BB9F6109
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 10:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40BF57A4357
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 09:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F5A19A298;
	Wed, 18 Dec 2024 09:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h0CEJ30g"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07F015A84E
	for <linux-pci@vger.kernel.org>; Wed, 18 Dec 2024 09:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734512814; cv=none; b=eeUfDYe7Z1TJZG42qnK8iPtVN/0C3FYNEE5/k+7IX1g0Ipvm2Bb7xG93U9UZJ9+cst+hpjZF6fDFFVhPJ70tz+kKswS6C4KNPCYugduCvyHDYKIlPx7Q4SFuAcJa8hUKA5jwlpRRcF2un5SE1HdjBtBYTU9FNn+xhrH0TqLjZoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734512814; c=relaxed/simple;
	bh=BtkrMpozf0jdTpY6iuVSH+yuW5J+4kqV/qyv7r3T4v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ph0riCSY2lwYq8Yc+vm7EZTr3pIqPIaZAkOj3lDaj47zbbGjd2qH6k2mLliOeT7vxPY+1jAG9RdiwManNpeeIofADTzeftL+0ZsNXdMTCAbXU4bPmsvS+Bt77oTTTefr/79zA3ZuXMBthlzyXohOdFaN84ZGsNPrqRSVxL135fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h0CEJ30g; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-8019338c2b2so4013190a12.3
        for <linux-pci@vger.kernel.org>; Wed, 18 Dec 2024 01:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734512811; x=1735117611; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GCGMCINTHycaSUk/d2i6Tkx5PMoxq8giUl7PZqrxQnU=;
        b=h0CEJ30gzKn7V5uhK2Z9GNvbNQYbakP580jwt0AilHJjMyHDenvfLcloMvX4k6Idvo
         AsZycDwDoOb4H5+3Hu7h1pB2RPubzgbiZ6wjh9jquvE4qmxZOfVcmHwBftKHm5jeuzFt
         mVc3ulpoWxXNNdiw7rY70BrYmSz9j7DEOQNvqCCXOegjPDDayegQF2AWip8AG78+9/kd
         h3qaGSetgFbTBEo+CBxH+vxjutO15MaE31XJfQO/JTF5u14vQOa44ock9AT9EBLJSp4d
         rWqrPwNjFJFvR0rv0/urWRLSM+6sT1Wgb57v5WVG91kXKwH2hY03TJ+/1Xu2boZorJQV
         XQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734512811; x=1735117611;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GCGMCINTHycaSUk/d2i6Tkx5PMoxq8giUl7PZqrxQnU=;
        b=qzsIAwsUbxKihzimh1mY396nmrqSQyPWKFV8YY96KybKRxXI+7PqRT0mUaSomT367C
         6pNOi2tPbdikPZx5anUt41scmRwcG9W9Kvig6I/mmpuMS/pgvRr7fHKskqdv5KqLAE2L
         L2wt5wR8WruI8b/SpFCILjG7sOrWIGr10q5laPJHpWuWbRs/07JJl8n1JK5LSwCSEho1
         aRETZ08QoieEuBCrLC68t6ksOMcz8s0zCXNvWIhxqEN1JefWyd4YRLdDroi1f9My5ne/
         MKpvzNzY6H1lUBFAPqFjmp04zAAxoVjhXJYuba3PgLDuAlKITSQTSYNluYK9eaxwctmL
         QLyA==
X-Forwarded-Encrypted: i=1; AJvYcCWXwc1aHq1C93/vxjhz7rzoGN2N+nT7cJXgwXRq5uQRME5AeEG3gYUrvijhu5PWcpqWHfraI0YI63Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxupYLiFSrsOLuB/pW2KauMbvkMirXGOhnYu58K4tCoHy025CQf
	5svBxkylQYZaaxWX4Bdq0Ilh7CWwaPMpJXKaX04ijOIHacX1mxLn2AQ52M0vIw==
X-Gm-Gg: ASbGncvdjnoXhLkUOeiGwAZlzJVo+h1J1BdblX67q2Ub6plwmJ/oa7rvXRt/bWD89ed
	aZkoBtIZrtVVWU6KaI6v+yeZRQmgGwhR1ku0pV2h0ppB+j1nCHkk0+KBBQ9pkR2OR0vX07iKfW/
	utlKYVMH607ZqJW8IMgwSW9bCqN6zhS7fwoLhP3tcFYxAGnF/V5NJl5xf0eScbE4uTgY71BbcFl
	Y18uOWx9Ra1Fqm7rZCkLjeHqBI+1kmWtIMZT+znBOOodvpc+z2uE3DGtRjtsuVWqG8p
X-Google-Smtp-Source: AGHT+IHyd0rjMU5k67UAqjTzwzFPT1nFixbQFJlYVvsZ8oxYL1YYOQHvMxEIakRysvdaXHIwPi972g==
X-Received: by 2002:a17:90b:2b8f:b0:2ee:df57:b194 with SMTP id 98e67ed59e1d1-2f2e91fef48mr2602950a91.21.1734512811162;
        Wed, 18 Dec 2024 01:06:51 -0800 (PST)
Received: from thinkpad ([117.193.214.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e6d87asm71760635ad.264.2024.12.18.01.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 01:06:50 -0800 (PST)
Date: Wed, 18 Dec 2024 14:36:41 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, p.zabel@pengutronix.de,
	cassel@kernel.org, quic_schintav@quicinc.com,
	fabrice.gasnier@foss.st.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: PCI: Add STM32MP25 PCIe root complex
 bindings
Message-ID: <20241218090641.dtn4niamg6gcvxml@thinkpad>
References: <20241205172022.GA3053765@bhelgaas>
 <d976d74c-80c0-4446-bb9b-960a990c552b@foss.st.com>
 <20241217172502.borj2oy4rpxcteag@thinkpad>
 <5b835381-55bc-4fc8-b848-535f6e881420@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b835381-55bc-4fc8-b848-535f6e881420@foss.st.com>

On Wed, Dec 18, 2024 at 09:42:45AM +0100, Christian Bruel wrote:
> 
> 
> On 12/17/24 18:25, Manivannan Sadhasivam wrote:
> > On Tue, Dec 17, 2024 at 04:53:48PM +0100, Christian Bruel wrote:
> > > 
> > > > Makes sense.  What about phys, resets, etc?  I'm pretty sure a PHY
> > > > would be a per-Root Port thing, and some resets and wakeup signals
> > > > also.
> > > > 
> > > > For new drivers, I think we should start adding Root Port stanzas to
> > > > specifically associate those things with the Root Port, e.g.,
> > > > something like this?
> > > > 
> > > >     pcie@48400000 {
> > > >       compatible = "st,stm32mp25-pcie-rc";
> > > > 
> > > >       pcie@0,0 {
> > > >         reg = <0x0000 0 0 0 0>;
> > > >         phys = <&combophy PHY_TYPE_PCIE>;
> > > >         phy-names = "pcie-phy";
> > > >       };
> > > >     };
> > > > 
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml?id=v6.12#n111
> > > > is one binding that does this, others include apple,pcie.yaml,
> > > > brcm,stb-pcie.yaml, hisilicon,kirin-pcie.yaml.
> > > > 
> > > 
> > > On a second thought, moving the PHY to the root-port part would introduce a
> > > discrepancy with the pcie_ep binding, whereas the PHY is required on the
> > > pcie_ep node.
> > > 
> > > Even for the pcie_rc, the PHY is needed to enable the core_clk to access
> > > the PCIe core registers,
> > > 
> > 
> > But why that matters? You can still parse the child nodes, enable PHY and
> > configure PCIe registers. >
> > > So that would make 2 different required PHY locations for RC and EP:
> > > 
> > >      pcie_rc: pcie@48400000 {
> > >        compatible = "st,stm32mp25-pcie-rc";
> > > 
> > >        pcie@0,0 {
> > >          reg = <0x0000 0 0 0 0>;
> > >          phys = <&combophy PHY_TYPE_PCIE>;
> > >          phy-names = "pcie-phy";
> > >        };
> > >      };
> > > 
> > >      pcie_ep pcie@48400000 {
> > >        compatible = "st,stm32mp25-pcie-ep";
> > >        phys = <&combophy PHY_TYPE_PCIE>;
> > >        phy-names = "pcie-phy";
> > >      };
> > > 
> > > Simplest seems to keep the PHY required for the pcie core regardless of the
> > > mode and keep the empty root port to split the design
> > > 
> > 
> > No please. Try to do the right thing from the start itself.
> 
> Parsing the child node to clock the IP seems weird. Note that
> hisilicon,kirin-pcie.yaml also declares the PHY at the controller level.
> 

Nothing is weird here. Almost all multi port controller drivers does the same.
Most of the single port controller instances define port properties in
controller node only, but that's what we want to avoid now.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

