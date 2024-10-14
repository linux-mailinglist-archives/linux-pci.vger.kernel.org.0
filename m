Return-Path: <linux-pci+bounces-14470-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAF299CB28
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 15:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DDF11C23D37
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 13:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59CC1AA7AF;
	Mon, 14 Oct 2024 13:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApYPDVbG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0CB1AA79A
	for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 13:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911366; cv=none; b=JYG9sSQWk6Y3niakgyyo/h3up0R6yq4zBqzMGJ/+BwQ3umkJYuZI/Nxk2WuRZE7vTskhW0uYt7cpePWdiWL/H+z8P8YgyIjFpIvkkWNJ8MfTvlSZGERZ/CP/Uuj7D5BxhuequF3D5cnJKd7s/YDpPv21SsPcUqlJK/oTQmpQu90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911366; c=relaxed/simple;
	bh=dzcg+QBGRefKW2wi6WLqmnf6WGiUYEdMsls9hFS03T0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=oBd8umBSYDtv+ded08irH7eUvVPZrkQsHyOY/tRYuFYkW06eEkdQptSC2KlpC6huaTztaYILdPd+aoV1vOUaxLfR/0nfsjqUB7+PofTd8RI6CSWrX7sa6iq9MOxxhWwXwhrLBmLxWw3CZAsKFRDTJltx7beKr8SjObv9LMsyOxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApYPDVbG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527C0C4CEC3;
	Mon, 14 Oct 2024 13:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728911366;
	bh=dzcg+QBGRefKW2wi6WLqmnf6WGiUYEdMsls9hFS03T0=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=ApYPDVbGYiETYJqcm/MbVdhtKHYnSnxTt9Q9Ozvs529aSAvbptvxb4SqUsTZuJswP
	 hBwi68+jTgEmeK/gNLesAiq6mu6BXPsF052E/3WckhEZ5XSfswTY32RoWREZkS5tAH
	 QskaLg4QGz34OyzaU7BlA35xvK11psL7OmJk95XMborTAKfwbr+3Y3u6InCAycug40
	 XlQEPbybKYTcNm+V1HjR+68aMrvwJn+jrYVsGDLfjRQlaVlh9xgp9ouqKhFlKtrtkE
	 a9KcwYSfFCJdmzmv8Fbyw8e9KWPtrvFCusqegxqcRIxxzF7+wvxcrVKqqCNKn2ZXTR
	 Hf5FcSorg7byw==
Message-ID: <5a770af8-d901-4376-ae5b-2ea28893a7cc@kernel.org>
Date: Mon, 14 Oct 2024 22:09:23 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v6 3/6] PCI: endpoint: Introduce pci_epc_mem_map()/unmap()
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Jingoo Han <jingoohan1@gmail.com>,
 linux-pci@vger.kernel.org, Rick Wertenbroek <rick.wertenbroek@gmail.com>
References: <20241012113246.95634-1-dlemoal@kernel.org>
 <20241012113246.95634-4-dlemoal@kernel.org> <ZwuNjwdRLKsaM1Sd@ryzen.lan>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <ZwuNjwdRLKsaM1Sd@ryzen.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/13/24 18:06, Niklas Cassel wrote:
>>   * @map_addr: ops to map CPU address to PCI address
>>   * @unmap_addr: ops to unmap CPU address and PCI address
>>   * @set_msi: ops to set the requested number of MSI interrupts in the MSI
>> @@ -61,6 +93,8 @@ struct pci_epc_ops {
>>  			   struct pci_epf_bar *epf_bar);
>>  	void	(*clear_bar)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>>  			     struct pci_epf_bar *epf_bar);
>> +	phys_addr_t (*align_addr)(struct pci_epc *epc, phys_addr_t pci_addr,
>> +				  size_t *size, size_t *offset);
> 
> This functions returns an aligned PCI address.
> Making it return a phys_addr_t for someone used to reading code in
> drivers/pci is very confusing, as you automatically assume that this is
> then the "CPU address" (which is not the case here).
> 
> Please change the return type (basically the same as my first comment in
> this reply) in order to make the API more clear.

Sure I can send an incremental patch to change this to use u64 like other
operation s (e.g. map_addr) for the pci address.

Mani,

Are you OK with that ?

-- 
Damien Le Moal
Western Digital Research

