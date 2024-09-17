Return-Path: <linux-pci+bounces-13271-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 583A697B2F4
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2024 18:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EF711C21779
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2024 16:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428C317A918;
	Tue, 17 Sep 2024 16:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3yUgbQt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBD1175D5C;
	Tue, 17 Sep 2024 16:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726590291; cv=none; b=b4wv9qfeLYWcxf7OOi2kga4tQNpi7x19dcy1ayrMoMYirDH7L54xfnKA4+edRIRgV/lY7N1Lnj5wm0Qab/71S56YwUr3P6KCl731BqEvw9QgLlnJ+PGsEHmnkuho66ZGnKyHTzpdhRi7MOvHMnOnhU9jYsEZ95aksCkTGWiWGC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726590291; c=relaxed/simple;
	bh=FSJzYyebJu6EW3JtLhOKiicsMZb4Rpff6c5JHt6r/Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNAMRzAgRcaCYw1Scm+b6MYbdlddlAVz2zyUDmWJwZAIOJXNkmkDYwtSJBijlwKKRws5ts7o5jNxs/B5W8iXBZIcmhV7j241IQgkUssh95w+jooYfmNE3MCDh3Pq69Imn2v7RjuDPX/CX9mDT10KuATUi7GvF/oWhmJd1HkvArY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3yUgbQt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6831FC4CEC5;
	Tue, 17 Sep 2024 16:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726590290;
	bh=FSJzYyebJu6EW3JtLhOKiicsMZb4Rpff6c5JHt6r/Uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R3yUgbQtV8tokG1/kV8PQm0MbBIf4yGJMYzMOVqL3YftanW05+prjHe//G1Pu3B9d
	 bDcevZBzWinn4BdwWbpwDmt2ipSyNaM5+a/ZojefTgf1tKpFIRRLHDS2KMnaPHNxPg
	 stRxN03aOiXPGDwijZuM2+wRNTi20wk4teUNIMSFKGntJBbMshkDG1utS2XDCivZU0
	 iafMUy3dIE5przpHhFh5p/e4kJoYGGZkKOgOGJIlCWsLdZ0MmBcLg/2QokpFGHendm
	 1B91XwDCuvTlYWhhgWMRAX0GRvLVZHY+ZAVjAg6id5VhPleH0Q78wxWcQtPdApgI2l
	 /FGI00YRFKXJQ==
Date: Tue, 17 Sep 2024 17:24:43 +0100
From: Simon Horman <horms@kernel.org>
To: Wei Huang <wei.huang2@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	Jonathan.Cameron@huawei.com, helgaas@kernel.org, corbet@lwn.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, alex.williamson@redhat.com, gospo@broadcom.com,
	michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
	somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
	manoj.panicker2@amd.com, Eric.VanTassell@amd.com,
	vadim.fedorenko@linux.dev, bagasdotme@gmail.com,
	bhelgaas@google.com, lukas@wunner.de, paul.e.luse@intel.com,
	jing2.liu@intel.com
Subject: Re: [PATCH V5 2/5] PCI/TPH: Add Steering Tag support
Message-ID: <20240917162443.GQ167971@kernel.org>
References: <20240916205103.3882081-1-wei.huang2@amd.com>
 <20240916205103.3882081-3-wei.huang2@amd.com>
 <20240917073215.GH167971@kernel.org>
 <6efc219d-29e1-4169-8393-c7e4610347cc@amd.com>
 <20240917161410.GP167971@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917161410.GP167971@kernel.org>

On Tue, Sep 17, 2024 at 05:14:10PM +0100, Simon Horman wrote:
> On Tue, Sep 17, 2024 at 09:31:00AM -0500, Wei Huang wrote:
> > 
> > 
> > On 9/17/24 02:32, Simon Horman wrote:
> > > On Mon, Sep 16, 2024 at 03:51:00PM -0500, Wei Huang wrote:
> > ...
> > >> +	val = readl(vec_ctrl);
> > >> +	mask = PCI_MSIX_ENTRY_CTRL_ST_LOWER | PCI_MSIX_ENTRY_CTRL_ST_UPPER;
> > >> +	val &= ~mask;
> > >> +	val |= FIELD_PREP(mask, (u32)tag);
> > > 
> > > Hi Wei Huang,
> > > 
> > > Unfortunately clang-18 (x86_64, allmodconfig, W=1, when applied to net-next)
> > > complains about this.  I think it is because it expects FIELD_PREP to be
> > > used with a mask that is a built-in constant.
> > 
> > I thought I fixed it, but apparently not enough for clang-18. I will
> > address this problem, along with other comments from you and Bjorn (if any).
> > 
> > BTW there is another code in drivers/gpu/drm/ using a similar approach.
> 
> Thanks,
> 
> I will run some checks over drivers/gpu/drm/ and let you know if they find
> anything.

FWIIW, I did try compiling all the .c files under drivers/gpu/drm/ with
clang-18, and it did not flag this problem.

