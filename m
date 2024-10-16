Return-Path: <linux-pci+bounces-14659-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A289A0F6B
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 18:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1203F1C22AA4
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 16:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE3E20F5DD;
	Wed, 16 Oct 2024 16:12:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B7A205E23;
	Wed, 16 Oct 2024 16:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729095126; cv=none; b=Rwjq3kRf3tQkO9SN1MrDzh7P0M4HpVvjPFbUFQOx7V2+mXBBlyCcUVzk6hE1HUJ12RQmUCwA1ypixqdvGuJxb/X95qPTROqabc5B/PL7Er2jkjwCrnFuqgJiO37PssvSlpbqVu/UqsO52iElS4Pfo29HF+WRlW9m24jqG6QiNJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729095126; c=relaxed/simple;
	bh=olTAeeYy1NLCDapKRpMFnDBIFDr4TFhhnSmanR1b1mk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ehk5COW9KasvBTqZPNbxkdmYfEbgYDHEpKmgJ4ba1XSmA4BjN/jHjXcZHCV+/f6GZOlo9Z96F0CCWmcEBrkWXwWuCdFjnrlPMTmaLEuCgCDbb3pL89dF09c7QPEHFifCcQnGUu68vqfYW9qR9k8V+LZvBNXIskSJeWRXRLyw4Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTGDT5Fx0z6D8q7;
	Thu, 17 Oct 2024 00:11:21 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E5B51400DB;
	Thu, 17 Oct 2024 00:11:59 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 16 Oct
 2024 18:11:58 +0200
Date: Wed, 16 Oct 2024 17:11:57 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <oohall@gmail.com>,
	<Benjamin.Cheatham@amd.com>, <rrichter@amd.com>, <nathan.fontenot@amd.com>,
	<smita.koralahallichannabasappa@amd.com>
Subject: Re: [PATCH 02/15] cxl/aer/pci: Update is_internal_error() to be
 callable w/o CONFIG_PCIEAER_CXL
Message-ID: <20241016171157.00004898@Huawei.com>
In-Reply-To: <20241008221657.1130181-3-terry.bowman@amd.com>
References: <20241008221657.1130181-1-terry.bowman@amd.com>
	<20241008221657.1130181-3-terry.bowman@amd.com>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 8 Oct 2024 17:16:44 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> CXL port error handling will be updated in future and will use
> logic to determine if an error requires CXL or PCIe processing.
> Internal errors are one indicator to identify an error is a CXL
> protocol error.
> 
> is_internal_error() is currently limited by CONFIG_PCIEAER_CXL
> kernel config.
> 
> Update the is_internal_error() function's declaration such that it is
> always available regardless if CONFIG_PCIEAER_CXL kernel config
> is enabled or disabled.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Given this has nothing specifically to do with CXL, this seems
sensible to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

