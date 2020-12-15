Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD8F2DA864
	for <lists+linux-pci@lfdr.de>; Tue, 15 Dec 2020 08:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgLOHKv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Dec 2020 02:10:51 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51360 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgLOHKv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Dec 2020 02:10:51 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BF799Zu047587;
        Tue, 15 Dec 2020 01:09:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608016149;
        bh=fNRq+gOfrdMwuLy2nUKc+a0umMFiha80ZqqipUQ7GjI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nIfK4UmtJX+4YT+uFZjIfdGIROvpQMEUPq69q+VnzUUNKEv6l1ZqiFK+mYyHP+B71
         oKzNXVzg6crDJV+KpHJwRsR+chryLG6CDGMfKQwzO8xwQXpyc3Wck+2s483ZUcP+Ap
         jhRRefqu1yf5pLoXhzIovUwX6KB1ZJNJhT5UaUQc=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BF799k0063765
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Dec 2020 01:09:09 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 15
 Dec 2020 01:09:08 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 15 Dec 2020 01:09:08 -0600
Received: from [10.250.235.36] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BF794NZ109620;
        Tue, 15 Dec 2020 01:09:05 -0600
Subject: Re: [PATCH v4 1/2] dt-bindings: pci: Retrain Link to work around Gen2
 training defect.
To:     Rob Herring <robh@kernel.org>
CC:     Athani Nadeem Ladkhan <nadeem@cadence.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Parshuram Raju Thombare <pthombar@cadence.com>
References: <20201211144236.3825-1-nadeem@cadence.com>
 <20201211144236.3825-2-nadeem@cadence.com>
 <CAL_JsqLTz2k03gzrjDqi2d1NHQV+3pXxg6OqwcJ17CmfGYMf-A@mail.gmail.com>
 <SN2PR07MB2557145EE4C4E9C50A16CF64D8C90@SN2PR07MB2557.namprd07.prod.outlook.com>
 <912c1efa-6c25-9e5d-5094-6c9dd8e3755d@ti.com>
 <CAL_JsqLEmb4N6AKWpJmh9mGkE3QWsgABUqcH4Zvb5CiSMe_Zvg@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <95f35432-3360-c855-9f87-cec4e3f57282@ti.com>
Date:   Tue, 15 Dec 2020 12:38:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLEmb4N6AKWpJmh9mGkE3QWsgABUqcH4Zvb5CiSMe_Zvg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 14/12/20 8:35 pm, Rob Herring wrote:
> On Sun, Dec 13, 2020 at 10:21 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>
>> Hi Nadeem,
>>
>> On 12/12/20 12:37 pm, Athani Nadeem Ladkhan wrote:
>>> Hi Rob / Kishon,
>>>
>>>> -----Original Message-----
>>>> From: Rob Herring <robh@kernel.org>
>>>> Sent: Friday, December 11, 2020 10:32 PM
>>>> To: Athani Nadeem Ladkhan <nadeem@cadence.com>
>>>> Cc: Tom Joseph <tjoseph@cadence.com>; Lorenzo Pieralisi
>>>> <lorenzo.pieralisi@arm.com>; Bjorn Helgaas <bhelgaas@google.com>; PCI
>>>> <linux-pci@vger.kernel.org>; linux-kernel@vger.kernel.org; Kishon Vijay
>>>> Abraham I <kishon@ti.com>; devicetree@vger.kernel.org; Milind Parab
>>>> <mparab@cadence.com>; Swapnil Kashinath Jakhade
>>>> <sjakhade@cadence.com>; Parshuram Raju Thombare
>>>> <pthombar@cadence.com>
>>>> Subject: Re: [PATCH v4 1/2] dt-bindings: pci: Retrain Link to work around
>>>> Gen2 training defect.
>>>>
>>>> EXTERNAL MAIL
>>>>
>>>>
>>>> On Fri, Dec 11, 2020 at 9:03 AM Nadeem Athani <nadeem@cadence.com>
>>>> wrote:
>>>>>
>>>>> Cadence controller will not initiate autonomous speed change if
>>>>> strapped as Gen2. The Retrain Link bit is set as quirk to enable this speed
>>>> change.
>>>>> Adding a quirk flag based on a new compatible string.
>>>>>
>>>>> Signed-off-by: Nadeem Athani <nadeem@cadence.com>
>>>>> ---
>>>>>  Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml | 4
>>>>> +++-
>>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git
>>>>> a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
>>>>> b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
>>>>> index 293b8ec318bc..204d78f9efe3 100644
>>>>> --- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
>>>>> +++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
>>>>> @@ -15,7 +15,9 @@ allOf:
>>>>>
>>>>>  properties:
>>>>>    compatible:
>>>>> -    const: cdns,cdns-pcie-host
>>>>> +    enum:
>>>>> +        - cdns,cdns-pcie-host
>>>>> +        - cdns,cdns-pcie-host-quirk-retrain
>>>>
>>>> So, we'll just keep adding quirk strings on to the compatible? I don't think so.
>>>> Compatible strings should map to a specific implementation/platform and
>>>> quirks can then be implied from them. This is the only way we can implement
>>>> quirks in the OS without firmware
>>>> (DT) changes.
>>> Ok, I will change the compatible string to " ti,j721e-pcie-host" in place of  " cdns,cdns-pcie-host-quirk-retrain" .
>>> @Kishon Vijay Abraham I: Is this fine? Or will you suggest an appropriate name?
>>
>> IMHO it should be something like "cdns,cdns-pcie-host-vX", since the
>> quirk itself is not specific to TI platform rather Cadence IP version.
> 
> That's fine if Cadence has a need for it, but for TI platforms use the
> TI compatible string. ECOs on version X IP without changing X is not
> uncommon.

Okay. I re-worked the patch to be applicable only to TI's J721E SoC
http://lore.kernel.org/r/20201215070009.27937-1-kishon@ti.com

Thank You,
Kishon
