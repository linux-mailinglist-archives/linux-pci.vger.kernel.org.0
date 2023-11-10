Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAB27E802C
	for <lists+linux-pci@lfdr.de>; Fri, 10 Nov 2023 19:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjKJSHX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Nov 2023 13:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344286AbjKJSFt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Nov 2023 13:05:49 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E4F357B3;
        Fri, 10 Nov 2023 05:00:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExvyxldYkfjCP+GQiUX5t9EO4hfYan1uTZnwbmQIQu/G1vq0VNQbvuUQTTnD5a2PRqi2AgfGW661TyPkczekp4Xb5UDwuoQuBy4J2wga5v9dI3jQr+y+BXU3Ib9EgzwoonAjCtlwpO41gx2dWsH9cIqV9kVIOsRLxnDFKqlFiEXz9mvcFBOL/23rzLYFZom5px1TVmnTEHDsxOql6u2Vc1BSd0HC2HNlIBsbIRcCywi8K2g3z7S1WWe8vARNK3Xm5tsRb+3+4AmdNcpTpOTnSZxbsdx+k9H5WMrvRZpbYjzESyp7n0EHlsEZlNz+HSrK7W8XNqodvdDnThmUHyrosw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8+bS/TuH9zHZbhwD/Zj1kR+bxppk4KNxb5mVMEw1OQ=;
 b=A6FrcvOREEGkqbSTeVDdjx+MRVtnTb9mp3YTEgcZ26gV+z3nC9PxZ/yioZPoKEip/R0KQVuTODQxvHPFBIQVfghWp7sIfTcuMZlUfwSrNJEan5UM94yliqnl0baL32Bku1I8Qr3l6b06LlDBh+azdkIC6b12xEAum0tgHJM32aDTYDLtzNWuPj8XEnmXzg0izwHz9cATasUnPgXxngGqDZ104+p33UCesjn+Ue4ZfvHDNCjPn2owfR4n3GMfnw5jdEP1KB7bEOfPOVxDG+uWmxElnK28yFJlBYwizAl0/3BFVTP2MX+OLj9UPhnPWqTE87uFUyssZFuxuX2KLRYaaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8+bS/TuH9zHZbhwD/Zj1kR+bxppk4KNxb5mVMEw1OQ=;
 b=jsqttlvm+0IkBakYhk0NFJvuwbYe6r8AU9urJ/XNYAj/5G4PephzB+c8FxXq8+OU9O3CN/T4PBHOFrGOiyoPaBmkj24pvLn97DrX0vvpLjCbfxtpHdeFVcvyYromBmDu+V7JugfOZX/uFoXk3n+Zkgx0S6FoKlEpYiv2raj9BIc2rvMQL43j8oh5PkSJ49mhCl8wlSPs6p6zs6O1qRlvhEjc2O55scuwYoMf5MCVmpt8WKscVZuEDtc8uCfhg3ojXLGuYtURK/oYfBeJEgw3kvqwg2L0tjNRU2Tc2xd0F/o+QJBzQ+ZHzyv7fyq16fQYaPhyYTJbCg6qRBVALvPRLg==
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by PH8PR12MB6938.namprd12.prod.outlook.com (2603:10b6:510:1bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Fri, 10 Nov
 2023 13:00:39 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::eda4:8c67:893f:3d13]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::eda4:8c67:893f:3d13%5]) with mapi id 15.20.6954.027; Fri, 10 Nov 2023
 13:00:39 +0000
From:   Vidya Sagar <vidyas@nvidia.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>
CC:     Vikram Sethi <vsethi@nvidia.com>,
        Krishna Thota <kthota@nvidia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Race b/w pciehp and FirmwareFirst DPC->EDR flow - Reg
Thread-Topic: Race b/w pciehp and FirmwareFirst DPC->EDR flow - Reg
Thread-Index: AQHaE5iCQ4MkYz8x9E+tul5MMdhomg==
Date:   Fri, 10 Nov 2023 13:00:39 +0000
Message-ID: <BN8PR12MB290002441CA3C24D1FA742D2B8AEA@BN8PR12MB2900.namprd12.prod.outlook.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR12MB2900:EE_|PH8PR12MB6938:EE_
x-ms-office365-filtering-correlation-id: aeaa4ca7-b899-48b7-1232-08dbe1ed0a3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BvTaSe+NebuSnFjAQvzgFZIjwgWaXJ2UOsFSrfmmnQi9zbmFwSSKsO8BqnNil1XB1BftRTO3tdNaw79K/gMNHTbTOBaODsNbZpJWAbVDjle0smRTtYAnEXzi28U8pkkoXvZZInF7EE6nVE8parBVVmMc3Hgxw0TfvGSsTJUFqljq+170PFyNFKKQrPv6MZ7Tca/WflWz6ZNJQhxeWO2fvTD80v1RCqsAgQzBmDUDEhoAla6LIVhhLfEYvighuNP8muaqT3TtuQKuAhlRYXxfDOb3VCx+l7j5u+35AfMBKLAM54T350j1/vwvQQXEwydaC4saEfS3PNSkPpueIKo9Ajfrz/45O8CkgYnAq1htkJ7NLwbnQSra4vFC5x10DONZT9BXeI0NuIA57Qd9TGZDk2cYnoc82E2rWHmbVUrPNYVRMM+P/wKO/AAVkv48nMk54FSiixtUfXmoHdxXjGiHnHVak8SJmjplQD9GejFMyPaboaAvGoLHRW9eCe54JexS3i/EsmBCqWfUd0ixz0rNQ57h/sgqvjwiH/b3DkFneVUwOqi/cwUmQUh9bxf4DC7hUHjfWky8s++gegcPTiK0Dujaor1bZiC/pe5E+IxdpwWiJa/x1vP54VW/pXeh7zWF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(376002)(396003)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(7696005)(26005)(83380400001)(71200400001)(38100700002)(8676002)(2906002)(5660300002)(8936002)(4326008)(316002)(41300700001)(52536014)(66946007)(76116006)(478600001)(66446008)(64756008)(54906003)(91956017)(66556008)(66476007)(6506007)(9686003)(86362001)(110136005)(33656002)(122000001)(38070700009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GbTdbL83jfp21Pv4LCHXmaMZ5ojaquAAO7iJ0V0WUSIb65ugquIswvMqma?=
 =?iso-8859-1?Q?8RYUk4Ued8Fcq9f6lDXfmh5Zo3UpvedxuK/koMzCfIUaQUzDpVfF9+1uvM?=
 =?iso-8859-1?Q?eZea8b/FR1TPGRUxiLPIH67utRoeLpeo63HFgEito22ipdnclyDV8X1cF7?=
 =?iso-8859-1?Q?0OjZfUc/Naqt0ngbuJgv6BphCsx5rZc4gEF0kitK/QEgcNPLmNlvBZX/g9?=
 =?iso-8859-1?Q?HOXSEjm3mwf0ryh9p/kA6WyAFVsxMfx1SCCXIB3iakrMxTaBPLzBS5KayK?=
 =?iso-8859-1?Q?+N3Eixb/zOPuJHKCKSPesjeoG8j7K6yyFAWs0bYbUsXfGfoHy1gWxmMNIS?=
 =?iso-8859-1?Q?HukrkbqfYTNbFU5CYe42fm5zK9qdOyMXgSrKjDvIZupw/u2W6HHwcOyCFj?=
 =?iso-8859-1?Q?h5qpxw6cNORqrgJX680LXU4PsuMiXB5qZ4uqbNmDrxjJDANNm172vBPlF6?=
 =?iso-8859-1?Q?/D6NXi57o8UszJ6Gi+llKDbadrgPhfDIoJvRrlI6qhoKiIymM6SqsLowbv?=
 =?iso-8859-1?Q?ort30XZ0uHitn6636xeyGI8rHn89HPJk4/0aq6FJ+8ZKBfIQTNbomm9tW7?=
 =?iso-8859-1?Q?HGjmR3KHzD8orfwdmpO3pJH0t4qrFDqU7LMw62Pjd4/XWHGYPv/00ruswC?=
 =?iso-8859-1?Q?2zilcjp5yOd0GC1aWrgmdSOFgPCaCHLusw7bNPXuRHCAO/jfAE9SbLQfvw?=
 =?iso-8859-1?Q?wyTQWjE1HOHcA6dLR7vrMLsAc4gUMGZ7SiTHgiE20D3RhowMIHowDW2VJe?=
 =?iso-8859-1?Q?SAe+Jq8idbKwmm5KNo3LXPI9ZL26Nl8IjDSgADaOloI4A0Eum8Zg9YGawV?=
 =?iso-8859-1?Q?brPNoDDSSwgitkPAmqOol+duAZjWWuV07i+FPdI2cgZQkD89apfHOE87p4?=
 =?iso-8859-1?Q?ilWIjPYMCP42uMXEJjwFDqOYFaQn9OKC/TVTK5DJh3IjyYuDZc1ztCk4On?=
 =?iso-8859-1?Q?nzu5RwUuR/RE9Q7m8VtZJxBKC42OEi9dGlMuYH3b1L2MaJ70sMDjLht/k9?=
 =?iso-8859-1?Q?j6IVDx8mIg7B9eHSaGNkM9zyQnCzvquTCk5xhkGWrk19JypvrF0SiAhnCt?=
 =?iso-8859-1?Q?fM0t//OagtpdUb60DKgV91L9CwHB7Yz/07yxE2A0m8aknIrKG13VFG0o7W?=
 =?iso-8859-1?Q?DWPsr+I8p3dIlNUkdNZx0QAqEEAlHCniL3iBY1i6ieWK/JOuYVgKMAAlpp?=
 =?iso-8859-1?Q?fQoFuPHpslftV3Ma9jRksQeNSqGKWtxa3vfBCqWeVqfheDJYi55ALRCDNN?=
 =?iso-8859-1?Q?MU1CLH2y/9AfHsMOO+b1WCItk6JI2g3qlxcyK0HU3f00uoXHWDEOCtoq62?=
 =?iso-8859-1?Q?wb/uA4gkIbjfFVBNiqzlWW5W7g1QtZ1pg/lPM506MWRuZn04HwCYLY4usM?=
 =?iso-8859-1?Q?QSoYOcq4vuuL91wMeb13Gbgpyx7e78ZvolMzDxKigWbh0blmIHDAe2GcLw?=
 =?iso-8859-1?Q?s9ygLqFOE51hkNDR0+F8VzZ7/tj8qF4lQ/d8nObJ2kdWfZVXWRdjKVgj/c?=
 =?iso-8859-1?Q?tBWReG/nGpC1M8ER13zHqnWvA3xld4misVnWtA21Hm3qdKV6KIpq84x0fQ?=
 =?iso-8859-1?Q?cVdiAWsEbOga99wBvNG0KWh9ZHkMYQCWtb/CE1yOBW/pDnozBtKmm9M7Xs?=
 =?iso-8859-1?Q?bekyoFFzhEPvA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeaa4ca7-b899-48b7-1232-08dbe1ed0a3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 13:00:39.7601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pCynUBJzySy5cWF480FhS5isl6BSiIGzCK6RFEv15ZUyJwS6XwS55blyL91wbyBql5TBDImTZx4ewEOkj6ZGMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6938
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi folks,=0A=
Here are the platform details.=0A=
- System with a Firmware First approach for both AER and DPC=0A=
- CPERs are sent to the OS for the AER events=0A=
- DPC is notified to the OS through EDR mechanism=0A=
- System doesn't have support for in-band PD and supports only OOB PD where=
 writing to a private register would set the PD state=0A=
- System has this design where PD state gets cleared whenever there is a li=
nk down (without even writing to the private register)=0A=
=0A=
In this system, if the root port has to experience a DPC because of any rig=
ht reasons (say SW trigger of DPC for time being), I'm observing the follow=
ing flow which is causing a race.=0A=
1. Since DPC brings the link down, there is a DLLSC and an MSI is sent to t=
he OS hence PCIe HP ISR is invoked.=0A=
2. ISR then takes stock of the Slot_Status register to see what all events =
caused the MSI generation.=0A=
3. It sees both DLLSC and PDC bits getting set.=0A=
4. PDC is set because of the aforementioned hardware design where for every=
 link down, PD state gets cleared and since this is considered as a change =
in the PD state, PDC also gets set.=0A=
5. PCIe HP ISR flow transitions to the PCIe HP IST (interrupt thread/bottom=
 half) and waits for the DPC_EDR to complete (because DLLSC is one of the e=
vents)=0A=
6. Parallel to the PCIe HP ISR/IST, DPC interrupt is raised to the firmware=
 and that would then send an EDR event to the OS. Firmware also sets the PD=
 state to '1' before that, as the endpoint device is still available.=0A=
7. Firmware programming of the private register to set the PD state raises =
second interrupt and PCIe HP ISR takes stock of the events and this time it=
 is only the PDC and not DLLSC. ISR sends a wake to the IST, but since ther=
e is an IST in progress already, nothing much happens at this point.=0A=
8. Once the DPC is completed and link comes back up again, DPC framework as=
ks the endpoint drivers to handle it by calling the 'pci_error_handlers' ca=
llabacks registered by the endpoint device drivers.=0A=
9. The PCIe HP IST (of the very first MSI) resumes after receiving the comp=
letion from the DPC framework saying that DPC recovery is successful.=0A=
10. Since PDC (Presence Detect Change) bit is also set for the first interr=
upt, IST attempts to remove the devices (as part of pciehp_handle_presence_=
or_link_change())=0A=
=0A=
At this point, there is a race between the device driver that is trying to =
work with the device (through pci_error_handlers callback) and the IST that=
 is trying to remove the device.=0A=
To be fair to pciehp_handle_presence_or_link_change(), after removing the d=
evices, it checks for the link-up/PD being '1' and scans the devices again =
if the device is still available. But unfortunately, IST is deadlocked (wit=
h the device driver) while removing the devices itself and won't go to the =
next step.=0A=
=0A=
The rationale given in the form of a comment in pciehp_handle_presence_or_l=
ink_change() for removing the devices first (without checking PD/link-up) a=
nd adding them back after checking link-up/PD is that, since there is a cha=
nge in PD, the new link-up need not be with the same old device rather it c=
ould be with a different device. So, it justifies in removing the existing =
devices and then scanning for new ones. But this is causing deadlock with t=
he already initiated DPC recovery process.=0A=
=0A=
I see two ways to avoid the deadlock in this scenario.=0A=
1. When PCIe HP IST is looking at both DLLSC and PDC, why should DPC->EDR f=
low look at only DLLSC and not DPC? If DPC->EDR flow checks DPC also (along=
 with DLL) and declares that the DPC recovery can't happen (as there could =
be a change of device) hence returning DPC recovery failure, then, the devi=
ce driver's pci_error_handlers callbacks won't be called and there won't be=
 any deadlock.=0A=
2. Check for the possibility of a common lock so that PCIe HP IST and devic=
e driver's pci_error_handlers callbacks don't race.=0A=
=0A=
Let me know your comments on this.=0A=
=0A=
Thanks,=0A=
Vidya Sagar=
