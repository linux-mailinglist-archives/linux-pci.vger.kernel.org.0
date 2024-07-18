Return-Path: <linux-pci+bounces-10526-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C109350CE
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 18:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A252B282702
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 16:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BB014532A;
	Thu, 18 Jul 2024 16:43:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804E3144D3C;
	Thu, 18 Jul 2024 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721321024; cv=none; b=a3E39lH7jH5O0DJGWsRCNgr4sW/sROE4HABNc+rJJyY4/u6KLYD2f0gB0K0kge3MgSUKlHL0734cwQosr9wqmgBEfj/sybMf8rCyDLnKy/YNCDCom6vV2YGVHPbZJsf69OPUbxFjQ2xINR+Yf0/0LaHwBKNHIUEMZPJl9SC09/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721321024; c=relaxed/simple;
	bh=SZ76AC/Rh91UiRrZuqOyscokG9yMnJIXTBDjNPBiwW0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F+T0QvUKUCOXHA03rO07xl/ioHryotVT+mfHImSREhGpUhrWe8RkCuR4OquHjdIlOdFmYex1uCR2O5o78HxC1FegitqrQmdIZAjYE3g8uPCtV5NF27NA2bjbgZ+zR/kYMUDP+EPgmAVQg7LbrAJ1Q0CAb8TKEmmWJ4mYIIJjqa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WPz9738hhz6K5nQ;
	Fri, 19 Jul 2024 00:41:47 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C8CD51400D7;
	Fri, 19 Jul 2024 00:43:38 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 18 Jul
 2024 17:43:38 +0100
Date: Thu, 18 Jul 2024 17:43:37 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
CC: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>, <rafael@kernel.org>, <lenb@kernel.org>,
	<james.morse@arm.com>, <tony.luck@intel.com>, <bp@alien8.de>,
	<bhelgaas@google.com>, <robert.moore@intel.com>, <avadhut.naik@amd.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>, <TonyWWang-oc@zhaoxin.com>
Subject: Re: [PATCH v3 0/3] Parse the HEST PCIe AER and set to relevant
 registers
Message-ID: <20240718174337.0000173c@Huawei.com>
In-Reply-To: <20240718154646.GA63955@yaz-khff2.amd.com>
References: <b99685d9-9f3a-4c21-8d33-2eaa5de8be54@zhaoxin.com>
	<20240718062405.30571-1-LeoLiu-oc@zhaoxin.com>
	<20240718154646.GA63955@yaz-khff2.amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 18 Jul 2024 11:46:46 -0400
Yazen Ghannam <yazen.ghannam@amd.com> wrote:

> On Thu, Jul 18, 2024 at 02:24:02PM +0800, LeoLiu-oc wrote:
> > From: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
> > 
> > According to the Section 18.3.2.4, 18.3.2.5 and 18.3.2.6 in ACPI SPEC
> > r6.5, the register value form HEST PCI Express AER Structure should be
> > written to relevant PCIe Device's AER Capabilities. So the purpose of the
> > patch set is to extract register value from HEST PCI Express AER
> > structures and program them into PCIe Device's AER registers.
> > Refer to the ACPI SPEC r6.5 for the more detailed description. This patch
> > is an effective supplement to _HPP/_HPX method when the Firmware does not
> > support the _HPP/_HPX method and can be specially configured for the AER
> > register of the specific device.
> > 
> > v1->v2:
> > - Move the definition of structure "hest_parse_aer_info" to file apei.h.
> > 
> > v2->v3:
> > - The applicable hardware for this patch is added to the commit
> >   information.
> > - Change the function name "program_hest_aer_endpoint" to
> >   "program_hest_aer_common".
> > - Add the comment to function "program_hest_aer_common".
> > - Remove the "PCI_EXP_TYPE_PCIE_BRIDGE" branch handling in function
> >   "program_hest_aer_params".
> >  
> 
> Please include a link to previous threads, if possible.
Also, don't reply to previous thread.  Just send a new thread but
useful to include links to previous.

Given it's nested in my client, v2 is
https://lore.kernel.org/all/20231218030430.783495-1-LeoLiu-oc@zhaoxin.com/

> 
> Thanks,
> Yazen
> 


