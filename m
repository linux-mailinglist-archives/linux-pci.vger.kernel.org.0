Return-Path: <linux-pci+bounces-35037-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A09AB3A477
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 17:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DABDC1C83B88
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 15:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347DC224B14;
	Thu, 28 Aug 2025 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="I9rzgNVJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974FA212B3D;
	Thu, 28 Aug 2025 15:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756395043; cv=none; b=gr/ZvWTaT7QMF/SXVKFZjbtrpMr6HLrtdqdvcApN8egGfwreI8vIWp6AYkX/8+nalpg1Lh93JwNIZR6ExCI4OpSmlRYWLkTmto6LkMKXSOwmdIXVqsiH2Cl8dsTIZSSdqL020j2QVpXGJYb/Qg9Y2cvF0W17H0vEa6geBN/Hiy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756395043; c=relaxed/simple;
	bh=D+JfpppeHZ1C8yo8ivhBtE7YLsWzyAKpWZYW+10lhR8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=NP9OSA77Vw9BV9Tk8Hq7l1GaNDy3BqjItGoLU09z5Klio4fwdhsQmJ5HrgBeww7GkmYwhd2rmfOqub6iJNoLIogw93cKHI3Uy1VPduT0M54a1vVF6wP+WkokM7+ui5YvVCAM3AvdafUUXW1lCm7lNeVnfbYnks8lNNf3zewvfo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=I9rzgNVJ; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=8wwntsh07I8G4apS4KKKdzc7kvaw5ntZiBPOIZD7YDM=; b=I9rzgNVJLrEUcO+No1a+J5d4KC
	kgEZF9AI+vmzB3708cCepfbdyyzb6L8FgQtCFEQQFKsBcV4AAmmb69NEPB0IlPgfjnkTLL2cIcXCv
	s0JayE282zt876ZqzX7lmHUlUJFHrGRuTgO4r2uuvZPc7x3LD511PvCtX0DeXYKIhUa/dVaSHWTUQ
	7xr23qBBadu9FdlquygYJK923Gemyn3v8IesDqU15K94OelFSfVlYV6JIBqmpJ2iRqmOHyoXcamJj
	rQDWy6X3Par7PBVRNc0GhwMcpwihQj73dFDOQ/nwobfL8P2bJc/LGI+KcWzECkvUNjPZTbnO2fIwK
	O1hRrO1Q==;
Received: from d104-157-31-28.abhsia.telus.net ([104.157.31.28] helo=[192.168.1.250])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <logang@deltatee.com>)
	id 1ureZq-007kQ3-1n;
	Thu, 28 Aug 2025 09:30:13 -0600
Message-ID: <51a1571e-bd20-4d1c-90c5-0b94d53fbd3a@deltatee.com>
Date: Thu, 28 Aug 2025 09:30:09 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Erick Karanja <karanja99erick@gmail.com>, kurt.schwemmer@microsemi.com,
 bhelgaas@google.com
Cc: julia.lawall@inria.fr, kelvin.cao@microchip.com,
 wesley.sheng@microchip.com, stephen.bates@microsemi.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250828093556.810911-1-karanja99erick@gmail.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20250828093556.810911-1-karanja99erick@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 104.157.31.28
X-SA-Exim-Rcpt-To: karanja99erick@gmail.com, kurt.schwemmer@microsemi.com, bhelgaas@google.com, julia.lawall@inria.fr, kelvin.cao@microchip.com, wesley.sheng@microchip.com, stephen.bates@microsemi.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH] PCI: switchtec: Replace manual locks with guard
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2025-08-28 03:35, Erick Karanja wrote:
> Replace lock/unlock pairs with guards to simplify and tidy up the code
> 
> Generated-by: Coccinelle SmPL
> 
> Signed-off-by: Erick Karanja <karanja99erick@gmail.com>

Looks good to me, thanks!

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

