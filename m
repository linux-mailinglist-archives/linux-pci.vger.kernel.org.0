Return-Path: <linux-pci+bounces-20517-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA90A21859
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 08:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDBA53A3EC9
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 07:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358681946A2;
	Wed, 29 Jan 2025 07:55:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874F8193084;
	Wed, 29 Jan 2025 07:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738137326; cv=none; b=cPZv9ltHH5aWJhQXaTYRDB9Dk0YzdgafEEJz9q9J2sl11wm+MThMIwUq83fO4dQGcYspaqDMddCObuWKP6G+cK9NqBImWOn1GAms2kjwFp2rhrgVA4/xcvmJsV5t+gh06Q0pt9FXMWkvGXuCoqyO4DqROLDBI2V6knea308dKvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738137326; c=relaxed/simple;
	bh=XD8l01ExZgbhVpjeOW9xaqcJGtddBGV3FnIhVYcKqK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D73+fZlVMd6B4OdMHrVBUia6OnpV2QED+bWqen36TemOtpqVp5fF0jTCjLYHyaCuBkYMdY6MkJIP6Zvwtq14fckYbFkg9tA6M1T+e8tlPyoeoR3GUVMBT/U2FEklpTr12GbdCLx63WWHnlCnENNh8n2fAQVL7GEsgHMujk8JUZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 29 Jan 2025 16:55:22 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
	by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id A32732019755;
	Wed, 29 Jan 2025 16:55:22 +0900 (JST)
Received: from iyokan2.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Wed, 29 Jan 2025 16:55:22 +0900
Received: from [10.212.246.222] (unknown [10.212.246.222])
	by iyokan2.css.socionext.com (Postfix) with ESMTP id E6BA6AB186;
	Wed, 29 Jan 2025 16:55:21 +0900 (JST)
Message-ID: <710d45e2-c20d-4844-9352-94812b5c6ca2@socionext.com>
Date: Wed, 29 Jan 2025 16:55:21 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] misc: pci_endpoint_test: Fix irq_type to convey
 the correct type
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250122022446.2898248-1-hayashi.kunihiko@socionext.com>
 <20250122022446.2898248-4-hayashi.kunihiko@socionext.com>
 <20250128143231.ondpjpugft37qwo5@thinkpad>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <20250128143231.ondpjpugft37qwo5@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Manivannan,

On 2025/01/28 23:32, Manivannan Sadhasivam wrote:
> On Wed, Jan 22, 2025 at 11:24:46AM +0900, Kunihiko Hayashi wrote:
>> There are two variables that indicate the interrupt type to be used
>> in the next test execution, "irq_type" as global and test->irq_type.
>>
>> The global is referenced from pci_endpoint_test_get_irq() to preserve
>> the current type for ioctl(PCITEST_GET_IRQTYPE).
>>
>> The type set in this function isn't reflected in the global "irq_type",
>> so ioctl(PCITEST_GET_IRQTYPE) returns the previous type.
>> As a result, the wrong type will be displayed in "pcitest" as follows:
>>
>>      # pcitest -i 0
>>      SET IRQ TYPE TO LEGACY:         OKAY
>>      # pcitest -I
>>      GET IRQ TYPE:           MSI
>>
>> Fix this issue by propagating the current type to the global "irq_type".
>>
> 
> This is becoming a nuisance. I think we should get rid of the global 'irq_type'
> and just stick to the one that is configurable using IOCTL command. Even if the
> user has configured the global 'irq_type' it is bound to change with IOCTL
> command.

We can add a new member of 'struct pci_endpoint_test' instead of the global
'irq_type'.

If I remove the global 'irq_type', the following module parameter description
will also be removed.

>> module_param(irq_type, int, 0444);
>> MODULE_PARM_DESC(irq_type, "IRQ mode selection in pci_endpoint_test (0 - Legacy, 1 - MSI, 2 - MSI-X)");

I'm concerned about compatibility. Is there any problem with removing this?

Thank you,

---
Best Regards
Kunihiko Hayashi

