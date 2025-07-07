Return-Path: <linux-pci+bounces-31611-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E38AFB1EE
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 13:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D7B8171122
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 11:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4392288CA1;
	Mon,  7 Jul 2025 11:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sDDxGoey"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A810C28853E;
	Mon,  7 Jul 2025 11:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751886346; cv=none; b=m9nwOJRMwsbCxcI/9qq42yfIetA44hB9JKlw6Vu9ajW2SNjqGUsA9snF8itFliG7ln9krkh7Ijyg3mdNK/qijAGddSarGvm523IRqZhLC6MnsImHPujaEYCBcdjGjsYJRV3Pk2ngo6GjLg5cC8Iqu41D6yJbpITDhihZLth+Xcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751886346; c=relaxed/simple;
	bh=KoMwxI+BjZlkT8Tms2SDNkjYSNzeRufAe/1amGoI+ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mb2DKigIYoAKWHlqYtifTYhWJKuoeE5pVr7bYdzkWf7DUH5N+lnGAkj5MV+wpQ0MaelO1tw9S6cWI9YlkKtM2cif6VrFYiAJnGnU9CwndnZQYCh/XkPZRLJia1U1xnfgHm3pAuOQdIgTj4zxP9/XvIxGyOlRtVn8ZMdIc/8Lv30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sDDxGoey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1431C4CEE3;
	Mon,  7 Jul 2025 11:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751886346;
	bh=KoMwxI+BjZlkT8Tms2SDNkjYSNzeRufAe/1amGoI+ac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sDDxGoeyD7+j008f4C5gG8JDXIDhNP0oYiiRUsHQHw1XANM4XOzj4BtQ3WRR5Nn0K
	 WLQ2PaBnbxIIzlNv3K7Ile06rk1m+JjXzF5UOOIs8F8KxsKtXtAULq9PJzo5d1kaxo
	 caU444uhBlooXbSdeQvgvT8/tOrzFv03nVOss4vwcoBh01qYKDQ0/1z8HNvWeFWIXT
	 ihr6tAvSPIwYq+TN0y7vd0jE6GXiIDMGZTlGlX4HxAe7bi6VDUGc9t5elocqno+Onm
	 crt4dZtDXxsWvYAgX2SCmcV72FGyZzew9r+pB2iOAoJINY5GG/OgEc6ykmZmHl6wTS
	 gBqnE5NypwKLA==
Date: Mon, 7 Jul 2025 13:05:39 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>,
	Will Deacon <will@kernel.org>, Robert Richter <rric@kernel.org>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Marc Zyngier <maz@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>, dingwei@marvell.com,
	Lukas Wunner <lukas@wunner.de>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 4/5] PCI: host-common: Add link down handling for host
 bridges
Message-ID: <aGuqA92VDLK8eRY1@ryzen>
References: <fr6orvqq62hozn5g3svpyyazdshv4kh4xszchxbmpdcpgp5pg6@mlehmlasbvrm>
 <20250530113404.GA138859@bhelgaas>
 <bixtbu7hzs5rwrgj22ff53souxvpd7vqysktpcnxvd66jrsizf@pelid4rjhips>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bixtbu7hzs5rwrgj22ff53souxvpd7vqysktpcnxvd66jrsizf@pelid4rjhips>

Hello Mani,

On Fri, May 30, 2025 at 09:39:28PM +0530, Manivannan Sadhasivam wrote:
> On Fri, May 30, 2025 at 06:34:04AM -0500, Bjorn Helgaas wrote:
> 
> > I think pci_host_handle_link_down() should take a Root Port, not a
> > host bridge, and the controller driver should figure out which port
> > needs to be recovered, or the controller driver can have its own loop
> > to recover all of them if it can't figure out which one needs it.
> > 
> 
> This should also work. Feel free to drop the relevant commits for v6.16, I can
> resubmit them (including dw-rockchip after -rc1).

What is the current status of this?

I assume that there is not much time left before 6.17 cut-off.


Kind regards,
Niklas

