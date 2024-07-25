Return-Path: <linux-pci+bounces-10791-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B7193C3E1
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 16:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC1C71C20BF6
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 14:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1561319CD17;
	Thu, 25 Jul 2024 14:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEUYi998"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B1619AD94;
	Thu, 25 Jul 2024 14:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721917029; cv=none; b=JWDmXvRYi5WfYjH8Ex2WQtMTRQLD9R8oq8DpRincwchMGfq/4lXhIPUy4mwzwnTjj0MljEmCbqvWQ2+YowGlnw0M0IWcdXvP5RvT7T8c9uH3tN+6sSW+m9BSU65to5D2x3LO/ADkC67NQ2IofRauZuAa0IyPTvD8NZMqoDL/Imc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721917029; c=relaxed/simple;
	bh=jX+L0vLQZKvmJCMqdntVlOglpSL6K01BYSiYJw3/uDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/5oOGJjCOS/wGHdEdNjzyMj7uOy+WYHrNut1+j4fgJDn6qo1biPmpm9ELUNY9Xis0M0gEb0CdGRRcjCauqOnFwy1kVU3aqQA6kDA7qROc8L+KtlpJ/RSQM1rJohplrqkwziNK4A/KREO+dOwuMFKym0oQTASQrvzLC9+aUNB1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEUYi998; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDFBEC116B1;
	Thu, 25 Jul 2024 14:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721917028;
	bh=jX+L0vLQZKvmJCMqdntVlOglpSL6K01BYSiYJw3/uDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CEUYi998Y1GGyt+o1If6t6QcKJc9ziTAnr/ZqpkOeyKHYPGYckSe4LP3oJVcyRvTN
	 Q8lzkRUwZlzPQgEh17/HssginNWa9SxcuGfUMLQpPIe0/W65WHS8wD7/uz9gasZTSd
	 V4ZeMhhd8Xf7xwrgDy8effJ9kkcfalra5ZuEwdrK4ZqcEv09HnyqqSl0ULO04/86nR
	 Cxwap1kMcOhRCq39IQUKd7MFyZGt7IQ99cTphkVaNmDY/06Gkxzydgdl5khRVBhO49
	 QlPYZHYbixWlvMJyj0Y76Wz3LiuohGt7bE4BbFzSm6ZQ/N1dgsbET2dNU7hEUDSvjM
	 IMVSrBRuwVT5Q==
Date: Thu, 25 Jul 2024 16:17:03 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	rick.wertenbroek@heig-vd.ch, alberto.dassatti@heig-vd.ch,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] PCI: endpoint: Introduce 'get_bar' to map fixed
 address BARs in EPC
Message-ID: <ZqJeX9D0ra2g9ifP@ryzen.lan>
References: <20240719115741.3694893-1-rick.wertenbroek@gmail.com>
 <20240719115741.3694893-2-rick.wertenbroek@gmail.com>
 <Zp+6TU/nn/Ea6xqq@x1-carbon.lan>
 <CAAEEuho08Taw3v2BeCjNDQZ0BRU0oweiLuOuhfrLd7PqAyzSCQ@mail.gmail.com>
 <Zp/e2+NanHRNVfRJ@x1-carbon.lan>
 <20240725053348.GN2317@thinkpad>
 <CAAEEuhpH-HB-tLinkLcCmiJ-9fmrGVjJFTjj7Nxk5M8M3XxSPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAEEuhpH-HB-tLinkLcCmiJ-9fmrGVjJFTjj7Nxk5M8M3XxSPA@mail.gmail.com>

On Thu, Jul 25, 2024 at 10:06:38AM +0200, Rick Wertenbroek wrote:
> 
> I don't know if the EPF node in the DT is the right place for the
> following reasons. First, it describes the requirements of the EPF and
> not the restrictions imposed by the EPC (so for example one function
> requires the BAR to use a given physical address and this is described
> in the DT EPF node, but the controller could use any address, it just
> configures the controller to use the address the EPF wants, but in the
> other case (e.g., on FPGA), the EPC can only handle a BAR at a given
> physical address and no other address so this should be in the EPC
> node). Second, it is very static, so the EPC relation EPF would be
> bound in the DT, I prefer being able to bind-unbind from configfs so
> that I can make changes without reboot (e.g., alternate between two or
> more endpoint functions, which may have different BAR requirements and
> configurations).

I agree that the MHI case (EPF requires a specific host address for the BAR)
and the FPGA case (EPC requires a specific host address for the BAR),
is different.

Right now, for EPC requirements, we have epc_features in the driver that
describes hardware for this EPC (e.g. fixed size BARs). Right now, I don't
see a reason to move this to DT (or let a DT alternative co-exist).


For EPF requirements, the MHI EPF driver exposes several different
versions (pci_epf_mhi_sa8775p, pci_epf_mhi_sdx55, pci_epf_mhi_sm8450)
in configfs, and each have their own specific driver data.

The only negative I can see with this is that it might clutter the
/sys/kernel/config/pci_ep/functions/ directory. Perhaps it is possible
to create a /sys/kernel/config/pci_ep/functions/pci_epf_mhi/ directory
where all the different versions reside?

Keeping this per-platform data in the MHI EPF driver is fine IMO.

If you would prefer to create a "pci_epf_mhi" generic version, that instead
takes this information from configfs, that would be fine too. I would also
be fine if you created a "pci_epf_mhi" generic version that tries to take
this information from device tree (as long as it is also possible to supply
the same information via configfs).

Good luck getting it accepted by the DT maintainers though. The configfs
interface was chosen because some developers (including Arnd Bergmann, IIRC)
didn't like the idea of having EPF specific information in DT.


> For combining pci_epf_alloc_space and pci_epc_set_bar into a single
> function, everyone seems to agree on this one.

Indeed, but as usual, good naming is one of the hardest problems :)

Instead of pci_epf_alloc_set_bar(), perhaps pci_epf_setup_bar() ?
If the EPC has a fixed address requirement, it will use that instead of
allocating memory.

If the EPF has a fixed address requirement, the API call will only succeed
if EPC does not have a fixed address requirement.

Perhaps EPF drivers that have a fixed address requirement could supply
that as a parameter to the API (and the EPC driver will fail the request
if it itself has fixed address requirement).

We already supply 'struct pci_epf_bar' to .set_bar(). I think the simplest
is just to extend this struct with more members (e.g. requires_fixed_addr,
fixed_addr). Basically 'struct pci_epf_bar' has all the wishes of the EPF
(32-bit/64-bit, IO/MEM BAR, BAR size, etc.).

It is already up to the EPC driver to fail the .set_bar() request if it
can't be satisfied, so pci_epf_setup_bar() could behave like .set_bar().


Kind regards,
Niklas

