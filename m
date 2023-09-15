Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEAB97A2371
	for <lists+linux-pci@lfdr.de>; Fri, 15 Sep 2023 18:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjIOQVW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Sep 2023 12:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbjIOQU7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Sep 2023 12:20:59 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E912134;
        Fri, 15 Sep 2023 09:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694794854; x=1726330854;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Kd9FQLmv9I6ieBzoywjLv3XfoVFdebCIZX5u0I2DOZg=;
  b=qCGvv5F4mFPyI8SU9v+ddK9ZJfL7qGWy3/oAn04E/M2CbML5BUODJm9Y
   7ELrQBxCma+vn4WI3vcs9cRMmHYl8G7AOwlk3NJfb3ITCaG62q9ieHFqE
   6oz4WSd2xbAJRW0q/B43Y7YAtmUT1LJAiraGUnbv7Qb/vKzgsx1hCxZjA
   vLO6KGSu6yI2lLACxvz/ODgOJiVwtsN7XDqRSEg0j31MILGnF3yQ9lIMq
   qH+RqJIM5EJBsSPsGtYC0VI2zNKyDJ9FgC+dXAwbeUSao7HBJf9xzT7LO
   jm71yckBsr3NP2PszgG7uR+ga1PmTncXdZJzMJudiAW4CYXG/dK5Jinxe
   Q==;
X-CSE-ConnectionGUID: f7+sVxWCQu2PmNmr08Qucg==
X-CSE-MsgGUID: qrzV0Lf/Tt+KEdDzKlAjAg==
X-IronPort-AV: E=Sophos;i="6.02,149,1688400000"; 
   d="scan'208";a="244407453"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 16 Sep 2023 00:20:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EX1x/WOEf3UU82WcDOKJ4nGPRtBG1KwFiGLNB4UZaJ6XNur//JcmZWGAW4NL8Xk0nVoAewxpK0qXqV1H2EAKGjvJgnG8RSI2euUN29F8vcEMzrqP3T94v0jus5RFgiD5XXTU0bLKhyX7k4NFPAW9du6xkXV/6wp8EhkGOReZe/B10paGIXNbQRZ1YYnO+ovRGNxKL6pboTseumO9OF0bzUSHnfNmwNDv6NXIKbOdbhFtdoo/9cBG/GHpzAXBfw4FfKlldUlWEB6EScTydMmI/cn4vQba3eczH9C5QCXsbFujwZWoL6p2WPDI2imi/hNwXP2pyjpZv6ukmPdlVRO0hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNUhVwvOwXHkEUguJb2k0ebqRaijCB06F7Qzk1bEUB8=;
 b=EiG4I6uCm6HJxzGNdSMuUshalVmSEFFWUqipuRdDqr/zJpqC6N7Bl8LsFIwASc7w/ymhB3Z+pvl/FeAJXor7c/dFPZJIdU6ZI+Y6RB9Dj2NSH5hufH0EF7vCvLRulgTsMwC+OViu8PvixaMT4Y05DBa+uVavrK8gCTrIGHwxVk6WE5fOz+vLptgCNqyA+NGfD1AR0sU6K17oT1WmAfIyMR9o7bJc2Qryz/vTL5/P/jJowNfeRLaSIi6fkHuc+l9UdjoZWkJflmRpOFTP4lXLvAxeTTYPC74l/xz8NIC8nHUNYPlwS41vxp/tMVU2i67HBTTDMbzY2/qe334lky4Oeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNUhVwvOwXHkEUguJb2k0ebqRaijCB06F7Qzk1bEUB8=;
 b=ZB135zmAMEvALea+ammrZQGtNdDxUcwxDr/3wk+mqTPxccOqcwxvKvyzRnz3tLwVtU2IXcfxFmnfu7WqS2Ck/BemW2fDzYNAKqaONITPIk9aCsaqeAikZhSOGfZe8T1orywwh01oTyth4bTj2EnC45vBNwRuNNx6DzRXagQaiFg=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BY1PR04MB8653.namprd04.prod.outlook.com (2603:10b6:a03:525::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.8; Fri, 15 Sep
 2023 16:20:48 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5%2]) with mapi id 15.20.6813.007; Fri, 15 Sep 2023
 16:20:47 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     David Gow <david@davidgow.net>
CC:     Damien Le Moal <dlemoal@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        patenteng <dimitar@daskalov.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux IDE and libata <linux-ide@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: Fwd: Kernel 6.5.2 Causes Marvell Technology Group 88SE9128 PCIe
 SATA to Constantly Reset
Thread-Topic: Fwd: Kernel 6.5.2 Causes Marvell Technology Group 88SE9128 PCIe
 SATA to Constantly Reset
Thread-Index: AQHZ5lSnupdrJGnYN0eHoLtrJK7xDbAbOvsAgAAnCgCAABQ3gIAAIHCAgAA8gQCAAEFTAA==
Date:   Fri, 15 Sep 2023 16:20:47 +0000
Message-ID: <ZQSEXl0GB3iKoqjZ@x1-carbon>
References: <dacb34e4-ce58-bc0e-8206-672d743a3e34@gmail.com>
 <ZQHRQHAPQdG+Nu1o@x1-carbon>
 <59f6ff78-6b45-465a-bd41-28c7a5d10931@davidgow.net>
 <10f65dfe-5e8a-10ab-4d89-efe693c07caa@kernel.org>
 <658b9285-e030-4987-86a7-57cdb6c7f161@davidgow.net>
 <ZQQa0QRhm1BuI5IT@x1-carbon>
 <49d92af6-4968-4066-b33c-0fd06f8fdf28@davidgow.net>
In-Reply-To: <49d92af6-4968-4066-b33c-0fd06f8fdf28@davidgow.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BY1PR04MB8653:EE_
x-ms-office365-filtering-correlation-id: 54389ab7-a9ab-4491-03ec-08dbb607b845
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cSz/8nMbLG/bTXOWcuYu+blp1vCdRC8o2kvVrZjuvSU5n+MeAzOsiT0A0FkBBb0q6fbqBBDnJqlD7xVWCvOVz52V4iTdDz9aIrvse6m3pq8JXYpwUKAx/+lM3z1WYcC35bj71Jja2QlpCVCDZSj2yA8BBY0L8uNoyrt0vsshpN2k3TtTE//0S5oIthkQX9pDAGzkGKvIJWAC0q9LuPnuurMlLPLIUcL3hxcKKtOr88R2LNGMrvWJnhsbF6XbFuZnOKkZ8nV99ElXZ6+hjnW9IuTTfoEqCTQEHEwZfY5eATHCG06Wg6sZUpwNrN9BvC9KdLr4t+oJKn0A7TIA7w0ljDwS961vD22S2MgSNRV+HkCnrCOTS4VCScgXEEnp265/AFvXwGIgKHHP0FaC4QUUFV1Dy5ab3M/UNwRbySdqD2E9jawwgMklW2Vp1uzIAckyUhBrI1D8pVW7jMXk4DQgEz66GnsdeNN5AhUCOHiVwM0dZsEfLl3WWol8pJdjxiA6uGW4Cb8I7+NaREYUxHiTBTZRTdyCMj3Bd2JgSmGJwMf1AHjYjC/bKjHqPrQbQrWKULoih+HbrfpiZtXVFjet9zhwqwkyVDelxN5WA0V06tg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(376002)(366004)(346002)(396003)(451199024)(1800799009)(186009)(83380400001)(71200400001)(6486002)(6506007)(16799955002)(86362001)(38100700002)(38070700005)(122000001)(82960400001)(26005)(2906002)(9686003)(6512007)(966005)(478600001)(5660300002)(91956017)(4326008)(8936002)(8676002)(33716001)(54906003)(41300700001)(66556008)(66476007)(66446008)(64756008)(76116006)(316002)(6916009)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/32cIwYGuYxgmNF7Vzt4HKIBQbKc8jMRl2t9ZcgnsL41ZzRq4JUwvTzR7gBy?=
 =?us-ascii?Q?8UQ3zSFuuSoytLlPMv1HYIeJezYKCvLj0xZAAzXE+5jlE4+Fq/9FMFyQtSEE?=
 =?us-ascii?Q?xepd5/WGqAdYQNcs20Ea379ngv9NKEVfss8M/OfI8Tgd2tiQl5XozwmaQeWQ?=
 =?us-ascii?Q?C8shWrR7YZE2XvEgJTYL/+nQhy92w6DJ+cSlptLVhczaC2bUxk6bZxZqy1IH?=
 =?us-ascii?Q?zEmIgFxVmbR1XLS18xqbbP3vzDu5aA8d3CgvXNiezoSZbbPTWkMN3Pv3NuDn?=
 =?us-ascii?Q?GWA905iTTeKF0jITRxZYyl67d7GD6J+ayVJBgOSpCBpGU02odF1pvrckFsD1?=
 =?us-ascii?Q?AA/uqBfnmCRORv3aSgYBFo3DGM1LRdK6jBpJYgqkkigCPD1UX0kNQSqg/SEt?=
 =?us-ascii?Q?XrD9d4LTy6D88Tv9W0HMXeH2iMYwE5aeabRGymx9eto+I2jePxOwvbelZqnB?=
 =?us-ascii?Q?PSVE6qW1DkfDaUeTQXWdM4IIOhB4V/HVYh2i6zQC+QWp//RZ31z3bDxhEkZy?=
 =?us-ascii?Q?e10Q08PfxK3fTnvHMfl4dkTXQt1tOxQ9ehyjDtchJgOSzL7aGDmNj6IOov4n?=
 =?us-ascii?Q?xlBWlts8HtQTLOvb7HTcCi8w/OP6NaeIxVsNXLRbk0UloazZTFRiPj3UhNQL?=
 =?us-ascii?Q?J2P/Qt7DBPALyRBSYh5yF6f+noLYj/mKMJ1OI+VJpDV0OqxT6FWIQB61V0ub?=
 =?us-ascii?Q?06DvU1K4Kxhz85qKlJ6Ryji83kAYQNgi+bj4PE6BgC2R2WCNtVJ9XYcmJ4s3?=
 =?us-ascii?Q?ckWMW4ha3eM4A8AIfdsFaEbVGxJxXBAxVtMk+WkrJSZD53ihPpLWdOBmOxOt?=
 =?us-ascii?Q?KS+B4EQEIulFyX1klAK9ZQd8ZxZOJOicgJjQTdHHmWOx3lfyR35UtfdThWwM?=
 =?us-ascii?Q?7DLyPgjbRIp5WQF5NODRmNgQrTuuztypDlj0+WYHPpiHZA7837N0Z6INWA/x?=
 =?us-ascii?Q?r0f2rE5LlSel6fGXA51GVR+iXjDR1+s8femV78FmPOclAKB+cHUDdH4V5sCJ?=
 =?us-ascii?Q?kbIn6dUKifs2W69OR7byGVKSbT+RJ01/G5MU619oCioh7Pqwg5ZUYXuksNf/?=
 =?us-ascii?Q?HHyxVUlFapEpgl/UuqqGFvEb2r/AehBKj0bhfaPcexh21k52cL8FxeiMHdmV?=
 =?us-ascii?Q?9283FOKRl2ism89fEQhYAIzo+h/wkyJQFkGd+342kKlv4B+cD8+NlVkmVD3I?=
 =?us-ascii?Q?fi8kfK5wVVLqqtRtNpxQQvTjF0WlUIL5qlS4qjnXjRGsEiJP1RHFDrPO3kbu?=
 =?us-ascii?Q?vWpdDHAdpljAZJl0qISiBg1h62YJv+uNZcOATqCEnkmfzEUI5gfLARuOL3JK?=
 =?us-ascii?Q?EMOcYB84ZdBPi8LVe6H9dDSafAGto6EHrevDjjbS5roc8eC+hUWrRAax2VjB?=
 =?us-ascii?Q?VF6WF1Ul8zrhLxilZtlnyDKQaR3RVJOWWdhAytEjrYjqfsguHvuLonIy0R3P?=
 =?us-ascii?Q?A7EJlSNy4vfsgsvYlxktx6zOgnUwHl5CmuKB7IjUTNQNDQgLmLRCd6eB4oGU?=
 =?us-ascii?Q?JUgPpegX5YWFs1zR146FkT320dZJaegpBMupFZahFHScKusSjHSkYwzej3P/?=
 =?us-ascii?Q?vuQ5NNsOzyfMFm5bzSOEXqsLfhl93sTtg2PqBjbsolhnvKdUWuWo4xWx2BE9?=
 =?us-ascii?Q?Aw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BDD9F48D6241B748939595E765B180E9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?PPqE4MTgFtYzbHMZSChjZkMGvjGkM5S3YJrAU9jXcVUdnlDQ1LB5ALdAmwSf?=
 =?us-ascii?Q?cOLyvXt/N/eUB8dam1KYoOO3myv/pdrNtmhP+C6xlRXSBAkzKjZ6AHxqnrjn?=
 =?us-ascii?Q?DPe+nStq+Or0S5ybFebl8sMQvPRSqTNaOVqiyjJrpmx7dfBqOnuj83ANErJF?=
 =?us-ascii?Q?Fs2kwHIwl3+qrKQmohWEs6OyB3F5QVau6nMY6uPLPECbjwsiQZpo2fSPxbW3?=
 =?us-ascii?Q?84zfiWkrTFcSrWsSbBBCrYkgrD4le95f/TBwjqOawHZm5NZLESA1xQTzJ3Un?=
 =?us-ascii?Q?fS1yu7z5ovgrSJ/gIXbt7NqDpbPnogpSeGyhklWNaoVw0O4tzxuCGVSB4dSz?=
 =?us-ascii?Q?uSysliO52BmBRP2OM/n/SZ3AQ/apwzRBL+wlGJtYSfRudunUtZ46zgqw8tGg?=
 =?us-ascii?Q?d2AXq980JCdyAv/K+3oBzjYzCBcOuUiD4ZX464SY2O774H5Yx1Za29U8/kWW?=
 =?us-ascii?Q?v4KOEeKn0HKyii1DB/5yLmHeRfybudaT+M7tJ+mZ0Y47dqUgqxF8ogW/FSG9?=
 =?us-ascii?Q?jZye/ofUg4qfyW6e8NwLozm7woxwK2wDx8QbIouh9gM5Gch8zPe6sUIOeqaN?=
 =?us-ascii?Q?7ISula8myGPxx8OX1/RAQDdV11l7duX0AWs19DYnkhYjFCMnB4NJVtYO323+?=
 =?us-ascii?Q?doS9+qPsIrXzcs/hdaKW5WmMjZuB49YOgvN/yvlPw/QQBveV5EoBFgjejo6s?=
 =?us-ascii?Q?/aoScDjl2ktzvRXUjDoqngSHoG9m0ihLqU5I22q/5TmIlStAwKMN6PKzDFLB?=
 =?us-ascii?Q?8HYE2QdiTieRLiGglceLJxVbLJ5BqL5+VOoWE33CBV9ZXWi2+rE0cw+8oS8/?=
 =?us-ascii?Q?BHMr82bwqBQTwvaK4karOL1TC6iSHBtcUSTmE1kJvcdoxbuwB5hLxxlw4eVX?=
 =?us-ascii?Q?LN7oE6b+S+elY1Ipy0+mjnQtdzlEwWRfJD7ottm4Zg+qhlaURd6r9qrhMstC?=
 =?us-ascii?Q?JoK6+oDNhLRGZffpK/LXZZhwGaG2uwieuLYwzgUrcGs=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54389ab7-a9ab-4491-03ec-08dbb607b845
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 16:20:47.5546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fw9KG8foLl35mUjodWPbwfE7I6huNTWNkIZWmzmpBVF5Cti1uTAjSJXISrUaZt2BO67nrvSF23SiyV0ScBtKLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB8653
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 15, 2023 at 08:26:58PM +0800, David Gow wrote:
> In any case, the bisect is done:
>=20
> 624885209f31eb9985bf51abe204ecbffe2fdeea is the first bad commit
> commit 624885209f31eb9985bf51abe204ecbffe2fdeea
> Author: Damien Le Moal <dlemoal@kernel.org>
> Date:   Thu May 11 03:13:41 2023 +0200
>=20
>     scsi: core: Detect support for command duration limits
>=20
>     Introduce the function scsi_cdl_check() to detect if a device support=
s
>     command duration limits (CDL). Support for the READ 16, WRITE 16, REA=
D
> 32
>     and WRITE 32 commands are checked using the function
> scsi_report_opcode()
>     to probe the rwcdlp and cdlp bits as they indicate the mode page
> defining
>     the command duration limits descriptors that apply to the command bei=
ng
>     tested.
>=20
>     If any of these commands support CDL, the field cdl_supported of stru=
ct
>     scsi_device is set to 1 to indicate that the device supports CDL.
>=20
>     Support for CDL for a device is advertizes through sysfs using the ne=
w
>     cdl_supported device attribute. This attribute value is 1 for a devic=
e
>     supporting CDL and 0 otherwise.
>=20
>     Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>     Reviewed-by: Hannes Reinecke <hare@suse.de>
>     Co-developed-by: Niklas Cassel <niklas.cassel@wdc.com>
>     Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
>     Link: https://lore.kernel.org/r/20230511011356.227789-9-nks@flawful.o=
rg
>     Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
>=20
>  Documentation/ABI/testing/sysfs-block-device |  9 ++++
>  drivers/scsi/scsi.c                          | 81
> ++++++++++++++++++++++++++++
>  drivers/scsi/scsi_scan.c                     |  3 ++
>  drivers/scsi/scsi_sysfs.c                    |  2 +
>  include/scsi/scsi_device.h                   |  3 ++
>  5 files changed, 98 insertions(+)
>=20
>=20
> This seems to match what was found on the Arch Linux forums, too:
> https://bbs.archlinux.org/viewtopic.php?id=3D288723&p=3D3
>=20
> I haven't tried it yet, but according to that forum thread, removing the
> calls to scsi_cdl_check() seems to resolve the issue. This is all well
> beyond my SCSI knowledge, but maybe a quirk to disable these CDL checks f=
or
> these older marvell controllers is required? Though it seems odd that the
> device would be rescanned and/or scsi_add_lun called multiple times a sec=
ond
> -- is that normal?
>=20
> In any case, this seems to be the cause.

Hello David,

Thank you very much for your effort of bisecting this.

Could you please try this patch and see if it improves things for you:
https://lore.kernel.org/linux-scsi/20230915022034.678121-1-dlemoal@kernel.o=
rg/


Kind regards,
Niklas=
