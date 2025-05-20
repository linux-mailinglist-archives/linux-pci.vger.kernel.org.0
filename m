Return-Path: <linux-pci+bounces-28114-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B74ABDD27
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 16:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF4618C8162
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 14:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6440E244666;
	Tue, 20 May 2025 14:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRrcIo3O"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2518BEC;
	Tue, 20 May 2025 14:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747751229; cv=none; b=fGLb5g2Xn+97TDyYBtVXW2+jV155Z3d5CS44PQsIQ2LO2g7HK/HGvBcjvXqf4t6AiQFWNPt9mYHLLrUUQaRTuMsw/xQ//Dq5g3Rf9hkjGrgwy7TzLU2J09zEdF1V9sdtZfwqssjTRC+WA2WG6v76TN3Cxhr+4q6T4g8xAoT38s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747751229; c=relaxed/simple;
	bh=oCLBYeP1sLVu5Ws29+9UfDbRGJI3ciUnpG/nTA1olYM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rrYvgsGQy6U/J8XH0+7AwJoV+aFuUfJ/b+cn3hbaYiHoAlbthntI5dOnPpSv/lCsSe2a36RexTEATYJXKK+mDt0ILRdVHh4p4CtkWT+gNhZersvpMHyBVfTJb82lE90AfncWgo80/H12MWxnedhufaKLRiZraaW5R5BgrRLglKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRrcIo3O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7789C4CEE9;
	Tue, 20 May 2025 14:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747751229;
	bh=oCLBYeP1sLVu5Ws29+9UfDbRGJI3ciUnpG/nTA1olYM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KRrcIo3ONGaX7Pi2FUjzUMa9ejaXw+b9Vm9fA9E3drThkSwBDBErRwftIqGCKAhYl
	 bgvtywYaGpxfZmkvw1WGrNyTx5+9cqmvDol7+KmjgP6gYZ5Y0jtXzaDt+lj0PjVRLq
	 EhGYy0wxjqBs2GooRe6qM+uu2Y0X+5SJGczXyS0LIOv6RpJ1MOJE0XmDdR0XDCrx6T
	 gmlU+1+zpu6h4u32w077LBi3dm342l6zDXzZQC9Zkr0gnH5zeDii9wXcwdbBZ/cB/p
	 JGV7/hDyqx5nG9Yg+Os07MjY52JZ6Hk85v7bL3fQXtVc5++fHv7e9lly/iSdoAgJK4
	 YkIlmYSK7kkHg==
Date: Tue, 20 May 2025 09:27:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Jon Pan-Doh <pandoh@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sargun Dhillon <sargun@meta.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Keith Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 07/16] PCI/AER: Initialize aer_err_info before using it
Message-ID: <20250520142707.GA1297901@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d429918-b42c-5714-ef40-ce2a9e129a6b@linux.intel.com>

On Tue, May 20, 2025 at 01:39:06PM +0300, Ilpo Järvinen wrote:
> On Mon, 19 May 2025, Bjorn Helgaas wrote:
> 
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Previously the struct aer_err_info "e_info" was allocated on the stack
> > without being initialized, so it contained junk except for the fields we
> > explicitly set later.
> > 
> > Initialize "e_info" at declaration with a designated initializer list,
> > which initializes the other members to zero.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/pci/pcie/aer.c | 37 ++++++++++++++++---------------------
> >  1 file changed, 16 insertions(+), 21 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index 95a4cab1d517..40f003eca1c5 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -1281,7 +1281,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
> >  		struct aer_err_source *e_src)
> 
> Unrelated to this change, these would fit on a single line.

Thanks, fixed!

