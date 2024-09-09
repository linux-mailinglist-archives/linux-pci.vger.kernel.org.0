Return-Path: <linux-pci+bounces-12962-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F7D972223
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 20:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11917284880
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 18:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AE5188CDE;
	Mon,  9 Sep 2024 18:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="XmQ2dPkv"
X-Original-To: linux-pci@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E9F1CA9E;
	Mon,  9 Sep 2024 18:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725908151; cv=none; b=IUgVdXOa3mhktoI1TrkJQ6edGxcgn+jxKPtx/2htEGVT+pvZMjJESQ63+FjDDFR81KQJZoJaiBo4dF5xtMI+LtPyDp4n+HtbiojJU639KkHbbK6PSynuUWFv3I/UT19SM+1QOcrVBSg4uIX98ioV6vwIVERQwiGGWmjm3uzGuHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725908151; c=relaxed/simple;
	bh=pJxhYFTsVLvjy61KRNZtlZ1dXALCOvxMZQXMIqh3nHM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=m0+5MUSYsOJIAkS7+AEe4XUAvh1Vm8F+qyts3rOw0K7T5AGN+3LiYCjf1I3C/pPBn6cdRgeTvnd4rw3Zp4MDO/AnOx2cK+WtnwhGa1zqV0Sed34RT5grXIXWy6s2Ed614KSzDT7boHK0DNZ7Rkf9ssAlJx42YLWE3AEFsYbtX+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=XmQ2dPkv; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=5k/Zh3I4yFggtheTtd/5isafLum1OVyyetQ50YqqJdI=; b=XmQ2dPkvqjfI8CYut3Zcl9zTPk
	qBClYeiCFUEhlwZhiEzEQi1hzkhH3/ZhFIg9qb4Znb7Y+Q4xDG9v5LBlM+XG8of4uZqg6XNB1fTpJ
	sTAdMQxx8dAYFKCJ7E6JBl1jqIs9UqOtpmpsePDE0aL5grli3lzfkgWaneSr6cMuCfHx0m9tckAJj
	bq7vlkNeyfmV50tzuGqmrRUwcH/UM3BsfbXbS3FsZ48G/zZSX5lczbDxun/IK1CrjrltNuRRgO1vh
	5JHTgt6tC8qF9OBCm3yNcOg3QwrpGw5LDr+6lPP1CSgNw/UlQ65yjqCuK7Y/Uas/XuGXGx5fAh6C1
	Pk1DJfkw==;
Received: from d104-157-31-28.abhsia.telus.net ([104.157.31.28] helo=[192.168.1.250])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <logang@deltatee.com>)
	id 1snixb-00HMbH-02;
	Mon, 09 Sep 2024 12:17:59 -0600
Message-ID: <dd14d4b8-0215-4d0b-a599-eb75b397447f@deltatee.com>
Date: Mon, 9 Sep 2024 12:17:57 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kaixin Wang <kxwang23@m.fudan.edu.cn>
Cc: 21302010073@m.fudan.edu.cn, 21210240012@m.fudan.edu.cn,
 dave.jiang@intel.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, kurt.schwemmer@microsemi.com,
 bhelgaas@google.com
References: <20240909172007.1863-1-kxwang23@m.fudan.edu.cn>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20240909172007.1863-1-kxwang23@m.fudan.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 104.157.31.28
X-SA-Exim-Rcpt-To: kxwang23@m.fudan.edu.cn, 21302010073@m.fudan.edu.cn, 21210240012@m.fudan.edu.cn, dave.jiang@intel.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kurt.schwemmer@microsemi.com, bhelgaas@google.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH] ntb: ntb_hw_switchtec: Fix use after free vulnerability
 in switchtec_ntb_remove due to race condition
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2024-09-09 11:20, Kaixin Wang wrote:
> In the switchtec_ntb_add function, it can call switchtec_ntb_init_sndev
> function, then &sndev->check_link_status_work is bound with
> check_link_status_work. switchtec_ntb_link_notification may be called
> to start the work.
> 
> If we remove the module which will call switchtec_ntb_remove to make
> cleanup, it will free sndev through kfree(sndev), while the work
> mentioned above will be used. The sequence of operations that may lead
> to a UAF bug is as follows:
> 
> CPU0                                 CPU1
> 
>                         | check_link_status_work
> switchtec_ntb_remove    |
> kfree(sndev);           |
>                         | if (sndev->link_force_down)
>                         | // use sndev
> 
> Fix it by ensuring that the work is canceled before proceeding with
> the cleanup in switchtec_ntb_remove.

Thank you, this looks good to me.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

