Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2125E51E66A
	for <lists+linux-pci@lfdr.de>; Sat,  7 May 2022 12:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384105AbiEGK0h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 7 May 2022 06:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243948AbiEGK0g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 7 May 2022 06:26:36 -0400
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1083517E1
        for <linux-pci@vger.kernel.org>; Sat,  7 May 2022 03:22:48 -0700 (PDT)
Received: from pps.filterd (m0174678.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2479OJHZ031557;
        Sat, 7 May 2022 10:22:38 GMT
Received: from eur03-am5-obe.outbound.protection.outlook.com (mail-am5eur03lp2058.outbound.protection.outlook.com [104.47.8.58])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3fwp3m02a9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 07 May 2022 10:22:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGergsDpuH40ZVRmFU/+ZmSbobKbb6f2pEQB7k01f3c2z9UwhIJ8cxrR6dCu4xzRbfS2O4kP2KhAWcPwIkkcM7aS7/aioqE49SJIqyPUQe7ZbgeCOwYRkdVCitLNEgMzg4LXe7//wVw8IxB85MKTSqt1CC8x3ZWCoae6Vx7EqGbXTGpNSINK54kxr37ydODG5p/7oK+TkjTgYYLlcFxE9wMewJFFcmmaU736IHH+JwkQvi99/gNZabiOogeGhi6hq/8Qjr+Nj670XPP1YlIBuYIRCwEQf2WLLBlziIzBV8nX8O415GktnMXgRHn5KV2/QDD44TQHvW5EnClsEiwg8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/A+ZO1UTCgMhQY5NDlF9Op02Zs4Kmt7fUWDc6jU4Ty0=;
 b=VHhYc/M0QRvlqdwTpboRS9n2Rsw2NrmWS7wh3w0aKbmy3oqPJcc8WoSUhDy8Vx+DKMMuSod0/4Y40wN/J9I1kdadnkPI8RvOhMsEMfjQYOL+9de69w1BAJwIvqBUkbLEbU4obz+kXWrXFqDkWJ3czGF3wRkMt/CY5DNAb8oRnzqdE74mRd/5I8U46L+mQ8F/+7VveFRF33bQ6L53Cm+816ARyaOoRhm0nxJ6igdFYByhoYOf5upqiV4ZgkcE3wE3r2nvwGzZwOfwJWEfW8JYyI3/VKbofXm1bp8KlW02LazUGApLzLGMb6wXCvx8PcfK5E1Gxrne8kWrKkBmg9ek/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/A+ZO1UTCgMhQY5NDlF9Op02Zs4Kmt7fUWDc6jU4Ty0=;
 b=Xv3aUpFNAQL3IIrdI8xpEpm99nODkH8nYpVOxuQblqSepZYJrihzMPQph7c5qmfnhXJeaOuzmO3G9EOPrn/kRY0RpcvWFmb1Hf1Yf87624Y3sI3EMBOoFM63mJfHZo9ZXKwzNn0y6VUQlTsOQzJO4P0TyB0++fVONENmB59f9PdqaJ0hYI0htdBxcwlo5NjLk1XH//hbxWZcnoq2q6H0+4LeWR4K36rpnHnA/fRXGgDDUbRZYEJXV7jGbGzn+rMe35JFZAUyG8fx7gf7In2S/HSEXXVI5O8NtiCnwEaYpbCw1aw507tQ0El3mEs+oR5G3TUmY4QbBQlAIF8LR+oqxA==
Received: from VI1PR03MB3710.eurprd03.prod.outlook.com (2603:10a6:803:31::18)
 by VI1PR03MB3583.eurprd03.prod.outlook.com (2603:10a6:803:2b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Sat, 7 May
 2022 10:22:32 +0000
Received: from VI1PR03MB3710.eurprd03.prod.outlook.com
 ([fe80::4534:2241:9a1:3937]) by VI1PR03MB3710.eurprd03.prod.outlook.com
 ([fe80::4534:2241:9a1:3937%6]) with mapi id 15.20.5206.027; Sat, 7 May 2022
 10:22:32 +0000
From:   Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: Write to srvio_numvfs triggers kernel panic
Thread-Topic: Write to srvio_numvfs triggers kernel panic
Thread-Index: AQHYX/D7w22LhOQ4BkKjl8Bb5V4dfa0STLQAgADl+oA=
Date:   Sat, 7 May 2022 10:22:32 +0000
Message-ID: <87v8uhlk1w.fsf@epam.com>
References: <87a6bxm5vm.fsf@epam.com> <20220506201722.GA555374@bhelgaas>
In-Reply-To: <20220506201722.GA555374@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: mu4e 1.6.5; emacs 27.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a92069c1-4c48-4cd2-2d38-08da30137f40
x-ms-traffictypediagnostic: VI1PR03MB3583:EE_
x-microsoft-antispam-prvs: <VI1PR03MB358388E34BF7F6FB7A723090E6C49@VI1PR03MB3583.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kSmpFU3Hahg0kw6HKbjiH6w5TWQpTYhPcVt+H2hAAuAtmTY2DeDyFzaNEUZunFVb5QjNik4iDT5iG89bmAKKj/i8tMFAyHZHnBbY0sDLn6iu75IWXLpjwTOUgd1mTx2tZMmgKZhgNJJD/R8nrXXKGWanaBBOJhVwJgE3tsBmbeGZCpgMG/5i7rV/AnocDtEjf6mszHaZNQpNoPAM41HxEbs0RkMG6idTbqPscoAFVIDEMt807wOxzwoKOWrkxdz0ajib2NBaWLMqHjl2OhqfaQJ8zPNCJRRmAjXDYwZM+dgaH2NYlkYhtvzoyIaiP52OUw2wMtkfcpkl6z1v5Xd/NV9GpRjxVyPM9RSF+qDLV5k6H3KIlT4y9vP8nVvH+aK5B41uL9g1KYXHvK/x4zV1GRkrD1Aa7LLGbXrjSrxvCuKhtqjXHnWtj4Z3G5UGWYTegiEDx7C6C/8CPT5nDjTZQItJnX/lvd0u8kDKrvBbsQN+HPPF6wGuljSAwBvYJdi4cSKlUM17k9nwFvM4Q3BjIwKp22jBHnXrZPpFNDm9tm/EwWLc0ChOQWfatuFJ/nMnnJTrI5eKBep7iS3KeoSu6L4ctPWiedGsOmbi3ozWPZGpaDlFfOM6KmQt+oIbpWbamcAxmIbPbfKWvkygeJdcJFl4UK82rlfJCRYf/1Nc0bZnSLcXfR7rvi0F+Au3q+4bjvhlACkPpSt/MdvN2ycQ+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB3710.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(6512007)(38100700002)(122000001)(38070700005)(66446008)(66476007)(64756008)(8676002)(66946007)(91956017)(4326008)(36756003)(45080400002)(66556008)(76116006)(83380400001)(6916009)(2906002)(186003)(6506007)(54906003)(86362001)(71200400001)(55236004)(2616005)(8936002)(5660300002)(508600001)(316002)(19627235002)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7811T4sYkDPBFaQ4TMN5M3lMhKerYdgyW1T5lIxkYLqGuEOm3vpSXNM5k8?=
 =?iso-8859-1?Q?EKfILbyhpxCNW0aIeypIf/aNQKpGdw2tMVqazIOzBfNYTMWe+SbC/tEW+e?=
 =?iso-8859-1?Q?oQghfKKsr81ZgmBAzmn9Ip7mXstyJa6dqyaiZ2qSNlCLywDSwpO/CLIIsx?=
 =?iso-8859-1?Q?6IsoCtxPZrZd3h5oer4a4JGO5YvQXgoH0dZpkn6dEVS2cx+5wsFC822Kof?=
 =?iso-8859-1?Q?2wy90OceLPQlKZV9b5DG7cVnTFZcvXLGTJPI0NhsGnwnM53BF9xlnPJ854?=
 =?iso-8859-1?Q?Wv8HH2FBs3hQ33CrAwqp1WvXSy93mh5R+4iDZmsLKlZ49XNLP5MxDHULh1?=
 =?iso-8859-1?Q?02yNUIIwjBI03kTwfhMQFYfZbUBk9QE9+yJBPeALVOBy/+/MDzVG8edUAm?=
 =?iso-8859-1?Q?Oji+YzA5RBimbznvhs8X9A2ZH0tNHJt9i2nP1F2Y6LP40TPoc+Iq0S6AWe?=
 =?iso-8859-1?Q?9Qs+ejIcqrbbWKYnKPiNDP23tgTC20cG6Kx3lBbrb5sIg2T1CkGOZf0u84?=
 =?iso-8859-1?Q?AN9AVhJpuigLSS1mXUmkjszFSpd5BmF+gR9lvczyTCOTnbc+yMIRm1yC4x?=
 =?iso-8859-1?Q?edbwVzq85orafwso+BP2LR4GqChLhia9Wdd6Y9pZT1pcrmYN8L2h/+tSyN?=
 =?iso-8859-1?Q?pgyAsUO6riBLz5soglH5UqpDB0GxsikPnurBwo+KeAGdy1+BqoodYoSLiD?=
 =?iso-8859-1?Q?hl9t2nSU/EOkz2jliyXOHli7Up4yJ/W6tWvWIuLXjVtko5vYPlBAiX+QGP?=
 =?iso-8859-1?Q?CZZQ2w2Fa4OZT4e3+xEMCdQs0hMHESNgTMogiRPLwWeNwHPTjU/z4oF13g?=
 =?iso-8859-1?Q?Z7uAuAhbk0TEJcyY9uEU4QbSE+k1xMBhN+6EsfKbZZR55VIemEaoJyWEdB?=
 =?iso-8859-1?Q?6BdKuQAXqbW6wYU+n3ODBWUbtmemT9NRUC9oqufgz/XPPBZJct0FOrFN46?=
 =?iso-8859-1?Q?f7TY2gM3BxGW+oy/cKQcGUYurxH4cLdWbaLqmpWLahhyhJSH55Iu9d8uL5?=
 =?iso-8859-1?Q?Z3PPmGlntD++baVf4Y3Ce6tK4A1aXNCn/JC14Qwh8MS+f05YYhT7qNN9qs?=
 =?iso-8859-1?Q?bpLApq/oOgYb9uX9xvISXY5ZQrmxXMG1+7L2JZSllsTpxaREfuFqPb1ons?=
 =?iso-8859-1?Q?C8wBZ6AdDLzL6cTNc+9kt9CvJM1h6Il+P/ifn7RWYmnNzYCi6O5o4YmhzN?=
 =?iso-8859-1?Q?kC7FPn3C1qH4qJJaNhghrf4asMN+PF3QHp7TF3lW/v4Pgx69pbElIJ9Bml?=
 =?iso-8859-1?Q?KAVc05dBEUbGHD+FcEz2mSdmnozDDHqOsurcMa/sT7Ik98kIdGx9HGJkdi?=
 =?iso-8859-1?Q?Q9jHmzl2L/69FHY5t8NreLF9lac2gZKD8ZKn4ThMdJwnbsHS2VMxA8bRS1?=
 =?iso-8859-1?Q?hth0S8A37ZLgwFIKNnHMIJZ/mmbfdlBJTeuL+n1IYrgJv4ohlqYKpfhae7?=
 =?iso-8859-1?Q?EygR0Cw/gf2wJTGk1KwH9mZ7KVi8qE6ZDN4Pokb9OvlGV0bCZ6XerVN+Uq?=
 =?iso-8859-1?Q?rB+Mgd/xJamahfQ6OmXup3jBOWl41ZAjQd4IgbUpr2Hm+e75Je5r4UtLtz?=
 =?iso-8859-1?Q?8fGOgvD8di+27XFklwAsDsJlECzBimU+/A/GiChC2m0zGvQUjphQNd5mFd?=
 =?iso-8859-1?Q?8F+C1rnfJpxlQRGiN/ls6IgonpcajcNzeyNgCaHz20HxJNLGl6ntpRJAnN?=
 =?iso-8859-1?Q?LRr7sVYu/edzoZ8Cj98eO7gNFvp7OMBJh9Nmg24qf00DeeMUl9uIPdAf3K?=
 =?iso-8859-1?Q?5b9qQ9RQy/X3zBsda4NxJEUhoPs2sVyWxmQh8rkQxi4rFCRb4RieS+OXB+?=
 =?iso-8859-1?Q?ietnOvKWl+q5djMUrNJm8XDLvxQMNqw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB3710.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a92069c1-4c48-4cd2-2d38-08da30137f40
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2022 10:22:32.3145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BsKPKAhdsSX69+tI9GLSPXqYXIHxKKPykF56uDfelepdn6TtnwoU6C/ly8D0W4EVp/uA6G3Cjv8FlAjJvt2oweu/CrkY7slO3yFXWdMct8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB3583
X-Proofpoint-ORIG-GUID: eJP_PJQX55QBedMmen8WZxRHfWvpBwLC
X-Proofpoint-GUID: eJP_PJQX55QBedMmen8WZxRHfWvpBwLC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-07_02,2022-05-06_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0 mlxlogscore=781
 mlxscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205070069
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Hello Bjorn,

Bjorn Helgaas <helgaas@kernel.org> writes:

> [+cc Alex, Leon, Jason]
>
> On Wed, May 04, 2022 at 07:56:01PM +0000, Volodymyr Babchuk wrote:
>>=20
>> Hello,
>>=20
>> I have encountered issue when PCI code tries to use both fields in
>>=20
>>         union {
>> 		struct pci_sriov	*sriov;		/* PF: SR-IOV info */
>> 		struct pci_dev		*physfn;	/* VF: related PF */
>> 	};
>>=20
>> (which are part of struct pci_dev) at the same time.
>>=20
>> Symptoms are following:
>>=20
>> # echo 1 > /sys/bus/pci/devices/0000:01:00.0/sriov_numvfs
>>=20
>> pci 0000:01:00.2: reg 0x20c: [mem 0x30018000-0x3001ffff 64bit]
>> pci 0000:01:00.2: VF(n) BAR0 space: [mem 0x30018000-0x30117fff 64bit] (c=
ontains BAR0 for 32 VFs)
>>  Unable to handle kernel paging request at virtual address 0001000200000=
010
>>  Mem abort info:
>>    ESR =3D 0x96000004
>>    EC =3D 0x25: DABT (current EL), IL =3D 32 bits
>>    SET =3D 0, FnV =3D 0
>>    EA =3D 0, S1PTW =3D 0
>>  Data abort info:
>>    ISV =3D 0, ISS =3D 0x00000004
>>    CM =3D 0, WnR =3D 0
>>  [0001000200000010] address between user and kernel address ranges
>>  Internal error: Oops: 96000004 [#1] PREEMPT SMP
>> Modules linked in: xt_MASQUERADE iptable_nat nf_nat nf_conntrack nf_defr=
ag_ipv6
>> nf_defrag_ipv4 libcrc32c iptable_filter crct10dif_ce nvme nvme_core at24
>> pci_endpoint_test bridge pdrv_genirq ip_tables x_tables ipv6
>>  CPU: 3 PID: 287 Comm: sh Not tainted 5.10.41-lorc+ #233
>>  Hardware name: XENVM-4.17 (DT)
>>  pstate: 60400005 (nZCv daif +PAN -UAO -TCO BTYPE=3D--)
>>  pc : pcie_aspm_get_link+0x90/0xcc
>>  lr : pcie_aspm_get_link+0x8c/0xcc
>>  sp : ffff8000130d39c0
>>  x29: ffff8000130d39c0 x28: 00000000000001a4
>>  x27: 00000000ffffee4b x26: ffff80001164f560
>>  x25: 0000000000000000 x24: 0000000000000000
>>  x23: ffff80001164f660 x22: 0000000000000000
>>  x23: ffff80001164f660 x22: 0000000000000000
>>  x21: ffff000003f08000 x20: ffff800010db37d8
>>  x19: ffff000004b8e780 x18: ffffffffffffffff
>>  x17: 0000000000000000 x16: 00000000deadbeef
>>  x15: ffff8000930d36c7 x14: 0000000000000006
>>  x13: ffff8000115c2710 x12: 000000000000081c
>>  x11: 00000000000002b4 x10: ffff8000115c2710
>>  x9 : ffff8000115c2710 x8 : 00000000ffffefff
>>  x7 : ffff80001161a710 x6 : ffff80001161a710
>>  x5 : ffff00003fdad900 x4 : 0000000000000000
>>  x3 : 0000000000000000 x2 : 0000000000000000
>>  x1 : ffff000003c51c80 x0 : 0001000200000000
>>  Call trace:
>>   pcie_aspm_get_link+0x90/0xcc
>>   aspm_ctrl_attrs_are_visible+0x30/0xc0
>>   internal_create_group+0xd0/0x3cc
>>   internal_create_groups.part.0+0x4c/0xc0
>>   sysfs_create_groups+0x20/0x34
>>   device_add+0x2b4/0x760
>>   pci_device_add+0x814/0x854
>>   pci_iov_add_virtfn+0x240/0x2f0
>>   sriov_enable+0x1f8/0x474
>>   pci_sriov_configure_simple+0x38/0x90
>>   sriov_numvfs_store+0xa4/0x1a0
>>   dev_attr_store+0x1c/0x30
>>   sysfs_kf_write+0x48/0x60
>>   kernfs_fop_write_iter+0x118/0x1ac
>>   new_sync_write+0xe8/0x184
>>   vfs_write+0x23c/0x2a0
>>   ksys_write+0x68/0xf4
>>   __arm64_sys_write+0x20/0x2c
>>   el0_svc_common.constprop.0+0x78/0x1a0
>>   do_el0_svc+0x28/0x94
>>   el0_svc+0x14/0x20
>>   el0_sync_handler+0xa4/0x130
>>   el0_sync+0x180/0x1c0
>> Code: d0002120 9133e000 97ffef8e f9400a60 (f9400813)
>>=20
>>=20
>> Debugging showed the following:
>>=20
>> pci_iov_add_virtfn() allocates new struct pci_dev:
>>=20
>> 	virtfn =3D pci_alloc_dev(bus);
>> and sets physfn:
>> 	virtfn->is_virtfn =3D 1;
>> 	virtfn->physfn =3D pci_dev_get(dev);
>>=20
>> then we will get into sriov_init() via the following call path:
>>=20
>> pci_device_add(virtfn, virtfn->bus);
>>   pci_init_capabilities(dev);
>>     pci_iov_init(dev);
>>       sriov_init(dev, pos);
>
> We called pci_device_add() with the VF.  pci_iov_init() only calls
> sriov_init() if it finds an SR-IOV capability on the device:
>
>   pci_iov_init(struct pci_dev *dev)
>     pos =3D pci_find_ext_capability(dev, PCI_EXT_CAP_ID_SRIOV);
>     if (pos)
>       return sriov_init(dev, pos);
>
> So this means the VF must have an SR-IOV capability, which sounds a
> little dubious.  From PCIe r6.0:

[...]

Yes, I dived into debugging and came to the same conclusions. I'm still
investigating this, but looks like my PCIe controller (DesignWare-based)
incorrectly reads configuration space for VF. Looks like instead of
providing access VF config space, it reads PF's one.

>
> Can you supply the output of "sudo lspci -vv" for your system?

Sure:

root@spider:~# lspci -vv
00:00.0 PCI bridge: Renesas Technology Corp. Device 0031 (prog-if 00 [Norma=
l decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR+ FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 189
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D=
0
        I/O behind bridge: [disabled]
        Memory behind bridge: 30000000-301fffff [size=3D2M]
        Prefetchable memory behind bridge: [disabled]
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B=
-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=3D0mA PME(D0+,D1+,D2=
-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [50] MSI: Enable+ Count=3D128/128 Maskable+ 64bit+
                Address: 0000000004030040  Data: 0000
                Masking: fffffffe  Pending: 00000000
        Capabilities: [70] Express (v2) Root Port (Slot-), MSI 00
                DevCap: MaxPayload 256 bytes, PhantFunc 0
                        ExtTag+ RBE+
                DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                        RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ T=
ransPend-
                LnkCap: Port #0, Speed 5GT/s, Width x2, ASPM L0s L1, Exit L=
atency L0s <4us, L1 <64us
                        ClockPM- Surprise- LLActRep+ BwNot- ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 5GT/s (ok), Width x2 (ok)
                        TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt-
                RootCap: CRSVisible-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+=
 CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis+, NR=
OPrPrP+, LTR+
                         10BitTagComp+, 10BitTagReq-, OBFF Not Supported, E=
xtFmt-, EETLPPrefix-
                         EmergencyPowerReduction Not Supported, EmergencyPo=
werReductionInit-
                         FRS-, LN System CLS Not Supported, TPHComp-, ExtTP=
HComp-, ARIFwd-
                         AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR=
+, OBFF Disabled ARIFwd-
                         AtomicOpsCtl: ReqEn- EgressBlck-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDi=
s-
                         Transmit Margin: Normal Operating Range, EnterModi=
fiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationCompl=
ete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqua=
lizationRequest-
        Capabilities: [100 v2] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFa=
talErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFa=
talErr+
                AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECR=
CChkCap- ECRCChkEn-
                        MultHdrRecCap+ MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
                RootCmd: CERptEn- NFERptEn- FERptEn-
                RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
                         FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
                ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
        Capabilities: [148 v1] Device Serial Number 00-00-00-00-00-00-00-00
        Capabilities: [158 v1] Secondary PCI Express
                LnkCtl3: LnkEquIntrruptEn-, PerformEqu-
                LaneErrStat: 0
        Capabilities: [178 v1] Physical Layer 16.0 GT/s <?>
        Capabilities: [19c v1] Lane Margining at the Receiver <?>
        Capabilities: [1bc v1] L1 PM Substates
                L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L=
1_PM_Substates+
                          PortCommonModeRestoreTime=3D10us PortTPowerOnTime=
=3D14us
                L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
                           T_CommonMode=3D0us LTR1.2_Threshold=3D0ns
                L1SubCtl2: T_PwrOn=3D10us
        Capabilities: [1cc v1] Vendor Specific Information: ID=3D0002 Rev=
=3D4 Len=3D100 <?>
        Capabilities: [2cc v1] Vendor Specific Information: ID=3D0001 Rev=
=3D1 Len=3D038 <?>
        Capabilities: [304 v1] Data Link Feature <?>
        Capabilities: [310 v1] Precision Time Measurement
                PTMCap: Requester:+ Responder:+ Root:+
                PTMClockGranularity: 16ns
                PTMControl: Enabled:- RootSelected:-
                PTMEffectiveGranularity: Unknown
        Capabilities: [31c v1] Vendor Specific Information: ID=3D0004 Rev=
=3D1 Len=3D054 <?>
        Kernel driver in use: pcieport
        Kernel modules: pci_endpoint_test

01:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd Device a=
824 (prog-if 02 [NVM Express])
        Subsystem: Samsung Electronics Co Ltd Device a809
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 0
        NUMA node: 0
        Region 0: Memory at 30010000 (64-bit, non-prefetchable) [size=3D32K=
]
        Expansion ROM at 30000000 [virtual] [disabled] [size=3D64K]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA PME(D0-,D1-,D2=
-,D3hot-,D3cold-)
                Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [70] Express (v2) Endpoint, MSI 00                   =
                                                                           =
                                 [8/5710]
                DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s unli=
mited, L1 unlimited
                        ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ Slo=
tPowerLimit 0.000W
                DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                        RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLRese=
t-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- T=
ransPend-
                LnkCap: Port #0, Speed 16GT/s, Width x4, ASPM not supported
                        ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 5GT/s (downgraded), Width x2 (downgraded)
                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, NROPr=
PrP-, LTR-
                         10BitTagComp+, 10BitTagReq-, OBFF Not Supported, E=
xtFmt-, EETLPPrefix-
                         EmergencyPowerReduction Not Supported, EmergencyPo=
werReductionInit-
                         FRS-, TPHComp-, ExtTPHComp-
                         AtomicOpsCap: 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR=
-, OBFF Disabled
                         AtomicOpsCtl: ReqEn-
                LnkCtl2: Target Link Speed: 16GT/s, EnterCompliance- SpeedD=
is-
                         Transmit Margin: Normal Operating Range, EnterModi=
fiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationCompl=
ete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqua=
lizationRequest-
        Capabilities: [b0] MSI-X: Enable+ Count=3D64 Masked-
                Vector table: BAR=3D0 offset=3D00004000
                PBA: BAR=3D0 offset=3D00003000
        Capabilities: [100 v2] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFa=
talErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFa=
talErr+
                AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECR=
CChkCap+ ECRCChkEn-
                        MultHdrRecCap+ MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
        Capabilities: [148 v1] Device Serial Number d3-42-50-11-99-38-25-00
        Capabilities: [168 v1] Alternative Routing-ID Interpretation (ARI)
                ARICap: MFVC- ACS-, Next Function: 0
                ARICtl: MFVC- ACS-, Function Group: 0
        Capabilities: [178 v1] Secondary PCI Express
                LnkCtl3: LnkEquIntrruptEn-, PerformEqu-
                LaneErrStat: 0
        Capabilities: [198 v1] Physical Layer 16.0 GT/s <?>
        Capabilities: [1c0 v1] Lane Margining at the Receiver <?>
        Capabilities: [1e8 v1] Single Root I/O Virtualization (SR-IOV)
                IOVCap: Migration-, Interrupt Message Number: 000
                IOVCtl: Enable- Migration- Interrupt- MSE- ARIHierarchy-
                IOVSta: Migration-
                Initial VFs: 32, Total VFs: 32, Number of VFs: 0, Function =
Dependency Link: 00
                VF offset: 2, stride: 1, Device ID: a824
                Supported Page Size: 00000553, System Page Size: 00000001
                Region 0: Memory at 0000000030018000 (64-bit, non-prefetcha=
ble)
                VF Migration: offset: 00000000, BIR: 0
        Capabilities: [3a4 v1] Data Link Feature <?>
        Kernel driver in use: nvme
        Kernel modules: nvme


> It could be that the device has an SR-IOV capability when it
> shouldn't.  But even if it does, Linux could tolerate that better
> than it does today.
>

Agree there. I can create simple patch that checks for is_virtfn
in sriov_init(). But what to do if it is set?

>> sriov_init() overwrites value in the union:
>> 	dev->sriov =3D iov; <<<<<---- There
>> 	dev->is_physfn =3D 1;
>>=20

--=20
Volodymyr Babchuk at EPAM=
