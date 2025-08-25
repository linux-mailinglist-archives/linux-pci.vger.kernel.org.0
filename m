Return-Path: <linux-pci+bounces-34680-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABCFB34C01
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 22:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 611795E7A20
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 20:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FD328726C;
	Mon, 25 Aug 2025 20:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tF4bIDmM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B578143C61;
	Mon, 25 Aug 2025 20:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756153853; cv=none; b=PbXMmvfiGtxBWhsm+htiy3paNTh50pr/JXDaLxT9CKFcVb4rimsPIYp35pSkGwR52yDEiRMmknbm8Gd3mwzb3IVEKX1q8K7/sfld5LFRksR4gp0C620a4uBz0EwISxT+BfJizxXzmNuC1VVree4yu0saZgzNFhFM9zcKX2BT7O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756153853; c=relaxed/simple;
	bh=8UDkz5+NJHjlqMVM+f8LGxpXdVjoPt8deai+stcazdA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=D6xoyKo/Vp++EL/u5VaHCsc5PmH5UqLVeqz0EH+6BaWiQlc736ACJUmLwpvlSLsI/ss8yFjD0jzeCqiAUsTxttmAi/DOCcXHfNZRusiVG77zmGdwdex+L+QmCQwuZktnz7rocrcZqH3oLX3i5r1eDS8nIHNNlsipfAke0MmWm2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tF4bIDmM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6827CC4CEED;
	Mon, 25 Aug 2025 20:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756153852;
	bh=8UDkz5+NJHjlqMVM+f8LGxpXdVjoPt8deai+stcazdA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tF4bIDmMrI43+36ns282EzHgvHkI1i4YU+8BiDurmsJWEvkIFY9tKfNWG7zi+5mEi
	 mDj8DCkKcqIgvxoY4k5kGBu2IHL0cJNNjj1gNRllclvDGlVxUbxrxck30YkO8OhAg1
	 YijnnsbnnRY8DQM2+QLc9Qt1p9Sn35QY/NTdncXDbhFeSzPfG3WtaYLwpmS0deC/tN
	 PN8ARJ7M1uzf8j8gK6Ymr1BMDqvy7dfy4m9KTi7ILTRvaTmqzmx2d/eA3+8GSq5Khb
	 pu98XSpDRMOh1iRkMceIUz2IDK0Sr+spT+Z9fMI1w3TgOyQ0F3sj6E5lZkLpQROCLL
	 HJ8rJD+TbgFQA==
Date: Mon, 25 Aug 2025 15:30:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] PCI: Replace short msleep() calls with more
 precise delay functions
Message-ID: <20250825203051.GA781401@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155f9f4f-45e4-45ea-85c2-de67115bd12c@163.com>

On Mon, Aug 25, 2025 at 12:05:26AM +0800, Hans Zhang wrote:
> On 2025/8/23 00:46, Bjorn Helgaas wrote:
> > On Fri, Aug 22, 2025 at 11:59:01PM +0800, Hans Zhang wrote:
> > > This series replaces short msleep() calls (less than 20ms) with more
> > > precise delay functions (fsleep() and usleep_range()) throughout the
> > > PCI subsystem.
> > > 
> > > The msleep() function with small values can sleep longer than intended
> > > due to timer granularity, which can cause unnecessary delays in PCI
> > > operations such as link status checking, reset handling, and hotplug
> > > operations.

> > I would split this a little differently:
> > 
> >    - Add #defines for values from PCIe base spec.  Make the #define
> >      value match the spec value.  If there's adjustment, e.g.,
> >      doubling, do it at the sleep site.  Adjustment like this seems a
> >      little paranoid since the spec should already have some margin
> >      built into it.

> patch 0001 I intend to modify it as follows:
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b0f4d98036cd..fb4aff520f64 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4963,11 +4963,8 @@ void pci_reset_secondary_bus(struct pci_dev *dev)
>         ctrl |= PCI_BRIDGE_CTL_BUS_RESET;
>         pci_write_config_word(dev, PCI_BRIDGE_CONTROL, ctrl);
> 
> -       /*
> -        * PCI spec v3.0 7.6.4.2 requires minimum Trst of 1ms.  Double
> -        * this to 2ms to ensure that we meet the minimum requirement.
> -        */
> -       msleep(2);
> +       /* Wait for the reset to take effect */
> +       fsleep(PCI_T_RST_SEC_BUS_DELAY_US);

This mixes 3 changes:

  1) Add #define PCI_T_RST_SEC_BUS_DELAY_US

  2) Reduce overall delay from 2ms to 1ms

  3) Convert msleep() to fsleep()

There's no issue at all with 1), and I don't know if it's really worth
doing 2), so I would do this:

  - msleep(2);
  + msleep(2 * PCI_T_RST_SEC_BUS_DELAY_MS);

Then we can consider the question of whether "msleep(2)" is misleading
to the reader because the actual delay is always > 20ms.  If that's
the case, I would consider a separate patch like this:

  - msleep(2 * PCI_T_RST_SEC_BUS_DELAY_MS);
  + fsleep(2 * PCI_T_RST_SEC_BUS_DELAY_US);

to make the stated intent of the code closer to the actual behavior.
If we do this, the commit log should include concrete details about
why short msleep() doesn't work as advertised.

> > I'm personally dubious about the places you used usleep_range().
> > These are low-frequency paths (rcar PHY ready, brcmstb link up,
> > hotplug command completion, DPC recover) that don't seem critical.  I
> > think they're all using made-up delays that don't come from any spec
> > or hardware requirement anyway.  I think it's hard to make an argument
> > for precision here.
> 
> My initial understanding was the same. There was no need for such precision
> here. Then msleep will be retained, but only modified to #defines?

The #defines are useful when (1) the value comes from a spec or (2) we
want to use the same value several places.  Otherwise, the value is
minimal.

For rcar PHY ready, brcmstb link up, hotplug command completion, DPC
recover, I don't think either applies, so personally I would probably
leave them alone (or, if we think short msleep() is just misleading in
principle, convert them to fsleep()).

Bjorn

