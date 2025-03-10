Return-Path: <linux-pci+bounces-23319-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D3EA596A9
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 14:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60E6B1683D9
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 13:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0125822ACFB;
	Mon, 10 Mar 2025 13:49:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B41B22ACD4;
	Mon, 10 Mar 2025 13:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741614559; cv=none; b=sihKpmNwreD5MqNjsx/brM9D2kQr6Gw0eoD6PcMOuFXrQMsdJ5BRXQBYuIwgWA9erkqvd4WWFVu0mOxOt2GhPS43LWgU34I94hP+A+kpcLiozP1kmAwNuQuGn6MIYXXTfn02qgKwmYcwjlk5aVYjXoujqLVQm0wBNL2kfjs/GYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741614559; c=relaxed/simple;
	bh=xxjqROJ5NoqPCw4FvlDpsExVDNSnd34Bn+fRqX582rg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PxcGrFAxNT1b+fxbZBk4DQleCbd48EMjUmHMRMdh1GQ3b8f5vavV4tQxk2XDDsqkJnvexxUIDHFdAXBQkWHm76ktDVbiJ9949BRIqp8IqsLrgHSlnInEKbSWJlmYNwU8eSts8gLzEIx5PJBj2geHd8RZer8BJZk4SFFwePl0MFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A86C153B;
	Mon, 10 Mar 2025 06:49:29 -0700 (PDT)
Received: from [10.57.39.174] (unknown [10.57.39.174])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 749533F673;
	Mon, 10 Mar 2025 06:49:15 -0700 (PDT)
Message-ID: <ef8dcf7a-34ed-4b27-a154-e01bc167d4e6@arm.com>
Date: Mon, 10 Mar 2025 13:49:13 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] staging: Add driver to communicate with the T2
 Security Chip
To: Aditya Garg <gargaditya08@live.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
Cc: "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Aun-Ali Zaidi <admin@kodeit.net>, "paul@mrarm.io" <paul@mrarm.io>,
 Orlando Chamberlain <orlandoch.dev@gmail.com>
References: <1A12CB39-B4FD-4859-9CD7-115314D97C75@live.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <1A12CB39-B4FD-4859-9CD7-115314D97C75@live.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-03-09 8:40 am, Aditya Garg wrote:
> From: Paul Pawlowski <paul@mrarm.io>
> 
> This patch adds a driver named apple-bce, to add support for the T2
> Security Chip found on certain Macs.
> 
> The driver has 3 main components:
> 
> BCE (Buffer Copy Engine) - this is what the files in the root directory
> are for. This estabilishes a basic communication channel with the T2.
> VHCI and Audio both require this component.
> 
> VHCI - this is a virtual USB host controller; keyboard, mouse and
> other system components are provided by this component (other
> drivers use this host controller to provide more functionality).
> 
> Audio - a driver for the T2 audio interface, currently only audio
> output is supported.
> 
> Currently, suspend and resume for VHCI is broken after a firmware
> update in iBridge since macOS Sonoma.
> 
> Signed-off-by: Paul Pawlowski <paul@mrarm.io>
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
> drivers/staging/Kconfig                       |   2 +
> drivers/staging/Makefile                      |   1 +
> drivers/staging/apple-bce/Kconfig             |  18 +
> drivers/staging/apple-bce/Makefile            |  28 +
> drivers/staging/apple-bce/apple_bce.c         | 448 ++++++++++
> drivers/staging/apple-bce/apple_bce.h         |  44 +
> drivers/staging/apple-bce/audio/audio.c       | 714 ++++++++++++++++
> drivers/staging/apple-bce/audio/audio.h       | 128 +++
> drivers/staging/apple-bce/audio/description.h |  45 ++
> drivers/staging/apple-bce/audio/pcm.c         | 311 +++++++
> drivers/staging/apple-bce/audio/pcm.h         |  19 +
> drivers/staging/apple-bce/audio/protocol.c    | 350 ++++++++
> drivers/staging/apple-bce/audio/protocol.h    | 148 ++++
> .../staging/apple-bce/audio/protocol_bce.c    | 229 ++++++
> .../staging/apple-bce/audio/protocol_bce.h    |  75 ++
> drivers/staging/apple-bce/mailbox.c           | 154 ++++
> drivers/staging/apple-bce/mailbox.h           |  56 ++
> drivers/staging/apple-bce/queue.c             | 393 +++++++++
> drivers/staging/apple-bce/queue.h             | 180 +++++
> drivers/staging/apple-bce/queue_dma.c         | 223 +++++
> drivers/staging/apple-bce/queue_dma.h         |  53 ++
> drivers/staging/apple-bce/vhci/command.h      | 207 +++++
> drivers/staging/apple-bce/vhci/queue.c        | 271 +++++++
> drivers/staging/apple-bce/vhci/queue.h        |  79 ++
> drivers/staging/apple-bce/vhci/transfer.c     | 664 +++++++++++++++
> drivers/staging/apple-bce/vhci/transfer.h     |  76 ++
> drivers/staging/apple-bce/vhci/vhci.c         | 764 ++++++++++++++++++
> drivers/staging/apple-bce/vhci/vhci.h         |  55 ++
> 28 files changed, 5735 insertions(+)

I'm slightly puzzled why this was sent to the IOMMU maintainers when it 
doesn't touch any IOMMU code, nor even contain any reference to the 
IOMMU API at all...

Since I don't know enough about audio or USB code, all I can really say 
here is to echo Greg's comment that, judging by that diffstat alone, 
this probably wants to be at least 3-5 separate patches, adding each 
functional piece in manageable chunks.

Thanks,
Robin.

