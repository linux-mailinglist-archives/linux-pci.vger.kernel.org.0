Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD272048D8
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jun 2020 06:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgFWEbz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Jun 2020 00:31:55 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:55821 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbgFWEbz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Jun 2020 00:31:55 -0400
Received: from [10.130.88.39] (unknown [109.253.199.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPSA id 7EFDB4408C8;
        Tue, 23 Jun 2020 07:31:50 +0300 (IDT)
Subject: Re: [PATCH] PCI: mvebu: setup BAR0 to internal-regs
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <marek.behun@nic.cz>,
        Baruch Siach <baruch@tkos.co.il>,
        Chris ackham <chris.packham@alliedtelesis.co.nz>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20200622224925.GA2332050@bjorn-Precision-5520>
From:   "Shmuel H." <sh@tkos.co.il>
Message-ID: <b56f15da-ddb0-c0c9-8027-acdc7f76d151@tkos.co.il>
Date:   Tue, 23 Jun 2020 07:31:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200622224925.GA2332050@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas, Bjorn,

On 6/23/20 1:49 AM, Bjorn Helgaas wrote:
> On Mon, Jun 22, 2020 at 08:40:33PM +0200, Thomas Petazzoni wrote:
>> On Mon, 22 Jun 2020 12:25:16 -0500
>> Bjorn Helgaas <helgaas@kernel.org> wrote:
>>
>>>> As a result of the requirement above, without this patch, MSI won't
>>>> function and therefore some devices won't operate properly without
>>>> pci=nomsi.  
>>> Does that mean MSIs never worked at all with mvebu?
>> They definitely worked. I think what happens is that this register was
>> normally setup by the vendor-specific bootloader, and thanks to
>> firmware initialization, Linux had MSIs working properly.
>>
>> With other bootloaders that initialize the PCIe block differently, or
>> even not at all, it became clear this init was missing in Linux.
> That would be very useful information to include in the commit log.

Thanks. I will add it to the commit message.

>
> Are there any other similar bugs lurking?  Other registers where we
> implicitly rely on the bootloader to do something?

I don't think that any PCI  driver writer can answer this question for
sure.

I can however confirm that this driver, on the a385, works with no
u-boot PCIe initialization. As for other subsystems PCI is dependent on
(e.g. SerDes, etc), I can't say for sure.

-- 
- Shmuel Hazan

mailto:sh@tkos.co.il | tel:+972-523-746-435 | http://tkos.co.il

