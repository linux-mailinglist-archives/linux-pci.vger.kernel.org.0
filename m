Return-Path: <linux-pci+bounces-5595-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FDC896760
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 09:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F106281E4C
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 07:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E315D8E4;
	Wed,  3 Apr 2024 07:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mxf93bp6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E205A5D73D;
	Wed,  3 Apr 2024 07:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131127; cv=none; b=fSOPafJYAu62N1nxdNQERRGstpJQ3Q7ZpwpVNjDnTZ8DBtS4Wmw3i3A7zsmHGXclWQdZtb2FB8vB1KeJVz1ig/zvehodewFWdS6henXDzXKioe1c6eqJFeaGsyPrIYKfIZgDKJ4FJX/rDXqKf3NFJnHldfO+ZsnPANfyysS8I4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131127; c=relaxed/simple;
	bh=rff1smmYpqyVpVVfAiWjpMpTYNbLSpbWFwSmqO/3U4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fVWEES5J+0VzwYuP7KDqT/9IxHlxfW7gaFtOMNoTWCKdlT3U34nrIgfSpeIPKsiVfzCyOqIIEX8/8KnmmPpfHGSZLEyDUf9Swt8a7CX6thlQi0fF3389m/5U6JmRlA7Fxud/YrWdAqmucylM495hO8SIyoeQXgEeXT5GjX08foQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mxf93bp6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8A6C433F1;
	Wed,  3 Apr 2024 07:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712131126;
	bh=rff1smmYpqyVpVVfAiWjpMpTYNbLSpbWFwSmqO/3U4g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Mxf93bp6wDizDIACTo4UdoDT5pg99FD2NqYFnuCZMDNdqh6VsEeWgF+VKKwu1x43i
	 P+5tYJSLJWqv/gy7hxE/lNOQ4Suik163ZcbxSP+RBZdHCnvBxikA4xXjnb8QSt5taY
	 hkG+omhxKCxYgQrZxOWXEZ2a92soCc2fzkeX84hURgDFbHp2+qn78zUVmNmvBG32VB
	 oKJgyXLeDksYFuH71EZaIGxi5LD+bQq49jT2P3J3owdEL+h0oaXAvZXh2oiHM67OQH
	 JG1z2uIMMMtW5pHoz1BEGR3CfY2/+14nsN1ZdqW6Zk65aSOgttY35xhGInQ5L2x69Z
	 W2+sPk5raT2CQ==
Message-ID: <2cdc7045-e277-4d1f-ad7c-66e4ac819a41@kernel.org>
Date: Wed, 3 Apr 2024 16:58:42 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/18] Improve PCI memory mapping API
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>, Niklas Cassel <cassel@kernel.org>
References: <20240330041928.1555578-1-dlemoal@kernel.org>
 <20240403075034.GF25309@thinkpad>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240403075034.GF25309@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/3/24 16:50, Manivannan Sadhasivam wrote:
> On Sat, Mar 30, 2024 at 01:19:10PM +0900, Damien Le Moal wrote:
>> This series introduces the new functions pci_epc_map_align(),
>> pci_epc_mem_map() and pci_epc_mem_unmap() to improve handling of the
>> PCI address mapping alignment constraints of endpoint controllers in a
>> controller independent manner.
>>
>> The issue fixed is that the fixed alignment defined by the "align" field
>> of struct pci_epc_features assumes that the alignment of the endpoint
>> memory used to map a RC PCI address range is independent of the PCI
>> address being mapped. But that is not the case for the rk3399 SoC
>> controller: in endpoint mode, this controller uses the lower bits of the
>> local endpoint memory address as the lower bits for the PCI addresses
>> for data transfers. That is, when mapping local memory, one must take
>> into account the number of bits of the RC PCI address that change from
>> the start address of the mapping.
>>
>> To fix this, the new endpoint controller method .map_align is introduced
>> and called from pci_epc_map_align(). This method is optional and for
>> controllers that do not define it, the mapping information returned
>> is based of the fixed alignment constraint as defined by the align
>> feature.
>>
>> The functions pci_epc_mem_map() is a helper function which obtains
>> mapping information, allocates endpoint controller memory according to
>> the mapping size obtained and maps the memory. pci_epc_mem_map() unmaps
>> and frees the endpoint memory.
>>
>> This series is organized as follows:
>>  - Patch 1 tidy up the epc core code
>>  - Patch 2 and 3 introduce the new map_align endpoint controller method
>>    and related epc functions.
>>  - Patch 4 to 6 modify the test endpoint driver to use these new
>>    functions and improve the code of this driver.
> 
> While posting the next version, please split the endpoint patches into a
> separate series. It helps in code review and can be applied separately.

Which patches ? They are all endpoint related:
 (1) Core code
 (2) test function driver
 (3) rockchip rk3399 controller

(2) and (3) depend on the patches in (1), so splitting the series is a big
possible only if (1) is applied first, so that is a source of delays and breaks
the context of the patches...

-- 
Damien Le Moal
Western Digital Research


