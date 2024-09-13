Return-Path: <linux-pci+bounces-13183-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 386AC978558
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 18:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEA46283FED
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 16:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C31B558A5;
	Fri, 13 Sep 2024 16:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cVuogwCu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096A536AF8
	for <linux-pci@vger.kernel.org>; Fri, 13 Sep 2024 16:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726243350; cv=none; b=mU11GfGO0pb0b1jAm/QBtN3PQAdo5XzHqwxoJA5scWzYEABM3hdO4w3wkeR30ru8QyRJqAZHCRf2drQOyiGLeXXBOaKBJDPCzH5wZJdYM4wEz/DRgdjyvaBeWojT3+87DtFopDoTSbuVwt1sWD6uYyOMZzkdvevWO7plwNFOt7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726243350; c=relaxed/simple;
	bh=PMbRR8fQoKGMbviurBgg2HLtamZ8UoAoHvFT0Z5J+G4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q3H5OmW9FGRD/gX8pMRhpj8yHlEcGM8jOZrJ/B0S6oCawvqexYgHhWlXiN8yYu3/VW/0ahEk19OcMXkdt/1cPiNe6WIv/yagGmKEnD00q59e0aDAepYEl8IKMsNlO5VVExYOSS3mGAJWCkg5QlY1jA9vk7Vs5X0v+EYPkNF9xAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cVuogwCu; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726243350; x=1757779350;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PMbRR8fQoKGMbviurBgg2HLtamZ8UoAoHvFT0Z5J+G4=;
  b=cVuogwCuOPhxtVWWusnTEUYd1nZKojQNwYf4Up4KtOkwfFfzyueI8rx+
   S3GseidLLCUPxeXbmZtH2nGO3rhaSJgcS6GKo76BSZqg3EAPo2k5hRZxK
   GFcB6KQgQedL0/31479Pa6WEuO5GMGDtw5U5yR4ftpd77J4kc7HAPw/pK
   Lz3EaSUKF+wFGSBvtD2XaobM3S0gTTiPUOiuC8gkyuK2a6LDtCU+rKsVN
   CMDDw6C6zebN99EDLOXikYlvslUmE/cJVrD9Mi0ZdPyQwKxolhISRMdc+
   WyHtDcqpwGWkVKtKLja/wbPVTXbPML/q1X90O2P0CK+U0iuBcQohaKLO2
   A==;
X-CSE-ConnectionGUID: U+Dr5huxSsuxknqz0ZRcUA==
X-CSE-MsgGUID: nXrm9qejQtOo5qvbD6Yp3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="25245639"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="25245639"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 09:02:29 -0700
X-CSE-ConnectionGUID: oMFb6pD+S8auH16pgujMzg==
X-CSE-MsgGUID: dHzr/VoyR1uYlK9QZICVag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="72870717"
Received: from unknown (HELO localhost) ([10.2.132.131])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 09:02:28 -0700
Date: Fri, 13 Sep 2024 09:02:27 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-pci@vger.kernel.org,
 paul.m.stillwell.jr@intel.com
Subject: Re: [PATCH v2] PCI: vmd: Clear PCI_INTERRUPT_LINE for VMD
 sub-devices
Message-ID: <20240913090227.00001ada@linux.intel.com>
In-Reply-To: <20240913105541.x3ccu34z5yqatmvq@thinkpad>
References: <20240820223213.210929-1-nirmal.patel@linux.intel.com>
	<20240822094806.2tg2pe6m75ekuc7g@thinkpad>
	<20240822113010.000059a1@linux.intel.com>
	<20240912143657.sgigcoj2lkedwfu4@thinkpad>
	<66e320bd9c800_3263b29421@dwillia2-xfh.jf.intel.com.notmuch>
	<20240912172534.ma3jc7po3ca2ytlh@thinkpad>
	<66e32e8d5e19a_3263b29452@dwillia2-xfh.jf.intel.com.notmuch>
	<20240912121513.000054b3@linux.intel.com>
	<66e380f5c8a50_3263b294c9@dwillia2-xfh.jf.intel.com.notmuch>
	<20240913105541.x3ccu34z5yqatmvq@thinkpad>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Sep 2024 16:25:41 +0530
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:

> On Thu, Sep 12, 2024 at 05:01:57PM -0700, Dan Williams wrote:
> > Nirmal Patel wrote:  
> > > On Thu, 12 Sep 2024 11:10:21 -0700
> > > Dan Williams <dan.j.williams@intel.com> wrote:
> > >   
> > > > Manivannan Sadhasivam wrote:
> > > > [..]  
> > > > > I don't think the issue should be constrained to VMD only.
> > > > > Based on my conversation with Nirmal [1], I understood that
> > > > > it is SPDK that makes wrong assumption if the device's
> > > > > PCI_INTERRUPT_LINE is non-zero (and I assumed that other
> > > > > application could do the same).    
> > > > 
> > > > I am skeptical one can find an example of an application that
> > > > gets similarly confused. SPDK is not a typical consumer of PCI
> > > > device information.
> > > >   
> > > > > In that case, how it can be classified as the "idiosyncracy"
> > > > > of VMD?    
> > > > 
> > > > If VMD were a typical PCIe switch, firmware would have already
> > > > fixed up these values. In fact this problem could likely also
> > > > be fixed in platform firmware, but the history of VMD is to
> > > > leak workaround after workaround into the kernel.  
> > > 
> > > This is not VMD leaking workaround in kernel, rather the patch is
> > > trying to keep fix limited to VMD driver.  
> > 
> > Oh, ok, I see that now, however...
> >   
> > > I tried over 10 different NVMes and only 1 vendor has
> > > PCI_INTERRUPT_LINE register set to 0xFF.  The platform firmware
> > > doesn't change that with or without VMD.  
> > 
> > ...SPDK is still asserting that it wants to be the NVME host driver
> > in userspace. As part of that it gets to keep all the pieces and
> > must realize that a device that has MSI/-X enabled is not using INTx
> > regardless of that register value.
> > 
> > Do not force the kernel to abide by SPDK expectations when the PCI
> > core / Linux-NVME driver contract does not need the
> > PCI_INTERRUPT_LINE cleared. If SPDK is taking over NVME, it gets to
> > take over *all* of it.  
> 
> In that case, we do not need a fix at all (even for VMD). My initial
> assumption was that, some other userspace applications may also
> behave the same way as SPDK. But I agree with you that unless we hear
> about them, it doesn't warrant a fix in the kernel. Thanks!

Okay, We can drop this patch for now. Thanks.
> 
> - Mani
> 


