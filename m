Return-Path: <linux-pci+bounces-8476-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0A2900BA2
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 19:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F11FF1C2220D
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 17:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7111019AD90;
	Fri,  7 Jun 2024 17:58:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D27A19ADAE;
	Fri,  7 Jun 2024 17:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717783091; cv=none; b=vCc/tP6qosSQw0W1uMtP15KhHDHwEwil8k5B5t54QipN9v1fIvDtihLV93Rx6qvLwFNjWjRl3QXWqaRHFMMf6ZiL/vPH4mfa3tRDwud+O+NmZPG2R1mvpMITcw9mf4n/8FRiwyUuD7oNnUkKJ8fh2/oOtLumGKBRdzhlucVXYxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717783091; c=relaxed/simple;
	bh=djLVwRYADCRsn6mXlpC3+LTYBS/XLkzLolWphDFBK9g=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bqU9pZEjz3ZmCqAdPoLaZ7YNPganP42ersAwL2dC+yeijD5njoqb9Kk2fKtg0Cclu9hxaDXTutEUoUjJNJyekTj8rTkA1N4DW/RJd4SH7kDJrajjIkg8PKQUrWGRE4YLW+i6kaDkGafFhR1ExvQkAThk1285CONj0jgXcvAgRbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vwpj16yFGz6J9dh;
	Sat,  8 Jun 2024 01:53:41 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A53A7140A70;
	Sat,  8 Jun 2024 01:58:06 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 18:58:06 +0100
Date: Fri, 7 Jun 2024 18:58:05 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v3 2/2] cxl: Calculate region bandwidth of targets with
 shared upstream link
Message-ID: <20240607185805.00007872@Huawei.com>
In-Reply-To: <92744829-dbb8-4681-914d-c36797518e3c@intel.com>
References: <20240529214357.1193417-1-dave.jiang@intel.com>
	<20240529214357.1193417-3-dave.jiang@intel.com>
	<20240605151936.000031df@Huawei.com>
	<c5e2b730-8274-48d0-9553-4c1b8cf4945a@intel.com>
	<20240607153042.000046c9@Huawei.com>
	<92744829-dbb8-4681-914d-c36797518e3c@intel.com>
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

On Fri, 7 Jun 2024 09:12:31 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 6/7/24 7:30 AM, Jonathan Cameron wrote:
> >   
> >>>> +		if (is_cxl_root(parent_port)) {
> >>>> +			ctx->port = parent_port;
> >>>> +			cxl_coordinates_combine(ctx->coord, ctx->coord,
> >>>> +						dport->coord);    
> >>>
> >>> I'm a bit lost in all the levels of iteration so may have missed it.
> >>>
> >>> Do we assume that GP BW (which is the root bridge) is shared across multiple root
> >>> ports on that host bridge if they are both part of the interleave set?    
> >>
> >> Do we need to count the number of RPs under a HB and do min(aggregated_RPs_BW, (GP_BW / no of RPs) * affiliated_RPs_in_region)?  
> > 
> > I'm not 100% sure I understand the question.
> > 
> > Taking this again and expanding it another level.
> > 
> > 
> > 
> >       Host CPU
> > ______________________________________
> >         |                           |
> >         |                           |
> >         | 3 from GP/HMAT            | 3 from GP/HMAT
> >    _____|_____               _______|______
> >   RP         RP             RP            RP
> >   2|          |2           2|             |2
> >  __|__     ___|__         __|___        __|____
> > |1    |1  1|     |1      |1     |1     |1      |1
> > EP   EP    EP    EP     EP     EP      EP     EP
> > 
> > Then your maths
> > 
> > aggregated RPs BW is 8
> > (GP_BW/no of RPS) * affliated RPS in region.
> > = (3/2 * 4)
> > = 6  
> 
> While the result is the same, the math would be this below right?
> min((3/2 * 2), 4) + min((3/2 * 2), 4)

That's better, but I thought your thing above was about RPs in a HB vs
RPs across the whole thing.  Hence was trying to align with that.

I'm lost and it's end of Friday.  Lets work this out with code.

Jonathan
> 
> > Which is correct. So yes, I think that works if we assume everything is balanced.
> > I'm fine with that assumption as that should be the common case.
> > 
> > 
> > Jonathan
> > 
> >   
> 


