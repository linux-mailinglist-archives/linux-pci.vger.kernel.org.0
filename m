Return-Path: <linux-pci+bounces-9273-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 976C2917AE5
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 10:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DAD6288050
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 08:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C0D149C4E;
	Wed, 26 Jun 2024 08:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FmqUEx3Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D004914885C
	for <linux-pci@vger.kernel.org>; Wed, 26 Jun 2024 08:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719390407; cv=none; b=JiFH8aInwQ942Wx+pKkof/Tt+tVMribUG3xDzacFf/obOvL0YsX1RtRTFYhK6wCpjQZ8LeS7VbGe8j4dOGhD6RizVSei/KQUaqkN9Epod3aD6MfUGDk1+nHci2HMWWD8JHKzrnFSJGVj3VNepY5Rz1QRIb2nOC8KOYdUwgGpUfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719390407; c=relaxed/simple;
	bh=/IygJjeYfUoOgXfGlZ7tUzEx3dWeTumHE76TBDhyeI0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PflkE9HQN8FIuGF8O4ONglZwtesltb0oPPhXqwOKldGmZ96sdHRtlInIrGTWQ7ZsisNnNhvm2668TC08WBqTjK6rIUh0/dFQ7x9px+H111XPOnt9Ms182nu6n1bnwGSQ41M+WHu/smN4bfwL0q+cI04kd6T+72kDhIu4bidt+QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FmqUEx3Z; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from thinkpad-p16sg1.. (S010600cb7a0d6c8b.vs.shawcable.net [96.55.224.203])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5B11120B7009;
	Wed, 26 Jun 2024 01:26:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5B11120B7009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1719390405;
	bh=GpfDVxPQyWogAvndGtC834EDIE3E4FR9/iy42YlP4fQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FmqUEx3ZOgYyLxKup+qddsea5msVR9AnJtZejSB/HhuCR6efnYvnVlEKRe8ZOOVhP
	 lTUo7Qni1jkUIaxCpk8Uful8JK5WYHrrH0gTu8Ki8zo3dQ2hhy/09Dp6CExzYSt6Rz
	 zXv/V56djK7xR8EzJEDEWMVs9SRAW8u0AQKnvLlw=
From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: fancer.lancer@gmail.com
Cc: Sergey.Semin@baikalelectronics.ru,
	apais@linux.microsoft.com,
	bboscaccy@linux.microsoft.com,
	code@tyhicks.com,
	jingoohan1@gmail.com,
	linux-pci@vger.kernel.org,
	manivannan.sadhasivam@linaro.org,
	okaya@kernel.org,
	robh@kernel.org,
	shyamsaini@linux.microsoft.com,
	srivatsa@csail.mit.edu,
	tballasi@linux.microsoft.com,
	vijayb@linux.microsoft.com
Subject: [PATCH V2] drivers: pci: dwc: configure multiple atu regions
Date: Wed, 26 Jun 2024 01:26:27 -0700
Message-Id: <20240626082627.1460912-1-shyamsaini@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <vw2dla7vlovnuaxqxeslpfqwg3oqvi3673ps4uaj7pvadlyazy@sfbfpb7z2wba>
References: <vw2dla7vlovnuaxqxeslpfqwg3oqvi3673ps4uaj7pvadlyazy@sfbfpb7z2wba>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Serge,

Apologies for delayed response.

> > Hi Manivannan,
> > 
> > >> Before this change, the dwc PCIe driver configures only 1 ATU region,
> > >> which is sufficient for the devices with PCIe memory <= 4GB. However,
> > >> the driver probe fails when device uses more than 4GB of pcie memory.
> > >> 
> > > Something is not clear... This commit message implies that the driver used to
> > > work on your hardware (you haven't mentioned which one it is) and broken by the
> > > commit from Sergey.
> > 
> > sorry for any confusion, the driver use to work in v5.10 kernel, with v6.0 kernel it
> > fails to probe with following messages:
> > layerscape-pcie xx00000.pcie: Failed to set MEM range ...
> > layerscape-pcie: probe of xx00000.pcie failed with error -22
> > 
> > By tracing code, I found that the probe was failing on [1] this check,
> > which was added in [2] upstream commit from Serge and finally, the ATU upper bound limit was
> > set to 4G in [3] commit
> > 
> > pci driver probe succeeds either when
> >          1) I remove [1] check
> >          2) or by setting the ATU limit to the size of Mem64 range (my original patch [4])
> > 
> > > As per Sergey's commit, we auto detect the dw_pcie::region_limit. If the IP is <
> > > 4.60, then the limit is 4G, otherwise depends on CX_ATU_MAX_REGION_SIZE set in
> > > hw.
> > 
> 
> > I couldn't find any reference of CX_ATU_MAX_REGION_SIZE in my PCIe TRM, perhaps because it
> > is older than v4.60
> 
> Please find the line containing "iATU: unroll " in the boot log and

layerscape-pcie xx00000.pcie: iATU: unroll F, 256 ob, 24 ib, align 4K, limit 4G

> copy it here. Also please provide a content of the dw_pcie::version
> field _after_ the dw_pcie_version_detect() method is executed.
version is set as 0

i see that my driver always has [1] max = 0
While I am awaiting official info about CX_ATU_MAX_REGION_SIZE, but I think CX_ATU_MAX_REGION_SIZE may not exist

> > 
> > > So if your IP is < 4.60, you cannot map > 4GB of outbound memory anyway. But if
> > > it is > 4.60, you shouldn't see the failure that you reported for > 4G space
> > > (well you can see the failure if the limit is less than the region size). In the
> > > previous thread you mentioned that dw_pcie::region_limit is set to 4G. So how
> > > come your driver was working previously?
> > 
> 
> > The PCIe IP is from Synopsys and is older than 4.60,
> 
> If you know what the actual IP-core version is and it's older than
> 4.70a, then it's better to pre-define the version in the
> drivers/pci/controller/dwc/pci-layerscape.c probe procedure (like it's
> done in drivers/pci/controller/dwc/pci-keystone.c,
> drivers/pci/controller/dwc/pcie-bt1.c).

sure, I will look into that

> > the board is from Freescale LX2
> > family.
> 
> I failed to find the LX2 PCIe controller support in the
> drivers/pci/controller/dwc/pci-layerscape.c driver. AFAICS the
> drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c driver is responsible
> for working with the LX2 PCIe host. Am I missing something?

driver is drivers/pci/controller/dwc/pci-layerscape.c
device-tree compatible string is "fsl,ls2088a-pcie"

> Anyway I've checked all the DT-nodes defined for the Freescale Layerscape
> PCIe host controllers. None of them have the PCIe ranges defined with
> the window size greater than 4G (actually all of them of the 1G size).
> So the next question is: what DT source have you been using on your
> platform and what is the DT-node defined for the PCIe host controller
> in there?

It is internal and custom pcie range. It is not present in any upstream boards dts files.

> > The board uses drivers/pci/controller/dwc/pci-layerscape.c driver
> > Given PCIe IP is older than 4.60, I am not sure why it was working earlier for a memory range larger than 4G
> > Highly appreciate your guidance and help on this.
> 
> It has been working earlier because the kernel 5.10 didn't have
> PCI ranges check for not exceeding the iATU regions maximum limit.

true

> But once again, the DW PCIe Root-port driver has been designed to 
> allocate a _single_ iATU region for each PCIe memory ranges. Thus if the
> ranges exceeds the maximum limit, the mapping won't work for the
> addresses greater than the maximum limit. I've already explained it
> here:
> https://lore.kernel.org/linux-pci/hxluc6qth4temdyxloekbhoy4iielyvxmmhp3u47qwtcxb5t5v@v5hdzvqmrsyv
> 
> Moreover the IP-core databook not only explicitly prohibits to define the iATU
> ranges greater than 4GB on the DW PCIe device older than 4.60a (text
> from v4.21a databook), but has more strict constraint of the regions
> not crossing the 4GB boundary:
> "The upper 32 bits of the Target Address register always forms the
> upper 32 bits of the translated address because:
> ■ The maximum region size is 4 GB.
> ■ A region must not cross a 4 GB boundary."
> 
> (It's obvious though since the iATU Limit Address register is of the
> 32-bit size on the old controllers.)
> 
> So you either need to allocate several iATU regions to cover the
> requested PCIe ranges, or fix the PCIe controller DT-node to having the
> ranges not exceeding the maximum limit.

we have requirement for memory ranmge greater than 4G, so it seems range can't be changed.

I am looking into your other suggestions, highly appreciate your feedback

Thanks,
Shyam

[1] https://elixir.bootlin.com/linux/v6.10-rc5/source/drivers/pci/controller/dwc/pcie-designware.c#L832


