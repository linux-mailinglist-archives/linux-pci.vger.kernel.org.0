Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509E328BCE5
	for <lists+linux-pci@lfdr.de>; Mon, 12 Oct 2020 17:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389450AbgJLPtm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Oct 2020 11:49:42 -0400
Received: from mail-co1nam11on2066.outbound.protection.outlook.com ([40.107.220.66]:37233
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390018AbgJLPtl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Oct 2020 11:49:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Emq6y+9fGFYqQjo8cW4//vOdekV+NaOsT0DXlDsUp/HsKBefV39tvd3ZH2r0hlSJwgctfsvP2UPdjC2mO561pMz7zi+Uinm91RkveJ4jAcQHzK6dxTZwyBa3tOO8bEYCUIlLol7kcR6YR6AasNiN2/jgbMFdSGJ7oh6I2fMnVYXpFTisKHZtzRthXD5ipHPOeU5h/Cqaq+mbM/97E4CxhJtFMoDhIVzQW9jOlq9vh2dn719r3M0ZNANxq1szzrZlaFVnswQ57xI8T7VT/lbtilSVZONEg8GAfXocOlg0VefX30i+gSGw7Vby0mHCVOupS960AOL9eK/UbvvhwjF4eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xQyYKRZq4umIufLLPOjgLlhyCQfDmR99n2dkmFuGY0=;
 b=JGuBp1J6dgy9bE6k/2Np042KDsWPRP8wqfz+J5Gi2pk0KcTxEguEyfPYJ8DSycToVEyARvXo2L1xYXrcQUhdxZ+ikM6xrAFBDTtiK+qXxxoQOwRUADJzacCL909KQ5LiLTT9nvbcIoQ1FgN4rP9ptxo5Ds9cWelmocBZnYPfpwUrqA9A8+o2l4YBQGoARFBkGUKjKiOSqltAZyA2ssMN3c98SCsZQvLlW+/LDlXC8LRt5B5/TIoq+86fJp0QH9RjVaR1o03EQO5A5UL+z8QVwQqz+4606is5G0Gx5ErdlsjmJS9FheqfG3UngcnYEDVzFBdUDnV8zKf+9/UzVD98Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xQyYKRZq4umIufLLPOjgLlhyCQfDmR99n2dkmFuGY0=;
 b=Qa7pw9j1o3ESw6tq4t9ZwJUk3QsaB870epLkA/Tv4O6XZYNc30sqIVKf+0SkB0OrOadQp4htqdMe855W9iOk7BbvB2qHREjWR7OEMtIwg77qBhBOnBzdztWs1fclMEIpPZpO2ACBFWlcRdod50r45WEeiHQ3NSdEoW9bB5n6mtE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from SJ0PR11MB5120.namprd11.prod.outlook.com (2603:10b6:a03:2d1::13)
 by BYAPR11MB3367.namprd11.prod.outlook.com (2603:10b6:a03:79::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Mon, 12 Oct
 2020 15:49:40 +0000
Received: from SJ0PR11MB5120.namprd11.prod.outlook.com
 ([fe80::c048:b134:f828:e40]) by SJ0PR11MB5120.namprd11.prod.outlook.com
 ([fe80::c048:b134:f828:e40%6]) with mapi id 15.20.3455.029; Mon, 12 Oct 2020
 15:49:40 +0000
To:     linux-pci@vger.kernel.org
From:   Chris Friesen <chris.friesen@windriver.com>
Subject: PCI, isolcpus, and irq affinity
Message-ID: <83d03f27-d92d-1b28-ad28-cbe5d011fe33@windriver.com>
Date:   Mon, 12 Oct 2020 09:49:37 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [70.64.84.123]
X-ClientProxiedBy: BY5PR17CA0069.namprd17.prod.outlook.com
 (2603:10b6:a03:167::46) To SJ0PR11MB5120.namprd11.prod.outlook.com
 (2603:10b6:a03:2d1::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.25.39.5] (70.64.84.123) by BY5PR17CA0069.namprd17.prod.outlook.com (2603:10b6:a03:167::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23 via Frontend Transport; Mon, 12 Oct 2020 15:49:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48190393-e5c6-4491-8a21-08d86ec66dc4
X-MS-TrafficTypeDiagnostic: BYAPR11MB3367:
X-Microsoft-Antispam-PRVS: <BYAPR11MB3367B249B6704A454D3D5C64F6070@BYAPR11MB3367.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XeSt3cpzfJuSb3x5HekkscjEhxQmAv4HH+Ul1T6UHW7Dr0VyAR89DM/vVgES5ouSlnAqi6/r6GS32+cAaQo1ZhVT/TMX4WqtbD5dlZsctago2movC7whsamaLVWoHFpxF/zsEm+4/VWcPf2yPFQqofInhwyI2UPkEcYnpbriVxyVp/K8uBVqxwHx70FPoDcPFgm01pL2GQHJjSzQOyy/FTwVZer3lwlJKw9U/0UpYoCJoV2y7bX7DjIHyWYdehvBV0evmke8/Dn8ly6OKS+Dj0OueBqBJ+FE3v6LkEjdyxLTT5T1oe3qSp2uNukq0GKOwstVOm472kVcQtKrsyF75BEsEcgmzTAKABVz0iTt8gs6PqBTCydifViqJrKBNw+36fKDaaCGQsZpyN2PGGTpffHU9Y8sb5q3tk5tcr0/Vh4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5120.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(39850400004)(366004)(136003)(16526019)(5660300002)(478600001)(186003)(966005)(36756003)(66946007)(2616005)(52116002)(66556008)(66476007)(16576012)(956004)(316002)(6486002)(86362001)(44832011)(6916009)(31696002)(8676002)(26005)(83380400001)(8936002)(2906002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ml3jljlVCzHTKTnSDqIuig0LD8c61UK/yVIuTUJOaN7DiifedvtqWhe2p3vyB3bRUA/xfpJpvGC6sO2wrLQKJMUBGzIC2xRj9ask3ZUet7gHTpvgDDFcYRmqpPuE2mrYg189rCXuGtfVfjhuO+4buPig4zST9pwsXt/2AX6ZS6McBhMqWOQn3UL2JEIgh7Q0t6NxwOm/J2CpRn+drcXAJVhUcfLopnF+vFSa1PuRLMgSdFT3bQZn4vbNE7F8Jx8mAEeRXX0ZTk/iB9fjGLDw9C73AzkgNnHjQUOWmj4jFwy4TwchcE+jjzvHdoHndMuNBWIeEvZQCL8ErexKRX8TAKCy2G4Spk3NkR3SkytnX+U9G+ACK7ZxV1BAyYZvYcO4LOjFKKJEHPgKCO3GOpnWCfUAeFcXj9IiVJz4IWc5Q6FfgmdcsGQ34SHncbTbfztSVFC7ok6X7Tdd6WQkWYs+SXrGDZ3yGDYGdoMS4pQ79uZ6+z4tuJuy8TMXWO0JFrfxGcFRU2dldVJDLtu1e9Mo5Lu7iq1+SXoVr3kyC5CqWUbeaQTpgQca8RqTWlGYhePrfFKxTC5SKpU0irtDG2/IPhy41AlLchi6j2VAk048A+e2syn+gOGoIWyms/nPGoGY78i1mQAOp7tv7uwtFpsehQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48190393-e5c6-4491-8a21-08d86ec66dc4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5120.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 15:49:39.8635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aKhPj8NhRtte8/oNJlUV4J0q49PVhq/YRsPmhhG697QMz6HDN6DMQgMgejfuGTCSaqezqVG0NSD+9BDT1+G52Pk2io4Hx4hvl2sJ96XcR9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3367
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

I'm not subscribed to the list so please CC me on replies.

I've got a linux system running the RT kernel with threaded irqs.  On 
startup we affine the various irq threads to the housekeeping CPUs, but 
I recently hit a scenario where after some days of uptime we ended up 
with a number of NVME irq threads affined to application cores instead 
(not good when we're trying to run low-latency applications).

Looking at the code, it appears that the NVME driver can in some 
scenarios end up calling pci_alloc_irq_vectors_affinity() after initial 
system startup, which seems to determine CPU affinity without any regard 
for things like "isolcpus" or "cset shield".

There seem to be other reports of similar issues:

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1831566

It looks like some SCSI drivers and virtio_pci_common.c will also call 
pci_alloc_irq_vectors_affinity(), though I'm not sure if they would ever 
do it after system startup.

How does it make sense for the PCI subsystem to affine interrupts to 
CPUs which have explicitly been designated as "isolated"?

Thanks,

Chris


