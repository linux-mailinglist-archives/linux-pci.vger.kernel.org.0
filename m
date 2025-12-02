Return-Path: <linux-pci+bounces-42479-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB38C9BA64
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 14:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 338074E3333
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 13:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249F630EF88;
	Tue,  2 Dec 2025 13:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCKMwPbC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3862280309;
	Tue,  2 Dec 2025 13:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764683138; cv=none; b=JZQL9kK7qoXWU2lUeFHHNSe2YyWoclXZPJcg772cmO49wz6zUtTidz+8CqTzfg1e4grsm/ONSN2DTr/Rv+VEl/8CDT7Wy7Dc0qloBXSR2cMXzqFaN0Qixbr3uhVn6+3wXr5QFDxOnRaxe+ZBpNTACgKFLoJfog2x81AaG/Docwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764683138; c=relaxed/simple;
	bh=D8cdvkqgDXZSioJ7TC3Z1nMJbtHIw0swgeRX8817ogA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeO5+wrJtJKIP3P8rTc3GUf4lFfeUbSvabV8PUw/J8VtoQ4ETyg3Oqzf+UeIp9mAAK/ic1+J8iVHEf0kOLEkkAKEUYJVPOP7m+j7Hpu/Bvckn21Xop1OUAucvkIoQw/Q8BmISd+fdUvLdiUT8dFBH0t23ZqnIAq7x/qwP27gztw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCKMwPbC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FDFC4CEF1;
	Tue,  2 Dec 2025 13:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764683137;
	bh=D8cdvkqgDXZSioJ7TC3Z1nMJbtHIw0swgeRX8817ogA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dCKMwPbChBvqqtqpF3NokvYxdaCdQA6XBybFE06bxzQYkv+X3ymsBFnOBIbacabqj
	 KNaLQsbHgNx0FuxqxBx6Ah9fbIj8BI6/fcwwxQnGhLYRkrNNXBCqJNDERfto3DvvcC
	 x/ctSi28KHixEWUtzS89tgcRYxC9FmVSbbxS2UNKfwU9/tBeU+qKvzkDs9K7l1Ncls
	 vCurMjK/BOIUW2bhiWRiunYRVmurclO6G/MZG3fWv/tSS8m812wld9JhoZX7B4Ao8t
	 rqp6qpdhosrLKg4qEIhOVnsdeTkyOp3svyXK5cCPj2+2varD+8Vr4FOzREBKzSJF4o
	 4o8/dlZjAGK3Q==
Date: Tue, 2 Dec 2025 19:15:28 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Jonathan Chocron <jonnyc@amazon.com>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v9 4/4] PCI: dwc: Support ECAM mechanism by enabling iATU
 'CFG Shift Feature'
Message-ID: <hiuivv6q6rakmkpdupuw7upx3mazzux46zvoxsontwag6xvaon@o2d2swxdtafb>
References: <alpine.DEB.2.21.2511280755440.36486@angie.orcam.me.uk>
 <cabf4c20-095b-4579-adc1-146a566b19b9@oss.qualcomm.com>
 <alpine.DEB.2.21.2511281714030.36486@angie.orcam.me.uk>
 <a4c6d47f-28b5-40d3-bc82-10aeb14f8e78@oss.qualcomm.com>
 <alpine.DEB.2.21.2511290428340.36486@angie.orcam.me.uk>
 <h7pgm3lqolm53sb4wrcpcurk4ghz4tulqnr7vgd7rzxy4hscue@jcn5tepevlwl>
 <syg7vpbt3w53s24hgl7b6w64odmif5bq557lwlvzlbvgkukwcn@66jtzzc3vtiu>
 <alpine.DEB.2.21.2512011617250.49654@angie.orcam.me.uk>
 <ps5jjiqv5mw2g3exzvfcfsa4bcda7hois2h6riarwb2d2son4u@2onu4bibw2hb>
 <alpine.DEB.2.21.2512021246470.49654@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.2512021246470.49654@angie.orcam.me.uk>

On Tue, Dec 02, 2025 at 01:39:14PM +0000, Maciej W. Rozycki wrote:
> On Tue, 2 Dec 2025, Manivannan Sadhasivam wrote:
> 
> > >  No change in behaviour, sorry.  I suppose it's this range of host address 
> > > decoding:
> > > 
> > > fu740-pcie e00000000.pcie:       IO 0x0060080000..0x006008ffff -> 0x0060080000
> > > 
> > > aka:
> > > 
> > > pci_bus 0000:00: root bus resource [io  0x0000-0xffff] (bus address [0x60080000-0x6008ffff])
> > > 
> > > that you're after.  Are you sure your code discovers it correctly?  As I 
> > > say I can only see IORESOURCE_MEM references and no IORESOURCE_IO ones as 
> > > would be appropriate for the root bus resource quoted.
> > 
> > The I/O resource is discovered by the driver correctly as seen from the logs:
> > 
> > pci_bus 0000:00: root bus resource [io  0x0000-0xffff] (bus address [0x60080000-0x6008ffff])
> > pci_bus 0000:00: root bus resource [mem 0x60090000-0x7fffffff]
> > pci_bus 0000:00: root bus resource [mem 0x2000000000-0x3fffffffff pref]
> > 
> > But we believe that the iATU is not programmed for the I/O port, resulting in
> > the I/O access not going out to the device.
> > 
> > Krishna found an issue in the previous patch that got shared. So I've attached a
> > new one. Could you please try and let us know? If it didn't help, please share
> > the dmesg log that will have some more info.
> 
>  This does work correctly, thank you; see the log diff below (I checked 
> the defxx driver separately too).

Cool! Thanks a lot for testing and sorry for the breakage once again. Btw, the
issue that was fixed in the last diff has been present for some time. It was
fortunate that you didn't hit that before.

>  Please make a proper submission and 
> I'll give it a Tested-by: tag after final verification against 6.18.
> 

Sure thing. Krishna will post the fix(es) as there are two separate issues and
will CC you.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

