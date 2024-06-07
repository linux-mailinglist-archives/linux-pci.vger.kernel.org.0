Return-Path: <linux-pci+bounces-8462-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B10409006AB
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 16:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC3501C214E4
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 14:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A001426AFA;
	Fri,  7 Jun 2024 14:30:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D57519309E;
	Fri,  7 Jun 2024 14:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770649; cv=none; b=O58KT9Yq6CBBm1eWmYx6gIJCt/kWd0R1G078blJAG4uf24ORyKDzDipt3Pcl7CpDJEMBVDkVJ3zmdNlyzuBSan8aDId7oT/QujWcgFtfOzU0ho7dZr0KmC/K8atIWew5EDNK2LLQUVInb8I0YTJ88DsRp30ELxw2L6SMmVVwlYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770649; c=relaxed/simple;
	bh=78AzIyycEMf7kUD5+bonTZpKGk3tnSvD7kCpdxroiwA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tYriR9Xx5yTY5i0hAnyvrlWBODBdjcqYurc2gP8kDL6vqYq3J1LNMH69MnQDxMAq3yVesAQZACsWINES6LdUWIkr5kXyyDmhAUBxFrnSxdjzhlWUzyxeTN5uzInTDo8VCwKQV/YhyYRGuf6/GLh1hpfu5VP8Sxq/PzpgnyG2uyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vwk9P35wsz6D8rX;
	Fri,  7 Jun 2024 22:29:29 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 725651402CB;
	Fri,  7 Jun 2024 22:30:43 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 15:30:43 +0100
Date: Fri, 7 Jun 2024 15:30:42 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v3 2/2] cxl: Calculate region bandwidth of targets with
 shared upstream link
Message-ID: <20240607153042.000046c9@Huawei.com>
In-Reply-To: <c5e2b730-8274-48d0-9553-4c1b8cf4945a@intel.com>
References: <20240529214357.1193417-1-dave.jiang@intel.com>
	<20240529214357.1193417-3-dave.jiang@intel.com>
	<20240605151936.000031df@Huawei.com>
	<c5e2b730-8274-48d0-9553-4c1b8cf4945a@intel.com>
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


> >> +		if (is_cxl_root(parent_port)) {
> >> +			ctx->port = parent_port;
> >> +			cxl_coordinates_combine(ctx->coord, ctx->coord,
> >> +						dport->coord);  
> > 
> > I'm a bit lost in all the levels of iteration so may have missed it.
> > 
> > Do we assume that GP BW (which is the root bridge) is shared across multiple root
> > ports on that host bridge if they are both part of the interleave set?  
> 
> Do we need to count the number of RPs under a HB and do min(aggregated_RPs_BW, (GP_BW / no of RPs) * affiliated_RPs_in_region)?

I'm not 100% sure I understand the question.

Taking this again and expanding it another level.



      Host CPU
______________________________________
        |                           |
        |                           |
        | 3 from GP/HMAT            | 3 from GP/HMAT
   _____|_____               _______|______
  RP         RP             RP            RP
  2|          |2           2|             |2
 __|__     ___|__         __|___        __|____
|1    |1  1|     |1      |1     |1     |1      |1
EP   EP    EP    EP     EP     EP      EP     EP

Then your maths

aggregated RPs BW is 8
(GP_BW/no of RPS) * affliated RPS in region.
= (3/2 * 4)
= 6
Which is correct. So yes, I think that works if we assume everything is balanced.
I'm fine with that assumption as that should be the common case.


Jonathan


