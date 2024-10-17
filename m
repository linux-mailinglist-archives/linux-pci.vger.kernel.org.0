Return-Path: <linux-pci+bounces-14782-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F369A23CF
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 15:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17009B2233E
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 13:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C54A1DDC13;
	Thu, 17 Oct 2024 13:31:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612DD1DDA31;
	Thu, 17 Oct 2024 13:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729171878; cv=none; b=Q7N4MXW1R4LkIjEi1qCXm7bJfmyb29LV4IZa+4QW2LX3o8ysiOt/BbCuU4eSGt+Rmo3+dsVYAFWgMYupZ9ALU19XHSMZrkGntSzuH1RQZayd343kxtqPvcPPRiM9yKk3h5CrlpvSPt1cUhJbiaPR1JA3V1igGdXOpvTuQVokBns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729171878; c=relaxed/simple;
	bh=AA0+BSw8gb7CWEmHQjYrvI9mdR0Nlru1/nmOVynku28=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N8jUOy7+SaeXiw0k14ZFKZ/51wHk+dKFlLCfPd4gvSQQxHpaQAsRPd/1jpxEuu1mSh3cc440jzZ+DX2CCT2Hj6I6dlnDd3wE5JLb3+oe/+Ey1IHx+s+fIIHi5gNVn6K+l4tnJmDZvKVQJ3pW2aZoFzhziGXAiQiKQQ9CUDFqy7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTpbC4wtmz6FGr7;
	Thu, 17 Oct 2024 21:29:27 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D8019140119;
	Thu, 17 Oct 2024 21:31:11 +0800 (CST)
Received: from localhost (10.126.174.164) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Oct
 2024 15:31:10 +0200
Date: Thu, 17 Oct 2024 14:31:08 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Terry Bowman <Terry.Bowman@amd.com>
CC: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <oohall@gmail.com>,
	<Benjamin.Cheatham@amd.com>, <rrichter@amd.com>, <nathan.fontenot@amd.com>,
	<smita.koralahallichannabasappa@amd.com>
Subject: Re: [PATCH 06/15] cxl/aer/pci: Introduce PCI_ERS_RESULT_PANIC to
 pci_ers_result type
Message-ID: <20241017143108.000075ff@Huawei.com>
In-Reply-To: <6555a001-4f5e-40c0-bf27-38dd7a15c3d9@amd.com>
References: <20241008221657.1130181-1-terry.bowman@amd.com>
	<20241008221657.1130181-7-terry.bowman@amd.com>
	<20241016173011.000021e4@Huawei.com>
	<6555a001-4f5e-40c0-bf27-38dd7a15c3d9@amd.com>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 16 Oct 2024 12:31:35 -0500
Terry Bowman <Terry.Bowman@amd.com> wrote:

> On 10/16/24 11:30, Jonathan Cameron wrote:
> > On Tue, 8 Oct 2024 17:16:48 -0500
> > Terry Bowman <terry.bowman@amd.com> wrote:
> >   
> >> The CXL AER service will be updated to support CXL PCIe port error
> >> handling in the future. These devices will use a system panic during
> >> recovery handling.  
> > 
> > Recovery handling by panic? :) That's an interesting form of recovery..
> >   
> 
> Yes, Dan requested all UCE (fatal and non-fatal) are handled by panic in order 
> to limit the  blast radius of corruption in the  case of UCE. 
That's fair enough.  Maybe it should be called attempted recovery handling ;)

This is fine.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Jonathan

> 
> The recovery logic in cxl_do_recovery() (not using the panic) is also tested as well.
> 
> Regards,
> Terry
> 
> >>
> >> Add PCI_ERS_RESULT_PANIC enumeration to pci_ers_result type.
> >>
> >> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> >> ---
> >>  include/linux/pci.h | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/include/linux/pci.h b/include/linux/pci.h
> >> index 4cf89a4b4cbc..6f7e7371161d 100644
> >> --- a/include/linux/pci.h
> >> +++ b/include/linux/pci.h
> >> @@ -857,6 +857,9 @@ enum pci_ers_result {
> >>  
> >>  	/* No AER capabilities registered for the driver */
> >>  	PCI_ERS_RESULT_NO_AER_DRIVER = (__force pci_ers_result_t) 6,
> >> +
> >> +	/* Device state requires system panic */
> >> +	PCI_ERS_RESULT_PANIC = (__force pci_ers_result_t) 7,
> >>  };
> >>  
> >>  /* PCI bus error event callbacks */  
> >   


