Return-Path: <linux-pci+bounces-21605-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0A5A381A1
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 12:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2EA317004D
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 11:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46F0217F20;
	Mon, 17 Feb 2025 11:26:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA992135C7;
	Mon, 17 Feb 2025 11:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739791609; cv=none; b=aKoOlcE5uW6U1GBMLkF4bpEn7LmPl4ozdeCVAP+bG2QJsCG+z3s3E8SUX3vOcxlXpGXSkqTdaMSHYnun9GeI9M2glYi7UVeu+62ldlYqMyvZAcGqk+o0N11kjFnUa05dR4D0nuhmfDUOkc07Ez326JQeseggq08eAABhrd5p54E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739791609; c=relaxed/simple;
	bh=OuMrnB1xAZdhRcTfUDDYRq3ryHgXLtSqmCrg3cU93EM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=srp3aKoz/yDWjdc8+ALDwCCUu/32J5FrmPDQmdozD4Sl76CDm/WKcVX3SbdcSJlTq7T2z18aRA3oxMweBv/2rq3wH9SVDE08yMzCSeF/UhO7ihMSfgnsQDblG/Q6NqjTxXjLsbXGt6anAUy1+JayF7zpbO1S/D2DYJfepuxNq8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 17 Feb 2025 20:26:46 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 08C9720090C2;
	Mon, 17 Feb 2025 20:26:46 +0900 (JST)
Received: from iyokan2.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Mon, 17 Feb 2025 20:26:46 +0900
Received: from [10.212.246.222] (unknown [10.212.246.222])
	by iyokan2.css.socionext.com (Postfix) with ESMTP id 10655398;
	Mon, 17 Feb 2025 20:26:45 +0900 (JST)
Message-ID: <36cc27be-4ba7-4d65-b32b-2a1e0b03b161@socionext.com>
Date: Mon, 17 Feb 2025 20:26:44 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] misc: pci_endpoint_test: Fix irq_type to convey
 the correct type
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof Wilczynski <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250210075812.3900646-1-hayashi.kunihiko@socionext.com>
 <20250210075812.3900646-4-hayashi.kunihiko@socionext.com>
 <20250214172533.szrbreiv45c3g5lo@thinkpad>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <20250214172533.szrbreiv45c3g5lo@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Manivannan,

On 2025/02/15 2:25, Manivannan Sadhasivam wrote:
> On Mon, Feb 10, 2025 at 04:58:10PM +0900, Kunihiko Hayashi wrote:
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
> 
> Could you please post the failure with kselftest that got merged into
> v6.14-rc1?

The kselftest doesn't call GET_IRQTYPE, so current kselftest doesn't fail.

If necessary, I can add GET_IRQTYPE test after SET_IRQTYPE of each
interrupt test prior to this patch.

         pci_ep_ioctl(PCITEST_SET_IRQTYPE, 0);
         ASSERT_EQ(0, ret) TH_LOG("Can't set Legacy IRQ type");

+       pci_ep_ioctl(PCITEST_GET_IRQTYPE, 0);
+       ASSERT_EQ(0, ret) TH_LOG("Can't get Legacy IRQ type");

However, pci_ep_ioctl() returns zero if OK, the return value should be
changed to the actual return value.

  #define pci_ep_ioctl(cmd, arg)                 \
  ({                                             \
         ret = ioctl(self->fd, cmd, arg);        \
-       ret = ret < 0 ? -errno : 0;             \
+       ret = ret < 0 ? -errno : ret;           \
  })

Before applying the patch, this test fails.

#  RUN           pci_ep_basic.LEGACY_IRQ_TEST ...
# pci_endpoint_test.c:104:LEGACY_IRQ_TEST:Expected 0 (0) == ret (1)
# pci_endpoint_test.c:104:LEGACY_IRQ_TEST:Can't get Legacy IRQ type
# LEGACY_IRQ_TEST: Test terminated by assertion
#          FAIL  pci_ep_basic.LEGACY_IRQ_TEST

Thank you,

---
Best Regards
Kunihiko Hayashi

