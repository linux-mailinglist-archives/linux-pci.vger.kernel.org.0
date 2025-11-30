Return-Path: <linux-pci+bounces-42322-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C2DC94AEE
	for <lists+linux-pci@lfdr.de>; Sun, 30 Nov 2025 04:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A46D4E1544
	for <lists+linux-pci@lfdr.de>; Sun, 30 Nov 2025 03:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0765A230270;
	Sun, 30 Nov 2025 03:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c/i1DH6v"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02338235BE2;
	Sun, 30 Nov 2025 03:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764471611; cv=none; b=q1y+vl8soQL3i37q3rygwW4xhq0XjOQW5FJBAJc1mVlpQn+3/f/+gKaFnNgHdUNoHrNpuIJOQfJp5uvq+ZZmkAr77JNFBIuTsYg97IeQ93O2wU9BO0VeXohgKOZzXzOzZzNiB6PppimU6XAwncta/aKB7w88edHU1xnh0WYfM9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764471611; c=relaxed/simple;
	bh=BYMqEJqnI/b9Dt/wOVTQtL57BuRA191x6wYEd76LXhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KkLF+c8i8Ga5xYBPAPVRqSXJD1sFe+RbP4pZO382hlPvNLYEM50n9OZjiJzs33IdIm7kIb4F3NMrL9SoZ/mUMAnhsiNVGDwe6jtN191lL5ORJfNIWBQC8cv4mWorT9wqdZS8vwPdaHXLTVpjnUDzu3tysAkbdht06kJq/cc5ncw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c/i1DH6v; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=62SYe2pDIp3VkphXuM3qJYUm0wpI1t1CDBdRSIx1j28=; b=c/i1DH6vqV4gbihCoxxOLsWdPQ
	7Bs79gMjo3taXn5o6lrK/dmSht70O38S2Pog9NIvYDfzPf+2m0Wz165Ekc9lzl7otbtykl4FhMvB2
	ZEUi/YZ60KM4MVgHBh31uBGsJ9N3m764fHrF5ZMKhpm8CagXN9Lrgbtdj0wko/22mACVSwEfDFDA0
	JJ9vLj6wbeMGFRrwre4N3zp796gcUSO5D/YkoFcsStvcUiBjvV/aVj5AK9SmuYsWLUzeLEB+InD8R
	9FaqHaM2UQpEwsi3Bvt93+XDOY2uh8kfUxtvLw1mlqdjCCA2lUvUepGkEhHbEEb2w4j5aNkHqiTcp
	JLdG1Lsg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPXfS-00000001yi3-27YF;
	Sun, 30 Nov 2025 03:00:06 +0000
Message-ID: <63e1daf7-f9a3-463e-8a1b-e9b72581c7af@infradead.org>
Date: Sat, 29 Nov 2025 19:00:04 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Nov 28
 (drivers/pci/controller/dwc/pcie-nxp-s32g.o)
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 linux-pci@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
 NXP S32 Linux Team <s32@nxp.com>, "imx@lists.linux.dev"
 <imx@lists.linux.dev>, linux-arm-kernel@lists.infradead.org
References: <20251128162928.36eec2d6@canb.auug.org.au>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251128162928.36eec2d6@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/27/25 9:29 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20251127:
> 

on i386 (allmodconfig):

WARNING: modpost: vmlinux: section mismatch in reference: s32g_init_pcie_controller+0x2b (section: .text) -> memblock_start_of_DRAM (section: .init.text)


-- 
~Randy


