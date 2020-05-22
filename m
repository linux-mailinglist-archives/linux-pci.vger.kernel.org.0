Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234FA1DE394
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 11:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgEVJ51 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 05:57:27 -0400
Received: from mail-eopbgr80058.outbound.protection.outlook.com ([40.107.8.58]:30339
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728212AbgEVJ50 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 May 2020 05:57:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpyOOSlJAodHsklUaFRH0TymYWyt6DPUt+hS0CsJput523K+xt9FWrMsSw0rFnvN7GAHMTejjhFnYu2WUy+H/tuN4ENDT48pyNahSP2hX9Ac8Jcc/zgJ3PgQqDdrO6cDwodVL7ozrgU+loJBSK9FFRoJanI84tJpkBYbr4Iay/JulYbhnNgECms1/ZaKFmzaNFD5jtbnrxt92fQ6FTo4nBh9aJmhUEatRFbCqv8PNRWaVZYQsVtlPhoHwcExRAv4hL1i6NwECsPBAsr5i8HIGrBaXscOpWs9U0ciq9qexBsHioLbV+BV3UfRSB1H65xo7RoWSzN5dz9bRDYPp/eK5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DiRek/1gWLqwYviHH523BGPtwtE2kagpc48+ur8iZg4=;
 b=arAFKKmlk/FDNZ4gIpMyBqYTfYw2lQV8WYVbjLVY4FTie2kisaIMtZqXxZQ6ZTvYCZBuuQIY/WMKODJVjWBFZ5WPiPnSWJKzuA/kkNd29N0ik0Mv86JwBIwRsogRJsKbW1S7WWP+1CZ5UUf+3mwWnIgrJJ5pN+RTFNDa6BDt8YGl+97J35+LCYljgmiSGVP9/TZoI+V9+UE5prCufAqV4YqbwfWzuM+Ti/WDsBxy5/f+C/1ktgGRGZwlqtM23NqKexgg9ZhK/yjNH0QMrtNRJTWkWfsPVolTSm3oUjcyWXWvMmW1ger6BwXVsCi75S3FuDCgHNrTFXwelwLGDYk7Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DiRek/1gWLqwYviHH523BGPtwtE2kagpc48+ur8iZg4=;
 b=Gttv99l1I8j39M/iAC6TKoAAqrGjUBkvMaUF2Oq8p8WqdURCn0fK10l3pBK/EnGMYZWfwzFqr4KjWRpBUX76TI9Nf6VXP+8sAj0DMvurDbOJZRZ8s75NKBG5iiC4ABShPTryLuXQiwo6mHoq8IRljEiso/Q6bZo/ZlKocn+yfxk=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oss.nxp.com;
Received: from VI1PR0402MB2815.eurprd04.prod.outlook.com
 (2603:10a6:800:ae::16) by VI1PR0402MB3616.eurprd04.prod.outlook.com
 (2603:10a6:803:8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Fri, 22 May
 2020 09:57:21 +0000
Received: from VI1PR0402MB2815.eurprd04.prod.outlook.com
 ([fe80::81fd:56b7:594b:59c0]) by VI1PR0402MB2815.eurprd04.prod.outlook.com
 ([fe80::81fd:56b7:594b:59c0%10]) with mapi id 15.20.3021.026; Fri, 22 May
 2020 09:57:21 +0000
Subject: Re: [PATCH 09/12] dt-bindings: arm: fsl: Add msi-map device-tree
 binding for fsl-mc bus
To:     Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     devicetree@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, PCI <linux-pci@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Makarand Pawagi <makarand.pawagi@nxp.com>,
        linux-acpi@vger.kernel.org,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200521130008.8266-10-lorenzo.pieralisi@arm.com>
 <CAL_Jsq+h18gH2D3B-OZku6ACCgonPUJcUnrN8a5=jApsXHdB5Q@mail.gmail.com>
 <abca6ecb-5d93-832f-ff7c-de53bb6203f3@arm.com>
From:   Diana Craciun OSS <diana.craciun@oss.nxp.com>
Message-ID: <ee7a5c04-814e-215f-ec74-52c2f3b881d0@oss.nxp.com>
Date:   Fri, 22 May 2020 12:57:05 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <abca6ecb-5d93-832f-ff7c-de53bb6203f3@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0169.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::38) To VI1PR0402MB2815.eurprd04.prod.outlook.com
 (2603:10a6:800:ae::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.122] (81.196.112.2) by AM0PR01CA0169.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24 via Frontend Transport; Fri, 22 May 2020 09:57:19 +0000
X-Originating-IP: [81.196.112.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3c04f067-51a7-4fc4-cce7-08d7fe3684ca
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3616:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3616D5811326B2BE8C6383C0BEB40@VI1PR0402MB3616.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 04111BAC64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lZK/RkyvmIvq4ObOJ01NQnu1OgK0NbX696tlJ/QZuwOlHHJLn0VsQ3S5c5CZHc6sfgsBV32k0djdccGHfNJccHacCuzOVH/WuYuh9OjizawKYBv8E0ri46Vpuej40I44Z0A2CAbcd9RxtymHfCyTvFPjcC6N1HIvLZ/4rkgIfbBCEeaW9J+1LyNhKy8Npolz/eW2u+rhT3iZAtlfuXVTBSDAmR5Y/J9fMXABXdTl9L+kZgGHlyU8l8ETSFglW+bEA9VfpsD71pOzoOu8cTT306+hSNTPIVUC9MQBMewh/rUH0ETeEtBZTwqfLRTJTacGPANi3k6XqoPGwkCh79X4if6X8YpvtpohDP5CHetwC71BwY5oe+L2A104orWdQxtbdBkwAzBvyH4UdqL0zYy92R/qnRQZVj1JOBr8SnPaYnaaIpH2m3QrIKC+ZBoWJWJYRfJAdof3DbwRChqWmQ1Fu5qYcFtWCdkXHPfCcDlsAV89QERkHaah9SXvSSHpnynEkeRD40Fgs4hZoYeW3NaijqmODeTfeej8k+crGR3Gd3z7h9T4/0Xhj8E1N2qGUMJBYd14973LP3wfN/Xktn0p2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB2815.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(478600001)(5660300002)(966005)(7416002)(66946007)(2616005)(86362001)(54906003)(16576012)(52116002)(31686004)(4326008)(6666004)(316002)(956004)(2906002)(6486002)(53546011)(8936002)(31696002)(110136005)(8676002)(16526019)(66556008)(66476007)(26005)(186003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: LiNugFNsLsT2IU/m+fXuKsRG4k2Q3PXQG1aMgarynHUWdpAj1iAC8rt+LTzpDibfXqTrkzxNEkg2e3UaFZ5d1I9q8aLYZqTUeWx2Ehej7ZNzJ4/FnAAbJ8CKH3Z7/d8q0No5pfebAONHFXSjFLY+of67LquzZqSKCAfwL+0mD0hq/0kOZu/jdcoPp+piHi+YVIJMbvKZ+Xo6q+Icob2k80tLAfRt69xmOClgWKKXbBec0QoP8JnBqy75CvwtlUOSM6C7D0Wp7O5K16nrYWK/HJ2Ng6r2dfju0P9bXTYLrDHi5ikAU7xxwEIM8puwzG8oPdroISrdkDvBEAm0ZB2S0MYFDu/05JfFYkqNYcSP7zOou9BMyqAw1+QnR62PfmXAK2GsKxohFdQx0Ta+3qqanPK0mLM9CWNXTvXazUOB39PMuD6QbwPTjgNAGavVoFOfC79FaDercYcEQvsH+MfkmRYO5MAML9FY3BRCwxdqp/8=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c04f067-51a7-4fc4-cce7-08d7fe3684ca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2020 09:57:21.2573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pd+ALR22Ie+M3ExeLZPReA8jU3lSist0knQclq0eaOPVI+5K+EvG/NeNNb06atARrVHZGVNOhUG5/TPBI4p38w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3616
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/22/2020 12:42 PM, Robin Murphy wrote:
> On 2020-05-22 00:10, Rob Herring wrote:
>> On Thu, May 21, 2020 at 7:00 AM Lorenzo Pieralisi
>> <lorenzo.pieralisi@arm.com> wrote:
>>>
>>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>>
>>> The existing bindings cannot be used to specify the relationship
>>> between fsl-mc devices and GIC ITSes.
>>>
>>> Add a generic binding for mapping fsl-mc devices to GIC ITSes, using
>>> msi-map property.
>>>
>>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>> Cc: Rob Herring <robh+dt@kernel.org>
>>> ---
>>>   .../devicetree/bindings/misc/fsl,qoriq-mc.txt | 30 
>>> +++++++++++++++++--
>>>   1 file changed, 27 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt 
>>> b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
>>> index 9134e9bcca56..b0813b2d0493 100644
>>> --- a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
>>> +++ b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
>>> @@ -18,9 +18,9 @@ same hardware "isolation context" and a 10-bit 
>>> value called an ICID
>>>   the requester.
>>>
>>>   The generic 'iommus' property is insufficient to describe the 
>>> relationship
>>> -between ICIDs and IOMMUs, so an iommu-map property is used to define
>>> -the set of possible ICIDs under a root DPRC and how they map to
>>> -an IOMMU.
>>> +between ICIDs and IOMMUs, so the iommu-map and msi-map properties 
>>> are used
>>> +to define the set of possible ICIDs under a root DPRC and how they 
>>> map to
>>> +an IOMMU and a GIC ITS respectively.
>>>
>>>   For generic IOMMU bindings, see
>>>   Documentation/devicetree/bindings/iommu/iommu.txt.
>>> @@ -28,6 +28,9 @@ Documentation/devicetree/bindings/iommu/iommu.txt.
>>>   For arm-smmu binding, see:
>>>   Documentation/devicetree/bindings/iommu/arm,smmu.yaml.
>>>
>>> +For GICv3 and GIC ITS bindings, see:
>>> +Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml. 
>>>
>>> +
>>>   Required properties:
>>>
>>>       - compatible
>>> @@ -119,6 +122,15 @@ Optional properties:
>>>     associated with the listed IOMMU, with the iommu-specifier
>>>     (i - icid-base + iommu-base).
>>>
>>> +- msi-map: Maps an ICID to a GIC ITS and associated iommu-specifier
>>> +  data.
>>> +
>>> +  The property is an arbitrary number of tuples of
>>> +  (icid-base,iommu,iommu-base,length).
>>
>> I'm confused because the example has GIC ITS phandle, not an IOMMU.
>>
>> What is an iommu-base?
>
> Right, I was already halfway through writing a reply to say that all 
> the copy-pasted "iommu" references here should be using the 
> terminology from the pci-msi.txt binding instead.

Right, will change it.

>
>>> +
>>> +  Any ICID in the interval [icid-base, icid-base + length) is
>>> +  associated with the listed GIC ITS, with the iommu-specifier
>>> +  (i - icid-base + iommu-base).
>>>   Example:
>>>
>>>           smmu: iommu@5000000 {
>>> @@ -128,6 +140,16 @@ Example:
>>>                  ...
>>>           };
>>>
>>> +       gic: interrupt-controller@6000000 {
>>> +               compatible = "arm,gic-v3";
>>> +               ...
>>> +               its: gic-its@6020000 {
>>> +                       compatible = "arm,gic-v3-its";
>>> +                       msi-controller;
>>> +                       ...
>>> +               };
>>> +       };
>>> +
>>>           fsl_mc: fsl-mc@80c000000 {
>>>                   compatible = "fsl,qoriq-mc";
>>>                   reg = <0x00000008 0x0c000000 0 0x40>,    /* MC 
>>> portal base */
>>> @@ -135,6 +157,8 @@ Example:
>>>                   msi-parent = <&its>;
>
> Side note: is it right to keep msi-parent here? It rather implies that 
> the MC itself has a 'native' Device ID rather than an ICID, which I 
> believe is not strictly true. Plus it's extra-confusing that it 
> doesn't specify an ID either way, since that makes it look like the 
> legacy PCI case that gets treated implicitly as an identity msi-map, 
> which makes no sense at all to combine with an actual msi-map.

Before adding msi-map, the fsl-mc code assumed that ICID and streamID 
are equal and used msi-parent just to get the reference to the ITS node. 
Removing msi-parent will break the backward compatibility of the already 
existing systems. Maybe we should mention that this is legacy and not to 
be used for newer device trees.


>
>>>                   /* define map for ICIDs 23-64 */
>>>                   iommu-map = <23 &smmu 23 41>;
>>> +                /* define msi map for ICIDs 23-64 */
>>> +                msi-map = <23 &its 23 41>;
>>
>> Seeing 23 twice is odd. The numbers to the right of 'its' should be an
>> ITS number space.
>
> On about 99% of systems the values in the SMMU Stream ID and ITS 
> Device ID spaces are going to be the same. Nobody's going to bother 
> carrying *two* sets of sideband data across the interconnect if they 
> don't have to ;)
>
> Robin.

Diana


>
>>>                   #address-cells = <3>;
>>>                   #size-cells = <1>;
>>>
>>> -- 
>>> 2.26.1
>>>
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>>

