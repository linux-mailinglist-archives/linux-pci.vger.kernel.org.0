Return-Path: <linux-pci+bounces-37356-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BF9BB10C7
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 17:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12DDB188F20C
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 15:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288561B4F2C;
	Wed,  1 Oct 2025 15:23:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EB218DB01;
	Wed,  1 Oct 2025 15:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759332211; cv=none; b=P2WppJLxz6yISIAi+np7r70ehcpbE61VCnm0Id6f/OT9Iv8evl7F48Y1J0F3/ox700PEwo15YkZArPUgPBrBVDd8suAkvvTB6vpIM4uMqkJnhQytjvaTJeLTFlUuozX5vBJ4P5/5Xx8JzGT3YedE65qQLolaSnAoDv3oYVFqu34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759332211; c=relaxed/simple;
	bh=jVqxPRXRq6SK8y+VbZrMaNMlaS4JvvNTrxIHVPAj/Ck=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vAE5PapdXosPgyLzMTmNMpM9oeN2DHslCJzcL/GIwtj3mGyVQagTIpQBceNpkRGm+cNhU+B4qg3WzDt2jomYZtCsNKCk81y1JF6jtQO5uC7JgN4wvKIDXJ/uNYjDRLoeJ2DYoapqRonQBCqbO3qc5QUAMAvegvg9507kVYKL7yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ccJbJ0319z6K5kg;
	Wed,  1 Oct 2025 23:23:08 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 8C64B140114;
	Wed,  1 Oct 2025 23:23:25 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 1 Oct
 2025 16:23:24 +0100
Date: Wed, 1 Oct 2025 16:23:22 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Terry Bowman <terry.bowman@amd.com>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<alucerop@amd.com>, <ira.weiny@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v12 05/25] cxl: Move CXL driver RCH error handling into
 CONFIG_CXL_RCH_RAS conditional block
Message-ID: <20251001162322.00002849@huawei.com>
In-Reply-To: <01bebc6a-c982-4826-8202-703a948c1d48@intel.com>
References: <20250925223440.3539069-1-terry.bowman@amd.com>
	<20250925223440.3539069-6-terry.bowman@amd.com>
	<01bebc6a-c982-4826-8202-703a948c1d48@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

> > diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> > index 0875ce8116ff..1ec4ea8c56f1 100644
> > --- a/drivers/cxl/core/ras.c
> > +++ b/drivers/cxl/core/ras.c
> > @@ -126,6 +126,10 @@ void cxl_ras_exit(void)
> >  	cancel_work_sync(&cxl_cper_prot_err_work);
> >  }
> >  
> > +static void cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
> > +static bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
> > +
> > +#ifdef CONFIG_CXL_RCH_RAS  
> 
> I don't love this in the C file. If we are going to have a Kconfig that we can use to gate the code, maybe we need core/ras_rch.c? Don't forget to add the new object entry to KBuild for cxl_test when you do that. 
> 

Seconded.  Seems worth an extra file to me as well.

J
> DJ

