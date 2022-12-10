Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF3464900D
	for <lists+linux-pci@lfdr.de>; Sat, 10 Dec 2022 18:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiLJRql (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Dec 2022 12:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiLJRqk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Dec 2022 12:46:40 -0500
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B84713F90
        for <linux-pci@vger.kernel.org>; Sat, 10 Dec 2022 09:46:37 -0800 (PST)
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BAEmA25018086;
        Sat, 10 Dec 2022 09:46:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=yHIV/drp0u2jkPhbMO68xNm2bI/rewPcHrFsfV2MFoY=;
 b=S2fnqczgVrGjeixxDfFddXpUv6Bj/CLS9FER8wd+orYR4ZdaA+ihN4Ot+HSAAwTw3g78
 DYfSizv4nlw2rYbJVBC3xaKXX8LX6y63S1xP4Oi13+R8aqxJvIA6NlH6x6eZzfyEHuSf
 DVreo9wHC2OIuk3Bd3daDkreaA/ziea7ngT3GCuVaY3LWvbB627i/uy+NW7luMc5HgT5
 v65c6T/E5wksZi0EWMpu7AvitqfboMY4kcURczGTKAdo8bt2vKfoTOv3tnIRxN8SESM8
 ECCXAJ6xw/RrI0QLvCfzEPTWLT1MWgA+b3nXNcZHc49N/oWj2dc8hOwbw8ykVPy15T0d Qw== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3mcs3p0dv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Dec 2022 09:46:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5QPoJURlJXrmaJvoB3rU/UFbKCEY65aI6agIvpKGxds6/pFVOXQnyErn6UciXuALUECuImM8E515gMQwCTT0GSk3WVw7QlgcsJDIu2hgfDnaU8rcvMWj3k5P8qpMBw/lLl+Z3We5Mz5VZ23oJ67WgOaW3+meBxsQBg5K5mjLJMPwWbutop1ffcitx7E6DXZ82S0AQJ7s7QAYU/JmZd1PX2v2MTAeEvVjUJDOE0t0GiTlYLqYR4D5hFNfWg9VGMQX66yKPfynLzDDYyHP9o22eaSkQouRMH20Ou7l90tf9KEHvNbcJI87GgFFECXG8vL+84ddQBOHvU2W1q5wUqBXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHIV/drp0u2jkPhbMO68xNm2bI/rewPcHrFsfV2MFoY=;
 b=W3HMkAEEKWLUoUwkiso147MXJQyfSwZU8ksMrcjYzpFp2NqAaB7qyyABjz/jr68EwM3cdpcewuxVAn6steq0VYE51/OvpM+PHFfWc0eJOHrIxjPIvhVcXyHrBd+lD+3DGbcyvq0dBRqvPOSHJqBGWyq5/DTYAXsEb3UGTzokH+r+EsqIAS15ZEwvAo/RTIx3MGuz/DHmlwNcZ+2ebPM5/IcQ1TcISBnp/X58vONWWju0fgK/iNIMe1Gfm8m/mPn8ydb6h0ihTyh7eS2SbMD5IqWSlIzMqZB+Jj6pjmKnu9swLBHjWtBEG0JvXCwj0gg54Cn3yd1ncc5MQ4sU58GbLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHIV/drp0u2jkPhbMO68xNm2bI/rewPcHrFsfV2MFoY=;
 b=FHXsDHSNtirHXTH5Jnb0huatQ/DaJnSeoK/k8tXXXFPKXyw+EadCT7LWYFg3pSZbjN9xXKpPbK9htJW6HJL5MtfoXUQPVriZKkbbeETjayaa1A19dwmnDwSWP9ktJlKDHfoRAA1ft3ug3DLEpDofr9q5L3XbNNuqUXEujdrO87uKEMWVyKdxvh0wqfRqcknZiD1Q2pFF5dmq3u3Yrpz1nhabtZJ2+D90pmm4r7lC59YZOAuAHbdhc5C8MhIFdMro4NgLqMzZWicr6c3QnOK3m6W28eVbM6fU7ZuK0qhNCWMLGFBb1oxugJpg4flQHw3W5bN3n5mWQCKlrxq7sHoS9g==
Received: from BL3PR02MB7986.namprd02.prod.outlook.com (2603:10b6:208:355::19)
 by SA0PR02MB7161.namprd02.prod.outlook.com (2603:10b6:806:e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Sat, 10 Dec
 2022 17:46:27 +0000
Received: from BL3PR02MB7986.namprd02.prod.outlook.com
 ([fe80::446d:8a7c:9ae1:1b4c]) by BL3PR02MB7986.namprd02.prod.outlook.com
 ([fe80::446d:8a7c:9ae1:1b4c%4]) with mapi id 15.20.5880.019; Sat, 10 Dec 2022
 17:46:27 +0000
From:   "Kallol Biswas [C]" <kallol.biswas@nutanix.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: uefi secureboot vm and IO window overlap
Thread-Topic: uefi secureboot vm and IO window overlap
Thread-Index: AdkL/kAMfOYsiVCGQGy3hYquUACg9wAEm5qAACukRQA=
Date:   Sat, 10 Dec 2022 17:46:27 +0000
Message-ID: <BL3PR02MB79864D31613689D74B1E05A3FE1F9@BL3PR02MB7986.namprd02.prod.outlook.com>
References: <BL3PR02MB798651506589044302A23DFAFE1C9@BL3PR02MB7986.namprd02.prod.outlook.com>
 <20221209205617.GA1732532@bhelgaas>
In-Reply-To: <20221209205617.GA1732532@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB7986:EE_|SA0PR02MB7161:EE_
x-ms-office365-filtering-correlation-id: 23de48ed-695d-468d-6299-08dadad6768d
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5UEUC35hOAErUMHzMBG5M0AATok2ZA5UDSWIYUegvC77z9KQH32axXlLnlDenxHTuI/YbuJRUUPXaz5baU2NdRyZ2URcr/kfMW738wph0QBCq4W1i5BtyH53/lxNw/pBk68Oc3H2u08quY4OPIAV61jxEd1yUQ+qu8VepW3eDWnqBhhQrgfbMPma+Lq8XIx8PH/rSVAVI5vsJAehShNO5HCkz4kREZrw+T5QDgGk0f/SHnNThpEb3Hk8TJdOn2/gkSs6032OEeOAGrgiazsmubr30Z0xOlensIxMEUZP/iGXEu3WgBLNt+9j7cgi953DQMRXBnUZQsham5YxWIf1PACIQAli3N8d7LyMPnyiyE0g0iVOQKFvTe6AR3M+JMZaGP03InBOUZ9A2lBE6U3qCTSjOiihvlAQoH4xUU65S+gdQ42O3EmDwgGu3zXJ/7QS+XxyEwF3mml+1BOI+5LPqGEsIuf8M6SQiteK7HUqNZXuhbhH6i96OzoJ5RwXbE/iGxoJ2esDNLtbTmBTFdcxH6ngHy/LX7kaPyP2WlCYlkxh2SdrXyio6LaPsGvWQKo2GbGgT+GeQQ4IAvBbJHKimChtYATQrZGJlwcFqCvvb7XUHtVAdn351iJYINFLPARJeucOXRLf3JPrPEUmNzpOZR9GPxzYjvWOW109OgpDAHpdGZusOBE2uktzdQTBwauZlhsZzgPhvVJU6Odp3BP60w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR02MB7986.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199015)(33656002)(38070700005)(55016003)(41300700001)(8936002)(478600001)(71200400001)(52536014)(86362001)(122000001)(38100700002)(5660300002)(53546011)(30864003)(316002)(6916009)(64756008)(66446008)(66946007)(66556008)(66476007)(4326008)(76116006)(8676002)(186003)(9686003)(6506007)(7696005)(83380400001)(26005)(2906002)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XMNgG6PlI5hwRXZvylcPha0sX/GwAqMQmJbDb+T7Rtq9aDGgEkJVTxMfRG?=
 =?iso-8859-1?Q?0i8SduMbMA/QxR/j50imUMya3DIykpOjUTF9UJm3lhlxn0BTRhcE5sAMxT?=
 =?iso-8859-1?Q?D4IIIaFA5fPrzK59Z7wC/jO0wx8XFEnrcpiZ64u+ChhI0W0davJWyuKPco?=
 =?iso-8859-1?Q?flYbT2hmQ/2hRnipIMLtEr4hB8Uh55lgaDYC7ZtpcOebw4YMKAE0S4Tb3p?=
 =?iso-8859-1?Q?u8cerTVTcm2ZnSxet7tzgmWMk/JIIopY5Mll901n/wK9useapeviN9nRQW?=
 =?iso-8859-1?Q?lWwzPap2SPEi/XA5jY6e/zsKhbBOoyC1h6bav28d7o9UE+g+UfVazNzhCB?=
 =?iso-8859-1?Q?tiCnBYL9MUGRJWiUC5jx3wluAPbgsbeDTzxXPeNUFHp7nM7832fSuhb3qS?=
 =?iso-8859-1?Q?4o1zRk6UR9KmaRCaR/v/3XSvGWioUPKo84oB6f421Igh7o/Xupegz80549?=
 =?iso-8859-1?Q?4+zM06ZIa3/lBbXbXe3924fR3HH9vmhjUgcLC2TCVOlPc5ZO5mtFvc1BI0?=
 =?iso-8859-1?Q?xYqGe8ZZMzz5dpTsBoKlPC2cpUhbffLwMIUEE8mRnhdBbeV2U56cLUrcc7?=
 =?iso-8859-1?Q?Dt6cfDO1rDcM9bkUmTbSPheMTpykvIV6WBpNOsnXN74hzDtRZoOaPloieN?=
 =?iso-8859-1?Q?1g4C14BJjOz1RdiOrYVZA0IsxJcZOM005rVJLJe7cjDdeDKdTpFgjW0dFf?=
 =?iso-8859-1?Q?WYHch17fnwhJsFcj8a0YxSIsNn8ypVH0pIobRMRoT37P5NqIo5PJECHPiW?=
 =?iso-8859-1?Q?Rsz+3pauEL9In64rFFlUa9hU+YITNLVqVFKDXJG2XkOdvCKHM2Gsr6T2VY?=
 =?iso-8859-1?Q?KKtRNqMql3596NfjtjB1mIGX1Ed/7Z1MMQvrwZdUisA7VJB8OldMXFJeio?=
 =?iso-8859-1?Q?w3OxNQSiuP/H1muQME+eLjLbKiirNRpDUkKSXc7xk81uHbHmCpxP8QzeFv?=
 =?iso-8859-1?Q?pEZMx+BCGywrpgHEnDmJkvkvyPTiod0+p0joMQsfpYp1PU9CR9cg1pxJFC?=
 =?iso-8859-1?Q?MzIHq1d9+651qyxZFcO3yVc2nLOlsJtd+EqRcxU/JDtNa+WrMCLqFr76gT?=
 =?iso-8859-1?Q?4FFW3okEHw8rjqCWW2JhnQ8dhbH7ClJyfF3I6seEukGojzs5j36MjOdHR3?=
 =?iso-8859-1?Q?YBQHytFi/vFqXIJKXEtICFX0aDjVoKDXiN/NxPUKi/AtE0jz3M8QN4VeUR?=
 =?iso-8859-1?Q?Q6+mxiJ8mL4eSKz5QTmgmMVi6dgby+eTECSJReukdM9y6mluOd5NvHKKMb?=
 =?iso-8859-1?Q?24GARM93UmisWSQVlMhpZ3FaG8vcEmgVJgjMr9nc4GyZMumu3q2/Z6EqbT?=
 =?iso-8859-1?Q?UlFM9OmjTfhEqtWKo6NILQUoLrA553hRRswFg3ikUVXtApUGdKWuCsux7X?=
 =?iso-8859-1?Q?9i0LJJB0tLAxqimyIhuzLbKBqDgP0WFwE3K6FvaKI4qThGqeWazREolGoX?=
 =?iso-8859-1?Q?NNiqfhPEQD0n3hpbqAqLcwMLxuH7LiKoPzMwv+t3AxQN77VWRGneZTPcWA?=
 =?iso-8859-1?Q?M7kEIL0WK/t6CiY/Q7NhyAZ1mAad2H5Y/KD3u/Hu3B9NAoD5c7SUgC6YE7?=
 =?iso-8859-1?Q?IYPCU/zeO4HZRVl3LCiVjcNHkie324Y8q/CHGGN68nBl2tAJ0P7FDkS59+?=
 =?iso-8859-1?Q?WvgltGC7adEyBobu1gaBax6Cu/J/+V6PniilqiK7iCXzJDoIgL1IKLCA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB7986.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23de48ed-695d-468d-6299-08dadad6768d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2022 17:46:27.3024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zLNizG0vHvKCqLDFeYKAI1mSDpQwyE0QPtDOZ/xvmUeUvALtPUJNELLgiqnOlj+v4tp9kmWkuAo4nX0y0nl0HYa8bXqlqK6jtsK8fj2ZraE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7161
X-Proofpoint-GUID: ObadLWy1wYsDoDkzZUkJAls9iUHCFK-y
X-Proofpoint-ORIG-GUID: ObadLWy1wYsDoDkzZUkJAls9iUHCFK-y
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

Part2 of the dmesg:

[    0.971206] PM: Registering ACPI NVS region [mem 0x7b37f000-0x7b3fefff] =
(524288 bytes)
[    0.972217] atomic64 test passed for x86-64 platform with CX8 and with S=
SE
[    0.972221] pinctrl core: initialized pinctrl subsystem
[    0.972335] RTC time: 22:21:18, date: 12/09/22
[    0.972479] NET: Registered protocol family 16
[    0.972981] ACPI: bus type PCI registered
[    0.972984] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.973212] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xb0000000=
-0xbfffffff] (base 0xb0000000)
[    0.973217] PCI: MMCONFIG at [mem 0xb0000000-0xbfffffff] reserved in E82=
0
[    0.973225] PCI: Using configuration type 1 for base access
[    0.979542] ACPI: Added _OSI(Module Device)
[    0.979545] ACPI: Added _OSI(Processor Device)
[    0.979547] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.979549] ACPI: Added _OSI(Processor Aggregator Device)
[    0.979551] ACPI: Added _OSI(Linux-Dell-Video)
[    0.982203] ACPI: EC: Look up EC in DSDT
[    0.988952] ACPI: Interpreter enabled
[    0.988962] ACPI: (supports S0 S5)
[    0.988964] ACPI: Using IOAPIC for interrupt routing
[    0.988985] PCI: Using host bridge windows from ACPI; if necessary, use =
"pci=3Dnocrs" and report a bug
[    0.989055] ACPI: Enabled 3 GPEs in block 00 to 3F
[    1.027331] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    1.027337] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cloc=
kPM Segments MSI]
[    1.027410] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotp=
lug PME AER PCIeCapability]
[    1.027532] PCI host bridge to bus 0000:00
[    1.027535] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window=
]
[    1.027537] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window=
]
[    1.027540] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bfff=
f window]
[    1.027543] pci_bus 0000:00: root bus resource [mem 0x80000000-0xaffffff=
f window]
[    1.027546] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebffff=
f window]
[    1.027550] pci_bus 0000:00: root bus resource [mem 0x84000000000-0x847f=
fffffff window]
[    1.027553] pci_bus 0000:00: root bus resource [bus 00-ff]
[    1.027586] pci 0000:00:00.0: [8086:29c0] type 00 class 0x060000
[    1.027923] pci 0000:00:01.0: [1234:1111] type 00 class 0x030000
[    1.029771] pci 0000:00:01.0: reg 0x10: [mem 0xc0000000-0xc0ffffff pref]
[    1.032365] pci 0000:00:01.0: reg 0x18: [mem 0xc1646000-0xc1646fff]
[    1.037370] pci 0000:00:01.0: reg 0x30: [mem 0xffff0000-0xffffffff pref]
[    1.037561] pci 0000:00:02.0: [1b36:000c] type 01 class 0x060400
[    1.038683] pci 0000:00:02.0: reg 0x10: [mem 0xc1645000-0xc1645fff]
[    1.041333] pci 0000:00:02.1: [1b36:000c] type 01 class 0x060400
[    1.042160] pci 0000:00:02.1: reg 0x10: [mem 0xc1644000-0xc1644fff]
[    1.044256] pci 0000:00:02.2: [1b36:000c] type 01 class 0x060400
[    1.045132] pci 0000:00:02.2: reg 0x10: [mem 0xc1643000-0xc1643fff]
[    1.047264] pci 0000:00:03.0: [1af4:1000] type 00 class 0x020000
[    1.048660] pci 0000:00:03.0: reg 0x10: [io  0x82c0-0x82df]
[    1.050053] pci 0000:00:03.0: reg 0x14: [mem 0xc1642000-0xc1642fff]
[    1.053606] pci 0000:00:03.0: reg 0x20: [mem 0x84000200000-0x84000203fff=
 64bit pref]
[    1.054555] pci 0000:00:03.0: reg 0x30: [mem 0xfffc0000-0xffffffff pref]
[    1.055180] pci 0000:00:1d.0: [8086:2934] type 00 class 0x0c0300
[    1.057124] pci 0000:00:1d.0: reg 0x20: [io  0x82a0-0x82bf]
[    1.058008] pci 0000:00:1d.1: [8086:2935] type 00 class 0x0c0300
[    1.060291] pci 0000:00:1d.1: reg 0x20: [io  0x8280-0x829f]
[    1.062049] pci 0000:00:1d.2: [8086:2936] type 00 class 0x0c0300
[    1.063856] pci 0000:00:1d.2: reg 0x20: [io  0x8260-0x827f]
[    1.064697] pci 0000:00:1d.7: [8086:293a] type 00 class 0x0c0320
[    1.065087] pci 0000:00:1d.7: reg 0x10: [mem 0xc1641000-0xc1641fff]
[    1.067311] pci 0000:00:1f.0: [8086:2918] type 00 class 0x060100
[    1.067694] pci 0000:00:1f.0: quirk: [io  0x0600-0x067f] claimed by ICH6=
 ACPI/GPIO/TCO
[    1.067872] pci 0000:00:1f.2: [8086:2922] type 00 class 0x010601
[    1.071400] pci 0000:00:1f.2: reg 0x20: [io  0x8240-0x825f]
[    1.072956] pci 0000:00:1f.2: reg 0x24: [mem 0xc1640000-0xc1640fff]
[    1.073880] pci 0000:00:1f.3: [8086:2930] type 00 class 0x0c0500
[    1.074144] pci 0000:00:1f.3: reg 0x20: [io  0x8200-0x823f]
[    1.074837] pci 0000:01:00.0: [1af4:1048] type 00 class 0x010000
[    1.076178] pci 0000:01:00.0: reg 0x14: [mem 0xc1400000-0xc1400fff]
[    1.078151] pci 0000:01:00.0: reg 0x20: [mem 0x84000000000-0x84000003fff=
 64bit pref]
[    1.079523] pci 0000:00:02.0: PCI bridge to [bus 01]
[    1.079541] pci 0000:00:02.0:   bridge window [io  0x8000-0x8fff]
[    1.079556] pci 0000:00:02.0:   bridge window [mem 0xc1400000-0xc15fffff=
]
[    1.079584] pci 0000:00:02.0:   bridge window [mem 0x84000000000-0x84000=
0fffff 64bit pref]
[    1.080227] pci 0000:02:00.0: [1af4:1045] type 00 class 0x00ff00
[    1.082135] pci 0000:02:00.0: reg 0x20: [mem 0x84000100000-0x84000103fff=
 64bit pref]
[    1.083830] pci 0000:00:02.1: PCI bridge to [bus 02]
[    1.083847] pci 0000:00:02.1:   bridge window [io  0x7000-0x7fff]
[    1.083861] pci 0000:00:02.1:   bridge window [mem 0xc1200000-0xc13fffff=
]
[    1.083890] pci 0000:00:02.1:   bridge window [mem 0x84000100000-0x84000=
1fffff 64bit pref]
[    1.084447] pci 0000:00:02.2: PCI bridge to [bus 03]
[    1.084464] pci 0000:00:02.2:   bridge window [io  0x6000-0x6fff]
[    1.084479] pci 0000:00:02.2:   bridge window [mem 0xc1000000-0xc11fffff=
]
[    1.086391] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
[    1.086452] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
[    1.086508] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
[    1.086563] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
[    1.086620] ACPI: PCI Interrupt Link [LNKE] (IRQs 5 *10 11)
[    1.086680] ACPI: PCI Interrupt Link [LNKF] (IRQs 5 *10 11)
[    1.086733] ACPI: PCI Interrupt Link [LNKG] (IRQs 5 10 *11)
[    1.086788] ACPI: PCI Interrupt Link [LNKH] (IRQs 5 10 *11)
[    1.086813] ACPI: PCI Interrupt Link [GSIA] (IRQs *16)
[    1.086821] ACPI: PCI Interrupt Link [GSIB] (IRQs *17)
[    1.086827] ACPI: PCI Interrupt Link [GSIC] (IRQs *18)
[    1.086834] ACPI: PCI Interrupt Link [GSID] (IRQs *19)
[    1.086841] ACPI: PCI Interrupt Link [GSIE] (IRQs *20)
[    1.086848] ACPI: PCI Interrupt Link [GSIF] (IRQs *21)
[    1.086854] ACPI: PCI Interrupt Link [GSIG] (IRQs *22)
[    1.086861] ACPI: PCI Interrupt Link [GSIH] (IRQs *23)
[    1.096292] vgaarb: device added: PCI:0000:00:01.0,decodes=3Dio+mem,owns=
=3Dio+mem,locks=3Dnone
[    1.096297] vgaarb: loaded
[    1.096299] vgaarb: bridge control possible 0000:00:01.0
[    1.096498] SCSI subsystem initialized
[    1.096518] ACPI: bus type USB registered
[    1.096533] usbcore: registered new interface driver usbfs
[    1.096541] usbcore: registered new interface driver hub
[    1.096804] usbcore: registered new device driver usb
[    1.097217] EDAC MC: Ver: 3.0.0
[    1.097604] PCI: Using ACPI for IRQ routing
[    1.152296] PCI: pci_cache_line_size set to 64 bytes
[    1.152358] pci 0000:00:03.0: can't claim BAR 0 [io  0x82c0-0x82df]: add=
ress conflict with PCI Bus 0000:01 [io  0x8000-0x8fff]
[    1.152371] pci 0000:00:1d.0: can't claim BAR 4 [io  0x82a0-0x82bf]: add=
ress conflict with PCI Bus 0000:01 [io  0x8000-0x8fff]
[    1.152382] pci 0000:00:1d.1: can't claim BAR 4 [io  0x8280-0x829f]: add=
ress conflict with PCI Bus 0000:01 [io  0x8000-0x8fff]
[    1.152393] pci 0000:00:1d.2: can't claim BAR 4 [io  0x8260-0x827f]: add=
ress conflict with PCI Bus 0000:01 [io  0x8000-0x8fff]
[    1.152418] pci 0000:00:1f.2: can't claim BAR 4 [io  0x8240-0x825f]: add=
ress conflict with PCI Bus 0000:01 [io  0x8000-0x8fff]
[    1.152429] pci 0000:00:1f.3: can't claim BAR 4 [io  0x8200-0x823f]: add=
ress conflict with PCI Bus 0000:01 [io  0x8000-0x8fff]
[    1.152536] e820: reserve RAM buffer [mem 0x79348018-0x7bffffff]
[    1.152539] e820: reserve RAM buffer [mem 0x795e0018-0x7bffffff]
[    1.152540] e820: reserve RAM buffer [mem 0x7a052000-0x7bffffff]
[    1.152542] e820: reserve RAM buffer [mem 0x7b0ef000-0x7bffffff]
[    1.152543] e820: reserve RAM buffer [mem 0x7ff7c000-0x7fffffff]
[    1.152786] NetLabel: Initializing
[    1.152788] NetLabel:  domain hash size =3D 128
[    1.152790] NetLabel:  protocols =3D UNLABELED CIPSOv4
[    1.152804] NetLabel:  unlabeled traffic allowed by default
[    1.153048] amd_nb: Cannot enumerate AMD northbridges
[    1.153191] Switched to clocksource kvm-clock
[    1.158706] pnp: PnP ACPI init
[    1.158716] ACPI: bus type PNP registered
[    1.158773] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    1.158809] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 (active)
[    1.158835] pnp 00:02: Plug and Play ACPI device, IDs PNP0f13 (active)
[    1.159239] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 (active)
[    1.163807] pnp: PnP ACPI: found 4 devices
[    1.163810] ACPI: bus type PNP unregistered
[    1.170404] pci 0000:00:01.0: can't claim BAR 6 [mem 0xffff0000-0xffffff=
ff pref]: no compatible bridge window
[    1.170410] pci 0000:00:03.0: can't claim BAR 6 [mem 0xfffc0000-0xffffff=
ff pref]: no compatible bridge window
[    1.172145] pci 0000:00:02.2: bridge window [mem 0x00100000-0x000fffff 6=
4bit pref] to [bus 03] add_size 200000 add_align 100000
[    1.172153] pci 0000:00:02.2: res[15]=3D[mem 0x00100000-0x000fffff 64bit=
 pref] res_to_dev_res add_size 200000 min_align 100000
[    1.172155] pci 0000:00:02.2: res[15]=3D[mem 0x00100000-0x002fffff 64bit=
 pref] res_to_dev_res add_size 200000 min_align 100000
[    1.172160] pci 0000:00:02.2: BAR 15: assigned [mem 0x84000300000-0x8400=
04fffff 64bit pref]
[    1.172165] pci 0000:00:03.0: BAR 6: assigned [mem 0x80000000-0x8003ffff=
 pref]
[    1.172175] pci 0000:00:01.0: BAR 6: assigned [mem 0x80040000-0x8004ffff=
 pref]
[    1.172179] pci 0000:00:1f.3: BAR 4: assigned [io  0x1000-0x103f]
[    1.172199] pci 0000:00:03.0: BAR 0: assigned [io  0x1040-0x105f]
[    1.172678] pci 0000:00:1d.0: BAR 4: assigned [io  0x1060-0x107f]
[    1.173149] pci 0000:00:1d.1: BAR 4: assigned [io  0x1080-0x109f]
[    1.173637] pci 0000:00:1d.2: BAR 4: assigned [io  0x10a0-0x10bf]
[    1.174102] pci 0000:00:1f.2: BAR 4: assigned [io  0x10c0-0x10df]
[    1.174567] pci 0000:00:02.0: PCI bridge to [bus 01]
[    1.174577] pci 0000:00:02.0:   bridge window [io  0x8000-0x8fff]
[    1.175344] pci 0000:00:02.0:   bridge window [mem 0xc1400000-0xc15fffff=
]
[    1.175847] pci 0000:00:02.0:   bridge window [mem 0x84000000000-0x84000=
0fffff 64bit pref]
[    1.176856] pci 0000:00:02.1: PCI bridge to [bus 02]
[    1.176868] pci 0000:00:02.1:   bridge window [io  0x7000-0x7fff]
[    1.177626] pci 0000:00:02.1:   bridge window [mem 0xc1200000-0xc13fffff=
]
[    1.178132] pci 0000:00:02.1:   bridge window [mem 0x84000100000-0x84000=
1fffff 64bit pref]
[    1.179179] pci 0000:00:02.2: PCI bridge to [bus 03]
[    1.179191] pci 0000:00:02.2:   bridge window [io  0x6000-0x6fff]
[    1.179960] pci 0000:00:02.2:   bridge window [mem 0xc1000000-0xc11fffff=
]
[    1.180468] pci 0000:00:02.2:   bridge window [mem 0x84000300000-0x84000=
4fffff 64bit pref]
[    1.182012] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    1.182014] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    1.182015] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff windo=
w]
[    1.182016] pci_bus 0000:00: resource 7 [mem 0x80000000-0xafffffff windo=
w]
[    1.182017] pci_bus 0000:00: resource 8 [mem 0xc0000000-0xfebfffff windo=
w]
[    1.182018] pci_bus 0000:00: resource 9 [mem 0x84000000000-0x847ffffffff=
 window]
[    1.182019] pci_bus 0000:01: resource 0 [io  0x8000-0x8fff]
[    1.182020] pci_bus 0000:01: resource 1 [mem 0xc1400000-0xc15fffff]
[    1.182021] pci_bus 0000:01: resource 2 [mem 0x84000000000-0x840000fffff=
 64bit pref]
[    1.182022] pci_bus 0000:02: resource 0 [io  0x7000-0x7fff]
[    1.182023] pci_bus 0000:02: resource 1 [mem 0xc1200000-0xc13fffff]
[    1.182024] pci_bus 0000:02: resource 2 [mem 0x84000100000-0x840001fffff=
 64bit pref]
[    1.182025] pci_bus 0000:03: resource 0 [io  0x6000-0x6fff]
[    1.182026] pci_bus 0000:03: resource 1 [mem 0xc1000000-0xc11fffff]
[    1.182027] pci_bus 0000:03: resource 2 [mem 0x84000300000-0x840004fffff=
 64bit pref]
[    1.182140] NET: Registered protocol family 2
[    1.182885] TCP established hash table entries: 131072 (order: 8, 104857=
6 bytes)
[    1.183081] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    1.183238] TCP: Hash tables configured (established 131072 bind 65536)
[    1.183259] TCP: reno registered
[    1.183288] UDP hash table entries: 8192 (order: 6, 262144 bytes)
[    1.183342] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes)
[    1.183813] NET: Registered protocol family 1
[    1.183853] pci 0000:00:01.0: Boot video device
[    1.184145] ACPI: PCI Interrupt Link [GSIA] enabled at IRQ 16
[    1.184912] ACPI: PCI Interrupt Link [GSIB] enabled at IRQ 17
[    1.185617] ACPI: PCI Interrupt Link [GSIC] enabled at IRQ 18
[    1.186311] ACPI: PCI Interrupt Link [GSID] enabled at IRQ 19
[    1.186872] PCI: CLS 0 bytes, default 64
[    1.186909] Unpacking initramfs...
[    1.550502] Freeing initrd memory: 31004k freed
[    1.556219] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.556225] software IO TLB [mem 0x73fdf000-0x77fdf000] (64MB) mapped at=
 [ffff957773fdf000-ffff957777fdefff]
[    1.558423] sha1_ssse3: Using SHA-NI optimized SHA-1 implementation
[    1.558475] sha256_ssse3: Using SHA-256-NI optimized SHA-256 implementat=
ion
[    1.560662] futex hash table entries: 65536 (order: 10, 4194304 bytes)
[    1.561221] Initialise system trusted keyring
[    1.561267] audit: initializing netlink socket (disabled)
[    1.561279] type=3D2000 audit(1670624479.968:1): initialized
[    1.582873] HugeTLB registered 1 GB page size, pre-allocated 0 pages
[    1.582876] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    1.583943] zpool: loaded
[    1.583947] zbud: loaded
[    1.584207] VFS: Disk quotas dquot_6.5.2
[    1.584323] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.584710] msgmni has been set to 23622
[    1.584804] Key type big_key registered
[    1.584807] SELinux:  Registering netfilter hooks
[    1.587358] NET: Registered protocol family 38
[    1.587366] Key type asymmetric registered
[    1.587370] Asymmetric key parser 'x509' registered
[    1.587422] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 248)
[    1.587606] io scheduler noop registered
[    1.587609] io scheduler deadline registered (default)
[    1.587660] io scheduler cfq registered
[    1.587664] io scheduler mq-deadline registered
[    1.587668] io scheduler kyber registered
[    1.588035] ACPI: PCI Interrupt Link [GSIG] enabled at IRQ 22
[    1.588283] pcieport 0000:00:02.0: irq 24 for MSI/MSI-X
[    1.589383] pcieport 0000:00:02.1: irq 25 for MSI/MSI-X
[    1.590369] pcieport 0000:00:02.2: irq 26 for MSI/MSI-X
[    1.591091] aer 0000:00:02.0:pcie002: service driver aer loaded
[    1.591209] aer 0000:00:02.1:pcie002: service driver aer loaded
[    1.591320] aer 0000:00:02.2:pcie002: service driver aer loaded
[    1.591358] pcieport 0000:00:02.0: Signaling PME through PCIe PME interr=
upt
[    1.591360] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
[    1.591377] pcie_pme 0000:00:02.0:pcie001: service driver pcie_pme loade=
d
[    1.591408] pcieport 0000:00:02.1: Signaling PME through PCIe PME interr=
upt
[    1.591410] pci 0000:02:00.0: Signaling PME through PCIe PME interrupt
[    1.591426] pcie_pme 0000:00:02.1:pcie001: service driver pcie_pme loade=
d
[    1.591456] pcieport 0000:00:02.2: Signaling PME through PCIe PME interr=
upt
[    1.591472] pcie_pme 0000:00:02.2:pcie001: service driver pcie_pme loade=
d
[    1.591484] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    1.591513] pciehp 0000:00:02.0:pcie004: Slot #0 AttnBtn+ PwrCtrl+ MRL- =
AttnInd+ PwrInd+ HotPlug+ Surprise+ Interlock+ NoCompl- LLActRep+
[    1.591606] pciehp 0000:00:02.0:pcie004: service driver pciehp loaded
[    1.591636] pciehp 0000:00:02.1:pcie004: Slot #0 AttnBtn+ PwrCtrl+ MRL- =
AttnInd+ PwrInd+ HotPlug+ Surprise+ Interlock+ NoCompl- LLActRep+
[    1.591716] pciehp 0000:00:02.1:pcie004: service driver pciehp loaded
[    1.591740] pciehp 0000:00:02.2:pcie004: Slot #0 AttnBtn+ PwrCtrl+ MRL- =
AttnInd+ PwrInd+ HotPlug+ Surprise+ Interlock+ NoCompl- LLActRep+
[    1.591817] pciehp 0000:00:02.2:pcie004: service driver pciehp loaded
[    1.591820] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    1.591833] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    1.591893] efifb: probing for efifb
[    1.591902] efifb: framebuffer at 0xc0000000, mapped to 0xffffa4b7c20000=
00, using 5120k, total 5120k
[    1.591906] efifb: mode is 1280x1024x32, linelength=3D5120, pages=3D1
[    1.591908] efifb: scrolling: redraw
[    1.591910] efifb: Truecolor: size=3D8:8:8:8, shift=3D24:16:8:0
[    1.595551] Console: switching to colour frame buffer device 160x64
[    1.597550] fb0: EFI VGA frame buffer device
[    1.597688] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input0
[    1.597709] ACPI: Power Button [PWRF]
[    1.598249] GHES: HEST is not enabled!
[    1.598319] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    1.621318] 00:03: ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
[    1.621761] Non-volatile memory driver v1.3
[    1.621801] Linux agpgart interface v0.103
[    1.621912] crash memory driver: version 1.1
[    1.622034] rdac: device handler registered
[    1.622077] hp_sw: device handler registered
[    1.622089] emc: device handler registered
[    1.622301] alua: device handler registered
[    1.622338] libphy: Fixed MDIO Bus: probed
[    1.622384] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.622403] ehci-pci: EHCI PCI platform driver
[    1.623018] ehci-pci 0000:00:1d.7: EHCI Host Controller
[    1.623074] ehci-pci 0000:00:1d.7: new USB bus registered, assigned bus =
number 1
[    1.623259] ehci-pci 0000:00:1d.7: irq 19, io mem 0xc1641000
[    1.629193] ehci-pci 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    1.629243] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[    1.629260] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.629278] usb usb1: Product: EHCI Host Controller
[    1.629291] usb usb1: Manufacturer: Linux 3.10.0-957.el7.x86_64 ehci_hcd
[    1.629307] usb usb1: SerialNumber: 0000:00:1d.7
[    1.629412] hub 1-0:1.0: USB hub found
[    1.629425] hub 1-0:1.0: 6 ports detected
[    1.629572] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.629591] ohci-pci: OHCI PCI platform driver
[    1.629608] uhci_hcd: USB Universal Host Controller Interface driver
[    1.630201] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    1.630259] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus =
number 2
[    1.630292] uhci_hcd 0000:00:1d.0: detected 2 ports
[    1.630372] uhci_hcd 0000:00:1d.0: irq 16, io base 0x00001060
[    1.631072] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    1.631732] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.632376] usb usb2: Product: UHCI Host Controller
[    1.632997] usb usb2: Manufacturer: Linux 3.10.0-957.el7.x86_64 uhci_hcd
[    1.633648] usb usb2: SerialNumber: 0000:00:1d.0
[    1.634348] hub 2-0:1.0: USB hub found
[    1.634980] hub 2-0:1.0: 2 ports detected
[    1.636264] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    1.636924] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus =
number 3
[    1.637570] uhci_hcd 0000:00:1d.1: detected 2 ports
[    1.638243] uhci_hcd 0000:00:1d.1: irq 17, io base 0x00001080
[    1.642738] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    1.643674] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.644275] usb usb3: Product: UHCI Host Controller
[    1.644857] usb usb3: Manufacturer: Linux 3.10.0-957.el7.x86_64 uhci_hcd
[    1.645452] usb usb3: SerialNumber: 0000:00:1d.1
[    1.646116] hub 3-0:1.0: USB hub found
[    1.646717] hub 3-0:1.0: 2 ports detected
[    1.647874] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    1.648503] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus =
number 4
[    1.649076] uhci_hcd 0000:00:1d.2: detected 2 ports
[    1.649731] uhci_hcd 0000:00:1d.2: irq 18, io base 0x000010a0
[    1.650353] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    1.650906] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    1.651484] usb usb4: Product: UHCI Host Controller
[    1.652037] usb usb4: Manufacturer: Linux 3.10.0-957.el7.x86_64 uhci_hcd
[    1.652606] usb usb4: SerialNumber: 0000:00:1d.2
[    1.653252] hub 4-0:1.0: USB hub found
[    1.653802] hub 4-0:1.0: 2 ports detected
[    1.654457] usbcore: registered new interface driver usbserial_generic
[    1.655012] usbserial: USB Serial support registered for generic
[    1.655605] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x6=
0,0x64 irq 1,12
[    1.656784] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.657358] serio: i8042 AUX port at 0x60,0x64 irq 12
[    1.658002] mousedev: PS/2 mouse device common for all mice
[    1.658828] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input1
[    1.659599] rtc_cmos 00:00: RTC can wake from S4
[    1.659975] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042=
/serio1/input/input2
[    1.660197] input: VirtualPS/2 VMware VMMouse as /devices/platform/i8042=
/serio1/input/input3
[    1.661622] rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
[    1.662299] rtc_cmos 00:00: alarms up to one day, y3k, 114 bytes nvram
[    1.662935] cpuidle: using governor menu
[    1.664025] EFI Variables Facility v0.08 2004-May-17
[    1.664890] hidraw: raw HID events driver (C) Jiri Kosina
[    1.665602] usbcore: registered new interface driver usbhid
[    1.666209] usbhid: USB HID core driver
[    1.666888] drop_monitor: Initializing network drop monitor service
[    1.667749] TCP: cubic registered
[    1.668351] Initializing XFRM netlink socket
[    1.669283] NET: Registered protocol family 10
[    1.670601] NET: Registered protocol family 17
[    1.671250] mpls_gso: MPLS GSO support
[    1.672388] PM: Hibernation image not present or could not be loaded.
[    1.672391] Loading compiled-in X.509 certificates
[    1.672997] Loaded X.509 cert 'CentOS Linux kpatch signing key: ea041315=
2cde1d98ebdca3fe6f0230904c9ef717'
[    1.673644] Loaded X.509 cert 'CentOS Linux Driver update signing key: 7=
f421ee0ab69461574bb358861dbe77762a4201b'
[    1.674569] Loaded X.509 cert 'CentOS Linux kernel signing key: b70dcf0d=
f2d9b7f29159248249fd6fe87b781427'
[    1.675209] registered taskstats version 1
[    1.677595] Key type trusted registered
[    1.679543] Key type encrypted registered
[    1.680255] IMA: No TPM chip found, activating TPM-bypass! (rc=3D-19)
[    1.681441]   Magic number: 2:870:400
[    1.682089] clockevents clockevent113: hash matches
[    1.682941] rtc_cmos 00:00: setting system clock to 2022-12-09 22:21:19 =
UTC (1670624479)
[    1.684430] Freeing unused kernel memory: 1876k freed
[    1.685403] Write protecting the kernel read-only data: 12288k
[    1.687079] Freeing unused kernel memory: 516k freed
[    1.688745] Freeing unused kernel memory: 600k freed
[    1.692321] random: systemd: uninitialized urandom read (16 bytes read)
[    1.693441] random: systemd: uninitialized urandom read (16 bytes read)
[    1.694076] random: systemd: uninitialized urandom read (16 bytes read)
[    1.696274] systemd[1]: systemd 219 running in system mode. (+PAM +AUDIT=
 +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNU=
TLS +ACL +XZ +LZ4 -SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
[    1.697583] systemd[1]: Detected virtualization kvm.
[    1.698232] systemd[1]: Detected architecture x86-64.
[    1.698856] systemd[1]: Running in initial RAM disk.
[    1.701504] systemd[1]: Set hostname to <localhost.localdomain>.
[    1.720343] random: systemd: uninitialized urandom read (16 bytes read)
[    1.721015] random: systemd: uninitialized urandom read (16 bytes read)
[    1.721699] random: systemd: uninitialized urandom read (16 bytes read)
[    1.722363] random: systemd: uninitialized urandom read (16 bytes read)
[    1.723401] random: systemd: uninitialized urandom read (16 bytes read)
[    1.724115] random: systemd: uninitialized urandom read (16 bytes read)
[    1.724938] random: systemd: uninitialized urandom read (16 bytes read)
[    1.727878] systemd[1]: Reached target Timers.
[    1.729301] systemd[1]: Created slice Root Slice.
[    1.730571] systemd[1]: Created slice System Slice.
[    1.731823] systemd[1]: Reached target Slices.
[    1.733088] systemd[1]: Listening on Journal Socket.
[    1.734713] systemd[1]: Starting Setup Virtual Console...
[    1.736233] systemd[1]: Starting Journal Service...
[    1.737727] systemd[1]: Starting Create list of required static device n=
odes for the current kernel...
[    1.742442] systemd[1]: Listening on udev Kernel Socket.
[    1.744094] systemd[1]: Starting dracut cmdline hook...
[    1.745476] systemd[1]: Reached target Swap.
[    1.746856] systemd[1]: Listening on udev Control Socket.
[    1.748242] systemd[1]: Reached target Sockets.
[    1.749872] systemd[1]: Starting Apply Kernel Variables...
[    1.751282] systemd[1]: Reached target Local File Systems.
[    1.752915] systemd[1]: Started Create list of required static device no=
des for the current kernel.
[    1.754593] systemd[1]: Started Apply Kernel Variables.
[    1.756652] systemd[1]: Starting Create Static Device Nodes in /dev...
[    1.758475] systemd[1]: Started Create Static Device Nodes in /dev.
[    1.764949] systemd[1]: Started Journal Service.
[    1.830416] device-mapper: uevent: version 1.0.3
[    1.831243] device-mapper: ioctl: 4.37.1-ioctl (2018-04-03) initialised:=
 dm-devel@redhat.com
[    1.938664] ACPI: PCI Interrupt Link [GSIH] enabled at IRQ 23
[    1.942364] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    1.950611] libata version 3.00 loaded.
[    1.961061] ahci 0000:00:1f.2: version 3.0
[    1.961929] ahci 0000:00:1f.2: irq 27 for MSI/MSI-X
[    1.962453] ahci 0000:00:1f.2: AHCI 0001.0000 32 slots 6 ports 1.5 Gbps =
0x3f impl SATA mode
[    1.963670] ahci 0000:00:1f.2: flags: 64bit ncq only=20
[    1.966521] scsi host0: ahci
[    1.967825] scsi host1: ahci
[    1.969345] scsi host2: ahci
[    1.970595] scsi host3: ahci
[    1.971952] scsi host4: ahci
[    1.974520] scsi host5: ahci
[    1.975402] ata1: SATA max UDMA/133 abar m4096@0xc1640000 port 0xc164010=
0 irq 27
[    1.976138] ata2: SATA max UDMA/133 abar m4096@0xc1640000 port 0xc164018=
0 irq 27
[    1.976851] ata3: SATA max UDMA/133 abar m4096@0xc1640000 port 0xc164020=
0 irq 27
[    1.977532] ata4: SATA max UDMA/133 abar m4096@0xc1640000 port 0xc164028=
0 irq 27
[    1.978193] ata5: SATA max UDMA/133 abar m4096@0xc1640000 port 0xc164030=
0 irq 27
[    1.978836] ata6: SATA max UDMA/133 abar m4096@0xc1640000 port 0xc164038=
0 irq 27
[    1.987484] checking generic (c0000000 500000) vs hw (c0000000 1000000)
[    1.987487] fb: conflicting fb hw usage bochsdrmfb vs EFI VGA - removing=
 generic driver
[    1.988193] Console: switching to colour dummy device 80x25
[    1.989025] [drm] Found bochs VGA, ID 0xb0c5.
[    1.989030] [drm] Framebuffer size 16384 kB @ 0xc0000000, mmio @ 0xc1646=
000.
[    1.989817] [TTM] Zone  kernel: Available graphics memory: 6048982 kiB
[    1.989820] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[    1.989823] [TTM] Initializing pool allocator
[    1.989828] [TTM] Initializing DMA pool allocator
[    1.990483] fbcon: bochsdrmfb (fb0) is primary device
[    1.992331] Console: switching to colour frame buffer device 128x48
[    1.994571] bochs-drm 0000:00:01.0: fb0: bochsdrmfb frame buffer device
[    2.003519] virtio-pci 0000:00:03.0: irq 28 for MSI/MSI-X
[    2.003556] virtio-pci 0000:00:03.0: irq 29 for MSI/MSI-X
[    2.003591] virtio-pci 0000:00:03.0: irq 30 for MSI/MSI-X
[    2.003704] virtio-pci 0000:01:00.0: irq 31 for MSI/MSI-X
[    2.003738] virtio-pci 0000:01:00.0: irq 32 for MSI/MSI-X
[    2.003771] virtio-pci 0000:01:00.0: irq 33 for MSI/MSI-X
[    2.003804] virtio-pci 0000:01:00.0: irq 34 for MSI/MSI-X
[    2.003834] virtio-pci 0000:01:00.0: irq 35 for MSI/MSI-X
[    2.003869] virtio-pci 0000:01:00.0: irq 36 for MSI/MSI-X
[    2.003904] virtio-pci 0000:01:00.0: irq 37 for MSI/MSI-X
[    2.006348] virtio-pci 0000:01:00.0: irq 38 for MSI/MSI-X
[    2.006395] virtio-pci 0000:01:00.0: irq 39 for MSI/MSI-X
[    2.006430] virtio-pci 0000:01:00.0: irq 40 for MSI/MSI-X
[    2.006465] virtio-pci 0000:01:00.0: irq 41 for MSI/MSI-X
[    2.006500] virtio-pci 0000:01:00.0: irq 42 for MSI/MSI-X
[    2.006540] virtio-pci 0000:01:00.0: irq 43 for MSI/MSI-X
[    2.006575] virtio-pci 0000:01:00.0: irq 44 for MSI/MSI-X
[    2.006610] virtio-pci 0000:01:00.0: irq 45 for MSI/MSI-X
[    2.006651] virtio-pci 0000:01:00.0: irq 46 for MSI/MSI-X
[    2.006688] virtio-pci 0000:01:00.0: irq 47 for MSI/MSI-X
[    2.006725] virtio-pci 0000:01:00.0: irq 48 for MSI/MSI-X
[    2.006755] virtio-pci 0000:01:00.0: irq 49 for MSI/MSI-X
[    2.006800] virtio-pci 0000:01:00.0: irq 50 for MSI/MSI-X
[    2.006837] virtio-pci 0000:01:00.0: irq 51 for MSI/MSI-X
[    2.006873] virtio-pci 0000:01:00.0: irq 52 for MSI/MSI-X
[    2.006909] virtio-pci 0000:01:00.0: irq 53 for MSI/MSI-X
[    2.006948] virtio-pci 0000:01:00.0: irq 54 for MSI/MSI-X
[    2.007196] [drm] Initialized bochs-drm 1.0.0 20130925 for 0000:00:01.0 =
on minor 0
[    2.007399] virtio-pci 0000:01:00.0: irq 55 for MSI/MSI-X
[    2.007452] virtio-pci 0000:01:00.0: irq 56 for MSI/MSI-X
[    2.007492] virtio-pci 0000:01:00.0: irq 57 for MSI/MSI-X
[    2.010640] scsi host6: Virtio SCSI HBA
[    2.014282] scsi 6:0:0:0: Direct-Access     NUTANIX  VDISK            0 =
   PQ: 0 ANSI: 5
[    2.059819] random: fast init done
[    2.063697] scsi 6:0:0:0: alua: supports implicit TPGS
[    2.063714] scsi 6:0:0:0: alua: device naa.6506b8d9a515c50c86dda140aaf60=
8bc port group 1 rel port ffffffff
[    2.063739] scsi 6:0:0:0: alua: Attached
[    2.069368] scsi 6:0:0:0: alua: transition timeout set to 60 seconds
[    2.069388] scsi 6:0:0:0: alua: port group 01 state A preferred supports=
 tolusna
[    2.074161] usb 1-1: New USB device found, idVendor=3D0627, idProduct=3D=
0001
[    2.074186] usb 1-1: New USB device strings: Mfr=3D1, Product=3D3, Seria=
lNumber=3D10
[    2.074205] usb 1-1: Product: QEMU USB Tablet
[    2.074217] usb 1-1: Manufacturer: QEMU
[    2.074227] usb 1-1: SerialNumber: 28754-0000:00:1d.7-1
[    2.075584] input: QEMU QEMU USB Tablet as /devices/pci0000:00/0000:00:1=
d.7/usb1/1-1/1-1:1.0/input/input4
[    2.075727] hid-generic 0003:0627:0001.0001: input,hidraw0: USB HID v0.0=
1 Mouse [QEMU QEMU USB Tablet] on usb-0000:00:1d.7-1/input0
[    2.284269] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.284474] ata2: SATA link down (SStatus 0 SControl 300)
[    2.284538] ata1.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[    2.284566] ata1.00: applying bridge limits
[    2.285533] ata3: SATA link down (SStatus 0 SControl 300)
[    2.286188] ata4: SATA link down (SStatus 0 SControl 300)
[    2.286874] ata5: SATA link down (SStatus 0 SControl 300)
[    2.287392] ata1.00: configured for UDMA/100
[    2.288006] ata6: SATA link down (SStatus 0 SControl 300)
[    2.288870] scsi 0:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.=
5+ PQ: 0 ANSI: 5
[    2.309974] sd 6:0:0:0: [sda] 209715200 512-byte logical blocks: (107 GB=
/100 GiB)
[    2.310493] sd 6:0:0:0: [sda] 4096-byte physical blocks
[    2.311694] sd 6:0:0:0: [sda] Write Protect is off
[    2.312194] sd 6:0:0:0: [sda] Mode Sense: 6f 00 00 00
[    2.312412] sd 6:0:0:0: [sda] Write cache: disabled, read cache: enabled=
, doesn't support DPO or FUA
[    2.316912]  sda: sda1 sda2 sda3
[    2.318465] sr 0:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
[    2.319042] cdrom: Uniform CD-ROM driver Revision: 3.20
[    2.319859] sr 0:0:0:0: Attached scsi CD-ROM sr0
[    2.319869] sd 6:0:0:0: [sda] Attached SCSI disk
[    2.558243] tsc: Refined TSC clocksource calibration: 2399.990 MHz
[    2.560020] SGI XFS with ACLs, security attributes, no debug enabled
[    2.566336] XFS (dm-0): Mounting V5 Filesystem
[    2.588682] XFS (dm-0): Ending clean mount
[    2.783340] systemd-journald[204]: Received SIGTERM from PID 1 (systemd)=
.
[    2.840814] type=3D1404 audit(1670624480.657:2): enforcing=3D1 old_enfor=
cing=3D0 auid=3D4294967295 ses=3D4294967295
[    2.859338] SELinux: 2048 avtab hash slots, 111767 rules.
[    2.896099] SELinux: 2048 avtab hash slots, 111767 rules.
[    2.914737] SELinux:  8 users, 14 roles, 5032 types, 315 bools, 1 sens, =
1024 cats
[    2.914740] SELinux:  129 classes, 111767 rules
[    2.917198] SELinux:  Class bpf not defined in policy.
[    2.917869] SELinux: the above unknown classes and permissions will be a=
llowed
[    2.918286] SELinux:  Completing initialization.
[    2.918287] SELinux:  Setting up existing superblocks.
[    2.927056] type=3D1403 audit(1670624480.743:3): policy loaded auid=3D42=
94967295 ses=3D4294967295
[    2.932468] systemd[1]: Successfully loaded SELinux policy in 91.490ms.
[    2.961463] ip_tables: (C) 2000-2006 Netfilter Core Team
[    2.962079] systemd[1]: Inserted module 'ip_tables'
[    2.975693] systemd[1]: Relabelled /dev, /run and /sys/fs/cgroup in 11.4=
47ms.
[    3.149451] systemd-journald[3611]: Received request to flush runtime jo=
urnal from PID 1
[    3.377181] input: PC Speaker as /devices/platform/pcspkr/input/input5
[    3.383147] i801_smbus 0000:00:1f.3: Enabling SMBus device
[    3.384270] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[    3.390433] lpc_ich 0000:00:1f.0: I/O space for GPIO uninitialized
[    3.398419] sd 6:0:0:0: Attached scsi generic sg0 type 0
[    3.399408] sr 0:0:0:0: Attached scsi generic sg1 type 5
[    3.450533] random: crng init done
[    3.465047] iTCO_vendor_support: vendor-support=3D0
[    3.467307] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[    3.468387] iTCO_wdt: Found a ICH9 TCO device (Version=3D2, TCOBASE=3D0x=
0660)
[    3.469695] ppdev: user-space parallel port driver
[    3.469802] iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=3D0)
[    3.471357] cryptd: max_cpu_qlen set to 1000
[    3.483460] AVX2 version of gcm_enc/dec engaged.
[    3.483968] AES CTR mode by8 optimization enabled
[    3.487473] alg: No test for __gcm-aes-aesni (__driver-gcm-aes-aesni)
[    3.488065] alg: No test for __generic-gcm-aes-aesni (__driver-generic-g=
cm-aes-aesni)
[    3.497458] Adding 6160380k swap on /dev/mapper/centos-swap.  Priority:-=
2 extents:1 across:6160380k FS
[    3.507568] XFS (sda2): Mounting V5 Filesystem
[    3.514219] XFS (dm-2): Mounting V5 Filesystem
[    3.522718] XFS (sda2): Ending clean mount
[    3.563636] XFS (dm-2): Ending clean mount
[    3.643722] type=3D1305 audit(1670624481.460:4): audit_pid=3D6878 old=3D=
0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:auditd_t:s0 r=
es=3D1
[    3.646170] RPC: Registered named UNIX socket transport module.
[    3.646719] RPC: Registered udp transport module.
[    3.647248] RPC: Registered tcp transport module.
[    3.647751] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    4.237393] ip6_tables: (C) 2000-2006 Netfilter Core Team
[    4.272117] Ebtables v2.0 registered
[    4.314957] nf_conntrack version 0.5.0 (65536 buckets, 262144 max)
[    4.318454] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[    4.394439] bridge: filtering via arp/ip/ip6tables is no longer availabl=
e by default. Update your scripts to load br_netfilter if you need this.
[    4.417046] Netfilter messages via NETLINK v0.30.
[    4.423282] ip_set: protocol 6
[    5.009138] tun: Universal TUN/TAP device driver, 1.6
[    5.009142] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    5.010482] virbr0: port 1(virbr0-nic) entered blocking state
[    5.010486] virbr0: port 1(virbr0-nic) entered disabled state
[    5.010608] device virbr0-nic entered promiscuous mode
[    5.089866] virbr0: port 1(virbr0-nic) entered blocking state
[    5.089871] virbr0: port 1(virbr0-nic) entered listening state
[    5.090007] IPv6: ADDRCONF(NETDEV_UP): virbr0: link is not ready
[    5.123431] virbr0: port 1(virbr0-nic) entered disabled state
[   15.825720] fuse init (API version 7.22)
[   18.937582] TCP: lp registered

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
