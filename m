Return-Path: <linux-pci+bounces-6935-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F278B899D
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 14:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A41361C20BAB
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 12:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA014F20C;
	Wed,  1 May 2024 12:17:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3CA824A3;
	Wed,  1 May 2024 12:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714565821; cv=none; b=qsbuCJ8deKrqv8ErZI11++wDut5vjIjAOw2ObuzqJ4m0erPpgokPVpH/496O/7ryWwZnObb2ewDSrY8ptFZxdr8pQEhqC2Xa7N08zVhiHWSsTQs4l5pQ8mfejDRbtOigFbR6Bjqv6b6poRuoI/4V5VZ9lOLy1XjYlTC94aOeyw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714565821; c=relaxed/simple;
	bh=VeNuP8V+9Dseyd/gDX6kcbd2isafcowipxEMwYfm6os=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MFhmz2LMfrml2f+0fXnfAgD3KqEFfWMzln66kJE5NXz/hKw8Mi47o5P0r/OyxjrRziI63oLM9Wsx7UAagcguT+EoTe1lruZUtQNO7+1la+A7OB8d8hA3Bc3mMIcfI2j8ZJ+9FLa+Yn3GttWPC7ElpyImqTIXs6YeIZJ73UTolB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VTwwM2hkxz67MC6;
	Wed,  1 May 2024 20:14:11 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 19B66140518;
	Wed,  1 May 2024 20:16:55 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 1 May
 2024 13:16:54 +0100
Date: Wed, 1 May 2024 13:16:51 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
CC: <kobayashi.da-06@jp.fujitsu.com>, <linux-cxl@vger.kernel.org>,
	<y-goto@fujitsu.com>, <linux-pci@vger.kernel.org>, <mj@ucw.cz>,
	<dan.j.williams@intel.com>, <dave.jiang@intel.com>
Subject: Re: [PATCH v6 2/2] cxl/pci: Add sysfs attribute for CXL 1.1 device
 link status
Message-ID: <20240501131651.00004cb7@Huawei.com>
In-Reply-To: <20240424050102.26788-3-kobayashi.da-06@fujitsu.com>
References: <20240424050102.26788-1-kobayashi.da-06@fujitsu.com>
	<20240424050102.26788-3-kobayashi.da-06@fujitsu.com>
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
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 24 Apr 2024 14:01:02 +0900
"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com> wrote:

> Add sysfs attribute for CXL 1.1 device link status to the cxl pci device.
> 
> In CXL1.1, the link status of the device is included in the RCRB mapped to
> the memory mapped register area. Critically, that arrangement makes the
> link status and control registers invisible to existing PCI user tooling.
> 
> Export those registers via sysfs with the expectation that PCI user
> tooling will alternatively look for these sysfs files when attempting to
> access to these CXL 1.1 endpoints registers.
> 
> Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Looks good to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


