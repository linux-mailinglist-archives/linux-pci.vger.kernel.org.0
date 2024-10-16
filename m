Return-Path: <linux-pci+bounces-14690-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EC69A128A
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 21:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D375B286563
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 19:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62885194A4B;
	Wed, 16 Oct 2024 19:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="ZjyhWYi3"
X-Original-To: linux-pci@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7091165EE6
	for <linux-pci@vger.kernel.org>; Wed, 16 Oct 2024 19:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729106983; cv=none; b=k6Lls/wFCVr3+iiJKYSORpj04lByYVEpFK2CGnUUlnGKHdhE6t5hEIdJrVwghnAvQb/H+DVe6QcoiTGLvtiC91uoyOSrvWXpnYVo5pwbJF5f0H3caWgffLfAhDBIEM5f7ZG1Vk0DyzFdDa7w+5j/2103Pq74mHNFJD663B7re7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729106983; c=relaxed/simple;
	bh=E3pz5NktMcCGwJTcSzoyiX83mvd/y+YLGX6taQ43k9c=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=bj9Ttw1VxvWer/rFZpnWD3oI/xitCRh7ztJK/2qXFKBuB5mK/xSzPzneoXL7v+EGet9ThIaxlvbsiEBoQw+n5Nr2jvWK3gs4DnVF9W+T3yKnSxUrsAauZJDSOnqHGkuZ2mUDw4A17VkbNr0+AZw2YGfOxh6umYtxphO/3lM+hvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=ZjyhWYi3; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=E3pz5NktMcCGwJTcSzoyiX83mvd/y+YLGX6taQ43k9c=; b=ZjyhWYi3kKoj0lDPInjmIHNWv7
	p1AGmi/U/v97PQhWcRgzXCPMQh00dWWn/8/kL7Z58Qfo1O8tScKSDWfjUsraLS3DyEWS+wzMRpUva
	P/gtgxpxc4WWEfLVSXgYjagpzFjp83q9HMYkGWmyOmHnmOPr/ZVKnmNwdrRj1ba81yUyDHKg8Ew1f
	iCVTXV4naH5KrdUbVqzKX7ZYbXv5JW5uIDWnKwcmFtjQVCy8+DzZs8zcVeoSv/P/TrgzzfATPv/Jw
	xMUq2+xJILS5YrLd3pnTdQcvDidGP468q42h8lG32MOItfYsevprrtqH2s6FNlDLr90Sji0ujVjCK
	1V4E2kXQ==;
Received: from d104-157-31-28.abhsia.telus.net ([104.157.31.28] helo=[192.168.1.250])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <logang@deltatee.com>)
	id 1t19i8-00AvqA-2C;
	Wed, 16 Oct 2024 13:29:33 -0600
Message-ID: <d115cc88-cc0c-41fc-840e-e11b783919cc@deltatee.com>
Date: Wed, 16 Oct 2024 13:29:30 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20241012024524.1377836-1-vivek.kasireddy@intel.com>
 <20241012024524.1377836-2-vivek.kasireddy@intel.com>
 <eddb423c-945f-40c9-b904-43ea8371f1c4@deltatee.com>
 <IA0PR11MB71855AF581EAA8EE8F43E820F8462@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <IA0PR11MB71855AF581EAA8EE8F43E820F8462@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 104.157.31.28
X-SA-Exim-Rcpt-To: vivek.kasireddy@intel.com, dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, bhelgaas@google.com, linux-pci@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v1 1/5] PCI/P2PDMA: Don't enforce ACS check for functions
 of same device
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2024-10-15 23:29, Kasireddy, Vivek wrote:
> I think it would make sense to limit the passing criteria for device functions'
> compatibility to Intel GPUs for now. These are the devices I am currently
> testing that we know are P2P compatible. Would this be OK?

Yes, this sounds good to me. We can reconsider if we get more rules like
it in the future.

Thanks,

Logan

