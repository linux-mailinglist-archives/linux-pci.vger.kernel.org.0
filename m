Return-Path: <linux-pci+bounces-15004-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 142129AA189
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 13:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 398E41C2208E
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 11:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C8A19CC00;
	Tue, 22 Oct 2024 11:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pY2WpYjm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFA219CC21
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 11:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729598224; cv=none; b=feXbeVJAgNIvq+0wY33prUpRzSwh0CqBjYfQLsNpQribiKRe7SrAX5Jky+gz377T6tvH0J5LsWF8/UgxuDM40YgHXDJ/TxoJbAUAQ1m7JdmLW1TyC5+quKP7yIqljvS3VuIwbBhNgA5M1i7ee7L8JrOx5WlfujQLoO2uJVBWkBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729598224; c=relaxed/simple;
	bh=/isuBtDJ+qspniIuPbrBAIHMCWCNGINnskQ2X2oaHOk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KydIWf4kWPE+9hNbtCqqfr0x771vIgV22poRpEASdwnS/TrJJOwIxTo/AtR05yEAJ2pRu5UhlRSjTyAoNBDgh0LK/iUqBcICJKl6/f6O1R4ZsWi5FUr5dc4qbfcIS8BB8U9OwE+WCWc7v+hobapviyRus+anHhNPY+ZLfMpz0RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pY2WpYjm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F41C4CEC3;
	Tue, 22 Oct 2024 11:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729598224;
	bh=/isuBtDJ+qspniIuPbrBAIHMCWCNGINnskQ2X2oaHOk=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=pY2WpYjmW087MDwejOweCl2DyejDBXD4vIWuvuFALhDEE0ZXtXK8epEBb3bN5CEPP
	 gwQ4r1dV+uTFwY6ixwKWactzKgMiyi2DN4YGMIVOy6UuemzsH/FDSKYt7YdYQqt5rk
	 OVZkim+x24Fx55C+g5DuIsuIZuo8M8KeJqMbmaYBBnJIJBtkASwqAQLNRwM7bpHJCg
	 7tv90mahzvrt8oji3FrPkwUQVYhWwV6jvvuLLu5e7ddL1nZwIzngwWqAn8FDcG8vw+
	 O9i9GmOr0Ee3Hk3IUxpmqHzepYUtyYpBhhcpki71QfDkksLHwwJc12KnyIWw2XF9NJ
	 uWJlKhufsabeQ==
Message-ID: <0a174951-3c0d-4a34-a631-a62f452663d3@kernel.org>
Date: Tue, 22 Oct 2024 20:57:01 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v6 0/6] Improve PCI memory mapping API
To: Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Jingoo Han <jingoohan1@gmail.com>,
 linux-pci@vger.kernel.org, Rick Wertenbroek <rick.wertenbroek@gmail.com>
References: <20241021221956.GA851955@bhelgaas>
 <848f676b-afce-472e-872d-53a32af094c1@kernel.org>
 <ZxdkopcSp9/P4f6k@x1-carbon.wireless.wdc>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <ZxdkopcSp9/P4f6k@x1-carbon.wireless.wdc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/24 17:38, Niklas Cassel wrote:
> On Tue, Oct 22, 2024 at 10:51:53AM +0900, Damien Le Moal wrote:
>> On 10/22/24 07:19, Bjorn Helgaas wrote:
>>> On Sat, Oct 12, 2024 at 08:32:40PM +0900, Damien Le Moal wrote:
>>
>> DMA transfers that can be done using dedicated DMA rx/tx channels associated
>> with the endpoint controller do not need to use this API as the mapping to
>> the host PCI address space is automatically handled by the DMA driver.
> 
> I disagree with this part. It think that it depends on the DMA controller.
> 
> Looking at the manual for e.g. the embedded DMA controller on the DWC
> controller (eDMA):
> ""
> When you do not want the iATU to translate outbound requests that are generated by the
> internal DMA module, then you must implement one of the following approaches:
> - Ensure that the combination of DMA channel programming and iATU control register
> programming, causes no translation of DMA traffic to be done in the iATU.
> or
> - Activate the DMA bypass mode to allow request TLPs which are initiated by the DMA
> controller to pass through the iATU untranslated. You can activate DMA bypass mode by
> setting the DMA Bypass field of the iATU Control 2 Register (IATU_REGION_C-
> TRL_OFF_2_OUTBOUND_0).
> ""
> 
> However, we also know that, if there is no match in the iATU table:
> ""
> The default behavior of the ATU when there is no address match in the outbound direction or no
> TLP attribute match in the inbound direction, is to pass the transaction through.
> ""
> 
> I.e. if there is a iATU mapping (which is what pci_epc_map_addr() sets up),
> the eDMA will take that into account. If there is none, it will go through
> untranslated.
> 
> 
> So for the eDMA embedded on the DWC controller, we do not strictly need to
> call pci_epc_map_addr(). (However, we probably want to do it anyway, as long
> as we haven't enabled DMA bypass mode, just to make sure that there is no
> other iATU mapping in the mapping table that will affect our transfer.)
> 
> However, if you think about a generic DMA controller, e.g. an ARM primecell
> pl330, I don't see how it that DMA controller will be able to perform
> transfers correctly if there is not an iATU mapping for the region that it
> is reading/writing to.
> 
> So the safest thing, that will work with any DMA controller is probably to
> always call pci_epc_map_addr() before doing the transfer.

Indeed, I think you are right. Not doing the mapping before DMA with the RK3588
works fine, but that may not be the case for all controllers.

-- 
Damien Le Moal
Western Digital Research

