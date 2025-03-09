Return-Path: <linux-pci+bounces-23239-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F76A582E3
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 11:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6B67188CE77
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 10:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BB6189F36;
	Sun,  9 Mar 2025 10:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Bp0ag1fN"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A989CEAC7;
	Sun,  9 Mar 2025 10:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741514591; cv=none; b=gU/3N4HTuNaZKjk2T263JQa45Tv+bzPk125N3KiaY5eC0Phnd14tqiP6kGjIAJLEStNvQy3MJZy/1F9tUVm+I35ybS9xu0VfqX3NIWSvwoq59dJ5/WUkmm7ymbtsT6WeULiWoXee08M9B4Pu46Hb4gE2q28LFl0b/VLgoB18JM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741514591; c=relaxed/simple;
	bh=5oKZTa9oZWK5vjx5HdfrB037DupWfOSwQFqRy3wd9R4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFlRtOAwfS/tQ97ymFXUydQDYHkH589afCLtiB9T+6CB2Lxw0jDUIgMw/feq11qR4j1i82hDBzBntrX+fyy//MkzYoi2yCYY9yn0x20QaWeG9JPVnfF7Ga9LApgH1LIIsiwdS2v1gUL5Os4wdbg4YYspjoA3u1UiHJDKjqMZuDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Bp0ag1fN; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 529A2kCA125938
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 9 Mar 2025 05:02:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741514566;
	bh=RBQ0j1CLIgtfdzGQYBSpQ8+bS2iuhrNB4K9nQUQx2qU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Bp0ag1fNpjkwSDg1f0ypCc7vZGRx513zzzzRjIj4ybMJnLJh/SsnPMtLEa6ni5pnD
	 kFhW/6AOUmYJWpnDZ/D9YA97cUK4kJoOq+4dc8sFeCPd33S/S+9PjWewYn8sDjPLoR
	 +RzjUMOZ8clfq8cw2sdxYqc61+sBAnTD+kbDXE3A=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 529A2k3i116259
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 9 Mar 2025 05:02:46 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 9
 Mar 2025 05:02:45 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 9 Mar 2025 05:02:46 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 529A2i7j102438;
	Sun, 9 Mar 2025 05:02:45 -0500
Date: Sun, 9 Mar 2025 15:32:43 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Hans Zhang <18255117159@163.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <bwawrzyn@cisco.com>,
        <thomas.richard@bootlin.com>,
        <wojciech.jasko-EXT@continental-corporation.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [v2] PCI: cadence: Add configuration space capability search API
Message-ID: <20250309100243.ihrxe6vfdugzpzsn@uda0492258>
References: <20250308133903.322216-1-18255117159@163.com>
 <20250309023839.2cakdpmsbzn6pm7g@uda0492258>
 <3e6645a8-6de9-4125-8444-fa1a4f526881@163.com>
 <20250309054835.4ydiq4xpguxtbvkf@uda0492258>
 <bf9fc865-58b9-45ed-a346-ce82899d838c@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bf9fc865-58b9-45ed-a346-ce82899d838c@163.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sun, Mar 09, 2025 at 05:49:09PM +0800, Hans Zhang wrote:
> 
> 
> On 2025/3/9 13:48, Siddharth Vadapalli wrote:
> > On Sun, Mar 09, 2025 at 11:18:21AM +0800, Hans Zhang wrote:
> > > 
> > > 
> > > On 2025/3/9 10:38, Siddharth Vadapalli wrote:
> > > > On Sat, Mar 08, 2025 at 09:39:03PM +0800, Hans Zhang wrote:
> > > > > Add configuration space capability search API using struct cdns_pcie*
> > > > > pointer.
> > > > > 
> > > > > The offset address of capability or extended capability designed by
> > > > > different SOC design companies may not be the same. Therefore, a flexible
> > > > > public API is required to find the offset address of a capability or
> > > > > extended capability in the configuration space.
> > > > > 
> > > > > Signed-off-by: Hans Zhang <18255117159@163.com>
> > > > > ---
> > > > > Changes since v1:
> > > > > https://lore.kernel.org/linux-pci/20250123070935.1810110-1-18255117159@163.com
> > > > > 
> > > > > - Added calling the new API in PCI-Cadence ep.c.
> > > > > - Add a commit message reason for adding the API.
> > > > 
> > > > In reply to your v1 patch, you have mentioned the following:
> > > > "Our controller driver currently has no plans for upstream and needs to
> > > > wait for notification from the boss."
> > > > at:
> > > > https://lore.kernel.org/linux-pci/fcfd4827-4d9e-4bcd-b1d0-8f9e349a6be7@163.com/
> > > > 
> > > > Since you have posted this patch, does it mean that you will be
> > > > upstreaming your driver as well? If not, we still end up in the same
> > > > situation as earlier where the Upstream Linux has APIs to support a
> > > > Downstream driver.
> > > > 
> > > > Bjorn indicated the above already at:
> > > > https://lore.kernel.org/linux-pci/20250123170831.GA1226684@bhelgaas/
> > > > and you did agree to do so. But this patch has no reference to the
> > > > upstream driver series which shall be making use of the APIs in this
> > > > patch.
> > > 
> > > Hi Siddharth,
> > > 
> > > 
> > > Bjorn:
> > >    If/when you upstream code that needs this interface, include this
> > >    patch as part of the series.  As Siddharth pointed out, we avoid
> > >    merging code that has no upstream users.
> > > 
> > > 
> > > Hans: This user is: pcie-cadence-ep.c. I think this is an optimization of
> > > Cadence common code. I think this is an optimization of Cadence common code.
> > > Siddharth, what do you think?
> > 
> > This seems to be an extension of the driver rather than an optimization.
> > At first glance, though it seems like this patch is enabling code-reuse,
> > it is actually attempting to walk through the config space registers to
> > identify a capability. Prior to this patch, those offsets were hard-coded,
> > saving the trouble of having to walk through the capability pointers to
> > arrive at the capability.
> 
> Hi Siddharth,
> 
> Prior to this patch, I don't think hard-coded is that reasonable. Because
> the SOC design of each company does not guarantee that the offset of each
> capability is the same. This parameter can be configured when selecting PCIe
> configuration options. The current code that just happens to hit the offset
> address is the same.

1. You are modifying the driver for the Cadence PCIe Controller IP and
not the one for your SoC (a.k.a the application/glue/wrapper driver).
2. The offsets are tied to the Controller IP and not to your SoC. Any
differences that arise due to IP Integration into your SoC should be
handled in the Glue driver (the one which you haven't upstreamed yet).
3. If the offsets in the Controller IP itself have changed, this
indicates a different IP version which has nothing to do with the SoC
that you are using.

Please clarify whether you are facing problems with the offsets due to a
difference in the IP Controller Version, or due to the way in which the IP
was integrated into your SoC.

> 
> You can refer to the pci_find_*capability() or dw_pcie_find_*capability API.
> The meaning of their appearance is the same as what I said, and the design
> of each company may be different.

These APIs exits since there are multiple users with different Controllers
(in the case of pci_find_*capability()) or different versions of the
Controller (in the case of dw_pcie_find_*capability) due to which we cannot
hard-code offsets. In the case of the Cadence PCIe Controller, I see only
one user in Upstream Linux at the moment which happens to be the
"pci-j721e.c" driver. Maybe there are other users, but the offsets seem
to be compatible with their SoCs in that case.

Regards,
Siddharth.

