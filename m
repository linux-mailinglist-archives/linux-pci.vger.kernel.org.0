Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6316451B07E
	for <lists+linux-pci@lfdr.de>; Wed,  4 May 2022 23:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbiEDVar (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 May 2022 17:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235839AbiEDVaq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 May 2022 17:30:46 -0400
X-Greylist: delayed 5463 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 May 2022 14:27:09 PDT
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A40326F0
        for <linux-pci@vger.kernel.org>; Wed,  4 May 2022 14:27:09 -0700 (PDT)
Received: from pps.filterd (m0174678.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.5/8.16.1.2) with ESMTP id 244Ju6xB028295
        for <linux-pci@vger.kernel.org>; Wed, 4 May 2022 19:56:06 GMT
Received: from eur05-vi1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2171.outbound.protection.outlook.com [104.47.17.171])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3fu33c59e4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Wed, 04 May 2022 19:56:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTnoKT89S240sOx8suf1okTYfhwruj3L50Afeu/65WD7AMBlGJYbDeOlTj0KXn/uO3iquq1vQ+uVXouMaYDNsvltx3xabdK96P77bCNKnd7w7RYV+ODdjYDUpDgcXCCoqbltEZgRSxiyCJC1ArgAgVEQdwIvRkKjvO/LUdiwEhBqh/z3XrTwJtytDRk0Nj9GEwKoQP8j6P5WIkynWAnJGHbJU5iPUruzAAg9VM5USNaXxQTBGd43mhIeyhj2pITiVajraaE04n7rP/C6yyLSfVxgieYbbhCmM2zFDKUGO734jkfMmzii5FztLOhqEje8yN4vtPnI/1/e2UuJn1Ayyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqd7XE3bXVQCqmYOABQv2SaMEDbPNmSGalglGhd3FFU=;
 b=NbB46zoapX4AsYdunwXFDYmWrQXrpy6qE3UzY2pO/9dJL4P4b0cEgWBBkeDo8J8FVrnC8Ns7KjKpWFIOh4fwp+uvg8dM4tYwF+5GRb2MBRhIBSzRm22ajs+i+SHUD+PozsRQPbutZvuNAF61EhEQTNSeTLmA4K1yfoI+Tt4uBxiCgeYqnpxVshVsT8x9mUNaUQ1ooYUcsW8gsYZl1DpPdTH9rnMP+xbfOFVjYLL3OXe04jWDCZR925GCHSFMgTR3hIUWn2W9oiiEkMHKfpTyzGLg8WH/pw3X/HzXUgejz7JlMiOL9v4LVBZgdXkq25mZLcpdXercH7gjpWUytisWqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqd7XE3bXVQCqmYOABQv2SaMEDbPNmSGalglGhd3FFU=;
 b=Y919Pqbjwwkc9AGpwEt4N4hlpwc3HlQTqWuWSiVEW5fON9myTljLnBeQMYB2P7F6+Ar2H91fZsh+6qO4P5xc04iSf6vhSZl8UrjrHlwJZtkvY182KemSIpCNhXbL+eRhXWD6loWtFexxH8ybKdnlw+IeclpyMTVjCI1CBKozX/pxx5TiSKrV/6P5yEjXfcedg3ZJArx8azKlrhRSalG9BAwsCtNFM9x6ErMijczg6PR4h/SyI/oSwrHc0atUxjAZ9EoexjSsavvHmFU89lastklAn3bN2MA47MfQ96DKYRPxxFtxiNr54orVlRselX3w1sJfkGlmvMvBNxYxrw/LrA==
Received: from AM0PR03MB3699.eurprd03.prod.outlook.com (52.134.85.31) by
 VI1PR03MB3102.eurprd03.prod.outlook.com (10.165.190.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.24; Wed, 4 May 2022 19:56:01 +0000
Received: from AM0PR03MB3699.eurprd03.prod.outlook.com
 ([fe80::78c1:e5da:903e:66f8]) by AM0PR03MB3699.eurprd03.prod.outlook.com
 ([fe80::78c1:e5da:903e:66f8%3]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 19:56:01 +0000
From:   Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Write to srvio_numvfs triggers kernel panic
Thread-Topic: Write to srvio_numvfs triggers kernel panic
Thread-Index: AQHYX/D7w22LhOQ4BkKjl8Bb5V4dfQ==
Date:   Wed, 4 May 2022 19:56:01 +0000
Message-ID: <87a6bxm5vm.fsf@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: mu4e 1.6.5; emacs 27.2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 905b8eb6-5f71-4c40-099f-08da2e081d9e
x-ms-traffictypediagnostic: VI1PR03MB3102:EE_
x-microsoft-antispam-prvs: <VI1PR03MB3102E899EEEAF4BDBF7841A7E6C39@VI1PR03MB3102.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SZeZ8u/+Q5ZgT5WYUtYJZGSdo0yvWfL/sLfX8577QxtHMMffFlnWtSHas9eZCnfT6hickmUn2KxxeX30o9f4Hkbzolpa96IYD9L/luXUmpl6OVv1hCeWjvKTuUZ/OkjRqwEd9EBOWrrSr/25jUa3TZBn4GpRQXvyF3v8HgJUI2ajLie/ui2sCYtugAHB35mFvGie62lFDg06qRHc2bK48ZKSutfC5lmUh5gOm/LP14Ak9u7FsQvnWUuZ7chq2iXx2Jf9DcQMSGb2HZdJu7efGAXw8Y7Tt5n8iFcd4M3oTgqu5kMJgMGHAvHaeWsxsrqrITAn0lYtZTGsOnt3d7BI23E2euktPJSzQPExGwCdrWdJk2SSGwm+pFpjPRqMdvO/9MGnxafdUqRuNfloxaJMJFdTch/DKcFFu00pVv2VkIYAyh0KRZufrd3jx+j2xnEgBaq7ijWq3YJ67Pvu4kEXHIXnd0yY4SlLgyT8hISry4+P2uK5qhWWTDZegJ22R7TL8MV7ofxAhhsVik8kcSrxQXTpKmXj8GzHGF9t1N5r4YSsldO+ZShhRIOhxYj+fQDjzaJ/NH8YcmVpV7qLgxUiaoGnCBkUaR4GVBSVb8edh7oCdJi8yg2XIhuArh8qyzfdl2umKKOJZEdyIrkoToIkqy6NUfyXzxoQ21HBIzkcTZD71EU3i9RxocS2z/BccF9tCFAoXnOTOmeefz7huerrIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR03MB3699.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(186003)(71200400001)(6486002)(83380400001)(508600001)(45080400002)(6512007)(2616005)(55236004)(6506007)(86362001)(38070700005)(38100700002)(5660300002)(122000001)(36756003)(2906002)(66446008)(66556008)(66946007)(91956017)(76116006)(66476007)(64756008)(8676002)(6916009)(316002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ywkrhkW2U6CSyeDKKb/H8YwfzYD8Lllapsg7NrIPbKWmX1bsKqbzGy4jR4?=
 =?iso-8859-1?Q?vyE8ZE1DN0DQNnqFsmfeIwWkEKyV9yA2Reo4KsbPY4i71WtKn8+vDniaus?=
 =?iso-8859-1?Q?Z8SRY8Rk7gM2dV28NopiMx8LvluItf28Hd5+eNOeS6ZzSm4i8T42oKmuei?=
 =?iso-8859-1?Q?yPtiXAM5vmCGPzMjrnqtHiMlSb2nbk3NSzp7XcKZ0u+kM4lQ7UnfIlPnX9?=
 =?iso-8859-1?Q?7nE7g85UWMC/C6wnyA6EIFfPv9ILcEBr5iBNdXUL4LsJ4YtH/r7nRdSOvU?=
 =?iso-8859-1?Q?vv3rOjsgXaXJRSRP+rzjvTJwfABk80PnBD21sq4xrZpqzGbcBQ+LumTlhN?=
 =?iso-8859-1?Q?C1+NXjWDB+roebmjz2K5jLokFItolAaBRA2tV6FBQ92jWQ3qI4UBbYHWiP?=
 =?iso-8859-1?Q?89jSnhc/CrkbBIpmlwwYacE8WWK1h8+A2zXPHIE/hS7CAMMXlqvsdSEDdz?=
 =?iso-8859-1?Q?gnPnhIAHLG4eqRN9Ui9HLZhrVVwyFXR7Lj2vK+YJZQF95iviR/PH3w/RZD?=
 =?iso-8859-1?Q?oBNTFDJE9+8k+/JZb0z/N4nJIp2A2OlweVkt2TU43r++rGBZYiJ+gg8T2Q?=
 =?iso-8859-1?Q?fgO8WoWkFrmYX+UWSkYRtIAmCXwq1jSzDRchBEvHHd4Hl6XWmifgsoKazH?=
 =?iso-8859-1?Q?mDFubRQw5rl53vmiDEUTRV5wMcQroc16u3waMJtvSrdEpseVi/upq8fPlm?=
 =?iso-8859-1?Q?LX9AvPK25NAhQlKpRNoJNFiFiOCb4/bO/sGbjRPOd43LHBDKN0YKnOBX5+?=
 =?iso-8859-1?Q?JV32khR1Q0EZ4zGsC4vjXOQmrzJm6YMxZDKLUXr0KtTlvPU7weRFia7EWY?=
 =?iso-8859-1?Q?Gn8hre73Uyg9fyknLQf97kgPHybaaWi3lvuj9E2lRxQp4Ni9AoW4QGT6sj?=
 =?iso-8859-1?Q?i1vtctJzEq0QlfLT67B5Uzd2ZwcDUZFlteMXHvD/d+jA0h6HCokW4zNpp8?=
 =?iso-8859-1?Q?/MgO+TI+Fc6H5Itx27/IOfLcfwW8efv2qz2YakvQHCWBcwIWx+E5wr6bp7?=
 =?iso-8859-1?Q?//MRAgvS3+aSZfC/RYniL8V9npjRxjCMGDo+vo7yfvbW/fLHYLX8Vtj6F2?=
 =?iso-8859-1?Q?9g3u6FLfzwSpXIGTatHpunUIYsbvFP6NZx3Q5iVM+J79Izv8cjCLJgESyq?=
 =?iso-8859-1?Q?fVxEm3+Qr4GKlnyqx+T0jxT8OSnc8YSQRhY1p8TgkRLERey06FksWIVQVU?=
 =?iso-8859-1?Q?YZAs5rQWjwWXDSAPk6NYD07Myu41jE+2fxBkgL/zlZXSwIsn9icf+91GSC?=
 =?iso-8859-1?Q?JGGUEuXK/fh5LmfmT0643+JMmvEEu9W4w5hYvVwLj5pLEm/cZOTEbvZrUs?=
 =?iso-8859-1?Q?kAbB2lchjyJK0sDLiO4xynKKeBMWX9xAEu1QVKn0Lm9kbsytdwHxhWtJ5j?=
 =?iso-8859-1?Q?pzSvW0GQ05tZfEEfnjEF27jYuCeHydmEdr9C63sx5OreUPGT7OFg9jq9Wz?=
 =?iso-8859-1?Q?Nan5LmAR9ON2WMxyMHJEq1m9lxNEGqYz+3Uh0g9sLQza+BnaqjHIEkkzgB?=
 =?iso-8859-1?Q?O0G0STfOw4FW60ra+LYn8hu+Jss4KY0pRgdYQzbv+I3BOEPLGEMPcVX5zl?=
 =?iso-8859-1?Q?GTfqvOofFhNb8g84hLEVb0gRYE3ZDTNfoyy8XfBhSj9uwByCnOhplyflPv?=
 =?iso-8859-1?Q?Tzilm+FltP7yp4QVOZGJvbxnM7TmOgAbvHxt3ihQeUm+iLotoAnV9wtAgF?=
 =?iso-8859-1?Q?ynLVJCrIhI4lOebcJtJedrXO1/a/P6kBqQIQWmkdfXU4S/Sacx93JlURzs?=
 =?iso-8859-1?Q?wH4dPxplZcvMjKTZTDuoix+6C/z6RMdLu6LhRRW/dYlyrUVcVAxA/XHZSn?=
 =?iso-8859-1?Q?gND45kwt6dNTCIA17QLA4c6AWl9TUjk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR03MB3699.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 905b8eb6-5f71-4c40-099f-08da2e081d9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 19:56:01.7234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4KkoKXFAVqf76Kzyy1tJJNqIZbEbs1adxY5han3punQV8m/6hpgAHSBg+WvpkgOpcwechHw9Oxj/SZ8OR0Fca4XIT1Tn94f291Txm8cUVVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB3102
X-Proofpoint-ORIG-GUID: pPEQU-GirD5gRC9ZjsmjUVtgHQV9Ibw3
X-Proofpoint-GUID: pPEQU-GirD5gRC9ZjsmjUVtgHQV9Ibw3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-04_05,2022-05-04_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=389 malwarescore=0 phishscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 clxscore=1011 bulkscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2205040116
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Hello,

I have encountered issue when PCI code tries to use both fields in

        union {
		struct pci_sriov	*sriov;		/* PF: SR-IOV info */
		struct pci_dev		*physfn;	/* VF: related PF */
	};

(which are part of struct pci_dev) at the same time.

Symptoms are following:

# echo 1 > /sys/bus/pci/devices/0000:01:00.0/sriov_numvfs

pci 0000:01:00.2: reg 0x20c: [mem 0x30018000-0x3001ffff 64bit]
pci 0000:01:00.2: VF(n) BAR0 space: [mem 0x30018000-0x30117fff 64bit] (cont=
ains BAR0 for 32 VFs)
 Unable to handle kernel paging request at virtual address 0001000200000010
 Mem abort info:
   ESR =3D 0x96000004
   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
   SET =3D 0, FnV =3D 0
   EA =3D 0, S1PTW =3D 0
 Data abort info:
   ISV =3D 0, ISS =3D 0x00000004
   CM =3D 0, WnR =3D 0
 [0001000200000010] address between user and kernel address ranges
 Internal error: Oops: 96000004 [#1] PREEMPT SMP
Modules linked in: xt_MASQUERADE iptable_nat nf_nat nf_conntrack nf_defrag_=
ipv6
nf_defrag_ipv4 libcrc32c iptable_filter crct10dif_ce nvme nvme_core at24
pci_endpoint_test bridge pdrv_genirq ip_tables x_tables ipv6
 CPU: 3 PID: 287 Comm: sh Not tainted 5.10.41-lorc+ #233
 Hardware name: XENVM-4.17 (DT)
 pstate: 60400005 (nZCv daif +PAN -UAO -TCO BTYPE=3D--)
 pc : pcie_aspm_get_link+0x90/0xcc
 lr : pcie_aspm_get_link+0x8c/0xcc
 sp : ffff8000130d39c0
 x29: ffff8000130d39c0 x28: 00000000000001a4
 x27: 00000000ffffee4b x26: ffff80001164f560
 x25: 0000000000000000 x24: 0000000000000000
 x23: ffff80001164f660 x22: 0000000000000000
 x23: ffff80001164f660 x22: 0000000000000000
 x21: ffff000003f08000 x20: ffff800010db37d8
 x19: ffff000004b8e780 x18: ffffffffffffffff
 x17: 0000000000000000 x16: 00000000deadbeef
 x15: ffff8000930d36c7 x14: 0000000000000006
 x13: ffff8000115c2710 x12: 000000000000081c
 x11: 00000000000002b4 x10: ffff8000115c2710
 x9 : ffff8000115c2710 x8 : 00000000ffffefff
 x7 : ffff80001161a710 x6 : ffff80001161a710
 x5 : ffff00003fdad900 x4 : 0000000000000000
 x3 : 0000000000000000 x2 : 0000000000000000
 x1 : ffff000003c51c80 x0 : 0001000200000000
 Call trace:
  pcie_aspm_get_link+0x90/0xcc
  aspm_ctrl_attrs_are_visible+0x30/0xc0
  internal_create_group+0xd0/0x3cc
  internal_create_groups.part.0+0x4c/0xc0
  sysfs_create_groups+0x20/0x34
  device_add+0x2b4/0x760
  pci_device_add+0x814/0x854
  pci_iov_add_virtfn+0x240/0x2f0
  sriov_enable+0x1f8/0x474
  pci_sriov_configure_simple+0x38/0x90
  sriov_numvfs_store+0xa4/0x1a0
  dev_attr_store+0x1c/0x30
  sysfs_kf_write+0x48/0x60
  kernfs_fop_write_iter+0x118/0x1ac
  new_sync_write+0xe8/0x184
  vfs_write+0x23c/0x2a0
  ksys_write+0x68/0xf4
  __arm64_sys_write+0x20/0x2c
  el0_svc_common.constprop.0+0x78/0x1a0
  do_el0_svc+0x28/0x94
  el0_svc+0x14/0x20
  el0_sync_handler+0xa4/0x130
  el0_sync+0x180/0x1c0
Code: d0002120 9133e000 97ffef8e f9400a60 (f9400813)


Debugging showed the following:

pci_iov_add_virtfn() allocates new struct pci_dev:

	virtfn =3D pci_alloc_dev(bus);
and sets physfn:
	virtfn->is_virtfn =3D 1;
	virtfn->physfn =3D pci_dev_get(dev);

then we will get into sriov_init() via the following call path:

pci_device_add(virtfn, virtfn->bus);
  pci_init_capabilities(dev);
    pci_iov_init(dev);
      sriov_init(dev, pos);


sriov_init() overwrites value in the union:
	dev->sriov =3D iov; <<<<<---- There
	dev->is_physfn =3D 1;

Next, we will get into function that causes panic:

pci_device_add(virtfn, virtfn->bus);
  device_add(&dev->dev)
    sysfs_create_groups()
      internal_create_group()
        aspm_ctrl_attrs_are_visible()
          pcie_aspm_get_link()
            pci_upstream_bridge()
              pci_physfn()

which is

static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
{
#ifdef CONFIG_PCI_IOV
	if (dev->is_virtfn)
		dev =3D dev->physfn;
#endif
	return dev;
}


as is_virtfn =3D=3D 1 and dev->physfn was overwritten via write to
dev->sriov, pci_physfn() will return pointer to struct pci_sriov
allocated by sriov_init(). And then pci_upstream_bridge() will
cause panic by acessing it as if it were pointer to struct pci_dev

I encountered this issue on ARM64, Linux 5.10.41. Tried to test
on master branch, but it is quite difficult to rebase platform
code on the master. But I compared all relevant parts of PCI code
and didn't found any differences.

Looks like I am missing following, because how SR-IOV can be so broken?
But what exactly?

--=20
Volodymyr Babchuk at EPAM=
