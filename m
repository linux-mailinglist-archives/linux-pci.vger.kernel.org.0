Return-Path: <linux-pci+bounces-10603-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 127F993911D
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 16:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C36B1282254
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 14:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557CF16DC20;
	Mon, 22 Jul 2024 14:58:23 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1817E1598F4;
	Mon, 22 Jul 2024 14:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721660303; cv=none; b=S940kzsuxL+X3nchCia/NcNLH5G7kP2b8DBDVKHXmXiLH2ZciSDBVX8xZ9W+uaujqFATG12KevDJD3rBC89eOKuzZFAme+mtt6mY69LduM0PQ4iDfpOglFanZfR/VloYPDYFpCBcUXNS9eZ7T+TBxJgr2VPE0RJNGJQLHKudMjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721660303; c=relaxed/simple;
	bh=VgvT5Q61KIMWA2CLu8ZknMiK/xT4j6mC8Y+9DX/EtCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3xi+kTy6tyezwwwX0hMhHvcMMphZwE3WAlEZfVhkCoqxNNKSPb4xJB6fmEJLK24J7Xg+Df9q/FMR8GgjfCGC5EBy5XBdsFC2BPMO6aZMJO6DxocXnVDJbhGxMmSHBYPOo8zta0kLPvu+g05K8NW0fKeRfi8zMlUfcqK0EmvRt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 4CBA5100DE9C5;
	Mon, 22 Jul 2024 16:58:17 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 02B3AF5100; Mon, 22 Jul 2024 16:58:16 +0200 (CEST)
Date: Mon, 22 Jul 2024 16:58:16 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Wei Huang <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	Jonathan.Cameron@huawei.com, helgaas@kernel.org, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	vadim.fedorenko@linux.dev, horms@kernel.org, bagasdotme@gmail.com,
	bhelgaas@google.com, Paul Luse <paul.e.luse@intel.com>,
	Jing Liu <jing2.liu@intel.com>
Subject: Re: [PATCH V3 00/10] PCIe TPH and cache direct injection support
Message-ID: <Zp5ziFP6JidCODF6@wunner.de>
References: <20240717205511.2541693-1-wei.huang2@amd.com>
 <ZptwfEGaI1NNQYZf@wunner.de>
 <612bf6f2-17a4-46fe-a5cd-ecb7023235ef@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <612bf6f2-17a4-46fe-a5cd-ecb7023235ef@amd.com>

On Mon, Jul 22, 2024 at 09:44:32AM -0500, Wei Huang wrote:
> On 7/20/24 03:08, Lukas Wunner wrote:
> > Paul Luse submitted a patch two years ago to save and restore
> > TPH registers, perhaps you can include it in your patch set?
> 
> Thanks for pointing them out. I skimmed through Paul's patch and it is
> straightforward to integrate.
> 
> Depending on Bjorn's preference, I can either integrate it into my
> patchset with full credits to Paul and Jing, or Paul want to resubmit a
> new version.

The former would likely be better as I'm not sure Paul has the time
to respin the patch.  My recollection is that TPH save/restore support
was dropped as a requirement for the Intel device this was originally
developed for, but it would be a shame to lose the time and effort
that already went into it and I think it might be useful for your
use case as well to support reset recovery.

> I read Bjorn's comments, lots of them have been addressed in my patchset
> (e.g. move under /pci/pcie, support _DSM and dev->tph).

Indeed, good job!

Thanks for taking a look!

Lukas

