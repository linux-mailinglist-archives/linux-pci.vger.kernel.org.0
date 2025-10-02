Return-Path: <linux-pci+bounces-37480-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15269BB58EF
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 00:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58C0E1924D5D
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 22:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABD71DB122;
	Thu,  2 Oct 2025 22:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="dvq+myBP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD464A55
	for <linux-pci@vger.kernel.org>; Thu,  2 Oct 2025 22:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759445417; cv=none; b=RgGlzW29KGjKQcJkBfiasCyKBvZI2PkUJrIMKKCydKUHmPtVuWIpMDzLYar4UuSBC2FZKJwcD0bN9sKQjqc+NqjK4o9p3bAnyI3dcU0k3hYkLM4a3zeoSvKlsUlHcQ1FURnQvi8nURTiYe1g61IZfAQ1sPhS2bOj4WMAUTP9tCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759445417; c=relaxed/simple;
	bh=scmGbTWG+zwjcO+jXDnBCs0eRN/NEHJQAaC7Xc+VpTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o6mcnl6JgD9J9Vsq5KViUbQE8xq0QhkHVGXnuAnTgGVWqd6tf43d5j95IOT4L6hQOrpvgE/gt/gOMt2667h3BSsKAxbfgJroegWhqh4iBYNpYbYb3eKTBtxBfg/G0KHUw6wdmBFETRsYx2Gp9wbikBzu8wpwQwuFxAjSrQLovoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=dvq+myBP; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [10.50.4.39] (45-31-46-51.lightspeed.sndgca.sbcglobal.net [45.31.46.51])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4cd6Sh5fSFz10cN;
	Thu,  2 Oct 2025 18:50:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1759445413; bh=scmGbTWG+zwjcO+jXDnBCs0eRN/NEHJQAaC7Xc+VpTs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=dvq+myBPiCyL3Lnj7reXcwpCZ0jK/wU9hCPxAu4fhT5IIoXbhbVHZUVgV9zGHtxw/
	 bP+H307NCMYj8oSMNYLcFcDR+Vy5AEFVCSrnA3zHiVCJWb+qFi3ZpGIfaddXe3lIbV
	 KUcAQiabZXHIyHNCIjNEY/2AExRaHT5sgm3YIWlM=
Message-ID: <e5c6756b-898e-475a-a390-391edfdc0943@panix.com>
Date: Thu, 2 Oct 2025 15:50:11 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: commit 54f45a30c0 ("PCI/MSI: Add startup/shutdown for per device
 domains") causing boot hangs on my laptop
To: Inochi Amaoto <inochiama@gmail.com>, Kenneth C <kenny@panix.com>
Cc: tglx@linutronix.de, bhelgaas@google.com, unicorn_wang@outlook.com,
 linux-pci@vger.kernel.org
References: <af5f1790-c3b3-4f43-97d5-759d43e09c7b@panix.com>
 <c6yky4m3ziocmvgblepbdr33j4irwlzew7z4ch2hnhj44otpwf@n2yo5sselj73>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <c6yky4m3ziocmvgblepbdr33j4irwlzew7z4ch2hnhj44otpwf@n2yo5sselj73>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>> I bisected it to the above named commit (but had to back out ba9d484ed3
>> (""PCI/MSI: Remove the conditional parent [un]mask logic") and then
>> 727e914bbfbbd ("PCI/MSI: Check MSI_FLAG_PCI_MSI_MASK_PARENT in
>> cond_[startup|shutdown]_parent()") first for a clean revert.)

On 10/2/25 15:28, Inochi Amaoto wrote:
> I think this has been fixed and the patch is merged in the latest
> mainline. Can you try
> https://lore.kernel.org/all/20250827230943.17829-1-inochiama@gmail.com

But isn't this 727e914bbfbbda9e, which exists already in Linus' master RN?

Thanks,

-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


