Return-Path: <linux-pci+bounces-26574-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F15EBA995B7
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 18:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E77E46500D
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 16:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E5C281374;
	Wed, 23 Apr 2025 16:49:36 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2E4280CF8;
	Wed, 23 Apr 2025 16:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745426976; cv=none; b=XjxxY19zUatJ1TG6odZFRx/4YON1C992s44yf5tg62V6Shkvui+d5GPkQOePOOBGwgRHj3GB4BGeqiIOLWueZFOaO+EkQ9bglRM5kZoJpXhhY1xxrwqNqvPS7aYhA/jlOabl9/+wyF5PFW+4CfuCI98fQ6LbpKljiTyPByULu9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745426976; c=relaxed/simple;
	bh=DwCe8G6WM/5SuZQn6okJwCC1R2F87Azvs3xG/UrOO2s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PAGxUhfIpWbzHXvQCYAnwpXdp1fKDavEOB+3H6PxjLFzmvr5DmM8rz8nVzsVBLSjBD1m1xBmJnoEAurPxf5TTxq9IYy15vOJQaUA0jDjqqHkx/zjeRgNhJqjmZqTWCPCuhZg/v1ZQcWtotpw2Mux3x20VUn4q5uuGpqS3rpADiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZjQ2T1wpwz6M4mH;
	Thu, 24 Apr 2025 00:45:21 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CE3D71404FA;
	Thu, 24 Apr 2025 00:49:30 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 23 Apr
 2025 18:49:29 +0200
Date: Wed, 23 Apr 2025 17:49:28 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <ming.li@zohomail.com>,
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v8 13/16] cxl/pci: Assign CXL Endpoint protocol error
 handlers
Message-ID: <20250423174928.00005879@huawei.com>
In-Reply-To: <20250327014717.2988633-14-terry.bowman@amd.com>
References: <20250327014717.2988633-1-terry.bowman@amd.com>
	<20250327014717.2988633-14-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 26 Mar 2025 20:47:14 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> CXL Endpoint protocol errors are currently handled using PCI error
> handlers. The CXL Endpoint requires CXL specific handling in the case of
> uncorrectable error handling not provided by the PCI handlers.
> 
> Add CXL specific handlers for CXL Endpoints. Assign the CXL handlers
> during Endpoint Port initialization.
> 
> Keep the PCI Endpoint handlers. PCI handlers can be called if the CXL
> device is not trained for alternate protocol (CXL). Update the CXL
> Endpoint PCI handlers to call the CXL handler. If the CXL
> uncorrectable handler returns PCI_ERS_RESULT_PANIC then the PCI
> handler invokes panic().
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

