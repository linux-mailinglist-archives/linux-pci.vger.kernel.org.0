Return-Path: <linux-pci+bounces-27679-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97068AB6355
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 08:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD2A43ACCF1
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 06:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3CA1FECAF;
	Wed, 14 May 2025 06:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uajTYLvO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA42EEC3
	for <linux-pci@vger.kernel.org>; Wed, 14 May 2025 06:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747204895; cv=none; b=WuLcYZGVMTLxR0GVv6g+SfPpp13isxah1Ra8STj+k5htR5pivYm/3knapDn7vRZiMgUKJYFniQNKuyyGQf3E4HqFPLbWrRGHUGyeok2jqrq9vMWRJ/9N6TeikOWShQFz41LWFfiOMm2euZ4e0PVho/6+mgAQu1e4YtGTk3NMyrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747204895; c=relaxed/simple;
	bh=DMk/pFKacrgjvoCa1/n15iM4UgpLTND9x72+WPM5twk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cw1d3ucLkCPGLLqZdnecZySM6JcySPWIIG79q2BD2wrx53D6M57cpreI6lH+OVsy/FfmM1r99JvCBsU180P+L9T52kEWkChDLN9OBpeaidtimU7ipJq68Vaqz932cctfvRHUZk1bH6lfLTyUe0fsNSnY+yCZF4lUFXWRkegOGQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uajTYLvO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E18AC4CEE9;
	Wed, 14 May 2025 06:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747204894;
	bh=DMk/pFKacrgjvoCa1/n15iM4UgpLTND9x72+WPM5twk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uajTYLvOC5tbDPHIMSnNGfnZoSoYkKidE25KcrOblW8fdCtgM7JWBDo7hAl1+jK48
	 G3sM0hWsI9Dg4NsX5DhH3HymDObyBWyuJ63cAJGMG7QuX4srzlsihOdKkloMf9J9LE
	 u8q7l4WiOtA01kSPa20F604AEHLzUOyFtXqlHp5+6qRvZP6kN9wLeA/FCzJV8dfqrY
	 HRp0U1lBdBJkfHCO6cYmjm1YDDm53O58r8HJQPn4UkEwEadtLLTwjhlOpqKHE/ZkB8
	 WWTlleeKDTtSYxBuxBAyNZCFiKXqtRnzOX00nkFGSi5rWzZFvRNyr+1jqa9BVsmPcP
	 OSupM6evxPd8A==
Message-ID: <971ba853-cc7e-48e2-9cb2-001d5c8ee8aa@kernel.org>
Date: Wed, 14 May 2025 15:41:28 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] PCI: endpoint: cleanup get_msix() callback
To: Niklas Cassel <cassel@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Jingoo Han <jingoohan1@gmail.com>, Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>, stable+noautosel@kernel.org,
 linux-pci@vger.kernel.org
References: <20250513073055.169486-8-cassel@kernel.org>
 <20250513073055.169486-13-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250513073055.169486-13-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/13/25 16:31, Niklas Cassel wrote:
> The kdoc for pci_epc_get_msix() says:
> "Invoke to get the number of MSI-X interrupts allocated by the RC"
> the kdoc for the callback pci_epc_ops->get_msix() says:
> "ops to get the number of MSI-X interrupts allocated by the RC from the
> MSI-X capability register"
> 
> pci_epc_ops->get_msix() does however return the number of interrupts
> in the encoding as defined by the Table Size field.
> 
> Nowhere in the kdoc does it say that the returned number of interrupts
> is in Table Size encoding.
> 
> Thus, it is very confusing that the wrapper function (pci_epc_get_msix())
> and the callback function (pci_epc_ops->get_msix()) don't return the same
> value.
> 
> Cleanup the API so that the wrapper function and the callback function
> will have the same semantics.

Same comment as previous patches. Mention the semantic.

But looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

