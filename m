Return-Path: <linux-pci+bounces-34784-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C94B372D5
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 21:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69C3A5E2AB1
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 19:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234B52F0C5E;
	Tue, 26 Aug 2025 19:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaQSHnS3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8042367B3;
	Tue, 26 Aug 2025 19:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756235202; cv=none; b=q+COzQKUw3QE9SqE7t9JfgW5iirS/Als+z2kvoyu00hB4rMCdWerqqnBdzU4/0Q4s84E7F7UwipNSD9TFp4BBDDgx8UV6EJeiLISldqamZcQo82Oh/8c/tCiLh0ggLnssRrQekWqrxwIK+8flZpNlNqyD6RBVsvjGM2DHRy1Xmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756235202; c=relaxed/simple;
	bh=6w9yUwv0T5/Z+m1k8BZQg7uc2YnfJvOkWoSgNF9bXeM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kzE3TR8+79lNRXjhuVXSW7rA2vkGI9FaveJvnXiqRVbzoEuLHs9+hG0sMFdDQa8TJvn/ERAIa3P0aYMRG+M5HTt6uJRzOFZgNHzGH/SIfKG/3q7qURzD1rBHIhyqTvdPzydTcAZnSKTGD3wDwBjZgPTqi41LGV3GXhP18skaDc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kaQSHnS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56CE3C4CEF1;
	Tue, 26 Aug 2025 19:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756235201;
	bh=6w9yUwv0T5/Z+m1k8BZQg7uc2YnfJvOkWoSgNF9bXeM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kaQSHnS3le/rwziik0JJNdbdVjURvDk2GugtDrJfAzp5ucv6xeJjqHNEJ3pdkgbS/
	 dXdxRY4i5MW256F3Q2E9EaoTOex/suBhD8wqmximS6zKPtezh8nNbwT2RQZT3aclb9
	 QZ0j4++2ypl2mqtlBBwidVf5LHae3aijAFv1CyUIZqVdWYsE823cX6vP9BP6tC9H5K
	 Tkk9n5Fyl4CtHkDR4SJwt/+lJQh9fshE8Gw6MZMhwNhMVb3lp6yP4W+K+3lVAUAcMK
	 jORQ04xs//SWgdlzN4eJULMwqSdRgJYqpxZxLgMuEnS96ql6Vvww5Dxgt0celmRxzR
	 k+aP4eoPcAEuw==
Date: Tue, 26 Aug 2025 14:06:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>, Shawn Guo <shawn.guo@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"open list:PCIE DRIVER FOR HISILICON STB" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] PCI: dwc: histb: Simplify reset control handling
 by using reset_control_bulk*() function
Message-ID: <20250826190640.GA851938@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANAwSgS7g-J75wqyei3KXQuVjMRYE0WWnfkwDMdFG4FFNGJKGg@mail.gmail.com>

[cc->to: Shawn]

On Tue, Aug 26, 2025 at 11:33:17PM +0530, Anand Moon wrote:
> On Tue, 26 Aug 2025 at 21:55, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Aug 26, 2025 at 05:12:41PM +0530, Anand Moon wrote:
> > > Currently, the driver acquires and asserts/deasserts the resets
> > > individually thereby making the driver complex to read.
> > >
> > > This can be simplified by using the reset_control_bulk() APIs.
> > >
> > > Use devm_reset_control_bulk_get_exclusive() API to acquire all the resets
> > > and use reset_control_bulk_{assert/deassert}() APIs to assert/deassert them
> > > in bulk.
> >
> > Please include a note that this changes the order of reset assert and
> > deassert and explain why this is safe.
> >
> I feel the device tree follows the same order as defined in the array.
> 
>      resets = <&crg 0x18c 6>, <&crg 0x18c 5>, <&crg 0x18c 4>;
>      reset-names = "soft", "sys", "bus";
> 
> Ok I will update this in the commit message.

Following the device tree order doesn't necessarily mean that this is
safe.  We know the current order in the code works.  We don't know
that a different order works until that's tested and verified.

These will both need acks from Shawn (pcie-histb.c maintainer).

