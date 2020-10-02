Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1810B2813D5
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 15:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387412AbgJBNP1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 09:15:27 -0400
Received: from mail-bn8nam12on2041.outbound.protection.outlook.com ([40.107.237.41]:65345
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733260AbgJBNP1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Oct 2020 09:15:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VHX+o0MX4JRcKIVCn/TnTV45LkHz/ukW7Ut1y3Jrh94YkJ/No7/ypylgLHt/xkxmQnvtuo1+Ss5sPWvqwOc3eL8lm5kwK75ZOIahamRDfaO16aOerwq43UvA3zbncNqo18Ae697R9ftnDKuG9kMKoyH2hrsJp1vkL+PIet3LlluugBdtNUfC3VrIp5AzfIHXiWK2wSID7pEYsU0NbGMBZ/7IcyXfLCM4tj7u3a0A52lz6vdNOIAwtXZNwtM0L3eMl97FJ2XTCrIsFAeYDBcC6FeZo9XHsGcZs1zRmcKG4d4HW9ONP0Co0fX4XpPndLwDgjg2WG9jMyxmTfdRYiWMXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6J5dmLBtPUSZ04x5XH8ApvE6PPZYiPwhO4hvEAlKjs=;
 b=bIbmzmp12E23ZfFwH6HGj5SqGvliCAR4setyWbfPsAb57mx7suO+WVUQWI1v2/sfb3BgOzbFzrKU3Y7uUKJGfLpUYfgWhqoky7TA7iGehyokGEbeGVGq1xq/jRlfgBClayNJPET/gChBOs2mk7ViVTCKndWB12Gw1NYdatzcQfbSADGEinyQgIde50XIbMb/hyM+oOV9NffkJ4OVuiBUUCLa781DrilMmeqvHgsoJV5q9ubhibVOT0FiiVnfaxnKpJL31Axal13QZiXBWzyDIUKABpgf+lT/Lq8dMz493wL4zfuTmi1ggN0ZOQ4NH4VAXfvhNAxyaWThhdQDAq5Iig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6J5dmLBtPUSZ04x5XH8ApvE6PPZYiPwhO4hvEAlKjs=;
 b=ygjWopPx3L7dpHbnC+9Er0m6GUqBxIJVvamz/jc+cUCDlafOC5qyqe+Wz4AerA7sasah8no4kQuPzbznOZrZhzjdBC9M82BHqjmkjxWZDlW3cMU8TW0eBaibcENNRJ4ivv+SM5Zccx07WaqyMUufKohwvU1JqlUuv+jfmnpzcG4=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4270.namprd12.prod.outlook.com (2603:10b6:208:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Fri, 2 Oct
 2020 13:15:23 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a%3]) with mapi id 15.20.3433.036; Fri, 2 Oct 2020
 13:15:23 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Arthur Borsboom <arthurborsboom@gmail.com>,
        matoro <matoro@airmail.cc>,
        Aaron Zakhrov <aaron.zakhrov@gmail.com>,
        Michal Rostecki <mrostecki@suse.com>,
        Shai Coleman <git@shaicoleman.com>
Subject: RE: [PATCH] PCI/ACPI: Whitelist hotplug ports for D3 if power managed
 by ACPI
Thread-Topic: [PATCH] PCI/ACPI: Whitelist hotplug ports for D3 if power
 managed by ACPI
Thread-Index: AQHWmHqRW/ArdKHcKEup0PjEoxxiSamESs9A
Date:   Fri, 2 Oct 2020 13:15:23 +0000
Message-ID: <MN2PR12MB448892DBE4D6A735700AF4D8F7310@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <cea9071dc46025f0d89cdfcec0642b7bfa45968a.1601614985.git.lukas@wunner.de>
In-Reply-To: <cea9071dc46025f0d89cdfcec0642b7bfa45968a.1601614985.git.lukas@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-02T13:14:11Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=4a91f25d-ceb4-4741-bdac-0000d3c7fa73;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-10-02T13:15:19Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: c7711487-bb59-4332-a3b4-0000f2c9a82a
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: wunner.de; dkim=none (message not signed)
 header.d=none;wunner.de; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fd31ea48-e5ca-40c9-673f-08d866d538c8
x-ms-traffictypediagnostic: MN2PR12MB4270:
x-microsoft-antispam-prvs: <MN2PR12MB42709DE3DC40EC60C5B2C6EBF7310@MN2PR12MB4270.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2GzrEUv0h06mCGbMAxVoXt42hl0O4/tPvIafMm+yWARFmIdTaROcPlxLOSKcSpMGMbOq7sMDN6J+yj91cZek2k8+Ugw8WZBCwWCy3VmkiS+Hy1JDVXuAsJ5/4UXfoYK/IN/DWwhNwl6UAGQ3G+1FmtMLRc410vYeHQh60NDnjaZ85f3DHWMjoZLcGdykYQRooW3yX14veebC7/LUTVGlqmdvP+fRdCsStPtatvvDfu+9Hw2hlH7mksUTEvGmXpqK0rLLKXpoaZ1g5EQU1ayRZ55WD1TFSFFBpxsd0EgZ/D12ayDMEftT9ZcPTPFWGbjG5koFLxMp8It7dg4wFrt2GnTPNa3ZouFyceOI2x+l0vTTYCCWCcY7hjuKtOBWS3gkjdr1X/HvSeWTmdAlIy9Eog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4488.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(7696005)(966005)(8936002)(53546011)(7416002)(478600001)(8676002)(6506007)(4326008)(26005)(54906003)(110136005)(316002)(186003)(71200400001)(83380400001)(55016002)(52536014)(9686003)(33656002)(5660300002)(45080400002)(83080400001)(2906002)(86362001)(66446008)(64756008)(66476007)(76116006)(66556008)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: WN/XvmmWrtMvZTY10h/o2ojlIxRg1mvM72+VcuKn7aqSAV0Y74C81jCPimUXP2+zoXlBqlauPn2mnEro38ytud077IwnRUtnm6QCtkR8j619ykT1NOWPPUGamy7N+CZuAKMgs+hccck/br6uWWd+HQX8xjq5BuCsqlYNSuxTyxo4KgF5wgas0sl6p2+KmYqMjp8HUM3X5AC82eeWoQYbQZLTsyx8Yqau779uR5Z2Wgqcj+P/AKk9auqaM3OXP3qbcuMamQEpUiXYc/upcC9j6fObexmxuoRjzBJBoevGqUmQFw/oVVbBBb3nmJIv7QVWHsesjUFHkAyHNmgn1IrtGY7w/++lQBBOKSILdoa7wZqVfZaAGCVIPeX7O9Sj+QZ9GPUt7OTiJ9v9GEU74krlA8KSEwLJ0BQae4P15spvA5ncPf98PblA4cJjttRehAxI3PLP+kEMNbL9pmQNs3gpwPCnAOtxQI96bZmH4q7qUl0szJF0MflL573iJMfckU1eVhjx4oIusdWRWukMJwM1ECttOz7WEDoc6y2dr+HGbhF/tTyvZQXCJ0CmvQuUNgIqNr0r++VNNx12pbmqSSARroCWH3wbEDU8agpcYZaz+5D4D9sUr1xgLFqiY5xPHAuWr7uJtsA1BMIAQuXai4riCg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd31ea48-e5ca-40c9-673f-08d866d538c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2020 13:15:23.7718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eGFVOMpytFQcbAizvxOp/BZVVyWskNdcRYQprdzTBTmn0igLZhgdLfXpQ6LSKarVe5AflJxuzfqjqe3XhWOh0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4270
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[AMD Public Use]

> -----Original Message-----
> From: Lukas Wunner <lukas@wunner.de>
> Sent: Friday, October 2, 2020 1:10 AM
> To: Bjorn Helgaas <helgaas@kernel.org>; Rafael J. Wysocki
> <rjw@rjwysocki.net>; Len Brown <lenb@kernel.org>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Mika Westerberg
> <mika.westerberg@linux.intel.com>; linux-pci@vger.kernel.org; linux-
> acpi@vger.kernel.org; amd-gfx@lists.freedesktop.org; Arthur Borsboom
> <arthurborsboom@gmail.com>; matoro <matoro@airmail.cc>; Aaron
> Zakhrov <aaron.zakhrov@gmail.com>; Michal Rostecki
> <mrostecki@suse.com>; Shai Coleman <git@shaicoleman.com>
> Subject: [PATCH] PCI/ACPI: Whitelist hotplug ports for D3 if power manage=
d
> by ACPI
>=20
> Recent laptops with dual AMD GPUs fail to suspend the discrete GPU, thus
> causing lockups on system sleep and high power consumption at runtime.
> The discrete GPU would normally be suspended to D3cold by turning off
> ACPI _PR3 Power Resources of the Root Port above the GPU.
>=20
> However on affected systems, the Root Port is hotplug-capable and
> pci_bridge_d3_possible() only allows hotplug ports to go to D3 if they be=
long
> to a Thunderbolt device or if the Root Port possesses a
> "HotPlugSupportInD3" ACPI property.  Neither is the case on affected
> laptops.  The reason for whitelisting only specific, known to work hotplu=
g
> ports for D3 is that there have been reports of SkyLake Xeon-SP systems
> raising Hardware Error NMIs upon suspending their hotplug ports:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> kernel.org%2Flinux-pci%2F20170503180426.GA4058%40otc-nc-
> 03%2F&amp;data=3D02%7C01%7Calexander.deucher%40amd.com%7C712c82d
> abd82477e540408d8669172c3%7C3dd8961fe4884e608e11a82d994e183d%7C0
> %7C0%7C637372123238938344&amp;sdata=3DS1%2ByqWpkuZcilrl7kRXQyodrN
> P66MAjcECRDd7tEjpE%3D&amp;reserved=3D0
>=20
> But if a hotplug port is power manageable by ACPI (as can be detected
> through presence of Power Resources and corresponding _PS0 and _PS3
> methods) then it ought to be safe to suspend it to D3.  To this end, amen=
d
> acpi_pci_bridge_d3() to whitelist such ports for D3.
>=20
> Link:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla
> b.freedesktop.org%2Fdrm%2Famd%2F-
> %2Fissues%2F1222&amp;data=3D02%7C01%7Calexander.deucher%40amd.com
> %7C712c82dabd82477e540408d8669172c3%7C3dd8961fe4884e608e11a82d99
> 4e183d%7C0%7C0%7C637372123238938344&amp;sdata=3Dk%2FRI8kSJclwhzYuc
> WSjAZNzNEaaU9JgIYNjJsV0dAWo%3D&amp;reserved=3D0
> Link:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla
> b.freedesktop.org%2Fdrm%2Famd%2F-
> %2Fissues%2F1252&amp;data=3D02%7C01%7Calexander.deucher%40amd.com
> %7C712c82dabd82477e540408d8669172c3%7C3dd8961fe4884e608e11a82d99
> 4e183d%7C0%7C0%7C637372123238938344&amp;sdata=3DJvakgHaQNI6XMaM
> eTHqtPJ5ooZP83lN%2F6wcdHyt53yA%3D&amp;reserved=3D0
> Link:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla
> b.freedesktop.org%2Fdrm%2Famd%2F-
> %2Fissues%2F1304&amp;data=3D02%7C01%7Calexander.deucher%40amd.com
> %7C712c82dabd82477e540408d8669172c3%7C3dd8961fe4884e608e11a82d99
> 4e183d%7C0%7C0%7C637372123238938344&amp;sdata=3D8clLa%2BCnwH4xtK
> Dc7F9%2FqPBSMFygpjP8EiPgVIz9LiE%3D&amp;reserved=3D0
> Reported-and-tested-by: Arthur Borsboom <arthurborsboom@gmail.com>
> Reported-and-tested-by: matoro <matoro@airmail.cc>
> Reported-by: Aaron Zakhrov <aaron.zakhrov@gmail.com>
> Reported-by: Michal Rostecki <mrostecki@suse.com>
> Reported-by: Shai Coleman <git@shaicoleman.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks for sorting this out.
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/pci/pci-acpi.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c index
> d5869a0..d9aa551 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -944,6 +944,16 @@ static bool acpi_pci_bridge_d3(struct pci_dev *dev)
>  	if (!dev->is_hotplug_bridge)
>  		return false;
>=20
> +	/* Assume D3 support if the bridge is power-manageable by ACPI. */
> +	adev =3D ACPI_COMPANION(&dev->dev);
> +	if (!adev && !pci_dev_is_added(dev)) {
> +		adev =3D acpi_pci_find_companion(&dev->dev);
> +		ACPI_COMPANION_SET(&dev->dev, adev);
> +	}
> +
> +	if (adev && acpi_device_power_manageable(adev))
> +		return true;
> +
>  	/*
>  	 * Look for a special _DSD property for the root port and if it
>  	 * is set we know the hierarchy behind it supports D3 just fine.
> --
> 2.27.0
