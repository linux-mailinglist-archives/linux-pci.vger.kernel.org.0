Return-Path: <linux-pci+bounces-38176-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D12BDD4D3
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 10:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 628273AEE32
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 08:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14F22C237E;
	Wed, 15 Oct 2025 08:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSNhFi6L"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A514013957E;
	Wed, 15 Oct 2025 08:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760515431; cv=none; b=Fab5FC+fgv9rJd9fmxkLrcyP+havAWoFMMzf7Wnu4HSYponuZP3FyNU+OnkUWmvHpnIWkFdhzBcT8NT9IWy7FTfopEo7vpYXGvux+PWtQoqDNqwBqI7qgTOX7MifTzP1oNWlDIqCDhuJq+NtxV+i9BNHvliVIdAwS7Lh9AxVIhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760515431; c=relaxed/simple;
	bh=5unoLNZna7TbN6XnAcrbvPxZlZXyH1EX+4YdDxPuHhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OhFuuou0w/V9fm2aalj6OQzofQjASShYojjbCUuj9vzwOAkohTT3V8qxlIPMJ+qa5YmgPNbjZJbITBZwEOTsn7q0EO9He2cI5Nx1i/8w/14kmMjuXeZYe7yRhnDEr5FEj1eluFZhoGX0pA/S9t7ZsrTwhdnabd+YlbBzjRnwDnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSNhFi6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9135CC4CEF8;
	Wed, 15 Oct 2025 08:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760515431;
	bh=5unoLNZna7TbN6XnAcrbvPxZlZXyH1EX+4YdDxPuHhA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XSNhFi6LSwYMGRwm8/DjIzD70+SJl6l4LlN+k5qLeOMIEtbTZO2LQs9c8auQB/xDA
	 K7JY5T9kobA8hMf16Hn2Hf7NwRCDtbTnXMHW+pn6XrtllrMxH39uRqhnYCFrxKAPG8
	 ciDRfUJ8clQlL7702X9qNivz2a76qmwTnRe0J/K4W710FBp0MY404iWKMPyjSbGYr0
	 7Rjptvc0+/m+BV1c+OT/QNJb2NH6LZjgi3FYZaPilIB/mj9WiW8g9H689PO0C1kLrF
	 ztXTF07l+hufkiLkTAHi0wsnXGencQw7E30Ywg1vcfYrbCEoGpps4RfqlkSBpn6rSl
	 7VGDwrPt2mv/g==
Date: Wed, 15 Oct 2025 10:03:44 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Scott Branden <sbranden@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2 2/4] of/irq: Fix OF node refcount in
 of_msi_get_domain()
Message-ID: <aO9VYGkCq7MDCcNn@lpieralisi>
References: <20251014095845.1310624-1-lpieralisi@kernel.org>
 <20251014095845.1310624-3-lpieralisi@kernel.org>
 <aO7Mx11tWFbDX8u1@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO7Mx11tWFbDX8u1@lizhi-Precision-Tower-5810>

On Tue, Oct 14, 2025 at 06:20:55PM -0400, Frank Li wrote:
> On Tue, Oct 14, 2025 at 11:58:43AM +0200, Lorenzo Pieralisi wrote:
> > In of_msi_get_domain() if the iterator loop stops early because an
> > irq_domain match is detected, an of_node_put() on the iterator node is
> > needed to keep the OF node refcount in sync.
> >
> > Add it.
> >
> > Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Cc: Rob Herring <robh@kernel.org>
> > ---
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> 
> After go though of_for_each_phandle, I understand why need of_node_put()
> at break branch.
> 
> It will be nice if add of_for_each_phandle_scoped() help macro.

Yes because this fix is not the end of it AFAICS.

Please review and test patch (4) as well since I slightly change
the existing logic there, I don't want to break the EP mapping code you
added in f1680d9081e1 (by the way, I don't get that commit logic, if the
msi-parent loop would match it could just return and we could have
removed the

if (ret)

guarding of_map_id(), correct ?).

That's what I did in patch (4), please have a look.

Thanks,
Lorenzo

> 
> 
> >  drivers/of/irq.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> > index e67b2041e73b..9f6cd5abba76 100644
> > --- a/drivers/of/irq.c
> > +++ b/drivers/of/irq.c
> > @@ -773,8 +773,10 @@ struct irq_domain *of_msi_get_domain(struct device *dev,
> >
> >  	of_for_each_phandle(&it, err, np, "msi-parent", "#msi-cells", 0) {
> >  		d = irq_find_matching_host(it.node, token);
> > -		if (d)
> > +		if (d) {
> > +			of_node_put(it.node);
> >  			return d;
> > +		}
> >  	}
> >
> >  	return NULL;
> > --
> > 2.50.1
> >

