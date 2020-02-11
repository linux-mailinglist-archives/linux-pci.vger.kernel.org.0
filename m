Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3A2159029
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2020 14:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgBKNnX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 11 Feb 2020 08:43:23 -0500
Received: from mail-oln040092254033.outbound.protection.outlook.com ([40.92.254.33]:6056
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727923AbgBKNnW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Feb 2020 08:43:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XpB1JGHP3Fcj135cX+VGQ4hy+bgC0q6o4k3Hq5s96TmZV2Bubu1FeWuRU+h1PTuN6ruDjRbLe/KsdffRCdZUwhYlwLIgQ9C/Scx1TWahJ17YzrGsKO+B8dDlzKDdlYtvXx+Y9nnt8kDqMf+/F158dBt8j2DFmyMnir3ijrtdBDzBUn2E6XQ6tGmrv3gVf9Rz8Qg9x+3rmvH/7SDe2DrXmoMhUWJMkQLmxJDVUpte8Fr3aJdzQFdQcigcasPlDBC9PZQHZUPhxqbz38cZD+mZZVeqgAlTbioOjZ2w7u98vNzW2DWR88PkR+VtDOxefzlIgTxSLpmLo/uVQgeg/pe6Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6VUTildx8l/Zv4yi/TMz+PTjiY6j8cWm/0vIlYC6+U=;
 b=iCRg2yyzX+Wv84YNY+1DMbUubW7adWaip0lVQ2JaYJYEsAUfaXbdRKNixYy5ZbcA1rjj94HkNqaCApYNE4xe6NJb8tHMegLpgKiKQwLB7ZvvEPGfTrPNH5ZQiKJ1BSut8UnevMRnPtGxDTVEKIoVJqKz0PDZKhZpcPY/lAzW/m1OwUNoJhaDy5JmMofRiQlrGHIsmDmJfP60QzBQzELii3YudK0bgrSjNlyTjqGDnzbiI0e00DH7WRveBmlh0daPXH+W5ykA3s61rHt818PMRRPSLsiJ9tYhdAO9MC1wdDiBKh1vhcT5tAfaKnyXwruGiEkjk8EmfGPK8X05iJ9wfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SG2APC01FT028.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebd::39) by
 SG2APC01HT004.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebd::207)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21; Tue, 11 Feb
 2020 13:43:16 +0000
Received: from SL2P216MB0443.KORP216.PROD.OUTLOOK.COM (10.152.250.53) by
 SG2APC01FT028.mail.protection.outlook.com (10.152.250.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Tue, 11 Feb 2020 13:43:16 +0000
Received: from SL2P216MB0443.KORP216.PROD.OUTLOOK.COM
 ([fe80::4c76:e74d:70a4:5a94]) by SL2P216MB0443.KORP216.PROD.OUTLOOK.COM
 ([fe80::4c76:e74d:70a4:5a94%11]) with mapi id 15.20.2707.030; Tue, 11 Feb
 2020 13:43:16 +0000
Received: from nicholas-dell-linux (2001:44b8:605f:11:6375:33df:328c:d925) by SY3PR01CA0139.ausprd01.prod.outlook.com (2603:10c6:0:1b::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend Transport; Tue, 11 Feb 2020 13:43:14 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Yicong Yang <yangyicong@hisilicon.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        fangjian 00545541 <f.fangjian@huawei.com>
Subject: Re: PCI: bus resource allocation error
Thread-Topic: PCI: bus resource allocation error
Thread-Index: AQHV4McmJYx6aq+dvkSE1wcW3LemFqgWANOA
Date:   Tue, 11 Feb 2020 13:43:16 +0000
Message-ID: <SL2P216MB04433D05965A7D1C0E6A4BD680180@SL2P216MB0443.KORP216.PROD.OUTLOOK.COM>
References: <f0cab9da-8e74-e923-a2fe-591d065228ee@hisilicon.com>
 <2e588019-0a42-c386-7314-e1cf5dbc3371@hisilicon.com>
In-Reply-To: <2e588019-0a42-c386-7314-e1cf5dbc3371@hisilicon.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SY3PR01CA0139.ausprd01.prod.outlook.com
 (2603:10c6:0:1b::24) To SL2P216MB0443.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::12)
x-incomingtopheadermarker: OriginalChecksum:75CDB79608FBFEA7E87124316DC34A87E947B4816BAD881C70E058089F36677E;UpperCasedChecksum:2EE28D7AFBFCD26CC5C3646D1742A31EC868C60DA4B322DF5B995640908001B3;SizeAsReceived:7773;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [2yAPRiNuQ9dfc5RxPWazrtihGWZMR+/TQUzjTut+AZqvQSfvDHUOl+IsrzdGhXeO]
x-microsoft-original-message-id: <20200211134307.GA1788@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 2cece60a-2f30-4337-a596-08d7aef858d1
x-ms-traffictypediagnostic: SG2APC01HT004:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lpPrCLJHGVBxeT3DBBJehvd/9MBWcxuEojhh76uuLXxj3WJXvse/EPm/pZyno4l2mfIYyHm1yLqjPqy9OYDU05q5T41yUC7cyz1gZj/SMyzzkMAS/gdWIUp3jIB/4kevsG7ddrdsq03NP8PjGTMx5dlseO4q61giE7e4sQNeuKFdvXPifJYlLCMsI4T+N+8uIFapLDkVtkn+xujKckC4lZwuS2aKmJsW0v48+Gvjlto=
x-ms-exchange-antispam-messagedata: 67PFEk2ti4jZKU7MBUmrnnMmM0T7LXRqYBc62SOgKfj5lwy/IjeIsZnoYjIjjyJbOFWxFG0ob/lMau07q11UV1Hd1DV6erI+hPRC89GuqPfqnVi/ebVtU+FtXoZGpVfFjVy8LpPs9h8AD3eZHYMKUPEZWyH5IyUjI+yL2raDwIuV1GGaAamuop6jiwqfQClxj9m7gGyYRUJFRpm0/DMFfg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6E21D8B11FCF77499C738619CAB71C7F@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cece60a-2f30-4337-a596-08d7aef858d1
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2020 13:43:16.7898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT004
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 11, 2020 at 06:36:42PM +0800, Yicong Yang wrote:
> Hi Bjorn and Nicholas,
> 
> Would you mind looking at the this and help me with the issues?
Sorry for dropping off the radar, I have had a lot going on.

> 
> I reproduced the issues on another machine and pasted the console log along with
> the lspci info on https://paste.ubuntu.com/p/5VHVnKWSty/.
> 
> As it has been a long time since last mail, I briefly illustrate the issues below:
> 
> There are 4 functions of a network card under one root port as below:
>  +-[0000:7c]---00.0-[7d]--+-00.0  Device 19e5:a222
>  |                        +-00.1  Device 19e5:a222
>  |                        +-00.2  Device 19e5:a222
>  |                        \-00.3  Device 19e5:a221
> 
> When I remove one function and rescan the bus[7c], the kernel print the error
> message as below:
Why do you need to remove and rescan the bus? It is possible that we 
should be addressing the problem of why you have the need to do that in 
the first place, rather than why the rescan does not work.

> 
> [  391.770030] pci 0000:7d:00.3: [19e5:a221] type 00 class 0x020000
> [  391.776024] pci 0000:7d:00.3: reg 0x10: [mem 0x1210c0000-0x1210cffff 64bit pref]
> [  391.783394] pci 0000:7d:00.3: reg 0x18: [mem 0x120c00000-0x120cfffff 64bit pref]
> [  391.790786] pci 0000:7d:00.3: reg 0x224: [mem 0x1210d0000-0x1210dffff 64bit pref]
> [  391.798238] pci 0000:7d:00.3: VF(n) BAR0 space: [mem 0x1210d0000-0x1210fffff 64bit pref] (contains BAR0 for 3 VFs)
> [  391.808543] pci 0000:7d:00.3: reg 0x22c: [mem 0x120d00000-0x120dfffff 64bit pref]
> [  391.815994] pci 0000:7d:00.3: VF(n) BAR2 space: [mem 0x120d00000-0x120ffffff 64bit pref] (contains BAR2 for 3 VFs)
> [  391.826391] pci 0000:7c:00.0: bridge window [mem 0x00100000-0x002fffff] to [bus 7d] add_size 300000 add_align 100000
> [  391.836869] pci 0000:7c:00.0: BAR 14: no space for [mem size 0x00500000]
>                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> [  391.843543] pci 0000:7c:00.0: BAR 14: failed to assign [mem size 0x00500000]
>                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> [  391.850562] pci 0000:7c:00.0: BAR 14: no space for [mem size 0x00200000]
>                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> [  391.857237] pci 0000:7c:00.0: BAR 14: failed to assign [mem size 0x00200000]
>                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ 
> or the machine in the pastebin prints:
> 
> [  790.671091] pci 0000:7d:00.3: Removing from iommu group 5
> [  937.541937] pci 0000:7d:00.3: [19e5:a221] type 00 class 0x020000
> [  937.541949] pci 0000:7d:00.3: reg 0x10: [mem 0x1221f0000-0x1221fffff 64bit pref]
> [  937.541953] pci 0000:7d:00.3: reg 0x18: [mem 0x121f00000-0x121ffffff 64bit pref]
> [  937.542113] pci 0000:7c:00.0: BAR 14: no space for [mem size 0x00200000]
>                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> [  937.542116] pci 0000:7c:00.0: BAR 14: failed to assign [mem size 0x00200000]
>                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> [  937.542120] pci 0000:7d:00.3: BAR 2: assigned [mem 0x121f00000-0x121ffffff 64bit pref]
> [  937.542125] pci 0000:7d:00.3: BAR 0: assigned [mem 0x1221f0000-0x1221fffff 64bit pref]
> [  937.542253] hns3 0000:7d:00.3: Adding to iommu group 5
> 
> Both the function and the root ports work well, and the function get the resource it requested as before
> remove. So from my perspective the message shouldn't be printed and should be eliminated.
> 
> I looked into the codes and got some informations:
> 
> when echo 1 > bus_rescan, kernel calls:
>     pci_rescan_bus()
>         pci_assign_unassigned_bus_resources()
>             __pci_bus_size_bridges()
>                /* first try to put the resource in 64 bit MMIO window(Bar 15). 
>                 * As it's not empty, function will return directly.
>                 */
>                pbus_size_mem()
> 
>                /* Then try to put rest resource in 32-bit MMIO window(Bar 14)
>                 * As it's not occupied by any functions, the resources are
>                 * put here. As no io memory is reserved in the bios for bar14,
>                 * error message prints when allocated.
>                 */
>                pbus_size_mem() /* problem is here */
> 
> In pbus_size_mem(), kernel try to size the bar to contain function resource.
> If it's occupied by any function (judged by find_bus_resource_of_type() in
> pbus_size_mem()), it'll return directly without any sizing. Otherwise the bar
> will be sized to put the request resource in.
> 
> It's just a rescan process, the bar size shouldn't be sized or allocated by
> calling __pci_bus_size_bridges(). As previous resource space in the bar
> reserved and the function will demands no extra spaces after rescan.
> The current process seems unreasonable.
If the BIOS assigned the resources with different packing than what the 
kernel would do, then the rescan may not fit into the space. You can try 
pci=realloc,nocrs if you have not already. Your system looks like it is 
ARM64 so you cannot use pci=nocrs, unfortunately. The ideal situation is 
if the kernel throws away everything the BIOS did and does everything 
itself (assuming that this will not cause platform conflicts). But there 
is no way of doing this without modifying the kernel, and I am not sure 
how to do it fully.

However, I have come to find that the code in drivers/pci/setup-bus.c is 
very old and full of holes. It does require a re-write (in my opinion, 
and some other people have agreed to some extent), which I want to do, 
but will need much more experience before I can pull something like that 
off and get it accepted by others.

Unfortunately without the system in front of me and the ability to make 
lots of changes to the kernel very quickly to find a fix, I might not be 
able to figure it out.

> 
> Thanks,
> Yicong Yang
> 
> 

Regards,
Nicholas
