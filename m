Return-Path: <linux-pci+bounces-28108-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E17ABDA1D
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 15:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9093D3BF98D
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 13:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6872459ED;
	Tue, 20 May 2025 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHbwhUZ2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35532459C9;
	Tue, 20 May 2025 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747749243; cv=none; b=b5J6bq8CAzBh7bFVL3C3tvB87LQfd4yut8oZJwc1dF4IBNvEhSLj0Bxeq7KX2tPQwCiFt/ZxUbHoJY+8hQgZJ+QK83/XCOWc9T8r5pwikMGlQlxlME93DGugfiSgmZ11g+uiWWJEhaM+QAMnx2CvCVLe/j6tmyGnxbiZaCU0rtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747749243; c=relaxed/simple;
	bh=K0AQGrstH9kybdCjHXTCQHHA8EFnSUmlknqnLl59yL4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=n1vlESCY/CzggvXTyMLZPrXBTsSaCm7Pgqx4scRvN4DwBWnHETyw2xCATPJEYWDRc9MmiDkeEfo+CyLGUXH2e3vIxnhnTUbKLL43gmaHxjKe52COjVPfk3XPRiPvtZN/pRULk9UsZK0LDrX7nFJpYuJaPjAFU8NyddC226lJh68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tHbwhUZ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436BAC4CEE9;
	Tue, 20 May 2025 13:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747749243;
	bh=K0AQGrstH9kybdCjHXTCQHHA8EFnSUmlknqnLl59yL4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tHbwhUZ211upNss9JSEf2Emr75oAjtGuGDEuuaCsv7phD+HStT1bCQ0xRxgPdPbu5
	 sD44X239VtWHZABLHSF3Feo1nBycsTuMCKue88EDGAVSQel+CrF10PEo++G37Cil34
	 ORCwoMa18+4eQM2Zk4YvnQvF+l77MvtCndcZp3wmCx3ACFc9MqMfQtDKjbB+AB4N7p
	 QUZWpdQhWb/xcYEsbOrAsftuBOwgqq1jp5fO2wI/AeGNvT+HJLt9Tl6StfQFvx1oW8
	 FXg6COHcZJCdv30Dhd0LDp3taWhwfnExZjd3NqitqkNKAr3RKb3JofoXeoj/9uC4JW
	 mDPrujL9AOnKQ==
Date: Tue, 20 May 2025 08:54:02 -0500
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
Subject: Re: [PATCH v6 01/16] PCI/DPC: Initialize aer_err_info before using it
Message-ID: <20250520135402.GA1291302@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <218ec0eb-93a9-ba14-ea6b-742d0d274b84@linux.intel.com>

On Tue, May 20, 2025 at 12:39:18PM +0300, Ilpo Järvinen wrote:
> On Mon, 19 May 2025, Bjorn Helgaas wrote:
> 
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Previously the struct aer_err_info "info" was allocated on the stack
> > without being initialized, so it contained junk except for the fields we
> > explicitly set later.
> > 
> > Initialize "info" at declaration so it starts as all zeroes.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/pci/pcie/dpc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> > index df42f15c9829..fe7719238456 100644
> > --- a/drivers/pci/pcie/dpc.c
> > +++ b/drivers/pci/pcie/dpc.c
> > @@ -258,7 +258,7 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
> >  void dpc_process_error(struct pci_dev *pdev)
> >  {
> >  	u16 cap = pdev->dpc_cap, status, source, reason, ext_reason;
> > -	struct aer_err_info info;
> > +	struct aer_err_info info = { 0 };
> 
> = {}; is enough to initialize it, no need to add those zeros.

Changed, thank you!

