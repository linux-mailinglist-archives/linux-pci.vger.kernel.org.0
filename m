Return-Path: <linux-pci+bounces-36475-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5233EB89766
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 14:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB67A7BA9C6
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 12:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B2D1B4236;
	Fri, 19 Sep 2025 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7ocws22"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813E419CC27;
	Fri, 19 Sep 2025 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758285200; cv=none; b=rkXw5qnfeuUc4CuslshXMQIK8bt4DvgRr/B1sLgLaf1zCUTWmRN6Wz4oFaXWdSgBE8xIccy4IuTVS3V+Dhozt5h0pfOgJnvBdBheMIMJZYYt9LhGpzb+j3DYEGypiO9ecRqxL0lkjfVC3lzlYguVZGZ2Yj/u1CrxdjEVQXniVa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758285200; c=relaxed/simple;
	bh=vobpzHuxbagJk0+nMmeihBJWUkhXY4FqYQ5Kve1dS28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8n5mpcMZk9c/3fE+tmvxfidm1eqv9dq5nKl0dSuxRLIwZxnmYzHcxZgJffLXS4k1BDZG21RV5ofyxB+bokydJhXxIvRKx+W5tU7awGFGoF85KVLLVJQCGvvPv15Nb5fdCyhn8CheT8StY7OoxrEmDqkzD+F/6uiY7RRNQR8pms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7ocws22; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA9EC4CEF0;
	Fri, 19 Sep 2025 12:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758285200;
	bh=vobpzHuxbagJk0+nMmeihBJWUkhXY4FqYQ5Kve1dS28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b7ocws22QNoMpcYJxLykD6ISRoWbqEhp+J6wvNPJ1LUSWeMmBvJpKmPC22zMs76qi
	 Yg/cKI1S0ccqcmHbbxqwJu8QdWbTbyY9aGdS7W0GMdWACbXeWEXMibFT2UW0bK4N8A
	 ndJPF9AzU/IaMd/KghcT93eJmQL8rRX+YTR5w5Iys8d/OvluCdJJMkoR/UKlCrjxa1
	 wjHjYRkP0Ufat6GTRpCGhF+jvjQVso4E62E2UQHdyXjdwETVpJMIP4NXLBD5PHdEvF
	 5eV9bvb0DQMo/4Eso5BNpjffDvhDV7Ryx+lWxbkEIe2g+aa2FaG35UsMr/mgIeYShU
	 JzXRNgLlAEmfg==
Date: Fri, 19 Sep 2025 18:03:13 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Rob Herring <robh@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] PCI: rcar-gen4: Add missing 1ms delay after PWR reset
 assertion
Message-ID: <3h3tkv6jmkwqqsb6bdotdx4bcnnzqqqzgl5digryxo5bc4qpm6@np76zatxj6ff>
References: <20250918231253.189906-1-marek.vasut+renesas@mailbox.org>
 <20250919100038.GA3918632@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919100038.GA3918632@rocinante>

On Fri, Sep 19, 2025 at 07:00:38PM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> [...]
> > Because it is the controller driver which can determine whether or not the
> > controller is in HSC domain based on its compatible string, add the missing
> > delay into the controller driver.
> > 
> > This 1ms delay is documented on R-Car V4H and V4M, it is currently unclear
> > whether S4 is affected as well. This patch does apply the extra delay on
> > R-Car S4 as well.
> 

What are the implications of not having the delay? Just asking to determine if
this patch is a stable candidate or not.

> [...]
> > -	if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc))
> > +	if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc)) {
> >  		reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
> > +		fsleep(1000);
> > +	}
> 
> Would it be a prudent thing to do here to add a comment over the fsleep()
> or over the if-statement to document briefly (and for posterity) why we
> sleep here?
> 

I can add the quote to the reference manual while applying.

> Otherwise, looks good! Thank you for fixing this potential issue.
> 
> Reviewed-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
> 

Thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

