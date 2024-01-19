Return-Path: <linux-pci+bounces-2349-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E07832957
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 13:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8B101C2318E
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 12:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5904EB50;
	Fri, 19 Jan 2024 12:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dzf63w38"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2DC24B5E;
	Fri, 19 Jan 2024 12:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705665994; cv=none; b=fys6OQ99osjyzRICREgt0Q1bBkwsI/KGicaQMu40XD7meewM0qbuMTQpFiy9neeYisZr/6ph6zLPwhhWUP2q0Mc5zQpAIa/NKzbiGKlaONhw1VYcmpRi/UgVRs4GmJrIPnuuu8bzaKo+C+dIMS8Z2gkGwjks03NJ7RgXdjaNUpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705665994; c=relaxed/simple;
	bh=LBIinFDQssszesoyzQPNn2bzAGez/p/FgFeNd9nRoPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBqXhkYkB9xWDUTfKWYapBY+MzZa8PzZOMXSzGo7RzN6XI6J2G75YoGWMRBi+/fe5YAwM/iQ7a2/LKoqdU9gE9nW4rJYUmN6364Gv7OQAtb1+pTYJ0E8gA/SWR1QnZe1cvnduhJIuImNI72CwF8iTzo31P3zxuwXTMp64OkNLFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dzf63w38; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4189CC433C7;
	Fri, 19 Jan 2024 12:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705665994;
	bh=LBIinFDQssszesoyzQPNn2bzAGez/p/FgFeNd9nRoPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dzf63w38v7dlUTgAIqcLppeDR+nGt9/JIRhA9/bG61yf19p8IdvCgX9LBivADSAJU
	 w+Q4QLT1vJ96II4+Ta6i+0pj7xJ9MnuB0CVMXqJJBUI4H0xsx3a7+QPQoPqTFD49gj
	 3p6ymRZbRnmASiaz0WW2c7EgqTiwo1rUhQVe0y0DdEY9EDe+0kefUHA8rk5ZErzFcn
	 dQTYyQQ1qeLWhqkxRADyUQHK7WdPDZKtMEdGI2hfMpH2ZBKfFxGWr062UPpToZlbwC
	 l/GJMlJPManWJboM3t0FdGR2o5odak1+4mooWI4+AyvmU2gYe4IZ4Lu7QaYM8U/f3y
	 gkOx5Io65uLJQ==
Date: Fri, 19 Jan 2024 13:06:25 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Niklas Cassel <Niklas.Cassel@wdc.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] PCI: dwc: Fix a 64bit bug in dw_pcie_ep_raise_msix_irq()
Message-ID: <ZaplwRta8wqczSzW@x1-carbon>
References: <3f9f779c-a32f-4925-9ff9-a706861d3357@moroto.mountain>
 <ZahE455neE3wPnHA@x1-carbon>
 <501533ad-7671-46aa-a034-91e0a6322e6c@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <501533ad-7671-46aa-a034-91e0a6322e6c@moroto.mountain>

On Fri, Jan 19, 2024 at 11:25:51AM +0300, Dan Carpenter wrote:
> On Wed, Jan 17, 2024 at 09:21:41PM +0000, Niklas Cassel wrote:
> > Hello Dan,
> > 
> > On Wed, Jan 17, 2024 at 09:32:08PM +0300, Dan Carpenter wrote:
> > > The "msg_addr" variable is u64.  However, the "tbl_offset" is an unsigned
> > 
> > Here you write tbl_offset.
> > 
> > > int.  This means that when the code does
> > > 
> > > 	msg_addr &= ~aligned_offset;
> > > 
> > > it will unintentionally zero out the high 32 bits.  Declare "tbl_offset"
> > 
> > Here you also write tbl_offset.
> > 
> 
> That's so weird...  I can't imagine how that happened.  Do you think it
> could be a Welsh mice situation where forest creatures are changing my
> work when I'm away from my desk?  https://www.youtube.com/shorts/h8gkIbtaaek

Yes, that it the most likely scenario :)

In fact, I think that is what happened with my original patch too...

Because while the C-standards says:

"""
6.5.3.3 Unary arithmetic operators
The result of the unary - operator is the negative of its (promoted) operand. The integer
promotions are performed on the operand, and the result has the promoted type.
"""


Of course, I also remember that implicit integer promotions are only up to
"int" or "unsigned int".

Because of course it is fine to convert types smaller than int implicitly...
but bigger than int? No way! :)


#include <stdio.h>
#include <stdint.h>

void main()
{
        uint16_t val_16 = 0xffff;
        uint8_t mask_8 = 0xf0;

        uint32_t val_32 = 0xffffffff;
        uint16_t mask_16 = 0x00f0;

        uint64_t val_64 = 0xffffffffffffffff;
        uint32_t mask_32 = 0x000000f0;

        uint16_t res_16 = val_16 & ~mask_8;
        uint32_t res_32 = val_32 & ~mask_16;
        uint64_t res_64 = val_64 & ~mask_32;

        printf("16: res: %#llx val: %#llx mask: %#llx\n", res_16, val_16, mask_8);
        printf("32: res: %#llx val: %#llx mask: %#llx\n", res_32, val_32, mask_16);
        printf("64: res: %#llx val: %#llx mask: %#llx\n", res_64, val_64, mask_32);
}

output:
16: res: 0xff0f val: 0xffff mask: 0xf0
32: res: 0xffffff0f val: 0xffffffff mask: 0xf0
64: res: 0xffffff0f val: 0xffffffffffffffff mask: 0xf0

(Silly me for not also reading 6.3.1.1...)


Kind regards,
Niklas

