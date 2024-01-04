Return-Path: <linux-pci+bounces-1691-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D009824AAE
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 23:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9C7D2861D3
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 22:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC242C848;
	Thu,  4 Jan 2024 22:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="tRavlGDQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797F72C851;
	Thu,  4 Jan 2024 22:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=AAtCmH9DA6lM9l6DifQrYEv+bX1UwKxr56zpWzhv1mc=; b=tRavlGDQW3rrwtr170Y697ZAUo
	TQQDbqphJG0rNHMFZXsdMzeQyaI1ksRfbV8rRh6tFXnUMD3yRn4B1Li8reCcRL9RcS79Bt5aHYLq3
	Ukg9sbe/qbBTwpTftDFjvy92YN+ty3TNAArYzmw+q7kdpjBh2yDqQJLcCvGiSnr798KmeUK59ue2J
	09qvlSh/1p3HsQlUy7sOjPMTI8pwwvYTb3zFfn/udvmdE5ZmuvPbnZ4ruvmbkjqtjZ1N40mN+6PvO
	eAf2qZZ1YO1c/n+UIJL3bfEWtmz39aaJxGvh4rUg4n4im6aJLSxOYdvmqD+tyeoEgsdHFqCS+fKJP
	Tx9XS27w==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <logang@deltatee.com>)
	id 1rLVZs-00CkPZ-5i; Thu, 04 Jan 2024 14:48:36 -0700
Message-ID: <e194200b-18e9-406d-9faf-03b54c1e606c@deltatee.com>
Date: Thu, 4 Jan 2024 14:48:33 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Bjorn Helgaas <bhelgaas@google.com>, Eric Dumazet <edumazet@google.com>
Cc: alexis.lothore@bootlin.com, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-pci@vger.kernel.org
References: <02d9ec4a10235def0e764ff1f5be881ba12e16e8.1704397858.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <02d9ec4a10235def0e764ff1f5be881ba12e16e8.1704397858.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: christophe.jaillet@wanadoo.fr, bhelgaas@google.com, edumazet@google.com, alexis.lothore@bootlin.com, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-pci@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH] PCI/P2PDMA: Fix a sleeping issue in a RCU read section
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2024-01-04 12:52, Christophe JAILLET wrote:
> It is not allowed to sleep within a RCU read section, so use GFP_ATOMIC
> instead of GFP_KERNEL here.
> 
> Fixes: ae21f835a5bd ("PCI/P2PDMA: Finish RCU conversion of pdev->p2pdma")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

This makes sense to me. Though, the use of RCU could probably use a
review. Seeing p2pdma is only released through a devm action on the
pdev, I would think it shouldn't be needed if we hold a reference to the
pdev.

Other than that:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks!

Logan

