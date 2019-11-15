Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7989EFDFE5
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2019 15:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfKOOTH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Nov 2019 09:19:07 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51886 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfKOOTH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Nov 2019 09:19:07 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAFEJ4Yi021401;
        Fri, 15 Nov 2019 08:19:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573827544;
        bh=/I9akdfvAxhab1mEMnAaKGhtLpVhL7/9dVBnUFiHXUc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ZRQ0W+epok3dkm982yZP4ZWC7c3pd4mFVDv3Zz0aGhNeyE+U1bzKRl9JW6/0LSbEq
         EhYGfrajjq19QKJKL49Y79ltFwGVkHFgYcp9VsJQW0O7Q4DyUIpifeQ9+HhqESurMo
         rjAd94kEidyHri/MicS0APCgzy8OC6D1nQi6iAsk=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAFEJ35Q002103
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Nov 2019 08:19:04 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 15
 Nov 2019 08:19:03 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 15 Nov 2019 08:19:03 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAFEJ1aJ041847;
        Fri, 15 Nov 2019 08:19:02 -0600
Subject: Re: pci-usb/pci-sata broken with LPAE config after "reduce use of
 block bounce buffers"
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <120f7c3e-363d-deb0-a347-782ac869ee0d@ti.com>
 <20191115130654.GA3414@lst.de>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <cf530590-26a4-22c6-c3ca-685fad7fd075@ti.com>
Date:   Fri, 15 Nov 2019 19:48:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191115130654.GA3414@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Christoph,

On 15/11/19 6:36 PM, Christoph Hellwig wrote:
> On Fri, Nov 15, 2019 at 04:29:31PM +0530, Kishon Vijay Abraham I wrote:
>> Hi Christoph,
>>
>> I think we are encountering a case where the connected PCIe card (like PCIe USB
>> card) supports 64-bit addressing and the ARM core supports 64-bit addressing
>> but the PCIe controller in the SoC to which PCIe card is connected supports
>> only 32-bits.
>>
>> Here dma APIs can provide an address above the 32 bit region to the PCIe card.
>> However this will fail when the card tries to access the provided address via
>> the PCIe controller.
> 
> What kernel version did you see your problems with?
> 
> Linux 5.3 added swiotlb to arm LPAE configs for exactly that case.

I'm using the latest kernel
commit 96b95eff4a591dbac582c2590d067e356a18aacb (HEAD, origin/master, origin/HEAD)
Merge: 4e84608c7836 80591e61a0f7
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Nov 14 08:48:10 2019 -0800

    Merge tag 'kbuild-fixes-v5.4-3' of
git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild

I think the fix on 5.3 was useful for platform drivers (where the platform
driver will set dma_set_mask as 32bits) even when the system itself supports LPAE.

Here the pci_driver will set dma_set_mask as 64 bits, since the PCI device as
such is capable of addressing 64 bits. The pci_driver doesn't know if the PCI
controller to which the PCI device is connected is capable of addressing 64 bits.

We should find a way to set the DMA mask of of the PCI device based on the DMA
mask of the PCI controller in the SoC. One option would be to change the
pci_drivers all over the kernel to set DMA mask to be based on the DMA mask of
the PCI controller (the PCI device hierarchy should get a reference to the
device pointer of the PCI controller). Or is there a better way to handle this?

Thanks
Kishon
