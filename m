Return-Path: <linux-pci+bounces-34393-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B508B2E211
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 18:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3214C3A588D
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 16:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB2A2E0938;
	Wed, 20 Aug 2025 16:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="SyOdm294"
X-Original-To: linux-pci@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4CC28D83D;
	Wed, 20 Aug 2025 16:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755706180; cv=none; b=h0sd+xBFxgLsh9HUd3QwCaTGoDJ7He6A5sjAQR8x6BpA26zRCGaqwh8Ck8KkL87fp8wcemunYvSmWjmL5nZknwbNATji8Or97DH9G4zh30P7WUCFX/zwD6hbi8a+qWxYn+YYURLbY0zaCOVBdz4mmnqKYg2KVSOTM3cLeEx1nq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755706180; c=relaxed/simple;
	bh=ouqmhsE9bC406TCIYBE/h1ew2IiR6n0ZI9bCj+xK8Z8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=PorBIUSXCBKXdGALTkNuOlsB3lEs4mh3wnea3L0PseuDOo6GZ39bbpQi0OA3ugEdCITdliTIz2pLEqpB+aRqoDD/MPOkYhrNr2Dvvj7tkl+Y74XxCwVCJwXxFCH5USxjSt2K+2x/g6hOLDll7FJlFYU1SZ93bMSxi4vE/s0/N4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=SyOdm294; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=4t7CV04NIwriNXLsYNy7+twj6GP21ECFduAyURtliLg=; b=SyOdm294VkdNWthcCiERrfTGsU
	orZElZjcIpCfcguzYbiXqWOyDTbovGGzaeA93sIV4juPnBpXeOqL2/ffA/jWBbQWbmntl6d3r2X3t
	NDr8iUx7TQLSqEVoHFfQhzm4F4PI6l9VFRnWU+KUK2IkVSjCO+mzfLQU5/vDjHEuin2aDys2gJjRy
	C4N/c1Tn71j6XyRwCmcM6IJbGAdACPLEJEhPj/wBAOjLXudSrviaVZgvZY3W3OPeZo4PZbvgS+dox
	Rj/yTClGFdhtQ+agAIOnR6rcG3ZJIovO4lTEO3lBOXgJOsiXAcsMsKGXqqyFYgnGMGra6qn8GpO3E
	8CeQmjYg==;
Received: from d172-219-145-75.abhsia.telus.net ([172.219.145.75] helo=[192.168.11.155])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <logang@deltatee.com>)
	id 1uolNU-001ZHp-2v;
	Wed, 20 Aug 2025 10:09:31 -0600
Message-ID: <d413619a-8218-4039-8efe-bf9274499de7@deltatee.com>
Date: Wed, 20 Aug 2025 10:09:30 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sungho Kim <sungho.kim@furiosa.ai>, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250820105714.2939896-1-sungho.kim@furiosa.ai>
Content-Language: en-US
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20250820105714.2939896-1-sungho.kim@furiosa.ai>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.219.145.75
X-SA-Exim-Rcpt-To: sungho.kim@furiosa.ai, bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH] PCI: p2pdma: Fix incorrect pointer usage in devm_kfree()
 call
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2025-08-20 04:57, Sungho Kim wrote:
> The error handling path in the P2P DMA resource setup function contains
> a bug in its `pgmap_free` label.
> 
> Memory is allocated for the `p2p_pgmap` struct, and the pointer is stored
> in the `p2p_pgmap` variable. However, the error path attempts to call
> devm_kfree() using the `pgmap` variable, which is a pointer to a member
> field within the `p2p_pgmap` struct, not the base pointer of the allocation.
> 
> This patch corrects the bug by passing the correct base pointer,
> `p2p_pgmap`, to the devm_kfree() function.
> 
> Signed-off-by: Sungho Kim <sungho.kim@furiosa.ai>

Good catch, thank you.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

