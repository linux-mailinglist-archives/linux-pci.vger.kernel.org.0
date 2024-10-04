Return-Path: <linux-pci+bounces-13824-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8709099045A
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 15:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 246F7B235B9
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 13:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21BF15B135;
	Fri,  4 Oct 2024 13:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4MlVO+A"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9971581E0
	for <linux-pci@vger.kernel.org>; Fri,  4 Oct 2024 13:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728048555; cv=none; b=rBcu0yUCoWwMCZT5+sswO1eqtTBKmwaNojtzPJ9un2M6DYAwWc+mnnu3fEcObX7BhNbuMrv9GVlztGrwsCK80Za1+0OG1ER5djkI6VWtzfL+ACr73uIf2DXAo95JtcEni3BfofYqFhSMQcwuGZp/FwWMjujUC1pwZpi1UfLpnkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728048555; c=relaxed/simple;
	bh=gO47TRlI0g8olXXTjShcD5NQiQdyk/LYJFe3VsSs6lI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BxQOD8Q9rX12jRBR09TVHB0rqwl1jbx8vqm9gvwvZyZmYDbfUdQ9N44seYYj5hHixe/zWXaLD5tbqkk/41lv4etWhRXdqium9tumCPsuw2xPIPT02POM8HZpf8VLYTU+VbWghpGKPQYR0yNi6gsZGRkkixOIh+RwFOeShxijsMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4MlVO+A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95BB1C4CEFB;
	Fri,  4 Oct 2024 13:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728048555;
	bh=gO47TRlI0g8olXXTjShcD5NQiQdyk/LYJFe3VsSs6lI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i4MlVO+AH9RxPsj9sD1Q/bGnLL6w8x+lTgO5Fy7V5uJFK2EcZMg+7JrYWixHVGyMK
	 vA5f5k1fB1+ukJbY+g74aQAhadABuPXxXV0oUKVEwFue87IfbXxDHc/CsD8CiijZfq
	 NJukUumW4M8JnG+IoJz/1Zg4cg001F3Aei4TBC2k2gh0wNgWLH8DnSSDJ4Jczz007k
	 NjWtlsI3iGOgcBR06zla0klZPY034KOfSVh6Csk3srlwHiA3PGt6OOto/fEm33c4P9
	 u4qVLlk45IcEbLvK3uwYE0eYS/i1ndQOYAhCmG+CX+Gw1HcqpmCLt/iOFHkPtitBgw
	 NgFGpLe03kKzg==
Message-ID: <6484ee3f-12db-4af9-8977-095f52a0a1d7@kernel.org>
Date: Fri, 4 Oct 2024 22:29:12 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] PCI: endpoint: Introduce pci_epc_mem_map()/unmap()
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Jingoo Han <jingoohan1@gmail.com>,
 linux-pci@vger.kernel.org, Rick Wertenbroek <rick.wertenbroek@gmail.com>
References: <20241004050742.140664-1-dlemoal@kernel.org>
 <20241004050742.140664-5-dlemoal@kernel.org> <Zv_Vt5xGEiQeBD1o@ryzen.lan>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <Zv_Vt5xGEiQeBD1o@ryzen.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/4/24 20:47, Niklas Cassel wrote:
> Naming is one of the hardest problems in computer science :)

Yep.

> Perhaps:
> s/pci_epc_mem_map()/pci_epc_mem_alloc_map()/
> s/pci_epc_mem_unmap()/pci_epc_mem_free_unmap()/
> 
> is slightly more clear that this both allocates and maps.

Sure, but I consider the allocation an implementation detail of the function.
And I really prefer the shorter function names :)

> Regardless:
> Reviewed-by: Niklas Cassel <cassel@kernel.org>

Thanks.

-- 
Damien Le Moal
Western Digital Research

