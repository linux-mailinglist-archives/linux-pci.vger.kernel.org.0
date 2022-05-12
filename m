Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C39A5246B8
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 09:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350861AbiELHSz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 May 2022 03:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350880AbiELHSv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2022 03:18:51 -0400
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7754C5E57
        for <linux-pci@vger.kernel.org>; Thu, 12 May 2022 00:18:48 -0700 (PDT)
Received: from pps.filterd (m0174683.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24C5xBcd023612;
        Thu, 12 May 2022 07:18:33 GMT
Received: from eur05-db8-obe.outbound.protection.outlook.com (mail-db8eur05lp2110.outbound.protection.outlook.com [104.47.17.110])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3g0vjdg73f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 07:18:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CbtbFVZ0xmuQ/w3UB7GzkkDXbyQPnDxwFEUR1xq8vDlhnRKRcB0ofwiQrNp8NHLpbCOEVTC8kz35janB5ex/K0uf9hSbYcCV4x6h55YdlUnJxLv/yNHsmfHYxnoE6u9ORGjtl0gUj54OxbqwQH4KD3WLvZXyesF2K670bZtXNfdQMnJgCdGouA2JrRmr7hC1dNk/JD6ktfGqvpahwjVdhynN5gZ9emc6bXMTmQs/bcBZ7nMrtfac6AzZm/7IOmQpCyCJbrleiDIxD3UXqToMHOCefrDOMkVsdTHXzIRpuDKLxRSnc6wOwzkTslZJuxNG2VPd7UuAgNbWEMvVzzdJmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FTHdYfooovZK5zAiC934Hnj3qIzlKfxfNs0CG5gaCc=;
 b=hgJTNCol6BN1TJ0lRC+niOEM9jCnQYvwrziy5bmJWzAomii/UPStbHQ5Gvl7/PG+JKxC7KndEsgucxu9VA5SEJc7Nv9E5REijm26OqcYX1Uvq71Xpj8itQttBPscW6Ub9VVRli7ZUa8zsfaxq/x9Di8iI8SFhM+XvjYCh2IqBP1sFlkoUhbtrBEz4YMrMhA1Pa8OzFNNLmevkyZ9IXobh8j/yEvdJA07ORkZheO1xBa6h+xUjCbyAGnsQq99Ko0Omvq4BTjoEjYLRbAHVCLC6mw43N46Sl+EFcrEnbOrQM+CCN3P9DsAzEuCeo9xs98gY7EN1wwIwGWq4iX3w4Zzpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FTHdYfooovZK5zAiC934Hnj3qIzlKfxfNs0CG5gaCc=;
 b=YeiwCtgmxH5ofvDmVzRS12SKaG61RWo3BwvG20SYwYk64zshekYtEew7HG2f5t72yc9jDolYrHPkr7I1K2QuwykKluweT+NEtNMihc0au+xPrR/y2CUhnKd9FQSxjqR/ban9EcbjCB9ncogRg42OkKTYH6zoBjPlhKSdv+hyXOom1O6xEBL03q4mA9mWKtCOa/Nhs3OaFtJdL5oP0MKZ0fkiKVbCUpPXiiVLvDOzUOLjEpZ35mMS9f+KeWTfiLIFK2PalsMbFsxi2s9k56V22Tb7ivP2OfQnwBJLu3Y7dJobE1R3hyZ6Vb5Gm8F51t6Sb4Yx2MMZ+jzdbCNhXEuu0g==
Received: from VI1PR03MB3710.eurprd03.prod.outlook.com (2603:10a6:803:31::18)
 by HE1PR0301MB2476.eurprd03.prod.outlook.com (2603:10a6:3:6e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 07:18:30 +0000
Received: from VI1PR03MB3710.eurprd03.prod.outlook.com
 ([fe80::ad68:b4b0:d885:8615]) by VI1PR03MB3710.eurprd03.prod.outlook.com
 ([fe80::ad68:b4b0:d885:8615%7]) with mapi id 15.20.5250.014; Thu, 12 May 2022
 07:18:30 +0000
From:   Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: Write to srvio_numvfs triggers kernel panic
Thread-Topic: Write to srvio_numvfs triggers kernel panic
Thread-Index: AQHYX/D7w22LhOQ4BkKjl8Bb5V4dfa0STLQAgADl+oCAAF9ZgIABPykAgAH4bYCAAAKlgIAA5UMAgAC324CAAncygA==
Date:   Thu, 12 May 2022 07:18:30 +0000
Message-ID: <877d6rkym2.fsf@epam.com>
References: <YnoIossyu7KQ8xmC@infradead.org>
 <20220510173733.GA688834@bhelgaas>
In-Reply-To: <20220510173733.GA688834@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: mu4e 1.6.5; emacs 27.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d764540e-df7d-4d17-af0d-08da33e79df6
x-ms-traffictypediagnostic: HE1PR0301MB2476:EE_
x-microsoft-antispam-prvs: <HE1PR0301MB24761968046FBC9EA62BD4E0E6CB9@HE1PR0301MB2476.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LZbgMSZruv4QfY294wKcfiKJWCRX/1e+GbGXRa9fXXLxPa4P/rLTZOjHjvKuAwNgfyaQNGYJ4eGjN3txYPZaqAhqpo6vD7iXrxKcqJBn6k80K4h8NFtfSyiBm3thRG7gqt4+90SOnd5QwSEI+XVH602odXpiydyhnLakjl9ZCTIQ9m6+isj450RK0DrDLfzHFWNOX9YvX4wHvBR5uUEG5okubY29IS2uBulNG1hkSq78V4fGob9HLvG7lJB1HzmUGVmkmSLnGTgPDdoQoJHw2xw0e2EFPynjnYqmj64WmcibGn9tGPmfMX3Ns0bnbZXPq4nBVyCDagqdXSc36SbWeleJuYplUGkYKaTz/l4azP7aRKIQXJzx3WLw0W1LwCGfLIOR52GC6CITm64acX6IPPv6QsdO5RU1uXP8Caw2jK2jun+62CX3wXar/rEkcTkmE6qQRYbW5HGox23ZA0EQ5LhbzswNgZBxbsjWwv5qKHvumi8WWt09ZnPxLMe3Uzbxa4dUVa8PxG4sJ/GfhcJZxTuvxJMsmR6/fads32YC2nVjs9V+hCc4hr6RF5YWBWLCRM3lKnOk+GbxSyi4BK018R6bSbvlAfXjkd9mycd+67lMjC9N10KOTQfyp/IJvMP2qjdlratWMwmb+DgoH3HAXX53eTihv40nwS4i1vIGFuCRQB9rJX9K0r2L4ZNZ+BynFxxlaaFmJNor3Sa+k2IMSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB3710.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(508600001)(8676002)(76116006)(4326008)(316002)(5660300002)(64756008)(66476007)(66556008)(66446008)(86362001)(38070700005)(38100700002)(71200400001)(6916009)(122000001)(186003)(54906003)(26005)(6512007)(2616005)(6506007)(55236004)(2906002)(8936002)(36756003)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6BXh5+YUUU7zZ1z2taNbQNAlbqljZltBSAMtsTTe+StbNcjj/jWQqhKpbH?=
 =?iso-8859-1?Q?pLpbIxiAEk1iG9o1qdN+XyDYOT6ydLI3soDxYwz7dAiCauaTkHja+4xZSl?=
 =?iso-8859-1?Q?GIu6SLzJtswyXc7PDZp3GzHLZnd/Aw+Qgv44hGV8+hDCsxe7918i5iW9BG?=
 =?iso-8859-1?Q?+SA31+vALLnqqhj44VJS3+glAX1GB2tuiSLAODHa2QD7Q/LBWWwyUW+HFV?=
 =?iso-8859-1?Q?cmadV+an/iwoJIn/ZxyXkkHqTHNwhoEMTeiPBwcPiyy8sXCL0H2nvFsyhr?=
 =?iso-8859-1?Q?pyQ+Qfj1EJnZtHYW0vtobX1/vpjFKZa3sf8iddJdbgv3k8H/otZ4iuUsMS?=
 =?iso-8859-1?Q?y/tDXNs45/JmJgXwzgzR0IjxPxsMblyIlOQf/vJ2xIe0+HrK3nHQ73N8xp?=
 =?iso-8859-1?Q?O2ysv9mN+eBUBYXNrUgnNxeMub8b16LpwGnuflsECT3H16gRy3CQkunazg?=
 =?iso-8859-1?Q?dh3SjD6HmGeWz126iL0uii+W/USCKDRf6qISUnQIbBkmcuC1S69EyPlTnC?=
 =?iso-8859-1?Q?ChPqMsFUfmD8iW6SHrGLRzKSgL/GODpGhyEi9nAbrztzQCPlKYIsNmS7eH?=
 =?iso-8859-1?Q?ioB4XuYdSO6eiqeQoLVsG4OPjUD+vr8Ju9Ltt3dh+SjaoUWrDeNwbxfqiu?=
 =?iso-8859-1?Q?4RA62PM7K6dSIuE/R0tH/C8wB7LpjyyJAZ6gj6+SHuH7IE+uc4xZOHL5h3?=
 =?iso-8859-1?Q?GggMiZVIWGOyzMvYBX7BbRNynn9QBqikn2f38nE0Z0njYxE/+rycabKe5Y?=
 =?iso-8859-1?Q?3t+ktGYM/tBWI9ZvPY+GeyZsbxOx4BURfR0hhZpdFLIos6Oo3vRT0d+adG?=
 =?iso-8859-1?Q?0qjlncAXmIbyRqb7aLliIDFMjV8o2QmlwvCXWn1aV0MDEtVja86YFn24U3?=
 =?iso-8859-1?Q?D8ovb1cVCgUMpv0uTWeRmQOZZ2I+/STpqIAiy/dhF6CGSxB8A377SVHLbZ?=
 =?iso-8859-1?Q?ZKITVqV8Ni9AiFPlXxh8m17FmDRxXZoVats1V/fmqTnWOu6ur4JcNlG+Fc?=
 =?iso-8859-1?Q?/gI5t7Ln6DfxrG1llqfEV4pinurlVoJogGeDfiogRqiJ8X9rVbBO+/gc6x?=
 =?iso-8859-1?Q?RrMbm4g9d9K8MaxjFrAsAIayU1hqVJFrDCNylWDHglrz6cO853oNvD2Ve4?=
 =?iso-8859-1?Q?u5PM1z+s4Y3xDXgwfUViY6HzvXAL6Hr0fnkfW0AX0Mcia0QODxWhQPGihF?=
 =?iso-8859-1?Q?9YFnQxDcPLVO4igAGYTTwj1rdp70yI7xhN/MKKDyabLQRFTxBmjWCZxqta?=
 =?iso-8859-1?Q?aBZZsqGk2JZJi3OVryVT+jCoEdEHyIn6nzeB+Q30z/RSY+8bJ8Vn+LL93d?=
 =?iso-8859-1?Q?pP/8FAcLHQhlYoHEHsVFfnsriZMNapWbTGsRivXGvrxJkC+S4JHiXnBV78?=
 =?iso-8859-1?Q?/7+c93M0xqhMkckyCmE34n5CA/DuQRocYgTCq5tQ72plIdkppqa1I55G+n?=
 =?iso-8859-1?Q?491k5ogwKVTytb1YZ7X8HZUoZ8xE/MHnSa8iTCc5bbXmOeY4uJk7Kdqbyn?=
 =?iso-8859-1?Q?k/gOZwZMMpYOTUzwFEoLTTYGnuqCLJbDJo869AUWeu8XKSyGsEsq1VPxdZ?=
 =?iso-8859-1?Q?uFKP5tbqyewFkoZyAW/huwHuKJGGqj5ECrObCqkbn+OKP1n5QmSAp9FSUk?=
 =?iso-8859-1?Q?UUrXxO5aPWJ9M3tPZsgWtmZaYrv9QMVzT4ywO8MypkFQ5M7qKxgYbEBeAf?=
 =?iso-8859-1?Q?bphTioLjS1tLt+CBew6acM6KYKKc2EOh+OmHCmHi7i1C4Lk22e735WCAEt?=
 =?iso-8859-1?Q?K8F3CzWuxLmEMwj+q/cQTGYnqA12aSsb2nhF/qZ+uEpzrORshcxNarAo/q?=
 =?iso-8859-1?Q?nJ6nrfGkJlkZ2AsYijxpp0pbg/mI/C0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB3710.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d764540e-df7d-4d17-af0d-08da33e79df6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2022 07:18:30.6529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FqQNXBUOWA0COTI/CJoan9mcQc5XxJcwZ4VVO2Crw9SdIYI4CtKhajpavZj3UMbAmc0H6VGZb6XwojZSVwxgcQ8xj6hMXszocDjUB4evKLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0301MB2476
X-Proofpoint-GUID: vbkl_PoEBBmELgQLR9LPPM0iOzVmQXh4
X-Proofpoint-ORIG-GUID: vbkl_PoEBBmELgQLR9LPPM0iOzVmQXh4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_07,2022-05-12_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=492 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0
 suspectscore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120033
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Hello Bjorn,

Bjorn Helgaas <helgaas@kernel.org> writes:

> On Mon, May 09, 2022 at 11:39:30PM -0700, Christoph Hellwig wrote:
>> On Mon, May 09, 2022 at 10:58:57AM -0600, Alex Williamson wrote:
>> > is_physfn =3D 0, is_virtfn =3D 0: A non-SR-IOV function
>> > is_physfn =3D 1, is_virtfn =3D 0: An SR-IOV PF
>> > is_physfn =3D 0, is_virtfn =3D 1: An SR-IOV VF
>> >=20
>> > As implemented with bit fields this is 2 bits, which is more space
>> > efficient than an enum.  Thanks,
>>=20
>> A two-bit bitfield with explicit constants for the values would probably
>> still much eaiser to understand.
>>=20
>> And there is some code that seems to intepret is_physfn a bit odd, e.g.:
>>=20
>> arch/powerpc/kernel/eeh_sysfs.c:        np =3D pci_device_to_OF_node(pde=
v->is_physfn ? pdev : pdev->physfn);
>> arch/powerpc/kernel/eeh_sysfs.c:        np =3D pci_device_to_OF_node(pde=
v->is_physfn ? pdev : pdev->physfn);
>
> "dev->sriov !=3D NULL" and "dev->is_physfn" are basically the same and
> many of the dev->is_physfn uses in drivers/pci would end up being
> simpler if replaced with dev->sriov, e.g.,
>
>   int pci_iov_virtfn_bus(struct pci_dev *dev, int vf_id)
>   {
>     if (!dev->is_physfn)
>       return -EINVAL;
>     return dev->bus->number + ((dev->devfn + dev->sriov->offset +
> 				dev->sriov->stride * vf_id) >> 8);
>   }
>
> would be more obvious as:
>
>   if (dev->sriov)
>     return dev->bus->number + ((dev->devfn + dev->sriov->offset +
> 				dev->sriov->stride * vf_id) >> 8);
>   return -EINVAL;

I'm not sure that this will work because dev->sriov and dev->physfn are
stored in the same union.=20


--=20
Volodymyr Babchuk at EPAM=
