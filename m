Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1DF1F52E0
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jun 2020 13:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgFJLJ6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jun 2020 07:09:58 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:54711 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728418AbgFJLJ6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Jun 2020 07:09:58 -0400
Received: from [192.168.42.142] (unknown [212.29.212.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPSA id F3DD544004C;
        Wed, 10 Jun 2020 14:09:54 +0300 (IDT)
Subject: Re: [RFC PATCH] pci: pci-mvebu: setup BAR0 to internal-regs
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <marek.behun@nic.cz>,
        Baruch Siach <baruch@tkos.co.il>,
        Chris ackham <chris.packham@alliedtelesis.co.nz>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20200608144024.1161237-1-sh@tkos.co.il>
 <20200608214335.156baaaa@windsurf>
 <df64c0b9-cba7-c92e-c32d-804a75796f83@tkos.co.il>
 <20200610122750.389c990f@windsurf.home>
From:   "Shmuel H." <sh@tkos.co.il>
Message-ID: <ecfaedfb-0176-f321-0427-73dc0cf81110@tkos.co.il>
Date:   Wed, 10 Jun 2020 14:09:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200610122750.389c990f@windsurf.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

On 6/10/20 1:27 PM, Thomas Petazzoni wrote:
> Hello,
>
> On Tue, 9 Jun 2020 14:21:07 +0300
> "Shmuel H." <sh@tkos.co.il> wrote:
>
>> Unfortunately, there is almost no documentation about the purpose of
>> this register apart from this cryptic sentence:
>>
>>      "BAR0 is dedicated to internal register access" (Marvell a38x
>> functional docs, section 19.8).
>>
>> I can only assume that only specific devices trigger the need for the
>> PCIe controller to access the SoC's internal registers and therefore
>> will fail to operate properly.
> In fact, section 10.2.6 of the Armada XP datasheet, about MSI/MSI-X
> support gives a hint: in order for the device to do a write to the MSI
> doorbell address, it needs to write to a register in the "internal
> registers" space". So it makes a lot of sense that this BAR0 has to be
> configured.
>
> Could you try to boot your system without your patch, and with the
> pci=nomsi argument on the kernel command line ? This will prevent the
> driver from using MSI, so it should fallback to legacy IRQs. If that
> works, then we have the confirmation the issue is MSI related. This
> will be useful just to have a good commit message that explains the
> problem, because otherwise I am fine with your patch.

I can confirm that pci=nomsi seems to solve the issue. The wil6210
operates and loads properly (without my patch), nice catch.

I will send an updated patch shortly.

Thanks!

-- 
- Shmuel Hazan

mailto:sh@tkos.co.il | tel:+972-523-746-435 | http://tkos.co.il

