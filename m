Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB87B3791F4
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 17:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241186AbhEJPGr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 11:06:47 -0400
Received: from mail-dm6nam11on2081.outbound.protection.outlook.com ([40.107.223.81]:16068
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233687AbhEJPDx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 May 2021 11:03:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dYXVylLof7KiJbfIGeju2iywmGucfFo7mSqEtYtoKncFxZZJMoTOe5Rg+2WQ1jhLzYFTo3IMVmqA5TlD8bCZpgxtui0KlOSAs2TTWICZwWgVBcrJpMRY2oZ6OM1/rJgZCHccc0HYpgcV5PMY9jDrCq96+K5h5Q2vDCYXg0sg3epfyNU6CnOKPd8bFieR/7FOwMcj1yUn+jx6YK8f1QDmItfmqJG8DL8/vLMb6DSq0p0h7YIAQbwhLvXbj2giCzwjbnyVVn3QvxsZvY21Tnvjcy5GgUIDidLVousnHNeU1V42NXca3jUDT3Qy18N/W3St19k1+PeCHTlPyEcPwHgyfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCTEBsdguAyHuQughLzp92+2mMesFb8QiLeSBxR/KJY=;
 b=IsFDcB/3c0bEqYlIkJgSf1nJ73boyu7ACaWYa7tHTtTDslQaiP8h7n0aJ3C1xkLtSWXIDsjC4BBVuVWrSqfO0RwzSdiF+rsjJyr4hMeEnqYQVf7HcIUvmoX7rMiKCjQ9YDSu6qkjXNF4zZCUfRnuliKvKGB7IYaVu3+hiU46eNOGZQz1+xBVNByTTLX3eJy/rWcXZdQsE8pJWH67U/iGKmeaaDRn74x3cgipLIFqoIPeyvgaSqX4knNjrfQEuibH3kN173uGL1KSzucIdmI9rXW4Z3ZuP4Tin/Zyd93pascnMKvzTmRASLu2jmVBMwuObfHoBOtu0Jh9CsC1an0Nrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=amd.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCTEBsdguAyHuQughLzp92+2mMesFb8QiLeSBxR/KJY=;
 b=AU4HoeIwWmmNw3mOVxWUgH4LwL3sfCc7K6wWpQsrlaaydYyyjzDLoVb7vRaZfb3FX3ByoXt2+PocP4zuSSQi9i9PC/fAkwT61NofZ2h0v0ucfE76c0WB1HKze/t/isYl06jNY3sgwVioSgMvoW3C8vJu/gogjxs++wj4Gng1t/c=
Received: from DS7PR03CA0246.namprd03.prod.outlook.com (2603:10b6:5:3b3::11)
 by BN6PR12MB1297.namprd12.prod.outlook.com (2603:10b6:404:14::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.29; Mon, 10 May
 2021 15:02:46 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::ca) by DS7PR03CA0246.outlook.office365.com
 (2603:10b6:5:3b3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend
 Transport; Mon, 10 May 2021 15:02:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4108.25 via Frontend Transport; Mon, 10 May 2021 15:02:46 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 10 May
 2021 10:02:45 -0500
Received: from SATLEXMB04.amd.com ([fe80::1808:d0cf:982f:70c5]) by
 SATLEXMB04.amd.com ([fe80::1808:d0cf:982f:70c5%6]) with mapi id
 15.01.2242.008; Mon, 10 May 2021 10:02:45 -0500
From:   "Slivka, Danijel" <Danijel.Slivka@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH] PCI: Fix accessing freed memory in
 pci_remove_resource_files
Thread-Topic: [PATCH] PCI: Fix accessing freed memory in
 pci_remove_resource_files
Thread-Index: AQHXQyuUNOgyuHQSMEuV4tqQvMN+t6rY6CeAgAPqyNA=
Date:   Mon, 10 May 2021 15:02:45 +0000
Message-ID: <5d5f4f33c3f34830b37cbd70e421023b@amd.com>
References: <20210507102706.7658-1-danijel.slivka@amd.com>
 <20210507220715.GA1545217@bjorn-Precision-5520>
In-Reply-To: <20210507220715.GA1545217@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Enabled=true;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_SetDate=2021-05-10T14:59:32Z;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Method=Privileged;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Name=Non-Business;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_ActionId=cc6b3743-cdce-478c-8ec7-e02b924281df;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_ContentBits=0
x-originating-ip: [10.22.81.148]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4759a5d3-43a1-4ff4-bc4f-08d913c4abda
X-MS-TrafficTypeDiagnostic: BN6PR12MB1297:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1297BC165FE97A35E35EFB9098549@BN6PR12MB1297.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b75B17FQ48EKYazlFP5LG+FsBEE3f3mOzJeyIRrwSl+WX5hztrhJ8emFI3VH3XP4Kw5ruVLcwQf6elDVxAg/nNRgvRWueG6+3bN9s7VpbhigrcW8x5qY2xexfjH6AHkwyABIE5rVRyfk1Xm1qOwgyK3MhN3391xLL5u+x27uVxmmUFoCCy1iwYq3+sf7kft+SNBZzlTH6yLxOj8YGGuslXrbl0NDHACrN6wlLr4zfw9PqAEO9Bax5K6EBcWYWMvcxG0RjYbUxJlCZjtyv3EsvVMxbn8rkIqOkOnFtj2DO82U94Sr8HjCpPqnZ36dzfjkKix+nQWCfIynjqE9nopno9cm2bKGt3tWQOfgQ0RimgU4gkUEIL1qrKg37Biu0rbURYENeQWG4o+q+6krNvG8yZ6QVmgccVMIxPDT1BeZ0Pn+48waMC1pP2nidDxpAtF8bwoG15AD4y9f+kAODwiEdgb/uJQEXYsk3+PIX0p/QsOeECiWqJ2c7+7fXv+TFHXuOVMJfhH9N1Pzq/jOqFrc2l1scOIYIeIsmIQgq4rvaVAzfZZ7Dbem+JZfkUX9zTRt0T3AGhlgPkcCGmbRBrSBrAvwyIwF4jycSrJgLRRZ3nOA/YPsd5CaTstDJGMJMjWf61cegFU5oF3KQ3Hp+cwQ1Gw8O/etX3cONru/CZx929h+LbrWg58q0I6TLFT3PaRT
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(39850400004)(346002)(46966006)(36840700001)(6916009)(478600001)(356005)(82310400003)(70206006)(82740400003)(81166007)(86362001)(8676002)(83380400001)(70586007)(7696005)(2616005)(36756003)(36860700001)(8936002)(5660300002)(54906003)(426003)(53546011)(2906002)(108616005)(24736004)(26005)(186003)(4326008)(316002)(47076005)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 15:02:46.6343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4759a5d3-43a1-4ff4-bc4f-08d913c4abda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1297
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Yes, I get segmentation fault on unloading custom module during the check o=
f error handling case.
There is no directly visible access to res_attr fields, as you mentioned, o=
ther than the one in a call chain after a check in pci_remove_resource_file=
s() which seems to cause the issue (accessing name).
Load and unload module will invoke pci_enable_sriov() and disable_pci_sriov=
() respectively that are both having a call of pci_remove_resource_files() =
in call chain.
In that function existing check is not behaving as expected since memory is=
 freed but pointers left dangling.=20
Below is call trace and detail description.=20


During loading of module pci_enable_sriov() is called, I have following inv=
oking sequence:
device_create_file
pci_create_capabilities_sysfs
pci_create_sysfs_dev_files
pci_bus_add_device
pci_iov_add_virtfn
sriov_enable
pci_enable_sriov

In case of a failure of device_create_file() for dev_attr_reset case  (whic=
h was the case I tested), it will call pci_remove_resource_files(),=20
which will free both, res_attr and res_attr_wc array elements (pointers) wi=
thout setting them to NULL.=20
Then failure is propagated only up to  pci_create_sysfs_dev_files and retur=
n value is not checked inside of pci_bus_add_device.=20
That causes the same behavior as pci_enable_sriov function passed.=20

On unload, during pci_disable_sriov(), pci_remove_resource_files() will be =
regularly called to try to remove the files.
The check segment that currently exist will not prevent calling of removal =
code since pointers are left as dangling pointers, even though the resource=
 files and attributes are already freed.

		res_attr =3D pdev->res_attr[i];
		if (res_attr) {
			sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
			kfree(res_attr);
		}

Attribute res_attr[i]->name is the one causing segmentation fault when strl=
en() function is called in kernfs_name_hash().

Here is the call trace:

[  991.796300] RIP: 0010:strlen+0x0/0x30
[  991.807240] Code: f8 48 89 fa 48 89 e5 74 09 48 83 c2 01 80 3a 00 75 f7 =
48 83 c6 01 0f b6 4e ff 48 83 c2 01 84 c9 88 4a ff 75 ed 5d c3 0f 1f 00 <80=
> 3f 00 55 48 89 e5 74 14 48 89 f8 48 83 c7 01 80 3f 00 75 f7 48
[  991.863423] RSP: 0018:ffffc1d68a9ffb80 EFLAGS: 00010246
[  991.879051] RAX: 0000000000000000 RBX: b5f8d4ce837e84cb RCX: 00000000000=
00000
[  991.900395] RDX: 0000000000000000 RSI: 0000000000000000 RDI: b5f8d4ce837=
e84cb
[  991.921739] RBP: ffffc1d68a9ffb98 R08: 0000000000000000 R09: ffffffff969=
64e01
[  991.943086] R10: ffffc1d68a9ffb78 R11: 0000000000000001 R12: 00000000000=
00000
[  991.964432] R13: 0000000000000000 R14: b5f8d4ce837e84cb R15: 00000000000=
00038
[  991.985777] FS:  00007f3c278b3740(0000) GS:ffffa0a61f740000(0000) knlGS:=
0000000000000000
[  992.009983] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  992.027168] CR2: 00007f3c27920340 CR3: 000000074c010004 CR4: 00000000003=
606e0
[  992.048516] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  992.069861] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[  992.091205] Call Trace:
[  992.098523]  ? kernfs_name_hash+0x17/0x80
[  992.110499]  kernfs_find_ns+0x3a/0xc0
[  992.121448]  kernfs_remove_by_name_ns+0x36/0xa0
[  992.134994]  sysfs_remove_bin_file+0x17/0x20
[  992.147760]  pci_remove_resource_files+0x38/0x80
[  992.161565]  pci_remove_sysfs_dev_files+0x5b/0xc0
[  992.175631]  pci_stop_bus_device+0x78/0x90
[  992.187875]  pci_stop_and_remove_bus_device+0x12/0x20
[  992.202983]  pci_iov_remove_virtfn+0xc3/0x110
[  992.216006]  sriov_disable+0x43/0x100
[  992.226953]  pci_disable_sriov+0x23/0x30

BR,
Danijel Slivka

-----Original Message-----
From: Bjorn Helgaas <helgaas@kernel.org>=20
Sent: Saturday, May 8, 2021 12:07 AM
To: Slivka, Danijel <Danijel.Slivka@amd.com>
Cc: bhelgaas@google.com; linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix accessing freed memory in pci_remove_resource=
_files

Hi Danijel,

Thanks for the patch.

On Fri, May 07, 2021 at 06:27:06PM +0800, Danijel Slivka wrote:
> This patch fixes segmentation fault during accessing already freed pci=20
> device resource files, as after freeing res_attr and res_attr_wc=20
> elements, in pci_remove_resource_files function, they are left as=20
> dangling pointers.
>=20
> Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
> ---
>  drivers/pci/pci-sysfs.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c index=20
> f8afd54ca3e1..bbdf6c57fcda 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1130,12 +1130,14 @@ static void pci_remove_resource_files(struct pci_=
dev *pdev)
>  		if (res_attr) {
>  			sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
>  			kfree(res_attr);
> +			pdev->res_attr[i] =3D NULL;
>  		}
> =20
>  		res_attr =3D pdev->res_attr_wc[i];
>  		if (res_attr) {
>  			sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
>  			kfree(res_attr);
> +			pdev->res_attr_wc[i] =3D NULL;

If this patch fixes something, I would expect to see a test like this
somewhere:

  if (pdev->res_attr[i])
    pdev->res_attr[i]->size =3D 0;

But I don't see anything like that, so I can't figure out where we actually=
 use res_attr[i] or res_attr_wc[i], except in
pci_remove_resource_files() itself.

Did you actually see a segmentation fault?  If so, where?

>  		}
>  	}
>  }
> --
> 2.20.1
>=20
