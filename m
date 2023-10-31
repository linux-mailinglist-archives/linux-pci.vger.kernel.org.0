Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFF77DCCFA
	for <lists+linux-pci@lfdr.de>; Tue, 31 Oct 2023 13:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbjJaM0h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Oct 2023 08:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjJaM0h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Oct 2023 08:26:37 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1AF9F;
        Tue, 31 Oct 2023 05:26:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngjY5b8kOezldEcR/2ZVm+96uCbYDJcahRdKs6Ww3im6XAfspi8Q2yUeX3aI/AfM9uC2aC48YZLkRHi31W1rdN/DydGhPvS3UQQHMDkEXKuRBl3SVXf/mhZ5aZ5Zd5b4GlTqdILV5CvmIKYbe+PvPfgowagWm5Ln7MEmVUn579D4+ejmTQjDR8L+79EaUhYO9kprbCujsg+5/CN4h3jvHIdWf2a4hb8rNeBMzQwRrpc1OXM3Ef6Jrjj/yQ2KB+1exzAx7cSpzuHeRq8TFEl4lZ6pEunqbSTRxReF9xoSzeOQ4SZwm8q8+oaMJwG9bqJFLIGlw4YIhGIqXoC9lS1N4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDCMWNLPmLMBBEruuczoaL8eIs5YEBtT9K16Oo3plNA=;
 b=cn921dV0wTIoorQDVBdIGC+SYqNfiWFcEuTXJlZO0QUrZBkZA8mczrhbhRpwbLACORIJT9BI0MwHuocw/0JUPRhlS2SebTC+2pB7qXC0CkaLolPm0Oc54rPTuPzyJ67tge+hFNen6MkPoG69YFBdAM2wSPJm38N9RKFSwuWGJhyYfONo8cpW97ZGwfYJyzMPgHPrJuE3pe3k7QR02+lXTa/WxUf/1oX1GzXz/CZXZcTuNYqv3VFL5S8FvsL9wMxRGGlj324lmFByDDUgWmaFs5mTroXVgySKa8VbsKHDjuqFveaTgUdi+bQKRKVvLG3jd6Z/CNs53ANAJ3oi1gKiMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDCMWNLPmLMBBEruuczoaL8eIs5YEBtT9K16Oo3plNA=;
 b=Y2ZVX3bnfPV1XMogrbuWL3KOV5AtQ9GCkVLqJfR3i6aQ7KSj4Ry8s2BllhN+DSg1jgJIzCxwl06R3OC6QwRnSRl2EnVRZsH5pUuZDR0NT/x70W4HSePRMOqZ5v8RizqQWL0arQILr30QkcRSGGPdLQ0ddhBBOiCVkWP9QgXd16pkAnF2zSII+Ky2KN43WqCUIQcaSKSRPmRR44ETFNjVw6a8c5m3Rqz7WwMGs1c95A9lrIGM7i2l3B9Ugo75TIaEjYIDR/x2uBxQfzSGr6llx7B8Ax6OIt3KWsWo8FU/xJqiNrCuzOxEi3hnlDSFK5evpmWDv1T3OJw8Xqym3YaE1A==
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by MN2PR12MB4439.namprd12.prod.outlook.com (2603:10b6:208:262::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 31 Oct
 2023 12:26:32 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::eda4:8c67:893f:3d13]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::eda4:8c67:893f:3d13%5]) with mapi id 15.20.6933.029; Tue, 31 Oct 2023
 12:26:31 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
CC:     Vikram Sethi <vsethi@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Thota <kthota@nvidia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Question: Clearing error bits in the root port post enumeration
Thread-Topic: Question: Clearing error bits in the root port post enumeration
Thread-Index: AQHaC/Tnhpk/uolTaU6mIGIsY9fcSQ==
Date:   Tue, 31 Oct 2023 12:26:31 +0000
Message-ID: <BN8PR12MB29005068F39DE028F19084EDB8A0A@BN8PR12MB2900.namprd12.prod.outlook.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR12MB2900:EE_|MN2PR12MB4439:EE_
x-ms-office365-filtering-correlation-id: cbb6f2db-c430-4911-807d-08dbda0c9d31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E3lnd9TNqWP6e4i+9K9ZPH5NWhLpv1+AktxW1loOfNjbQMoJCKoHDAWOw1MKi8s3AtSfTt54K0QrSDQYuOD/rmYdSwsouUzGmiVwnn1f2V1Ws/WjIJl3SeGmmvti36LxNYsozz7no6NF/FKAagC774WEhJNHGWKPvxW9WL/oFTAAIJiZyyZTtYZD/k4gb/qWT1gcVJDxc0w/6KkD+nYSKS5ZVoHvNiWWgSNQEkp6MrJX8M1yI0IzqM4b5PBrLUQBKkYIelveI7kivALI96TM2zPUeQk7phcBTdORR9N57wdhzi16q7CiJb+GzIM9NZliVG+D31lvKUxtUA/2qTp89bmrE5ww4geAErrBGa7Br3/xXWUR6jkOBnX+9v9Wa8AwMLPq75kot97NSsOmU3wDYcC6+/Yq8cV7hoJkzj8KPpmf7cvatqdFEEiKdXzUCAelDYHcenPepz2+/BCifJ5NckFDh+746lJYX4hkpSzMbr6T9ZlxqVkCdPs+H66a9v36gK8HgSmTZHqgvUI6U3TUFGrflUZjfMF3uaVdqTrt3FJMT+Vb96vk0UT036rWRAMC74fUrs5mG9lN4FS1btOy28QzeE2DF1uA22DtJgjGwUH6OXyBo/gJB59ZjTEKcPW3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(366004)(346002)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(41300700001)(316002)(110136005)(66446008)(66476007)(54906003)(64756008)(66556008)(52536014)(8936002)(8676002)(66946007)(76116006)(91956017)(5660300002)(4326008)(55016003)(122000001)(83380400001)(478600001)(2906002)(26005)(33656002)(6506007)(9686003)(7696005)(86362001)(38100700002)(38070700009)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2ikFE4iUC7eu5bQ2fN0sTMFPvZJll7BY9qcqcIMmf2ex5568oh+3o+kfGP?=
 =?iso-8859-1?Q?oULgWq14MUWzeEuXpuj3ZG5Jj72xPLI7n4R7L5C5Gf9OZ+y100vcrM2VED?=
 =?iso-8859-1?Q?SxfIuL9WM8F90knFdC+ANUpdri27t2SjhGMWV9RMtX4yFWHs8fEjIrBWiN?=
 =?iso-8859-1?Q?fFrHZlnyUsEdULFFjh9WyP/dxKz29/Dyx8QtbAy1xeUdHe33OlOEN1eQIK?=
 =?iso-8859-1?Q?o+bTG9lT8x4lDUC+QfdsylNOGcqDv/sIfqFO8xHYMR9gBG72krWMf5Xore?=
 =?iso-8859-1?Q?+bQ3Y/FGf8phnZjMF3vFAEsS88GebpzCSB1pATFGe/ZqtyErX6We0B0OWM?=
 =?iso-8859-1?Q?Vp3jCBLi0l/0AQ+unwfwLuGBcf1pg+YyHS3qGBn9LV9Uapwn0igIau+e18?=
 =?iso-8859-1?Q?rWZ1+EebujBRhIsJwlVMSP6qlgk+Uz5JUGjLzSGfCzwN/SdotNRiNILIm7?=
 =?iso-8859-1?Q?oktdeaQYvuLusWYx/wD1uHjAU/WwA7x2gm6jg7mftohf7t0SLCX7zAAhNj?=
 =?iso-8859-1?Q?mm4tT5JTCpw3xigerMamuO8/XmScdqzFhusnDS4Uv3Hpkdxoa6X3RSswOt?=
 =?iso-8859-1?Q?TCj27MyGK4aP6v6n/CCUKNjDVQPWf17EheH12ud/2tN6XTYsfHbSPL8CMv?=
 =?iso-8859-1?Q?KS2NGKgKEw79P4ehjiTxDac3zDohaYamigZDdKdIDzx3dBg5Rm4987Q5EA?=
 =?iso-8859-1?Q?nltDP2eO7wshHkttN1cVN9kM1ljExtiFmWRoCdrvMFtqXUWQOvuwcANrKS?=
 =?iso-8859-1?Q?+1xB/zax3DoFTNJ0YMvXGq+xG9lE6/KCeaG9JzSf3OJN4pD4kp22ptTLMo?=
 =?iso-8859-1?Q?t4m0T0gfXt2j6zMlcERDD693GXTv98TpbVkW+l46v91tCqYMqTWqW1dOLI?=
 =?iso-8859-1?Q?eiVutRw9iiQFX8G8pri1MduD2A/LRGJHkXJWuW87YaUhe3mZ6S8ioHiJtR?=
 =?iso-8859-1?Q?MyGN9kND6zj13yr5L0tO18Kh3rMWdQQMuOoJmYs7h+4x5bPHwMY7MDdb8e?=
 =?iso-8859-1?Q?R+Mxc00YbOB5CSnEKuZ+xd9VgNzPMK3HANBLSUIw4em5+EF7hF8oH13QqY?=
 =?iso-8859-1?Q?zuhCXWUT67VuHg808/cYM69qb6Nws9Pw0H++GAfjBKtVJcaCaI3W81V9CR?=
 =?iso-8859-1?Q?5sCclMIjOivP/85yo63BHYgOajoQb8+SbfZCbi8grw4/vMyYbY7a0ZDpUg?=
 =?iso-8859-1?Q?hiaCnapeq4txMBbUtGmRIT0/YUh1i6rqY7V+x3cURyxJeYMlrYp5BPjafa?=
 =?iso-8859-1?Q?4uCbb7lCv8vE3bp2GqIcNUyR4WHRDe/iX8stTarWnAkZwX6oQ9wsJ2OgbF?=
 =?iso-8859-1?Q?cRmg/N1USzOyzj026qrxiLKx2X4RhuOb8VEd6Wn6u2owkoEGaEpiLTERzx?=
 =?iso-8859-1?Q?FOXLEjGJ9c8YyjGjL4C5/QiGQPzKifFwf2ZQJE94ofPt95Bo48ScxwGPRu?=
 =?iso-8859-1?Q?V0T9DYr9obeYRDTXX2wrt9FnlvNNlTTSwEitRw4Zc8EtrFPVkAqHcm2lU9?=
 =?iso-8859-1?Q?TgzcELJiJc5MlAVO/vO0VByrIswwxBkNXjUKsZZsCLKAKE/pqqjipHjK0+?=
 =?iso-8859-1?Q?e9ET46w/iqh7J12NkK9rYJoew9MEDmsMskYuSWqPIK3/vumDRXv9iEIHaP?=
 =?iso-8859-1?Q?8KVgayEQvGiA8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb6f2db-c430-4911-807d-08dbda0c9d31
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 12:26:31.4477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dqe/6S1k/hYMKBJ+73fSsFtGSCvIwR6UWkA6cilJggJLbeTYm2v1AtEVL+rLvjAzNAZmZN4tZAagfYpehmJQ7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4439
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi folks,=0A=
=0A=
I would like to know your comments on the following scenario where we are o=
bserving the root port logging errors because of the enumeration flow being=
 followed.=0A=
=0A=
DUT information:=0A=
- Has a root port and an endpoint connected to it=0A=
- Uses ECAM mechanism to access the configuration space=0A=
- Booted through ACPI flow=0A=
- Has a Firmware-First approach for handling the errors=0A=
- System is configured to treat Unsupported Requests as AdvisoryNon-Fatal e=
rrors=0A=
=0A=
As we all know, when a configuration read request comes in for a device num=
ber that is not implemented, a UR would be returned as per the PCIe spec.=
=0A=
=0A=
As part of the enumeration flow on DUT, when the kernel reads offset 0x0 of=
 B:D:F=3D0:0:0, the root port responds with its valid Vendor-ID and Device-=
ID values.=0A=
But, when B:D:F=3D0:1:0 is probed, since there is no device present there, =
the root port responds with an Unsupported Request and simultaneously logs =
the same in the Device Status register (i.e. bit-3).=0A=
Because of it, there is a UR logged in the Device Status register of the RP=
 by the time enumeration is complete.=0A=
=0A=
In the case of AER capability natively owned by the kernel, the AER driver'=
s init call would clear all such pending bits.=0A=
=0A=
Since we are going with the Firmware-First approach, and the system is conf=
igured to treat Unsupported Requests as AdvisoryNon-Fatal errors, only a co=
rrectable error interrupt can be raised to the Firmware which takes care of=
 clearing the corresponding status registers.=0A=
The firmware can't know about the UnsupReq bit being set as the interrupt i=
t received is for a correctable error hence it clears only bits related to =
correctable error.=0A=
=0A=
All these events leave a freshly booted system with the following bits set.=
=0A=
=0A=
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort- <=
MAbort+ <SERR- <PERR-          (MAbort)=0A=
DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-       =
                                                       (UnsupReq)=0A=
UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- E=
CRC- UnsupReq+ ACSViol-   (UnsupReq)=0A=
=0A=
Since the reason for UR is well understood at this point, I would like to w=
eigh in on the idea of clearing the aforementioned bits in the root port on=
ce the enumeration is done particularly to cater to the configurations wher=
e Firmware-First approach is in place.=0A=
Please let me know your comments on this approach.=0A=
=0A=
Thanks,=0A=
Vidya Sagar=0A=
=0A=
