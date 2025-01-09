Return-Path: <linux-pci+bounces-19582-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AEEA06A11
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 01:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 332DE1889383
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 00:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE94567D;
	Thu,  9 Jan 2025 00:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="UGkgQy70"
X-Original-To: linux-pci@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBF8747F;
	Thu,  9 Jan 2025 00:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736384220; cv=none; b=dgl+zVnRtB6Dc/AjKmUAolc+nv9xoPEqM2dPmrwND+UN/aNOVY2m9rHp5/ViuYIRBBhfotihtYF7dtPHOHE6Xtm8900JFJkU/6Up28yUyZ++0vpZK5L2yq9k7r/8ngPDe83ILnG4nljNWbD9Hw2qm7URix8aTt4EuG5NuAlxORY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736384220; c=relaxed/simple;
	bh=pDxsGYA94ZJvccx7h7YtavqdIP+Ethfqkoymg/eO8R8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vx9ZLskHjb85HxNK9k2Uo42Zvb4Na6keSSCw1U4qwksHYSCNpfpXHT8PodHIqp6apjleWXBEWLsUGw5cySHwKwT6hy1+dolS/aTw7Q9PhQzf7ecn0/gnLlmXKvND6yzZRoZ21Mf4d1+mPSwQCHy9o9So6LwAyYMvS6PKI6c9mJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=UGkgQy70; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1736383909; bh=k8kzBlyyjheX3u/O1bNIju0yUnhs5g97abatif2hwQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UGkgQy70qy58KVWkdeMBdwogYZsWyz52b1G+v4BDNriLMZwEi1Rx7gxaMIiXyW/+S
	 4Fi1daeAcGwFU8LvDuT6NPseXungaFcIVJPxng+lbLAcqY2BVeFoWtfNFKTbzFprnV
	 U76lj6OM/u8Owcseyy5QX7xD/uRjbfCDmcXOP/Mo=
Received: from Ubuntu.. ([240e:305:25d4:e300:e8b8:34da:c848:9463])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id B670E402; Thu, 09 Jan 2025 08:45:39 +0800
X-QQ-mid: xmsmtpt1736383539tybdxs9hj
Message-ID: <tencent_E41517B9A991E979CCA31DA8087A1F62E10A@qq.com>
X-QQ-XMAILINFO: M9KKp5YUu5UTw5uw0evkmMDnZRyKWCliF2Gux9OwETM/ry04UEmjnfWbJ6LqxE
	 VrpMXNcNYVdwZ9eiHQskZ4fbCuyaCO/AGSdeNgGNTryCooFSj7GWglT3LPo/+N8qPZRfUaH/xqp7
	 kcxjORZ7tn6BcYHEOjIwhAdSn3NgDlPMiEACddxXAmVqIppsOWdcCb8qqgcRWkvMyPiutmIcGOkr
	 QfKycVZlPziVm921Od+PxK7pdOOML6j5fAaeBnkTpDEXHmjwX95G0awuYnxqkP8vUa5GMuc+9LMl
	 u5pUupQbkEoIe57NFaQyC8JiGN/XvkyYf2KNL1VqxR2pAzM42p3R3ddyyAjsWd8+wqM0dS4Eu8HE
	 hnqQJ1wTfstItuV8Lwy19zhQfAYESNQuf6bj0hV9eeCGHiZx5wpfdzx8g6yfq2GQV7dtekNro5xs
	 jiQMpSh12xp17iETlp9p4C02xgJv1035c1FIM3zIL8zyKPkU2uuBZn78nooFolvxUzpZFJh+rwFP
	 vumGQsnJF8Icd8BsRXaI8ExAzIsLjzPdL0xoIfFDev1ULBamUkRBbd6X1HKtsOZxVdZWl1GiczOw
	 Iaz1MiAjQVZZh70qglocnRQZS6L29mhTBJw8JsjpDoeHmgwZniP1dbMaiq4PT2uILA8J+PIwqNdf
	 Y2lkh1ZlsGAx67oo0MFVvLjzIxmi6tpDeCz1HPR/2jp2gQxMQLXzqJbeL/lRAU2Q2t6Xy66TgZmR
	 Qok9QM8X8WD7/YWVW8+60KflsJKzvJzz5/BWiQQT7UB2zZo9d83c0V2ZcJXkaFhR9UnLk2G22xhd
	 11kLavWYty7ntrRVj8mmmxiFTABK4rfosDmcD6CajiIdoSV6ztg38U+tVA1TWiiTkIuBz3Mq1Y3M
	 MzkqyfshSqPIx9GRLQfLYQ3E/+2dgeFI8Kqecsxa2tfBqc1LibJ/CFolAkXewxAEOPjh06PdwMpX
	 LZiNoSKCS7U4i4qPmvyEiByxzfyg+0RR9tNH211nyLT1so+jbvBazqZu6rTqKhn/U9Ve9quIj051
	 3B4T1L+UHqmcvzbgcYId3XF/0flbaV1URx40YT0XUDkSCAjd/yemjvqdteZ3VxFtXTUY7dqw==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: kingdix10@qq.com
To: biju.das.jz@bp.renesas.com
Cc: bhelgaas@google.com,
	geert@linux-m68k.org,
	helgaas@kernel.org,
	kingdix10@qq.com,
	kw@linux.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	marek.vasut+renesas@gmail.com,
	prabhakar.csengg@gmail.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	robh@kernel.org,
	yoshihiro.shimoda.uh@renesas.com
Subject: Re: Re: [PATCH v4] PCI: rcar-ep: Fix the issue of the name parameter when calling devm_request_mem_region
Date: Thu,  9 Jan 2025 08:45:37 +0800
X-OQ-MSGID: <20250109004538.1918033-1-kingdix10@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <TY3PR01MB11346F0645DD928C6849D9EAF86122@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <TY3PR01MB11346F0645DD928C6849D9EAF86122@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 2025-01-08 at 11:13 +0000, Biju Das wrote:
> Hi Geert,
> 
> > -----Original Message-----
> > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > Sent: 08 January 2025 11:09
> > Subject: Re: Re: [PATCH v4] PCI: rcar-ep: Fix the issue of the name
> > parameter when calling
> > devm_request_mem_region
> > 
> > Hi Biju,
> > 
> > On Wed, Jan 8, 2025 at 11:57 AM Biju Das
> > <biju.das.jz@bp.renesas.com> wrote:
> > > > From: Lad, Prabhakar <prabhakar.csengg@gmail.com> On Wed, Jan
> > > > 8,
> > > > 2025 at 10:45 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > > > > From: kingdix10@qq.com <kingdix10@qq.com>
> > > > > > Sent: 08 January 2025 04:59
> > > > > > Subject: Re: Re: [PATCH v4] PCI: rcar-ep: Fix the issue of
> > > > > > the
> > > > > > name parameter when calling devm_request_mem_region
> > > > > > 
> > > > > > On Tue, 2025-01-07 at 16:56 -0600, Bjorn Helgaas wrote:
> > > > > > > On Tue, Jan 07, 2025 at 09:51:23PM +0800,
> > > > > > > kingdix10@qq.com wrote:
> > > > > > > > From: King Dix <kingdix10@qq.com>
> > > > > > > > 
> > > > > > > > When using devm_request_mem_region to request a
> > > > > > > > resource, if
> > > > > > > > the passed variable is a stack string variable, it will
> > > > > > > > lead
> > > > > > > > to an oops issue when executing the command cat
> > > > > > > > /proc/iomem.
> > > > > > > > 
> > > > > > > > Fix this by replacing outbound_name with the name of
> > > > > > > > the
> > > > > > > > previously requested resource.
> > > > > > > 
> > > > > > > Thanks a lot for doing this work!
> > > > > > > 
> > > > > > > Add "()" after function names in subject and commit log.
> > > > > > > 
> > > > > > 
> > > > > > Thanks for your review. I will fix the issue right now.
> > > > > > 
> > > > > > > Please include a couple lines of the oops message to help
> > > > > > > people connect the problem with the fix.
> > > > > 
> > > > > Maybe Prabhakar should be able to provide Oops log, as it is
> > > > > tested on real platform??
> > > > > 
> > > > It doesn't Oops out, it just prints a null string. Below are
> > > > the logs from RZ/G2M:
> > > > 
> > > > $  cat /proc/iomem
> > > > 30000000-37ffffff :
> > > > 38000000-3fffffff :
> > 
> > Prabhakar's original email showed garbage here.
> > Looks like your mailer removed it...
> 
> Oops. My mailer removed junk chars.
> 
> > 
> > > Before patch:
> > > 
> > > fe000000-fe07ffff : fe000000.pcie-ep apb-base fe100000-fe1fffff :
> > > fe200000-fe3fffff :
> > 
> > Same here.
> > 
> > > After applying the patch:
> > > fe000000-fe07ffff : fe000000.pcie-ep apb-base fe100000-fe1fffff :
> > > memory0 fe200000-fe3fffff : memory1
> > > 
> > > kingdix10@qq.com, maybe you need to update commit description
> > > referring oops.
> > 
> > Depending on the data found in memory at the time of printing, the
> > output will be different.  I guess
> > it might still crash in the (very
> > unlikely) case that no NUL-terminator is found, and the string
> > iterator will access unmapped memory
> > above the stack.
> 
> I agree.
> 
> Cheers,
> Biju

Thank you all very much for the information and suggestions. I'll handle it right away.


