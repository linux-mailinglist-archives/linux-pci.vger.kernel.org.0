Return-Path: <linux-pci+bounces-18032-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBB59EB407
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 15:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA497285DA6
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 14:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B458A1B0F3C;
	Tue, 10 Dec 2024 14:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnbDumCF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC641AAA1B;
	Tue, 10 Dec 2024 14:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733842417; cv=none; b=Tj6qljZVyLxfgIsl9oL9Jyc2E++46Sm+errIiLQRCY8Br1JGb3DTEh7kIRC2qGuSE9zbtTtzqOafirSxZRjqeSLRo6WGEoWAJg8EyNFPvGaKvzYRHjw8rcVgunKHD9x553MKZIhnhSTQMFJLmusw+6uM4TrPdCCMfj89Y+2giPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733842417; c=relaxed/simple;
	bh=M1OlLv3huZuTXdO1fN0ecGWpyL1LcINSI7uaJNiaGqA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fFLGYKOQWk2KSvkrnZa5+kXuknTCGwdFAY+QJRr3B8Oi+2V0nqhdnDO2JwmIOG4Gyc4ZkzhmcgtrpMp5YgoDiJdIGhn3RsEuzP34rINGn6gD0jAWDt968JgnOpCIQpdhaj72oUAXwBWksnpY/Vq1lFjlr/vJaXZjsoLfGLLmLhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnbDumCF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42100C4CEDE;
	Tue, 10 Dec 2024 14:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733842417;
	bh=M1OlLv3huZuTXdO1fN0ecGWpyL1LcINSI7uaJNiaGqA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SnbDumCF+nY6G1t9JZYJGybikUE9s1a9pH6fu2eV6fK1sh7sNiOlrYSBUJB55H8YW
	 kHls2Vmz87wOk3JNwa7psyNgUQDf48q6PTzPumIIw+ETwgWWKC/BzXkdpygE8v7Mrk
	 PnCeTNWQ+/WRW0dbHb64nAEzO+K24XNYnhpYxd5HCnS+8ZKVLwZnNKIX5FRYGnbHik
	 nk/s7+sighiYHlt0TCtZc1JQBrFuDKypLSTbumLbYRmEYJ4w5rXwqpxR7P0O9YcfWc
	 HXAUOEJcydEMvPJWgOTSQ2aNA8EXshMXMnp0cmvyWSyQyXuvkpNvHBAcYmL6V1fooB
	 svC08zE9wNyjg==
Date: Tue, 10 Dec 2024 08:53:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] perf/dwc_pcie: Qualify RAS DES VSEC Capability by
 Vendor, Revision
Message-ID: <20241210145335.GA3239578@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a1ef0d2-be24-4865-8e23-159d001ac6d6@linux.alibaba.com>

On Tue, Dec 10, 2024 at 08:04:17PM +0800, Shuai Xue wrote:
> 在 2024/12/10 06:29, Bjorn Helgaas 写道:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > PCI Vendor-Specific (VSEC) Capabilities are defined by each vendor.
> > Devices from different vendors may advertise a VSEC Capability with the DWC
> > RAS DES functionality, but the vendors may assign different VSEC IDs.
> > 
> > Search for the DWC RAS DES Capability using the VSEC ID and VSEC Rev
> > chosen by the vendor.

> > -	for (vid = dwc_pcie_vendor_ids; vid->vendor_id; vid++) {
> > +	for (vid = dwc_pcie_pmu_vsec_ids; vid->vendor_id; vid++) {
> 
> How about checking the pdev->vendor with vid->vendor_id before
> search the vesc cap?
> 
> +		if (pdev->vendor != vid->vendor_id)
> +			continue;

Every user of VSEC needs to specify the (Vendor ID, VSEC ID) and
verify that the Vendor ID matches the device Vendor ID, so
pci_find_vsec_capability() does this check internally, so I don't
think we need to do it here.

> >   		vsec = pci_find_vsec_capability(pdev, vid->vendor_id,
> > -						DWC_PCIE_VSEC_RAS_DES_ID);
> > -		if (vsec)
> > -			break;
> > +						vid->vsec_id);


