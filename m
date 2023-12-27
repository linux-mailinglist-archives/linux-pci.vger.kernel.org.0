Return-Path: <linux-pci+bounces-1471-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBC581F230
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 22:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 518281F22F26
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 21:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7541747F54;
	Wed, 27 Dec 2023 21:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LLxrhLs2"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A885945945;
	Wed, 27 Dec 2023 21:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=HCosurRW6yUv7qxc0Aw6J2XZAhZw5XHFPIkEQJBxiBA=; b=LLxrhLs2Od+xYkbwxREDMUjrEl
	lJafovGRc3uINC/tv8CpNM01fWSnC8Jko3VfrgBHinBVFihxHhmj3nMPpP4BO5fpIRhnarLiItNHP
	/IT+eOreTmub39N1/oc2Ec6vN0blQRpL/2ROXX91e3N7ef77Wi3U1AU7QzGiPHAKzwvTQ4x7+euh6
	Wf21bkT9SzouS0jT2Pgj309S4ZtaXTraAOlviTL4sCGL69mValcSJglXeXQNWIghGm8/uDzdZgo/H
	yS97LOo4Jn+9sCRGFsXjsPYXvkvB8HYoEbyepQccMkxnXXJx9I5liBvQFywKE4F1rypY/bq9ecpTO
	xN6/LZFw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rIbKt-00FWn3-27;
	Wed, 27 Dec 2023 21:21:07 +0000
Message-ID: <dc2d7189-70f2-49e2-ba78-ef2d15211e9b@infradead.org>
Date: Wed, 27 Dec 2023 13:21:05 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] resource: Use typedef for alignf callback
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring
 <robh@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Igor Mammedov <imammedo@redhat.com>, Lukas Wunner <lukas@wunner.de>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20231222122901.49538-1-ilpo.jarvinen@linux.intel.com>
 <20231222122901.49538-5-ilpo.jarvinen@linux.intel.com>
 <ZYWPaGc4rjymcm75@smile.fi.intel.com>
 <8161e59d-2122-562c-dcc7-f772ddbcbdf@linux.intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <8161e59d-2122-562c-dcc7-f772ddbcbdf@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/27/23 07:54, Ilpo Järvinen wrote:
> On Fri, 22 Dec 2023, Andy Shevchenko wrote:
> 
>>> +/**
>>> + * resource_alignf - Resource alignment callback
>>> + * @data:	Private data used by the callback
>>> + * @res:	Resource candidate range (an empty resource slot)
>>> + * @size:	The minimum size of the empty slot
>>> + * @align:	Alignment from the constraints
>>> + *
>>> + * Callback allows calculating resource placement and alignment beyond min,
>>> + * max, and align fields in the struct resource_constraint.
>>> + *
>>> + * Return: Start address for the resource.
>>> + */
>>> +typedef resource_size_t (*resource_alignf)(void *data,
>>> +					   const struct resource *res,
>>> +					   resource_size_t size,
>>> +					   resource_size_t align);
>>
>> Never saw typedef kernel-doc before, so hopefully this will be rendered
>> just fine.
> 
> This was a good point. It seems that one has to prefix the name with 
> typedef like this:

That's correct.
> 
> /**
>  * typedef resource_alignf - Resource alignment callback
> 
> ...otherwise scripts/kernel-doc attempts to parse it as a function 
> kerneldoc.

ack.

Thanks.

-- 
#Randy

