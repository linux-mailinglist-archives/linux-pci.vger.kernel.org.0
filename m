Return-Path: <linux-pci+bounces-19490-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8775BA05286
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 06:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27B6518885A1
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 05:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC051A00D1;
	Wed,  8 Jan 2025 05:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="DdZ8lsYt"
X-Original-To: linux-pci@vger.kernel.org
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E366919CC14;
	Wed,  8 Jan 2025 05:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736313164; cv=none; b=K5pDHql5FwLJKM04GtbI7SeJP2b6d4yjamuFbJMjNNUL1DnoAOEKghdBUYWPqSmnXwz6eFf+6CZkMwet6hPMPTJaQ57xmLn8uAVuoc2HhAQ2qXKqHPiVa8FKEc4P3M+J4Hvg+uiKnp9K3RoPo/qYuTJ73CleaRExg3IMulkmhto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736313164; c=relaxed/simple;
	bh=khBrMLfjUOheD5NaxrhTuBlaiuDNNaFmShvp6bqtsj0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=fECznJ7iTh8u+tzh/WEaYGjwCi0omVmWlKXCgm2mj15z+t3OWHmQyX2slaY/24SvNf/5p5NiRJcMdzz7QMN7T235SJNlVXj04fpJnxb3xMFMnfmosA7cIdEAfgEmr/0wEtztWVUnFiI3D9isHPmQzPfaczBxDdR5XqdtJkc6PEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=DdZ8lsYt; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1736313157; bh=xLoT2B7MZW5ZVyM6/KQK5x4O9Hsj4Lww6F+8a3FHJYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DdZ8lsYtvhGXChb/UokKL1PKMGphOBReachvAigfrn4Y9v1jYHJ0FfwNyerf94L7k
	 jfEVTbh8Qg4lUNU+GQCWQTn9ZFlRl5DCsHok+VLQvjWQ1tj9DLvQr0tBcKH9PKqLRu
	 eQm76AJd6CtCC5J90cNwVHhesTmK9+zqID/cmfdw=
Received: from Ubuntu.. ([240e:305:25d4:e300:6504:4e8:136:29f6])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id ECB9905B; Wed, 08 Jan 2025 12:59:11 +0800
X-QQ-mid: xmsmtpt1736312351tvaoiggkk
Message-ID: <tencent_D3EAA236B531BDF17998832CC18EC36CBC07@qq.com>
X-QQ-XMAILINFO: NpQVNvxcCxoX8TNGU8NY7MBWaducvYQ+XDS3twY6HHTAjZovsDwcVCRUoQ7nVY
	 /32fTYslzR54mHn9DV2e64peiTX8ckRqv3GOIJIqpgM8dBIiSJ0Z1e/z96exUqNkYWJudpubPWg0
	 dBvaHGL2lQhk/L+KMbpNXaSVqbz3aWqt+nBr71ga99aKypBFzC8VNwQU/6yTh+04FrEBn5yOABfK
	 k1dTwwyBRPIOoZ+ZaeTK2Ne3Id2r5KRzfB7roRgxUTRi/k5TShwSx7QUtZwf24dmopkr5aAYXNHX
	 bYIkO2sOqXEVXPZrVfAm2RK7y1vE4T9xF1SygklGhli/cOZ19c8wognw82/X+78gqAPY9JjC5FKM
	 5ywlBFYVN7CWzathtyFGMWXF+MGrWp9VkV8AbXKisS/uyj29LJoAwemZ1FFdIcuQFD8CV9eeZUne
	 TFXBE6M1gzh9chDeWPHEKhab75SmEUULcHOOAi2jeUXIKz4+8V6fXFV4MdTZr9m/O8vS1UcWf1kN
	 nNI2uTHe4BMelRwOW59ZJnEKpqDDeGBAITLC3T3jrLfxWKbM6+hdOLohQ+aQY2BlZ8srNGnT1eRH
	 upX5Z6JNc+n7SWkmgyMz14Qx1Zp2D6iKEOeY39K+t8uCj+/k94Ib5NyDXqGKcrW7D1/qzTgLQ4KF
	 ZBjrDyJzUiw67r1P5FKlM08yvGktd6wvC+oc5VidELrGFV/RaQdjx+Et/0NgaCUAHpU43QG8deK5
	 ekCcpX0pezYV6+tRfYKFuK4pazqfBfmfb9fg4Is7qkA7QYC55kQSbWXp+nyWhdmPalKSjUQz1k/d
	 zhxQx9fjnvAqcTcer3burJnTp5S1kZpqBl38ih5Kz7meu0HsC8uJUpDAMUz1hi0Ceppm1PQz7zqX
	 J6vXKeZLnFR4NOnv/ibX1mS/mRmiNtzbnvDCNb9xyridTRqnfFNz6ydjeckzlAt0DFLEh+XndOyh
	 g1y6kJsYee4vWB3nt27WUdVHSay2xyJLb9R8EM6/kp9apmRXA9mXi5NTC2P34JqxVU4Fx7udZ3/G
	 269AphT98A6Dzl6VaCcHjbM3SrK03Vzmf4fKoHVzQutu6LZbrK0tkPCtBmtQGbcoaXbBEEt4WN/H
	 GjlKqprDTgJU+jNOk=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: kingdix10@qq.com
To: helgaas@kernel.org
Cc: bhelgaas@google.com,
	kingdix10@qq.com,
	kw@linux.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	marek.vasut+renesas@gmail.com,
	prabhakar.csengg@gmail.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	robh@kernel.org,
	yoshihiro.shimoda.uh@renesas.com
Subject: Re: Re: [PATCH v4] PCI: rcar-ep: Fix the issue of the name parameter when calling devm_request_mem_region
Date: Wed,  8 Jan 2025 12:59:11 +0800
X-OQ-MSGID: <20250108045911.2112164-1-kingdix10@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107225653.GA189000@bhelgaas>
References: <20250107225653.GA189000@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2025-01-07 at 16:56 -0600, Bjorn Helgaas wrote:
> On Tue, Jan 07, 2025 at 09:51:23PM +0800, kingdix10@qq.com wrote:
> > From: King Dix <kingdix10@qq.com>
> > 
> > When using devm_request_mem_region to request a resource, if the
> > passed
> > variable is a stack string variable, it will lead to an oops issue
> > when
> > executing the command cat /proc/iomem.
> > 
> > Fix this by replacing outbound_name with the name of the previously
> > requested resource.
> 
> Thanks a lot for doing this work!
> 
> Add "()" after function names in subject and commit log.
> 

Thanks for your review. I will fix the issue right now.

> Please include a couple lines of the oops message to help people
> connect the problem with the fix.
> 

This is a potential issue that I found while analyzing the code. I don't
have the conditions to reproduce this issue, but I can write a driver to
reproduce this issue in QEMU and obtain logs for reference.

> I suppose you found this by tripping over it.  Can you look through
> the other callers of devm_request_mem_region() and similar
> interfaces,
> at least in drivers/pci, and make sure there are no other similar
> errors?
> 

I've already checked that there are only a few calls of 
devm_request_mem_region() under the drivers/pci directory, and they
are all correct. 

> > Fixes: 2a6d0d63d999 ("PCI: rcar: Add endpoint mode support")
> > 
> > Signed-off-by: King Dix <kingdix10@qq.com>
> > Reviewed-by: Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > Changes in v4:
> >   - Add more information to the comment.
> > Changes in v3:
> >   - Fix the spelling issue in the comment.
> > Changes in v2:
> >   - Fix the code indentation issue.
> > ---
> >  drivers/pci/controller/pcie-rcar-ep.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-rcar-ep.c
> > b/drivers/pci/controller/pcie-rcar-ep.c
> > index 047e2cef5afc..c5e0d025bc43 100644
> > --- a/drivers/pci/controller/pcie-rcar-ep.c
> > +++ b/drivers/pci/controller/pcie-rcar-ep.c
> > @@ -107,7 +107,7 @@ static int
> > rcar_pcie_parse_outbound_ranges(struct rcar_pcie_endpoint *ep,
> >  		}
> >  		if (!devm_request_mem_region(&pdev->dev, res->start,
> >  					     resource_size(res),
> > -					     outbound_name)) {
> > +					     res->name)) {
> >  			dev_err(pcie->dev, "Cannot request memory region %s.\n",
> >  				outbound_name);
> >  			return -EIO;
> > -- 
> > 2.43.0
> > 


