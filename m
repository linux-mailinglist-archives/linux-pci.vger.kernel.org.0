Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4655B1F7D
	for <lists+linux-pci@lfdr.de>; Thu,  8 Sep 2022 15:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiIHNoL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Sep 2022 09:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiIHNoK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Sep 2022 09:44:10 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37934ED984
        for <linux-pci@vger.kernel.org>; Thu,  8 Sep 2022 06:44:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ycx0mX09tMPwTji4DRjYxOU/gYtpDsMno5T/vG5eP0Q6Qda6dF5xeX1l3cWMuBEd/Z/gkM+Sz8Pqcbi/g4Jo8SjGCAEDD6732m/69F2WcqpEgdOk+x+dkI3PqfTuc410y7vcN8ZFJOnt/H5SGy05npCEAGee2xxUDKt9tNhFwNV47XliCGqavbwQ/LiS7HSru5DX8T7Zx968+buvd9p93IE1jI2z4bGIX2JJaWJSG+1yD7OofWW0T+RuoEw3SyZ9ctw2Ov4fBO6UrqOhpOS0liocDm3Uob4U7fe96o8BJYUty52k3xlZFQ6Z5XcYLHXviDkwdgDIDO2Zfir3RPwamQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4XonOBmgD21JE5IYP0HrHf109/l1oRMqnaKkAXGv0k=;
 b=ZtjAUa9C7ldDdrOQBEY6UM1EIPonjh9Ow/f53XLi5hpAYjQYQsFsqzAYvMGFBz4hnrOUxYLdZCKpzlzPt2kjnNlWAhKMrTWlfNJpAdVD3NHA/Jpv9ih9jNKAkDker5jj5puBMwnSGGMbuakVzCpfSQusMCpOlZGqyyQ6aLuM8u/j1/74YQd5joJKPOj0vBAhKZrHK8GTHBi3mkZUf2WRvmBHAq3YQGgQXklku0I8/ka3FiDnvtJh7D+A4pS18sFNTL7PXKjSgdmM8jp0nOAci23o9pIET15lOM5OQxldrde3UAnPvhsEqKOg7FCBMPzRTTXAm+hVaFIYdkvCeSxSKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4XonOBmgD21JE5IYP0HrHf109/l1oRMqnaKkAXGv0k=;
 b=BFb9lICRr+gQeNSCUo9eKKqdxPvFOeTF6NOaDefcGFLOnA+lKc45YgJLkSK5ljDiAKlpPFe6VHuPpB8gxTrrigcZhJ/AUBHzt24UhhCtyigARHXkH3D5Yh9+XfJTCHyzkg8KcznUDJtPmFSRN2pN+WuJJpNtyQj8FgI/dDBvFDI=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SA0PR12MB4493.namprd12.prod.outlook.com (2603:10b6:806:72::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Thu, 8 Sep
 2022 13:44:07 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2428:2f57:b85c:757f]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::2428:2f57:b85c:757f%9]) with mapi id 15.20.5612.019; Thu, 8 Sep 2022
 13:44:07 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>, Daniel Gomez <daniel@qtec.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: PCI/MSI: kernel NULL pointer dereference
Thread-Topic: PCI/MSI: kernel NULL pointer dereference
Thread-Index: AQHYw3xWk8KpGJtYSkSYx/7EtVH6Jq3VinZA
Date:   Thu, 8 Sep 2022 13:44:06 +0000
Message-ID: <BL1PR12MB51444FEAE2566F31E4BA591BF7409@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <CAH1Ww+TS2sdQc4PewxYjGNp94=uGWjh0Z13cjLbVhSWQMOij0w@mail.gmail.com>
 <20220908121248.GA190779@bhelgaas>
In-Reply-To: <20220908121248.GA190779@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-09-08T13:43:36Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=43bcd5d7-4e0f-4100-af80-be02c9ffe29a;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-09-08T13:44:04Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: c64d4a40-218a-4631-9ecc-700a40f783dc
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SA0PR12MB4493:EE_
x-ms-office365-filtering-correlation-id: 77665091-4126-491a-a3f4-08da91a0336b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wLLfwWTTBxmePe/84vWYZ9I0dmHXq2lHeTpWL+msUtjhPCihJcO+loP8toYkeDwvC2SZ6MK/bwB0DscWYhpa/TI/H0vu+pkUTQOfLnLk+q1WjVt7UTTvn3Uf2VnwMEVg86BGSRNdz8jrlKf+ijEPYND/yyqe3rq7XNcd0hX5hJgZTuWSWYN20IHUkusRqGQf6HGHjX/tlAfKY1I5857iFsRlxgHvYk+WUd0tlC5AjzCYNhSiTviF0fdiJfi+/6Ejia/5NJyr8yjOEeFz3JnOtnp1P6KBnANSnNoAcOkpiGVKYmgQbSSq10Kl4vdaKa7l/HxD3Yf+PNE2nni0bKNCPDPHjBuq2LUsY6OC7h0+LocEKdTFeASBMbXVBdw5BLw4A9UY5Ndl5j+vsXseXZXUoThgXViclbjkR9VJDDZ8mUuiRvM7OaOH8vATm1/upzjD2IAR+5gooDJ2y7FgYjyFvsLni5t0Da83ewxt6gRhDCuw6VPfDic2Js3QnVuB/PBNuInXdnZ3v+RDj1anzK8wyRUmuv4UWr3wcQjp7PCI2v8Dli5lqXNh7ggHpB7wO5H8XKE5uUOoVnSIMtEbKEmo6/gwCFC8okdcw8UA0+ANvQbQcBpLKEt1aLmLKYnqYHRI0NX/LQ763vgm207K9Tks9P8PImQ8m9c2F0+DJC+1y4UJmZa400hoPwoDpZERgs4ni3oyE2yydfO2VKK/P/HeCWn12Kx+kvZslDOP7jYF49cJUbq8H/g8Xe0ffBiNOJBtflCEI6oX5KjBF/sexNTV3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(9686003)(26005)(38070700005)(7696005)(478600001)(53546011)(6506007)(86362001)(45080400002)(71200400001)(41300700001)(186003)(83380400001)(38100700002)(122000001)(55016003)(64756008)(66556008)(8936002)(66476007)(8676002)(66946007)(4326008)(66446008)(52536014)(76116006)(5660300002)(2906002)(33656002)(4001150100001)(110136005)(54906003)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vn/qCsL5Ndo54Q9XfPuTfEk5bNFQPmhh9lpA6LDvMYlRfFvN97FWY37nsH2B?=
 =?us-ascii?Q?k3roiI1m/5qiApwJI+ZfVsyWXqH/f7F7Jhl4tf7ut8oNdgE++V3gj8SAaayB?=
 =?us-ascii?Q?sbSQKJbjbv+pn8aDbods7wkrQF8amqNO4eF6JKeIw6VxGdRk+bLEedZ1Axgn?=
 =?us-ascii?Q?y+eSnZRA2VZuTgaD3mTKjOuKYPkHv0vNCKGU94bXUl06HwWEvyq2eTQ0B/Xr?=
 =?us-ascii?Q?5kOz+ZoNp5kEXmTP6FbZsNNYHsasentFCq8iooT2WhWvYvoHf7MDasrDZvey?=
 =?us-ascii?Q?vhBVJMIzmpNrA+eOaosHAMqz63sEivd+XV9EepYAOvuwxEpP/Ob/ZnMGXzXC?=
 =?us-ascii?Q?yUjSU74aaDQ7e6sIAZAXEKzrAhOfHn4q5LygOZLEDm7ihLCMm4ghwMTKZYnA?=
 =?us-ascii?Q?jonmHpNsfBnlj1O3i3R1Yy69tBSnpT4ijVT8xznwpbTdOpaYSuQlChdtVd+r?=
 =?us-ascii?Q?5QHWyIpXpCQgEsuDWYdkK6O7ld3zrrhHi8sz00xWgPHMNLMvgA1D57RXoL0M?=
 =?us-ascii?Q?Ix+4MMBlqIQIgoYyQqJLwUlIYDcLfgB2KYoGOtikY4aWiFG5QkWTGJ3Hvb8o?=
 =?us-ascii?Q?KU0SR8clawMZtq3U3vnuFiyaUoFkdSZ9HZwDMJwLe7GbR3vOucdDeB8l55Mc?=
 =?us-ascii?Q?kyULFBOv+9G0l6hoqqu/AVFW7n2d11x9BrHIICYniN0fzpARjpX976ECIJUS?=
 =?us-ascii?Q?16w5n2csEGt0JrCRJQagMMinHIC5VkSwuG6tRKzeweXWvYiyYws8iuOBO2T0?=
 =?us-ascii?Q?7h61QxGaayynKaam8IsG166q+0+AAgUCiM3+KGbst9rFxNEnNoxfPpHd2d3T?=
 =?us-ascii?Q?4l78vKyrreEFLttEt6rW164QTEK/nlrhiuPxhBubos7o8f6RYciCHjYNohdy?=
 =?us-ascii?Q?im9Mtdo3smGW57rBnez4cZTgVy+krE9GU+swxI95DUEWNOzxk7LV7jirermK?=
 =?us-ascii?Q?2DfP6yfKv6cZVc474qiRM2gXEfUK/h3wpa0eO3l55c+Yexi2KZsQ7UfDVDsC?=
 =?us-ascii?Q?/P5IhOHLDwlsMJ51B6qazrdiU7fh+ADcAcZU9tIoqOYkzmlJUJEwNjwDT9n8?=
 =?us-ascii?Q?sYLDikmu7jyaFRzpto8of85F/XptxHnaRoypVwKngasPp//PGI69pl+JC4mW?=
 =?us-ascii?Q?7GWjzNtszgPPJZ3BEdcpgDIUac8ppipWbv3F1PZJKeuN2GYeBYOTP+CHaV/3?=
 =?us-ascii?Q?qI/guPSPCtsdfkjNQZ2JOaChvn83EhIGw3F/0zaBSQlqDRy6VGeVb66RcZlq?=
 =?us-ascii?Q?YreUb9oetUm6EWPOVLDP5KpJxgp+Ath8fXSBag5AnD8mv2EZhOeo5MyHCGYo?=
 =?us-ascii?Q?A1SU3N0tRKlsL1CymnpMW6s9JlIera2gss8vcBt6tX79xmPnvYEYy8hiO0hV?=
 =?us-ascii?Q?XZ+HhyREY8BTcm8zVVhoDh2jbQW2VX6dnKz7/McVI1h0YPJri0oK1xtt0vaF?=
 =?us-ascii?Q?fGCirBxDXV1jPV23+3UuVvqI9su8pQkTDLfBZ6CgVsr7UYhq1NwZkdIPlBdP?=
 =?us-ascii?Q?kINBiNwBe0mid9FcggKzRLNaMxpDLnnTQAYdUyw+GPR9a0mrbwhhdWs2kLZh?=
 =?us-ascii?Q?2gQkaKBGzUJ5vRjrBKw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77665091-4126-491a-a3f4-08da91a0336b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 13:44:06.9207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RUSli4IzbwrT3ZRm1lHALW7WhiPJoFt+D8d57T84D3gfN7WhC3vEOZFRA1G3I/8sReKL+NHuoNRvSgTdxCVZ0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4493
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[Public]

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Thursday, September 8, 2022 8:13 AM
> To: Daniel Gomez <daniel@qtec.com>
> Cc: linux-pci@vger.kernel.org; Thomas Gleixner <tglx@linutronix.de>;
> Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>
> Subject: Re: PCI/MSI: kernel NULL pointer dereference
>=20
> On Thu, Sep 08, 2022 at 12:41:00PM +0200, Daniel Gomez wrote:
> > Hi,
> >
> > I have the following error whenever I remove the fglrx module from the
> > latest 6.0-rc4.
>=20
> You bisected to 93296cd1325d; I don't see a commit with a "Fixes:"
> that references that.  If you can reproduce this with an in-tree driver, =
we can
> certainly fix it, but it's harder for an out-of-tree driver.
>=20
> I cc'd some AMD graphics folks in case they have a pointer for where to g=
et
> fglrx support.

I can ask around, but I don't think we've actively worked on fglrx since we=
 switched to the open source amdgpu driver 5-6 years ago.  What hardware is=
 this?

Alex

>=20
> > Logs:
> > /mnt/raid0/krops/workspace/sources/fglrx-
> module/module/firegl_public.c
> > :1674
> > KCL_SetPageCache_Array
> > <6>[fglrx] IRQ 37 Disabled
> > BUG: kernel NULL pointer dereference, address: 0000000000000010
> > #PF: supervisor write access in kernel mode
> > #PF: error_code(0x0002) - not-present page PGD 0 P4D 0
> > Oops: 0002 [#1] SMP NOPTI
> > CPU: 1 PID: 254 Comm: rmmod Tainted: G        W  O
> > 6.0.0-rc4-qtec-standard #2
> > Hardware name: QTechnology QT5022/QT5022, BIOS PM_2.1.0.309 X64
> > 09/27/2013
> > RIP: 0010:mutex_lock+0x2a/0x40
> > Code: 0f 1f 44 00 00 53 be 1b 01 00 00 48 89 fb 48 c7 c7 08 81 3d 82
> > e8 46 2c 52  ff e8 01 d7 ff ff 31 c0 65 48 8b 14 25 00 ad 01 00 <f0>
> > 48 0f b1 13 74 06 48 89  df 5b eb b9 5b c3 0f 1f 80 00 00 00 00
> > RSP: 0018:ffffc90000b07dd8 EFLAGS: 00010246
> > RAX: 0000000000000000 RBX: 0000000000000010 RCX: 0000000000000000
> > RDX: ffff888116aabb00 RSI: 000000000000011b RDI: ffffffff823d8108
> > RBP: ffff8881148d20d0 R08: 0000000000000000 R09: ffffffffa053537b
> > R10: ffff888149365cc0 R11: ffffea00052c5048 R12: 0000000000000000
> > R13: ffff88813877c000 R14: 0000000000000000 R15: 0000000000000000
> > FS:  00007f6f90b3cb80(0000) GS:ffff88815b300000(0000)
> > knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000000000010 CR3: 000000011e4c8000 CR4: 00000000000006e0 Call
> > Trace:
> >  <TASK>
> >  pci_disable_msi+0x34/0xe0
> >  irqmgr_wrap_shutdown+0x165/0x190 [fglrx]  ?
> > firegl_takedown+0x841/0x950 [fglrx]  ? kobject_put+0xa6/0x220  ?
> > cleanup_device+0x299/0x2a0 [fglrx]  ? pci_unregister_driver+0x42/0xa0
> > ? firegl_cleanup_device_heads+0x65/0xa0 [fglrx]  ?
> > firegl_cleanup_module+0x84/0x11c [fglrx]  ?
> > __x64_sys_delete_module+0x11b/0x210
> >  ? get_vtime_delta+0xe/0x40
> >  ? vtime_user_exit+0x1c/0x60
> >  ? __ct_user_exit+0x68/0xb0
> >  ? do_syscall_64+0x3c/0x80
> >  ? entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >  </TASK>
> > Modules linked in: amdgpu fglrx(O-) ath9k ath9k_common mfd_core
> > gpu_sched drm_buddy drm_ttm_helper ath9k_hw ttm
> drm_display_helper
> > drm_kms_helper ath sp5100_tco syscopyarea sysfillrect sysimgblt
> > fb_sys_fops video drm backlight
> > ipv6
> > CR2: 0000000000000010
> > ---[ end trace 0000000000000000 ]---
> > RIP: 0010:mutex_lock+0x2a/0x40
> > Code: 0f 1f 44 00 00 53 be 1b 01 00 00 48 89 fb 48 c7 c7 08 81 3d 82
> > e8 46 2c 52  ff e8 01 d7 ff ff 31 c0 65 48 8b 14 25 00 ad 01 00 <f0>
> > 48 0f b1 13 74 06 48 89  df 5b eb b9 5b c3 0f 1f 80 00 00 00 00
> > RSP: 0018:ffffc90000b07dd8 EFLAGS: 00010246
> > RAX: 0000000000000000 RBX: 0000000000000010 RCX: 0000000000000000
> > RDX: ffff888116aabb00 RSI: 000000000000011b RDI: ffffffff823d8108
> > RBP: ffff8881148d20d0 R08: 0000000000000000 R09: ffffffffa053537b
> > R10: ffff888149365cc0 R11: ffffea00052c5048 R12: 0000000000000000
> > R13: ffff88813877c000 R14: 0000000000000000 R15: 0000000000000000
> > FS:  00007f6f90b3cb80(0000) GS:ffff88815b300000(0000)
> > knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000000000010 CR3: 000000011e4c8000 CR4: 00000000000006e0
> >
> > Steps:
> > insmod fglrx.ko
> > clinfo
> > MatrixMultiplication
> > rmmod fglrx.ko
> >
> > I know this is an out of tree driver from AMD but we still need that
> > driver for some products because of the OpenCL stack support on it.
> >
> > Note: The open-source upstream radeon does not support OpenCL.
> >
> > So, doing git-bisect I found the issue is provoked by this commit [1].
> > Unfortunately, I cannot revert it for testing as if I do it the system
> > hangs on boot because of this other commit [2].
> >
> > I understand, the driver might have some issues but shouldn't the
> > kernel prevent this crash at pci_disable_msi function? Do we have a
> > mutex problem here provoked by the fglrx driver?
> > Does anyone have any suggestions on how we can/should proceed with
> this?
> >
> > Thanks in advance,
> > Daniel
> >
> > [1] Commit 93296cd1325d1d9afede60202d8833011c9001f2:
> > 93296cd1325d 2021-12-15 PCI/MSI: Allocate MSI device data on first use
> > [2] Commit ffd84485e6beb9cad3e5a133d88201b995298c33:
> > ffd84485e6be 2021-12-10 PCI/MSI: Let the irq code handle sysfs groups
