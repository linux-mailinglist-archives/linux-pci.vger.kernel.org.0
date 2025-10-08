Return-Path: <linux-pci+bounces-37733-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6237BC6974
	for <lists+linux-pci@lfdr.de>; Wed, 08 Oct 2025 22:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB00919E5201
	for <lists+linux-pci@lfdr.de>; Wed,  8 Oct 2025 20:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623A22BFC60;
	Wed,  8 Oct 2025 20:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="Qx3TKBmx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FE82BF017
	for <linux-pci@vger.kernel.org>; Wed,  8 Oct 2025 20:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759955452; cv=none; b=JwzeXoqvkeJ1NcPz6dG6oNDj7Bs5AZ3dODIaMOfSsb8dzbA/cxysZ+tRopUZAqHvnZ4yAQa4kkOwjKPLP4vkZOKeiQCuASBntGBgLTOVJTF5mtNg29CxmJvyEsYaDv2Mcua9nDEfxPkKopUX0GnT7QOiJm1d0AIpydpLL1vbyAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759955452; c=relaxed/simple;
	bh=bXUwXtfMWGkqI6Z6Z+4tBYpeV53Ia2QzeK0+GOrHdd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uBtCrHLygPrHLIB6s24IaKsGW2QlQFK6Cblyl3Rh+HyM40z3CVFNJ97ssynsG0m2Eg6Ti5sOhzoBxKblNmQPmR/T/PmVK8UfBK+EGoNsuKtpBIqRa5naIatt7uINIT+7R8lxUuVJVJTvMqYoHeemfQ1+KRGnYrFDf/qpt88AAdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=Qx3TKBmx; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [10.50.4.39] (45-31-46-51.lightspeed.sndgca.sbcglobal.net [45.31.46.51])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4chl534ybRz3yTR;
	Wed,  8 Oct 2025 16:30:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1759955448; bh=bXUwXtfMWGkqI6Z6Z+4tBYpeV53Ia2QzeK0+GOrHdd4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Qx3TKBmxAsNjaWijxJjx9nj1QiZMY4bLcoI5DoenJC7w8k7jYRgRRWGhFGPyaRocj
	 hDuOC0bO53/8cxWg3KsMtHaC5slMs9NFo53Igr/lX3TjZS1lc6iaUbt/MbviKJq+vH
	 gx4+7W5lwWkOkah8ZxCuk370pRzDTGCCligU86v0=
Message-ID: <54d5e1d1-10ef-4e51-9a46-d6d67db61c43@panix.com>
Date: Wed, 8 Oct 2025 13:30:46 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Commit 4292a1e45fd4 ("PCI: Refactor distributing available memory
 to use loops") gives errors enumerating TBolt devices behind my TB dock
To: Bjorn Helgaas <helgaas@kernel.org>, Kenneth C <kenny@panix.com>
Cc: ilpo.jarvinen@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org
References: <20251008201443.GA638724@bhelgaas>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <20251008201443.GA638724@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/8/25 13:14, Bjorn Helgaas wrote:

> Can you try this patch, which identified the same 4292a1e45fd4 commit?
> 
>    https://lore.kernel.org/r/tencent_8C54420E1B0FF8D804C1B4651DF970716309@qq.com

I'll try it RN. But OK, is it just me, or has Lore changed from straight 
text to "funky" colored HTML? It's nice visually, but now "save-as" 
doesn't work any longer to produce "git apply"-able patches.

> I tentatively put it on pci/for-linus.
I just "git remote"ed your tree, do you have a SHA? I'm not seeing it.

Thanks, Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


