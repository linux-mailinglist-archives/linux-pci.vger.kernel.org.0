Return-Path: <linux-pci+bounces-7270-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFF48C0602
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 23:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE40A1C2109F
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 21:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77236130E26;
	Wed,  8 May 2024 21:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ryAT1UiX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B7D130AF6
	for <linux-pci@vger.kernel.org>; Wed,  8 May 2024 21:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715202231; cv=none; b=Jeupk1hDJqQlQCM5oMei1ujnOtPUKHLTgM516ySurBUXoty2+/21H2hHXX4QkDBpUeyV2Jy5o0S8FpwL+rjjy8HFJHqJEAI46BYvz7qVRj4HzSxB1EiK1kyqt6lTALBD6VAmRkPNNAtzI6R6T0R7LlEh005gGJaSG6BjU4XwyeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715202231; c=relaxed/simple;
	bh=vKS4hBk0ebX4QdGYChUaZeKVeMstHNsVpRUR7tHyDUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNdkHiuZZZSRu7GBlYuCvqRFXujdBnY7MV42mTcRs5lyDtRpSOOo10zIeUPueJCIdN9qo44sxgNN/kMTfSL6v1+mLycnnqUyTHjE+rI8+eIn4kPxR9lZOZeoKD6qbyuaronQrc34KmrZLGBnUxqHyXBEKODDvJVm+Br7kPGyXZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ryAT1UiX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ECACC113CC;
	Wed,  8 May 2024 21:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715202230;
	bh=vKS4hBk0ebX4QdGYChUaZeKVeMstHNsVpRUR7tHyDUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ryAT1UiXGQs6hb96NiFYjTQTWIxL02vYMrWLQ0queRS9mhyYh+6tf3mVwgC/fkBgm
	 2C3IZ464JBdQyPU0KiGFTXHe9N9koFv/+lGoaAmCDfH3XYQl7+gS7NFeyz5MyVlWqA
	 MXBWH0h3gFUcOQF4zsGHdxBTDTjro5YjYZ/6r+Bne9IosDnzb5wE3UDE7COjtCOW1N
	 qPyLvjgSncPhif4l01npqp1B6wZWuFCIr0uYoykJ0VA01/T0hWPq9sSQrg1+tOx+mz
	 WRfq93eOZ6FDW1zCZt5j6QhRDWlTgkpobDmcYxF3zDIIaptgc6y+hAR4HBjIiq0rm4
	 HHzZ8jgUXflrA==
Date: Wed, 8 May 2024 15:03:48 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-pci@vger.kernel.org,
	Suganath Prabu S <suganath-prabu.subramani@broadcom.com>,
	Peter Delevoryas <pdel@meta.com>, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] pci: fix broadcom secondary bus reset handling
Message-ID: <ZjvotAoAGFdg3p2u@kbusch-mbp.mynextlight.net>
References: <20240501145118.2051595-1-kbusch@meta.com>
 <20240501195534.GA853546@bhelgaas>
 <ZjNTI1E3DnGy59Iu@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjNTI1E3DnGy59Iu@kbusch-mbp.dhcp.thefacebook.com>

On Thu, May 02, 2024 at 09:47:31AM +0100, Keith Busch wrote:
> Yeah, you're right. I started off quirking specific devices, then it
> evolved to the more generic handling this turned into, but didn't update
> the commit log or comments accordingly.

Quick update, we're testing configurable options to modify the pcie port
behavior, so a kernel-side update may not happen if that is successful.

