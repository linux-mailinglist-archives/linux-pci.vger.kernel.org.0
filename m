Return-Path: <linux-pci+bounces-16670-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D95F9C7460
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 15:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D773D2871BF
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 14:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020D5200127;
	Wed, 13 Nov 2024 14:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCJHfNIb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC3B1FCF78;
	Wed, 13 Nov 2024 14:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731508192; cv=none; b=blBVK3FOzQSaH1BEkUUO+mKz6qKmVs+7x8Kwb0oteoAjmZwBW4UVawEJmQaiyPHhtNYlex9FYXNu/UYwMko7TQa3C31NSenv1WiNRR7qvH9fyerrHZjROvi/6WDLe/dLG3cvjzyOm55dqJgwyJBYducBU5AJIZdocvdZtIuhgh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731508192; c=relaxed/simple;
	bh=1HnPuW8zkvLUT3DcdmESKxawgO3Bw//LMyl3qPeV9ms=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XdhZL+2c2aGsLl/KifqKFBzySiYsiE3Vx2cqRH3swF3MIpvwsO+oUJCkSl2ugt+uaUKEQwceOpDNOoNZJ6QbAdDV6gAUz3Uk9Hc7FFObsesNN3JyFU6Omg5CsmJYPfEdsua28Ji4lhDatuXI1gJW2kPKWChw5MIUeHtic72Qfaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCJHfNIb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425EFC4CEC3;
	Wed, 13 Nov 2024 14:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731508192;
	bh=1HnPuW8zkvLUT3DcdmESKxawgO3Bw//LMyl3qPeV9ms=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=jCJHfNIbO6RqU3lbMet0zAy/a2SKrLodTPgT3kQ2bqYff6eYN9f2i07S2sNGNW3BP
	 YpM9nWTBJ+pFmnZCfVTjnJ7f7zAC05eNRe7fHYZrzTKVIhB3W/5y7tbl2dwgtJJEn4
	 kO9UQe7ji0Aodj4z68rDdgGnP2IrcxRJGpjTzy3tkjt6b4yThnr2AKletJCEiNrUek
	 beSMyC6zuQCa49htnj7swt58BaIZCgHUUwA2sILlVWi0HxLthIpfZo8rm/q26Yfvy1
	 D6Iz6NdOitppKRzD57mP1m8fqoo64VrKz6i/GcgGPWs6qeDVbbal9YZNEgHoJ1K9Wt
	 R23IRNVw4lbIA==
Message-ID: <ed723fe1-e243-4a9e-8d1c-f29461d07cb7@kernel.org>
Date: Wed, 13 Nov 2024 23:29:48 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/14] Fix and improve the Rockchip endpoint driver
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
References: <20241017015849.190271-1-dlemoal@kernel.org>
 <117828c6-92c4-4af4-b47e-f049f9c2cb7b@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <117828c6-92c4-4af4-b47e-f049f9c2cb7b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/24 19:35, Damien Le Moal wrote:
> On 10/17/24 10:58, Damien Le Moal wrote:
>> This patch series fix the PCI address mapping handling of the Rockchip
>> PCI endpoint driver, refactor some of its code, improves link training
>> and adds handling of the PERST# signal.
>>
>> This series is organized as follows:
>>  - Patch 1 fixes the rockchip ATU programming
>>  - Patch 2, 3 and 4 introduce small code improvments
>>  - Patch 5 implements the .align_addr() operation to make the RK3399
>>    endpoint controller driver fully functional with the new
>>    pci_epc_mem_map() function
>>  - Patch 6 uses the new align_addr operation function to fix the ATU
>>    programming for MSI IRQ data mapping
>>  - Patch 7, 8, 9 and 10 refactor the driver code to make it more
>>    readable
>>  - Patch 11 introduces the .stop() endpoint controller operation to
>>    correctly disable the endpopint controller after use
>>  - Patch 12 improves link training
>>  - Patch 13 implements handling of the #PERST signal
>>  - Patch 14 adds a DT overlay file to enable EP mode and define the
>>    PERST# GPIO (reset-gpios) property.
>>
>> These patches were tested using a Pine Rockpro64 board used as an
>> endpoint with the test endpoint function driver and a prototype nvme
>> endpoint function driver.
> 
> Ping ? If there are no issues, can we get this queued up ?

Mani,

Ping AGAIN !!!!

I do not see anything queued in pci/next. What is the blocker ?
These patches have been sitting on the list for nearly a month now, PLEASE DO
SOMETHING. Comment or apply, but please reply something.

> 
>>
>> Changes from v4:
>>  - Added patch 6
>>  - Added comments to patch 12 and 13 to clarify link training handling
>>    and PERST# GPIO use.
>>  - Added patch 14
>>
>> Changes from v3:
>>  - Addressed Mani's comments (see mailing list for details).
>>  - Removed old patch 11 (dt-binding changes) and instead use in patch 12
>>    the already defined reset_gpios property.
>>  - Added patch 6
>>  - Added review tags
>>
>> Changes from v2:
>>  - Split the patch series
>>  - Corrected patch 11 to add the missing "maxItem"
>>
>> Changes from v1:
>>  - Changed pci_epc_check_func() to pci_epc_function_is_valid() in patch
>>    1.
>>  - Removed patch "PCI: endpoint: Improve pci_epc_mem_alloc_addr()"
>>    (former patch 2 of v1)
>>  - Various typos cleanups all over. Also fixed some blank space
>>    indentation.
>>  - Added review tags
>>
>> Damien Le Moal (14):
>>   PCI: rockchip-ep: Fix address translation unit programming
>>   PCI: rockchip-ep: Use a macro to define EP controller .align feature
>>   PCI: rockchip-ep: Improve rockchip_pcie_ep_unmap_addr()
>>   PCI: rockchip-ep: Improve rockchip_pcie_ep_map_addr()
>>   PCI: rockchip-ep: Implement the pci_epc_ops::align_addr() operation
>>   PCI: rockchip-ep: Fix MSI IRQ data mapping
>>   PCI: rockchip-ep: Rename rockchip_pcie_parse_ep_dt()
>>   PCI: rockchip-ep: Refactor rockchip_pcie_ep_probe() memory allocations
>>   PCI: rockchip-ep: Refactor rockchip_pcie_ep_probe() MSI-X hiding
>>   PCI: rockchip-ep: Refactor endpoint link training enable
>>   PCI: rockship-ep: Implement the pci_epc_ops::stop_link() operation
>>   PCI: rockchip-ep: Improve link training
>>   PCI: rockchip-ep: Handle PERST# signal in endpoint mode
>>   arm64: dts: rockchip: Add rockpro64 overlay for PCIe endpoint mode
>>
>>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>>  .../rockchip/rk3399-rockpro64-pcie-ep.dtso    |  20 +
>>  drivers/pci/controller/pcie-rockchip-ep.c     | 432 ++++++++++++++----
>>  drivers/pci/controller/pcie-rockchip-host.c   |   4 +-
>>  drivers/pci/controller/pcie-rockchip.c        |  21 +-
>>  drivers/pci/controller/pcie-rockchip.h        |  24 +-
>>  6 files changed, 406 insertions(+), 96 deletions(-)
>>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rockpro64-pcie-ep.dtso
>>
> 
> 


-- 
Damien Le Moal
Western Digital Research

