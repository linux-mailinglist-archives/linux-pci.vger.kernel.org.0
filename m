Return-Path: <linux-pci+bounces-17078-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A32B9D2CF5
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 18:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02860B2B1C4
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 17:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759B81D0438;
	Tue, 19 Nov 2024 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DNU2Z6tp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A301CF2B6
	for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2024 17:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732035869; cv=none; b=Z7ZkrtelNGxGwqkLhYBrbAMAHWHwQl09jNTEm5wc0A0AS6TgzowPKJLEziytk3wpeFvJZAnEX1OwB1CzuXFMrkdk8z1EbAfZ64VKndF8OVpmRQ5F4c3VDVeOEk56CoqBi51+U9PwMY/76tRwETgdT16zftURGE7wJ/J1GbyvYG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732035869; c=relaxed/simple;
	bh=JLSO53zWiRurLZgkEVkHh6GEFG2ijbePpRs42IOEJIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxnBC7sYngrjpcUTIJf0Wz7URWX1LZUiCEYAjBeVz/zqdcWF0W+6RcBTUf4ZN9nIn2sybQCBLxj52E5JpxPjijxp3BaAC5Zck7F3kP4rnpBAV4TVh2GmYkloZkxmQlOzrbMk6DRxfWHEFSD5PFQG3FhcQMYrSmVFYiwhzrmTD6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DNU2Z6tp; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7f45ab88e7fso869710a12.1
        for <linux-pci@vger.kernel.org>; Tue, 19 Nov 2024 09:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732035867; x=1732640667; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M7G/ON1XPIM+nLaKFx55E9lPI7ZbdMAymv55tloDTzs=;
        b=DNU2Z6tph4gXZ6GeQs3i5WDgwQe5UABY77XB+UlSjyZ+p8pXxKIa/EBXcARqsd+lm6
         jMVef+Z7XnssZnE3n/GFgESV11awty+2Xe4NGUrVLkEjrfmJYR0SnA9AmJVtFaCwQFmg
         vi0afBbqkButXEXz5Wx3CCD29xE3pi+OT5iW7ceVS1+WoSgWeeNAKfgH4BUM94zIJQ0Y
         ErMotzHI395L8a6ZaogXuzlFBjlg8nMSIZPEZjKljd+96B6BnJroBIsBqvSRsLFOHJ6e
         A4eFBjR0KVj3C9brQKRl2ppHK0WYksUqm+AIUXA9zWmplQKpAX+aNLSAxOhGYyzR+eam
         ylyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732035867; x=1732640667;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M7G/ON1XPIM+nLaKFx55E9lPI7ZbdMAymv55tloDTzs=;
        b=hTUAUGEI9osdXlp2w06hT8/Ziiurs24l6J9HirLmD4dx7ha3ZP4+m+Z8VlHkCl/6ED
         +oVkuG53NjenYHyUxmgoPKzNyqk29h9GJ1FrsBuMcJqXsbYz8fsPRSzbuzfH/v8adNHb
         rp5kYAzZ2UEZ8asSUFSDrNuVTIUEmcYg/pn40W1JJ93u+2XVC5YKkIG3zjsdcdU+XJn3
         l9QCmvH5EyTQ7cuSN7MWWva4lDKKROBiZiW7WmDtBCqqsVDE1ZKpeCR2/I08//1LxEly
         SnF6zycSgY+TFSGoXnmDcpED4/E+mZJbhDwJm+KdczPAPmko48AY+Oybw4QNlF0SWVy5
         FZlw==
X-Forwarded-Encrypted: i=1; AJvYcCWjWFdo/1rrBC4yXRWwS78vZ+sYwDBjHXPnxALfHAtc0xwim+REqfWg44UMy9wnYRd2MFPvC5nbzPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY1qmXpTmscPjCWqn4/wcaoQGwToGW9PXL2jmRdbZWw6or5hu9
	HVi3R1JzJbIyEtSn0Xcldt50sDuIgo2VA/07olhATLdmqZPbvysnKBbiS9q3Zg==
X-Google-Smtp-Source: AGHT+IHKqW9avdg6R0UhtuehadqqtqXGT50NzKijPuK4my4mXXocf1FJrKvkRfDHMzoWI6jjr0c1pA==
X-Received: by 2002:a05:6a20:7491:b0:1db:f89a:c6fe with SMTP id adf61e73a8af0-1dc90bde9e5mr25294921637.32.1732035867078;
        Tue, 19 Nov 2024 09:04:27 -0800 (PST)
Received: from thinkpad ([36.255.17.169])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1dada40sm7961710a12.61.2024.11.19.09.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 09:04:26 -0800 (PST)
Date: Tue, 19 Nov 2024 22:34:21 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: snps,dw-pcie: Drop "#interrupt-cells"
 from example
Message-ID: <20241119170421.xxku2gkp3wea2xvf@thinkpad>
References: <20241105213217.442809-1-robh@kernel.org>
 <20241115072604.yre2d7yiclt5d3w5@thinkpad>
 <CAL_JsqLkVUSgL-r1YvdSOTQGeN0r4Co=NRxvX1WL6q6yt0zN6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqLkVUSgL-r1YvdSOTQGeN0r4Co=NRxvX1WL6q6yt0zN6g@mail.gmail.com>

On Fri, Nov 15, 2024 at 08:07:07AM -0600, Rob Herring wrote:
> On Fri, Nov 15, 2024 at 1:26 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Tue, Nov 05, 2024 at 03:32:16PM -0600, Rob Herring (Arm) wrote:
> > > "#interrupt-cells" is not valid without a corresponding "interrupt-map"
> > > or "interrupt-controller" property. As the example has neither, drop
> > > "#interrupt-cells". This fixes a dtc interrupt_provider warning.
> > >
> >
> > But the DWC controllers have an in-built MSI controller. Shouldn't we add
> > 'interrrupt-controller' property then?
> 
> Why? Is that needed for the MSI controller to function? I don't think so.
> 

No. I was asking from bindings perspective.

> Now we do have "interrupt-controller" present for a number of MSI
> providers. I suspect that's there to get OF_DECLARE to work, but I
> doubt we really need MSI controllers initialized early.
> 

Again no, for this case. I was under the assumption that all interrupt
providers should have the 'interrupt-controller' property in their nodes.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

