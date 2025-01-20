Return-Path: <linux-pci+bounces-20140-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0137A16BE7
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 13:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA2383A3AA9
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 12:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C31119CD1E;
	Mon, 20 Jan 2025 12:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qiim54m1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B79374F1
	for <linux-pci@vger.kernel.org>; Mon, 20 Jan 2025 12:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737374419; cv=none; b=o4FIpGH2XUQVaV3OpHbXvCkZG3B4jKJIUN0TqbtCI7LAu9CxV+o1X+Bu19++9wicSWN070BR0S9wQGzic/vVLptaGQTeuej2Ejrkq9q2AXFzGYxmrlY7IzBIrZbGg8Mv/ALLVe9y6lqmK9qCYmOTlajDprIbm2YPopzejBUIVoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737374419; c=relaxed/simple;
	bh=gu9igA/nVaZPbfEtDa4BhchJQLKkldOfTuqnBg1jo0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awq++B3jt4nC+AdIgity+cXvLgcItI1IQwIFMHyoUFCNUQzX+ztyNGNZ56CX4D8qp0xDa+v90ZHb2Z93yKCZAhvS0O6fRpVBxsJHifzgpHOHTriOFJUn67eTdArHJMfxKRxFt7TvT7IEfFZUh0AlR6p8BetgN0FQ1fO3ocHyZx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qiim54m1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3740AC4CEDD;
	Mon, 20 Jan 2025 12:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737374418;
	bh=gu9igA/nVaZPbfEtDa4BhchJQLKkldOfTuqnBg1jo0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qiim54m11BYwFnq9vvZgRASVvHziDvJvwgPLlPE/wwSsp0hBiYYPYxpkQ3xMjQgAt
	 zL5rs/j0EfsTAeFRtQKcZGECPBkd/vo4x8V5GVKUvSAZe01ERWWuqXKbPnFcde8A5v
	 ixVJQvidL5CGb4jIbDXzp0vi+Dlo2u0XHMwBHW+pMoj0Haw1XvB2SiWVMRD6kCbA8A
	 v7ea0FQmJN7CdrjE9OqlhqQoP1TtJwAnK3uGQ+nITCGNobfiHu2M1JL2gdJcdmJVK1
	 cHSXjvl/Zl1m6i8c34maMGbp952PC5IF85RX1c6zUkHUZkWeoSW03pFJw3yNeccDuk
	 ylgGp5knPiXyw==
Date: Mon, 20 Jan 2025 13:00:15 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v3 1/2] PCI: endpoint: pci-epf-test: Add support for
 capabilities
Message-ID: <Z446zwlcPt8dv5lx@ryzen>
References: <20241203063851.695733-5-cassel@kernel.org>
 <20250118203421.GA790917@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250118203421.GA790917@bhelgaas>

Hello Bjorn,

On Sat, Jan 18, 2025 at 02:34:21PM -0600, Bjorn Helgaas wrote:
> On Tue, Dec 03, 2024 at 07:38:53AM +0100, Niklas Cassel wrote:
> > The test BAR is on the EP side is allocated using pci_epf_alloc_space(),
> > which allocates the backing memory using dma_alloc_coherent(), which will
> > return zeroed memory regardless of __GFP_ZERO was set or not.
> 
> > +static void pci_epf_test_set_capabilities(struct pci_epf *epf)
> > +{
> > +	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> > +	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> > +	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
> > +	struct pci_epc *epc = epf->epc;
> > +	u32 caps = 0;
> > +
> > +	if (epc->ops->align_addr)
> > +		caps |= CAP_UNALIGNED_ACCESS;
> > +
> > +	reg->caps = cpu_to_le32(caps);
> 
> "make C=2 drivers/pci/" complains about this:
> 
>   drivers/pci/endpoint/functions/pci-epf-test.c:756:19: warning: incorrect type in assignment (different base types)
>   drivers/pci/endpoint/functions/pci-epf-test.c:756:19:    expected unsigned int [usertype] caps
>   drivers/pci/endpoint/functions/pci-epf-test.c:756:19:    got restricted __le32 [usertype]

Yes, pci-epf-test is broken when it comes to endianness, as reported here:
https://lore.kernel.org/linux-pci/ZxYHoi4mv-4eg0TK@ryzen.lan/


Nice to see that sparse is complaining about it! :)

Mani said that he was going to work on it, but I guess that it fell through
the cracks.

I sent patch for it here:
https://lore.kernel.org/linux-pci/20250120115009.2748899-2-cassel@kernel.org/T/#u

FWIW, I tested it on rk3588 which is little-endian, and that still worked.

However, if you feel that it is a bit too late to queue it now, you could
also take only the following change from the patch above:

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index ffb534a8e50a..cb7e57377214 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -76,7 +76,7 @@ struct pci_epf_test_reg {
        u32     irq_type;
        u32     irq_number;
        u32     flags;
-       u32     caps;
+       __le32  caps;
 } __packed;
 
 static struct pci_epf_header test_header = {


Kind regards,
Niklas

