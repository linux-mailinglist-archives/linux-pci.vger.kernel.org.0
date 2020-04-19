Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0171A1AF9AD
	for <lists+linux-pci@lfdr.de>; Sun, 19 Apr 2020 13:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgDSLq3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 19 Apr 2020 07:46:29 -0400
Received: from mail-eopbgr150074.outbound.protection.outlook.com ([40.107.15.74]:8969
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725841AbgDSLq3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 19 Apr 2020 07:46:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlfbFJYWpXydcxrrZg13xmTLzlo1iJjJQVAcYYeUPayMEgPEutPI7tMm1FTS9Scg9hrDJgHc2kyzltVLg1+Ji+heNCba+qBhWXn3VyPJuVaE9AJebwuPd/yp3M+iS7Hxa+j033O71MM/wK/pB5xS+ve/4GaUfJAGwa7MdPmCIqNk06Jyu4DIRU2KqmhYbE4vSOT+9vwGDTDzpQQUgnmJFdKvU2DDc1gJsPB2sxgYB0UuvS2/++vTLcXWgjcOHxYmTYPEfgztYAEyWoWrrGaiYmBbw1LxegyBKgP7Bg1T4stk1vPEXKwBYBgTylUzPJ4O5ZjiaSBjLlkPTNewqloJcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APESdKDqPdl4xOju0+rN2vLGG/1VsoTDNWDVrt93onA=;
 b=g34BX39hlJaSzeF6nMMk1UILEMkznQGk7R9KZ5lHCAU1KPx31IGLirRyxGgvA+T9Cxp8I2sZiswZrYQooRlut+Y4Z108/y2upuVex8Pg784Ux4C86VDl5KODFJcR8twAe3yad13xpK/PBdz5Idg0V4ydbvhH1r6z1fVMDXrSr31u21UeaXYKkfhaqj5YnN0njzfybtxkmG9qD6XwwuJYXpo30EtBHLefFXarAn4UOC5TlxMSHtlWvgO3hg2MiQHRlQ0dDSBzR8ic4Y+uolgqJNCMPQJAJCVYFDwH439A5e10N+wrBP+gov4xch77KBcgLdCM+NTBgqAPq1SzaYx1hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APESdKDqPdl4xOju0+rN2vLGG/1VsoTDNWDVrt93onA=;
 b=I8KI8IPIf0qaCNRh0E+1hlQXqGml3vZ6LjODmmlZrtZJA9ojkzNgXAseiVxv8Bn46V+WD7UI8xZ3NtzwLx22Ik23XGu5QeBLUDtL1XPR8LX0P41vkmFCL9b9wMPeBRPolAowz4ilIlTMdI3yG8SdNZWItK8wrsvGtewnf08qX3c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=maxg@mellanox.com; 
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB5746.eurprd05.prod.outlook.com (2603:10a6:208:111::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Sun, 19 Apr
 2020 11:46:25 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.2921.027; Sun, 19 Apr 2020
 11:46:25 +0000
Subject: Re: [PATCH 2/2] powerpc/powernv: Enable and setup PCI P2P
To:     Oliver O'Halloran <oohall@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-pci@vger.kernel.org,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Carol L Soto <clsoto@us.ibm.com>, idanw@mellanox.com,
        aneela@mellanox.com, shlomin@mellanox.com
References: <20200416165725.206741-1-maxg@mellanox.com>
 <20200416165725.206741-2-maxg@mellanox.com> <20200417070238.GC18880@lst.de>
 <7255b11a-4ea0-3bac-2cc3-7fff0b56c9ac@mellanox.com>
 <CAOSf1CHdepTVZUE0=H0P3vLTY820wyiLGuKM_qOjv9kguS3Zww@mail.gmail.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <beef6318-ca4d-10c1-cb08-1de06e484a8a@mellanox.com>
Date:   Sun, 19 Apr 2020 14:46:22 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <CAOSf1CHdepTVZUE0=H0P3vLTY820wyiLGuKM_qOjv9kguS3Zww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR05CA0077.eurprd05.prod.outlook.com
 (2603:10a6:208:136::17) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (217.132.177.164) by AM0PR05CA0077.eurprd05.prod.outlook.com (2603:10a6:208:136::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend Transport; Sun, 19 Apr 2020 11:46:24 +0000
X-Originating-IP: [217.132.177.164]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d09f1c07-009c-4318-67d9-08d7e4574a48
X-MS-TrafficTypeDiagnostic: AM0PR05MB5746:|AM0PR05MB5746:|AM0PR05MB5746:
X-LD-Processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB574616D16A0EA5B0631C8246B6D70@AM0PR05MB5746.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0378F1E47A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB5810.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(26005)(2616005)(956004)(52116002)(16526019)(186003)(66946007)(6486002)(66476007)(8676002)(66556008)(31686004)(6916009)(2906002)(5660300002)(81156014)(36756003)(4744005)(16576012)(478600001)(86362001)(316002)(8936002)(4326008)(54906003)(53546011)(107886003)(31696002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NoBIzhYN0pB75TyQwIQ7enBrnSk7RcHxYbQgK5EjaLu07ynmJG1IGR3h6B5PpCSgt8mpYLJtzrVL6htnoB5C2+jSMPejyZGgf3xKG92UxkeB8SbZAMLSp9TM5d4yO8kOSRZnu9k28bx5XFkRtc0DHeV6LYfstUfeFWLPZ5w6tygmoIv4bPG2IkWiguZbESPIaV1wdOu9bw4/7Q9gwyQ7mY1J69nFduAFA557U/FsUH5R0l7GTx4OAkgX41XpDDA/TzvrzEPVQLJNnTwQAwvE1ubnS4xdTQ6Wiz6HHpO1aSP0adTJWW46O6YGh99aqd0HV/q1Yq3ELVmF47xxjBKzIbELTrx6YCMWWlYZhvwCBaelsoXFXEeNeDBs9QHn5UK9U7Iwegx23judbT2rJj9NOPVmkdg3gyuHjhwkC1z9dzXqNJHFWLwLs63k0zcQfMyH
X-MS-Exchange-AntiSpam-MessageData: KpcCFj0DSsgBgePnuU9PCOmz/wLkKUKNyO2SnTi6JT+iFYxfV+2Xdjc91EVJ9TNPmA6YB0As192fHwj30x+PIQ560x/GkN7O17ZmRG0VAPuVw7jcL6ZxM3+EpNq/kI2zX7JWBwItXpgY1zR1M0OvDAA4XsJf0whlltGIigpM7z6kn3zNNTv/HvYits/0Ce1GZJatAb8LR3n2hFu5ocsXeHmKBTWV2OlNXSVpNFoq0Q+SoRusaITSfXGReE6kSsCJlH0/u0jcDlH0JC3DFkvR/BUOy41WlaCvwvwfZzZ0WDYbNXmRPntpPc7mlEndh8Exk96IBeVjbHIe9TkCLffpo8K7SWKfLTGz4FbLNl1xxg76+xqCe7rUpqViRUAbJcq1DOlw9FBtZONKvQcfQzSc7qgGEpLu2lF55b1gt9lCCP/RPpJGUQxGV4LcY5csdkSBcAdJw0BBPixhX4N81UkKF+h2lXIcMyf0ltChKbmKEssJtahXT5PdWlhYLKHjMUO+wvvlEPkSjvPbueOneD6jOU3jVkHLNQI+djBeXOHr/vLC790mItY+n7u6eqIbJQ1TbrMMlDLHqBYfkfVkTFiAq/y6tjRqN8YXJU25FGSNM7qH1mPuGkINlmmGkG6Ej4vESSFiGRSbW80RWlnV9iubeZyCXai5nPcu+rdElPfWPoPhd9oNqeqGrnJx8wnMzGRhQ+a0s2Bqdwu70HqxQUXDlbPVo+IWivbaWqcrPHJriyfdGr/KpY6gJcpT0+tveTXKKFll0IaX5G5Ja8F/dNN1/kYb9CfPqDb3ExCRiacz6l2gm9Rtup4LSpD7prLE5ntE
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d09f1c07-009c-4318-67d9-08d7e4574a48
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2020 11:46:25.8090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mfYyrKvfy+1ttqOwZKfMy1k0/FdMdSRpjFuTzbWDiunLwE44A7XyRGghtiIEIfhutbWhyCkUFjj6/6eCFDM5Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5746
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 4/17/2020 5:04 PM, Oliver O'Halloran wrote:
> On Fri, Apr 17, 2020 at 9:17 PM Max Gurtovoy <maxg@mellanox.com> wrote:
>>> The enable and disable path shares almost no code, why not split it into
>>> two functions?
>> how about also changing the defines OPAL_PCI_P2P_* to an enum ?
>>
>> /* PCI p2p operation descriptors */
>> enum opal_pci_p2p {
>>
>>           OPAL_PCI_P2P_DISABLE    = 0,
>>
>>           OPAL_PCI_P2P_ENABLE     = (1 << 0),
>>           OPAL_PCI_P2P_LOAD       = (1 << 1),
>>           OPAL_PCI_P2P_STORE      = (1 << 2),
>> };
>>
>> Fred ?
> I'd rather you didn't. We try to keep the definitions in opal-api.h
> the same as the skiboot's opal-api.h since the skiboot version is
> canonical.
>
> Also, generally patches to anything PowerNV related go through the
> powerpc tree rather than the pci tree even if they're PCI related. Can
> you make sure you have linuxppc-dev CCed when you post v2.

Sure, no problem.


>
> Oliver
