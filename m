Return-Path: <linux-pci+bounces-40699-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 671DFC465E5
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 12:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 571284E2107
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 11:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B500D1DDC1B;
	Mon, 10 Nov 2025 11:49:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632933093CD
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 11:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775351; cv=none; b=uGvzItUssSWVIG117OEoaoAwMU/ClHRYYLf4o89XzMrFvwIPO18c+U/z4KS+OJRJvVgAcAMbCB3xFBkuyszyF5Dg0CvWPih2ETwyYUKkBgsmBRwELe8RkJnBWvgmVD8rshhsomFNHPcPUSDheviz6yWRHbIJg60w5g2tTon61HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775351; c=relaxed/simple;
	bh=SmwF1mMyOD+QTSK/Qbn2OKv+sTN1MTgS2XCFWrxX7iI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZmBGDBjMWzqTDzLHQyn7wFeR1DSusKaMIKolnw3VNJQNqVJkitZDfMvhxECP222yUdq+OAk1E0r72qt6fI/Td5JIF+FtZOf4Z76bxSFbs3o7rtHas7Gjn5AK4K+7Hd3IlKYoE03Nuf+ovxigmkbMoHLkkER7haiVjncgMZRaDq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d4nxK6vPczJ46F6;
	Mon, 10 Nov 2025 19:48:37 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 29FD414033F;
	Mon, 10 Nov 2025 19:49:07 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 10 Nov
 2025 11:49:06 +0000
Date: Mon, 10 Nov 2025 11:49:05 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <dan.j.williams@intel.com>
CC: <linux-pci@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<bhelgaas@google.com>, <aneesh.kumar@kernel.org>, <yilun.xu@linux.intel.com>,
	<aik@amd.com>, Arto Merilainen <amerilainen@nvidia.com>
Subject: Re: [PATCH 2/6] PCI/IDE: Add Address Association Register setup for
 downstream MMIO
Message-ID: <20251110114905.00005fc5@huawei.com>
In-Reply-To: <690bd7e585c47_74f76100f@dwillia2-mobl4.notmuch>
References: <20251105040055.2832866-1-dan.j.williams@intel.com>
	<20251105040055.2832866-3-dan.j.williams@intel.com>
	<20251105095832.00000871@huawei.com>
	<690bd7e585c47_74f76100f@dwillia2-mobl4.notmuch>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 5 Nov 2025 15:04:05 -0800
dan.j.williams@intel.com wrote:

> Jonathan Cameron wrote:
> > On Tue,  4 Nov 2025 20:00:51 -0800
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >   
> > > From: Xu Yilun <yilun.xu@linux.intel.com>
> > > 
> > > The address ranges for downstream Address Association Registers need to
> > > cover memory addresses for all functions (PFs/VFs/downstream devices)
> > > managed by a Device Security Manager (DSM). The proposed solution is get
> > > the memory (32-bit only) range and prefetchable-memory (64-bit capable)
> > > range from the immediate ancestor downstream port (either the direct-attach
> > > RP or deepest switch port when switch attached).
> > > 
> > > Similar to RID association, address associations will be set by default if
> > > hardware sets 'Number of Address Association Register Blocks' in the
> > > 'Selective IDE Stream Capability Register' to a non-zero value. TSM drivers
> > > can opt-out of the settings by zero'ing out unwanted / unsupported address
> > > ranges. E.g. TDX Connect only supports prefetachable (64-bit capable)
> > > memory ranges for the Address Association setting.
> > > 
> > > If the immediate downstream port provides both a memory range and
> > > prefetchable-memory range, but the IDE partner port only provides 1 Address
> > > Association Register block then the TSM driver can pick which range to
> > > associate, or let the PCI core prioritize memory.
> > > 
> > > Note, the Address Association Register setup for upstream requests is still
> > > uncertain so is not included.
> > > 
> > > Co-developed-by: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> > > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> > > Co-developed-by: Arto Merilainen <amerilainen@nvidia.com>
> > > Signed-off-by: Arto Merilainen <amerilainen@nvidia.com>
> > > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > > Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > ---
> > >  include/linux/pci-ide.h |  27 ++++++++++
> > >  include/linux/pci.h     |   5 ++
> > >  drivers/pci/ide.c       | 115 ++++++++++++++++++++++++++++++++++++----
> > >  3 files changed, 138 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
> > > index d0f10f3c89fc..55283c8490e4 100644
> > > --- a/include/linux/pci-ide.h
> > > +++ b/include/linux/pci-ide.h
> > > @@ -28,6 +28,9 @@ enum pci_ide_partner_select {
> > >   * @rid_start: Partner Port Requester ID range start
> > >   * @rid_end: Partner Port Requester ID range end
> > >   * @stream_index: Selective IDE Stream Register Block selection
> > > + * @mem_assoc: PCI bus memory address association for targeting peer partner  
> > 
> > The text above about TDX only support prefetchable to me suggestions this
> > is optional so should be marked so like pref_assoc?  
> 
> Maybe... I think I was more considering the fact that PCI compliant
> devices always have a 32-bit MMIO range. Given both are optional it
> might be better to detail that in the Description section:
> 
> diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
> index 40f0be185120..37a1ad9501b0 100644
> --- a/include/linux/pci-ide.h
> +++ b/include/linux/pci-ide.h
> @@ -29,13 +29,18 @@ enum pci_ide_partner_select {
>   * @rid_end: Partner Port Requester ID range end
>   * @stream_index: Selective IDE Stream Register Block selection
>   * @mem_assoc: PCI bus memory address association for targeting peer partner
> - * @pref_assoc: (optional) PCI bus prefetchable memory address association for
> + * @pref_assoc: PCI bus prefetchable memory address association for
>   *		targeting peer partner
>   * @default_stream: Endpoint uses this stream for all upstream TLPs regardless of
>   *		    address and RID association registers
>   * @setup: flag to track whether to run pci_ide_stream_teardown() for this
>   *	   partner slot
>   * @enable: flag whether to run pci_ide_stream_disable() for this partner slot
> + *
> + * By default, pci_ide_stream_alloc() initializes @mem_assoc and @pref_assoc
> + * with the immediate ancestor downstream port memory ranges (i.e. Type 1
> + * Configuration Space Header values). Caller may zero size ({0, -1}) the range
> + * to drop it from consideration at pci_ide_stream_setup() time.
>   */
That does the job. Thanks,

>  struct pci_ide_partner {
>  	u16 rid_start;


