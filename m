Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA622D5AB6
	for <lists+linux-pci@lfdr.de>; Thu, 10 Dec 2020 13:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbgLJMkk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Dec 2020 07:40:40 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34772 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbgLJMkk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Dec 2020 07:40:40 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BACdex4051840;
        Thu, 10 Dec 2020 06:39:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607603980;
        bh=PoKSJKFHo6LVi1AsWhRWfh5gsTPjeohBjOFQoH+PCFU=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=ur2v+oaScko/mvK0G/OEpB5ZohPmWVOUMTdsy8C8R+dboRrTKosuGGaRF3dFrVlkX
         gYx4NnQKDjldD2jhztENDHI7oCUg7h6ajYGpgbgTHcPu5BbJhWSiHSn7sPDHpX+ts8
         OtY/lyqC7Eqvrc0KHvqKqlwKB4IC99qNPrJfsvXE=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BACde9g056026
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Dec 2020 06:39:40 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 10
 Dec 2020 06:39:40 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 10 Dec 2020 06:39:40 -0600
Received: from [10.250.235.36] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BACdY6B052109;
        Thu, 10 Dec 2020 06:39:35 -0600
Subject: Re: [PATCH v2 0/3] PCI: J721E: Fix Broken DT w.r.t SYSCON DT
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>
References: <20201204075117.10430-1-kishon@ti.com>
 <6c846ae3-0bb5-f8de-0f3e-5e0239a7aa6c@ti.com>
Message-ID: <3ef9989a-0700-3935-1deb-b86304a76ec6@ti.com>
Date:   Thu, 10 Dec 2020 18:09:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6c846ae3-0bb5-f8de-0f3e-5e0239a7aa6c@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On 10/12/20 12:17 pm, Kishon Vijay Abraham I wrote:
> Hi Lorenzo,
> 
> On 04/12/20 1:21 pm, Kishon Vijay Abraham I wrote:
>> Previously a subnode to syscon node was added which has the
>> exact memory mapped address of pcie_ctrl but based on review comment
>> provided by Rob [1], the offset is now being passed as argument to
>> "ti,syscon-pcie-ctrl" phandle.
>>
>> This series has both driver change and DT change. The driver change
>> should be merged first and the driver takes care of maintaining old
>> DT compatibility.
> 
> Can you queue the 1st two patches of this series for this merge window?
> I'll ask NM to queue the DTS patch. Let me know if you want me to resend
> only the first two patches as a separate series.

Never mind, I'll resend the pending patches for which I have already got
Acks from Rob.

Thank You,
Kishon

> 
> Thank You,
> Kishon
> 
>>
>> Changes frm v1:
>> *) Remove use of allOf in schema
>> *) Added Fixes tag
>> *) Maintain old DT compatibility
>>
>> [1] -> http://lore.kernel.org/r/CAL_JsqKiUcO76bo1GoepWM1TusJWoty_BRy2hFSgtEVMqtrvvQ@mail.gmail.com
>>
>> Kishon Vijay Abraham I (3):
>>   dt-bindings: pci: ti,j721e: Fix "ti,syscon-pcie-ctrl" to take argument
>>   PCI: j721e: Get offset within "syscon" from "ti,syscon-pcie-ctrl"
>>     phandle arg
>>   arm64: dts: ti: k3-j721e-main: Remove "syscon" nodes added for
>>     pcieX_ctrl
>>
>>  .../bindings/pci/ti,j721e-pci-ep.yaml         | 11 +++--
>>  .../bindings/pci/ti,j721e-pci-host.yaml       | 11 +++--
>>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 48 ++++---------------
>>  drivers/pci/controller/cadence/pci-j721e.c    | 28 +++++++----
>>  4 files changed, 41 insertions(+), 57 deletions(-)
>>
