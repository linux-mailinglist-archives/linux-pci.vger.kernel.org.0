Return-Path: <linux-pci+bounces-29442-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 053A7AD55DC
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 14:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E91AA1BC272A
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 12:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D400283132;
	Wed, 11 Jun 2025 12:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbAxg+9a"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DB0283136
	for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2025 12:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749645907; cv=none; b=HxZ6wpkqMdk0VkP+HL/ZAtAq62IbEMo0WDB8FEDLWGF9V8DlkiLhm8inCGJ7LGIwWtGx3sGUSLMrDelduRR4jG1/qAQeH4NF+pSBe9USgNatV/UCxBOoMRoq57jcFXR628xfiVKg/fIplAwiX8Qjt+UyWOPzyekYZicxgZQoGd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749645907; c=relaxed/simple;
	bh=/kmCKfxck2XTpbBSQv0jQXrhAcyXqrNF/ZI1zjeFLwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUGpoFpRbBCZn6x1//GZUwTFVdi40dgJszzyl4OCfqfqlN+Y+1kavuGOxS/1zRz/pa28D3rnDnEI2dpeY4EaHX5aDYfWAvsYXaOp7aGI0YT4dF3D3KZy1duyNQiBPtKGtvyalr8E2rc/BkX0wfwmwUAFAvxwOQrMYP1+HuamYGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbAxg+9a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA24EC4CEEE;
	Wed, 11 Jun 2025 12:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749645907;
	bh=/kmCKfxck2XTpbBSQv0jQXrhAcyXqrNF/ZI1zjeFLwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MbAxg+9al+qRba03aM3fWzZ2UnOKiFpEDVqSmMO8pAarU29GhtJNb4SpAv567flcR
	 6pDt41ZiGqLOKU4FjE+QhULleCibYfLnHyCNT6dreeK4At9I7qbZCkt/JoftAbI+Ux
	 kv+c/EMZZdG8p9W6LHuBPOrIwpwj5igjSWCZXbcVQW/d43rCBp5DfNmzFYH+MI+Ace
	 Yb5N6jYdIa1QFTwzL//jL3Xhws8ncn7jrSC7nUNkLcXslH8QrcZrjWiXq8U+FS/oVx
	 5SUpiPy20Pn7lXmCVcKaxV/fy/1b2ghPLm71pgjIB+XdolhkTLo4C3ZmcZLYaMNtqh
	 5XkacYFhuGRxA==
Date: Wed, 11 Jun 2025 14:45:02 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Laszlo Fiat <laszlo.fiat@proton.me>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/4] PCI: dwc: Reduce LINK_WAIT_SLEEP_MS
Message-ID: <aEl6Ti18IpqG7arA@ryzen>
References: <20250611105140.1639031-6-cassel@kernel.org>
 <20250611105140.1639031-10-cassel@kernel.org>
 <bf1edd8b-cfe4-4ad1-b001-c4297047f9c5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf1edd8b-cfe4-4ad1-b001-c4297047f9c5@kernel.org>

On Wed, Jun 11, 2025 at 09:38:31PM +0900, Damien Le Moal wrote:

(snip)

> > -/* Parameters for the waiting for link up routine */
> > + * Parameters for the waiting for link up routine. As per PCIe r6.0, sec 6.6.1,
> 
> s/for the/for
> 
> and maybe reword this to something like:
> 
> * Parameters for waiting for a link to be established.

This sentence was there before I appended to the comment.
But sure, can fix it in V2.


Kind regards,
Niklas

