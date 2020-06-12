Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833751F7383
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jun 2020 07:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgFLFb2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Jun 2020 01:31:28 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36726 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgFLFb1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Jun 2020 01:31:27 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05C5UxHv105841;
        Fri, 12 Jun 2020 00:30:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1591939859;
        bh=CsA12+jay5u2Gva3INtQk/dUmPirKLYO9bGaNjt4rNo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Cg2p8vydUTWmNQ2lzOSyDSWmdqOebHooI/vMth+bh7pd/51rQC2ntnVLZH4Lvio5P
         uVhqDC8T3gST0DBveYMwe83KlQWQo63bBpBzPbyvL5i2bI3vuCswq4fpeMW4N5bP7L
         gl+ViholWzlFmh9GSDIrvxLutyvzt0Fh6zAaUTlE=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05C5UxcF111764;
        Fri, 12 Jun 2020 00:30:59 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 12
 Jun 2020 00:30:58 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 12 Jun 2020 00:30:58 -0500
Received: from [10.250.233.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05C5UsBx060089;
        Fri, 12 Jun 2020 00:30:54 -0500
Subject: Re: [PATCH v2 01/14] Documentation: PCI: Add specification for the
 *PCI NTB* function device
To:     Matthew Wilcox <willy@infradead.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-ntb@googlegroups.com>
References: <20200611130525.22746-1-kishon@ti.com>
 <20200611130525.22746-2-kishon@ti.com>
 <20200611151301.GB8681@bombadil.infradead.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <c8a5d63a-7026-2b40-4b26-5f4e481f7df4@ti.com>
Date:   Fri, 12 Jun 2020 11:00:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200611151301.GB8681@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Matthew,

On 6/11/2020 8:43 PM, Matthew Wilcox wrote:
> On Thu, Jun 11, 2020 at 06:35:12PM +0530, Kishon Vijay Abraham I wrote:
>> +++ b/Documentation/PCI/endpoint/pci-ntb-function.rst
>> @@ -0,0 +1,344 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +=================
>> +PCI NTB Function
>> +=================
>> +
>> +:Author: Kishon Vijay Abraham I <kishon@ti.com>
>> +
>> +PCI NTB Function allows two different systems (or hosts) to communicate
>> +with each other by configurig the endpoint instances in such a way that
>> +transactions from one system is routed to the other system.
> 
> At no point in this document do you expand "NTB" into Non-Transparent
> Bridge.  The above paragraph probably also needs to say something like "By
> making each host appear as a device to the other host".  Although maybe
> that's not entirely accurate?  It's been a few years since I last played
> with NTBs.
> 
> So how about the following opening paragraph:
> 
> PCI Non Transparent Bridges (NTB) allow two host systems to communicate
> with each other by exposing each host as a device to the other host.
> NTBs typically support the ability to generate interrupts on the remote
> machine, expose memory ranges as BARs and perform DMA.  They also support
> scratchpads which are areas of memory within the NTB that are accessible
> from both machines.
> 
> ... feel free to fix that up if my memory is out of date or corrupted.

I think that's accurate. I'll wait for review comments on the rest of the
series and I'll fix this one in my next revision.

Thanks
Kishon
