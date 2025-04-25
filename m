Return-Path: <linux-pci+bounces-26763-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3F7A9CCBC
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 17:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508655A017B
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 15:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D70285412;
	Fri, 25 Apr 2025 15:18:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAC92853F3;
	Fri, 25 Apr 2025 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745594299; cv=none; b=Nqh7QggKN4QwY0QcwkjIISGSILGt+WjnbX7NMgO7yNjDzKzZvTHLtI5lV6TYWrpIJO2xBFeTeG4Vep1Syyuh6YIY64ut0J55gmBtoe3o8p0mYz9rXRg5otpJLEah01wi7QUKerE1fTpUnJMyjFy4Ou20452gbPhUSpq5rTP/MWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745594299; c=relaxed/simple;
	bh=FvN9HXG5+5Rpjeqr/q4angzS0+2K431c0FIv3jfhMhs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=T6wrJMJCFTMq/XteeXjGsGlZqKbcBNIyWhtbXcShTZ0dGgVO2B/OZcEk8lr6X2SdJEM+9WKP/D9QSpdDKwMuKhVcCEz4hrVusAtlXo12bBV6bOuYiKMw3fw31c79LNsULdoz79rcde+qs2/+FA+u55nLnmOo6DGkfJLoZaJ9QuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E685106F;
	Fri, 25 Apr 2025 08:18:11 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48ED13F59E;
	Fri, 25 Apr 2025 08:18:15 -0700 (PDT)
Message-ID: <e6db6396-cb1e-4e24-8fd0-3cce388a3913@arm.com>
Date: Fri, 25 Apr 2025 16:18:13 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: arm64: juno-r2: SSD detect failed on mainline and next
From: Robin Murphy <robin.murphy@arm.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, iommu@lists.linux.dev,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Linux Regressions <regressions@lists.linux.dev>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Anders Roxell <anders.roxell@linaro.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <CA+G9fYt0F_vR-zOV4P8m4HTv6AecT-eEnrL+t5wgAaKPodi0mQ@mail.gmail.com>
 <6e0ef5cc-b692-4d39-bec4-a75c1af3f0aa@arm.com>
 <CA+G9fYs_nUN2x8fFJ0cfudHWbCOLSJK=OhEK0Efd1ifcjq_LRg@mail.gmail.com>
 <5a277d1d-c7b1-430c-a463-1e307a2823f6@arm.com>
 <03e6283e-2ef7-498c-9460-8411114711e2@arm.com>
Content-Language: en-GB
In-Reply-To: <03e6283e-2ef7-498c-9460-8411114711e2@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/04/2025 8:11 pm, Robin Murphy wrote:
[...]
> OK, I found it, but I'm still not sure what exactly to make of it - it's 
> the pci_request_acs() in of_iommu_configure(), now being called early 
> enough to actually have an effect. Booting with EDK2 already using PCI 
> prior to Linux, here's what I get for `sudo lspci -vv | grep ACSctl` 
> with 6.15-rc1:
> 
>          ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
> UpstreamFwd+ EgressCtrl- DirectTrans-
>          ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
> UpstreamFwd+ EgressCtrl- DirectTrans-
>          ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
> UpstreamFwd+ EgressCtrl- DirectTrans-
>          ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
> UpstreamFwd+ EgressCtrl- DirectTrans-
>          ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
> UpstreamFwd+ EgressCtrl- DirectTrans-
>          ACSCtl:    SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ 
> UpstreamFwd+ EgressCtrl- DirectTrans-
> 
> whereas with the 6.14 behaviour they are all '-'. I don't have a working 
> root filesystem with the U-Boot setup, but if I boot it with 
> "pci=config_acs=000000@pci:0:0" then the kernel does assign the bridge 
> windows and discover the ethernet/SATA endpoints again. I can spend some 
> time getting NFS working next week, but if you're able to get lspci 
> output off a machine in the "broken" state easily that would be handy to 
> compare.
> 
> So at this point it would seem to be something about how Linux 
> configures ACS when doing it from scratch. What I don't really know is 
> where to go from there. I do know Juno's possibly a bit odd in that the 
> switch supports ACS, but both the root port and endpoints either side of 
> it don't. Could this be tickling some subtle bug in the PCI layer, and 
> what is EDK2 doing that makes it not happen?

Just following up on where I ran out of ideas. I poked at things a 
little more, and from a process of elimination, the culprit appears to 
be is that we enable ACS source validation on the downstream port while 
its secondary bus is still 0, *then* we get to the "bridge configuration 
invalid" bit and reconfigure the bus numbers, but after that, config 
space accesses to the secondary bus still apparently fail to work as 
expected.

What's now beyond me is whether this is just an ACS quirk of this 
particular switch, and/or whether there's something we could or should 
be doing in the PCI layer.

All I can suggest a this point is that you could at least sidestep the 
problem on the LKFT boards by updating them to a less-ancient version of 
U-Boot which supports PCIe for Juno (looks like that landed in 2020.10), 
which should then configure the switch at boot such that the bus 
numbering doesn't need to change when Linux probes it - that appears to 
be the only "magic" thing that EDK2 is doing.

Thanks,
Robin.

