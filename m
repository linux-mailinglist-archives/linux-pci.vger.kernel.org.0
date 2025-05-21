Return-Path: <linux-pci+bounces-28236-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95307ABFD39
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 21:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D83B01BC4CF0
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 19:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C2B230BE8;
	Wed, 21 May 2025 19:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhvpVny9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FB122173C;
	Wed, 21 May 2025 19:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747855086; cv=none; b=JKXXam+UgCBWl1h4Bb9OHBn38Ozz2CHwa7xn99EAHfodfzYSVQUVoLkrmq31BAeALiH0hEhGJH2LrBFdrZV3eOiNpfElNpwC8/gYc51xO0QpIFcKCdQPEX3VO0XGKBY40yqBHLZT18XncWtkACxCT5ZXsTIKYbLK90P8dDnyAfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747855086; c=relaxed/simple;
	bh=11eaAuGJiJiZBtdGomgSvZbqRIL2Y2/cQykWBiFSowo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mXC4381KVbN8jcTG4Dm6cLzmpf4lYi6MjO8cSMLHWVof25i9hvCXileXWuBZJejdwTgCKvDQtEnmTM5V8aGYZZAdjo5ZS72QxojfuPHOM1n7K17xNfaQfxgY9tAqSjQZjjQDIPJk3QHUZgeDVT4qQrFGhqnos+7grDS37IBLBzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhvpVny9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A172C4CEE4;
	Wed, 21 May 2025 19:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747855085;
	bh=11eaAuGJiJiZBtdGomgSvZbqRIL2Y2/cQykWBiFSowo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qhvpVny9dMzrOx+Mn5azE81/XRNYeXos00YtD6PNA/RC9skrUY3H32mHDPJPIC4mJ
	 CCCJAhZ7eiBx6xsNuaRWGFWkUu8NzEJEqKqAd481MdKfHpxStiaudPUkeGlS1jqtOj
	 yhfyrZ0uPL3huDKW7QzjzVJT/8uV2F9KnyXOn1sJIu7HfjTQUAzeSm9LuOb5q5Yua0
	 jz2nRXACHn4pQxHsCY3Amxm4sUkv+y5QOgbDWhQr+fDZuQAh/BongCCX63wtemuviI
	 nNvazIe8vbPQWZeVB4AuTzbiHzcU9RNdS4F4I5ExLfhFxLoSm59Ttmn2EZ/MSrG9VP
	 jDfpVevewM4ag==
Date: Wed, 21 May 2025 14:18:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-pci@vger.kernel.org, Jon Pan-Doh <pandoh@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	Weinan Liu <wnliu@google.com>,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>, Sargun Dhillon <sargun@meta.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Keith Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH v7 01/17] PCI/DPC: Initialize aer_err_info before using it
Message-ID: <20250521191803.GA1426656@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250521095218.0000045d@huawei.com>

On Wed, May 21, 2025 at 09:52:18AM +0100, Jonathan Cameron wrote:
> On Tue, 20 May 2025 16:50:18 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Previously the struct aer_err_info "info" was allocated on the stack
> > without being initialized, so it contained junk except for the fields we
> > explicitly set later.
> > 
> > Initialize "info" at declaration so it starts as all zeros.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > Tested-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
> > Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> I chased this through a bit and looks like at least some unset fields would
> result in garbage prints.  So maybe needs a fixes tag?
> info->tlp_header_valid is an easy one to follow as only set in some paths.

I don't see a current issue related to info->tlp_header_valid because
it's always cleared in the path from DPC:

  dpc_process_error
    dpc_get_aer_uncorrect_severity
      info->severity = AER_FATAL or AER_NONFATAL
    aer_get_device_error_info
      info->status = 0;
      info->tlp_header_valid = 0;    # unconditional
      pci_read_config_dword(PCI_ERR_UNCOR_STATUS, &info->status);
      pci_read_config_dword(PCI_ERR_UNCOR_MASK, &info->mask);
      info->first_error = PCI_ERR_CAP_FEP(...);
    aer_print_error

However, only info->{severity,status,tlp_header_valid,mask,
first_error} are initialized before dpc_process_error() calls
aer_print_error(), and aer_print_error() uses info->{id,
error_dev_num}, which haven't been initialized.

AFAICT, this has been the case since
https://git.kernel.org/linus/8aefa9b0d910 ("PCI/DPC: Print AER status
in DPC event handling")

Here's aer_get_device_error_info() at that time:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pcie/aer.c?id=8aefa9b0d910#n867

and aer_print_error():
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pcie/aer.c?id=8aefa9b0d910#n530

At the time of 8aefa9b0d910, info->severity was also used without
initialization; this was fixed by 9f08a5d896ce ("PCI/DPC: Fix print
AER status in DPC event handling").

But I think the info->{id,error_dev_num} has been there since.

Anyway, I added:

  Fixes: 8aefa9b0d910 ("PCI/DPC: Print AER status in DPC event handling")

> Otherwise absolutely makes sense.
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/pci/pcie/dpc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> > index df42f15c9829..3daaf61c79c9 100644
> > --- a/drivers/pci/pcie/dpc.c
> > +++ b/drivers/pci/pcie/dpc.c
> > @@ -258,7 +258,7 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
> >  void dpc_process_error(struct pci_dev *pdev)
> >  {
> >  	u16 cap = pdev->dpc_cap, status, source, reason, ext_reason;
> > -	struct aer_err_info info;
> > +	struct aer_err_info info = {};
> >  
> >  	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
> >  	pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID, &source);
> 

