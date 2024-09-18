Return-Path: <linux-pci+bounces-13278-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A5597B945
	for <lists+linux-pci@lfdr.de>; Wed, 18 Sep 2024 10:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DBF3281EA7
	for <lists+linux-pci@lfdr.de>; Wed, 18 Sep 2024 08:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFE416EBE6;
	Wed, 18 Sep 2024 08:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="DDbz/JeA"
X-Original-To: linux-pci@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08907166F25;
	Wed, 18 Sep 2024 08:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726647707; cv=none; b=F0xjDaElZ2P5FIz5P7IApsT86MxJp3GSqfCiS7jQ++Pgey4BPPZn7YHbFpgLe4ZG/rfJEtjBsTV49Ms81T7UaUAwvkze+8Mf+5wBAMnMapbW+yk76QEKFHZbMRPAU2aHqBG89FOF5EFUQc3Dyv82PqB6A5oTjIsWUevBniXDaik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726647707; c=relaxed/simple;
	bh=kDJM19bviA/FrFZ2UuSD18/HQM8mHWwOtadJixPJYPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KpJugTpkHvCi1G6km/imQToeyaGfTQ2oEQNnSE52Sqhiyskw7+UwIEwgxt9LKN0LgEny8pU9VY2KBmFGEP5WuS9/AW1QbzfrRI24qFu7BivGpsQZheUozKjILmn3IZCTCSSFhJGvivjbmPJZCa3gl+HqBONdc2pq0FCcuL2UgI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=DDbz/JeA; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=v9Hw/owoAXL6eCc51YZo8Aacprq6fodHMr7qvhkKcVw=; b=DDbz/JeAYqAAib/syOV1e3Goyr
	BoxMx/c96JUViAvFOxGVf9Nxlwh3DZQDNh7KGVT5iEXvbNpBaR166+ZY/NC0XFoUzvmZiOAX/ci8F
	iHza9slGdHsfPZkOOHfSdox77Gomb9xF8ANRRls+2A2uevdH5FgZkvZcZJrGttFKnzgT9ORY9D0hA
	GJiKcEFK1NIFZl0q2RX43HFQfZgcXnlmyDU+eKROg3u+pRRh50bkrTEeyjWDGEB9/xEp5ulNQ6R0N
	xncbAcGe8lr2S7Bk1OTutHv2Z1XR50XfeuS0VTO2O2ajNxAFQS9fMOScCFFA/5MBSv/D/mQY/n6O2
	wvBAxf/A==;
Received: from [83.68.141.146] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sqpwE-0003RF-8A; Wed, 18 Sep 2024 10:21:26 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
 robh@kernel.org, bhelgaas@google.com, cassel@kernel.org, ukleinek@debian.org,
 dlemoal@kernel.org, yoshihiro.shimoda.uh@renesas.com,
 Chen Ni <nichen@iscas.ac.cn>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Chen Ni <nichen@iscas.ac.cn>
Subject: Re: [PATCH] PCI: dw-rockchip: Remove redundant dev_err()
Date: Wed, 18 Sep 2024 10:21:25 +0200
Message-ID: <1945968.taCxCBeP46@phil>
In-Reply-To: <20240918074401.2221146-1-nichen@iscas.ac.cn>
References: <20240918074401.2221146-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Mittwoch, 18. September 2024, 09:44:01 CEST schrieb Chen Ni:
> There is no need to call the dev_err() function directly to print a
> custom message when handling an error from platform_get_irq_byname()
> function as it is going to display an appropriate error message in case
> of a failure.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



