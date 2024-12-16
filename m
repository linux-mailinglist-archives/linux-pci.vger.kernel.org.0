Return-Path: <linux-pci+bounces-18520-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C129F35AB
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 17:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 427077A3C18
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 16:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493212063DD;
	Mon, 16 Dec 2024 16:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EMRoHY4a"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE912063D7
	for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 16:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365830; cv=none; b=ORkouAMU/vY9DzQfh0s3FK8vPVSYymMUUzLGiuVDcdo1BzBRmH2TJPQe7leTqaoMAMIOMUTOk+w9Pr8I0nK2+nIbU0z0Wq5wBw8vfK6snsF6HjCHxYEDmIrPlZ6HRI333NEBZX1Aw4lSwoLpQ7/QxHe3O/WeaEN2idYiqWoPdZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365830; c=relaxed/simple;
	bh=t8wf47QY9cmdBo63Gv0CCceIk9iBBth3UuB3w+B9zfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=McvHSpg1oUkUgygT1+JdlaJmNblXKUFSjCQt3tP6s21iBMh0eZvUtcThnizuUSG9Z/tJHD34JJ20mTx/JImgBfPDeXGE8owIn1OLmHGvqNCEk9ivNFPnR1yvyIrsTcxacJ7/TqrULvXEJmCCYTZW9dbbzBeb8FEnbvYNSl0szcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EMRoHY4a; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7242f559a9fso5492587b3a.1
        for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 08:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734365828; x=1734970628; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=82gDKALWw0Ekg/l8MKhauenkjup0NAxqqSYjA8q5Flo=;
        b=EMRoHY4aeTjOHOR29cyv4zuei/iVpMLuYrSfQzyZclfe0NEXW6Jl504WqSbsqUx8Xy
         b5hpCSFig3u2axLHJnu20jv19Ba5IsKrNiFelE2gfHsvqnWFMCIfKTjHoeUL1sDoXVBf
         afShywFdFiEev+CQuTxTSPxzR4yQ7FYAj8XhplNN8NxqrN/qmwwHWsRAcADSZBGfOqIS
         aInMNWjkvwZy3nUUQE3lUsHkbKGjS/h8qFYE9uZuevWcof8ebNbhNCid6gc/sfq11E3I
         jnXBpewD3YJE9QsDWJ4VTiqibXrUPWCzAU6IgOpqEZjL0YX96WQgVW9u1nGUWJk3ewqz
         VUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734365828; x=1734970628;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=82gDKALWw0Ekg/l8MKhauenkjup0NAxqqSYjA8q5Flo=;
        b=Fh4XFFQiv0OQpDxLqoUNswYLyj4xxhmbYZ+mR3zeqGrXW7hL0g1P8Zo/Y5pGV58Tt0
         NWSSLXT+1WletWXADks/dW2+AyoELXEgrX4l3Xwp3Ap2dp8H06VoRI+zJVgv38Azrv7o
         nfeB9Ond6pv9vS8CxqRsUS4eTGCCmd/9IKaXuRyjckgoREwy62rYWASprEmkxceuaZXa
         qxihQJrBXaFTI7FoyzuC0PuVqqa1VEb4724gYn7piRAzV1cRhqNsV8cOIyxIOaeupXsX
         gt0Ut1LQS0yR3i1L7un6H6AIFqTcwlg/KGUge52okVNt3L9LE14BhDaBEQpB+m6Vv74P
         41LA==
X-Forwarded-Encrypted: i=1; AJvYcCUOKkcvhdnlQcDG2aE2BqX00x/4uzcWELXAv8G4tQVnSmjFddcgY+cz4Lf5d+gfACvpD8lv7YE71WI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9I8pOvrS9ZLIjD4p8WbKUHrMUIc99vLGpCM4FIFAbMhhkCHU9
	8fWa7+EAxr1nur3BJhzdECYgRPgS3F1l/YLtYxZjypXsyfSwNbfvCV02SQ7D+g==
X-Gm-Gg: ASbGncvGGEXNbYhvjZAEfzJVv9iI1LsVdZJ3fubVAftFkNPZS9tyonyqZ2peRQyDzdQ
	2APXjStwtkXH1+AbIrlUnUv8ZcxXTDcOxELoO0eH3W/XRQPqj/WQgFaVKez3GJXSEvO0p0eXcB6
	Fi+8cyled83PHUktWo+c4/SPQ/d5P5XZXe31RbcoseHfHXcuhGTSSu3z2hv8ELSOZrK9Uo+p4Wv
	ObKMXTyVBqhpdcLpTulR7hxUA5XLRm6nobNXw2A35A+/jQxokGZ/uHhnp1oJ7kmJf9a
X-Google-Smtp-Source: AGHT+IGvG6qXEoCqCkROvX+b6dhtMyqPUbkI3UVWtmJgHt1xZMsm2fyfByqDiqxFQpxzhlW12Qg/Wg==
X-Received: by 2002:a05:6a00:3688:b0:729:35b:542e with SMTP id d2e1a72fcca58-7290c25a4bcmr16844563b3a.16.1734365827870;
        Mon, 16 Dec 2024 08:17:07 -0800 (PST)
Received: from thinkpad ([120.56.200.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918bb3a6dsm4925657b3a.136.2024.12.16.08.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 08:17:07 -0800 (PST)
Date: Mon, 16 Dec 2024 21:47:00 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	p.zabel@pengutronix.de, cassel@kernel.org,
	quic_schintav@quicinc.com, fabrice.gasnier@foss.st.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] PCI: stm32: Add PCIe endpoint support for
 STM32MP25
Message-ID: <20241216161700.dtldi7fari6kafrr@thinkpad>
References: <20241126155119.1574564-1-christian.bruel@foss.st.com>
 <20241126155119.1574564-5-christian.bruel@foss.st.com>
 <20241203152230.5mdrt27u5u5ecwcz@thinkpad>
 <4e257489-4d90-4e47-a4d9-a2444627c356@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e257489-4d90-4e47-a4d9-a2444627c356@foss.st.com>

On Mon, Dec 16, 2024 at 11:02:07AM +0100, Christian Bruel wrote:
> Hi Manivanna,
> 
> On 12/3/24 16:22, Manivannan Sadhasivam wrote:
> > On Tue, Nov 26, 2024 at 04:51:18PM +0100, Christian Bruel wrote:
> > 
> > [...]
> > 
> > > +static int stm32_pcie_start_link(struct dw_pcie *pci)
> > > +{
> > > +	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
> > > +	int ret;
> > > +
> > > +	if (stm32_pcie->link_status == STM32_PCIE_EP_LINK_ENABLED) {
> > > +		dev_dbg(pci->dev, "Link is already enabled\n");
> > > +		return 0;
> > > +	}
> > > +
> > > +	ret = stm32_pcie_enable_link(pci);
> > > +	if (ret) {
> > > +		dev_err(pci->dev, "PCIe cannot establish link: %d\n", ret);
> > > +		return ret;
> > > +	}
> > 
> > How the REFCLK is supplied to the endpoint? From host or generated locally?
> 
> From Host only, we don't support the separated clock model.
> 

OK. So even without refclk you are still able to access the controller
registers? So the controller CSRs should be accessible by separate local clock I
believe.

Anyhow, please add this limitation (refclk dependency from host) in commit
message.

[...]

> > > +	ret = phy_set_mode(stm32_pcie->phy, PHY_MODE_PCIE);
> > 
> > Hmm, so PHY mode is common for both endpoint and host?
> 
> Yes it is. We need to init the phy here because it is a clock source for the
> PCIe core clk
> 

Clock source? Is it coming directly to PCIe or through RCC? There is no direct
clock representation from PHY to PCIe in DT binding.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

