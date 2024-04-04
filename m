Return-Path: <linux-pci+bounces-5729-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02068898941
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 15:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 884081C20DBF
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 13:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D971272A3;
	Thu,  4 Apr 2024 13:52:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FEC12838B;
	Thu,  4 Apr 2024 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712238769; cv=none; b=UDsQISV6OFnRutT6a4tLHUk1PPJvKudhAVYekD8Rcq8Dx3CkBeTr/3csBjDj4U0UeOzPhTUj2PlxvpXCBys8Xm9LLz5zAkAyrZfm6dMDiQZOsn2bquWBqVWRxIN+Kyj/uRePtucVhc9++qaKJf2iNTNG+PeYuoY15oFocBJeshc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712238769; c=relaxed/simple;
	bh=p/xIWORqgT6hpFpXe4AVo+Pf1rB1FZaKpn1vwwBA98g=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ODFHhLO47IVyTWDTrRy3B9y+zSpN+U1/772omIQjRoQ/QADC7sqllvAoy/+7peL7KqkuRYqrqt2M5CSmI175FCOAtvZkZ/P5K5ezmsSXlPZXsjoFRN0MimZc88xTQYIlzscGf7SzpRFb3rsM0wRxpIaVOMu7PRX2S0c47uIOx1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V9NH84qjrz6J7Df;
	Thu,  4 Apr 2024 21:48:04 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D9C43140C72;
	Thu,  4 Apr 2024 21:52:43 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 4 Apr
 2024 14:52:43 +0100
Date: Thu, 4 Apr 2024 14:52:42 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Lukas Wunner <lukas@wunner.de>
CC: Dan Williams <dan.j.williams@intel.com>, Bjorn Helgaas
	<helgaas@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>, <bhelgaas@google.com>
Subject: Re: [PATCH v2 1/3] PCI: Add check for CXL Secondary Bus Reset
Message-ID: <20240404145242.00002dd8@Huawei.com>
In-Reply-To: <Zg5skrUCyx17fRjq@wunner.de>
References: <6605bef53c82b_1fb31e29481@dwillia2-xfh.jf.intel.com.notmuch>
	<20240402172323.GA1818777@bhelgaas>
	<660c44604f0a3_19e029497@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	<20240403154441.00002e30@Huawei.com>
	<Zg5skrUCyx17fRjq@wunner.de>
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

On Thu, 4 Apr 2024 11:02:10 +0200
Lukas Wunner <lukas@wunner.de> wrote:

> On Wed, Apr 03, 2024 at 03:44:41PM +0100, Jonathan Cameron wrote:
> > > Bjorn Helgaas wrote:  
> > > > FWIW, I pinged administration@pcisig.com and got the response that
> > > > "1E98h is not a VID in our system, but 1E98 has already been reserved
> > > > by CXL."
> > > > 
> > > > I wish there were a clearer public statement of this reservation, but
> > > > I interpret the response to mean that CXL is not a "Vendor", maybe due
> > > > to some strict definition of "Vendor," but that PCI-SIG will not
> > > > assign 0x1e98 to any other vendor.
> > > > 
> > > > So IMO we should add "#define PCI_VENDOR_ID_CXL 0x1e98" so that if we
> > > > ever *do* see such an assignment, we'll be more likely to flag it as
> > > > an issue.    
> > 
> > Sorry for late entry on this discussion and I'll be careful what I say
> > on the history.
> > 
> > As you've guessed it was "entertaining" and for FWIW that text occurs
> > in other consortium specs (some predate CXL).
> > 
> > It's reserved with agreement from the PCI SIG for a strictly defined set
> > of purposes that does not correspond to those allowed for a normal ID
> > granted to a vendor member. As you say CXL isn't a vendor (don't ask
> > how DMTF got a vendor ID - 0x1AB4).
> > 
> > Hence the naming gymnastics and vague answers to avoid any chance of
> > lawyers getting involved :(  
> 
> Hm, I'm wondering if avoiding the term "vendor" with something like
> 
> #define PCI_CONSORTIUM_ID_CXL 0x1e98
> 
> would assuage the angst of a legal misstep? ;)
Works for me, but I really hope we don't have to care :(

Jonathan

