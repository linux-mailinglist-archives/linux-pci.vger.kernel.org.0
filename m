Return-Path: <linux-pci+bounces-20135-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 689EBA16AAB
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 11:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71B687A0F96
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 10:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C831AF0C2;
	Mon, 20 Jan 2025 10:24:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8DB1531F2;
	Mon, 20 Jan 2025 10:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737368668; cv=none; b=IjPXocDTbVOaQuCzjtAoEdlqlJ/aVlAUZkU6Cb0xNuY6MK9ZtR4OK/w/PMxpjKZoNSgV0BgVTHph2M8CmijQbrXhFbkWG0buti///sXYbBOirgW1FoTvpAAb9XLGdBDHJKKTs1ktXpbKKj7QwAiQHdDQyKG4jN2s1SH7AzUYiRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737368668; c=relaxed/simple;
	bh=KJEG8PAqpcWT4frQh4dz7x61uG4IGDmGdjWv2lai2LI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=csVt/J3I/A0iRq+oiFlIQ3Nw3Ld6E+6TwXUx6fRuj+yUo3ARFLkgfJj5/1QP3ov2ua1mhWNZfjPhXEMtmO+o7VRUgDGPLy2wjh03zhC9LSwcwX7IcKMLKF19RYXNx94sszQaFtv968/Opn13tAquhkDnA/+CGbcz6tMR1wMPIK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 20 Jan 2025 19:24:24 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 3C5582006FCC;
	Mon, 20 Jan 2025 19:24:24 +0900 (JST)
Received: from iyokan2.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Mon, 20 Jan 2025 19:24:24 +0900
Received: from [10.212.247.50] (unknown [10.212.247.50])
	by iyokan2.css.socionext.com (Postfix) with ESMTP id 6EA6BAB184;
	Mon, 20 Jan 2025 19:24:23 +0900 (JST)
Message-ID: <cba08e9c-9a91-4c55-b2f8-a24499321300@socionext.com>
Date: Mon, 20 Jan 2025 19:24:23 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v1] misc: pci_endpoint_test: Fix irq_type to convey
 the correct type
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250116150412.GA581512@bhelgaas>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <20250116150412.GA581512@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bjorn,

Thank you for your comment.

On 2025/01/17 0:04, Bjorn Helgaas wrote:
> On Thu, Jan 16, 2025 at 11:41:45AM +0900, Kunihiko Hayashi wrote:
>> There are two variables that indicate the interrupt type to be used
>> in the next test execution, global "irq_type" and test->irq_type.
>>
>> The former is referenced from pci_endpoint_test_get_irq() to preserve
>> the current type for ioctl(PCITEST_GET_IRQTYPE).
>>
>> In pci_endpoint_test_request_irq(), since this global variable is
>> referenced when an error occurs, the unintended error message is
>> displayed.
> 
> Apparently this test fails (with an error message) when it shouldn't?
> Please include the error message here. >
> "... since this global variable is referenced ..." is not quite enough
> explanation of how this causes a spurious test failure or under what
> circumstances the failure occurs.

I see. This failure path is taken if devm_request_irq() returns with
an error. The message that causes an error in the third interrupt is for
example:

   pci-endpoint-test 0000:01:00.0: Failed to request IRQ 30 for MSI 3

Before this fix, this message will show "MSI" even if the current irq
type was "legacy" or "MSI-X".

I'll add such that description in the commit.

And I discovered that not releasing interrupt correctly caused WARN()
after displaying this message. I'll fix the issue additionally.

>> And the type set in pci_endpoint_test_set_irq() isn't reflected in
>> the global "irq_type", so ioctl(PCITEST_GET_IRQTYPE) returns the
> previous
>> type. As a result, the wrong type will be displayed in "pcitest".
> 
> The global "irq_type" seems a little suspect.  Is it possible to run
> multiple tests concurrently?  If so, is this usage safe from races?

The global "irq_type" is only changed in pci_endpoint_test_set_irq().
I think this function is protected by the ioctl's mutex even if running
multiple tests.

Thank you,

---
Best Regards
Kunihiko Hayashi

