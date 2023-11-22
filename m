Return-Path: <linux-pci+bounces-118-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 279927F3E14
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 07:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4C6C281A3B
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 06:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AFF15AD3;
	Wed, 22 Nov 2023 06:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuNcpdzF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DE515ACF
	for <linux-pci@vger.kernel.org>; Wed, 22 Nov 2023 06:22:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08186C433C7;
	Wed, 22 Nov 2023 06:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700634177;
	bh=lRHrHy0nZgjiXBpazDnlXh11S+m3DtUxLrn8Yrq0sw4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fuNcpdzFdmJfeiIJ+a9NIvpT42xlPDHwacaALa3m4m6E/s9/whZlQ7el+o8Ghxfe0
	 /okATPmYjg4tWivMZVNSoS5cFph6BggAyBK0fBQHchMk993z9UoSOHec1QLLa0uhHF
	 9ExWKkgCuhRXiR3V2eJ1MrtxBcBXh62hF4/qblFxcCD4SiCUEsHU4/3ligP4ppOd9B
	 LVkuSpj73qTJPHHzQHBWaPTlsMP27eC2u3+6oGYAyXOlPjgw+J0EvWWmQ8ezyARq8t
	 Unr7yiHCawlxt8GOyObmJBFE7LriqQUHFHgB8HsCWyvNsledSt91iMmoYHlUZNQ3F5
	 Aj00gw2ZmEyyw==
Message-ID: <3859e36a-f920-4df8-922d-36305c81758b@kernel.org>
Date: Wed, 22 Nov 2023 15:22:54 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/16] PCI: portdrv: Use PCI_IRQ_INTX
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
 Serge Semin <fancer.lancer@gmail.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
References: <20231122060406.14695-1-dlemoal@kernel.org>
 <20231122060406.14695-7-dlemoal@kernel.org> <ZV2c3oAHtmmYgSGn@infradead.org>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZV2c3oAHtmmYgSGn@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/22/23 15:17, Christoph Hellwig wrote:
> On Wed, Nov 22, 2023 at 03:03:56PM +0900, Damien Le Moal wrote:
>> In the PCI Express Port Bus Driver, use the macro PCI_IRQ_INTX instead
>> of the now deprecated PCI_IRQ_LEGACY macro.
> 
> I'd prefer to just script these cleanups in one big run to be honest..

I did not want to go as far as changing all drivers everywhere and limited the
series to drivers/pci. We could do a coccinel script for everything else.


-- 
Damien Le Moal
Western Digital Research


