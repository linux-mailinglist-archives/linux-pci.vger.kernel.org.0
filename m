Return-Path: <linux-pci+bounces-18660-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 571A29F5296
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 18:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 711837A2494
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 17:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AF71DE2AC;
	Tue, 17 Dec 2024 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aAg37WfX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81371F7568
	for <linux-pci@vger.kernel.org>; Tue, 17 Dec 2024 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456045; cv=none; b=L00HP/NXFRC6fOUS3DQ5s68Hs/R5dCksMZi9+C2mpKn/c5E9/1RMG7GYejDRLlj5Gzq4e1fh+srVfibj3G0lKYcYQ173cF0vgrQMdPcoAPZyP66BUn+zljAbHgtgAMB7O3COolHXDVR2y+jKfNuYRKSW4iB+bCPngo+7UOzHHtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456045; c=relaxed/simple;
	bh=lU3v/h95t9yKq+oPE/QPiEX37Ydf45Rwlzuvm1RuHwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyUBRAL+Zj+tHKCgbhcex/Z2o1DIEU0yOGC/z1tqAxV6Ye7vX50D+0vx93T2j6JvlkA0rVR34pZtT3BLfoiq9blb9GNU2PAx3cym5RUV4ISdJ3YO5XwJfCaTllo/m7ZsEvNVhdOEgeF8u8OO/LnThZIAjNK/Bk7Y7vg4KJlMtAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aAg37WfX; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ee50ffcf14so5171091a91.0
        for <linux-pci@vger.kernel.org>; Tue, 17 Dec 2024 09:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734456043; x=1735060843; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=97u39/mB75Gyvq3MUoP9A6BWuOZp1jV8oYjBZnf5YHs=;
        b=aAg37WfXAKzH8J0gBo8+CmgbMQfNxTmLmgza8p7mM/WtKG4Udas38fPEtaCtY+COQ8
         WREMrEuUdRJIWM3Ymd0PILouuqEj3uWXJ2ZM+GVrRzxOp3nmuymm1rGPfnU7ZCmztpsK
         meVDvwXNmC6zdP1JJmkWIBpZvYmnFZ4FllTZid26VQpo5MC9INOj2k2jy56KfJXGIVNW
         vpvVOGsmL235elLgXzSlNW1tfiW0d+BDwkPqXiSBGjcC33iMaJ+FuaUJ73055VvY0dcL
         jowC5Fux9CdlXCmwEoyte6FMWxN7hArG0OBMzqpv1YmTObDdrzJjn1d73Cp+tc4RvTwY
         y0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734456043; x=1735060843;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=97u39/mB75Gyvq3MUoP9A6BWuOZp1jV8oYjBZnf5YHs=;
        b=Scrn12QVJQJh+Ai+8mUc8R5C0sFPFSCjDTIG3bo0Hqoku1iPJDriqtpoxgbxsc208I
         T4IsGv2zuSRCa4rTRkaiy5C/r0pnpt377XnV9OaJnY30bpthoVIU0uyBNtnblSNo9dk/
         w4sPhWfIxls+hxafD1P+x0lqlewzAjAzfeXIO70cQxf/1dcb3Hj6Wmkks9l2YixK+fBM
         XyYrIAIgQwDjNhUIDljQMCbLUXKgG0bho9VpKWDC8IsZq3vt0qIro6ZlO3avuhFiaMjs
         jA4+ncHpTWwzdN9ITPyBvP7TAmkZKmPlajNtYFKN/rNb2WGnNhTyKbMZod6EcXxCdllY
         pRFQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6es58hVDc03q9Gx1tisHYxXuvBw/MRIB2b9EzZhPbT7fsMLxcdjZtsDYbgcCk0qlKpWRU0807GIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlU/prHZeQZlyi3sp8t8yr+ibyAcrbjCHDFq1+F7gzhm9j1Whu
	Ny4h7qwxIDJMDrOOYZh9Ak7gZCkUElHw/cIv7jjmVw/yBS/sQcg03rkrnA6cTw==
X-Gm-Gg: ASbGncsltSJhyCr1/cnWvqSBp5/tv8IcjiZ2bJtP1TYWsKBensJmGWAK2wbJy20BAgR
	RitaMSgmFYzNsLNYB8hVpzKrEjY6fdKmd7xgtXp+7/Is9gfDnOKFFz5iwHr2liElGafgXddlGxj
	cJ1JF5xPfyP4UaHNY05docSUwAL1Tru+m++YAtqKGzevl458rv72fXGnw1+5/jXcl1ISb7M00F9
	2bY3jbzGhnPqCTCD8xEHaqPNiiMD3f3JfOS/CQMbPJZNktDcMcSrJqDyzjS+PlpifHD
X-Google-Smtp-Source: AGHT+IGjUccenohiYb+SDkdAmpf0k5ZpdC9204RkXFZyFmXwB9GNV/fs0d/6P1jKINhalSCuMQyisw==
X-Received: by 2002:a17:90b:2750:b0:2ee:7504:bb3d with SMTP id 98e67ed59e1d1-2f2d867445amr6395058a91.0.1734456043265;
        Tue, 17 Dec 2024 09:20:43 -0800 (PST)
Received: from thinkpad ([117.193.214.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2a2434a7bsm6848964a91.36.2024.12.17.09.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 09:20:42 -0800 (PST)
Date: Tue, 17 Dec 2024 22:50:33 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Christian Bruel <christian.bruel@foss.st.com>,
	Rob Herring <robh+dt@kernel.org>, lpieralisi@kernel.org,
	kw@linux.com, bhelgaas@google.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, p.zabel@pengutronix.de,
	cassel@kernel.org, quic_schintav@quicinc.com,
	fabrice.gasnier@foss.st.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: PCI: Add STM32MP25 PCIe root complex
 bindings
Message-ID: <20241217172033.zxl4bufakzx7eww5@thinkpad>
References: <20241126155119.1574564-2-christian.bruel@foss.st.com>
 <20241203222515.GA2967814@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241203222515.GA2967814@bhelgaas>

On Tue, Dec 03, 2024 at 04:25:15PM -0600, Bjorn Helgaas wrote:
> On Tue, Nov 26, 2024 at 04:51:15PM +0100, Christian Bruel wrote:
> > Document the bindings for STM32MP25 PCIe Controller configured in
> > root complex mode.
> > 
> > Supports 4 legacy interrupts and MSI interrupts from the ARM
> > GICv2m controller.
> 
> s/legacy/INTx/
> 
> > STM32 PCIe may be in a power domain which is the case for the STM32MP25
> > based boards.
> > 
> > Supports wake# from wake-gpios
> 
> s/wake#/WAKE#/
> 
> > +  wake-gpios:
> > +    description: GPIO controlled connection to WAKE# input signal
> 
> I'm not a hardware guy, but this sounds like a GPIO that *reads*
> WAKE#, not controls it.
> 
> > +    pcie@48400000 {
> > +        compatible = "st,stm32mp25-pcie-rc";
> > +        device_type = "pci";
> > +        num-lanes = <1>;
> 
> num-lanes applies to a Root Port, not to a Root Complex.  I know most
> bindings conflate Root Ports with the Root Complex, maybe because many
> of these controllers only support a single Root Port?
> 
> But are we ever going to separate these out?  I assume someday
> controllers will support multiple Root Ports and/or additional devices
> on the root bus, like RCiEPs, RCECs, etc., and we'll need per-RP phys,
> max-link-speed, num-lanes, reset-gpios, etc.
> 
> Seems like it would be to our benefit to split out the Root Ports when
> we can, even if the current hardware only supports one, so we can
> start untangling the code and data structures.
> 

+1 for moving the properties to RP node where they should belong to. The
controller driver might have to do some extra work to parse the RP node and get
these properties, but it is worth the effort.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

