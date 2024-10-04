Return-Path: <linux-pci+bounces-13825-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 570129904C2
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 15:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1910728441A
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 13:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D656121019A;
	Fri,  4 Oct 2024 13:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZscyMAmG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BD1210193
	for <linux-pci@vger.kernel.org>; Fri,  4 Oct 2024 13:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728049624; cv=none; b=kUBJNTWI0TNppC6Eju8UwtIP6PjK/VpKt8Q9ns054FSxj8b9wZSqtv0wKzI9zHBg04l7a1SwozHf2fLNhnEtEpImx2xnfDv9/A1oCwpJXwnrfF9POOXn13UA0A9NsyyUxZeKwQmCyKU7bV+oa61QR/Q3DWQxBN/d7ukiErplRH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728049624; c=relaxed/simple;
	bh=VplJpafPH/rPQd0E2m+Ybci3LwtVWtOZW7o7TcuIwxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TDjagwrhDX+8R1yA4aojJcNyCceYHk9pw1kTXhgviFpMeUT2FsAEYNakCjxhsFwbcRfApsO9VNT1Mc8qGf3Y/SpiPNc6iknw4D0Q5iHORS9J9DSIrPp7Tc2aVS5qUs2nFp0MFFjvBHrbhlI0/offdc/4hl6cV677te5NW1NwudI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZscyMAmG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65F6C4CEC6;
	Fri,  4 Oct 2024 13:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728049624;
	bh=VplJpafPH/rPQd0E2m+Ybci3LwtVWtOZW7o7TcuIwxw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZscyMAmG/12eh3ciPBRklyZtffo/yFOg8wK61pq7HMV9B6OClaHuF4LXCLj45W5gn
	 p/w3SHzj9v7AJmQQVoALblCjVFENdlipiS8LxTsq5dgbUPVQooY+NUasYq8K+Jz51i
	 64B8jSDokQxB0FnloE4Uoa6oSV9talVk+ZLVe/qKW9DadufZh2cBuTANwH42VGm0ln
	 xiou2xQ6+Cbuku2HjwVZSc5C3Gh34fyr3cKFEAM3u7MXGeXD4USSs65f3I+e7F6jmu
	 gpq5Sv8ES0zXQCl76+2coZZq38vz7/3oE/U35cVsd61vPmenECGZ0N1Lazy6Xn7frU
	 0yU3zAMbXfYgA==
Message-ID: <a3c93ede-adc8-4f4d-9da1-da8241ddeffc@kernel.org>
Date: Fri, 4 Oct 2024 22:47:01 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] PCI: endpoint: test: Use pci_epc_mem_map/unmap()
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Jingoo Han <jingoohan1@gmail.com>,
 linux-pci@vger.kernel.org, Rick Wertenbroek <rick.wertenbroek@gmail.com>
References: <20241004050742.140664-1-dlemoal@kernel.org>
 <20241004050742.140664-7-dlemoal@kernel.org> <Zv_bdtrQFSDulOkA@ryzen.lan>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <Zv_bdtrQFSDulOkA@ryzen.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/4/24 21:11, Niklas Cassel wrote:
> You are introducing an API where we need to do a while() loop around all
> pci_epc_mem_map calls, because the API allows you to return a
> map->pci_size that is smaller than the requested size.

Yes.

> What I don't understand is that the only driver that implements this API
> is DWC PCIe EP, and that function currently never returns a map->pci_size
> smaller than requested, so from just looking at this series by itself,
> this API seems way too complicated for the only single implementer.
> 
> I think that you need to also include the patch that implements map_align()
> for rk3399 in this series (without any other rk3399 patches), such that the
> API actually makes sense.

This is coming in a followup series. Note that the Cadence controller also look
suspiciously similar to the rk3399, so it may need the same treatment. As for
the need for the loop, let's not kid ourselves here: it was already needed
because some controllers have limited window sizes and do not allow allocating
large chunks of memory to map. That was never handled...

I consider this loop the least of our problems with the epc API. This series
fixes one issue (transparent handling of alignment), but does not address the
fact that there is absolutely NOTHING that allows an epf driver to manage the
number of mappings that can be done simultaneously. That is, if the epf driver
does not in purpose serialize things to minimize the number of mappings used, it
will get errors.

And coming from block layer where large request splitting is normal, I really do
not have any problem with handling large things in smaller chunks with a loop :)

> Because without that patch, the API seems to be way more complicated than
> it needs to be.
> 
> 
> 
> With this new API, it is a bit unfortunate that all EPF drivers will now
> need do a while() loop around their map() calls, just because of rk3399.

As I said, the Cadence controller likely needs the same treatment as well. But I
do not have that hardware and specs to check that.

> The current map functions already return an -EINVAL if you try to map
> something that is larger than the window size. Isn't the problem for rk3399
> that the window size is just 1 MB. Can't you simply return -EINVAL if the
> allocation (including the extra bytes needed for alignment) exceeds 1 MB?

Sure. But then the epf will still need to loop using smaller mappings to get
work done. So at least this API simplifies that task.

> By default, pcitest.sh uses these sizes for read write transfers:
> 
> echo "Read Tests"
> echo
> 
> pcitest -r -s 1
> pcitest -r -s 1024
> pcitest -r -s 1025
> pcitest -r -s 1024000
> pcitest -r -s 1024001
> echo
> 
> echo "Write Tests"
> echo
> 
> pcitest -w -s 1
> pcitest -w -s 1024
> pcitest -w -s 1025
> pcitest -w -s 1024000
> pcitest -w -s 1024001
> 
> All that should be way smaller than 1 MB, including alignment.
> Specifying something larger will (for many platforms) fail.

To improve the test, we can add larger sizes. However, we should do that only
when all controllers have been audited and eventually modified to have a
.map_align() (or not if not needed) operation. Given the alignment use in the
test function driver, I suspect that all ep controllers need a .map_align()
operation.

> I understand that certain EPF drivers will need to map buffers larger
> than that. But perhaps we can keep pci-epf-test.c simple, and introduce
> the more complex logic in EPF drivers that actually need it?

But then it would not be much of test driver... We need to exercise corner cases
as well.

> E.g. introduce a PCI EP API, e.g. pci_epc_max_mapping_for_address(),
> that given a PCI address, returns the largest buffer the EPC can map.

That is what pci_epc_map_align() tells you... You are only changing the name.

> Simple drivers like pci-epf-test can then choose to only support the simple
> case (no looping case), and return error (e.g. -EINVAL) for buffers larger
> than pci_epc_max_mapping_for_address().

I really do not see any issue with that loop...

> More complicated EPF drivers can then choose if they want to support only
> the simple case (no looping case), but can also choose to support buffers
> larger than pci_epc_max_mapping_for_address(), using looping (I assume that
> each loop iteration will be able to map (at least) the same amount as the
> first loop iteration).

How can they "choose" if the controller being used gives you a max mapping size
that completely depend on the PCI address used by the RC ? Unless the protocol
used by that function driver imposes constraint on the host on buffer alignment,
the epf cannot choose anything here. E.g. NVMe epf needs to be able to handle
anything.

> The looping case and the non-looping case can even be implemented in their
> separate function.
> 
> I personally, think that there is value in keeping pci-epf-test.c as simple
> as possible, so that people can get familiar with the PCI endpoint framework.
> More complicated logic can be found in other EPF drivers, e.g. pci-epf-ntb.c
> and pci-epf-vntb.c.
> 
> Thoughts?

The loop is really simple. It is clear that it iterates over the buffer to
process until it is fully accessed. I really do not see the problem. EPC/EPF
stuff in itself is nor simle at all already. The map_align API and the potential
for needing a loop to process PCI transfers does not make it more complicated
than it already is in my opinion.

> If we implement pci_epc_max_mapping_for_address(), and then the looping and
> non-looping case in separate functions, perhaps we could even implement it
> in pci-epf-test.c, as having more functions will help with the readability,
> but with the patch as it looks right, I do feel like the readability gets
> quite worse.

If you really insist, then I will drop this patch, but then the test driver will
not be of much a test at all... The nice thing about this patch is that it
provides a *simple* example of how to handle PCI transfers using mmio or DMA,
and in chunks based on the PCI address alignment. That is something that all epf
drivers will do and that devleopers of epf drivers will be happy to see.

-- 
Damien Le Moal
Western Digital Research

