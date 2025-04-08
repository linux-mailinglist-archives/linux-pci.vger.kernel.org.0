Return-Path: <linux-pci+bounces-25480-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D7FA7F9FF
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 11:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A39EF17D00A
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 09:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89991265CC8;
	Tue,  8 Apr 2025 09:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwQoubic"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5708C205ABB;
	Tue,  8 Apr 2025 09:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744104999; cv=none; b=fFL2Ep4uN6ZW0SHYDCZIjt362D8bPvOFGc0UmkBmYMIEs8AmieW8gg0Bbmg6gDh58dqQDAbMqkzBqFCZ2qFqbKvVIBf+qB0+UICR0l4Up6p/7rFsRXYPOXIjxzXoCZHrtiYeOkT7FQxFvk0sevg5FJrGgHQN1+fHz9a18eQBPyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744104999; c=relaxed/simple;
	bh=NhA7bxfJCNkME8DTstpV9tqh1cqwE1796oGVhCFkVEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmARImHi1oNu5Xg8c8bebiNnCY6q7Nyt6ciHdlVDbb2iCSb2pT1KpgYcGW8UkPa7JaC7sy2rbx1j8y8tL2645oaPL844qnTTvZ/Xhi+IsHDjNnHXfcEUYQiJPRvS0d6wItxIRE1lpzRqD2GqEYYcAlGmK6KXpyVDRV1AC+ZtW8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwQoubic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0753EC4CEE5;
	Tue,  8 Apr 2025 09:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744104998;
	bh=NhA7bxfJCNkME8DTstpV9tqh1cqwE1796oGVhCFkVEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qwQoubicBlwx2gQbUo50rP967w+XMv47NsMLywWTYtyGuAp1td/sdBTgSUn8+kPQB
	 fpkInfJ3IGClbrwHkVDrV9MC+bK01DWfRDA1k5ibOWFPhQu2r90hhfRXaHkC7rI8CY
	 JmhEnPFE8w7BFzhcup9gIkcEfo/IE7x/NIBy3VPyvrInTBz4TChPjqZu0BjRI05Z6N
	 BVNWN2qR+IrTuL9p/hSVuWoRl08X/dWaW/rfSgZ1zsPdAx6OFJUdqjTJvzfi88TtdY
	 PFVAim52t2E2+80SXPdL/ZjYKHresFPgLByNe23qr9h/1xYb//iLbIutdrlTPY3NOP
	 7GyL0i9pp8UBQ==
Date: Tue, 8 Apr 2025 11:36:32 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/3] PCI: endpoint: improve fixed_size bar handling
 when allocating space
Message-ID: <Z_TuIP-k1yLbjcys@ryzen>
References: <20250407-pci-ep-size-alignment-v3-0-865878e68cc8@baylibre.com>
 <20250407-pci-ep-size-alignment-v3-2-865878e68cc8@baylibre.com>
 <Z_Pw3I2xO7BMSGWW@ryzen>
 <1jjz7wvuyj.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1jjz7wvuyj.fsf@starbuckisacylon.baylibre.com>

On Mon, Apr 07, 2025 at 05:43:00PM +0200, Jerome Brunet wrote:
> On Mon 07 Apr 2025 at 17:35, Niklas Cassel <cassel@kernel.org> wrote:
> 
> > Hello Jerome,
> >
> > On Mon, Apr 07, 2025 at 04:39:08PM +0200, Jerome Brunet wrote:
> >> When trying to allocate space for an endpoint function on a BAR with a
> >> fixed size, the size saved in the 'struct pci_epf_bar' should be the fixed
> >> size. This is expected by pci_epc_set_bar().
> >> 
> >> However, if the fixed_size is smaller that the alignment, the size saved
> >> in the 'struct pci_epf_bar' matches the alignment and it is a problem for
> >> pci_epc_set_bar().
> >> 
> >> To solve this, continue to allocate space that match the iATU alignment
> >> requirement but save the size that matches what is present in the BAR.
> >> 
> >> Fixes: 2a9a801620ef ("PCI: endpoint: Add support to specify alignment for buffers allocated to BARs")
> >> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> >> ---
> >>  drivers/pci/endpoint/pci-epf-core.c | 25 +++++++++++++++++--------
> >>  1 file changed, 17 insertions(+), 8 deletions(-)
> >> 
> >> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> >> index b7deb0ee1760b23a24f49abf3baf53ea2f273476..fb902b751e1c965c902c5199d57969ae0a757c2e 100644
> >> --- a/drivers/pci/endpoint/pci-epf-core.c
> >> +++ b/drivers/pci/endpoint/pci-epf-core.c
> >> @@ -225,6 +225,7 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
> >>  	struct device *dev;
> >>  	struct pci_epf_bar *epf_bar;
> >>  	struct pci_epc *epc;
> >> +	size_t size;
> >>  
> >>  	if (!addr)
> >>  		return;
> >> @@ -237,9 +238,12 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
> >>  		epf_bar = epf->sec_epc_bar;
> >>  	}
> >>  
> >> +	size = epf_bar[bar].size;
> >> +	if (epc_features->align)
> >> +		size = ALIGN(size, epc_features->align);
> >
> > Personally, I think that you should just save the aligned_size / mem_size /
> > backing_mem_size as a new struct member, as that avoids the risk that someone
> > later modifies pci_epf_alloc_space() but forgets to update
> > pci_epf_free_space() accordingly.
> 
> I tried but it looked a bit silly to store that when it was only a
> matter of calling ALIGN() with parameters we already had, and it is
> supposed to be only used in those two functions.

Another advantage is that you could kill patch 1/3 in this series, as
there would be no need to supply epc_features to pci_epf_free_space().


Kind regards,
Niklas

