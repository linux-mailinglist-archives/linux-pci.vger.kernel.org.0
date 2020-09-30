Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F5627ED8D
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 17:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbgI3PmW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 11:42:22 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58386 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgI3PmW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2020 11:42:22 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08UFgDt1045672;
        Wed, 30 Sep 2020 10:42:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601480533;
        bh=+ll5S2eNGiNif7/o2agDFeqc3tuSX/ZkzSW13n3l9XE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=kibQWMDXWG1it3TrotAwdRyX/nj4KkiOvyp1P1j8+tldqJ+pe/RJ4wd07qiF0Vo1q
         hVghGbUQV5faf8gPu/ccq2ZVIPWuyduI6H9S1YNaPYi95o5O9GM8Ah2CRH4QYXEksQ
         mhqsweWyPgbWMrSC1VAOSVX3tZj/PY/bTHyvQTIE=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08UFgDE4052741
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 10:42:13 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 10:42:12 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 10:42:12 -0500
Received: from [10.250.232.108] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08UFg88L047226;
        Wed, 30 Sep 2020 10:42:09 -0500
Subject: Re: [PATCH] PCI: layerscape: Change back to the default error
 response behavior
To:     Rob Herring <robh@kernel.org>
CC:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Roy Zang <roy.zang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
        Yang-Leo Li <leoyang.li@nxp.com>
References: <20200929131328.13779-1-Zhiqiang.Hou@nxp.com>
 <6e6d021b-bc46-63b4-7e84-6ca2c8e631f9@ti.com>
 <CAL_Jsq+rH6-NMb0=jbdYA5mzP_2VphW4TXvKJdKr3cnsPQp1RA@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <81530aba-0e4d-9685-2fc1-dfdf948a7178@ti.com>
Date:   Wed, 30 Sep 2020 21:12:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+rH6-NMb0=jbdYA5mzP_2VphW4TXvKJdKr3cnsPQp1RA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 30/09/20 8:37 pm, Rob Herring wrote:
> On Wed, Sep 30, 2020 at 8:29 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>
>> Hi Hou,
>>
>> On 29/09/20 6:43 pm, Zhiqiang Hou wrote:
>>> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>>>
>>> In the current error response behavior, it will send a SLVERR response
>>> to device's internal AXI slave system interface when the PCIe controller
>>> experiences an erroneous completion (UR, CA and CT) from an external
>>> completer for its outbound non-posted request, which will result in
>>> SError and crash the kernel directly.
>>> This patch change back it to the default behavior to increase the
>>> robustness of the kernel. In the default behavior, it always sends an
>>> OKAY response to the internal AXI slave interface when the controller
>>> gets these erroneous completions. And the AER driver will report and
>>> try to recover these errors.
>>
>> I don't think not forwarding any error interrupts is a good idea.
> 
> Interrupts would be fine. Abort/SError is not. I think it is pretty
> clear what the correct behavior is for config accesses.

IIUC $patch prevents SError in all cases. Doesn't UR, CA and CT all
sends SLVERR which will result in Abort and that is being prevented
here?. Maybe I'm wrong here, Hou can confirm.

Thanks
Kishon
