Return-Path: <linux-pci+bounces-15640-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 544479B68B1
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 16:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D25BFB2329C
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 15:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D895213EDC;
	Wed, 30 Oct 2024 15:59:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA130213EFF;
	Wed, 30 Oct 2024 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730303946; cv=none; b=Vo8Lh3zXILVN15biyGrz2yy3EHwhgVe3qPuR1s/1soJUtuI83qiUljdi3vCFYYIEwDbWqVBOnmq8zSWW+OkmRsPUbWVrLyU4QdDo1UKh7iu9lQduWoGX3Syllfw/vM8gMy+wfI2WyDeDs6fL7WmsHbwluoBosqn3aO1dMwTpzb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730303946; c=relaxed/simple;
	bh=izOxNBnMwK2x6wyTuLbVwu4dfjX4Be2CqB/qIo5sb04=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=diZbDK2+G/Vt3HMAMyjQBM9QUye4GvLCauMeze5dCs/cy5JCCGzDbqRF7p+USZLy/WThhHY7a8i6elhgU1PQ4F164KyY+otVUyu75eubwXBbW6AIYRld6ZGLgsXmwNhaByEB618csLUAWPZlqhin6GxOHVOclUNBT9RUeu/hJiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XdsF13FGyz6K6XB;
	Wed, 30 Oct 2024 23:56:37 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E06C9140453;
	Wed, 30 Oct 2024 23:59:02 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Oct
 2024 16:59:02 +0100
Date: Wed, 30 Oct 2024 15:59:00 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH v2 11/14] cxl/pci: Rename RAS handler interfaces to also
 indicate CXL PCIe port support
Message-ID: <20241030155900.00000867@Huawei.com>
In-Reply-To: <20241025210305.27499-12-terry.bowman@amd.com>
References: <20241025210305.27499-1-terry.bowman@amd.com>
	<20241025210305.27499-12-terry.bowman@amd.com>
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
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 25 Oct 2024 16:03:02 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

Patch title looks unconnected to the patch. Cut and paste issue?


> CXL PCIe port protocol error handling support will be added to the
> CXL drivers in the future. In preparation, rename the existing
> interfaces to support handling all CXL PCIe port protocol errors.
> 
> The driver's RAS support functions currently rely on a 'struct
> cxl_dev_state' type parameter, which is not available for CXL port
> devices. However, since the same CXL RAS capability structure is
> needed across most CXL components and devices, a common handling
> approach should be adopted.
> 
> To accommodate this, update the __cxl_handle_cor_ras() and
> __cxl_handle_ras() functions to use a `struct device` instead of
> `struct cxl_dev_state`.
> 
> No functional changes are introduced.
> 
> [1] CXL 3.1 Spec, 8.2.4 CXL.cache and CXL.mem Registers
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Otherwise looks fine


