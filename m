Return-Path: <linux-pci+bounces-29025-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A9EACEE90
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 13:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62E25172354
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 11:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B70E1D88AC;
	Thu,  5 Jun 2025 11:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hTcSmnsR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B1619E971;
	Thu,  5 Jun 2025 11:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749122827; cv=none; b=LaJjI51qe1vVGmqUx0NO8mgyDoHi5k4RHckTe1GmOsqJMgtqoZ31mPAjEazVgJuoczEzi7VVR80tDpwlFWtvjBnHqMvHmCuqJ1/f4egbsmLbU8Uq6iSt9Ey6iFmy5KXKVjGpdRkV9bpqtsEOjiXL/f328uroP4ubEA7bcA5PHkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749122827; c=relaxed/simple;
	bh=EcT+oDKu4Lz64E2epDrPkU6dtYYFKU/5/AB8XI5u05Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYiYtl/vDYYF/FV7Bo2ZOmARdihAljrXOn2Fa2iYZ8PuLFOC8CQagG01awCcnWZ+wCcNsNUDgnCcknM2rt/Q/2X7t7ToUdsqzOTmG38n6Y3gjtZrGWf57089F0cTPa8EwR0e2I1vJqbHlFGomZidu1fmzgPsfkOM3NA45juDFhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hTcSmnsR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D16C4CEE7;
	Thu,  5 Jun 2025 11:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749122826;
	bh=EcT+oDKu4Lz64E2epDrPkU6dtYYFKU/5/AB8XI5u05Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hTcSmnsRYfxMMi5x3FbPZ/LKIgrtH5cGD/GqM5w6D8ciFd/AkIjgmsUzz7iiTjy2G
	 7ddFxssFJ8MYmXH+khwJsbg60t94dlsw0sKsQJAQTB4r1VAsVAnB2KJXiAuHqjQbyE
	 zHen9AI/zMXwSjLJdLCNOF9rly7zKlSq0PejV6wE=
Date: Thu, 5 Jun 2025 13:27:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Macpaul Lin =?utf-8?B?KOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
Cc: Deren Wu =?utf-8?B?KOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>,
	Johnny-CC Chang =?utf-8?B?KOW8teaZi+WYiSk=?= <Johnny-CC.Chang@mediatek.com>,
	Mingyen Hsieh =?utf-8?B?KOisneaYjuiruik=?= <Mingyen.Hsieh@mediatek.com>,
	Yenchia Chen =?utf-8?B?KOmZs+W9peWYiSk=?= <Yenchia.Chen@mediatek.com>,
	Pablo Sun =?utf-8?B?KOWtq+avk+e/lCk=?= <pablo.sun@mediatek.com>,
	"helgaas@kernel.org" <helgaas@kernel.org>,
	Jieyy Yang =?utf-8?B?KOadqOa0gSk=?= <Jieyy.Yang@mediatek.com>,
	"ajayagarwal@google.com" <ajayagarwal@google.com>,
	"sashal@kernel.org" <sashal@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bear Wang =?utf-8?B?KOiQqeWOn+aDn+W+tyk=?= <bear.wang@mediatek.com>,
	"david.e.box@linux.intel.com" <david.e.box@linux.intel.com>,
	"johan+linaro@kernel.org" <johan+linaro@kernel.org>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"sdalvi@google.com" <sdalvi@google.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	Hanson Lin =?utf-8?B?KOael+iBluWzsCk=?= <Hanson.Lin@mediatek.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
	"manugautam@google.com" <manugautam@google.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"vidyas@nvidia.com" <vidyas@nvidia.com>
Subject: Re: [PATCH v3] PCI/ASPM: Disable L1 before disabling L1ss
Message-ID: <2025060543-arrest-facecloth-89e6@gregkh>
References: <20241022223018.GA893095@bhelgaas>
 <8a7897f69c6347833c8e37ca5991ab051933de6e.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a7897f69c6347833c8e37ca5991ab051933de6e.camel@mediatek.com>

On Thu, Jun 05, 2025 at 11:23:02AM +0000, Macpaul Lin (林智斌) wrote:
> On Tue, 2024-10-22 at 17:30 -0500, Bjorn Helgaas wrote:
> > On Mon, Oct 07, 2024 at 08:59:17AM +0530, Ajay Agarwal wrote:
> > > The current sequence in the driver for L1ss update is as follows.
> > > 
> > > Disable L1ss
> > > Disable L1
> > > Enable L1ss as required
> > > Enable L1 if required
> > > 
> > > With this sequence, a bus hang is observed during the L1ss
> > > disable sequence when the RC CPU attempts to clear the RC L1ss
> > > register after clearing the EP L1ss register. It looks like the
> > > RC attempts to enter L1ss again and at the same time, access to
> > > RC L1ss register fails because aux clk is still not active.
> > > 
> > > PCIe spec r6.2, section 5.5.4, recommends that setting either
> > > or both of the enable bits for ASPM L1 PM Substates must be done
> > > while ASPM L1 is disabled. My interpretation here is that
> > > clearing L1ss should also be done when L1 is disabled. Thereby,
> > > change the sequence as follows.
> > > 
> > > Disable L1
> > > Disable L1ss
> > > Enable L1ss as required
> > > Enable L1 if required
> > > 
> > > Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> > 
> > Applied to pci/aspm for v6.13, thank you, Ajay!
> 
> Thanks! MediaTek also found this issue will happen on some old kernel,
> for example 6.11 or 6.12. would you please pick this patch also to some
> stable tree?
> 
> LINK:https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/pci/pcie/aspm.c?id=7447990137bf06b2aeecad9c6081e01a9f47f2aa

Please submit it properly, with your signed-off-by and we will be glad
to consider it.

thanks,

greg k-h

