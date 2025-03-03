Return-Path: <linux-pci+bounces-22786-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F1DA4CC9D
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 21:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64C10164BB5
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 20:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581922356C0;
	Mon,  3 Mar 2025 20:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CA0U5ezT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCD72356BB;
	Mon,  3 Mar 2025 20:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741033290; cv=none; b=q8Lxg45LkZWLedCqDRhbPIN/PYjgCdcXgPFXTi5+NAr3TdEUkiXduu1vUvxRoORuxiRo1XdiGYjT6+Xkv3MKurzFB8rdASG0qCycTBjLvprFxnnKq0qWqx+fV3bL+mGnszjbs8wqDSMhhCP/uv21mYJ/balocWZutQiYWj0wbuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741033290; c=relaxed/simple;
	bh=L1FVfq5kHaEDSv0B9ekqY7PhYzWtuPIPPs36lrR+kZs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sCpmhMviaSJB8mvn0vjX6bUKtMRddWMVRy0ydJqSn567mGojhPBUdu7op7xKqUJXpWUvOp+3KAph8WP/hQt37ltCczeeIwT+5IXZ8hmg4QRI6asoGrCf3E+ntYmuyCN9lNE/mL9n0wznPp/Qvf1ethZcGDo0yak6BBO9vEAyprs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CA0U5ezT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D875C4CEE5;
	Mon,  3 Mar 2025 20:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741033289;
	bh=L1FVfq5kHaEDSv0B9ekqY7PhYzWtuPIPPs36lrR+kZs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CA0U5ezTL/YZL7+MPX+P6Lz5t+0vJ/FN1B7f/zAPgQEGa4rYfMHfAVcuLRXP8xGmS
	 o9HI76pE5tN+cO4JhMiQuy7AU5YvDgI0b1qu7JGL+U93SGFTwUHyNGALpJ2Gt38+tQ
	 lzw/RtrPpTefXBUivWrgomjIVUgKp/orvUC7ToV1dGGswJQixBC1/0mCCAM/GLE/es
	 RMyOvRF00u/2qwt37P2a7O52Eh8eGTyyFN6Ixc0d1/oxKXp1RutQYvxaxkJvD1JKY/
	 bky05s8pLAEhFm53dt4Oj1+5Bxh0yF/2z08HpQIBLjt3Gnvrd0sOMfCcbiA2rK1yYb
	 MEwTLpdM6zQBQ==
Date: Mon, 3 Mar 2025 14:21:27 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: =?utf-8?B?THXDrXM=?= Mendes <luis.p.mendes@gmail.com>
Cc: Marc Zyngier <maz@kernel.org>,
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu: Use devm_request_irq() for registering
 interrupt handler
Message-ID: <20250303202127.GA192918@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEzXK1qtSRVS0TYAwMHTYh=7edO604iRKuXMQNMO_MC+-hunQg@mail.gmail.com>

On Sat, Mar 01, 2025 at 07:49:23PM +0000, Luís Mendes wrote:
> ... I would like to offer my help for testing the patches with your
> guidance.
> 
> ... In any way, long story short I've read in some threads about
> mvebu that PCIe is broken, and I say that it is not, the secret to
> have PCIe working is to use a good u-boot bootloader. Many recent
> u-boot versions cause the PCIe not to work on boot and I haven't
> figured out why yet. In fact my A388 systems are working with the
> amdgpu driver and an AMD Polaris, a RX 550 with 4GB VRAM. I have
> been succesfully using PCIe with this old u-boot version:
> https://github.com/SolidRun/u-boot-armada38x repo and branch
> u-boot-2013.01-15t1-clearfog.

Glad to hear that.  Making this work with more versions of u-boot
would be great, and maybe we can make progress on that eventually.

For right now, I want to try to make progress on Pali's patches.  I'm
pretty much in the dark as far as mvebu and IRQ details, but it might
help enlighten me if you could collect these:

  - complete dmesg log, booted with "pci=nomsi"
  - complete output of "sudo lspci -vv"
  - contents of /proc/interrupts
  - output of "grep -r . /proc/irq/"

For now just pick one of your systems, probably the solidrun one since
that sounds like one that other folks might have.

Bjorn

