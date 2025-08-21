Return-Path: <linux-pci+bounces-34468-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3FEB2FE54
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 17:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 615D36870C4
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 15:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E142270ED7;
	Thu, 21 Aug 2025 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dDcO1J2S"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF6A270EAB
	for <linux-pci@vger.kernel.org>; Thu, 21 Aug 2025 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789617; cv=none; b=SSXfQzN3q5thRYkUtl3gsIPoAnYI0LXtdSmKvmTuyg5dr+1VWUoRVdaNh5FJora1g/U5KIemLoZrgYDUbtxOn3tBTJwDvgQb38hpKNszYEuykgPYnZJyX+zLIakh3qpvQRuIwftrOZjq/Mwksoz3R8OU/JDAQMptvMWoi+LgM/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789617; c=relaxed/simple;
	bh=F/EjgN8PLsBzT6JEQmm+8aj3BN2j2mJJkwSmhkAXh0I=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=meXSISGT++Ih18/BtifnZ7Ji9EyAQFg1AQFUf3WHJ7VPQIXuVl/uQZe4g9dYaSFGgjSxLkUyKgv+Ka4gKAFMR5i0Suoa+3L0t24t1tlAm+AcfGAlSyyb2Wr6naQVto38h9u63RmqfG+IJBRujdWrWuMgTDDJOa6HYt6RgZsSqeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dDcO1J2S; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-3b9e411c820so738610f8f.1
        for <linux-pci@vger.kernel.org>; Thu, 21 Aug 2025 08:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755789613; x=1756394413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xNeH8jwIaMIahWPVnKl5loQQejVbwxs7rBb60S32DBI=;
        b=dDcO1J2Sw9jvCB6JCNEkNmbqBmhGzvnkmZi2po8Yyp7odu3Wvb39Oh7V5Q9nVPVBa8
         OMDf21pkw+c6hIBWwnzgAubteTV8449tt+wSXY84hzK57qhMz5aWDuURuJfdCOODKbmr
         jB/wtQltgD4pWle0zAf+fXQQM5SmHyCckKFLeQJmHhLoi6F90wdiM0cQqczQww1TrL6n
         HRogoYhTXEs3jWXMJH10dL4xikiGzOBTbLF+bdaaUWdi3lGQqtZSOpvNTRx/dkfEQOno
         SmsykhptCJrk7813Ygs57sbu+ef+DXlTEeb5hDPTUAUwFher+CwM2l/mWiP2cpHg8jxQ
         U+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755789613; x=1756394413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNeH8jwIaMIahWPVnKl5loQQejVbwxs7rBb60S32DBI=;
        b=cyqKXbvvvhQLxnKTjOmdeMBEKexarP7XJN29DJrSzLRnUR0NoeI6i4Ba6rE0j02QLZ
         HZt2B4hlFFLan0FfV/dptCiz6e05Rjdeduanblqli3+YS0cxaGanWRqLQtmPZDSrkt87
         QliUkwE+i4HubQgDWVGb9LrpY9+f1P2mfRsHjCx1p/F4sJHc98XuO1yvampCFRVN0L9M
         nRn5u6Hl6nv/rkWax66vw5NPh5nYXoSrBAUwkUX/8X2k3i9691tS7WA9NmfKH/FUp+1N
         bCtE/6ANRyDKEhsZlMRoKQikFi8xHZqvXI9D9DhsBf1zM2U7UE1SgV/BMSyQLm60Vms0
         +YOQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9RAXvuO6Z+qq4EAGjVlTg2Nlwe89di5o40BYpg8WuxJD4EQYUHSAuVaf3uwHCQaAPcEUEHsh49dY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiyuzLTreC5oXgu6tuUcBwHEN6aheDexNpUHD3trNd0/ALEbUS
	f2zhm6abmHMgXLTo/UXbL9KmQOlo5nIl4bczcnhhcZwKwB4s2cCbzYVxY0Fjw4772yM=
X-Gm-Gg: ASbGncvXCCADl1MAyDq9+gzdb2OBz25hCfQ5O12KRxOac7mzz2pkwKc8wZSsFuj2vNC
	+wViTruPZHSvugrrlcSbjm+ZmxyzjWVg90OQN35xxcnRfwIN5eJ17dYdpqgZ9f3cp8G1kOLA/HC
	zwbLX3AJiW09Uuc5TFJkAnv1ZnPwG63hKIZRJ/OmmNT0Dvdc/8ypRrP+K2zQt0W9X5NpAX+7Awc
	TWS+uo5/30Wo2dZkVsrynsFek9MPPCpdMQy1wn5g9hbj5Pm89j9hGahZ5F0+eu0KGhp2/jov+YR
	Aq4ODBps+o7mMh8a2Ob/Im+kMiqrbJcswUX6Lig5n8siDAu4x2A+70ZgRdNBF7o6qKUCAWyMuNT
	vq31THQPi3vWrzDsum5B9r3P03zrBQdNBbcDjLrMpSbbuOaDEpKMXs1egWP4fx9u/r9GS+QI=
X-Google-Smtp-Source: AGHT+IHDN8OczdJt+JNi7lF2guoFhCWb2f4SvtjNNXIrg4sA//TwST6NTNw7zh3uRT3ZYvRmUOk3qA==
X-Received: by 2002:a05:6000:288b:b0:3b8:893f:a17d with SMTP id ffacd0b85a97d-3c497274347mr2450727f8f.49.1755789613394;
        Thu, 21 Aug 2025 08:20:13 -0700 (PDT)
Received: from localhost (host-79-36-0-44.retail.telecomitalia.it. [79.36.0.44])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba9077520sm105918256d6.21.2025.08.21.08.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:20:12 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Thu, 21 Aug 2025 17:22:04 +0200
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
Message-ID: <aKc5nMT1xXpY03ip@apocalypse>
References: <20250812085037.13517-1-andrea.porta@suse.com>
 <4fee3870-f9d5-48e3-a5be-6df581d3e296@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fee3870-f9d5-48e3-a5be-6df581d3e296@kernel.org>

Hi Krzysztof,

On 10:55 Tue 12 Aug     , Krzysztof Kozlowski wrote:
> On 12/08/2025 10:50, Andrea della Porta wrote:
> > The devicetree compiler is complaining as follows:
> > 
> > arch/arm64/boot/dts/broadcom/rp1-nexus.dtsi:3.11-14.3: Warning (unit_address_vs_reg): /axi/pcie@1000120000/rp1_nexus: node has a reg or ranges property, but no unit name
> > /home/andrea/linux-torvalds/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb: pcie@1000120000: Unevaluated properties are not allowed ('rp1_nexus' was unexpected)
> 
> Please trim the paths.

Ack.

> 
> > 
> > Add the optional node that fix this to the DT binding.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202506041952.baJDYBT4-lkp@intel.com/
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > ---
> >  Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > index 812ef5957cfc..7d8ba920b652 100644
> > --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > @@ -126,6 +126,15 @@ required:
> >  allOf:
> >    - $ref: /schemas/pci/pci-host-bridge.yaml#
> >    - $ref: /schemas/interrupt-controller/msi-controller.yaml#
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: brcm,bcm2712-pcie
> > +    then:
> > +      properties:
> > +        rp1_nexus:
> 
> No, you cannot document post-factum... This does not follow DTS coding
> style.

I think I didn't catch what you mean here: would that mean that
we cannot resolve that warning since we cannot add anything to the
binding?

Regarding rp1_nexus, you're right I guess it should be
rp1-nexus as per DTS coding style.

> 
> Also:
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

In this case it could be difficult: we need to search for a DT node
starting from the DT root and using generic names like pci@0,0 or
dev@0,0 could possibly led to conflicts with other peripherals.
That's why I chose a specific name.

Many thanks,
Andrea

> 
> ... and nodes should be anyway defined in top-level and only customized
> per variant. I am surprised that DTS patch carries a reviewed tag,
> because it was never checked/tested :/
> 
> > +          $ref: /schemas/misc/pci1de4,1.yaml
> >    - if:
> >        properties:
> >          compatible:
> 
> 
> Best regards,
> Krzysztof

