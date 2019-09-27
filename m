Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 177ACC0B23
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2019 20:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbfI0SdW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Sep 2019 14:33:22 -0400
Received: from alpha.anastas.io ([104.248.188.109]:42585 "EHLO
        alpha.anastas.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfI0SdW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Sep 2019 14:33:22 -0400
Received: from authenticated-user (alpha.anastas.io [104.248.188.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by alpha.anastas.io (Postfix) with ESMTPSA id 17EE87E01A;
        Fri, 27 Sep 2019 13:33:21 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anastas.io; s=mail;
        t=1569609201; bh=wk1mdhZxXbNyN8NdhJA3cUtm/ZxciUydA26w8eVYR2s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cFaZ9992JNzVHC7adO3hByHpKrVvF0DrbMWzA0uMqlQjiXnmacmrnHaIUWPOrF2mn
         tsPygIlxWfZ07ObOtzM6C4EH1iMtsiXA3UB3bUvfhqZLGuWaXZ2XlqPNWuAoOXhRHU
         K0JboLNKfVKiSFsOCamrNMA7tDmGBkO78rPCYK9xPTe9nLI5otyTxQW29pD8gy1kWM
         ki0p/2PGet+olyl8xU2rOghW4izlfxC1aR+jmtrk4GkmLpIbQ9Xv5/kbkQcOXaMq7w
         kwDKPNyQIHbG92Zvz8TTcxC/w9dwD9RxhLELedwEiAP5a02cN2w5lhe3L0TyE9DpKA
         cJBjNphpaeNVw==
Subject: Re: [PATCH v2 1/1] powerpc/pci: Fix pcibios_setup_device() ordering
To:     Alexey Kardashevskiy <aik@ozlabs.ru>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     bhelgaas@google.com, mpe@ellerman.id.au, benh@kernel.crashing.org,
        sbobroff@linux.ibm.com, oohall@gmail.com, lukas@wunner.de
References: <20190905191343.2919-1-shawn@anastas.io>
 <20190905191343.2919-2-shawn@anastas.io>
 <e090d238-d452-6c82-d21b-aeda5f5310e6@ozlabs.ru>
From:   Shawn Anastasio <shawn@anastas.io>
Message-ID: <57bb4467-40ab-bdf7-4091-adc0236c3ea3@anastas.io>
Date:   Fri, 27 Sep 2019 13:33:19 -0500
MIME-Version: 1.0
In-Reply-To: <e090d238-d452-6c82-d21b-aeda5f5310e6@ozlabs.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/9/19 2:59 AM, Alexey Kardashevskiy wrote:
> 
> 
> On 06/09/2019 05:13, Shawn Anastasio wrote:
>> Move PCI device setup from pcibios_add_device() and pcibios_fixup_bus() to
>> pcibios_bus_add_device(). This ensures that platform-specific DMA and IOMMU
>> setup occurs after the device has been registered in sysfs, which is a
>> requirement for IOMMU group assignment to work
>>
>> This fixes IOMMU group assignment for hotplugged devices on pseries, where
>> the existing behavior results in IOMMU assignment before registration.
> 
> 
> Although this is a correct approach which we should proceed with, this
> breaks adding of SRIOV VFs from pnv_tce_iommu_bus_notifier (and possibly
> the bare metal PCI hotplug), I am trying to fix that now...

Were you able to make any progress? I can think of a couple of ways
to fix SRIOV, but they're not particularly elegant and involve
duplication.
