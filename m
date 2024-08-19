Return-Path: <linux-pci+bounces-11847-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9AA95787F
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 01:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A19F11C2263C
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 23:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1C51DF68D;
	Mon, 19 Aug 2024 23:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2kVampv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9227A15AAB8;
	Mon, 19 Aug 2024 23:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724109137; cv=none; b=cLU+nPt7D+++WcohxS2Q5IYW58zbiXaziT78EmbIKRyKSY98Zd52zWCNErepN0xbqgxJrZuU+CH/S/jUFWfyf+gOBXNgskdgbXdzgPF4y67EE4BJiGQwpPuqaoRE+MBONH1nHz77QzarRrnQX+C7to4OTjY35NIKONyMgbmjbRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724109137; c=relaxed/simple;
	bh=VHEkD+dkDRyfNtL8bwaNRMNAG8RJ9dSBV/nM2A5T72M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U/1MFFG8nNwJqTfY5qDtsmXU1XJCeZk2E0Zqg0lZtaq7MqtXY4G2ZK6w8GbnLTedajatOFyMfKuUAAGqjqGvRQkx4wfEDGtWv23cslH4mdGzZsKgWIBHKGYTJUlXpfBPAUBvxDpa7aNMgaVysH6WaFm8HKlR0mgkq5cTYxclC6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2kVampv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F21FC32782;
	Mon, 19 Aug 2024 23:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724109137;
	bh=VHEkD+dkDRyfNtL8bwaNRMNAG8RJ9dSBV/nM2A5T72M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h2kVampvs0KyS47DVGtX4fkbEwUP6xyBzbsqkexpNBRiHgJ5dEkuMu8pXU4MOC+VR
	 KecfCY8sdwrjRLIr972pzt1DNMVjZ/WnNquHnWZ4AJbFJg3NuwpqP2fOQ45rx0pAM+
	 melWnggsX39WpqNYxwsmdR/Hid0np1uuv2JhI1tNU9j54Qsz1YzniTHBZ1RIv4PKbr
	 DPDu2y4VoiFOLF+0ucSAab14QQBwOoWvkTP+PSl+ngcFmwPvmCDKvYzwztp+qZJlTL
	 XA7W+f9COBcDJzRTVO/GPKoBa1nX1qBIGNi7M3UaA9ub5vh6wclKwXb60KYnV/0Y33
	 mS8pV5+9/56VA==
Message-ID: <e1f9013d-f520-44de-b961-bf60bdee8181@kernel.org>
Date: Tue, 20 Aug 2024 08:12:14 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: endpoint: pci-epf-test: Move DMA check into
 read/write/copy functions
To: Rick Wertenbroek <rick.wertenbroek@gmail.com>, rick.wertenbroek@heig-vd.ch
Cc: alberto.dassatti@heig-vd.ch,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Niklas Cassel <cassel@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240819120112.23563-1-rick.wertenbroek@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240819120112.23563-1-rick.wertenbroek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/19/24 21:01, Rick Wertenbroek wrote:
> The pci-epf-test PCI endpoint function /drivers/pci/endpoint/function/pci-epf_test.c
> is meant to be used in a PCI endpoint device inside a host computer with
> the host side driver: /drivers/misc/pci_endpoint_test.c.
> 
> The host side driver can request read/write/copy transactions from the
> endpoint function and expects an IRQ from the endpoint function once
> the read/write/copy transaction is finished. These can be issued with or
> without DMA enabled. If the host side driver requests a read/write/copy
> transaction with DMA enabled and the endpoint function does not support
> DMA, the endpoint would only print an error message and wait for further
> commands without sending an IRQ because pci_epf_test_raise_irq() is
> skipped in pci_epf_test_cmd_handler(). This results in the host side
> driver hanging indefinitely waiting for the IRQ.
> 
> Move the DMA check into the pci_epf_test_read()/write()/copy() functions
> so that they report a transfer (IO) error and that pci_epf_test_raise_irq()
> is called when a transfer with DMA is requested, even if unsupported.
> 
> The host side driver will no longer hang but report an error on transfer
> (printing "NOT OKAY") thanks to the checksum because no data was moved.
> 
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


