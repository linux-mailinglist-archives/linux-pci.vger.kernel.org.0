Return-Path: <linux-pci+bounces-12911-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A1896FC70
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 21:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90BB4B24EB3
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 19:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2E41D45EA;
	Fri,  6 Sep 2024 19:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oj6JYw9+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBC81CBE8C
	for <linux-pci@vger.kernel.org>; Fri,  6 Sep 2024 19:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725652694; cv=none; b=mmjbqMx6LrzkjwzbheLAS3YeHQckP9sYTdYo8x7P3nofHqNEvgPPDCfcEf6C+zCdnHdn977jtzZoGtIOxbr/PCZENx7fbJ1E1nggi5s856K9O8/L0aSp+AbjbG/kKtYNZKQytbojvKGtHfEL8AwNNZlsjRaCZnzXbxBuBs9JJjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725652694; c=relaxed/simple;
	bh=q68srOg5WlhdKyMnrW0mwwT9+kBxLQEDtM7dpJ5d7tM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Cvf06TpfVcpeSbKYWKO2eRhWs8hDUHQKAblzJZAoBMcvnwp6zIlw+ZiwcT4Zo6oRj+yGvlMeSIGCWR1msFUb5L3/YHU0DKThT3ww/ik0rEjc0E6Jbe+3kSrXt8ZYzcflVLxvrx1qx2+Nr0sGxw6KYlkWWC5XSODqPdfapTvgTCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oj6JYw9+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D798C4CEC4;
	Fri,  6 Sep 2024 19:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725652693;
	bh=q68srOg5WlhdKyMnrW0mwwT9+kBxLQEDtM7dpJ5d7tM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=oj6JYw9+QaqwGc9EXWZ3FhqoEBTSe/Bbz9oIt0U33UWG1qLlSJHehiY6i52uuURBn
	 0Wah8D0ukKvy07WzPJxTbuYyKyYnbAjPVWsS5jMP5sDQV4g7agtkSNHxFefD+n7NZq
	 qrMQiB0oT4tGZgqFh5cPe8JqKEGeLjime84Q+pVNdKKBXsbyb6joGB4jXF6662OWef
	 +I26GLwz/86IA7MGwRoo0JDvsj8A+vnhVwZHzylHigDbyRgbBJLVKGFZlQ1aKjuYDA
	 mEurmiyN1elbQpP2jRiiWMczDWDnXZsgibBXEZK0DK3CsRAn+SmIBCNiN4sax3dIc9
	 pVHLR7oOcNGlQ==
Date: Fri, 6 Sep 2024 14:58:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Frank Li <Frank.li@nxp.com>, Hongxing Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: legacy PCI device behind a bridge not getting a valid IRQ on imx
 host controller
Message-ID: <20240906195811.GA433355@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+vNU1=XqwpzREwo_aNoRwZrMMRpxw_9qvrUW=iU=5u5PjReg@mail.gmail.com>

On Fri, Sep 06, 2024 at 12:37:42PM -0700, Tim Harvey wrote:
> ...

> I have the hardware in hand now as well as the out-of-tree driver
> that's being used. I can say there is nothing wrong here with legacy
> PCI interrupt mapping, if I write a skeleton driver that uses
> pci_resister_driver(struct pci_driver) its probe is called with an
> interrupt and request_irq on that interrupt succeeds just fine.
> 
> The issue here is with the vendor's out-of-tree driver which instead
> is using pci_get_device() to scan the bus which returns a struct
> pci_dev * that doesn't have an irq assigned (like what is described
> in
> https://www.kernel.org/doc/html/v5.5/PCI/pci.html#how-to-find-pci-devices-manually).
> When using pci_get_device() when/how does pci_assign_irq() get
> called to assign the irq to the device?

Hmmm.  pci_get_device() is strongly discouraged because it subverts
the driver model (it skips the usual driver probe/claim model so it
allows multiple drivers to operate the device simultaneously which can
obviously cause conflicts), and it doesn't play well with hotplug
(hotplug events automatically cause driver .probe() methods to be
called, but users of pci_get_device() have to roll their own way of
doing this).

So I'm not aware of a documented/supported way to set up the INTx
interrupts in the pci_get_device() case.  

Bjorn

