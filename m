Return-Path: <linux-pci+bounces-28107-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E93C2ABDA12
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 15:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C01D17C5BD
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 13:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF40A242D9A;
	Tue, 20 May 2025 13:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKhSL5zH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EC322D7A8;
	Tue, 20 May 2025 13:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747749219; cv=none; b=RldcnOxlH6aCb+FLcO3f9LCkMi7wvL4hq0DBmSj7aAhA1qvpsLefBhO9wZFH6HZV8AoHq/m51ccSgn+ZCygZ0CFnrYQW4yyS1EwQj03+KML+32SnZnxZ+j6jbnnZcZDzjyC7bEaQLwyrY8+tyQ2TmYdWk7mSiG9b1/i1ng4LF44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747749219; c=relaxed/simple;
	bh=CA5p6228eQF/0HRQYWgn129Rwa1VmXENjAQVYFscsY4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RmMttkjPY9FHhUwwlDT10pxARENCikFP6SYnpUosoGxonYkHOulDN7E+9KmB0r+CW3k3bMd1ki8123nIpR/SoOKQkg37wUU/6PzenoR3zmhoxxmkFq8UN6++qbBgPkT1FvVIJxGIdZrxSjHly1MLhbo3S4dkRojtJtSV6RXkcZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKhSL5zH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F38C4CEE9;
	Tue, 20 May 2025 13:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747749219;
	bh=CA5p6228eQF/0HRQYWgn129Rwa1VmXENjAQVYFscsY4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qKhSL5zHq6LTXe4tDiSws76qlpFpBxS55j5/qW7Kw0DLI30xLHiPQHy+WCf8jqGbn
	 GulWMyASh05tnd6owvEp/31ihxBteK6KrFklBxQB9ibsexDTyhdosP2LQIkhF6hUA6
	 0Ql6lVXoDXZiagWAM6NWz6nDZpsSIZC8Qv4I1ev6ecrmXmYlmnbftL/r4CZrULN4ks
	 Vh2NOO0WfaPRpC4IEkRIgGAf7VpAUJT3YTSNCgyn9yoiU12j3kw5Lj2AOvAtIJ8Yzy
	 ITdDeli7zeQUnKGWsedG+wCqldMbN0jI0PPF7Gyi8ZzJGWbYfhkaGKBfDZXS85wrhs
	 zzL31sbUUSjIQ==
Date: Tue, 20 May 2025 08:53:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Jon Pan-Doh <pandoh@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
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
	Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 01/16] PCI/DPC: Initialize aer_err_info before using it
Message-ID: <20250520135337.GA1290915@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b1b80e2-4f59-462e-96a9-546b1d7a7644@linux.intel.com>

On Mon, May 19, 2025 at 03:41:50PM -0700, Sathyanarayanan Kuppuswamy wrote:
> Hi,
> 
> On 5/19/25 2:35 PM, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Previously the struct aer_err_info "info" was allocated on the stack
> 
> /s/Previously/Currently ?

I prefer "previously" here because it clearly refers to the situation
*before* this patch (allocated on stack without initialization), and
it also gives a hint that this situation is what the patch changes.

If I used "currently," I could be mentioning something relevant that
isn't being changed by the patch, e.g., "currently the struct is
allocated on the stack so it's important to keep it small."

> > without being initialized, so it contained junk except for the fields we
> > explicitly set later.
> > 
> > Initialize "info" at declaration so it starts as all zeroes.
> 
> /s/zeroes/zeros

Fixed, thank you!

> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >   drivers/pci/pcie/dpc.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> > index df42f15c9829..fe7719238456 100644
> > --- a/drivers/pci/pcie/dpc.c
> > +++ b/drivers/pci/pcie/dpc.c
> > @@ -258,7 +258,7 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
> >   void dpc_process_error(struct pci_dev *pdev)
> >   {
> >   	u16 cap = pdev->dpc_cap, status, source, reason, ext_reason;
> > -	struct aer_err_info info;
> > +	struct aer_err_info info = { 0 };
> >   	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
> >   	pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID, &source);
> 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
> 

