Return-Path: <linux-pci+bounces-14932-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF649A5BC6
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 08:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6AAE1C21589
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 06:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DE51D0BA2;
	Mon, 21 Oct 2024 06:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqP9st+B"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA6015575F;
	Mon, 21 Oct 2024 06:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729493745; cv=none; b=RxxtRC4Iequ+WkpPT2Yv8X0sA/VyYTF9SpeOt0B4FsIVK5Ck+R4aT1kua+NdjujYQKX67C65OSa1qqIXzIIkkXztC92E8n8QLWElKa/LsPd1Bb3/oSPjiOYQ9C/zREpcSdp5WvToWLIJ9tWbZ5E8OdVP5VvD25aZh46yvk+1uCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729493745; c=relaxed/simple;
	bh=07U94b6F6zmDzp669IA6TRr0lDH3z86Sqc3IMdNwgNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbDq4P6mK9ySzucQiGuVtetWCaovsN/Wqmr1eKqWMeVYbN0YKjW3p6tpxiPOW5aHPhFieLWXXUFKNqONcrPRZKka0uMEVsSEJKiZetqKhxz2jKW2mP0f3NQGwiDveI9g+Vy3tki7opeb6i5eEVDzzM3XXXqMLOzMQpsaEdFomA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqP9st+B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB75C4CEC3;
	Mon, 21 Oct 2024 06:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729493744;
	bh=07U94b6F6zmDzp669IA6TRr0lDH3z86Sqc3IMdNwgNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PqP9st+BYR5vYI/1IdDe2BM9BNsFGptV4wKU4M5ozOYKdcJ26JgZC/pnBbbNVbpF0
	 pGv7W6OQY6AA3SBfqJFQt5DGdH04+QTWY6AyCunzWtIkoClBTL2ZfMRokwpv6yBNJK
	 wVBkecuIFlRZf9Vt4twPTy0lAJJ0D7SZlvRA8xwx5f5Fb2kds/iMPjQ2e8hXaJZThx
	 MFgKFGhTPq5tiYMun0KeDDINMfUu6GiQGWeb6vWKzOijs/Aizk+bUUqD4dZK+6ztFB
	 k4aldEtLJJ81a54AKjv4pG+sgJB1a5eHC+bB+QiAsSJjY6v/GS0DX2hBHFjVE9gECN
	 o0HsPi0LZ8VkA==
Date: Mon, 21 Oct 2024 08:55:38 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, dlemoal@kernel.org, maz@kernel.org,
	tglx@linutronix.de, jdmason@kudzu.us
Subject: Re: [PATCH v3 4/6] PCI: endpoint: pci-epf-test: Add doorbell test
 support
Message-ID: <ZxX66guRidaeV1zO@ryzen.lan>
References: <20241015-ep-msi-v3-0-cedc89a16c1a@nxp.com>
 <20241015-ep-msi-v3-4-cedc89a16c1a@nxp.com>
 <ZxJqITunljv0PGxn@ryzen.lan>
 <ZxJ7HoSuYNr8mwSi@lizhi-Precision-Tower-5810>
 <ZxUWlSFEPDCCXaq0@x1-carbon.lan>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxUWlSFEPDCCXaq0@x1-carbon.lan>

On Sun, Oct 20, 2024 at 04:41:25PM +0200, Niklas Cassel wrote:
> On Fri, Oct 18, 2024 at 11:13:34AM -0400, Frank Li wrote:
> > On Fri, Oct 18, 2024 at 04:01:05PM +0200, Niklas Cassel wrote:
> 
> How about we add a new pcitest --set-doorbell-mode option
> (that is similar to pcitest -i which sets the interrupt mode to use).
> 
> That way, we can do:
> ./pcitest --set-doorbell-mode 1
> (This will enable doorbell for e.g. BAR0, pci-epf-test will call
> pci_epf_alloc_doorbell() when receiving this command from the RC side.
> The command will return failure if pci_epf_alloc_doorbell() returned failure.)
> 
> ./pcitest -B
> (This will perform the doorbell test)
> 
> ./pcitest --set-doorbell-mode 0
> (This will disable the doorbell for BAR0,
> so it will again not trigger IRQs when BAR0 is written,
> and pcitest's tests to read/write the BARs will again behave as expected.)
> 
> (We probably also need another option pcitest --get-doorbell-mode.)
> 
> I think this should solve all your concerns. Thoughts?

And just to clarify, if we go with the --set-doorbell-mode approach,
then my previous idea (introducing capabilities in pci-epf-test and
pci-endpoint-test) is no longer a necessity.


Kind regards,
Niklas

