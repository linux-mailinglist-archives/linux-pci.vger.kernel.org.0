Return-Path: <linux-pci+bounces-20155-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 194B9A16E72
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 15:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF93B1884880
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 14:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3E23596C;
	Mon, 20 Jan 2025 14:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="vyrnoiru"
X-Original-To: linux-pci@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2329450;
	Mon, 20 Jan 2025 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737383435; cv=none; b=LvRwTr7C2kM8rRdGHVhcKjbDr8pPoCy87wuuxCclVT4s5bBEgcoGfhIwxyam5huHa9vu2Ccp4/CwXfy+hUZxe/qzkxOG14507jr8hxU+H7uk42q9MUvA65wRbBChwbCQurHG11+f+gkGLrzqqbJo351HtqAdDeKNUQWVR9Bz5pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737383435; c=relaxed/simple;
	bh=qmTDwhVL1W44aWSyU9yNOlbmzOZv5rCUFdrYQjcJjCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NRtPbPMm0wFe0ry98/aoY6tYJSkvExcIVoWYGVd2Fo9b9kRt5+K3RrdVqmQ4jCHVwQS+GHXPMbuRc75wNMCCC+QsoKir3LiwU2bqUpU1a7G1bc/42EslEfvK3QL/suaPFAsMnQaFelcIHAx+jFxpRcpxKF6Jh81p7kwWsL7sMcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=vyrnoiru; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1737383119; bh=67XJay9E8w2xGB4eA46TW3l1Brrz6HL7BURXEAD1+wI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=vyrnoiruEc80HsRvnxggExXu+fgvMma//6/D1wYTiJetyydEmCrONH3DtOSiwycUl
	 9IoYOtQCvCLRhIok3YFye+yS6len1ol6W7SN8JmNuTgdKQ92gEJRcgmoWdcYmyPriO
	 H5QdMVeJKbBqFMKNQMIoYa+wpsjQ0pM+8/AmsHOo=
Received: from [IPV6:2409:8a00:78e3:4720:c022:5e89:361b:6a74] ([2409:8a00:78e3:4720:c022:5e89:361b:6a74])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id 4C21B483; Mon, 20 Jan 2025 22:19:02 +0800
X-QQ-mid: xmsmtpt1737382742t1jiue7qo
Message-ID: <tencent_DBC0851ABE9B45D70B4BA098F876F5F10609@qq.com>
X-QQ-XMAILINFO: MsIRozTmGo8X7Ok6d5GHidBYwKVjYI6X7mNTA4wvoMC8hr45h8gborcXh15dgs
	 ULqTKWuXPcAQkyCReWTfNtJJnEojIET+f7bUyhs1GmVjZ5q2lod4Lxftqr240sfvLTQjfooT4pMc
	 QBMauS/qcjKrXffHofv2SNOBYVF3jejOefRb2gGtXXq8KBHsTbn6/30IzUESpn4wcBX9rVatOSxh
	 l7NRjrDcbJ/7MR3z0oTiI2GkZGNTWEPrn2yMyCCoj2dGDu0El9O3JpElW3u1jbXZBDEiUUW7LSdT
	 B2mbETQKMVHj/QPFlZGqQ8URCa+YiBqftFFJipifRWFhe742Od3ybgGOnYQC61EJUH3q+AazoEJ5
	 RiErXiiJOc9bGem30ROZQxvJ6dTQfQTRX32RPseWmUuhZR8iQrK5+hsJSv8FBfBdMkPJfTyAHlQC
	 5CeVW5G+vDKqupfQVSZZKd0Dc7rUtChmVSI199qY8PNmX+eEYy7XdRAgfdPPzTBE9gYx/9zFaYyN
	 TQhfvn80FeEgoVuHlUZ/rqw7Gc6sLLzF6ELzYYTKJhv36j2J4Wm7N90DLEPYbr+LXKuWrGWEb0+H
	 Y6PAgbsdF+DLe6OZqse6iLT8LNEuWSzYcLy4gsSdoH8gXLv0lHZHT/CxUTvYotLHXsCDmSrmz57X
	 +MhwDk6gkSxooiZi39nY1rzfw271cz02W2dsPdk3a+9z9oVHI+KKY5I2iv2brsTlaYDdvZrq5czU
	 bxbYIUd7DL5qi5Kd+KpVjHHGu5+fu8S6vU7ABKCUUV2Gnm7QjKrVa1QC3Y0MRm/Y8aAplilQLKFZ
	 2MILfk/RPnj611fv7eMm8zH7MKSIWPhMzpOBSbVDN1vPBrJsw7ccYYp4g5+AaB6WIf7+ILEMJXNX
	 quR/dQRqF6ZnuvoTU0i2eSomPRJOLOLcpniZ9Nt517n3SbT+RSrIR34O6MSB2EU3OAuUlomtZFup
	 q13kUyxDe52E0Ikhr98vO10xS2ql8Ah/KBJ2a4UfY=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-OQ-MSGID: <aa2705e8-fdeb-477c-8568-4e69575c7e79@qq.com>
Date: Mon, 20 Jan 2025 22:19:01 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] PCI: reread the Link Control 2 Register before
 using
To: "Maciej W. Rozycki" <macro@orcam.me.uk>, Jiwei Sun <sjiwei@163.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, helgaas@kernel.org,
 Lukas Wunner <lukas@wunner.de>, ahuang12@lenovo.com, sunjw10@lenovo.com,
 sunjw10@outlook.com
References: <20250115134154.9220-1-sjiwei@163.com>
 <20250115134154.9220-3-sjiwei@163.com>
 <4df1849e-c56e-b889-8807-437aab637112@linux.intel.com>
 <417720e7-c793-4c36-a542-a7e937e5a3cf@163.com>
 <alpine.DEB.2.21.2501180101360.27432@angie.orcam.me.uk>
Content-Language: en-US
From: Jiwei <jiwei.sun.bj@qq.com>
In-Reply-To: <alpine.DEB.2.21.2501180101360.27432@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/18/25 09:03, Maciej W. Rozycki wrote:
> On Fri, 17 Jan 2025, Jiwei Sun wrote:
> 
>> However, within this section of code, lnkctl2 is not modified (after 
>> reading from register on line 111) at all and remains 0x5. This results 
>> in the condition on line 130 evaluating to 0 (false), which in turn 
>> prevents the code from line 132 onward from being executed. The removing
>> 2.5GT/s downstream link speed restriction work can not be done.
> 
>  It seems like a regression from my original code indeed.

Sorry, I am confused by this sentence.

IIUC, there is no regression regarding the lifting 2.5GT/s restriction in
the commit a89c82249c37 ("PCI: Work around PCIe link training failures").
However, since commit de9a6c8d5dbf ("PCI/bwctrl: Add 
pcie_set_target_speed() to set PCIe Link Speed"), the code to lift the 
restriction is no longer executed. Therefore, commit de9a6c8d5dbf 
("PCI/bwctrl: Add pcie_set_target_speed() to set PCIe Link Speed") can be
considered a regression of commit a a89c82249c37 ("PCI: Work around PCIe
link training failures").

So, this fix patch(PCI: reread the Link Control 2 Register before using) 
is required, right?

Thanks,
Regards,
Jiwei

> 
>   Maciej


