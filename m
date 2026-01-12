Return-Path: <linux-pci+bounces-44533-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B81D1441E
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 18:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 023B9304D999
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 17:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E279E378D9B;
	Mon, 12 Jan 2026 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="s9Jmgg6A"
X-Original-To: linux-pci@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418E7378D99;
	Mon, 12 Jan 2026 17:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768237289; cv=none; b=tnjA9P1nTeCqDoEP6+gvg1ZdsH201km+/IMfuZzKNBlluN2ILObRjEKKCABrBbDUZsvzcg+OIi6o+PkyKYIEZOBhMDjqNTE3Q8NdIgbby89RdBIpZLNLfFbFYvM7CLv+KB3Y746+zhyudg/J0GdIQs3o9KEJrhKEFVX2DoaUbUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768237289; c=relaxed/simple;
	bh=qtVhgiT8Cjt8NLxXK5d3PfWhXlczeRTeLLoUrZKRoMw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=R2y+8t698ILPwmHhaDAVpGGzJiUpS+MIo0uPNjo+eDh9XLa4f5bEDUgx6y3ASNIUutp00oN6wbuIDlSiTI4evGM+x/iHXzG/L1mx7EcVqJmTaWrYiq76JUFGWPZfy4ek51Mu3EAXc/wGWnOea6eh8jFnGyEcqmpTVP9STTG3DbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=s9Jmgg6A; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.201.246] (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id 150F92126E4C;
	Mon, 12 Jan 2026 09:01:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 150F92126E4C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768237287;
	bh=TypZo+IG73459ie315hT8yP1qGfHBJLyVc6z3Je942o=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=s9Jmgg6Anwzzo3a2OPI5nJeXM1OshEac3uaowsatiMsY/oxwPn+kASsvp53vz+tcG
	 AVANFfWoDLIpm6hzcn+J21B3bh2usND3nl9r5O7fVxqFDm2VtHdBeQiU+4H60Bbjd6
	 LVdEvUd/fD4p2yXNsERm+b/9grS7T2MSfIpWTKxE=
Message-ID: <5aad59db-f2fd-43ac-990d-1bfa7bac7fab@linux.microsoft.com>
Date: Mon, 12 Jan 2026 09:01:17 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
 bhelgaas@google.com, easwar.hariharan@linux.microsoft.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI: hv: Remove unused field pci_bus in struct
 hv_pcibus_device
To: mhklinux@outlook.com
References: <20260111170034.67558-1-mhklinux@outlook.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20260111170034.67558-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/11/2026 9:00 AM, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Field pci_bus in struct hv_pcibus_device is unused since
> commit 418cb6c8e051 ("PCI: hv: Generify PCI probing"). Remove it.
> 
> No functional change.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>

