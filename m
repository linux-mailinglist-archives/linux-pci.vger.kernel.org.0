Return-Path: <linux-pci+bounces-120-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E01567F3E28
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 07:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EED51F22545
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 06:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11A7D2E6;
	Wed, 22 Nov 2023 06:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdGXOFtn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E33210A
	for <linux-pci@vger.kernel.org>; Wed, 22 Nov 2023 06:33:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD760C433C7;
	Wed, 22 Nov 2023 06:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700634787;
	bh=P/VDZhUYeLyF/fTIY/BSgPTr9A7SPup0XOIVoTr3Jys=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pdGXOFtnqohCTRSm1JZIu/QFsZo1lcT4bFupJtKkE8CeAS4gLUiuv5vBV0M9d9qxc
	 oiXXYzEKz1TwAJ0tmMTX9HLu6oDL/uPvEJHlNlw3Kg7f65p+f8ixqlJoZNl0dnEFgD
	 WbvZj18bPo07B67x7pVG/jOA66x2rBW3fkPiEOMFrJZvPEtlH1OJyBV3umy3V+gCy6
	 Q70iZNDQl+G3OAHQ1f2+FD/DkK2hgW1+YdgdlrzM6sLVmBx0dOUpNNK0mimCHOGtmf
	 vZ3T3Mz7W9X6xHXyw1j9UpH10vL8RTYum28GdeD1e49ouZL6xtS5pGz1S2xCcAhoxF
	 iwHiJSvJW7dsw==
Message-ID: <d8e64422-d332-4c99-88bc-85f6e2077c32@kernel.org>
Date: Wed, 22 Nov 2023 15:33:04 +0900
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
 <3859e36a-f920-4df8-922d-36305c81758b@kernel.org>
 <ZV2eY8iH41eOSgIZ@infradead.org>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZV2eY8iH41eOSgIZ@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/22/23 15:23, Christoph Hellwig wrote:
> On Wed, Nov 22, 2023 at 03:22:54PM +0900, Damien Le Moal wrote:
>> I did not want to go as far as changing all drivers everywhere and limited the
>> series to drivers/pci. We could do a coccinel script for everything else.
> 
> Yes.  This is actually even trivial enough for sed :)

Surprisingly, only 44 files use PCI_IRQ_LEGACY. Let me see how a patch look
with the change.

-- 
Damien Le Moal
Western Digital Research


