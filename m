Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1FE43FB14
	for <lists+linux-pci@lfdr.de>; Fri, 29 Oct 2021 12:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbhJ2Kzl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Oct 2021 06:55:41 -0400
Received: from mx0b-00622301.pphosted.com ([205.220.175.205]:4654 "EHLO
        mx0b-00622301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231749AbhJ2Kzj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Oct 2021 06:55:39 -0400
Received: from pps.filterd (m0241925.ppops.net [127.0.0.1])
        by mx0a-00622301.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19TAjFYH014035;
        Fri, 29 Oct 2021 10:52:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ambarella.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=com20210415pp;
 bh=CsYS/UPUunF1uum1o+czoT3MdeRByj1tVNVLSvOzhEU=;
 b=v/EntMzPlYPyvP3yrTyAUOVT+VPSSXt+kl7azr3wzs2tim2+w7Z+9YRepkrvhsNbAGLg
 UJUeRh3NpLoZ0oKvjHbu0tetnoSMxXsUHhjnJLX67NIiVll/siYMS6pP1O1zIXlaZ2lA
 Epd8XvBFCsl0YPWiGDcwxR79WnURsEfsgQBfYUBtJam3fnXdK4Nx/oKi5eI2A+9Ii1h1
 C99S25W9du2IRahGM8xWJDjFVhbZBcYa3Ol7m9GjGpdPDCFW+pM97do0AYOgD9SQ/2os
 LgPYdumWh5Xee71drKnHbz4kwAxxAY1kdEq/Tg2VTvRIx3oN+/M8Az2M6TSJW0EGpary bg== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by mx0a-00622301.pphosted.com with ESMTP id 3c0dyag1a4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Oct 2021 10:52:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SY8j65giOw3hMOZEuLS6ed2VMKsGZFBIlrXHBgUblyZ6rdyA3bAUrGlnVlZj3uP9KzELQDihfNe0fyWsx3GTUkQ0EUwkHe9sbaoiMfUmUxfLzS5+8itj7X2006jRu+1qXoM3UDZVrA34LKEdJlBwZtzSb1uX5SWKh/N8sEbfNl6V4MlpPoNLEnk7rL69IqtSs2Ii4aN2FLlw0J/JvW3wi5K8UkX3fb9nWReT0WPygfQ9UdTdNCRzW5otrteELDuWOYba2gSRdjCSrP2Jvjcb1JM2gxQsP0rm7MmB32yHFF6EOzbhukjuim1N/VcLgtsxdCvlHc37BzDhcx+iAStz+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILYYnt46ZcuGKiaSN6wFcDRfK5cvLX9rAqmA9UrLjjU=;
 b=idzKlpouRYmUKBJujayz4rSm2vmN+HPsgPZ20k8/c1Z1KEJdtWAfMCyonMtvkkJuM7x3+28aGyodgdyQcp+6jaVBpothK6MPEKNMkmAO77bXXZBCH7cCUKpouq4dlU1Oz5+WJvRlFRyM3Z3fWmDV5Ij1Ahxkih9pAawkycosLjrZkYAk7Ry9MRWvDudZKQOcowSa2se9auiWBG0uAAHaUomh1c4kpZUR2mTV6QoQ385WnY1epdTZWKwg/YwttPYsxSufBPWfBZyl3X2ld+8F/VdWAmlQpMfdM2aW9cwcuYOSl8okd+vHgWj8Kehn0Y41HJKq8DkUV0TsQOWKMTPD7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ambarella.com; dmarc=pass action=none
 header.from=ambarella.com; dkim=pass header.d=ambarella.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ambarella.onmicrosoft.com; s=selector1-ambarella-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILYYnt46ZcuGKiaSN6wFcDRfK5cvLX9rAqmA9UrLjjU=;
 b=hKg5McHIrqlHbrE+RKN+paRjRjqAsyeIrLysMmeWd2Gi4hUZbab0By84t52Lo3pr9hsDTqv+JciXiJXXo0Elq930S7x/IMUsC4kRBN+TTdv0npASSm8A3UY7X88uJ/OZF1IDhvu2klUqyAqrUJ4S/731qQVS89JazDJF7yKn7BY=
Received: from CH2PR19MB4024.namprd19.prod.outlook.com (2603:10b6:610:92::22)
 by CH2PR19MB3750.namprd19.prod.outlook.com (2603:10b6:610:90::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 10:52:37 +0000
Received: from CH2PR19MB4024.namprd19.prod.outlook.com
 ([fe80::8143:f3e0:9fd3:a8e7]) by CH2PR19MB4024.namprd19.prod.outlook.com
 ([fe80::8143:f3e0:9fd3:a8e7%5]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 10:52:37 +0000
From:   Li Chen <lchen@ambarella.com>
To:     Keith Busch <kbusch@kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tom Joseph <tjoseph@cadence.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: RE: [EXT] Re: nvme may get timeout from dd when using different
 non-prefetch mmio outbound/ranges
Thread-Topic: [EXT] Re: nvme may get timeout from dd when using different
 non-prefetch mmio outbound/ranges
Thread-Index: AdfHKUVD4pdAQATdSnyIoo960S9VyQCjl4+AAAEy0AAAFvQC8AAB+KwAAJu5nUA=
Date:   Fri, 29 Oct 2021 10:52:37 +0000
Message-ID: <CH2PR19MB4024F88716768EC49BCA08CCA0879@CH2PR19MB4024.namprd19.prod.outlook.com>
References: <CH2PR19MB4024E04EBD0E4958F0BBB2ACA0809@CH2PR19MB4024.namprd19.prod.outlook.com>
 <20211025154739.GA4760@bhelgaas>
 <20211025162158.GA2335242@dhcp-10-100-145-180.wdc.com>
 <CH2PR19MB4024372120E0E74C8F2CB685A0849@CH2PR19MB4024.namprd19.prod.outlook.com>
 <20211026041538.GB2335242@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20211026041538.GB2335242@dhcp-10-100-145-180.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=ambarella.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3549be5-fe31-4980-4f0d-08d99aca3893
x-ms-traffictypediagnostic: CH2PR19MB3750:
x-microsoft-antispam-prvs: <CH2PR19MB3750A4F3F6D70D227EF7A470A0879@CH2PR19MB3750.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e7nIgqt6mNVPtcej4P2421QJiwvk325iNorPKAd5DPm/WwVr20Rg0KFoAKNffXTNKKLeiceu3JhksxirwQkjrytYDy1R2QG7sXSp7nlhQy1HFhsGcFeyK3+OMQ8H22XBOGOSQO5rLEM6aqXIJWVJXOpPE1f0afavBcMX5dqRwwT3FuIfVafOM8HUQruT2O8jm1cf1fr0VKlR46NNoaxxBOr3ZKpQPM1S3n9WkGSGtH/EyqE1ZAMWVyJ2PdVzHP7PvEEWdpkMmWiIMn2CCqGqilfsBxNHncRLbDeopOV8BHshV0/PSPY7JVf4tK3y3/98ez1kLndTiCaluloPpjvc+gDg4R7FxmW49N1L8g5gNOxd4tqHitfmq/nXDeEtVVcLc+EAmxqzN82JNj73Po6Q8X1WSXErVWxDEpUqji1SA7Zwhewnlcbe6Ux8A7NnMRdcafhAfv6Q+8EzCZFu83iSPokhfPaROAQ706op9c60QM5CSRGQpO5bz6OnBr7lmIapWscn56VJAvqYUjRoHwKVZdmKSydad9AyChT1EZPFcy6Cjn3CxfEfvZ5aTpw0hRDQM4mOOQaRUmP3jn31xRfTxNQ5L/QOIcHJBRf1ghGaRYHGd+s+n/qZ4vFPaZkSlgmUq16AAmKka9yVzKX0qzi5fagfhzM4L5fYSDH40lTNCNGlKtF/OcmSQNtsSNvoH7OiXApWuJlom0tEIGmCs2sdeuy5zJH945YMN5a0j5WWOlA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB4024.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(88996005)(53546011)(8676002)(6506007)(55016002)(33656002)(7696005)(4326008)(8936002)(86362001)(122000001)(38100700002)(508600001)(83380400001)(2906002)(186003)(54906003)(52536014)(966005)(6916009)(26005)(316002)(66446008)(71200400001)(66476007)(9686003)(66946007)(64756008)(5660300002)(66556008)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gZHf9TxPMf399uR1EPp/u0Cjp62RdxGQwLDQONHtSLA6TAesCSDYdnIjA7FQ?=
 =?us-ascii?Q?BCOSjPEYJfEDyQPqTvpQFtqUw3C9Wj2jZE3P+dxhkt/UfTRky39Z03+kCnK8?=
 =?us-ascii?Q?ueEDkyaU/RRZYFG33Une4MLH5EXb+535dkpnOnxDjjG7FxtAwTZ3YEI7Z8MK?=
 =?us-ascii?Q?QknF0L0SojDtUDCMf9vmAMPs/dovHbRWZjNqqaD5ZslVLRM9RG7ET3r/eAbH?=
 =?us-ascii?Q?ZhvHR7aWR2H0DHQaqAnQNMWp1Y2i7Kd3h7/JZkQZ7dfJAEkFDx9YYIwIE7Yy?=
 =?us-ascii?Q?RXjV8VvFcvNzp5paYkmPDdiJ5Sabc5D7gt4N5odQowzTGhI04MeS4eMJVnck?=
 =?us-ascii?Q?u+yRR1jyz1zW9ae+FD/0fV5E71fPVNdrPpz8OhO8llTzMxpk0HaGrzKlkmrk?=
 =?us-ascii?Q?nLLPjchT/XdiA882cjpQqhuz+ysYUGblMQfqfJXqLvzsznzVWW3OoOS2n4ro?=
 =?us-ascii?Q?V4bU8pjwGSH9M0Gn9u2+eJM5XqOYudvaLMXNsALLKRPL68vmjod4QeEBd6Xj?=
 =?us-ascii?Q?5ZD/fHeJBqF8LmY7OhrN7zDcUyFpun71F6f0hlhorUFAWaXXUxFT0Q37FKvn?=
 =?us-ascii?Q?D7azgxTjwQYGsLpZzMcE2yk1YkNTtRIayHz3P6u1ytoiliB+VuNtNWqpFWkG?=
 =?us-ascii?Q?EGwb1xg7n2UCEHSFpoqvFBQlqid9xuNFABnKDx36zG2WUShhuZ4eyIlrMFsE?=
 =?us-ascii?Q?tuTLhG25UTkYHTGg6b6Z81qIeFsOJcx9MGC2SwbmReOe/27w7S7NodK2d9Lj?=
 =?us-ascii?Q?JpJCDkBkd0RcAaEku6zbPvKsJa8kyvp0lbOxp5CUdWPySW7LcIOgIlZZBpQZ?=
 =?us-ascii?Q?ZVn7gDcfrT+hBk2TT6OOeshDfigmY9+NjcwXoDEVyhn7/NvtIc4xulTv51hy?=
 =?us-ascii?Q?ioV36r90oUqmg+1j3q8C6IQbn6u9rm8x5jFb4EKtFtl5yXRIs6QafCS04KxL?=
 =?us-ascii?Q?5/6bzfgiJ8o2gCNDFqgl+O4G9U/jABf/4vu39ZZldVjIvtibhTWNyK1T5hrf?=
 =?us-ascii?Q?+LFnLjxaYDkFs1HaunlGKvHg4YN7xe0KDbSOKhNuc2k0qs3BoDCv0MDQYOIY?=
 =?us-ascii?Q?DCmpGXDybjFGjS8suBsGROkR3ZA22dmXhyD98za7c7AkGXopWds6r32m724v?=
 =?us-ascii?Q?YiezbkxrOFQx0Z12wGfKKSo+tuhom0B6bxuYN+ZQZYKYFoRidXRbefMy/wq/?=
 =?us-ascii?Q?tldhf78Brmg1VO+fjtFNb2GGZk+ib1HJrLX8ppbUiGwvpElpheqyrnzNJsK+?=
 =?us-ascii?Q?1X7CqkvcfMl239AFbKKBbeN4jqeB26VPGlXyND/8LtaFGrlvsexqbloGT+Jk?=
 =?us-ascii?Q?hhLXDVLrE75rMn647uHP2NUiMEVL6rOHUxdsMe6cLTnhgaMF39GtAABWAa6V?=
 =?us-ascii?Q?EvVJOb7YEp6Hh1fBm2imIEaxykLbS8yqrDTeai1vTUjlw0ZTdCNPyaFP3TCT?=
 =?us-ascii?Q?8t1MSNOanJIa1EmUUxpWH8jwBHpc+7bhTWKXtfiXDMjeGW4woXskTNHxPSck?=
 =?us-ascii?Q?qDtVEP3iNOp82vS8FNOYs1jYbbYMe0HRUf53YglLEvFCkUqeN68fZwpZwHg6?=
 =?us-ascii?Q?HJcS1945dK+VfGo95aWozhGNGn66O7589Kpc+nbSzg1aCWZpdWz96RhMD9lr?=
 =?us-ascii?Q?YAx4xqc6+sfTMD5c7QAXPvA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ambarella.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB4024.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3549be5-fe31-4980-4f0d-08d99aca3893
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2021 10:52:37.0605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3ccd3c8d-5f7c-4eb4-ae6f-32d8c106402c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QeEhCozCg9KRymobPU2x8F8CXuU50o3Vp8BTLbHE34axxSe2c+mX+ZWpS6ke4/ByZypE9om82XjWwqyqRKkEnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB3750
X-Proofpoint-GUID: reeu8cBM3K2DDDEE6RWZ8hW72_Nwe0b3
X-Proofpoint-ORIG-GUID: reeu8cBM3K2DDDEE6RWZ8hW72_Nwe0b3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-29_02,2021-10-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 clxscore=1015 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2110290062
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Keith Busch [mailto:kbusch@kernel.org]
> Sent: Tuesday, October 26, 2021 12:16 PM
> To: Li Chen
> Cc: Bjorn Helgaas; linux-pci@vger.kernel.org; Lorenzo Pieralisi; Rob Herr=
ing;
> kw@linux.com; Bjorn Helgaas; linux-kernel@vger.kernel.org; Tom Joseph; Je=
ns
> Axboe; Christoph Hellwig; Sagi Grimberg; linux-nvme@lists.infradead.org
> Subject: Re: [EXT] Re: nvme may get timeout from dd when using different =
non-
> prefetch mmio outbound/ranges
>=20
> On Tue, Oct 26, 2021 at 03:40:54AM +0000, Li Chen wrote:
> > My nvme is " 05:00.0 Non-Volatile memory controller: Samsung Electronic=
s Co
> Ltd NVMe SSD Controller 980". From its datasheet,
> https://urldefense.com/v3/__https://s3.ap-northeast-
> 2.amazonaws.com/global.semi.static/Samsung_NVMe_SSD_980_Data_Sheet_R
> ev.1.1.pdf__;!!PeEy7nZLVv0!3MU3LdTWuzON9JMUkq29zwJM4d7g7wKtkiZszTu-
> PVepWchI_uLHpQGgdR_LEZM$ , it says nothing about CMB/SQEs, so I'm not sur=
e.
> Is there other ways/tools(like nvme-cli) to query?
>=20
> The driver will export a sysfs property for it if it is supported:
>=20
>   # cat /sys/class/nvme/nvme0/cmb
>=20
> If the file doesn't exist, then /dev/nvme0 doesn't have the capability.
>=20
> > > > I don't know how to interpret "ranges".  Can you supply the dmesg a=
nd
> > > > "lspci -vvs 0000:05:00.0" output both ways, e.g.,
> > > >
> > > >   pci_bus 0000:00: root bus resource [mem 0x7f800000-0xefffffff win=
dow]
> > > >   pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff win=
dow]
> > > >   pci 0000:05:00.0: [vvvv:dddd] type 00 class 0x...
> > > >   pci 0000:05:00.0: reg 0x10: [mem 0x.....000-0x.....fff ...]
> > > >
> > > > > Question:
> > > > > 1.  Why dd can cause nvme timeout? Is there more debug ways?
> > >
> > > That means the nvme controller didn't provide a response to a posted
> > > command within the driver's latency tolerance.
> >
> > FYI, with the help of pci bridger's vendor, they find something interes=
ting:
> "From catc log, I saw some memory read pkts sent from SSD card, but its m=
emory
> range is within the memory range of switch down port. So, switch down por=
t will
> replay UR pkt. It seems not normal." and "Why SSD card send out some memo=
ry
> pkts which memory address is within switch down port's memory range. If s=
o,
> switch will response UR pkts". I also don't understand how can this happe=
n?
>=20
> I think we can safely assume you're not attempting peer-to-peer, so that
> behavior as described shouldn't be happening. It sounds like the memory
> windows may be incorrect. The dmesg may help to show if something appears
> wrong.

Hi, Keith

Agree that here doesn't involve peer-to-peer DMA. After conforming from swi=
tch vendor today, the two ur(unsupported request) is because nvme is trying=
 to dma read dram with bus address 80d5000 and 80d5100. But the two bus add=
resses are located in switch's down port range, so the switch down port rep=
ort ur.=20

In our soc, dma/bus/pci address and physical/AXI address are 1:1, and DRAM =
space in physical memory address space is 000000.0000 - 0fffff.ffff 64G, so=
 bus address 80d5000 and 80d5100 to cpu address are also 80d5000 and 80d510=
0, which both located inside dram space.=20

Both our bootloader and romcode don't enum and configure pcie devices and s=
witches, so the switch cfg stage should be left to kernel.=20

Come back to the subject of this thread: " nvme may get timeout from dd whe=
n using different non-prefetch mmio outbound/ranges". I found:

1. For <0x02000000 0x00 0x08000000 0x20 0x08000000 0x00 0x04000000>;
(which will timeout nvme)

Switch(bridge of nvme)'s resource window:=20
Memory behind bridge: Memory behind bridge: 08000000-080fffff [size=3D1M]

80d5000 and 80d5100 are both inside this range.

2. For <0x02000000 0x00 0x00400000 0x20 0x00400000 0x00 0x08000000>;=20
(which make nvme not timeout)=20

Switch(bridge of nvme)'s resource window:=20
Memory behind bridge: Memory behind bridge: 00400000-004fffff [size=3D1M]

80d5000 and 80d5100 are not inside this range, so if nvme tries to read 80d=
5000 and 80d5100 , ur won't happe.


From /proc/iomen:
# cat /proc/iomem
01200000-ffffffff : System RAM
  01280000-022affff : Kernel code
  022b0000-0295ffff : reserved
  02960000-040cffff : Kernel data
  05280000-0528ffff : reserved
  41cc0000-422c0fff : reserved
  422c1000-4232afff : reserved
  4232d000-667bbfff : reserved
  667bc000-667bcfff : reserved
  667bd000-667c0fff : reserved
  667c1000-ffffffff : reserved
2000000000-2000000fff : cfg

No one uses 0000000-1200000, so " Memory behind bridge: Memory behind bridg=
e: 00400000-004fffff [size=3D1M]" will never have any problem(because 0x120=
0000 > 0x004fffff).=20


Above answers the question in Subject, one question left: what's the right =
way to resolve this problem? Use ranges property to configure switch memory=
 window indirectly(just what I did)? Or something else?

I don't think changing range property is the right way: If my PCIe topology=
 becomes more complex and have more endpoints or switches, maybe I have to =
reserve more MMIO through range property(please correct me if I'm wrong), t=
he end of switch's memory window may be larger than 0x01200000. In case get=
ting ur again,  I must reserve more physical memory address for them(like c=
hange kernel start address 0x01200000 to 0x02000000), which will make my vi=
sible dram smaller(I have verified it with "free -m"), it is not acceptable.


So, is there any better solution?

Regards,
Li=20

**********************************************************************
This email and attachments contain Ambarella Proprietary and/or Confidentia=
l Information and is intended solely for the use of the individual(s) to wh=
om it is addressed. Any unauthorized review, use, disclosure, distribute, c=
opy, or print is prohibited. If you are not an intended recipient, please c=
ontact the sender by reply email and destroy all copies of the original mes=
sage. Thank you.
