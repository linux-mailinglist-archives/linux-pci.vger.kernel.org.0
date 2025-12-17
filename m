Return-Path: <linux-pci+bounces-43204-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C393CC8A10
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 16:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A3B0309E558
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 15:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C1134B43F;
	Wed, 17 Dec 2025 15:48:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA6F2FF164;
	Wed, 17 Dec 2025 15:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765986517; cv=none; b=SiQqhZut0WBKk9f/sK76IvODfaniatTKK4ujhfp9UGgFt4iRHeUibLemO1U2UzCAnRM09BBJwwvUmReilySfpuwJJEdGEm+ux7+Lmyi9qAzUxsJhsPebNnzfLl+7l/lluuzx5h7LibkCI3SS/U1CxX2cn8jjDuATK9qQPip1Yp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765986517; c=relaxed/simple;
	bh=4Z/fRxAkhYB+S6AnaWaXiWnOUn/71F98GuSAN1l8tKU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GaqUW9cjC/w6h0FB9nvjx6Q6H7OV90F4gAoAKYGuMyD5prCdXTYUwxH3hzU6sU6bgaBVOpc56t/0APaYZMj78BJutwNvzDjHujN6sPdVd9bTTP9Zi/nJLalAJyYaWSkOez8tp2gkjoUGMzqsttRwlC+m16CZ5cKpsuK1cVP+P00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dWdVW1sgKzJ46Bd;
	Wed, 17 Dec 2025 23:48:03 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id CBA4940565;
	Wed, 17 Dec 2025 23:48:32 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 17 Dec
 2025 15:48:31 +0000
Date: Wed, 17 Dec 2025 15:48:30 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
	<alison.schofield@intel.com>, <terry.bowman@amd.com>,
	<alejandro.lucero-palau@amd.com>, <linux-pci@vger.kernel.org>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v2 4/6] cxl/mem: Convert devm_cxl_add_memdev() to
 scope-based-cleanup
Message-ID: <20251217154830.00001085@huawei.com>
In-Reply-To: <20251216005616.3090129-5-dan.j.williams@intel.com>
References: <20251216005616.3090129-1-dan.j.williams@intel.com>
	<20251216005616.3090129-5-dan.j.williams@intel.com>
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

On Mon, 15 Dec 2025 16:56:14 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> In preparation for adding more setup steps, convert the current
> implementation to scope-based cleanup.
> 
> The cxl_memdev_shutdown() is only required after cdev_device_add(). With
> that moved to a helper function it precludes the need to add
> scope-based-handler for that cleanup if devm_add_action_or_reset() fails.
> 
> Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Tested-by: Alejandro Lucero <alucerop@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
One trivial thing below that is probably fine to cleanup whilst picking this
up.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  drivers/cxl/core/memdev.c | 70 ++++++++++++++++++++++++---------------
>  1 file changed, 44 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 7a4153e1c6a7..18efbf294db5 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c

> +
> +DEFINE_FREE(put_cxlmd, struct cxl_memdev *,
> +	    if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev);)

Bonus ; ?




