Return-Path: <linux-pci+bounces-39233-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32315C043A3
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 05:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F106B18C1A6B
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 03:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9195424BD04;
	Fri, 24 Oct 2025 03:14:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604B824BBEC;
	Fri, 24 Oct 2025 03:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761275677; cv=none; b=P026jGVeR0zF2eB/DW/LGcDPBCX4ohs8dax3mHkxHqkey/Yfi9nl0Ffw/NdK+eby9KiyKd+E/pK1qYL5myD/vwPQWNmwzWWerj5mz23tF/QvHnOeoVQOo/oj0pfFyIVFulvxmQ8ecfZMML8qGbbVtvvFbGvoMk9lHw+yUelxEn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761275677; c=relaxed/simple;
	bh=vXkI+iWiw+ha+Okk4SRY7GShtgAm9kpMzjgcFMBV340=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwMfAvjMAuHPklgD7ww4t71LJdOTqubK4j4Yerf4JyDH2Btq325LMRorqJgxoHNyE6c2Y/s+PnVhedyzjqvyDgjdKJOfVs+yN7T2fcXcAuHJHQQE8B6NYrHB9L7YC84LSSbHfBqMvnHmWPNmUgdhVnTwVYID+rIL0wCpOIBBg4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id D04B92C07AA5;
	Fri, 24 Oct 2025 05:14:25 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id BFD344A12; Fri, 24 Oct 2025 05:14:25 +0200 (CEST)
Date: Fri, 24 Oct 2025 05:14:25 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	kbusch@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	mahesh@linux.ibm.com, oohall@gmail.com, Jonathan.Cameron@huawei.com,
	terry.bowman@amd.com, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v6 4/5] PCI/ERR: Use pcie_aer_is_native() to check for
 native AER control
Message-ID: <aPrvEZ3X4_tiD2Fh@wunner.de>
References: <20251015024159.56414-1-xueshuai@linux.alibaba.com>
 <20251015024159.56414-5-xueshuai@linux.alibaba.com>
 <aPYMO2Eu5UyeEvNu@wunner.de>
 <0fe95dbe-a7ba-4882-bfff-0197828ee6ba@linux.alibaba.com>
 <aPZAAPEGBNk_ec36@wunner.de>
 <645adbb6-096f-4af3-9609-ddc5a6f5239a@linux.alibaba.com>
 <aPoDbKebJD30NjKG@wunner.de>
 <1eaf1f94-e26b-4313-b6b7-51ad966fe28e@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1eaf1f94-e26b-4313-b6b7-51ad966fe28e@linux.alibaba.com>

On Fri, Oct 24, 2025 at 11:09:25AM +0800, Shuai Xue wrote:
> 2025/10/23 18:29, Lukas Wunner:
> > On Mon, Oct 20, 2025 at 10:45:31PM +0800, Shuai Xue wrote:
> > > From PCIe spec, BIT 0-2 are logged for functions supporting Advanced
> > > Error Handling.
> > > 
> > > I am not sure if we should clear BIT 3, and also BIT 6 (Emergency Power
> > > Reduction Detected) and in case a AER error.
> > 
> > AFAIUI, bits 0 to 3 are what the PCIe r7.0 sec 6.2.1 calls
> > "baseline capability" error reporting.  They're supported
> > even if AER is not supported.
> > 
> > Bit 6 has nothing to do with this AFAICS.
> 
> Per PCIe r7.0 section 7.5.3.5:
> 
>   **For Functions supporting Advanced Error Handling**, errors are logged
>   in this register regardless of the settings of the Uncorrectable Error
>   Mask register. Default value of this bit is 0b.
> 
> From this, it's clear that bits 0 to 2 are not logged unless AER is supported.

No.  It just means that if AER is supported, the Uncorrectable Error Mask
register has no bearing on whether the bits in the Device Status register
are set.  It does not mean that the bits are only set if AER is supported.

Thanks,

Lukas

