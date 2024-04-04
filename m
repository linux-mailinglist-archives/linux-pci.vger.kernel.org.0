Return-Path: <linux-pci+bounces-5734-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 318BF898B4C
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 17:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F9E11C21830
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 15:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE8A1292CE;
	Thu,  4 Apr 2024 15:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8cAtd5B"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B324E1CF;
	Thu,  4 Apr 2024 15:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712245073; cv=none; b=BEFcj3J5XlmJbEj0g1eHcAav0/nZzsV79mKeqlORHPI5s9egs9j0Lpc58kuH5zrvkNQU2XJ8l2nX2svf9zDD1k+Few5bBF3nLOqTJ7LfaME41sKBF3AEW5eDUf3H9tQeZWDRg8pKxZwFXCU6STBnlPr2ST4I++KDwc/y/6+04aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712245073; c=relaxed/simple;
	bh=9fu+X/maWneGuPiNgyWhl6U6znKl47GH2p4fZ12Wj3o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WW/UfJZr7/LApO5FQVOLtS8xu+Wx15sezmPVVaQLF6vpf7UOc+A1XKzlLtM+4yLk9cOSc53V6P7RSRUbj6uytUXyrgLZ0R1m2kR0kPvbGWWzch+Kqtv8GEKBmZumGlCvUoP1IuiC96BRTI5CkRy+Nltn/BAtkezp0+sW/ygGBgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8cAtd5B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E658BC433F1;
	Thu,  4 Apr 2024 15:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712245073;
	bh=9fu+X/maWneGuPiNgyWhl6U6znKl47GH2p4fZ12Wj3o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O8cAtd5BVE8jvSlXSMkaoJ2QtiBFjh9hv2KWubOKFCo5E3VNTJ/+msGQl0jZHtLdL
	 rnF/qYH/QZe9Ap1VAE08ahPXm8DgPbbMsNF2lruMCDJC79yWgluVkwLLFwqqfclkEN
	 hVh4q4u04WOzG3zhhKFyRnbVhiij+jK+xv5zsv4HL3ZHpSNJ9ZysN37UQWFcRas5Fx
	 FVq0KkuhNZ9/G8Bv5MgCLSBb0MF/rrtfuRPEs6OMOWVsJNRTu4I5UCwnPxYcJClW0N
	 K4VQ3ZnRFTKZ/nKOnCg49dvCtSI8Az4oUGay4AxnZsdGYepOdxVbjUIY9VZUO10VnF
	 Khbpnd+8mtLoA==
Date: Thu, 4 Apr 2024 08:37:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, netdev@vger.kernel.org, bhelgaas@google.com,
 linux-pci@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>,
 davem@davemloft.net, pabeni@redhat.com
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <20240404083752.5c81d369@kernel.org>
In-Reply-To: <d0bd66c7-13d2-40a3-8d7d-055ac0234271@lunn.ch>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
	<Zg6Q8Re0TlkDkrkr@nanopsycho>
	<CAKgT0Uf8sJK-x2nZqVBqMkDLvgM2P=UHZRfXBtfy=hv7T_B=TA@mail.gmail.com>
	<d0bd66c7-13d2-40a3-8d7d-055ac0234271@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Apr 2024 17:24:03 +0200 Andrew Lunn wrote:
> Given the discussion going on in the thread "mlx5 ConnectX control
> misc driver", you also plan to show you don't need such a misc driver?

To the extent to which it is possible to prove an in-existence
of something :) Since my argument that Meta can use _vendor_ devices
without resorting to "misc drivers" doesn't convince them, I doubt
this data point would help.

