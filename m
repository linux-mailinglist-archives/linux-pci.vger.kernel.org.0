Return-Path: <linux-pci+bounces-37353-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD77BB0FDA
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 17:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CDD7162C4A
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 15:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF7C1E5B88;
	Wed,  1 Oct 2025 15:10:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DA612E1E9;
	Wed,  1 Oct 2025 15:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759331408; cv=none; b=HtAkajGiSeHyYquqMoXkTiBKNr+ILZUP6CC9sjqNZNwHUnx5ekscMVZezBGpWgaq5nSQGK9Ighq3eacHq/7cGf+kJ3JMa9gCAX1wV5eyY1O6USvkavDILQcRfOjXKAzEx3RYbFbS+mDOl5jetIJmvle9tUEoklY/LSMq0dLQSfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759331408; c=relaxed/simple;
	bh=HvnXgTJbJ0MVYqnqUhs5cKKuD6dGLE4p52uFjAzybC0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RaMTv4aiwvoX/912CB5ps5reHkn6G3tvpGT8nGNsfYkXNsdaamqU+l9FgzTNipmG20hAV7QeEV5wsYHJPBzH4hDkls1JkcM9AacC3nJJhZtZcTGyM6RH7iXOyK9GAQYefcQJEqbwWiYSw5Gl2IOSWJdXqYg8APiujxfnXit3K9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ccJHr5Xyrz6K5qB;
	Wed,  1 Oct 2025 23:09:44 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D3E4140370;
	Wed,  1 Oct 2025 23:10:02 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 1 Oct
 2025 16:10:01 +0100
Date: Wed, 1 Oct 2025 16:09:59 +0100
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
Subject: Re: [PATCH v12 02/25] cxl/pci: Remove unnecessary CXL RCH handling
 helper functions
Message-ID: <20251001160959.0000050f@huawei.com>
In-Reply-To: <20250925223440.3539069-3-terry.bowman@amd.com>
References: <20250925223440.3539069-1-terry.bowman@amd.com>
	<20250925223440.3539069-3-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 25 Sep 2025 17:34:17 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> cxl_handle_rdport_cor_ras() and cxl_handle_rdport_ras() are specific
> to Restricted CXL Host (RCH) handling. Improve readability and
> maintainability by replacing these and instead using the common
> cxl_handle_cor_ras() and cxl_handle_ras() functions.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

