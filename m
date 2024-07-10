Return-Path: <linux-pci+bounces-10091-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E0092D811
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 20:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBD881F239B1
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 18:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AE5195804;
	Wed, 10 Jul 2024 18:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evhiNZid"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A8E1957F5;
	Wed, 10 Jul 2024 18:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720635132; cv=none; b=siR7N3frqPjuvFPW+G3M3hWRHP9Kwl5SrtslLLTZX2jI7GdwjuSImc2DRJbo/t/NLZ/7VUS0vpSlv5zcdIGbNv+VH7qi9Qqk9ol9qi/vKswhGaKuq6GZXTHEe+vzyNjpoyOxl+Cj5JKsIBta8XBKb1UPw0wFYbxQ/nHEdqcwcjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720635132; c=relaxed/simple;
	bh=z+wirWBsOp9GoI8+mq4qyfgFFTtVOQxQrjPZpKutIFY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RVRvemglIlQW3LSYefPRavCIFNK9EiUcRtKOtxGbm2eI70S5R+fcMy6vmG0NC1l9ekd1sR76B9vDUn5Z5fy4oyTSNkwq+ZrcGKxHIugUQ7GJZ3qvieCaqG2qKf8py88/lrfSuBl8nBq39kLCxxFvirLmzalMHxveAIVPt8Gsxus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evhiNZid; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58264C32781;
	Wed, 10 Jul 2024 18:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720635131;
	bh=z+wirWBsOp9GoI8+mq4qyfgFFTtVOQxQrjPZpKutIFY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=evhiNZid8jGNfR9iPBp6wi4BB2/I2vs5ugDgTPT0JapU0xhvW2ALsW2AQd038Bdvi
	 lJFI4amR48wrpu6Wssl/65G5wSQot2jB17DVh5jIOs+V+9Tf+leI8HocW7IyuT//gp
	 RGwOk90Zo/bk/sWIx+ounMA/4UayFFeqd7Xa4qDRNlsnEdNGyrGsNbli4xYJyYqbEh
	 ullG2r0mLmfvnHMMccLWxEnjiUT7Q2Wg6mMI6MFJ9LvlwBUTy8aBjB69uiYPw+Bhkd
	 Mshi8Jo+odkLaujSatlDF1khUciKNICmCOVaDOGFzi7MdZtvBbQLdJmF5lv1NW358E
	 mqCgijziM8Hrg==
Date: Wed, 10 Jul 2024 11:12:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Sanman
 Pradhan <sanmanpradhan@meta.com>, Andrew Lunn <andrew@lunn.ch>, Alexander
 Duyck <alexanderduyck@fb.com>, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, kernel-team@meta.com
Subject: Re: [net-next PATCH v4 00/15] eth: fbnic: Add network driver for
 Meta Platforms Host Network Interface
Message-ID: <20240710111210.0d9bea99@kernel.org>
In-Reply-To: <172054602727.1305884.10973465571854855750.stgit@ahduyck-xeon-server.home.arpa>
References: <172054602727.1305884.10973465571854855750.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 09 Jul 2024 10:28:30 -0700 Alexander Duyck wrote:
> This patchest includes the necessary patches to enable basic Tx and Rx over
> the Meta Platforms Host Network Interface. To do this we introduce a new
> driver and driver directories in the form of
> "drivers/net/ethernet/meta/fbnic".
> 
> The NIC itself is fairly simplistic. As far as speeds we support 25Gb,
> 50Gb, and 100Gb and we are mostly focused on speeds and feeds. As far as
> future patch sets we will be supporting the basic Rx/Tx offloads such as
> header/payload data split, TSO, checksum, and timestamp offloads. We have
> access to the MAC and PCS from the NIC, however the PHY and QSFP are hidden
> behind a FW layer as it is shared between 4 slices and the BMC.
> 
> Due to submission limits the the general plan to submit a minimal driver
> for now almost equivilent to a UEFI driver in functionality, and then
> follow up over the coming months enabling additional offloads and enabling
> more features for the device.

cocci says:

drivers/net/ethernet/meta/fbnic/fbnic_irq.c:42:7-27: WARNING: Threaded IRQ with no primary handler requested without IRQF_ONESHOT (unless it is nested IRQ)
-- 
pw-bot: cr

