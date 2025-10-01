Return-Path: <linux-pci+bounces-37354-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B5ABB1034
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 17:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EB4A3ABF4A
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 15:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5DC259CBD;
	Wed,  1 Oct 2025 15:12:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D431E7C19;
	Wed,  1 Oct 2025 15:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759331521; cv=none; b=AtIu4E0zLjRbIjitFNoD0aeN/jnzX4nEhPzDJA9Xo7GmVhzUB0R9Ub515f2TD2Ca2cWVMPVZDEPULXPGbsUJSDmdFVAJ/cMHvaQvn8zbXkd+qwsHlteHtAV0ALKtrT6KXC8R88YkhqfKClq9Dq2WrFdiJdkKy9nbVPRCxvjSEH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759331521; c=relaxed/simple;
	bh=e+32P1M8vjBzMfiJeZXG0sLqbNEg2nAu6vpkb5VTwKw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U++upCbN85zRVhQyXfD0nx0VRORLm6/PaDphm4iI7dyKmuItaeB+OylC586YU++vSrEYw/METwmhaAaCCOvug3LVZOOBRT0F9x7SmesfustGnBFetfBL12ZPiGaBf8p8bjUIbDKcFu8lviYKeCBViaxjGPUlIUQQHfKjlqQvqYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ccJGm5Gswz6K8vK;
	Wed,  1 Oct 2025 23:08:48 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 3DEFF140114;
	Wed,  1 Oct 2025 23:11:57 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 1 Oct
 2025 16:11:56 +0100
Date: Wed, 1 Oct 2025 16:11:54 +0100
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
Subject: Re: [PATCH v12 04/25] CXL/AER: Remove CONFIG_PCIEAER_CXL and
 replace with CONFIG_CXL_RAS
Message-ID: <20251001161154.0000787b@huawei.com>
In-Reply-To: <20250925223440.3539069-5-terry.bowman@amd.com>
References: <20250925223440.3539069-1-terry.bowman@amd.com>
	<20250925223440.3539069-5-terry.bowman@amd.com>
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

On Thu, 25 Sep 2025 17:34:19 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> CXL RAS compilation is enabled using CONFIG_CXL_RAS while the AER CXL logic
> uses CONFIG_PCIEAER_CXL. The 2 share the same dependencies and can be
> combined. The 2 kernel configs are unnecessary and are problematic for the
> user because of the duplication. Replace occurrences of CONFIG_PCIEAER_CXL
> to be CONFIG_CXL_RAS.
> 
> Update the CONFIG_CXL_RAS Kconfig definition to include dependencies 'PCIEAER
> && CXL_PCI' taken from the CONFIG_PCIEAER_CXL definition.
> 
> Remove the Kconfig CONFIG_PCIEAER_CXL definition.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
Seems reasonable.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

