Return-Path: <linux-pci+bounces-9009-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 871E7910139
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 12:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD1361C20C36
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 10:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5241A8C05;
	Thu, 20 Jun 2024 10:14:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90787E58C;
	Thu, 20 Jun 2024 10:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718878443; cv=none; b=XYUjBWxmQ5cC+cze2WGsTJnJRo6pLgLIWbxHJEM5jk9y7XpMhH7L4nBw8TW1mqAuF+c8FXizCXLc+qVASRDH0xxNVrfm4nGlC+H+EC4pNEegCcOVAtLGj2PjD9pOvbA8Z+SKznh7l4w9kMkpb5eLjv3ex0rJvo6Fdbkhqe+5EwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718878443; c=relaxed/simple;
	bh=rqEJ1E3B8D88tLogDgJy//2/NvAS7IhW9VG3e6M3LHs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nQEXA2GapulC7oYVPMt7mhy1OvF/EO9fkaqstVGIzex8+RLXqvMCIGeK4CSBoZRNkkmZ5Qjje82sDEiseiMd/bPI3pAIlkYS++dqnZYvPx2QTFnJ1sQGluFSguAHA+rscAPcfv58jd7QHcZ2jJwESI4qfSNuNXEtdf9o3SZ809s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W4bt83fzHz6K6WD;
	Thu, 20 Jun 2024 18:13:36 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E07B3140A90;
	Thu, 20 Jun 2024 18:13:59 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 20 Jun
 2024 11:13:59 +0100
Date: Thu, 20 Jun 2024 11:13:58 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v5 1/2] cxl: Preserve the CDAT access_coordinate for an
 endpoint
Message-ID: <20240620111358.00003fa5@Huawei.com>
In-Reply-To: <20240618231730.2533819-2-dave.jiang@intel.com>
References: <20240618231730.2533819-1-dave.jiang@intel.com>
	<20240618231730.2533819-2-dave.jiang@intel.com>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 18 Jun 2024 16:16:40 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Keep the access_coordinate from the CDAT tables for region perf
> calculations. The region perf calculation requires all participating
> endpoints to have arrived in order to determine if there are limitations
> of bandwidth data due to shared uplink.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

