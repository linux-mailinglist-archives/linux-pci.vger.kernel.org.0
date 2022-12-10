Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE2E64900C
	for <lists+linux-pci@lfdr.de>; Sat, 10 Dec 2022 18:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiLJRqM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Dec 2022 12:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiLJRqL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Dec 2022 12:46:11 -0500
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD2613F90
        for <linux-pci@vger.kernel.org>; Sat, 10 Dec 2022 09:46:07 -0800 (PST)
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BACrqGv023681;
        Sat, 10 Dec 2022 09:45:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=zG6zAWyWR2SWmWVv5MdIdO919fO0AVWjWfnNg/j9mv8=;
 b=MAZNQrVHjVgaNeS7rYFHXf2r+lQ11F26wCzV/0WHw0EENVCnpKA6btWa+jn/B7tW2nLW
 iBAqCHF7CXBP7vq8FCNv0WGYOXI3Fes5IJlTCn7dVOm20JHzNevBis60PLT9DxbNX7ks
 RFKhZCRkWiFmZBupToAmJMFCkgevinthIT3aLmeJ8OnFcEb1b86Lux4/L2UQ+nz2tt7e
 IJ9UbEyHC8e1kieLrJb5wqZFEQZ+r2F44Sbn68jh7QXpdJFYSx2JEk4XUChmCObwHP6t
 FpagUEAR52TK1HuNrejxs00JW1ps+y8Icn9/Lh+xeVfdOzkd0vSF+7hUYALpIvkpyIX8 DQ== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3mcth4rahr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Dec 2022 09:45:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f35FmegPTUAzatT0xOJkx3Tv4LdvMCTXMtp9gB8nPkqZBMxHuhtDW3C0bSYP8wWaeG9GodQ/2dHOmHBexYS7+lVsl0h6QsshHpNle/zOqv5mfgyk8MiOhEN7ZBM9hvLBs/VhcFREOg3bxSX5iLZPG28u1b4p9sQVfBL4TXAUB91x2dDjgl8Pu+Zr7M9WS04l63NqLrHeXJd+OiNr95Ol+BvyeJn+HTQFg0WpUrmbjJB52HQ8xwFC5wvTnj8lS+N+cLI8ex+ykhsYaHNawPfe6BEI9JKJdNPislxwAJnHrfJLQ/48Alo51NwiFio2ZBSmLQoLncsYRmWRDgunbBbAcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zG6zAWyWR2SWmWVv5MdIdO919fO0AVWjWfnNg/j9mv8=;
 b=b43C+WJM8YSZg7DMaR8Bistb2ugf1flbovxAP4VTTYsQvr5ShIkzLp5ig2OMJjheIU9Ag+IOqfl0nO4rI/aY5bVTK4fhwNwULt8OGs9eXeeu3welWfl0Q49TXkuAr0hyn/+DjBi+ayyv3LMhp07J5ksMPJgo68/6Jf/wpxUK5ZBmUWdThqeLS88joiqXx7BqW6U1nxc2ioXlw+GHhloiAGXGHJZsaJZiNxO1m5Ev2spVdyvP7/7Q7OitdGQJrNByOMLBWUn8shxpVkv6TzQ9lTT7oCtn7XCjheFZybwZTDfoltHLaIJrsBTdii8mcz0DKCZKen1VWx/TdRXc1k0DZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zG6zAWyWR2SWmWVv5MdIdO919fO0AVWjWfnNg/j9mv8=;
 b=p656v2FVdDBe7v0+Y8JvY3snpeA797zEBj2Wk+JwSODJ3+SZpNmiDWgjqHQeX9x4zo95QQeByrBuyAupftQQMrWGfoqm7aTGR/hydrf9J7NbxC+BcIe39fuLmsk2I6FY6cZ2p2JEDFMuxg5SDSyT81nniJlEh6JpNXX2Mc++mkS9S+elMmlL+oL1Fsj9a6qvokyE9dVhyte94TbI7rTAGV3pjT6fPP7pE6pZcTYx3BatSGKRkDFQogpgFfI/H0uvo1BCIRXeX2XioyzN/XeYUUMhP3VcBzzybv2DqAzRS1EO/89UpC1g/NR95Ioh3fhbT/GXHeby5cS4Rtfe7NqaxA==
Received: from BL3PR02MB7986.namprd02.prod.outlook.com (2603:10b6:208:355::19)
 by SA0PR02MB7161.namprd02.prod.outlook.com (2603:10b6:806:e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Sat, 10 Dec
 2022 17:45:51 +0000
Received: from BL3PR02MB7986.namprd02.prod.outlook.com
 ([fe80::446d:8a7c:9ae1:1b4c]) by BL3PR02MB7986.namprd02.prod.outlook.com
 ([fe80::446d:8a7c:9ae1:1b4c%4]) with mapi id 15.20.5880.019; Sat, 10 Dec 2022
 17:45:51 +0000
From:   "Kallol Biswas [C]" <kallol.biswas@nutanix.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: uefi secureboot vm and IO window overlap
Thread-Topic: uefi secureboot vm and IO window overlap
Thread-Index: AdkL/kAMfOYsiVCGQGy3hYquUACg9wAEm5qAACuQL0A=
Date:   Sat, 10 Dec 2022 17:45:50 +0000
Message-ID: <BL3PR02MB7986DFD09C363B691D7EF194FE1F9@BL3PR02MB7986.namprd02.prod.outlook.com>
References: <BL3PR02MB798651506589044302A23DFAFE1C9@BL3PR02MB7986.namprd02.prod.outlook.com>
 <20221209205617.GA1732532@bhelgaas>
In-Reply-To: <20221209205617.GA1732532@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB7986:EE_|SA0PR02MB7161:EE_
x-ms-office365-filtering-correlation-id: 9ee7dd32-902c-4dd8-8ec6-08dadad660dc
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kn9Y7WlZcdz6UG7YKkKMFF3SssB0gNXX3LpwzV7bkr8djpCPWpXKGkdBgydKVQn0OVJjxmEQfbMrYtqhbdoQDGoFIstHf+Wknjl3te2wgYvW83FufA2TlCz/AeDCBmYAfkxV3GV21p6sSrrrLrXW/CHzZbtG4MfrrM/A4pKvopGUnCPxhhDtH+V0wZytbDkpFVx1VfsGWQ6faoQFP5K5Ou/fISMYBwlA2sMlATBi+h5kZKCKtP5JCfyoCYY1hamuiHE3i0CtEj/uy29os9bzsZzr8FudhTCKFHtTnAWTlt9jkw3g9nZ1JHTDymkN8NifO1QrdXT0Owoyq6YyHhyi7Dgx7Nmvo/Dj+Yy/lhx06oHhOIEKmEyBQe2BJ22Ted1ngV+W3jFxBW/e7xPGekph3oPPovm16t/ePM0fbmVU5DM5e8UZaMONbxId2u5m3A2ZY/h9bkg6mkgNHhUiIP7u+2DH5VdZVvXm4JGuLlmqghMxqyvYl6cCyoXX/wd0NzR5Kg+TvMMiPnxSwAh5cYoyvNlEEkeOlIdpRiAxpMh/MLwIE3OUX5um8iayvCzSCneqjSK87XZHAtqY3MEm21SDtAgXkILQ/tsVv8IpZXFGXw/Vq+Luc6qBe00Wn7j8moqkSX8XoJSvLUmgWFLSyS+DeKPa4FLeMO1bUKGWFEp4uGOd+ptwsTVM7vWHhueRK5dTWEWc4ZHbOHRreDXtjDXSpC21+kmys5WTRMP6HpURnD8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR02MB7986.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199015)(33656002)(38070700005)(55016003)(41300700001)(8936002)(478600001)(71200400001)(52536014)(86362001)(122000001)(38100700002)(5660300002)(53546011)(30864003)(316002)(6916009)(64756008)(66446008)(66946007)(66556008)(66476007)(4326008)(76116006)(8676002)(186003)(9686003)(6506007)(7696005)(83380400001)(26005)(2906002)(579004)(559001)(505234007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RUFrji6sKe0t+mW2jZWS8OtrynSxvWL63r92P+SM9kX9WPqlT7Myr/fPe4?=
 =?iso-8859-1?Q?aBMlxKW5YJKqLb2gD03BzI5GesobcSXeYOHKrgKaPFTGV4xJ/Zba53K0SE?=
 =?iso-8859-1?Q?sDzFP8K+ruoB77GQacTg4D6IUFw+h9mvmF1QSdlrsKm5d3ifjCHlQ3WnbM?=
 =?iso-8859-1?Q?j43BbnXsjMjZ6q/49uioHxOQjEfqxHNh2wySPF0wfABeMoi3iX0wFYK4By?=
 =?iso-8859-1?Q?MYGxxNtIorO/vKVfHFPZvsy+C+R490+ZDThBji+2cpYMWtcyXBF8LOMs7B?=
 =?iso-8859-1?Q?Dr+pYntbnE0rUkO+iZdhlTaotFWUiHcPiv1UwqwAnDn7Tqf9rNqJ7zhxnb?=
 =?iso-8859-1?Q?thbb66oUp0TJQIJBYtIqqYyXiN/euj0kUc0FYzRiwWtDDSEWwjxXXeOpA7?=
 =?iso-8859-1?Q?vNEb0IxxVf8iAMHqyeDrZ8U2dI+NuwEVWgJ09urAc52aCnmh3A42OG6d5S?=
 =?iso-8859-1?Q?H+saXCBPzMbxbjq0Dj/FlSU5n51H2xdoq5nTHEDyYHBtwyPUsTK56A8Wz9?=
 =?iso-8859-1?Q?L4hPdXOwL6TGFdqpkuYgEIptwA5D87aLpnlI2e1tyjDRvxBeex05q1vfc6?=
 =?iso-8859-1?Q?LMmDr2g3A0QXvq+CqdunmVXQyFed0k7lZHEKLjnV7aygUgwSAdmc/iIxKC?=
 =?iso-8859-1?Q?7IrwELECgnXYTEOCloJKBXqhFg9aXgIC17ZrT2Pi7DlTckgq2sQUsugLLl?=
 =?iso-8859-1?Q?5bkuXe3rZMbZEpikrMkE0ibDnujZ2+HooQgja6+k04Avhi+ZiNXEcau+bY?=
 =?iso-8859-1?Q?zNrt3Uw/kyPMbx1zscMIWWYeCo73X6OAcZShAm6q3a27ao+kUZqBDnMqOI?=
 =?iso-8859-1?Q?fJ85HPiPVrZLI6S8dJllUqfGcYK9HaDEOiNicj3p5tBtYFV6L8fRmj7iLg?=
 =?iso-8859-1?Q?LXUINKHCh6Mc/Hixi4eh4niBhTDWkHtUmm4F6nq7R0MeJnaKzQCpRrVlvB?=
 =?iso-8859-1?Q?AxbUlILjiY5emyXTmBEptHdN0I/Km/xt9Po4nhC/tlTe+0boviT+JHfN6w?=
 =?iso-8859-1?Q?xq62B9AKZwaxmonr94BM/W5rFmGHrCCbs0NKZIZ+8etR3452aQwI6Po4ni?=
 =?iso-8859-1?Q?0ahYJJE4jdXK/YYZHXvYl9j8Nlm6R6gHy0l3g064FkQ41+OTvuUkC2JpKv?=
 =?iso-8859-1?Q?z/uweGFaZJFtFr3Vg5waALF5CfOqJzueDTcd3SCmTTWPXYThUMfJXWBXmm?=
 =?iso-8859-1?Q?sJ16k3RuOPThceECSE+I6U0jES/Zwhf2j7jPtNIqWE04U9xQpwCNSbYBmP?=
 =?iso-8859-1?Q?B/gHfWs5xhwo64AfOzH3jky+/CIllapFUvq/JB/5/dA2P9q/idajOhcTGy?=
 =?iso-8859-1?Q?7/1FkayJOA7uqFZlZAOAqhDpTSQKLzdvaLwiyxQDkO8cRQeGvDGwxMcQZ3?=
 =?iso-8859-1?Q?ic7kOJZrZioqLV345xcInrhb/gOCmpue0p0gyCcVIDO41JvSN+FCtq3ME9?=
 =?iso-8859-1?Q?vXXJ/+NDVJGI5f5X4hDLJiGL6/QaQ0N4xPQTUJwxBo8/l6GtQlSCXGQ8Dl?=
 =?iso-8859-1?Q?ymY98sdH8dJu9U9EiOI8Aamfao09ZzxxX2ZkXj75LSq7ahVyKXui+A5b2x?=
 =?iso-8859-1?Q?k5yCAmYYsXuOpNPs92EXJ9NRxZPTFlQbhoh/Gn+8vYyOQDbrbDVcmPmGVk?=
 =?iso-8859-1?Q?Rj8TH5BpSstI6Q8gI3IwcowURdZwMuN/sw0BbF2T2kl7kvKSOV3Jhn5A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB7986.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee7dd32-902c-4dd8-8ec6-08dadad660dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2022 17:45:50.8801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6357wzSyudF/anDykVNbYujCr8zVhamRiqq/Fd1wKg+XSyNbUFuWeXuOhU/OxRI1Su6GuaJ6NZqf42QdbNtgk65ssb/iwr3bS+Jeq9IB3xk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7161
X-Proofpoint-ORIG-GUID: 9q7dFJqblkUbENTOhMKCji7gy4qZ9-KQ
X-Proofpoint-GUID: 9q7dFJqblkUbENTOhMKCji7gy4qZ9-KQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-10_06,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The part1 of the dmesg:

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.10.0-957.el7.x86_64 (mockbuild@kbuilder.bsys=
.centos.org) (gcc version 4.8.5 20150623 (Red Hat 4.8.5-36) (GCC) ) #1 SMP =
Thu Nov 8 23:39:32 UTC 2018
[    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-3.10.0-957.el7.x86_64 ro=
ot=3D/dev/mapper/centos-root ro crashkernel=3Dauto rd.lvm.lv=3Dcentos/root =
rd.lvm.lv=3Dcentos/swap pci=3Dearlydump
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007a051fff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x000000007a052000-0x000000007a060fff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x000000007a061000-0x000000007b0eefff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x000000007b0ef000-0x000000007b36efff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x000000007b36f000-0x000000007b37efff] ACPI =
data
[    0.000000] BIOS-e820: [mem 0x000000007b37f000-0x000000007b3fefff] ACPI =
NVS
[    0.000000] BIOS-e820: [mem 0x000000007b3ff000-0x000000007ff7bfff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x000000007ff7c000-0x000000007fffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000b0000000-0x00000000bfffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000037fffffff] usabl=
e
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] pci 0000:00:00.0 config space:
  00: 86 80 c0 29 07 00 00 00 00 00 00 06 00 00 00 00
  10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  20: 00 00 00 00 00 00 00 00 00 00 00 00 f4 1a 00 11
  30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00
  40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  50: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  60: 01 00 00 b0 00 00 00 00 00 00 00 00 00 00 00 00
  70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  90: 00 01 00 00 00 00 00 00 00 00 00 00 00 02 38 00
  a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  e0: 00
[    0.000000]  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    0.000000] pci 0000:00:01.0 config space:
  00: 34 12 11 11 07 00 00 00 02 00 00 03 00 00 00 00
  10: 08 00 00 c0 00 00 00 00 00 60 64 c1 00 00 00 00
  20: 00 00 00 00 00 00 00 00 00 00 00 00 f4 1a 00 11
  30: 00 00 ff ff 00 00 00 00 00 00 00 00 ff 00 00 00
  40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  e0: 00
[    0.000000]  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    0.000000] pci 0000:00:02.0 config space:
  00: 36 1b 0c 00 07 00 10 00 00 00 04 06 00 00 81 00
  10: 00 50 64 c1 00 00 00 00 00 01 01 00 80 80 00 00
  20: 40 c1 50 c1 01 00 01 00 40 08 00 00 40 08 00 00
  30: 00 00 00 00 54 00 00 00 00 00 00 00 0b 01 00 00
  40: 0d 00 00 00 36 1b 00 00 11 40 00 00 00 00 00 00
  50: 00 08 00 00 10 48 42 01 00 80 00 00 00 00 00 00
  60: 04 06 30 10 00 00 11 20 7b 00 02 00 c0 01 40 00
  70: 00 00 00 00 00 00 00 00 20 00 30 00 00 00 00 00
  80: 1e 00 00 00 04 00 00 00 00 00 00 00 00 00 00 00
  90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  e0: 00
[    0.000000]  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    0.000000] pci 0000:00:02.1 config space:
  00: 36 1b 0c 00 07 00 10 00 00 00 04 06 00 00 01 00
  10: 00 40 64 c1 00 00 00 00 00 02 02 00 70 70 00 00
  20: 20 c1 30 c1 11 00 11 00 40 08 00 00 40 08 00 00
  30: 00 00 00 00 54 00 00 00 00 00 00 00 0b 01 00 00
  40: 0d 00 00 00 36 1b 00 00 11 40 00 00 00 00 00 00
  50: 00 08 00 00 10 48 42 01 00 80 00 00 00 00 00 00
  60: 04 06 30 11 00 00 11 20 7b 00 02 00 c0 01 40 00
  70: 00 00 00 00 00 00 00 00 20 00 30 00 00 00 00 00
  80: 1e 00 00 00 04 00 00 00 00 00 00 00 00 00 00 00
  90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  e0: 00
[    0.000000]  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    0.000000] pci 0000:00:02.2 config space:
  00: 36 1b 0c 00 07 00 10 00 00 00 04 06 00 00 01 00
  10: 00 30 64 c1 00 00 00 00 00 03 03 00 60 60 00 00
  20: 00 c1 10 c1 f1 ff 01 00 ff ff ff ff 00 00 00 00
  30: 00 00 00 00 54 00 00 00 00 00 00 00 0b 01 00 00
  40: 0d 00 00 00 36 1b 00 00 11 40 00 00 00 00 00 00
  50: 00 08 00 00 10 48 42 01 00 80 00 00 00 00 00 00
  60: 04 06 30 12 00 00 04 22 7b 00 02 00 c0 07 00 00
  70: 00 00 00 00 00 00 00 00 20 00 30 00 00 00 00 00
  80: 1e 00 00 00 04 00 00 00 00 00 00 00 00 00 00 00
  90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  e0: 00
[    0.000000]  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    0.000000] pci 0000:00:03.0 config space:
  00: f4 1a 00 10 07 00 10 00 00 00 00 02 00 00 00 00
  10: c1 82 00 00 00 20 64 c1 00 00 00 00 00 00 00 00
  20: 0c 00 20 00 40 08 00 00 00 00 00 00 f4 1a 01 00
  30: 00 00 fc ff 98 00 00 00 00 00 00 00 0b 01 00 00
  40: 09 00 10 01 04 00 00 00 00 00 00 00 00 10 00 00
  50: 09 40 10 03 04 00 00 00 00 10 00 00 00 10 00 00
  60: 09 50 10 04 04 00 00 00 00 20 00 00 00 10 00 00
  70: 09 60 14 02 04 00 00 00 00 30 00 00 00 10 00 00
  80: 04 00 00 00 09 70 14 05 00 00 00 00 00 00 00 00
  90: 00 00 00 00 00 00 00 00 11 84 02 00 01 00 00 00
  a0: 01 08 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  e0: 00
[    0.000000]  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    0.000000] pci 0000:00:1d.0 config space:
  00: 86 80 34 29 07 00 00 00 03 00 03 0c 00 00 80 00
  10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  20: a1 82 00 00 00 00 00 00 00 00 00 00 f4 1a 00 11
  30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 00 00
  40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  60: 10 00 00 00 00 00 00 00 00 00 01 00 00 00 00 00
  70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  c0: 00 8f 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  e0: 00
[    0.000000]  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    0.000000] pci 0000:00:1d.1 config space:
  00: 86 80 35 29 07 00 00 00 03 00 03 0c 00 00 00 00
  10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  20: 81 82 00 00 00 00 00 00 00 00 00 00 f4 1a 00 11
  30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 02 00 00
  40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  60: 10 00 00 00 00 00 00 00 00 00 01 00 00 00 00 00
  70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  c0: 00 8f 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  e0: 00
[    0.000000]  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    0.000000] pci 0000:00:1d.2 config space:
  00: 86 80 36 29 07 00 00 00 03 00 03 0c 00 00 00 00
  10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  20: 61 82 00 00 00 00 00 00 00 00 00 00 f4 1a 00 11
  30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 03 00 00
  40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  60: 10 00 00 00 00 00 00 00 00 00 01 00 00 00 00 00
  70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  c0: 00 8f 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  e0: 00
[    0.000000]  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    0.000000] pci 0000:00:1d.7 config space:
  00: 86 80 3a 29 07 00 00 00 03 20 03 0c 00 00 00 00
  10: 00 10 64 c1 00 00 00 00 00 00 00 00 00 00 00 00
  20: 00 00 00 00 00 00 00 00 00 00 00 00 f4 1a 00 11
  30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 04 00 00
  40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  60: 20 20 00 00 00 00 00 00 01 00 00 00 00 00 00 00
  70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  e0: 00
[    0.000000]  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    0.000000] pci 0000:00:1f.0 config space:
  00: 86 80 18 29 07 00 00 00 02 00 01 06 00 00 80 00
  10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  20: 00 00 00 00 00 00 00 00 00 00 00 00 f4 1a 00 11
  30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 00 00 00
  40: 01 06 00 00 80 00 00 00 00 00 00 00 00 00 00 00
  50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  60: 0a 0a 0b 0b 00 00 00 00 0a 0a 0b 0b 00 00 00 00
  70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  80: 00 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
  90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  e0: 00
[    0.000000]  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  f0: 01 c0 d1 fe 00 00 00 00 00 00 00 00 00 00 00 00
[    0.000000] pci 0000:00:1f.2 config space:
  00: 86 80 22 29 07 00 10 00 02 01 06 01 00 00 80 00
  10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  20: 41 82 00 00 00 00 64 c1 00 00 00 00 f4 1a 00 11
  30: 00 00 00 00 80 00 00 00 00 00 00 00 0a 01 00 00
  40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  80: 05 a8 80 00 00 00 00 00 00 00 00 00 00 00 00 00
  90: 40 00 3f 00 00 00 00 00 00 00 00 00 00 00 00 00
  a0: 00 00 00 00 00 00 00 00 12 00 10 00 48 00 00 00
  b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  e0: 00
[    0.000000]  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    0.000000] pci 0000:00:1f.3 config space:
  00: 86 80 30 29 07 00 00 00 02 00 05 0c 00 00 80 00
  10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  20: 01 82 00 00 00 00 00 00 00 00 00 00 f4 1a 00 11
  30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 00 00
  40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  e0: 00
[    0.000000]  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    0.000000] pci 0000:01:00.0 config space:
  00: f4 1a 48 10 07 00 10 00 01 00 00 01 00 00 00 00
  10: 00 00 00 00 00 00 40 c1 00 00 00 00 00 00 00 00
  20: 0c 00 00 00 40 08 00 00 00 00 00 00 f4 1a 00 11
  30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 00 00
  40: 10 00 02 00 00 80 00 10 00 00 00 00 11 04 00 00
  50: 00 00 11 20 00 00 00 00 00 00 00 00 00 00 00 00
  60: 00 00 00 00 00 00 30 00 00 00 00 00 00 00 00 00
  70: 00 00 00 00 00 00 00 00 00 00 00 00 01 40 03 00
  80: 00 00 00 00 09 7c 10 01 04 00 00 00 00 00 00 00
  90: 00 10 00 00 09 84 10 03 04 00 00 00 00 10 00 00
  a0: 00 10 00 00 09 94 10 04 04 00 00 00 00 20 00 00
  b0: 00 10 00 00 09 a4 14 02 04 00 00 00 00 30 00 00
  c0: 00 10 00 00 04 00 00 00 09 b4 14 05 00 00 00 00
  d0: 00 00 00 00 00 00 00 00 00 00 00 00 11 c8 1a 00
  e0: 01
[    0.000000]  00 00 00 01 08 00 00 00 00 00 00 00 00 00 00
  f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    0.000000] pci 0000:02:00.0 config space:
  00: f4 1a 45 10 07 00 10 00 01 00 ff 00 00 00 00 00
  10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  20: 0c 00 10 00 40 08 00 00 00 00 00 00 f4 1a 00 11
  30: 00 00 00 00 c8 00 00 00 00 00 00 00 0b 01 00 00
  40: 10 00 02 00 00 80 00 10 00 00 00 00 11 04 00 00
  50: 00 00 11 20 00 00 00 00 00 00 00 00 00 00 00 00
  60: 00 00 00 00 00 00 30 00 00 00 00 00 00 00 00 00
  70: 00 00 00 00 00 00 00 00 00 00 00 00 01 40 03 00
  80: 00 00 00 00 09 7c 10 01 04 00 00 00 00 00 00 00
  90: 00 10 00 00 09 84 10 03 04 00 00 00 00 10 00 00
  a0: 00 10 00 00 09 94 10 04 04 00 00 00 00 20 00 00
  b0: 00 10 00 00 09 a4 14 02 04 00 00 00 00 30 00 00
  c0: 00 10 00 00 04 00 00 00 09 b4 14 05 00 00 00 00
  d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  e0: 00
[    0.000000]  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    0.000000] e820: update [mem 0x795e0018-0x795e9457] usable =3D=3D> usab=
le
[    0.000000] e820: update [mem 0x79348018-0x7936f857] usable =3D=3D> usab=
le
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000009ff=
ff] usable
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x00000000793480=
17] usable
[    0.000000] reserve setup_data: [mem 0x0000000079348018-0x000000007936f8=
57] usable
[    0.000000] reserve setup_data: [mem 0x000000007936f858-0x00000000795e00=
17] usable
[    0.000000] reserve setup_data: [mem 0x00000000795e0018-0x00000000795e94=
57] usable
[    0.000000] reserve setup_data: [mem 0x00000000795e9458-0x000000007a051f=
ff] usable
[    0.000000] reserve setup_data: [mem 0x000000007a052000-0x000000007a060f=
ff] ACPI data
[    0.000000] reserve setup_data: [mem 0x000000007a061000-0x000000007b0eef=
ff] usable
[    0.000000] reserve setup_data: [mem 0x000000007b0ef000-0x000000007b36ef=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x000000007b36f000-0x000000007b37ef=
ff] ACPI data
[    0.000000] reserve setup_data: [mem 0x000000007b37f000-0x000000007b3fef=
ff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000007b3ff000-0x000000007ff7bf=
ff] usable
[    0.000000] reserve setup_data: [mem 0x000000007ff7c000-0x000000007fffff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000b0000000-0x00000000bfffff=
ff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000037fffff=
ff] usable
[    0.000000] efi: EFI v2.70 by EDK II
[    0.000000] efi:  SMBIOS=3D0x7b12e000  ACPI=3D0x7b37e000  ACPI 2.0=3D0x7=
b37e014=20
[    0.000000] efi: mem00: type=3D3, attr=3D0xf, range=3D[0x000000000000000=
0-0x0000000000001000) (0MB)
[    0.000000] efi: mem01: type=3D2, attr=3D0xf, range=3D[0x000000000000100=
0-0x0000000000002000) (0MB)
[    0.000000] efi: mem02: type=3D7, attr=3D0xf, range=3D[0x000000000000200=
0-0x0000000000087000) (0MB)
[    0.000000] efi: mem03: type=3D4, attr=3D0xf, range=3D[0x000000000008700=
0-0x0000000000088000) (0MB)
[    0.000000] efi: mem04: type=3D7, attr=3D0xf, range=3D[0x000000000008800=
0-0x00000000000a0000) (0MB)
[    0.000000] efi: mem05: type=3D7, attr=3D0xf, range=3D[0x000000000010000=
0-0x0000000000806000) (7MB)
[    0.000000] efi: mem06: type=3D4, attr=3D0xf, range=3D[0x000000000080600=
0-0x0000000000807000) (0MB)
[    0.000000] efi: mem07: type=3D7, attr=3D0xf, range=3D[0x000000000080700=
0-0x0000000000820000) (0MB)
[    0.000000] efi: mem08: type=3D4, attr=3D0xf, range=3D[0x000000000082000=
0-0x0000000001500000) (12MB)
[    0.000000] efi: mem09: type=3D7, attr=3D0xf, range=3D[0x000000000150000=
0-0x0000000001600000) (1MB)
[    0.000000] efi: mem10: type=3D2, attr=3D0xf, range=3D[0x000000000160000=
0-0x0000000002c7a000) (22MB)
[    0.000000] efi: mem11: type=3D7, attr=3D0xf, range=3D[0x0000000002c7a00=
0-0x000000003cb3d000) (926MB)
[    0.000000] efi: mem12: type=3D2, attr=3D0xf, range=3D[0x000000003cb3d00=
0-0x0000000040000000) (52MB)
[    0.000000] efi: mem13: type=3D7, attr=3D0xf, range=3D[0x000000004000000=
0-0x0000000059e2c000) (414MB)
[    0.000000] efi: mem14: type=3D2, attr=3D0xf, range=3D[0x0000000059e2c00=
0-0x0000000077fdf000) (481MB)
[    0.000000] efi: mem15: type=3D4, attr=3D0xf, range=3D[0x0000000077fdf00=
0-0x0000000077fff000) (0MB)
[    0.000000] efi: mem16: type=3D7, attr=3D0xf, range=3D[0x0000000077fff00=
0-0x0000000079346000) (19MB)
[    0.000000] efi: mem17: type=3D2, attr=3D0xf, range=3D[0x000000007934600=
0-0x0000000079370000) (0MB)
[    0.000000] efi: mem18: type=3D1, attr=3D0xf, range=3D[0x000000007937000=
0-0x000000007947f000) (1MB)
[    0.000000] efi: mem19: type=3D4, attr=3D0xf, range=3D[0x000000007947f00=
0-0x00000000795df000) (1MB)
[    0.000000] efi: mem20: type=3D7, attr=3D0xf, range=3D[0x00000000795df00=
0-0x00000000795e0000) (0MB)
[    0.000000] efi: mem21: type=3D2, attr=3D0xf, range=3D[0x00000000795e000=
0-0x00000000795ea000) (0MB)
[    0.000000] efi: mem22: type=3D4, attr=3D0xf, range=3D[0x00000000795ea00=
0-0x00000000795eb000) (0MB)
[    0.000000] efi: mem23: type=3D1, attr=3D0xf, range=3D[0x00000000795eb00=
0-0x00000000796f5000) (1MB)
[    0.000000] efi: mem24: type=3D2, attr=3D0xf, range=3D[0x00000000796f500=
0-0x0000000079800000) (1MB)
[    0.000000] efi: mem25: type=3D4, attr=3D0xf, range=3D[0x000000007980000=
0-0x0000000079801000) (0MB)
[    0.000000] efi: mem26: type=3D2, attr=3D0xf, range=3D[0x000000007980100=
0-0x0000000079802000) (0MB)
[    0.000000] efi: mem27: type=3D4, attr=3D0xf, range=3D[0x000000007980200=
0-0x0000000079f83000) (7MB)
[    0.000000] efi: mem28: type=3D3, attr=3D0xf, range=3D[0x0000000079f8300=
0-0x000000007a02b000) (0MB)
[    0.000000] efi: mem29: type=3D4, attr=3D0xf, range=3D[0x000000007a02b00=
0-0x000000007a052000) (0MB)
[    0.000000] efi: mem30: type=3D9, attr=3D0xf, range=3D[0x000000007a05200=
0-0x000000007a061000) (0MB)
[    0.000000] efi: mem31: type=3D4, attr=3D0xf, range=3D[0x000000007a06100=
0-0x000000007a0a2000) (0MB)
[    0.000000] efi: mem32: type=3D3, attr=3D0xf, range=3D[0x000000007a0a200=
0-0x000000007a0b2000) (0MB)
[    0.000000] efi: mem33: type=3D4, attr=3D0xf, range=3D[0x000000007a0b200=
0-0x000000007a0b6000) (0MB)
[    0.000000] efi: mem34: type=3D3, attr=3D0xf, range=3D[0x000000007a0b600=
0-0x000000007a0e4000) (0MB)
[    0.000000] efi: mem35: type=3D4, attr=3D0xf, range=3D[0x000000007a0e400=
0-0x000000007a0e5000) (0MB)
[    0.000000] efi: mem36: type=3D3, attr=3D0xf, range=3D[0x000000007a0e500=
0-0x000000007a0fa000) (0MB)
[    0.000000] efi: mem37: type=3D4, attr=3D0xf, range=3D[0x000000007a0fa00=
0-0x000000007a0fe000) (0MB)
[    0.000000] efi: mem38: type=3D3, attr=3D0xf, range=3D[0x000000007a0fe00=
0-0x000000007a130000) (0MB)
[    0.000000] efi: mem39: type=3D4, attr=3D0xf, range=3D[0x000000007a13000=
0-0x000000007a133000) (0MB)
[    0.000000] efi: mem40: type=3D3, attr=3D0xf, range=3D[0x000000007a13300=
0-0x000000007a168000) (0MB)
[    0.000000] efi: mem41: type=3D4, attr=3D0xf, range=3D[0x000000007a16800=
0-0x000000007a16a000) (0MB)
[    0.000000] efi: mem42: type=3D3, attr=3D0xf, range=3D[0x000000007a16a00=
0-0x000000007a19b000) (0MB)
[    0.000000] efi: mem43: type=3D4, attr=3D0xf, range=3D[0x000000007a19b00=
0-0x000000007a1a1000) (0MB)
[    0.000000] efi: mem44: type=3D3, attr=3D0xf, range=3D[0x000000007a1a100=
0-0x000000007a1bd000) (0MB)
[    0.000000] efi: mem45: type=3D4, attr=3D0xf, range=3D[0x000000007a1bd00=
0-0x000000007a1be000) (0MB)
[    0.000000] efi: mem46: type=3D3, attr=3D0xf, range=3D[0x000000007a1be00=
0-0x000000007a1d4000) (0MB)
[    0.000000] efi: mem47: type=3D4, attr=3D0xf, range=3D[0x000000007a1d400=
0-0x000000007a1d8000) (0MB)
[    0.000000] efi: mem48: type=3D3, attr=3D0xf, range=3D[0x000000007a1d800=
0-0x000000007a217000) (0MB)
[    0.000000] efi: mem49: type=3D4, attr=3D0xf, range=3D[0x000000007a21700=
0-0x000000007a220000) (0MB)
[    0.000000] efi: mem50: type=3D3, attr=3D0xf, range=3D[0x000000007a22000=
0-0x000000007a232000) (0MB)
[    0.000000] efi: mem51: type=3D4, attr=3D0xf, range=3D[0x000000007a23200=
0-0x000000007a234000) (0MB)
[    0.000000] efi: mem52: type=3D3, attr=3D0xf, range=3D[0x000000007a23400=
0-0x000000007a246000) (0MB)
[    0.000000] efi: mem53: type=3D4, attr=3D0xf, range=3D[0x000000007a24600=
0-0x000000007a24d000) (0MB)
[    0.000000] efi: mem54: type=3D3, attr=3D0xf, range=3D[0x000000007a24d00=
0-0x000000007a261000) (0MB)
[    0.000000] efi: mem55: type=3D4, attr=3D0xf, range=3D[0x000000007a26100=
0-0x000000007a265000) (0MB)
[    0.000000] efi: mem56: type=3D3, attr=3D0xf, range=3D[0x000000007a26500=
0-0x000000007a27f000) (0MB)
[    0.000000] efi: mem57: type=3D4, attr=3D0xf, range=3D[0x000000007a27f00=
0-0x000000007a281000) (0MB)
[    0.000000] efi: mem58: type=3D3, attr=3D0xf, range=3D[0x000000007a28100=
0-0x000000007a285000) (0MB)
[    0.000000] efi: mem59: type=3D4, attr=3D0xf, range=3D[0x000000007a28500=
0-0x000000007a289000) (0MB)
[    0.000000] efi: mem60: type=3D3, attr=3D0xf, range=3D[0x000000007a28900=
0-0x000000007a2d3000) (0MB)
[    0.000000] efi: mem61: type=3D4, attr=3D0xf, range=3D[0x000000007a2d300=
0-0x000000007a2d6000) (0MB)
[    0.000000] efi: mem62: type=3D3, attr=3D0xf, range=3D[0x000000007a2d600=
0-0x000000007a387000) (0MB)
[    0.000000] efi: mem63: type=3D4, attr=3D0xf, range=3D[0x000000007a38700=
0-0x000000007a600000) (2MB)
[    0.000000] efi: mem64: type=3D3, attr=3D0xf, range=3D[0x000000007a60000=
0-0x000000007a60c000) (0MB)
[    0.000000] efi: mem65: type=3D4, attr=3D0xf, range=3D[0x000000007a60c00=
0-0x000000007a613000) (0MB)
[    0.000000] efi: mem66: type=3D3, attr=3D0xf, range=3D[0x000000007a61300=
0-0x000000007a621000) (0MB)
[    0.000000] efi: mem67: type=3D4, attr=3D0xf, range=3D[0x000000007a62100=
0-0x000000007a623000) (0MB)
[    0.000000] efi: mem68: type=3D3, attr=3D0xf, range=3D[0x000000007a62300=
0-0x000000007a629000) (0MB)
[    0.000000] efi: mem69: type=3D4, attr=3D0xf, range=3D[0x000000007a62900=
0-0x000000007a62f000) (0MB)
[    0.000000] efi: mem70: type=3D3, attr=3D0xf, range=3D[0x000000007a62f00=
0-0x000000007a637000) (0MB)
[    0.000000] efi: mem71: type=3D4, attr=3D0xf, range=3D[0x000000007a63700=
0-0x000000007a63f000) (0MB)
[    0.000000] efi: mem72: type=3D3, attr=3D0xf, range=3D[0x000000007a63f00=
0-0x000000007a64d000) (0MB)
[    0.000000] efi: mem73: type=3D4, attr=3D0xf, range=3D[0x000000007a64d00=
0-0x000000007a650000) (0MB)
[    0.000000] efi: mem74: type=3D3, attr=3D0xf, range=3D[0x000000007a65000=
0-0x000000007a69e000) (0MB)
[    0.000000] efi: mem75: type=3D4, attr=3D0xf, range=3D[0x000000007a69e00=
0-0x000000007a6a1000) (0MB)
[    0.000000] efi: mem76: type=3D3, attr=3D0xf, range=3D[0x000000007a6a100=
0-0x000000007a6a5000) (0MB)
[    0.000000] efi: mem77: type=3D4, attr=3D0xf, range=3D[0x000000007a6a500=
0-0x000000007a6ab000) (0MB)
[    0.000000] efi: mem78: type=3D3, attr=3D0xf, range=3D[0x000000007a6ab00=
0-0x000000007a6d2000) (0MB)
[    0.000000] efi: mem79: type=3D4, attr=3D0xf, range=3D[0x000000007a6d200=
0-0x000000007a6d3000) (0MB)
[    0.000000] efi: mem80: type=3D3, attr=3D0xf, range=3D[0x000000007a6d300=
0-0x000000007a6d7000) (0MB)
[    0.000000] efi: mem81: type=3D4, attr=3D0xf, range=3D[0x000000007a6d700=
0-0x000000007a6db000) (0MB)
[    0.000000] efi: mem82: type=3D3, attr=3D0xf, range=3D[0x000000007a6db00=
0-0x000000007a6e5000) (0MB)
[    0.000000] efi: mem83: type=3D4, attr=3D0xf, range=3D[0x000000007a6e500=
0-0x000000007a6e7000) (0MB)
[    0.000000] efi: mem84: type=3D3, attr=3D0xf, range=3D[0x000000007a6e700=
0-0x000000007a6eb000) (0MB)
[    0.000000] efi: mem85: type=3D4, attr=3D0xf, range=3D[0x000000007a6eb00=
0-0x000000007a6ef000) (0MB)
[    0.000000] efi: mem86: type=3D3, attr=3D0xf, range=3D[0x000000007a6ef00=
0-0x000000007a6ff000) (0MB)
[    0.000000] efi: mem87: type=3D4, attr=3D0xf, range=3D[0x000000007a6ff00=
0-0x000000007a7c2000) (0MB)
[    0.000000] efi: mem88: type=3D3, attr=3D0xf, range=3D[0x000000007a7c200=
0-0x000000007a7dc000) (0MB)
[    0.000000] efi: mem89: type=3D4, attr=3D0xf, range=3D[0x000000007a7dc00=
0-0x000000007a7e0000) (0MB)
[    0.000000] efi: mem90: type=3D3, attr=3D0xf, range=3D[0x000000007a7e000=
0-0x000000007a7e4000) (0MB)
[    0.000000] efi: mem91: type=3D4, attr=3D0xf, range=3D[0x000000007a7e400=
0-0x000000007a7e8000) (0MB)
[    0.000000] efi: mem92: type=3D3, attr=3D0xf, range=3D[0x000000007a7e800=
0-0x000000007a7f6000) (0MB)
[    0.000000] efi: mem93: type=3D4, attr=3D0xf, range=3D[0x000000007a7f600=
0-0x000000007abf6000) (4MB)
[    0.000000] efi: mem94: type=3D3, attr=3D0xf, range=3D[0x000000007abf600=
0-0x000000007ac07000) (0MB)
[    0.000000] efi: mem95: type=3D4, attr=3D0xf, range=3D[0x000000007ac0700=
0-0x000000007ac08000) (0MB)
[    0.000000] efi: mem96: type=3D3, attr=3D0xf, range=3D[0x000000007ac0800=
0-0x000000007ac10000) (0MB)
[    0.000000] efi: mem97: type=3D4, attr=3D0xf, range=3D[0x000000007ac1000=
0-0x000000007ac11000) (0MB)
[    0.000000] efi: mem98: type=3D3, attr=3D0xf, range=3D[0x000000007ac1100=
0-0x000000007ac1f000) (0MB)
[    0.000000] efi: mem99: type=3D4, attr=3D0xf, range=3D[0x000000007ac1f00=
0-0x000000007ac20000) (0MB)
[    0.000000] efi: mem100: type=3D3, attr=3D0xf, range=3D[0x000000007ac200=
00-0x000000007ac21000) (0MB)
[    0.000000] efi: mem101: type=3D4, attr=3D0xf, range=3D[0x000000007ac210=
00-0x000000007b0ef000) (4MB)
[    0.000000] efi: mem102: type=3D6, attr=3D0x800000000000000f, range=3D[0=
x000000007b0ef000-0x000000007b1ef000) (1MB)
[    0.000000] efi: mem103: type=3D5, attr=3D0x800000000000000f, range=3D[0=
x000000007b1ef000-0x000000007b2ef000) (1MB)
[    0.000000] efi: mem104: type=3D0, attr=3D0xf, range=3D[0x000000007b2ef0=
00-0x000000007b36f000) (0MB)
[    0.000000] efi: mem105: type=3D9, attr=3D0xf, range=3D[0x000000007b36f0=
00-0x000000007b37f000) (0MB)
[    0.000000] efi: mem106: type=3D10, attr=3D0xf, range=3D[0x000000007b37f=
000-0x000000007b3ff000) (0MB)
[    0.000000] efi: mem107: type=3D4, attr=3D0xf, range=3D[0x000000007b3ff0=
00-0x000000007f600000) (66MB)
[    0.000000] efi: mem108: type=3D7, attr=3D0xf, range=3D[0x000000007f6000=
00-0x000000007f758000) (1MB)
[    0.000000] efi: mem109: type=3D4, attr=3D0xf, range=3D[0x000000007f7580=
00-0x000000007f778000) (0MB)
[    0.000000] efi: mem110: type=3D3, attr=3D0xf, range=3D[0x000000007f7780=
00-0x000000007f7c0000) (0MB)
[    0.000000] efi: mem111: type=3D4, attr=3D0xf, range=3D[0x000000007f7c00=
00-0x000000007ff4e000) (7MB)
[    0.000000] efi: mem112: type=3D3, attr=3D0xf, range=3D[0x000000007ff4e0=
00-0x000000007ff7c000) (0MB)
[    0.000000] efi: mem113: type=3D6, attr=3D0x800000000000000f, range=3D[0=
x000000007ff7c000-0x0000000080000000) (0MB)
[    0.000000] efi: mem114: type=3D7, attr=3D0xf, range=3D[0x00000001000000=
00-0x0000000380000000) (10240MB)
[    0.000000] efi: mem115: type=3D0, attr=3D0x1, range=3D[0x00000000b00000=
00-0x00000000c0000000) (256MB)
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: Nutanix AHV/RHEL-AV, BIOS 0.0.0 02/06/2015
[    0.000000] Hypervisor detected: KVM
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] AGP: No AGP bridge found
[    0.000000] e820: last_pfn =3D 0x380000 max_arch_pfn =3D 0x400000000
[    0.000000] MTRR default type: write-back
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-FFFFF uncachable
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0000C0000000 mask 3FFFC0000000 uncachable
[    0.000000]   1 base 0000B0000000 mask 3FFFF0000000 uncachable
[    0.000000]   2 base 084000000000 mask 3FF800000000 uncachable
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] PAT configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- UC =20
[    0.000000] e820: last_pfn =3D 0x7ff7c max_arch_pfn =3D 0x400000000
[    0.000000] Base memory trampoline at [ffff957700099000] 99000 size 2457=
6
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0x174852000, 0x174852fff] PGTABLE
[    0.000000] BRK [0x174853000, 0x174853fff] PGTABLE
[    0.000000] BRK [0x174854000, 0x174854fff] PGTABLE
[    0.000000] BRK [0x174855000, 0x174855fff] PGTABLE
[    0.000000] BRK [0x174856000, 0x174856fff] PGTABLE
[    0.000000] BRK [0x174857000, 0x174857fff] PGTABLE
[    0.000000] BRK [0x174858000, 0x174858fff] PGTABLE
[    0.000000] BRK [0x174859000, 0x174859fff] PGTABLE
[    0.000000] BRK [0x17485a000, 0x17485afff] PGTABLE
[    0.000000] RAMDISK: [mem 0x3cb3d000-0x3e983fff]
[    0.000000] Early table checksum verification disabled
[    0.000000] ACPI: RSDP 000000007b37e014 00024 (v02 BOCHS )
[    0.000000] ACPI: XSDT 000000007b37d0e8 00054 (v01 BOCHS  BXPCFACP 00000=
001      01000013)
[    0.000000] ACPI: FACP 000000007b37c000 000F4 (v03 BOCHS  BXPCFACP 00000=
001 BXPC 00000001)
[    0.000000] ACPI: DSDT 000000007a052000 0EBE9 (v01 BOCHS  BXPCDSDT 00000=
001 BXPC 00000001)
[    0.000000] ACPI: FACS 000000007b3dc000 00040
[    0.000000] ACPI: APIC 000000007b37b000 007F0 (v01 BOCHS  BXPCAPIC 00000=
001 BXPC 00000001)
[    0.000000] ACPI: SSDT 000000007b37a000 000CA (v01 BOCHS   VMGENID 00000=
001 BXPC 00000001)
[    0.000000] ACPI: SRAT 000000007b379000 00FD0 (v01 BOCHS  BXPCSRAT 00000=
001 BXPC 00000001)
[    0.000000] ACPI: MCFG 000000007b378000 0003C (v01 BOCHS  BXPCMCFG 00000=
001 BXPC 00000001)
[    0.000000] ACPI: BGRT 000000007b377000 00038 (v01 INTEL  EDK2     00000=
002      01000013)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] SRAT: PXM 0 -> APIC 0x00 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x01 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x02 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x03 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x04 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x05 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x06 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x07 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x08 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x09 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x0a -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x0b -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x0c -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x0d -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x0e -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x0f -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x10 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x11 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x12 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x13 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x14 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x15 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x16 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x17 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x18 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x19 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x1a -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x1b -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x1c -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x1d -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x1e -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x1f -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x20 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x21 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x22 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x23 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x24 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x25 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x26 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x27 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x28 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x29 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x2a -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x2b -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x2c -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x2d -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x2e -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x2f -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x30 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x31 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x32 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x33 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x34 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x35 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x36 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x37 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x38 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x39 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x3a -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x3b -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x3c -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x3d -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x3e -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x3f -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x40 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x41 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x42 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x43 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x44 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x45 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x46 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x47 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x48 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x49 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x4a -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x4b -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x4c -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x4d -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x4e -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x4f -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x50 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x51 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x52 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x53 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x54 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x55 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x56 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x57 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x58 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x59 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x5a -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x5b -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x5c -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x5d -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x5e -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x5f -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x60 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x61 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x62 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x63 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x64 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x65 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x66 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x67 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x68 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x69 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x6a -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x6b -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x6c -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x6d -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x6e -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x6f -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x70 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x71 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x72 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x73 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x74 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x75 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x76 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x77 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x78 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x79 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x7a -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x7b -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x7c -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x7d -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x7e -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x7f -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x80 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x81 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x82 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x83 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x84 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x85 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x86 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x87 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x88 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x89 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x8a -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x8b -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x8c -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x8d -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x8e -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x8f -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x90 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x91 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x92 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x93 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x94 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x95 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x96 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x97 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x98 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x99 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x9a -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x9b -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x9c -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x9d -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x9e -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x9f -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xa0 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xa1 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xa2 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xa3 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xa4 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xa5 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xa6 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xa7 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xa8 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xa9 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xaa -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xab -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xac -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xad -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xae -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xaf -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xb0 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xb1 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xb2 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xb3 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xb4 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xb5 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xb6 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xb7 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xb8 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xb9 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xba -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xbb -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xbc -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xbd -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xbe -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xbf -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xc0 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xc1 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xc2 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xc3 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xc4 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xc5 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xc6 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xc7 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xc8 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xc9 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xca -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xcb -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xcc -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xcd -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xce -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xcf -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xd0 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xd1 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xd2 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xd3 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xd4 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xd5 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xd6 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xd7 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xd8 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xd9 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xda -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xdb -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xdc -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xdd -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xde -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xdf -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xe0 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xe1 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xe2 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xe3 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xe4 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xe5 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xe6 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xe7 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xe8 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xe9 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xea -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xeb -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xec -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xed -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xee -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0xef -> Node 0
[    0.000000] SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
[    0.000000] SRAT: Node 0 PXM 0 [mem 0x00100000-0x7fffffff]
[    0.000000] SRAT: Node 0 PXM 0 [mem 0x100000000-0x37fffffff]
[    0.000000] SRAT: Node 0 PXM 0 [mem 0x380000000-0x83c7fffffff] hotplug
[    0.000000] NUMA: Node 0 [mem 0x00000000-0x0009ffff] + [mem 0x00100000-0=
x7fffffff] -> [mem 0x00000000-0x7fffffff]
[    0.000000] NUMA: Node 0 [mem 0x00000000-0x7fffffff] + [mem 0x100000000-=
0x37fffffff] -> [mem 0x00000000-0x37fffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x37ffd9000-0x37fffffff]
[    0.000000] Reserving 161MB of memory at 720MB for crashkernel (System R=
AM: 12283MB)
[    0.000000] kvm-clock: cpu 0, msr 3:7ff88001, primary cpu clock
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000000] kvm-clock: using sched offset of 8466389451723 cycles
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00001000-0x00ffffff]
[    0.000000]   DMA32    [mem 0x01000000-0xffffffff]
[    0.000000]   Normal   [mem 0x100000000-0x37fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00001000-0x0009ffff]
[    0.000000]   node   0: [mem 0x00100000-0x7a051fff]
[    0.000000]   node   0: [mem 0x7a061000-0x7b0eefff]
[    0.000000]   node   0: [mem 0x7b3ff000-0x7ff7bfff]
[    0.000000]   node   0: [mem 0x100000000-0x37fffffff]
[    0.000000] Initmem setup node 0 [mem 0x00001000-0x37fffffff]
[    0.000000] On node 0 totalpages: 3144700
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 2040 pages reserved
[    0.000000]   DMA zone: 3999 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 8114 pages used for memmap
[    0.000000]   DMA32 zone: 519261 pages, LIFO batch:31
[    0.000000]   Normal zone: 40960 pages used for memmap
[    0.000000]   Normal zone: 2621440 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x608
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x04] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x05] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x06] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x07] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x08] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x09] lapic_id[0x09] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0a] lapic_id[0x0a] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0b] lapic_id[0x0b] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0c] lapic_id[0x0c] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0d] lapic_id[0x0d] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0e] lapic_id[0x0e] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0f] lapic_id[0x0f] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x10] lapic_id[0x10] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x11] lapic_id[0x11] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x12] lapic_id[0x12] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x13] lapic_id[0x13] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x14] lapic_id[0x14] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x15] lapic_id[0x15] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x16] lapic_id[0x16] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x17] lapic_id[0x17] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x18] lapic_id[0x18] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x19] lapic_id[0x19] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x1a] lapic_id[0x1a] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x1b] lapic_id[0x1b] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x1c] lapic_id[0x1c] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x1d] lapic_id[0x1d] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x1e] lapic_id[0x1e] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x1f] lapic_id[0x1f] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x20] lapic_id[0x20] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x21] lapic_id[0x21] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x22] lapic_id[0x22] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x23] lapic_id[0x23] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x24] lapic_id[0x24] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x25] lapic_id[0x25] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x26] lapic_id[0x26] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x27] lapic_id[0x27] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x28] lapic_id[0x28] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x29] lapic_id[0x29] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x2a] lapic_id[0x2a] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x2b] lapic_id[0x2b] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x2c] lapic_id[0x2c] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x2d] lapic_id[0x2d] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x2e] lapic_id[0x2e] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x2f] lapic_id[0x2f] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x30] lapic_id[0x30] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x31] lapic_id[0x31] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x32] lapic_id[0x32] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x33] lapic_id[0x33] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x34] lapic_id[0x34] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x35] lapic_id[0x35] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x36] lapic_id[0x36] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x37] lapic_id[0x37] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x38] lapic_id[0x38] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x39] lapic_id[0x39] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x3a] lapic_id[0x3a] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x3b] lapic_id[0x3b] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x3c] lapic_id[0x3c] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x3d] lapic_id[0x3d] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x3e] lapic_id[0x3e] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x3f] lapic_id[0x3f] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x40] lapic_id[0x40] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x41] lapic_id[0x41] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x42] lapic_id[0x42] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x43] lapic_id[0x43] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x44] lapic_id[0x44] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x45] lapic_id[0x45] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x46] lapic_id[0x46] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x47] lapic_id[0x47] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x48] lapic_id[0x48] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x49] lapic_id[0x49] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x4a] lapic_id[0x4a] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x4b] lapic_id[0x4b] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x4c] lapic_id[0x4c] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x4d] lapic_id[0x4d] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x4e] lapic_id[0x4e] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x4f] lapic_id[0x4f] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x50] lapic_id[0x50] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x51] lapic_id[0x51] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x52] lapic_id[0x52] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x53] lapic_id[0x53] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x54] lapic_id[0x54] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x55] lapic_id[0x55] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x56] lapic_id[0x56] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x57] lapic_id[0x57] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x58] lapic_id[0x58] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x59] lapic_id[0x59] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x5a] lapic_id[0x5a] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x5b] lapic_id[0x5b] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x5c] lapic_id[0x5c] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x5d] lapic_id[0x5d] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x5e] lapic_id[0x5e] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x5f] lapic_id[0x5f] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x60] lapic_id[0x60] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x61] lapic_id[0x61] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x62] lapic_id[0x62] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x63] lapic_id[0x63] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x64] lapic_id[0x64] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x65] lapic_id[0x65] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x66] lapic_id[0x66] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x67] lapic_id[0x67] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x68] lapic_id[0x68] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x69] lapic_id[0x69] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x6a] lapic_id[0x6a] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x6b] lapic_id[0x6b] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x6c] lapic_id[0x6c] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x6d] lapic_id[0x6d] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x6e] lapic_id[0x6e] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x6f] lapic_id[0x6f] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x70] lapic_id[0x70] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x71] lapic_id[0x71] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x72] lapic_id[0x72] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x73] lapic_id[0x73] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x74] lapic_id[0x74] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x75] lapic_id[0x75] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x76] lapic_id[0x76] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x77] lapic_id[0x77] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x78] lapic_id[0x78] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x79] lapic_id[0x79] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x7a] lapic_id[0x7a] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x7b] lapic_id[0x7b] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x7c] lapic_id[0x7c] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x7d] lapic_id[0x7d] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x7e] lapic_id[0x7e] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x7f] lapic_id[0x7f] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x80] lapic_id[0x80] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x81] lapic_id[0x81] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x82] lapic_id[0x82] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x83] lapic_id[0x83] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x84] lapic_id[0x84] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x85] lapic_id[0x85] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x86] lapic_id[0x86] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x87] lapic_id[0x87] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x88] lapic_id[0x88] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x89] lapic_id[0x89] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x8a] lapic_id[0x8a] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x8b] lapic_id[0x8b] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x8c] lapic_id[0x8c] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x8d] lapic_id[0x8d] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x8e] lapic_id[0x8e] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x8f] lapic_id[0x8f] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x90] lapic_id[0x90] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x91] lapic_id[0x91] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x92] lapic_id[0x92] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x93] lapic_id[0x93] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x94] lapic_id[0x94] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x95] lapic_id[0x95] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x96] lapic_id[0x96] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x97] lapic_id[0x97] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x98] lapic_id[0x98] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x99] lapic_id[0x99] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x9a] lapic_id[0x9a] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x9b] lapic_id[0x9b] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x9c] lapic_id[0x9c] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x9d] lapic_id[0x9d] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x9e] lapic_id[0x9e] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x9f] lapic_id[0x9f] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xa0] lapic_id[0xa0] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xa1] lapic_id[0xa1] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xa2] lapic_id[0xa2] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xa3] lapic_id[0xa3] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xa4] lapic_id[0xa4] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xa5] lapic_id[0xa5] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xa6] lapic_id[0xa6] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xa7] lapic_id[0xa7] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xa8] lapic_id[0xa8] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xa9] lapic_id[0xa9] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xaa] lapic_id[0xaa] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xab] lapic_id[0xab] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xac] lapic_id[0xac] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xad] lapic_id[0xad] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xae] lapic_id[0xae] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xaf] lapic_id[0xaf] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xb0] lapic_id[0xb0] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xb1] lapic_id[0xb1] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xb2] lapic_id[0xb2] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xb3] lapic_id[0xb3] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xb4] lapic_id[0xb4] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xb5] lapic_id[0xb5] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xb6] lapic_id[0xb6] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xb7] lapic_id[0xb7] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xb8] lapic_id[0xb8] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xb9] lapic_id[0xb9] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xba] lapic_id[0xba] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xbb] lapic_id[0xbb] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xbc] lapic_id[0xbc] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xbd] lapic_id[0xbd] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xbe] lapic_id[0xbe] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xbf] lapic_id[0xbf] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xc0] lapic_id[0xc0] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xc1] lapic_id[0xc1] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xc2] lapic_id[0xc2] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xc3] lapic_id[0xc3] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xc4] lapic_id[0xc4] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xc5] lapic_id[0xc5] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xc6] lapic_id[0xc6] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xc7] lapic_id[0xc7] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xc8] lapic_id[0xc8] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xc9] lapic_id[0xc9] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xca] lapic_id[0xca] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xcb] lapic_id[0xcb] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xcc] lapic_id[0xcc] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xcd] lapic_id[0xcd] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xce] lapic_id[0xce] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xcf] lapic_id[0xcf] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xd0] lapic_id[0xd0] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xd1] lapic_id[0xd1] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xd2] lapic_id[0xd2] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xd3] lapic_id[0xd3] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xd4] lapic_id[0xd4] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xd5] lapic_id[0xd5] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xd6] lapic_id[0xd6] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xd7] lapic_id[0xd7] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xd8] lapic_id[0xd8] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xd9] lapic_id[0xd9] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xda] lapic_id[0xda] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xdb] lapic_id[0xdb] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xdc] lapic_id[0xdc] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xdd] lapic_id[0xdd] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xde] lapic_id[0xde] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xdf] lapic_id[0xdf] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xe0] lapic_id[0xe0] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xe1] lapic_id[0xe1] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xe2] lapic_id[0xe2] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xe3] lapic_id[0xe3] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xe4] lapic_id[0xe4] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xe5] lapic_id[0xe5] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xe6] lapic_id[0xe6] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xe7] lapic_id[0xe7] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xe8] lapic_id[0xe8] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xe9] lapic_id[0xe9] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xea] lapic_id[0xea] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xeb] lapic_id[0xeb] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xec] lapic_id[0xec] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xed] lapic_id[0xed] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xee] lapic_id[0xee] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0xef] lapic_id[0xef] disabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x00] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-=
23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level=
)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level=
)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ5 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] ACPI: IRQ10 used by override.
[    0.000000] ACPI: IRQ11 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] smpboot: Allowing 240 CPUs, 216 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x79348000-0x79348fff]
[    0.000000] PM: Registered nosave memory: [mem 0x7936f000-0x7936ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x795e0000-0x795e0fff]
[    0.000000] PM: Registered nosave memory: [mem 0x795e9000-0x795e9fff]
[    0.000000] PM: Registered nosave memory: [mem 0x7a052000-0x7a060fff]
[    0.000000] PM: Registered nosave memory: [mem 0x7b0ef000-0x7b36efff]
[    0.000000] PM: Registered nosave memory: [mem 0x7b36f000-0x7b37efff]
[    0.000000] PM: Registered nosave memory: [mem 0x7b37f000-0x7b3fefff]
[    0.000000] PM: Registered nosave memory: [mem 0x7ff7c000-0x7fffffff]
[    0.000000] PM: Registered nosave memory: [mem 0x80000000-0xafffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xb0000000-0xbfffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xc0000000-0xffffffff]
[    0.000000] e820: [mem 0xc0000000-0xffffffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on KVM
[    0.000000] setup_percpu: NR_CPUS:5120 nr_cpumask_bits:240 nr_cpu_ids:24=
0 nr_node_ids:1
[    0.000000] PERCPU: Embedded 38 pages/cpu @ffff957a6fa00000 s118784 r819=
2 d28672 u262144
[    0.000000] pcpu-alloc: s118784 r8192 d28672 u262144 alloc=3D1*2097152
[    0.000000] pcpu-alloc: [0] 000 001 002 003 004 005 006 007=20
[    0.000000] pcpu-alloc: [0] 008 009 010 011 012 013 014 015=20
[    0.000000] pcpu-alloc: [0] 016 017 018 019 020 021 022 023=20
[    0.000000] pcpu-alloc: [0] 024 025 026 027 028 029 030 031=20
[    0.000000] pcpu-alloc: [0] 032 033 034 035 036 037 038 039=20
[    0.000000] pcpu-alloc: [0] 040 041 042 043 044 045 046 047=20
[    0.000000] pcpu-alloc: [0] 048 049 050 051 052 053 054 055=20
[    0.000000] pcpu-alloc: [0] 056 057 058 059 060 061 062 063=20
[    0.000000] pcpu-alloc: [0] 064 065 066 067 068 069 070 071=20
[    0.000000] pcpu-alloc: [0] 072 073 074 075 076 077 078 079=20
[    0.000000] pcpu-alloc: [0] 080 081 082 083 084 085 086 087=20
[    0.000000] pcpu-alloc: [0] 088 089 090 091 092 093 094 095=20
[    0.000000] pcpu-alloc: [0] 096 097 098 099 100 101 102 103=20
[    0.000000] pcpu-alloc: [0] 104 105 106 107 108 109 110 111=20
[    0.000000] pcpu-alloc: [0] 112 113 114 115 116 117 118 119=20
[    0.000000] pcpu-alloc: [0] 120 121 122 123 124 125 126 127=20
[    0.000000] pcpu-alloc: [0] 128 129 130 131 132 133 134 135=20
[    0.000000] pcpu-alloc: [0] 136 137 138 139 140 141 142 143=20
[    0.000000] pcpu-alloc: [0] 144 145 146 147 148 149 150 151=20
[    0.000000] pcpu-alloc: [0] 152 153 154 155 156 157 158 159=20
[    0.000000] pcpu-alloc: [0] 160 161 162 163 164 165 166 167=20
[    0.000000] pcpu-alloc: [0] 168 169 170 171 172 173 174 175=20
[    0.000000] pcpu-alloc: [0] 176 177 178 179 180 181 182 183=20
[    0.000000] pcpu-alloc: [0] 184 185 186 187 188 189 190 191=20
[    0.000000] pcpu-alloc: [0] 192 193 194 195 196 197 198 199=20
[    0.000000] pcpu-alloc: [0] 200 201 202 203 204 205 206 207=20
[    0.000000] pcpu-alloc: [0] 208 209 210 211 212 213 214 215=20
[    0.000000] pcpu-alloc: [0] 216 217 218 219 220 221 222 223=20
[    0.000000] pcpu-alloc: [0] 224 225 226 227 228 229 230 231=20
[    0.000000] pcpu-alloc: [0] 232 233 234 235 236 237 238 239=20
[    0.000000] KVM setup async PF for cpu 0
[    0.000000] kvm-stealtime: cpu 0, msr 36fa1c040
[    0.000000] PV qspinlock hash table entries: 512 (order: 1, 8192 bytes)
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 3093522
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=3D/vmlinuz-3.10.0-957.el7.x8=
6_64 root=3D/dev/mapper/centos-root ro crashkernel=3Dauto rd.lvm.lv=3Dcento=
s/root rd.lvm.lv=3Dcentos/swap pci=3Dearlydump
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] x86/fpu: xstate_offset[2]: 0240, xstate_sizes[2]: 0100
[    0.000000] x86/fpu: xstate_offset[3]: 0000, xstate_sizes[3]: 0000
[    0.000000] x86/fpu: xstate_offset[4]: 0000, xstate_sizes[4]: 0000
[    0.000000] x86/fpu: xstate_offset[5]: 0440, xstate_sizes[5]: 0040
[    0.000000] x86/fpu: xstate_offset[6]: 0480, xstate_sizes[6]: 0200
[    0.000000] x86/fpu: xstate_offset[7]: 0680, xstate_sizes[7]: 0400
[    0.000000] xsave: enabled xstate_bv 0xe7, cntxt size 0xa80 using standa=
rd form
[    0.000000] AGP: Checking aperture...
[    0.000000] AGP: No AGP bridge found
[    0.000000] Memory: 3793528k/14680064k available (7664k kernel code, 210=
1264k absent, 630984k reserved, 6055k data, 1876k init)
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D240,=
 Nodes=3D1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=3D5120 to nr_cpu_ids=3D24=
0.
[    0.000000] NR_IRQS:327936 nr_irqs:2344 0
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] allocated 50331648 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=3Dmemory' option if you don't wan=
t memory cgroups
[    0.000000] tsc: Detected 2399.998 MHz processor
[    0.144336] Calibrating delay loop (skipped) preset value.. 4799.99 Bogo=
MIPS (lpj=3D2399998)
[    0.144342] pid_max: default: 245760 minimum: 1920
[    0.144900] Security Framework initialized
[    0.144913] SELinux:  Initializing.
[    0.145003] SELinux:  Starting in permissive mode
[    0.145004] Yama: becoming mindful.
[    0.145902] Dentry cache hash table entries: 2097152 (order: 12, 1677721=
6 bytes)
[    0.148534] Inode-cache hash table entries: 1048576 (order: 11, 8388608 =
bytes)
[    0.149661] Mount-cache hash table entries: 32768 (order: 6, 262144 byte=
s)
[    0.149677] Mountpoint-cache hash table entries: 32768 (order: 6, 262144=
 bytes)
[    0.150223] Initializing cgroup subsys memory
[    0.150247] Initializing cgroup subsys devices
[    0.150250] Initializing cgroup subsys freezer
[    0.150252] Initializing cgroup subsys net_cls
[    0.150255] Initializing cgroup subsys blkio
[    0.150258] Initializing cgroup subsys perf_event
[    0.150274] Initializing cgroup subsys hugetlb
[    0.150277] Initializing cgroup subsys pids
[    0.150279] Initializing cgroup subsys net_prio
[    0.150449] x86/cpu: Activated the Intel User Mode Instruction Preventio=
n (UMIP) CPU feature
[    0.150697] mce: CPU supports 10 MCE banks
[    0.150772] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.150775] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.150777] tlb_flushall_shift: 6
[    0.150819] Speculative Store Bypass: Mitigation: Speculative Store Bypa=
ss disabled via prctl and seccomp
[    0.150895] FEATURE SPEC_CTRL Present
[    0.150897] FEATURE IBPB_SUPPORT Present
[    0.150920] Spectre V2 : Mitigation: Enhanced IBRS
[    0.153334] Freeing SMP alternatives: 28k freed
[    0.160332] ACPI: Core revision 20130517
[    0.166681] ACPI: All ACPI Tables successfully acquired
[    0.170805] ftrace: allocating 29185 entries in 115 pages
[    0.202313] Enabling x2apic
[    0.202321] Enabled x2apic
[    0.202481] Switched APIC routing to physical x2apic.
[    0.203317] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.203320] smpboot: CPU0: Intel(R) Xeon(R) Silver 4314 CPU @ 2.40GHz (f=
am: 0f, model: 06, stepping: 01)
[    0.203336] TSC deadline timer enabled
[    0.203357] Performance Events: unsupported Netburst CPU model 6 no PMU =
driver, software events only.
[    0.203419] KVM setup paravirtual spinlock
[    0.217852] kvm-clock: cpu 1, msr 3:7ff88041, secondary cpu clock
[    0.217990] x86/cpu: Activated the Intel User Mode Instruction Preventio=
n (UMIP) CPU feature
[    0.238401] KVM setup async PF for cpu 1
[    0.238425] kvm-stealtime: cpu 1, msr 36fa5c040
[    0.249514] kvm-clock: cpu 2, msr 3:7ff88081, secondary cpu clock
[    0.249652] x86/cpu: Activated the Intel User Mode Instruction Preventio=
n (UMIP) CPU feature
[    0.270061] KVM setup async PF for cpu 2
[    0.270080] kvm-stealtime: cpu 2, msr 36fa9c040
[    0.281177] kvm-clock: cpu 3, msr 3:7ff880c1, secondary cpu clock
[    0.281308] x86/cpu: Activated the Intel User Mode Instruction Preventio=
n (UMIP) CPU feature
[    0.301714] KVM setup async PF for cpu 3
[    0.301732] kvm-stealtime: cpu 3, msr 36fadc040
[    0.312825] kvm-clock: cpu 4, msr 3:7ff88101, secondary cpu clock
[    0.312954] x86/cpu: Activated the Intel User Mode Instruction Preventio=
n (UMIP) CPU feature
[    0.333363] KVM setup async PF for cpu 4
[    0.333382] kvm-stealtime: cpu 4, msr 36fb1c040
[    0.344479] kvm-clock: cpu 5, msr 3:7ff88141, secondary cpu clock
[    0.344606] x86/cpu: Activated the Intel User Mode Instruction Preventio=
n (UMIP) CPU feature
[    0.365014] KVM setup async PF for cpu 5
[    0.365032] kvm-stealtime: cpu 5, msr 36fb5c040
[    0.376119] kvm-clock: cpu 6, msr 3:7ff88181, secondary cpu clock
[    0.376247] x86/cpu: Activated the Intel User Mode Instruction Preventio=
n (UMIP) CPU feature
[    0.396661] KVM setup async PF for cpu 6
[    0.396679] kvm-stealtime: cpu 6, msr 36fb9c040
[    0.407770] kvm-clock: cpu 7, msr 3:7ff881c1, secondary cpu clock
[    0.407900] x86/cpu: Activated the Intel User Mode Instruction Preventio=
n (UMIP) CPU feature
[    0.428306] KVM setup async PF for cpu 7
[    0.428325] kvm-stealtime: cpu 7, msr 36fbdc040
[    0.439417] kvm-clock: cpu 8, msr 3:7ff88201, secondary cpu clock
[    0.439546] x86/cpu: Activated the Intel User Mode Instruction Preventio=
n (UMIP) CPU feature
[    0.459951] KVM setup async PF for cpu 8
[    0.459969] kvm-stealtime: cpu 8, msr 36fc1c040
[    0.471058] kvm-clock: cpu 9, msr 3:7ff88241, secondary cpu clock
[    0.471188] x86/cpu: Activated the Intel User Mode Instruction Preventio=
n (UMIP) CPU feature
[    0.491590] KVM setup async PF for cpu 9
[    0.491608] kvm-stealtime: cpu 9, msr 36fc5c040
[    0.502711] kvm-clock: cpu 10, msr 3:7ff88281, secondary cpu clock
[    0.502845] x86/cpu: Activated the Intel User Mode Instruction Preventio=
n (UMIP) CPU feature
[    0.523245] KVM setup async PF for cpu 10
[    0.523267] kvm-stealtime: cpu 10, msr 36fc9c040
[    0.534351] kvm-clock: cpu 11, msr 3:7ff882c1, secondary cpu clock
[    0.534481] x86/cpu: Activated the Intel User Mode Instruction Preventio=
n (UMIP) CPU feature
[    0.554883] KVM setup async PF for cpu 11
[    0.554903] kvm-stealtime: cpu 11, msr 36fcdc040
[    0.566017] kvm-clock: cpu 12, msr 3:7ff88301, secondary cpu clock
[    0.566189] x86/cpu: Activated the Intel User Mode Instruction Preventio=
n (UMIP) CPU feature
[    0.586645] KVM setup async PF for cpu 12
[    0.586679] kvm-stealtime: cpu 12, msr 36fd1c040
[    0.597745] kvm-clock: cpu 13, msr 3:7ff88341, secondary cpu clock
[    0.597874] x86/cpu: Activated the Intel User Mode Instruction Preventio=
n (UMIP) CPU feature
[    0.618281] KVM setup async PF for cpu 13
[    0.618299] kvm-stealtime: cpu 13, msr 36fd5c040
[    0.629390] kvm-clock: cpu 14, msr 3:7ff88381, secondary cpu clock
[    0.629525] x86/cpu: Activated the Intel User Mode Instruction Preventio=
n (UMIP) CPU feature
[    0.649931] KVM setup async PF for cpu 14
[    0.649947] kvm-stealtime: cpu 14, msr 36fd9c040
[    0.661050] kvm-clock: cpu 15, msr 3:7ff883c1, secondary cpu clock
[    0.661186] x86/cpu: Activated the Intel User Mode Instruction Preventio=
n (UMIP) CPU feature
[    0.681582] KVM setup async PF for cpu 15
[    0.681603] kvm-stealtime: cpu 15, msr 36fddc040
[    0.692688] kvm-clock: cpu 16, msr 3:7ff88401, secondary cpu clock
[    0.692816] x86/cpu: Activated the Intel User Mode Instruction Preventio=
n (UMIP) CPU feature
[    0.713223] KVM setup async PF for cpu 16
[    0.713240] kvm-stealtime: cpu 16, msr 36fe1c040
[    0.724350] kvm-clock: cpu 17, msr 3:7ff88441, secondary cpu clock
[    0.724490] x86/cpu: Activated the Intel User Mode Instruction Preventio=
n (UMIP) CPU feature
[    0.744884] KVM setup async PF for cpu 17
[    0.744915] kvm-stealtime: cpu 17, msr 36fe5c040
[    0.755991] kvm-clock: cpu 18, msr 3:7ff88481, secondary cpu clock
[    0.756123] x86/cpu: Activated the Intel User Mode Instruction Preventio=
n (UMIP) CPU feature
[    0.776529] KVM setup async PF for cpu 18
[    0.776548] kvm-stealtime: cpu 18, msr 36fe9c040
[    0.787644] kvm-clock: cpu 19, msr 3:7ff884c1, secondary cpu clock
[    0.787775] x86/cpu: Activated the Intel User Mode Instruction Preventio=
n (UMIP) CPU feature
[    0.808178] KVM setup async PF for cpu 19
[    0.808196] kvm-stealtime: cpu 19, msr 36fedc040
[    0.819300] kvm-clock: cpu 20, msr 3:7ff88501, secondary cpu clock
[    0.819438] x86/cpu: Activated the Intel User Mode Instruction Preventio=
n (UMIP) CPU feature
[    0.839839] KVM setup async PF for cpu 20
[    0.839861] kvm-stealtime: cpu 20, msr 36ff1c040
[    0.850941] kvm-clock: cpu 21, msr 3:7ff88541, secondary cpu clock
[    0.851074] x86/cpu: Activated the Intel User Mode Instruction Preventio=
n (UMIP) CPU feature
[    0.871476] KVM setup async PF for cpu 21
[    0.871495] kvm-stealtime: cpu 21, msr 36ff5c040
[    0.882588] kvm-clock: cpu 22, msr 3:7ff88581, secondary cpu clock
[    0.882720] x86/cpu: Activated the Intel User Mode Instruction Preventio=
n (UMIP) CPU feature
[    0.903128] KVM setup async PF for cpu 22
[    0.903146] kvm-stealtime: cpu 22, msr 36ff9c040
[    0.914236] kvm-clock: cpu 23, msr 3:7ff885c1, secondary cpu clock
[    0.914365] x86/cpu: Activated the Intel User Mode Instruction Preventio=
n (UMIP) CPU feature
[    0.206770] smpboot: Booting Node   0, Processors  #1 #2 #3 #4 #5 #6 #7 =
#8 #9 #10 #11 #12 #13 #14 #15 #16 #17 #18 #19 #20 #21 #22 #23
[    0.934762] Brought up 24 CPUs
[    0.934771] smpboot: Max logical packages: 240
[    0.934774] KVM setup async PF for cpu 23
[    0.934775] smpboot: Total of 24 processors activated (115199.90 BogoMIP=
S)
[    0.934789] kvm-stealtime: cpu 23, msr 36ffdc040
[    0.968262] node 0 initialised, 2038568 pages in 32ms
[    0.968662] devtmpfs: initialized
[    0.971108] EVM: security.selinux
[    0.971111] EVM: security.ima
[    0.971112] EVM: security.capability

-----Original Message-----
From: Bjorn Helgaas <helgaas@kernel.org>=20
Sent: Friday, December 9, 2022 12:56 PM
To: Kallol Biswas [C] <kallol.biswas@nutanix.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: uefi secureboot vm and IO window overlap

Hi Kallol,

On Fri, Dec 09, 2022 at 06:44:42PM +0000, Kallol Biswas [C] wrote:
> We are observing an io window overlap issue in a secureboot enabled uefi =
vm.
>=20
> Linux displays:
> pci 0000:00:1d.0: can't claim BAR 4 [io=A0 0x92a0-0x92bf]: address=20
> conflict with PCI Bus 0000:01 [io=A0 0x9000-0x9fff]
>=20
> Eventually conflict gets resolved but we need to understand why get the c=
onflict in the first place.
>=20
> Details:
>=20
> The VM is a uefi based VM and the issue shows up if secure boot is=20
> enabled.=A0 We have enabled ovmf log and uefi/ovmf programs a bridge IO=20
> window with the range 0x9000-0x91ff, but in Linux we see the same=20
> bridge is programmed with 0x9000-0x9fff. This results in an address=20
> conflict with subsequent devices.

Linux normally doesn't reassign bridge windows if the existing configuratio=
n (typically from firmware) works.

Booting with "pci=3Dearlydump" should dump the config before Linux touches =
anything.

I see your response about being able to reproduce it where it's easier to d=
ebug.  If you need more help, please include the complete dmesg log so we c=
an see what's happening.

Bjorn
