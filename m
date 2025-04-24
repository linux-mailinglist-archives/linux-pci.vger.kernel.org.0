Return-Path: <linux-pci+bounces-26692-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8013BA9B146
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 16:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ED4B3AD67A
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 14:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86341487FE;
	Thu, 24 Apr 2025 14:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="iwGvoaMo"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338D91714B2;
	Thu, 24 Apr 2025 14:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745505611; cv=none; b=WJT0H5i941fBv2rqpDwqxO4XWczPmwYx4wW497/hU0iKEMLQtW/xYzXjXnZ06TJ1Pfvc3dfW4n5GONmSPnU04vRUxAA+4SAV865CxZVxRaIIR2N+DOjfikWgAX4sNz+ZYXxibveRdVd0YiaWdLb8ljQP+59S6gy0hCnU/b/F21M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745505611; c=relaxed/simple;
	bh=7L0i9/qPkLsYVUJCJPkkIu096qoLA09P+c4VjGsLR5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DaWDH2ah5d7z6+6ryxjO2ryQMjWdfsRtvFke/J25V7p2mEd8Id5vmzxhfN3FNzGNjuCifsF/vyB1aSfrm1qJZECFNa5zzESQ5DZr1iGgfi/mvVXWVH4sjDsHaAq2Qjymnx55FyIjEL4FnCZgYEe4fAyqC95NAdRqAm7+WlThdMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=iwGvoaMo; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=goSCDGtcecvK9GvzZNb+KfUbcLcmc090ZuK2JJk3f7k=;
	b=iwGvoaMocXQ5QBSZkqbD2WJWyC0DB4I313iE/43bylZ13wYdypvCyAO2CnwvmV
	ayUiJyDJZn82DK4wVvrhjUxeYdfG4wKjLDRaM+kWlUSWNAjOWxfaACdOPVn0Tn+Z
	vqV3jSRY01nPHM3LcEkOLiyfU4bIEimnrcj5nb9Y0aOug=
Received: from [192.168.71.89] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wAHhisUTQpoY1+4CA--.6024S2;
	Thu, 24 Apr 2025 22:39:17 +0800 (CST)
Message-ID: <a9092968-9d19-4d5e-89bb-1063a3d8d93b@163.com>
Date: Thu, 24 Apr 2025 22:39:17 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: dwc: ep: Use FIELD_GET()
To: Niklas Cassel <cassel@kernel.org>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
 manivannan.sadhasivam@linaro.org, kw@linux.com, robh@kernel.org,
 thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250421114548.171803-1-18255117159@163.com>
 <aApANPRB7f1mOWDa@ryzen>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <aApANPRB7f1mOWDa@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wAHhisUTQpoY1+4CA--.6024S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU5LvKUUUUU
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgA5o2gKS7QuLwAAs8



On 2025/4/24 21:44, Niklas Cassel wrote:
> On Mon, Apr 21, 2025 at 07:45:48PM +0800, Hans Zhang wrote:
>> Use FIELD_GET() and FIELD_PREP() to remove dependences on the field
>> position, i.e., the shift value. No functional change intended.
> 
> Nit: It is a little bit misleading to write "Use ... FIELD_PREP()"
> since this patch actually never uses FIELD_PREP().
> 
> Reviewed-by: Niklas Cassel <cassel@kernel.org>

Hi Niklas,

Thank you very much for your review. I think Mani can help me modify it 
when merging to the temporary branch.

Best regards,
Hans


