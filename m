Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 224C03C264
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2019 06:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391032AbfFKEkL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jun 2019 00:40:11 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34050 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388141AbfFKEkL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jun 2019 00:40:11 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5B4druO021816;
        Mon, 10 Jun 2019 23:39:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560227993;
        bh=4CSDiP1xLUzAxuQfz4ZRA31r4GwtzqiVasSISApjHu4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=PtUYWVLx1XD5jnus/WobdTrHYWH38XwEd6RhBdD4d9ID+gD//I2BIe2INKAip1XwE
         21KPjF8ghgsEjgj7ZTvAKKjT0Sg9P2PDJp6defIHu6/JyQo1Vjh+P6Md6TX/KZhfTY
         B2bml38ZGyAf1Zmtb/u8LU5lTIk9xdQLHEFvGNFg=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5B4dr8j018697
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Jun 2019 23:39:53 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 10
 Jun 2019 23:39:53 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 10 Jun 2019 23:39:53 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5B4dmJ6034860;
        Mon, 10 Jun 2019 23:39:49 -0500
Subject: Re: [RFC PATCH 23/30] of/platform: Export
 of_platform_device_create_pdata()
To:     Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190604131516.13596-1-kishon@ti.com>
 <20190604131516.13596-24-kishon@ti.com>
 <CAL_JsqJ5gsctd7L3VOhTO1JdUqmMmSJRpos1XQyfxzmGO7wauw@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <a80c7c33-7091-70d9-cd86-a19fe43d3bc6@ti.com>
Date:   Tue, 11 Jun 2019 10:08:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJ5gsctd7L3VOhTO1JdUqmMmSJRpos1XQyfxzmGO7wauw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On 10/06/19 11:13 PM, Rob Herring wrote:
> On Tue, Jun 4, 2019 at 7:19 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>
>> Export of_platform_device_create_pdata() to be used by drivers to
>> create child devices with the given platform data. This can be used
>> by platform specific driver to send platform data core driver. For e.g.,
>> this will be used by TI's J721E SoC specific PCIe driver to send
>> ->start_link() ops and ->is_link_up() ops to Cadence core PCIe driver.
> 
> NAK
> 
> of_platform_device_create_pdata() is purely for legacy handling of
> auxdata which is something I hope to get rid of someday. Or to put it
> another way, auxdata use is a sign of platforms not fully converted to
> DT.

All right. Thanks for letting me know your thoughts.

Lorenzo,

We've modeled Cadence PCIe core as a separate driver and for some of the
functionalities (for example starting LTSSM or checking link status) it has to
invoke the wrapper driver functions (The registers for these are present in
wrapper and not in Cadence Core). In the case of Designware, we modeled DWC
core as a library which provided APIs to be used by wrapper driver. Now that
Rob is not inclined for passing platform data from one driver to another (in
this case TI specific J721E driver to Cadence PCIe driver), should we model
Cadence core also as a library? If you agree, I can prepare patches for making
Cadence PCIe core as a library. Please let me know your thoughts.

Thanks
Kishon

