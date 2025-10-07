Return-Path: <linux-pci+bounces-37676-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A9ABC1F6B
	for <lists+linux-pci@lfdr.de>; Tue, 07 Oct 2025 17:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF8B3C01D3
	for <lists+linux-pci@lfdr.de>; Tue,  7 Oct 2025 15:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AB02E1C5C;
	Tue,  7 Oct 2025 15:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koG/RO7Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132432D839F;
	Tue,  7 Oct 2025 15:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759851727; cv=none; b=Ccbh01MPFK7u5IUrjWWSBdWFGxYDr1zOWD7FmkV3OSkmQf6ZSv5b5sQ7d9ibAIpOtGcls6dFffTRJ6eIx5M/r1hbkzFtn6j6RsOtFZtDDdKc+Z0qzsX9Q2fWOLOa7yY/66JgBhcKhyNtJoNQmGvZl693zSa87ryDN8XAJmVimss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759851727; c=relaxed/simple;
	bh=HTp9egI/EQqilYgnZaivf9/v+3moPdyBfRynwvlSPgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/UystIGYSQWZfG30KjjCougE0vBwkXEzV5s5AMgb8SBGEzBSidkk6JSVpiRI1g1NYPHZH8zMN896x8+l/Ej3O1qabjasaryxDxlTxsgH0b4WrZSFahNU+fPqmm33S1au09oNHf+3VSyhLySMUcSiravBOk4iXdXpzgPDmQXTgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koG/RO7Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7565C4CEF1;
	Tue,  7 Oct 2025 15:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759851726;
	bh=HTp9egI/EQqilYgnZaivf9/v+3moPdyBfRynwvlSPgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=koG/RO7YwUwyU4Ukbpsp6hMltCYanwGT4o0fM5KqKdCX9I0ufrlYnkpUoldu5N8jR
	 CWhiPdDp6RwhIIAl8Jk+SjZESiKj71yzvM95+H2hX2+Am6wAHb7cxzz3fXLI9kOzTH
	 fL/jJbvHZnQOp47jJ9FjZqzIj+0swbLZ4dnLgI7BLEwO0d7x5BjgoRPCHw1B0IpWzF
	 R4jdZtTdHFkKblkNv+JSYQ7tLSFRViyoYaL09AWZ8WDakaZZ7B6TXhJMGCQJm8W2To
	 DItFaEW0HaRmiCQkdft+GW4zwsIeNln6tdXRqVDZlDCZ8MKPsbMdFmgg7nq050P4ts
	 D/BGskVpr9h4Q==
Date: Tue, 7 Oct 2025 17:41:55 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, chester62515@gmail.com,
	mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com, s32@nxp.com,
	bhelgaas@google.com, jingoohan1@gmail.com, kwilczynski@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com,
	Ghennadi.Procopciuc@nxp.com, ciprianmarian.costea@nxp.com,
	bogdan.hamciuc@nxp.com, Frank.li@nxp.com,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, cassel@kernel.org
Subject: Re: [PATCH 1/3 v2] dt-bindings: PCI: s32g: Add NXP PCIe controller
Message-ID: <aOU0w5Brp6uxjZDr@lpieralisi>
References: <20250919155821.95334-1-vincent.guittot@linaro.org>
 <20250919155821.95334-2-vincent.guittot@linaro.org>
 <iom65w7amxqf7miopujxeulyiglhkyjszjc3nd4ivknj5npcz2@bvxej6ymkecd>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <iom65w7amxqf7miopujxeulyiglhkyjszjc3nd4ivknj5npcz2@bvxej6ymkecd>

On Mon, Sep 22, 2025 at 11:51:07AM +0530, Manivannan Sadhasivam wrote:

[...]

> > +                  /*
> > +                   * non-prefetchable memory, with best case size and
> > +                   * alignment
> > +                   */
> > +                  <0x82000000 0x0 0x00000000 0x58 0x00000000 0x7 0xfffe0000>;
> 
> s/0x82000000/0x02000000
> 
> And the PCI address really starts from 0x00000000? I don't think so.

Isn't the DWC ATU programmed to make sure that the PCI memory window DT
provides _is_ the PCI "bus" memory base address ?

It is a question, I don't know the DWC inner details fully.

I don't get what you mean by "I don't think so". Either the host controller
AXI<->PCI translation is programmable, then the PCI base address is what
we decide it is or it isn't.

Thanks,
Lorenzo

