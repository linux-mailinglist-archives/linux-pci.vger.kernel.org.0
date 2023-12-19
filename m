Return-Path: <linux-pci+bounces-1165-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B258818500
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 11:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EEAE1C23488
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 10:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F225214012;
	Tue, 19 Dec 2023 10:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKpscsB5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72991426E
	for <linux-pci@vger.kernel.org>; Tue, 19 Dec 2023 10:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF81C433C8;
	Tue, 19 Dec 2023 10:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702980433;
	bh=KpiQW4wH6gcnbNKmr8FiY5w2vkWBhqNxRQEsYDuTr7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gKpscsB5k9GsNZrsO5A0UUh8xoDJWW7fex3QlDFxhu6FO3jWPQ5xBcvtevY802Q7Q
	 hwJuMWUCMtMJTAn7waa76tQVIx4hTBsJL9UIiz33hG/IAa1T8Hu12AwVcxdXCaVjdD
	 X12BVVY86Kk+NnnsXJMJYhiymJj31Yi97JhjqKkhZH3PPq+lpTpuhbSXd71IO/921A
	 guAnl40+mjhb/5xWtXUaMcqctLHE24qL5z+3OqNjY8Wwi0KMNOoSpzqRA26MECc+Y6
	 qnTLHnA+boN0jVlaYijMDEffqKLfxRRCaDYhloRX33KB0mmdH9u9xgI3GiAqMp+eTe
	 W6DyVw5VwBTjA==
Date: Tue, 19 Dec 2023 11:07:09 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v4 06/16] PCI: portdrv: Use PCI_IRQ_INTX
Message-ID: <ZYFrTTDizjf9ME2M@lpieralisi>
References: <20231122060406.14695-1-dlemoal@kernel.org>
 <20231122060406.14695-7-dlemoal@kernel.org>
 <ZV2c3oAHtmmYgSGn@infradead.org>
 <3859e36a-f920-4df8-922d-36305c81758b@kernel.org>
 <ZV2eY8iH41eOSgIZ@infradead.org>
 <d8e64422-d332-4c99-88bc-85f6e2077c32@kernel.org>
 <ZV2hZ+0jRQUJqMH6@infradead.org>
 <d7c8ff12-279e-4201-8987-92de01e8ecea@kernel.org>
 <ZV2lq6PcYwL5uCHr@infradead.org>
 <3bb1f206-b709-4e74-a381-e01a8ad72e6e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bb1f206-b709-4e74-a381-e01a8ad72e6e@kernel.org>

On Wed, Nov 22, 2023 at 03:59:47PM +0900, Damien Le Moal wrote:
> On 11/22/23 15:54, Christoph Hellwig wrote:
> > On Wed, Nov 22, 2023 at 03:49:28PM +0900, Damien Le Moal wrote:
> >>> As mentioned in reply 1 I think this is perfect for a scripted run
> >>> after -rc1.
> >>
> >> You mean 6.8-rc1 next cycle ?
> > 
> > Yes.  6.7-rc1 is over :)
> 
> OK.
> 
> Bjorn,
> 
> I can resend without this patch, or maybe you can drop it when applying. Let me
> know what you prefer.

Krzysztof diligently made me notice, thanks.

I have now dropped it and repushed out the resulting irq-clean-up
branch.

Lorenzo

