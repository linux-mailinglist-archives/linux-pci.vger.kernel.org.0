Return-Path: <linux-pci+bounces-37735-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C92BBC6A8E
	for <lists+linux-pci@lfdr.de>; Wed, 08 Oct 2025 23:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 139C03B0469
	for <lists+linux-pci@lfdr.de>; Wed,  8 Oct 2025 21:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC66296BDF;
	Wed,  8 Oct 2025 21:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b="ocFjgEZN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D260227C84B
	for <linux-pci@vger.kernel.org>; Wed,  8 Oct 2025 21:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.1.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759958103; cv=none; b=WdWLphU/woC6nsJKng7pskInQm45qv6OIku3PCUKBU2315HtpE/wXuXP0sO3oMfRaVAgZUcYr37dIvguIAztiFRD/T2h/p9BOu2aUtiJ4XBFsUtm+4EROm12rlV6OxexVKycWX9bGZ3X+KH6ATX77iYBzlXbaTCA7xrDvVMOQW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759958103; c=relaxed/simple;
	bh=jL2/w68coamp6qFZ5nwkWwN/q6ZBoEs7tOkZqPEqGDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jpcqAHFyXfN58ke4LogCDfeFj2FTpwamvrsRCy8yTH7lYw1Expp3yFlXDGeSf8cXZnZHG6Q1WbAyDe5Y/YzRL1ktZTFjAdEW77pVKTJ6BiiPiZV4G9LstfOGfzpK/5jDu6rFC9zMXJFQ3OmslF8rC5xe0A4rXf1YrKdefkrM57A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com; spf=pass smtp.mailfrom=panix.com; dkim=pass (1024-bit key) header.d=panix.com header.i=@panix.com header.b=ocFjgEZN; arc=none smtp.client-ip=166.84.1.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=panix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=panix.com
Received: from [10.50.4.39] (45-31-46-51.lightspeed.sndgca.sbcglobal.net [45.31.46.51])
	by mailbackend.panix.com (Postfix) with ESMTPSA id 4chm4321m0z42PQ;
	Wed,  8 Oct 2025 17:14:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
	t=1759958099; bh=jL2/w68coamp6qFZ5nwkWwN/q6ZBoEs7tOkZqPEqGDk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ocFjgEZNWbXSteAEwRANebT/LfXdBpSdLnE39WlgprM/xbyuucfNlP5eOsRXz8Ceo
	 NcuMzvWq2CR+w/4hMyYRstNPz9WgfNcdlqUdgkEJu475HjJJCNF9kSlG4I3HMMaeE8
	 f8WEB8ouhtG8JFsqclhcofunaJGSt+acJayUu78U=
Message-ID: <b96b6c1e-a100-4eba-8efd-0ce4e8199356@panix.com>
Date: Wed, 8 Oct 2025 14:14:58 -0700
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
> https://lore.kernel.org/r/tencent_8C54420E1B0FF8D804C1B4651DF970716309@qq.com

This fixes it, thanks!

-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA


