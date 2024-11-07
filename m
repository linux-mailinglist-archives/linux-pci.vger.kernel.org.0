Return-Path: <linux-pci+bounces-16184-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 257899BFA8F
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 01:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AC9AB21C47
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 00:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CB5376;
	Thu,  7 Nov 2024 00:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsQ0t20I"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF952621;
	Thu,  7 Nov 2024 00:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730938201; cv=none; b=M9yMITpiJUOwMSaqEM4LJFvjGsVw9gKjLbO5+z0sd/wOwNCfo/2nIR+aThtiCQiCCiqkKL1UBYuA45pOBqI8lxplMeB7HhlCftQ/Gt5Yjddzunv0vtZ4F8eXwlPCt/yP4ioSMoakt/w+NZwoTOgAUPfYCACD7tPpy3JpWzXvZro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730938201; c=relaxed/simple;
	bh=ahJJ66zHU05O74HVdHJzt0TPlEhGTsvZ3dF1zQoUn14=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r6g3F+JcMo/I+ENo3f5FvSrhxBnzT6Ppp7w0Ffs5HfoZW3Q+51EgRQKYRXWyH0GCutcJuhs2AzTNxur03senSYL8bFM2hLqRE1rh8xGM+uZ4C+1LTfRsAouAXG8fxiA1cyLSskDvkC8SKPcgcuCyyGcflL5FtNvhKshhwg2qZPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsQ0t20I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB8EC4CEC6;
	Thu,  7 Nov 2024 00:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730938200;
	bh=ahJJ66zHU05O74HVdHJzt0TPlEhGTsvZ3dF1zQoUn14=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lsQ0t20IwarFbJ2em6VqcpTNT2X+mVuMHAgvasRwD7LNz3KqPPAjmuy79qAsMUi5x
	 iSD3EiSrHUF+45lkum9NSMz7qLI5KgcJeKH15ObrWOWIOChavCj0p5Wq3SiNU97oe6
	 ltkzg1D5wDTFztIGseIaLdsHCHb1FyjYksIU8ZSobLt7DmSWOTrtson85eo/441p1L
	 ymOd74czcubFQaCVCOQTtP30rH0Hdc13vw7g9ut9oOO15v8c1WY5JwGBFTTpgYzi/V
	 I0U/VeBxLpw9r2MeITtxlxiLGPdST8eJMo53yLmnoY5s1hSfnAa0rX0HEJUwaHBSjj
	 4UFJ8m9Q2v6cQ==
Date: Wed, 6 Nov 2024 16:09:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Sanman Pradhan <sanman.p211993@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>, netdev@vger.kernel.org, alexanderduyck@fb.com,
 kernel-team@meta.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 mohsin.bashr@gmail.com, sanmanpradhan@meta.com, andrew+netdev@lunn.ch,
 vadim.fedorenko@linux.dev, jdamato@fastly.com, sdf@fomichev.me,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH net-next] eth: fbnic: Add PCIe hardware statistics
Message-ID: <20241106160958.6d287fd8@kernel.org>
In-Reply-To: <76fdd29a-c7fa-4b99-ae63-cce17c91dae9@lunn.ch>
References: <20241106122251.GC5006@unreal>
	<20241106171257.GA1529850@bhelgaas>
	<76fdd29a-c7fa-4b99-ae63-cce17c91dae9@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Nov 2024 18:36:16 +0100 Andrew Lunn wrote:
> > How would this be done in the PCI core?  As far as I can tell, all
> > these registers are device-specific and live in some device BAR.  
> 
> Is this a licences PCIe core?
> 
> Could the same statistics appear in other devices which licence the
> same core? Maybe this needs pulling out into a helper?

The core is licensed but I believe the _USER in the defines names means
the stats sit in the integration logic not the licensed IP. I could be
wrong.

> If this is true, other uses of this core might not be networking
> hardware, so ethtool -S would not be the best interfaces. Then they
> should appear in debugfs?

I tried to push back on adding PCIe config to network tooling,
and nobody listened. Look at all the PCI stuff in devlink params.
Some vendors dump PCIe signal integrity into ethtool -S

