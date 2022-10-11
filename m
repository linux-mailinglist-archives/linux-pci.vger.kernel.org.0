Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686E65FB15A
	for <lists+linux-pci@lfdr.de>; Tue, 11 Oct 2022 13:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiJKLTX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Oct 2022 07:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiJKLTW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Oct 2022 07:19:22 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2073.outbound.protection.outlook.com [40.107.102.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BCE8E0FE;
        Tue, 11 Oct 2022 04:19:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nihj+jSRpjgApz6mBeZlAMBzG6yu2gxd263X0fsKmbaKCTA7d5FKot2pkkOG/NcRGlB5WSzuim/1+AqmWwgfz7Z1K6hIMvn7zkyxEGxHOn+WcWiudsX3FWcXlLUvZme49Ia7tQ6qnE/XaWDBhI3pxhwA4PErXLcxP+3wvEYhv1p0SLGF+ob1gXRWtfeabOOilx8L1zCmfjGWi7+hCiZJw4ifpF4RPPrVvbPcMXVjqR3FqU6yDnvSpPYwGFAjuIXwrSiiJWv2p6xMp+irKOwx2WBqp1oKvbTc0wJH49RBOXretpIkGB2evShyyGvgFQy1wdExOHv4RX7fxpVPRX2wTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=br322W7uJpQO7CbnNruW4x1Twm+0zYF5K4/uazzLqu0=;
 b=S53mt8VGfyXU0x/pfJclFGEJ3PrbcMu5b8gCg6OWVYtBowGOvFucgwGPRdiJCqsOTXaMI1+b4oSk5ZXw8C5vY+r6JtKFY/u+Kgwh4dXYHqPCeXUKVaNuxVXyMRYweFeHHeky9A4ZzwtVlIbBupgQihAZ/OndKGp5Bduaz3ulOE/MgXF2fmaVtO3e5+LIouaixCQ5TwoD68MJ0WjdvVKy+pWbw+G3narIgUiJdF6z99ZDGD1V7GGzcMTGUagdvyUFXcS5lvyMJlatXW2ZHRp3fcNGmT7NsBL4j4c+Lm7IFK2GXdTiW68HOuj6wwB14R3e6cr3ngIwv8n+OVKiGOc5iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=br322W7uJpQO7CbnNruW4x1Twm+0zYF5K4/uazzLqu0=;
 b=K2STpOevJo4BtSKCnN83MiBOPYKDmPYfr0OJqBLD3i0945D8cvFp5X5xA3cM9t5tSGZeIt/0kZ1MKf/WUZ12rihn/XV8c96JNrF26QGaoHxLPOAkYaJp/oR7puotlhvO8ZSb9FpmvLTpjXtEv+B8Mr3Tk1DzU+OwH9HVMrZwPSQ=
Received: from CH2PR12MB4838.namprd12.prod.outlook.com (2603:10b6:610:1::27)
 by SJ0PR12MB6733.namprd12.prod.outlook.com (2603:10b6:a03:477::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19; Tue, 11 Oct
 2022 11:19:17 +0000
Received: from CH2PR12MB4838.namprd12.prod.outlook.com
 ([fe80::ca59:d2c2:70b:4b8e]) by CH2PR12MB4838.namprd12.prod.outlook.com
 ([fe80::ca59:d2c2:70b:4b8e%4]) with mapi id 15.20.5709.015; Tue, 11 Oct 2022
 11:19:17 +0000
From:   "Ma, Rui" <Rui.Ma@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] PCI/IOV: Decrease VF memory BAR size to save host memory
 occupied by PTEs
Thread-Topic: [PATCH] PCI/IOV: Decrease VF memory BAR size to save host memory
 occupied by PTEs
Thread-Index: AQHY0X7RCECvmc6ZJ0OnxWUUfOu4763z19kAgBU3eRA=
Date:   Tue, 11 Oct 2022 11:19:17 +0000
Message-ID: <CH2PR12MB4838B7571D40D0CEDF30600D91239@CH2PR12MB4838.namprd12.prod.outlook.com>
References: <20220926080542.920427-1-Rui.Ma@amd.com>
 <20220927220640.GA1728095@bhelgaas>
In-Reply-To: <20220927220640.GA1728095@bhelgaas>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-11T11:19:13Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=bae527d0-9544-4c72-ac95-fc57c150fa09;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-10-11T11:19:13Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: a55a4981-dc98-4e41-bb6f-3133f0c36ef9
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4838:EE_|SJ0PR12MB6733:EE_
x-ms-office365-filtering-correlation-id: 1a2876e9-fe86-4c28-46ed-08daab7a6fa6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OzR3nzs0eS2n7KAJ5f85cP+Zk/FgvH+4T6jwrhBmtCKqhUH+t8j5ZzzQLzsJsAg+8o7XtG7PDxRNhjOg1bNGHty1EwVSbM3MAvpN/YD9PdPX8I/pH+s/AB/ECrApEPg+qxmI8sfdmehPTibvN28i69H4HlSnP93TQeMzsMxn0WgOXMnQSMeJK98RGySB6LiEik4uDTKGdvqCVijkZ8PXsPZIWQXPmbbR+diZC+crRkQ782tgcvx9wcXGPgSTSeBmyryz0MQZHirE/mrLaq5SCpmM4fXsuVBMKoCK0zr68nbxxqFicPNLJWfjxQCV95cfLooZu83F+5M9dzQktTgnFfGarBSJCYfC7fwggtYTYLdu/WamOMb8TWYbplSlD8h1t7+M+540QHmYBaDA4MeCPHCkPfuQM8JZmM1og9naGOvU2lJxPyhH1mf0luSd3vhO0sHPCW2bmRj1GETlwnNegLDvKSu1b6jXlNljOe4IK4lVa76MdHlJfHTG+02UlqiHEaOxGldwYXIRpnKFNSaOid7szSIlpMKe4VLkGsm697sVRF6sBMXmhfBEurMbJ7b2cMauB4HjJD2EYVYir005jWLfWjy2McgTXF7wl2Xm3fgptbVmFk2UL2jCwE4XdMEEh+AfmeogyhQg/dMxa4SaNSxuVBYuL9KDM8nRxHKfVjQ7xPSfIJ1Wr/u37F/WT58k6kp+XJ6ykLI9YRtGTsGCoxRE4jE7al+bRR4el1o0Lyq636o0Y+refl3KqBJhPKWBFOwyBC5nAAbgBMWQi7vwYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4838.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(451199015)(26005)(38070700005)(38100700002)(9686003)(33656002)(86362001)(2906002)(8676002)(64756008)(52536014)(5660300002)(8936002)(4326008)(66556008)(66476007)(41300700001)(66446008)(66946007)(122000001)(55016003)(76116006)(83380400001)(6916009)(316002)(186003)(71200400001)(53546011)(7696005)(6506007)(54906003)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gYyCUTEFrN15QFBddJMYvGN6dTfZDHVsd+IkS5y64dE+5VDFb5kcRqClk/M0?=
 =?us-ascii?Q?bWz4q/BOwgeltfkjMEP7SvALwayC717Yp6NEqeGht7X/Qhu/1U1wZbR2X0Gi?=
 =?us-ascii?Q?JIG3bslZkxaxb1EgBwu7V87amPAez10ZlzFWd5Ga897XlVCZNftxwHnUj8rX?=
 =?us-ascii?Q?kwHL7KHEG84itvtwyJbfF5LVsqp1SZHo3ajMvVz2QNb3tnerPl+DD0Tlv0Un?=
 =?us-ascii?Q?HlqDDQozShf8Sd5IPvhizEDDw4/jk8LBKopvYKYngY3o8JdO4SpOPTDzry4F?=
 =?us-ascii?Q?K7dQ7wL93D5+CzloWs08Ice9ROrPBsWS86YNuI1fFG+DT6mGfi5i+34oFQbW?=
 =?us-ascii?Q?nnrv89StWgg285ooyk0FuZ2/70a2iODBvfXPaGKTe1DeukwyqlWPonvtIpAg?=
 =?us-ascii?Q?PRrTTcovqSXvH1K7+G/g0K78Mrtnk2X1gGCMR6rCjYezFBLHbUeuL8x0kCvq?=
 =?us-ascii?Q?IkTaHBpN9PA+yUf243DxuSZqhAO74CI1YgcqHykLvsPH/rhpcwinLigCs2/C?=
 =?us-ascii?Q?3ZV1T5Alh58kD8TUM5si3UrdhkkHnpjoiNwBJPXRgM/a6RF+PJXI6MORcWmt?=
 =?us-ascii?Q?9kdjzBmfAo/9GSlUKg38fEElDaArGPLjdzmlyQL2AsRVZ3VQ+YbvYa2p8L9h?=
 =?us-ascii?Q?hqNh/BcWS/ZgzhBKNw46rWGHZn0cENhdXXo4Qse0TQ/fElfBExQ+ngJW4DwI?=
 =?us-ascii?Q?9ZLCX37Xr60dxWNmanNbtXSR1dmjmhOyLWfr2ukT4SMU/c07CNwU+Qze0qOB?=
 =?us-ascii?Q?K+f9qA8D6Oa9Fm1R5D162fg4RlKwyK1LQ7L03805kP1/s/D/n6iO509XioBi?=
 =?us-ascii?Q?t5Zkl/afzaiaZ07ePIgMe45KlbhT/KIGL7AClr8SArzUiWsiKNetqzFCmWI2?=
 =?us-ascii?Q?FnZVS5p2MU+NOnxaiENaBnwzImDvAIE91BzQJhm+5r7MBA2rnjdTchc+dVDa?=
 =?us-ascii?Q?VgGWVelm3hZ4za+NrEBo1cL7wA2HUWO+hXOv4NqIC7BFy5JHtSWTSGv+J9x6?=
 =?us-ascii?Q?mrkFOr/i1vFQKPECT7rHoXU8eGd1AharqDMAerzsUZRhdaI2ycO2C0luhi5Q?=
 =?us-ascii?Q?Go+uSl3/P2Tbo2pu0k4c+Tg8Nc+v8OCAj3uiqRO7mwHCKHyhv2i91oDqCW2x?=
 =?us-ascii?Q?F0l3pYDomSVkK4qF/OjsNQR4aYqECKRbTgQYvNace693OFGCgi0/9QfRIPnf?=
 =?us-ascii?Q?9k4oMtSndaeJKeAxvUXpZ91UYkR3DVvu48urHpLDaTxxkHyQ/qHWr+fhTqb+?=
 =?us-ascii?Q?gZuDkwj57ScycWEf1FDzM29OHDaXJFFZu0+CsPPHdsyETIngZKR0ud3DRKY/?=
 =?us-ascii?Q?PoW/qNeBn/7bDAtW9ECWrefuOlwYJ9t96/SU8qx2LhKuPw0S/nGNbdWO60IR?=
 =?us-ascii?Q?Mo0WQ3J23gvSx/c6wgXuvpuj9OPCjjxbwOMK69Xa16uxsck4FS+IFSOdRW2z?=
 =?us-ascii?Q?0VNmYhxMdtIXuoXXx/VkEXMQr3pJCCBXjMvJ35Cc8dBdDt8EVetri7Zkiv35?=
 =?us-ascii?Q?C9MAj/oUbiOM1Kn41YiK1Bf3l1WJFj/VK3NZBcGW40QQy5j00pBteNaP8JoL?=
 =?us-ascii?Q?wRZ069lBqhyXOgOOIWE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4838.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a2876e9-fe86-4c28-46ed-08daab7a6fa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 11:19:17.3405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z6WyVOR0NuMaiv/l/C+YFQSaOmDuXdzAAjFxiIUjoExRuAg5ofvjeEgsPWdXEh7z7s1QeKnNi1eklI0P8zshiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6733
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[AMD Official Use Only - General]

Hi Helgass:
	Thank you very much for your suggestions on my patch!

	The patch is a device-specific behavior. In our AMD device SR-IOV, the act=
ual VF BAR size is dependent on NumVFs too. If only one VF is created, the =
VF BAR size will depend on BAR probing algorithm as described in Section 9.=
3.3.14, but when several
VFs created our own driver will decrease BAR0 memory size  according to Num=
VFs. So I want to add this quirk to keep Linux code and certain driver code=
 consistent.

> Except that this doesn't affect the *starting* address of each VF BAR, wh=
ich I guess is what you mean by "BAR memory mapping is always based on the =
initial device physical device."
Yes we should not change the starting address or the device cannot load wel=
l.

> Well, I guess the device still describes its worst-case BAR size; the qui=
rk basically just optimizes space usage.  Right?
Yes.

> Aren't both virt and phys contiguous and nicely aligned for this case?  I=
t seems like the perfect application for huge pages.
It cannot use huge page though address aligned.

>> +		shift =3D 1;
>> +		shift =3D virtfn_get_shift(dev, iov->num_VFs, i);
>Maybe more of the fiddling could be hidden in the quirk, e.g.,
>  size =3D quirk_vf_bar_size(dev, iov->num_VFs, i);
>  if (!size)
>    size =3D pci_iov_resource_size(dev, i + PCI_IOV_RESOURCES);
If I hide get-shift func in the quirk is it concise to call pci_iov_resourc=
e_size() in quirk?

	And I solved other issues in the patch sent later. Thank you for your pati=
ence!


Regards,
Rui

-----Original Message-----
From: Bjorn Helgaas <helgaas@kernel.org>=20
Sent: Wednesday, September 28, 2022 6:07 AM
To: Ma, Rui <Rui.Ma@amd.com>
Cc: bhelgaas@google.com; linux-pci@vger.kernel.org; linux-kernel@vger.kerne=
l.org
Subject: Re: [PATCH] PCI/IOV: Decrease VF memory BAR size to save host memo=
ry occupied by PTEs

On Mon, Sep 26, 2022 at 04:05:42PM +0800, Rui Ma wrote:
> In SR_IOV scene, when the device physical space(such as Video RAM)is=20
> fixed, as the number of VFs increases, the actual BAR memory space=20
> used by each VF decreases.

s/SR_IOV/SR-IOV/ to match spec usage.

I think this is device-specific behavior, right?  I don't see anything in t=
he PCIe spec about the BAR size being dependent on NumVFs.  If it's device-=
specific, it shouldn't be presented as "for all SR-IOV devices, the actual =
BAR memory space decreases as number of VFs increases."

> However, the BAR memory mapping is always based on the initial device=20
> physical device. So do not map this unneeded memory can save host=20
> memory occupied by PTEs. Although each PTE only occupies a few bytes=20
> of space on its own, a large number of PTEs can still take up a lot of sp=
ace.

So IIUC this is basically a quirk to override the "VF BAR aperture"
size, which PCIe r6.0, sec 9.2.1.1.1 says is "determined by the usual BAR p=
robing algorithm as described in Section 9.3.3.14."

Except that this doesn't affect the *starting* address of each VF BAR, whic=
h I guess is what you mean by "BAR memory mapping is always based on the in=
itial device physical device."

Hmm.  This kind of breaks the "plug and play" model of PCI because the devi=
ce is no longer self-describing.  Well, I guess the device still describes =
its worst-case BAR size; the quirk basically just optimizes space usage.  R=
ight?

It's a shame if we can't reduce PTE usage by using hugeTLB pages for this. =
 Aren't both virt and phys contiguous and nicely aligned for this case?  It=
 seems like the perfect application for huge pages.

> Signed-off-by: Rui Ma <Rui.Ma@amd.com>
> ---
>  drivers/pci/iov.c    | 14 ++++++++++++--
>  drivers/pci/pci.h    | 15 +++++++++++++++
>  drivers/pci/quirks.c | 37 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 64 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c index=20
> 952217572113..6b9f9b6b9be1 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -296,6 +296,14 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
>  	struct pci_sriov *iov =3D dev->sriov;
>  	struct pci_bus *bus;
> =20
> +    /*
> +     * Some SR-IOV device's BAR map range is larger than they can actual=
ly use.
> +     * This extra BAR space occupy too much reverse mapping size(physica=
l page
> +     * back to the PTEs). So add a divisor shift parameter to resize the
> +     * request resource of VF.
> +     */
> +	u16 shift =3D 1;
> +
>  	bus =3D virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, id));
>  	if (!bus)
>  		goto failed;
> @@ -328,8 +336,10 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
>  		virtfn->resource[i].name =3D pci_name(virtfn);
>  		virtfn->resource[i].flags =3D res->flags;
>  		size =3D pci_iov_resource_size(dev, i + PCI_IOV_RESOURCES);
> +		shift =3D 1;
> +		shift =3D virtfn_get_shift(dev, iov->num_VFs, i);

Maybe more of the fiddling could be hidden in the quirk, e.g.,

  size =3D quirk_vf_bar_size(dev, iov->num_VFs, i);
  if (!size)
    size =3D pci_iov_resource_size(dev, i + PCI_IOV_RESOURCES);

>  		virtfn->resource[i].start =3D res->start + size * id;
> -		virtfn->resource[i].end =3D virtfn->resource[i].start + size - 1;
> +		virtfn->resource[i].end =3D virtfn->resource[i].start + (size >>=20
> +(shift - 1)) - 1;
>  		rc =3D request_resource(res, &virtfn->resource[i]);
>  		BUG_ON(rc);
>  	}
> @@ -680,12 +690,12 @@ static int sriov_enable(struct pci_dev *dev, int nr=
_virtfn)
>  	msleep(100);
>  	pci_cfg_access_unlock(dev);
> =20
> +	iov->num_VFs =3D nr_virtfn;
>  	rc =3D sriov_add_vfs(dev, initial);
>  	if (rc)
>  		goto err_pcibios;
> =20
>  	kobject_uevent(&dev->dev.kobj, KOBJ_CHANGE);
> -	iov->num_VFs =3D nr_virtfn;
> =20
>  	return 0;
> =20
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h index=20
> 3d60cabde1a1..befc67a280eb 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -603,6 +603,21 @@ static inline int pci_dev_specific_reset(struct=20
> pci_dev *dev, bool probe)  }  #endif
> =20
> +struct virtfn_get_shift_methods {
> +	u16 vendor;
> +	u16 device;
> +	u16 (*get_shift)(struct pci_dev *dev, u16 arg, int arg2); };
> +
> +#ifdef CONFIG_PCI_QUIRKS
> +u16 virtfn_get_shift(struct pci_dev *dev, u16 arg1, int arg2); #else=20
> +static inline u16 virtfn_get_shift(struct pci_dev *dev, u16 arg1, int=20
> +arg2) {
> +	return (u16)1;
> +}
> +#endif
> +
>  #if defined(CONFIG_PCI_QUIRKS) && defined(CONFIG_ARM64)  int=20
> acpi_get_rc_resources(struct device *dev, const char *hid, u16 segment,
>  			  struct resource *res);
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index=20
> da829274fc66..add587919705 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4085,6 +4085,43 @@ int pci_dev_specific_reset(struct pci_dev *dev, bo=
ol probe)
>  	return -ENOTTY;
>  }
> =20
> +static u16 divided_by_VF(struct pci_dev *dev, u16 num_VFs, int=20
> +bar_num)

This is clearly ATI specific or at the very least specific to devices that =
divvy up BAR0 in special ways, so the name is a bit too generic.

> +{
> +	u16 shift =3D 1;
> +
> +	if (bar_num =3D=3D 0) {
> +		while ((1 << shift) <=3D num_VFs)
> +			shift +=3D 1;
> +	}
> +	pci_info(dev, "BAR %d get shift: %d.\n", bar_num, shift);

Drop the period at end.  If we're changing the size, I think it would be us=
eful to know num_VFs, BAR #, and the new size.  IIUC, "dev" here is the PF,=
 so this is the "VF BAR", not the BAR 0 of the PF.

> +	return shift;
> +}
> +
> +static const struct virtfn_get_shift_methods virtfn_get_shift_methods[] =
=3D {
> +	{ PCI_VENDOR_ID_ATI, 0x73a1, divided_by_VF},
> +	{ 0 }
> +};
> +
> +/*
> + * Get shift num to calculate SR-IOV device BAR. Sometimes the BAR=20
> +size for
> + * SR-IOV device is too large and we want to calculate the size to=20
> +define
> + * the end of virtfn.
> + */
> +u16 virtfn_get_shift(struct pci_dev *dev, u16 arg1, int arg2) {
> +	const struct virtfn_get_shift_methods *i;
> +
> +	for (i =3D virtfn_get_shift_methods; i->get_shift; i++) {
> +		if ((i->vendor =3D=3D dev->vendor ||
> +		     i->vendor =3D=3D (u16)PCI_ANY_ID) &&
> +		    (i->device =3D=3D dev->device ||
> +		     i->device =3D=3D (u16)PCI_ANY_ID))
> +			return i->get_shift(dev, arg1, arg2);
> +	}
> +
> +	return (u16)1;
> +}
> +
>  static void quirk_dma_func0_alias(struct pci_dev *dev)  {
>  	if (PCI_FUNC(dev->devfn) !=3D 0)
> --
> 2.25.1
> =
