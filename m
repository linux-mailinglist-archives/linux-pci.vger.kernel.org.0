Return-Path: <linux-pci+bounces-17418-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A81D9DA8E9
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 14:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3CD4282ABC
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 13:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AEE1FCFF2;
	Wed, 27 Nov 2024 13:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSSmnWME"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F7C1FCFC2;
	Wed, 27 Nov 2024 13:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732715045; cv=none; b=hGLct5odxnHXNwHmNx9dwjVp6k1t1Mkjc6Lf/0aOm6HGHBwvEp/M5e2smmTZE6RuXrn6VgNw3HQFSBzGbXObTYD+iem6DKjVxVEKpsEKOB++znbNsDnRP/OATKnA5hl+0khACtzaap1Z4CXb5rAVBNYyuA5Z6UAplG+Bfw0H0Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732715045; c=relaxed/simple;
	bh=J5kbzFJdRU8mGY871AZ3Cz82lCZYsmam9fRQzz21ITk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGwpykMt8K+JrFvOBS1uwNCkiZnqHrI8fBOHMXEvM25Nv96Xw2FCf6vtyEJcflKAlIvO3ttBuBZ7qrOFDw8hggZdeaCZuHdFRexwgmS/pYuPSWOTdvwzq0K13fgGd6GmzNPSDk6N2gUedw013yfoFKwJ4hjyDbMKQ3iS/J5J1FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSSmnWME; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77148C4CECC;
	Wed, 27 Nov 2024 13:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732715044;
	bh=J5kbzFJdRU8mGY871AZ3Cz82lCZYsmam9fRQzz21ITk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hSSmnWMEoU1j6ZJ3uX6MsrZUbaV5vF9BPfFyVIk4PEduBfHU+/mYermlj1Jt0GIGc
	 u3np+OJuvEHZqlF2+FsIs6HxrnnlzXI1k/j04JS7ZRlkV5GXE44BtSKwNcu8iCIXHF
	 9I1wMZZ86PSAcNK8ooEArxq3uTanWIMoFZguxp73wIfOj9Ue+ZZZ/hZ+lJi3g+rqDT
	 IeiPMn3RTq5xgp6oSQPlSQWkgLPuvKJgG4CoumDeFGt0xYvQaIjP2j6rs4iZl1n1Dl
	 bGoKcsv3JUmpFuc/z9GK/c6s9l8s9fsK0JkSJN4ibherM9WlldEA6OWqL0NRxcv2K1
	 PNoeX8o8MUVwQ==
Date: Wed, 27 Nov 2024 07:44:02 -0600
From: Rob Herring <robh@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 0/2] Preserve the flags portion on 1:1 dma-ranges
 mapping
Message-ID: <20241127134402.GA3351562-robh@kernel.org>
References: <cover.1732441813.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1732441813.git.andrea.porta@suse.com>

On Sun, Nov 24, 2024 at 11:05:35AM +0100, Andrea della Porta wrote:
> Empty dma-ranges in DT nodes using 3-cell address spcifier cause the
> flag portion to be dropped by of_translate_one(), failing the translation
> chain. This patch aims at fixing this issue.
> 
> Part of this patchset was originally preparatory for a bigger patchset
> (see [1]). It has been split in a standalone one for better management
> and because it contains a bugfix which is probably of interest to stable
> branch.
> I've also added new tests to unittest to prove it.
> 
> Many thanks,
> Andrea
> 
> References:
> [1] - https://lore.kernel.org/all/3029857353c9499659369c1540ba887d7860670f.1730123575.git.andrea.porta@suse.com/
> 
> 
> Changes in V2:
> 
> - Added blank lines between paragraphs in commit message for patch 2
> - Fixed a comment to explain the code behaviour in a straighter way
> 
> 
> Andrea della Porta (2):
>   of/unittest: Add empty dma-ranges address translation tests
>   of: address: Preserve the flags portion on 1:1 dma-ranges mapping
> 
>  drivers/of/address.c                        |  3 +-
>  drivers/of/unittest-data/tests-address.dtsi |  2 ++
>  drivers/of/unittest.c                       | 39 +++++++++++++++++++++
>  3 files changed, 43 insertions(+), 1 deletion(-)

Applied, thanks!

Rob

