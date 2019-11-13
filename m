Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9897FAE16
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2019 11:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfKMKHO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Nov 2019 05:07:14 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52156 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKMKHN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Nov 2019 05:07:13 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xADA75UV130420;
        Wed, 13 Nov 2019 04:07:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573639625;
        bh=QY0/3WnaWYbY1hQFRQ+jKpTcoxgrjWNA2hh4v1+PV0Q=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=peDjozw8/HrfmLDYoGmaqKWjA5RKdLYNN8ALHU0YNrKC9ii+2RO+5uEXdUTMbRTP2
         bOPjWSNDECCQE03XeznZvERNOyZyUAU7I9WVFHFzWZM8oZaZ5vY7oSbB+pkq2W8z/x
         cc1cd9B+CEohBwdMfMxWUW9WnCGMtUw/Gn17W6QY=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xADA75xW102424;
        Wed, 13 Nov 2019 04:07:05 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 13
 Nov 2019 04:06:47 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 13 Nov 2019 04:06:47 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xADA731W117587;
        Wed, 13 Nov 2019 04:07:04 -0600
Subject: Re: Exploring the PCI EP Framework
To:     Ismael Luceno Cortes <ismael.luceno@silicon-gears.com>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20191112114854.GA3478@kiki>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <6e534239-36c7-086f-502a-fa399917f5f7@ti.com>
Date:   Wed, 13 Nov 2019 15:36:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191112114854.GA3478@kiki>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+linux-pci

Hi,

On 12/11/19 5:18 PM, Ismael Luceno Cortes wrote:
> Hello Kishon and Lorenzo,
> 
> I'm in the process of evaluating options to implement virtual devices,
> and I have a doubt that I couldn't solve by a quick look at the code.
> 
> I have some prototype boards with general purpose cores that can
> synthesize devices (sadly a custom driver, but I plan to replace it if I
> get approval).
> 
> The cores are for the most part equal, even in function, so the problem
> is that for whichever takes the role of endpoint I need a lightweight
> mechanism to signal an incoming transfer.
> 
> I didn't see any way to implement doorbell registers; is there such a
> thing?

The endpoint relies on polling a shared memory to detect any events. However if
the HW supports some sort of memory signaled interrupt (similar to what is
usually available in systems with RC) then we could use it for interrupting the
endpoint system. All we have to do is map the MSI address to a EP BAR region so
that host can write to a mapped BAR in order to raise MSI interrupt.

Even if the HW supports, the EP framework doesn't support to use MSI. I'll have
to see how that can be added.
> 
> I realize it may not exist because it would imply not yet existing
> mechanisms. I even don't know if such a thing is feasible with a
> standard IOMMU, but I'm trying to figure out just that.

Does the PCI EP controller also wired to IOMMU?
> 
> I'm tempted to try to glue together the EP framework with VFIO for the
> purpose.

That would help to create a user space endpoint function driver. Not sure if
it'll help for the doorbell.
> 
> Are you aware of any efforts along those lines?

Most of the efforts in EP right now are towards binding the epf to virtio.
https://lore.kernel.org/linux-pci/20190905161516.2845-1-haotian.wang@sifive.com/T/#m4092f14a49852425a00a9a9afa80b4d3b1b836d1

Thanks
Kishon
