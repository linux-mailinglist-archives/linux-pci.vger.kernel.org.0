Return-Path: <linux-pci+bounces-40281-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3450DC32B0F
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 19:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 23C274EB2C2
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 18:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A3A3328E1;
	Tue,  4 Nov 2025 18:41:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE04B32D0F6;
	Tue,  4 Nov 2025 18:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762281667; cv=none; b=NbJMOqWXjl7IPNRr2dwKvwRf0tuW2A2XjfpVzHl6y81ISJvf/zJfNcKa2KrHFuAR9V3wpRiqlfE27hJ5aILC2SrFj949kLyRroqX/lhcd1Smr4hKe+kvWm+oezowv9pKq9F7SYmNFoisIOe6sDJv/ifbpVQg9+oRes+VcSIsH3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762281667; c=relaxed/simple;
	bh=lrL3/WItw6GMr++iGni3XaQxYHNwMg9KU+0x1jcAD08=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GKq8l1DKqGyabJUjengUma6Ua90QdeUmEqhvFzv4Xts3LlOlMG71E8zhAXfIYLQvDDT1kVgVVdczM81g1T3eh7o1/eAP68tHRXZRrAC7J49k/4f36RcUvG5BHNd7d2dtKoK4IjJaBBzgRrpIjWD94rMjiy1N9bl5zhutu8TRyKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d1HMt5RRdzHnGgC;
	Wed,  5 Nov 2025 02:40:58 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 981F01402A4;
	Wed,  5 Nov 2025 02:41:02 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 4 Nov
 2025 18:41:01 +0000
Date: Tue, 4 Nov 2025 18:41:00 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [RESEND v13 22/25] CXL/PCI: Export and rename merge_result() to
 pci_ers_merge_result()
Message-ID: <20251104184100.0000018e@huawei.com>
In-Reply-To: <20251104170305.4163840-23-terry.bowman@amd.com>
References: <20251104170305.4163840-1-terry.bowman@amd.com>
	<20251104170305.4163840-23-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 4 Nov 2025 11:03:02 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> CXL uncorrectable errors (UCE) will soon be handled separately from the PCI
> AER handling. The merge_result() function can be made common to use in both
> handling paths.
> 
> Rename the PCI subsystem's merge_result() to be pci_ers_merge_result().
> Export pci_ers_merge_result() to make available for the CXL and other
> drivers to use.
> 
> Update pci_ers_merge_result() to support recently introduced PCI_ERS_RESULT_PANIC
> result.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

