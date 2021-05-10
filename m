Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7B5379220
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 17:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbhEJPK2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 11:10:28 -0400
Received: from mail-dm6nam10on2065.outbound.protection.outlook.com ([40.107.93.65]:5601
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232273AbhEJPKE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 May 2021 11:10:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4jHFGtnPPcWll70payt0vC6zLWFnSCULot5kfFL4gzVM+NImBxi09Dou8domlZPrbAAi7VbcGw3Q6CM5HneOTOYSUKY7vlXp4yxxqgBmwUoz3F0ZviQpa0mkwNBZp3os5UVWOUx3h5osHKFY8IY0BXgxhMAC7q4f4zvLt3jNaPbs2ZxyL/tYZHNLjoZp5XfelyMMiAN4bvEz9gxq6lM74F6tA411IqsyVU6q1EE2wSKYNKXjeILz2/wlosgCfdD7xGNnllOO70Muo2ZRIK8Wh2YT1csM0I35yJRhsOVaWWSoYcU0MD4l7U5LsfKvOwcgUGOV83GMjeIflLw+Npyow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PJHqv8/gHvGvF8w6PJuiNXq9h2UUfywUk3JTy1+IMk=;
 b=nBdRKPzp8DVGqTt2fpuyPFTg+9RRHSudNrjjBdtkag4b2ULlXLMZqluDE8j1/VRxdgEJw7z4XycGYRuI1jwSOFl42bXHk9E+sWkfyPUYPYJtDMKs5RQ1n9u6+sJB42r0wDrlp3vEAH2Xh37OzIEyonxWel0fv13zewO0cAKzcsyHEJ3bPzfmXV33V8SOXgoyxiGhrycQPaj5w02M03cdlPi99SqJWhF8t78mJgbAPlbnJGRHzzmEbIOUiAN5LYHve7xDyfIbVODMYwA9U+ID+1ulPzV3LNeSdR6j7IXS3D/kErOGi+B3QRL+MQKsxs/cUM39ugPwqjQAd6N/pU8krQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=amd.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PJHqv8/gHvGvF8w6PJuiNXq9h2UUfywUk3JTy1+IMk=;
 b=I6r01gRR0Y938c2K5ZS5T+gyS0dl0gH5SrNh180GmP1BCocoYNSgzdxG2Se1rTa5+QH7wXp1deDJ+5284DNbqPoMT/42F7RMi4OdSGE+L5g6OJjm2/ySJ+G4ztYb+i1NZmwgn1sDmtwEMqxVjC89fnHIhvGOKeu2Jaw1pYHNQj0=
Received: from BN0PR04CA0121.namprd04.prod.outlook.com (2603:10b6:408:ed::6)
 by BY5PR12MB3875.namprd12.prod.outlook.com (2603:10b6:a03:1ae::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.29; Mon, 10 May
 2021 15:08:57 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::3c) by BN0PR04CA0121.outlook.office365.com
 (2603:10b6:408:ed::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Mon, 10 May 2021 15:08:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4108.25 via Frontend Transport; Mon, 10 May 2021 15:08:57 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 10 May
 2021 10:08:56 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 10 May
 2021 10:08:56 -0500
Received: from SATLEXMB04.amd.com ([fe80::1808:d0cf:982f:70c5]) by
 SATLEXMB04.amd.com ([fe80::1808:d0cf:982f:70c5%6]) with mapi id
 15.01.2242.008; Mon, 10 May 2021 10:08:56 -0500
From:   "Slivka, Danijel" <Danijel.Slivka@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH] PCI: Fix accessing freed memory in
 pci_remove_resource_files
Thread-Topic: [PATCH] PCI: Fix accessing freed memory in
 pci_remove_resource_files
Thread-Index: AQHXQyuUNOgyuHQSMEuV4tqQvMN+t6rY6CeAgAPtwtA=
Date:   Mon, 10 May 2021 15:08:56 +0000
Message-ID: <16d920c979b24639b1aeda4c565c644e@amd.com>
References: <20210507102706.7658-1-danijel.slivka@amd.com>
 <20210507220715.GA1545217@bjorn-Precision-5520>
In-Reply-To: <20210507220715.GA1545217@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Enabled=true;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_SetDate=2021-05-10T15:07:02Z;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Method=Privileged;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Name=Non-Business;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_ActionId=dc4fbade-f75a-45d5-8421-ed8b2eaa2e91;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_ContentBits=0
x-originating-ip: [10.22.81.148]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2513918-0b68-432e-53fc-08d913c588b2
X-MS-TrafficTypeDiagnostic: BY5PR12MB3875:
X-Microsoft-Antispam-PRVS: <BY5PR12MB38758A674423EDC960A00EB798549@BY5PR12MB3875.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YPhr9/RIegqIezjgdMVuNdSO49Qcp+HIztiFxheU5ZRmb/Oys6j5rJdSj4rqo8VsnxO/psMCQOmk6g8oLl8vYOTEA1FVKluR67bU3/YXH2W5HdOUQZYC+bANR349pgjDX7Ce4Hh1I8jIudn/xJB0LTlcwkyd+U1UeYF75962VXq0fP1ysJK7O5xp+8e3SXXaGeJh4rC8f6xiamW4oCMgHniImx5g8b907L98VgVnx47l9ARWSPgk7ZHL1U3uc/qsFQFFcjB0zSw6oe2XHTkWWa7q+s0aGbwtm3PBitTkVwC6vor7FIlQFTpL58ljjQLDVBdA0A06QbEqR6fy3Kkm0qQxTJ+RGsmgZs/6B1Pqo+qmmxjXwBBv1usFm9BqCw8p9weeLUZWonVGFsz+XK15Yk/BymXw3xm7Lyt7OZw0RVWS7VHzvH3k+DbWGfsQsU7jPzXzGuTc0CMyHXe3EBb2eRZ3ElUmJXB7uEGh9DkI+F9taIstd+5IpM/76eUt7fQE5MQuIz1aaKf3xE22+6cjcEeWlEv6ae9Hg/H5neQ+PDrUqgyAjPI2GOeTMvFOu03J/yNqL1uCeOhM0UB+Ug4U+u6IR3cpcRy5XOMOVyu1q6yzMC4NMkA3g48bP1OkaIbdr1lHJPG9iLHiVVblrwiMj+8Qw7LgMptNPGhpdyRM21u0OMyw8ECfrE1hSrdvi8Qs
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(39850400004)(346002)(46966006)(36840700001)(108616005)(24736004)(53546011)(2906002)(186003)(26005)(426003)(54906003)(5660300002)(47076005)(336012)(316002)(4326008)(7696005)(81166007)(82740400003)(70206006)(83380400001)(6916009)(356005)(8676002)(478600001)(86362001)(36756003)(36860700001)(8936002)(82310400003)(2616005)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 15:08:57.2069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2513918-0b68-432e-53fc-08d913c588b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3875
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
h was the case I tested), it will call pci_remove_resource_files(), which w=
ill free both, res_attr and res_attr_wc array elements (pointers) without s=
etting them to NULL.=20
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
