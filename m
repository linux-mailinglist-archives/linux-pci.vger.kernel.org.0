Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8772C5681
	for <lists+linux-pci@lfdr.de>; Thu, 26 Nov 2020 14:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389924AbgKZN6l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Nov 2020 08:58:41 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60966 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389923AbgKZN6k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Nov 2020 08:58:40 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AQDwWkT046631;
        Thu, 26 Nov 2020 07:58:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1606399112;
        bh=G6GjJkJWLodJtk4azhNrCODdNU4ykJN55mLmKNOTymw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=llofq/PRX6NY4VW08Ax1hHkJit8bN1giaINruTvkF7vbR5XM5+PWUjsnH+YgabgHC
         8nQQ2GhL9m3TQrq9X0Q8qVwWn/3ay5w09heuaGSs2QFy+B1Lh1g97TV6ueNjM/7oc5
         l+dM03X0YiSipkEKTlyLNlz6yT8usNYIKWjUGuNw=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AQDwWde106348
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Nov 2020 07:58:32 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 26
 Nov 2020 07:58:32 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 26 Nov 2020 07:58:32 -0600
Received: from [10.250.235.36] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AQDwSN0024222;
        Thu, 26 Nov 2020 07:58:29 -0600
Subject: Re: [PATCH v3] PCI: cadence: Retrain Link to work around Gen2
 training defect.
To:     Rob Herring <robh@kernel.org>
CC:     Athani Nadeem Ladkhan <nadeem@cadence.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Milind Parab <mparab@cadence.com>
References: <20200930182105.9752-1-nadeem@cadence.com>
 <a3a89720-6813-b344-630d-4cd2d6ccf24f@ti.com>
 <SN2PR07MB255715C886C2DC5B9044BC01D81E0@SN2PR07MB2557.namprd07.prod.outlook.com>
 <d2aa5519-e207-c3e5-9d81-14209d856b54@ti.com>
 <CAL_JsqKdAzi4zu=U=DPF_VBjTt9287gsTR1hgDWriMKdsx+MNA@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <fd972d22-7bf5-c87d-9612-4ff684ffe625@ti.com>
Date:   Thu, 26 Nov 2020 19:28:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKdAzi4zu=U=DPF_VBjTt9287gsTR1hgDWriMKdsx+MNA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Tom, Nadeem,

On 27/10/20 12:50 am, Rob Herring wrote:
> On Fri, Oct 23, 2020 at 1:57 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>
>> Hi Nadeem,
>>
>> On 19/10/20 10:48 pm, Athani Nadeem Ladkhan wrote:
>>> Hi Kishon,
>>>
>>>> -----Original Message-----
>>>> From: Kishon Vijay Abraham I <kishon@ti.com>
>>>> Sent: Monday, October 19, 2020 10:59 AM
>>>> To: Athani Nadeem Ladkhan <nadeem@cadence.com>;
>>>> lorenzo.pieralisi@arm.com; robh@kernel.org; bhelgaas@google.com; linux-
>>>> pci@vger.kernel.org; linux-kernel@vger.kernel.org; Tom Joseph
>>>> <tjoseph@cadence.com>
>>>> Cc: Swapnil Kashinath Jakhade <sjakhade@cadence.com>; Milind Parab
>>>> <mparab@cadence.com>
>>>> Subject: Re: [PATCH v3] PCI: cadence: Retrain Link to work around Gen2
>>>> training defect.
>>>>
>>>> EXTERNAL MAIL
>>>>
>>>>
>>>> Hi Nadeem,
>>>>
>>>> On 30/09/20 11:51 pm, Nadeem Athani wrote:
>>>>> Cadence controller will not initiate autonomous speed change if
>>>>> strapped as Gen2. The Retrain Link bit is set as quirk to enable this speed
>>>> change.
>>>>>
>>>>> Signed-off-by: Nadeem Athani <nadeem@cadence.com>

Do you have a follow-up patch fixing the review comments?

Thanks
Kishon
