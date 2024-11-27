Return-Path: <linux-pci+bounces-17410-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFE09DA6EA
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 12:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61A36281706
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 11:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E121F8EE2;
	Wed, 27 Nov 2024 11:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFIWeZ03"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17AB1F8EE1
	for <linux-pci@vger.kernel.org>; Wed, 27 Nov 2024 11:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732707611; cv=none; b=OsDrB9EF/tvgRvhL3vGXjpfMLywkdhO3iMLYe91m9SHA/KBIgGHDufmOjR8pGHrDsuB2vMyhb5EcxZN5bE+CNQUJ34aMPG9uUi6BmiRb6+LazOVk1xU3+O6FV6P4pP0T0PpFB3a8wyTn9iyzdv2u8eFuvIpOT5H0w0zvv1MivAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732707611; c=relaxed/simple;
	bh=dPEMETFQcfRbRNL03Jy3rNGPSUKAv5yzuB3LFpDxkfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qn39aWf4+hC3zE1Mi2IY/c4GuAa9A+YQZHb0T7Trq7SWIbmLEQggAjgSYp5ATAjlv5DEOhMXshloPELVfuSm2Gd1B0wA/kWoBQpFDW84NNy9QXBtkCwlkfNC6Il39uniuEGqwMLUl9rIz41S/eFp22WTy4R9ZZrDAnHpHFpu7wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFIWeZ03; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8961C4CECC;
	Wed, 27 Nov 2024 11:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732707610;
	bh=dPEMETFQcfRbRNL03Jy3rNGPSUKAv5yzuB3LFpDxkfU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oFIWeZ03lLoiQE+IB2kW6F/ugpv1+7Ksuw0RQLKmjayA4ktfmjEokOgUhXkhnoafR
	 LRGiJWJwLoOJLli2DlDMkt9eTxTfGwCmg4GZIqYcSXIe03G8UC4XXXlp/ZAGQjbqGe
	 ekUMxBG1YkFIaQ/zZRMrrULr7RzeQ4/fVsi3GnPYSV+l3xVwEPSyWh5B6AVxppPQP0
	 ycoqraAsGtgexYlkW0cdrDhp5RcyVlSUUOKH9lbzrkFndhA83YChe0eBwKsKsczA2v
	 VvkmVI4RhPmNfA0np2AMyuPwWsuK5uCKlS58e5JfZvnZQf+mnIHcVLzYY6fo612iVA
	 3P00kT/mWmdcw==
Message-ID: <2633ef1d-8651-4f03-844f-7e8cf8099e30@kernel.org>
Date: Wed, 27 Nov 2024 20:40:08 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] PCI endpoint test: Add support for capabilities
To: Niklas Cassel <cassel@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, linux-pci@vger.kernel.org,
 Frank Li <Frank.Li@nxp.com>
References: <20241121152318.2888179-4-cassel@kernel.org>
 <20241126132020.efpyad6ldvvwfaki@thinkpad> <Z0cBFjK1WgSmg6k5@ryzen>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <Z0cBFjK1WgSmg6k5@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/27/24 20:23, Niklas Cassel wrote:

[...]

> IMO, an EPF driver should be able to write to any PCI address.
> (Especially since this can be solved trivially by EPF drivers simply using
> pci_epc_mem_map()/unmap())
> 
> E.g. the upcoming NVMe EPF driver uses the NVMe host side driver.
> This host side driver does no magic padding on host side for endpoints
> (NVMe controllers) that have an iATU with outbound address alignment
> restriction.

Not to mention that per NVMe specs, there should be no alignment constraints for
IO buffers. Anything is OK. And you can see it running this EPF driver while
going through a host boot sequence and using nvme-cli: the BIOS probing the NVMe
drive, GRUB looking at the NVMe drive and nvme-cli using on-stack buffers result
is high randomness of the buffer alignments. Trying to get that to work in all
cases led to the pci_epc_mem_map()/unmap() API :)

So having the test EPF driver allowing testing such unaligned pattern would
definitely help solidify the endpoint framework and its endpoint controller drivers.

> Imagine e.g. another EPF driver, for another existing protocol, e.g. AHCI.
> Modifying existing generic Linux drivers (e.g. the AHCI driver), simply because
> some random EPC driver has a specific outbound alignment requirement (that can
> simply be ignored by using pci_epc_mem_map/unmap()) does not make sense IMO.
> 
> 
>>
>> That being said, I really like to get rid of the hardcoded
>> 'pci_endpoint_test_data::alignment' field and make the driver learn about it
>> dynamically. I'm just thinking out loud here.
> 
> That would certainly be possible, by simply dedicating a new register to that
> in the test BAR (struct pci_epf_test_reg). However, I think that that would be
> a worse alternative compared to what this series is proposing.
> 
> The only ugliness in my opinion is that we are setting the CAP_UNALIGNED_ACCESS
> capability based on if an EPC driver has implemented the .align_addr callback.
> 
> If we could simply implement .align_addr() in the two missing EPC drivers:
> drivers/pci/controller/cadence/pcie-cadence-ep.c

At least for this one, it is likely exactly the same as for
drivers/pci/controller/pcie-rockchip-ep.c. The code for these 2 drivers is
suspiciously similar, which strongly hints at the fact that the HW is most
likely based on the same IP blocks.

> drivers/pci/controller/pcie-rcar-ep.c
> 
> pci-epf-test.c could set the CAP_UNALIGNED_ACCESS capability unconditionally.
> 
> However, I do not have the hardware for those two drivers, so I cannot
> implement .align_addr() for those myself.
> 
> So in order to be able to move forward, I think that simply letting
> pci-epf-test.c check if the EPC driver which is currently in use has
> implemented the .align_addr callback, is a tolerable ugliness.
> 
> Once all EPC drivers have implemented .align_addr(), we could change
> pci-epf-test.c to unconditionally set the CAP_UNALIGNED_ACCESS capability.
> 
> 
> Kind regards,
> Niklas


-- 
Damien Le Moal
Western Digital Research

