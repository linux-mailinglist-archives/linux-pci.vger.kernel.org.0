Return-Path: <linux-pci+bounces-4919-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5678806D2
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 22:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B83E4B21918
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 21:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D35B3EA77;
	Tue, 19 Mar 2024 21:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5DmDjNg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497793BBD5
	for <linux-pci@vger.kernel.org>; Tue, 19 Mar 2024 21:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710884170; cv=none; b=CA6SyC113v7JPlq1cMVrRELHE1J0tlCi4F9LdMzOU5+DH01TRtKuzptLuQNcYUP3cLU0hvw0t5eGFWLZNiZ6XkXSdeoKCJu2daESYdHsxRQCnDAJTe6ZKeoyxyc2MtwVrCGHMuWfI0ytbDvr+5u8njo8X3YngSh3E0xhVyAkbR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710884170; c=relaxed/simple;
	bh=nZH7U2duuFJTJMLQp2doBhMTZXd7KpVSp2Z+6uKvV5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PM71h8BEW/+oQTgjimIoYl+GXtDnV7rePLW466j6geH8oKNw/cw4fwiERjaYrPDOnFbSXNfAFfFjFhaQ7zFNA5VtA6MRr1fLfj+JLr+hkiX5pGNybdbKcftoUBK6qgQ8bC2mv2p6l1M2IZLuRmXIKZx9r50WuHCu53c0yo7woPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5DmDjNg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2155AC433F1;
	Tue, 19 Mar 2024 21:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710884169;
	bh=nZH7U2duuFJTJMLQp2doBhMTZXd7KpVSp2Z+6uKvV5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W5DmDjNgjXGAZ+Klcj32kC7esaAzjck/Le6qQlQIQ9N/PRoP0PXs+m2E+X0iwa0ia
	 gedmKhTpkxOove6467FbW2Q7CTGGqw38tD4r6CKacyosAc/6pNC03Zj/Eopzm3pp+/
	 u2xLDCTMaqfF/udqCUwNPPBiAegZqidiPBiFxXkk9tACOakbxCMLsI5S0mALIrdBgn
	 GGxrAVZK3fuE1ezU0YxjW/WZbh30XYwjrtVO6JxWUD0/4X8L2Aoy4Znwxi5MeBjmQ6
	 O5JZ8V7nBAPWhLokS8HQaLYuTq2cQeP/JB/ZwIupwH86YrMonV/lb/KfZCigj9pu47
	 gcg6pgiVLb3PQ==
Date: Tue, 19 Mar 2024 22:36:05 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] misc: pci_endpoint_test: Use
 memcpy_toio()/memcpy_fromio() for BAR tests
Message-ID: <ZfoFRTAh9O88o8ZD@ryzen>
References: <20240318193019.123795-1-cassel@kernel.org>
 <8194c85c-cdc8-431a-a2fc-50569475b160@app.fastmail.com>
 <ZfnAATqpYlssxrT3@ryzen>
 <20240319164826.GF3297@thinkpad>
 <ZfnDHgqJOAVubbke@ryzen>
 <e284c1cc-0258-4363-930f-5b508855c094@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e284c1cc-0258-4363-930f-5b508855c094@app.fastmail.com>

Hello Arnd,

On Tue, Mar 19, 2024 at 08:55:19PM +0100, Arnd Bergmann wrote:
> On Tue, Mar 19, 2024, at 17:53, Niklas Cassel wrote:
> > On Tue, Mar 19, 2024 at 10:18:26PM +0530, Manivannan Sadhasivam wrote:
> >> > 
> >> > I did also see this comment:
> >> > https://github.com/torvalds/linux/blob/master/Documentation/memory-barriers.txt#L2785-L2790
> >> > 
> >> > Do you think that we need to perform any flushing after the memset(),
> >> > to ensure that the data written using memcpy_toio() is actually what
> >> > we expect it to me?
> >> > 
> >> 
> >> The documentation recommends cache flushing only if the normal memory write and
> >> MMIO access are dependent. But here you are just accessing the MMIO. So no
> >> explicit ordering or cache flushing is required.
> >
> > What does dependent mean in this case then?
> >
> > Since the data that we are writing to the device is the data that was
> > just written to memory using memset().
> 
> You need a barrier for the case where the memset() writes to
> a buffer in RAM and then you write the address of that buffer
> into a device register, which triggers a DMA read from the
> buffer. Without a barrier, the side effect of the MMIO write
> may come before the data in the RAM buffer is visible.
> 
> A memcpy_fromio() only involves a single master accessing
> the memory (i.e. the CPU executing both the memset() and the
> memcpy()), so there is no way this can go wrong.

Thank you for the clarification.


Kind regards,
Niklas

