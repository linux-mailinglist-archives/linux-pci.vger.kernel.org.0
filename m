Return-Path: <linux-pci+bounces-5621-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 513608972EE
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 16:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A2701C26CF2
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 14:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB8313A25C;
	Wed,  3 Apr 2024 14:44:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0E65CDC9;
	Wed,  3 Apr 2024 14:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712155490; cv=none; b=EhWd2J7cXh5ex/PVnR4c8qAplcQhCdZxWkFgRnmvec0+ePl4EtZ6p5f5vxRDUhrKpWKbj6PxF5Kuuuz+LdrDdUNJw67dIDTYpn7bduN4jfOnu5wmGZFuXlSF1Dcbo0p1EUTlEMaEhMt7+MabEMjw/wVxCeuiy8Ayb6HiPfD8Nac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712155490; c=relaxed/simple;
	bh=IrUDpDbY6A60AvasDp0VrbVMOemlAHNy1JjbHgYZ0KA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h9xPAjVRV8gnmYnChICduItbE5HfUAPfcBD1oxNfzKCLf23VHxt+X0Ok4szQdqfxaIqR4NE3P1J4Hae67K8HxBlkVSo69DLkArx8RPNFxwf3NJPx86axE9ixzenZqrCGLgG3GLwE4eBzlvz/VAIxcMDh6h9vNDmhaHsJj96l7DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V8nYR0YQBz6D8W7;
	Wed,  3 Apr 2024 22:43:23 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 9E61F140B73;
	Wed,  3 Apr 2024 22:44:42 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 3 Apr
 2024 15:44:41 +0100
Date: Wed, 3 Apr 2024 15:44:41 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <bhelgaas@google.com>,
	<lukas@wunner.de>
Subject: Re: [PATCH v2 1/3] PCI: Add check for CXL Secondary Bus Reset
Message-ID: <20240403154441.00002e30@Huawei.com>
In-Reply-To: <660c44604f0a3_19e029497@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <6605bef53c82b_1fb31e29481@dwillia2-xfh.jf.intel.com.notmuch>
	<20240402172323.GA1818777@bhelgaas>
	<660c44604f0a3_19e029497@dwillia2-mobl3.amr.corp.intel.com.notmuch>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 2 Apr 2024 10:46:08 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Bjorn Helgaas wrote:
> [..]
> > FWIW, I pinged administration@pcisig.com and got the response that
> > "1E98h is not a VID in our system, but 1E98 has already been reserved
> > by CXL."
> > 
> > I wish there were a clearer public statement of this reservation, but
> > I interpret the response to mean that CXL is not a "Vendor", maybe due
> > to some strict definition of "Vendor," but that PCI-SIG will not
> > assign 0x1e98 to any other vendor.
> > 
> > So IMO we should add "#define PCI_VENDOR_ID_CXL 0x1e98" so that if we
> > ever *do* see such an assignment, we'll be more likely to flag it as
> > an issue.  
> 
> Agree.

Sorry for late entry on this discussion and I'll be careful what I say
on the history.

As you've guessed it was "entertaining" and for FWIW that text occurs
in other consortium specs (some predate CXL).

It's reserved with agreement from the PCI SIG for a strictly defined set
of purposes that does not correspond to those allowed for a normal ID
granted to a vendor member. As you say CXL isn't a vendor (don't ask
how DMTF got a vendor ID - 0x1AB4).

Hence the naming gymnastics and vague answers to avoid any chance of
lawyers getting involved :(

Jonathan



