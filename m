Return-Path: <linux-pci+bounces-14962-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F05DC9A95B5
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 03:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89A27B20D26
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 01:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD0248CFC;
	Tue, 22 Oct 2024 01:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vR7gQ40+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0B617993
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 01:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729561917; cv=none; b=PTsYDkfB3voXxg+hO67k7FAnj+093kFgGRH08HwL/6xFp0ZJw8LTnb55mgoLzyX0cXND/6LeO619QPbBnuVesSxg5Ddk18gSc2gQutfhkOkLOLzrYtzUHSaI6KM9kzLbsaZ2smt49wGmR3uBK+9haOckF42yGh+sB12rwnRlGW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729561917; c=relaxed/simple;
	bh=6Cojv7XUb97Rb78ATzMgGODTRH4owbqIqoONsUFqr1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K7E1+PtYn5yBgfyGBwvqq9q0/iP/BJFCIy1JWfTS9VJX0T3y6aX+bOKYPjpbpj/qfqXSenUl9l/Zb5K7Egae6ZsSHQqLu0UnF4wYFUHGUtvAntRz1pW51mYc4No2Rg01gj7g0vrz2uRzXR7vKI2miTMRaSzkIyJRrlPZwdYQXV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vR7gQ40+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABCE8C4CEC3;
	Tue, 22 Oct 2024 01:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729561916;
	bh=6Cojv7XUb97Rb78ATzMgGODTRH4owbqIqoONsUFqr1c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vR7gQ40+kPx4puvZV/C+wav0frO4zJOBuaQMtPbWuaA7/bPQqFjebkdN/ye97v02v
	 7ESqOicLahzNkQ/eUmuSXfzCnwFrxUgLeLCEn81fVhZbuXXyMC+BfU3IQHPOFK+TVJ
	 gOQYeJu5xz7Svbl4cTv6XXfOolYatNZBnTglZGZOq/ps3SnkNw5+5MdMq/KUrqyrPy
	 gT6DQPxEqz2MbYxY29PeqsnnWB9i7pGZHNPStOcLbhb281Y2HLI6UM/JGJV2n/ebrS
	 HIwfkW+UZIhILSVdABaFOGJZ95VZO2mSGUOwPdKvea8h/izzRcFPh7HQqYljXWOoO4
	 nTuzRfx5Bopxw==
Message-ID: <848f676b-afce-472e-872d-53a32af094c1@kernel.org>
Date: Tue, 22 Oct 2024 10:51:53 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] Improve PCI memory mapping API
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Jingoo Han <jingoohan1@gmail.com>,
 linux-pci@vger.kernel.org, Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
References: <20241021221956.GA851955@bhelgaas>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241021221956.GA851955@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/24 07:19, Bjorn Helgaas wrote:
> On Sat, Oct 12, 2024 at 08:32:40PM +0900, Damien Le Moal wrote:
>> This series introduces the new functions pci_epc_mem_map() and
>> pci_epc_mem_unmap() to improve handling of the PCI address mapping
>> alignment constraints of endpoint controllers in a controller
>> independent manner.
> 
> Hi Damien, I know this is obvious to everybody except me, but who uses
> this mapping?  A driver running on the endpoint that does MMIO?  DMA
> (Memory Reads or Writes that target an endpoint BAR)?  I'm still
> trying to wrap my head around the whole endpoint driver model.

The mapping API is for mmio or DMA using enpoint controller memory mapped to a
host PCI address range. It is not for BARs. BARs setup does not use the same API
and has not changed with these patches.

BARs can still be accessed on the enpoint (within the EPF driver) with regular
READ_ONCE()/WRITE_ONCE() once they are set. But any data transfer between the
PCI RC host and the EPF driver on the EP host that use mmio or DMA generic
channel (memory copy offload channel) needs the new mapping API. DMA transfers
that can be done using dedicated DMA rx/tx channels associated with the endpoint
controller do not need to use this API as the mapping to the host PCI address
space is automatically handled by the DMA driver.


-- 
Damien Le Moal
Western Digital Research

