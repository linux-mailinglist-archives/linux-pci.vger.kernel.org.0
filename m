Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399FF2DAD96
	for <lists+linux-pci@lfdr.de>; Tue, 15 Dec 2020 13:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbgLOM6T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Dec 2020 07:58:19 -0500
Received: from halon.esss.lu.se ([194.47.240.54]:15123 "EHLO halon.esss.lu.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729028AbgLOM6M (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Dec 2020 07:58:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ess.eu; s=dec2019;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:from:references:cc:to:subject:from;
        bh=FmksUH45YtSkRp/Xj6PHBuFO+raNDQ45Hls44BOXkPU=;
        b=a9v3kWWZKU8bUROouOCLeo+Q5tBExt9OJYYsGKvsndJtrU+m8JvmEBQ/Mf6VJDasT1pHnm1wOhDKm
         GA6N1KYIPMakbRuSd3x3wz7nxnDZGR4WzpBA5BnAoBNvYxdHSiLbsSofvFHpOtKpl1RXwBBZXP6MlU
         /zVX6CVERiiOBucmrcj7WhIlzNRIYZZZGaobLarXws2vE/z4tzlKeDZXZuua4k+mAwU8ytg2nPZhla
         jBmptLBlMw+r/xUutELUxu6yngGliCe+GSqSu/o2czssArfQHBrEc4U2fOtZzim1tZbwRG9mb14sCT
         b7f2nnQsI+IpQ6+7M2NDO8/Ux+5kwIg==
Received: from mail.esss.lu.se (it-exch16-4.esss.lu.se [10.0.42.134])
        by halon.esss.lu.se (Halon) with ESMTPS
        id 0107db40-3ed5-11eb-93c8-005056a66d10;
        Tue, 15 Dec 2020 13:56:53 +0100 (CET)
Received: from [192.168.0.9] (194.47.241.248) by it-exch16-4.esss.lu.se
 (10.0.42.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 15 Dec
 2020 13:56:22 +0100
Subject: Re: Recovering from AER: Uncorrected (Fatal) error
To:     Keith Busch <kbusch@kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20201209213227.GA2544987@bjorn-Precision-5520>
 <6234c1c4-a8cc-1bd6-8366-f359b9b5ef54@ess.eu>
 <20201214212319.GB22809@redsun51.ssa.fujisawa.hgst.com>
From:   Hinko Kocevar <hinko.kocevar@ess.eu>
Message-ID: <0def63a9-9a9e-440c-6bd8-7fd8dfef5b63@ess.eu>
Date:   Tue, 15 Dec 2020 13:56:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201214212319.GB22809@redsun51.ssa.fujisawa.hgst.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [194.47.241.248]
X-ClientProxiedBy: it-exch16-2.esss.lu.se (10.0.42.132) To
 it-exch16-4.esss.lu.se (10.0.42.134)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Keith,

On 12/14/20 10:23 PM, Keith Busch wrote:
> On Wed, Dec 09, 2020 at 11:55:07PM +0100, Hinko Kocevar wrote:
>> Adding a bunch of printk()'s to portdrv_pci.c led to (partial) success!
>>
>> So, the pcie_portdrv_error_detected() returns PCI_ERS_RESULT_CAN_RECOVER and
>> therefore the pcie_portdrv_slot_reset() is not called.
>>
>> But the pcie_portdrv_err_resume() is called! Adding these two lines to
>> pcie_portdrv_err_resume(), before the call to device_for_each_child():
>>
>>          pci_restore_state(dev);
>>          pci_save_state(dev);
> 
> You need to do that with the current kernel or are you still using a
> 3.10? A more recent kernel shouldn't have needed such a fix after the


This was tested on the 5.9.12 kernel at that time. As of today, I've 
re-ran the tests on Bjorn's git tree, pci/err branch from Sunday (I 
guess 5.10.0 version).

> following commit was introduced:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=874b3251113a1e2cbe79c24994dc03fe4fe4b99b
> 

I noticed the change you are pointing out when trying to propose a patch.

It made me curious on why the pcie_portdrv_slot_reset() is not invoked.

After sprinkling a couple of printk()'s around the pcie_do_recovery() 
and pcie_portdrv_err_handler's I can observe that the 
pcie_portdrv_slot_reset() is never called from pcie_do_recovery() due to 
status returned by reset_subordinates() (actually aer_root_reset() from 
pcie/aer.c) being PCI_ERS_RESULT_RECOVERED.

I reckon, in order to invoke the pcie_portdrv_slot_reset(), the 
aer_root_reset() should have returned PCI_ERS_RESULT_NEED_RESET.

As soon as I plug the calls to pci_restore_state() and pci_save_state() 
into the pcie_portdrv_err_resume() the bus and devices are operational 
again.
