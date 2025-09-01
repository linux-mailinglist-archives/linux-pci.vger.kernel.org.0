Return-Path: <linux-pci+bounces-35244-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497D9B3DCF3
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 10:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 054AE3B9D00
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 08:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94C12FE04C;
	Mon,  1 Sep 2025 08:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gOXNZahq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24222FB99B
	for <linux-pci@vger.kernel.org>; Mon,  1 Sep 2025 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756716494; cv=none; b=n7w2wJCxyGRoyKC5IgPIQrSZZZCj4D2vLoAwKD18z6F25N6Zszr5bNjd3ULe3ipT+4yzso9Gwzb0BHp8Jl5833vPgGsIIxh18Wii++yydY0AYk3frgsb+2UHvbeANLK2UkzA9y7lHPEFSMdHIE9/LCQ5igS6NkFqY3ngiZB5i9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756716494; c=relaxed/simple;
	bh=neeT00/mxDswioH9iJwGYH9YEmmlx3hZdCS21iYzw3g=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HS8mfAXPGrp2HE5k6o1WoU4BUnGNwtPF9FeVuXmrC8ZHjx11K0RuzESkiYvaR05paT/NUAs4iPBuBMyw0n30tncekaZpx5lBZsUbIrLeTYdR1+IiPSNkD+Z44rKFVP9WuCmDl7IR2NuqX+5tDPs/JCm/a7wFxBzLroFN9hZVXzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gOXNZahq; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-afeec747e60so605171966b.0
        for <linux-pci@vger.kernel.org>; Mon, 01 Sep 2025 01:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756716490; x=1757321290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cPLbjAvQn0E2rMIx0xgjNyYjUFJLwi35g9A0s0bGBYk=;
        b=gOXNZahqc4/88gy+ti8ZsBT/gDP8IScW79A02vQySTEvTkgkWhboJ0UZhgwtGhkHCS
         +WXyPOxgv629OG/nV4FVSm2s1exIb85VgKs8eVp2mFOyLlVKjSJAu0LAv/7fzRP6IP8b
         GNN0CGGM1n+gwaBUfsVoCXszehz8TgkwXUnBe0AtjCwq+yflBoI1Y6LryduMoyv3Tw6U
         lGa1JusV4S+vJOdNl43twFNhlysjC91np9qSQiMgNYBE+L2D0rM1W7okfwjpnZvDFdiK
         1BuImbzS1qJY5A3TIpRGmXtYMnebz0ZGrDzDeBOMFyO/U8S9zCol584WWBEMvVNtEhMt
         TqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756716490; x=1757321290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPLbjAvQn0E2rMIx0xgjNyYjUFJLwi35g9A0s0bGBYk=;
        b=w1Yo+skquxmBiPlamBwH6ZMmeg+Ni2n7dZNYDwRlsfn/IwR6ENxQ3y0ot0wPT8xiBP
         4yNBXvPermo3XHY/IZr49I+WQ7TqHfGKk2NqavJlT8ZHK53T3gkDFIxd1JMmLwS01LaF
         GWVzPryUEVu9Li4vE2ygGBxpr5mdsEgtoIN2pEjDW9AT9Pnu2/Al1mogestUg6UJIPfB
         PM0JcdPON/qtow4YQSxTRHba8S4Npb+KalGJM74tc3354w8/+CFhDQ/xTjmig+BjEVCf
         kQgDTQwrtYtfxbbtV06Q1wb0HzmDMRcx+Aj6UTNhPgijU7qJj5+65SSSHQK5AhSN0Z85
         Y/3g==
X-Forwarded-Encrypted: i=1; AJvYcCUDjaLshFESH6MXRCVxPRrS+CCxBQTv64yRAN5wfjdCbd2pZ2D1hvWJoMNa5nLLMW4UMUeRaxx4agk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz2b8Xc4vf0EmHIT9PD4G7Mqx1ZJXz9o3ugmV3LfhGZwpdwbjn
	R8dW+Lxv/c7kfWIh2EB0T/14OvwAW2999aX/Mp9mLQfVWFdVOjpYGO2AFBFoZecRi5E=
X-Gm-Gg: ASbGnct+iY8rmsORNh+BeWBxY6uzC4QziHETrquibVMfIuP+lPEkWf8K5Wd9Ruw+td2
	2E3Awg+e6TecXO5wEhBkZm1IYZdZvBy/CoMwvRjAaxQ93VTGHBzlguu6V/7nPK6e3CGXP6WS+ap
	Ubhj+v5GjPX9yDfn0P+nAKoR+yDjG4uFwwn5ZrSbMJBMI0XUzohinznnlOOd/+I8lsZ1y81YQE5
	VW1RRMQwqAWW97KSLetbB4qF3Eg55OntM4MBd+WZoSlQW547vawh27FACAT/OwhVPHWu67sKQpP
	EfxGp81R5Jt87hbntuH8XT5wHeokWEV/e+UVah/2GXzjT+EdNj7MdHtr/uxx4368gmPIP8b8qOz
	oWp8YHIWMe6WW2WUvIit4YLWjUFSo/3Vlav/m61qhVmvJlnnvjiPyC5Cmsv6eB44mIAAULaN0JI
	PhWTAYG+RdfWVIS0WAEmTbJvqeDOc=
X-Google-Smtp-Source: AGHT+IEQBUXzLByR1LDYkZW1JXKHq8+bGwyDWqHROpCdMH+jh7ytpsNxmNwRf7WbZfZJa0YLFDJJBA==
X-Received: by 2002:a17:906:7d9:b0:b04:1b84:923c with SMTP id a640c23a62f3a-b041b85025emr362763666b.51.1756716490047;
        Mon, 01 Sep 2025 01:48:10 -0700 (PDT)
Received: from localhost (host-79-36-0-44.retail.telecomitalia.it. [79.36.0.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b04189de5b5sm345647166b.10.2025.09.01.01.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 01:48:09 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Mon, 1 Sep 2025 10:50:05 +0200
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, kwilczynski@kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, iivanov@suse.de, svarbanov@suse.de,
	mbrugger@suse.com, Jonathan Bell <jonathan@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] dt-bindings: pci: brcmstb: Add rp1-nexus node to fix DTC
 warning
Message-ID: <aLVePQRfU4IB1zK8@apocalypse>
References: <20250812085037.13517-1-andrea.porta@suse.com>
 <4fee3870-f9d5-48e3-a5be-6df581d3e296@kernel.org>
 <aKc5nMT1xXpY03ip@apocalypse>
 <e7875f70-2b79-48e0-a63b-caf6f1fd287b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7875f70-2b79-48e0-a63b-caf6f1fd287b@kernel.org>

Hi Krzysztof,

On 08:50 Fri 22 Aug     , Krzysztof Kozlowski wrote:
> On 21/08/2025 17:22, Andrea della Porta wrote:
> > Hi Krzysztof,
> > 
> > On 10:55 Tue 12 Aug     , Krzysztof Kozlowski wrote:
> >> On 12/08/2025 10:50, Andrea della Porta wrote:
> >>> The devicetree compiler is complaining as follows:
> >>>
> >>> arch/arm64/boot/dts/broadcom/rp1-nexus.dtsi:3.11-14.3: Warning (unit_address_vs_reg): /axi/pcie@1000120000/rp1_nexus: node has a reg or ranges property, but no unit name
> >>> /home/andrea/linux-torvalds/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: pcie@1000120000: Unevaluated properties are not allowed ('rp1_nexus' was unexpected)
> >>
> >> Please trim the paths.
> > 
> > Ack.
> > 
> >>
> >>>
> >>> Add the optional node that fix this to the DT binding.
> >>>
> >>> Reported-by: kernel test robot <lkp@intel.com>
> >>> Closes: https://lore.kernel.org/oe-kbuild-all/202506041952.baJDYBT4-lkp@intel.com/
> >>> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> >>> ---
> >>>  Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 9 +++++++++
> >>>  1 file changed, 9 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> >>> index 812ef5957cfc..7d8ba920b652 100644
> >>> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> >>> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> >>> @@ -126,6 +126,15 @@ required:
> >>>  allOf:
> >>>    - $ref: /schemas/pci/pci-host-bridge.yaml#
> >>>    - $ref: /schemas/interrupt-controller/msi-controller.yaml#
> >>> +  - if:
> >>> +      properties:
> >>> +        compatible:
> >>> +          contains:
> >>> +            const: brcm,bcm2712-pcie
> >>> +    then:
> >>> +      properties:
> >>> +        rp1_nexus:
> >>
> >> No, you cannot document post-factum... This does not follow DTS coding
> >> style.
> > 
> > I think I didn't catch what you mean here: would that mean that
> > we cannot resolve that warning since we cannot add anything to the
> > binding?
> 
> I meant, you cannot use a warning from the code you recently introduced
> as a reason to use incorrect style.
> 
> Fixing warning is of course fine and correct, but for the code recently
> introduced and which bypassed ABI review it is basically like new review
> of new ABI.
> 
> This needs standard review practice, so you need to document WHY you
> need such node. Warning is not the reason here why you are doing. If
> this was part of original patchset, like it should have been, you would
> not use some imaginary warning as reason, right?
> 
> So provide reason why you need here this dedicated child, what is that
> child representing.

Ack.

> 
> Otherwise I can suggest: drop the child and DTSO, this also solves the
> warning...

This would not fix the issue: it's the non overlay that needs the specific
node. But I got the point, and we have a solution for that (see below).

> 
> > 
> > Regarding rp1_nexus, you're right I guess it should be
> > rp1-nexus as per DTS coding style.
> > 
> >>
> >> Also:
> >>
> >> Node names should be generic. See also an explanation and list of
> >> examples (not exhaustive) in DT specification:
> >> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> > 
> > In this case it could be difficult: we need to search for a DT node
> 
> Search like in driver? That's wrong, you should be searching by compatible.

Thanks for the hint. Searching by compatble is the solution.

> 
> > starting from the DT root and using generic names like pci@0,0 or
> > dev@0,0 could possibly led to conflicts with other peripherals.
> > That's why I chose a specific name.
> 
> Dunno, depends what can be there, but you do not get a specific
> (non-generic) device node name for a generic PCI device or endpoint.

I would use 'port' instead of rp1-nexus. Would it work for you?

Many thanks,
Andrea

> 
> 
> 
> Best regards,
> Krzysztof

