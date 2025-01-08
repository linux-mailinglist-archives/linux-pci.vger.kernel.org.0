Return-Path: <linux-pci+bounces-19571-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C390A06800
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 23:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDBE816759F
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 22:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6F9202F97;
	Wed,  8 Jan 2025 22:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAPqRI6q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEFC1AF0B4;
	Wed,  8 Jan 2025 22:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736374400; cv=none; b=TtlssXjeGLoSKJx2Pqb0JYFyc3wk8giSMNxh1bjr+zvp1krEaY6Yeu9ntJahZkIg66x1u2GnmKlD7h3JUqU2AF+u31YkvoYFujNFaGC47lBxxgUk9rWHzhlr3aS0McJtuykcCNirqMMli7y2SDrrmy4hlkGiXI4Qj9Bhh2I0TVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736374400; c=relaxed/simple;
	bh=txUAMzhnn7qnCj8VsLdnRbJXjg/Wnh8MafOMw9qmsJI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=C5L7y9haNQm9ZY1cgoyh8b7aJhOxPqr5UXGRK+nDXitm9ie/NsbGtB0B3X2w42IbWPpHb5mP5+zsOvHMiaggqv1I0/+bOOHPPMTUBtcihPSm+fGBSK1jsFY6OT6dp8CHwNFkXlmLWXNd7DTO6uKDFrw3yfQJGum88jT4Np8Trj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAPqRI6q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6453C4CED3;
	Wed,  8 Jan 2025 22:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736374400;
	bh=txUAMzhnn7qnCj8VsLdnRbJXjg/Wnh8MafOMw9qmsJI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OAPqRI6qhZFwKNSL1zVQhAgS3F4n5EqH4LM0jvyt5QAHNLFKETMnozpP/d306lw7W
	 70yl3BBuN4/J0h2VUVSBAJJRXfEQYjMOsF/EH77qUY9fo3RnUndVFiMyuyKNWmN3cK
	 RPJUJf3TLxH70w85oxWkv9C7SyoVrPfkRVsi7wL/zIWstBm2gZsw97ZC9wY7FGf12o
	 qg94rEnw2B+9uwGcTH7jbWGAVBEposCXtRDhHeOJbZxtWCliSUe7GaU3QQ5K0FYUPc
	 gkeVDPSxlc8idghs8J99knDTQ8OlVvIxfwZK3GFUmJo2mXFhsfi2Pk3FrxXCzm+XZQ
	 z4ZSD/vCPC7CQ==
Date: Wed, 8 Jan 2025 16:13:18 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-kernel@vger.kernel.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v8 3/7] PCI: Make pcie_read_tlp_log() signature same
Message-ID: <20250108221318.GA232458@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250108204011.GA1342186@yaz-khff2.amd.com>

On Wed, Jan 08, 2025 at 03:40:11PM -0500, Yazen Ghannam wrote:
> On Wed, Dec 18, 2024 at 04:37:43PM +0200, Ilpo Järvinen wrote:
> > pcie_read_tlp_log()'s prototype and function signature diverged due to
> > changes made while applying.
> > 
> > Make the parameters of pcie_read_tlp_log() named identically.
> > 
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Just wondering, could this be squashed into the previous patch? Or is
> the goal to be strict with one logical change per patch?

I haven't looked closely enough to opine on whether this should be
squashed, but I generally do prefer one logical change per patch.

It's much easier for me to squash things when merging than it is to
untangle things that should be separate patches.

Bjorn

