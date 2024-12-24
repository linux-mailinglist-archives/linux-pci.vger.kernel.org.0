Return-Path: <linux-pci+bounces-19018-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D899C9FC153
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 19:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AA221628CC
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 18:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E30212B20;
	Tue, 24 Dec 2024 18:43:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54EE1D7994;
	Tue, 24 Dec 2024 18:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735065836; cv=none; b=cYGCX7OMYZJCHCSiMQJDOsvqjtARg3VMs6Rijrr7Mi1BeeFCfHhiuAUhux40VUPVpzwLdfUXxPrDNCDgirssHX1keHpa7NEB6aZjz1C7K6MxM245quU2HsMmq5cnO6N8P8VJN8hZOzai1z9U5gMJmCU2MALDXQ3cxG4ESboJzg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735065836; c=relaxed/simple;
	bh=eUQe3VlDVi/NLUztpYcnC6hub8HQ30qbiRrsn1AecSA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PbYFN/UA7LsWRC3lFKEoDRECD7LXBHmZ7lMZTrJurl0Jz/vVvMuXpFbml+4rATUltAm8Lc0nicT8JSPvMcE9eV8bxXIVoxbDM65k1BZci1mOpfMf81uupVEJAbwzIUCmHYndWlL9fBbt8HD9D5rJsxwceYCVv/duRZvA/e435xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHkKB3vsJz6L76H;
	Wed, 25 Dec 2024 02:42:38 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 36182140133;
	Wed, 25 Dec 2024 02:43:52 +0800 (CST)
Received: from localhost (10.48.156.150) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 19:43:51 +0100
Date: Tue, 24 Dec 2024 18:43:49 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <ming4.li@intel.com>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v4 12/15] cxl/pci: Add error handler for CXL PCIe Port
 RAS errors
Message-ID: <20241224184349.0000424b@huawei.com>
In-Reply-To: <20241211234002.3728674-13-terry.bowman@amd.com>
References: <20241211234002.3728674-1-terry.bowman@amd.com>
	<20241211234002.3728674-13-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 11 Dec 2024 17:39:59 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> Introduce correctable and uncorrectable CXL PCIe port protocol error
> handlers.
> 
> The handlers will be called with a 'struct pci_dev' parameter
> indicating the CXL Port device requiring handling. The CXL PCIe Port
> device's underlying 'struct device' will match the Port device in the
> CXL topology.
> 
> Use the PCIe Port's device object to find the matching Upstream Switch
> Port, Downstream Switch Port, or Root Port in the CXL topology. The
> matching device will contain a reference to the RAS register block used to
> handle and log the error.
> 
> Invoke the existing __cxl_handle_ras() or __cxl_handle_cor_ras() passing
> a reference to the RAS registers as a parameter. These functions will use
> the register reference to clear the device's RAS status.
> 
> Future patches will assign the error handlers and add trace logging.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Other than Li Ming's question, LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


