Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE7F70FB83
	for <lists+linux-pci@lfdr.de>; Wed, 24 May 2023 18:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjEXQQh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 May 2023 12:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbjEXQQY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 May 2023 12:16:24 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DB8C1;
        Wed, 24 May 2023 09:16:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfnEx/ZQokZCmdwBnmesCjQww/VGECQ1rkb89eyrkdaSJXqQg7Vj5FI4TBzmG56r1hlf40foqpGJpMDgpbpQNScOWa6A2unHlXVaBTmVleK/UMBEDOm6PECfj1BDBM3FYR8IzUEjP8VdTMhrEPgQRze6s77J8d/+QE7hNtAovlCdJKY1zu9zQg0xwKi0MZzYzoNPkmWhdfANYSHPX9w6tK3UOxfMqJb1HU/l/1mD4K0m9xw/nQOSpua7I/kAS91EZRT+XfjTxVMJNmnWvrqM9V/L+UwEvuQ2EtLKicd+k2nGe3sh3BUx0dltx/b5+ICgSitN+9NeXvyBTK/IaQPL7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zIczFQ4SvExU9mOicVzGvNpvNjbzBWg7N/EzmsAsdE=;
 b=m+TpP2SCJ57dULZX2Sm6UCgNiJJ9pGH/fjV7X2bFe9rXLTC3QOOOUNc65XAf6FPWQA9/C3iURfOqoBI3MKV+mVx3AR4xOTouUBqi7punXmK2FDdmOpMCifKckdbp8OzxOrkPbmwjlTNGB2vZpZGmlMJI0AlfVeoo6MuMIl+vHrNU4zJwUSHtTYJKBUBVFw1z3ULPh5IJ9YFKn9PXFEk4l0gbawGSgkBw5nqZbAmuz03kjRWxem9l50iLFWMBbHOYxEuxaC4adOUp9PhB2H+qg/JiIwaKwulxeo+w3llvCtKCQjWtUBveidSlmH/KpE3qsflVfVrjBwN5dkgPGs9WUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zIczFQ4SvExU9mOicVzGvNpvNjbzBWg7N/EzmsAsdE=;
 b=sG/fNgVcU68VX1XPWKsy2/78mIICEXALm+Zvd3ANGSm//zzKWX8MkETfX2JayabPQhosR0b1mRxQx8HZsp0IoDp5cNN2MV8oG0zA3ewChEOFXXXGfORQ0dBsRxU5xbM+0Kjcbnrh8FezQva8HUEszwT2eHOUt21VWDi52iqsWao=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY8PR12MB7313.namprd12.prod.outlook.com (2603:10b6:930:53::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 16:16:20 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 16:16:20 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Lukas Wunner <lukas@wunner.de>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Natikar, Basavaraj" <Basavaraj.Natikar@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Iain Lane <iain@orangesquash.org.uk>
Subject: RE: [PATCH v3] PCI: Don't assume root ports from > 2015 are power
 manageable
Thread-Topic: [PATCH v3] PCI: Don't assume root ports from > 2015 are power
 manageable
Thread-Index: AQHZjlOGnEBduEAsg06kATHaVNuSQq9pkLcAgAAGsDA=
Date:   Wed, 24 May 2023 16:16:20 +0000
Message-ID: <MN0PR12MB6101E8F181DA892B0D6D7C1BE2419@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230524152136.1033-1-mario.limonciello@amd.com>
 <20230524154454.GA28455@wunner.de>
In-Reply-To: <20230524154454.GA28455@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=88514904-ee4a-4191-b4dc-eadb112848ce;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-24T16:08:50Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|CY8PR12MB7313:EE_
x-ms-office365-filtering-correlation-id: f8c4f0d7-66f4-4a9c-0637-08db5c7235ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rcFkFIrvopiIEcwpcCXMhUNKX+CSXVTmyp7DLbO3my+0l+D4IhYgHAA8fh8wMtgGwIF9NxQBG5jsqNVRu2gU9cBIWnyvHMDLJqTVriQ72ICvKRHYplilOkjnRd1/CTSzBzI/C5MINLT6CJp06XCIuGEP89hbyHEAC+HWrmMwBiu0ow1Gc0JW3pWhYiDtikxMBi69BOPKJUNARTYjTu9favbjD8WOzGOUv6QtRsb8kQTjPWsm9LgHAlnE/ZD5dPy5avnM5tOUhR8K2EavkxStcylcU4O9OQ9b+TR1TPyBSpJTXiC1aJ0kjhK0mNjdodBeaOGfTr/W4CVgSayzI/9TSzroF0XZuwqgtwdgeQOStWtNrJ7T6pHjW83IST3Vk1H32L20UzRaApp8XqZZ6OnsBW64ohL8ttDpx8pYW53BtSzrn2WRcZNCrNypLUalteMl8jh5D4+7YWEKfUHbgBpgY8xpwdp6yj3x0+A6w9RHxF54fDF4J1P50GWJrupbw9wBL7pFdpzrLPPJYj2AToKAVWqbNo4I4znxBl64Qszilrs/lndOKAJAdWuO/MGMe+e+9wnJ9KPl2xlWMzTi/AG/0Uctgvrkx/VltdX/Q2dYT1OYgjt+dI5OOYtw9yXzxl1X
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199021)(4326008)(6916009)(64756008)(55016003)(9686003)(6506007)(26005)(66946007)(316002)(66476007)(76116006)(66556008)(66446008)(71200400001)(7696005)(54906003)(41300700001)(478600001)(5660300002)(8936002)(8676002)(52536014)(83380400001)(86362001)(2906002)(38070700005)(122000001)(38100700002)(186003)(33656002)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MwWg+iiURuw66LG6XFgO5M2W119/xvjQ76QgigjAVabONdyyvutg78eub8w7?=
 =?us-ascii?Q?eGmjFJxMx+bkBMqhqbpGG/zSUEje3M8p5KTaXjm+XD1AkW4v+E5SE+pSL56T?=
 =?us-ascii?Q?P1on6tvVyb9UJ3gsNxAWJv1XOLq5J3TmC/mVPf5cBRzA+hryb6o2oosJQiF5?=
 =?us-ascii?Q?x60Z74khN5vIj59EGh8pjRMlATqxa+z0+nexTirwT/6f3Eb+mLuiF8TaQkWz?=
 =?us-ascii?Q?bS8X4abiewpU3/A6fpt4FlwzXuK8Jh29EjVbC7BU4Qc9iQ0Dex5mhT6WeAgq?=
 =?us-ascii?Q?z8UO/qZsPrxn9aUhSVcTwQ5P0KBqFQZV/gCM34E9i4zpuFNllxMcswiJVFsf?=
 =?us-ascii?Q?kOy3xDNPwdqHECDJUkuwRuWd0c8aFYYmig5Py6XGOTn0eC0+lwgABo74biv3?=
 =?us-ascii?Q?8QB3nRXsGybGIXJwRtiGXLuWu1BK6XAuBGM7JAFGwkcA84uymOzZ31/u2HOI?=
 =?us-ascii?Q?2DcYfVP5YqO1QYSjsPfwWJmspjUDrFcTonh4rq3FNDGAJ67HZCaOWHZtbgJO?=
 =?us-ascii?Q?b+BHOF5MkIH+Pi+vV3Eto+BpSBlIYBtQZkjw3xNkTNib1Wkumq2yydJwZCiR?=
 =?us-ascii?Q?oriU4DX8mpopD63Qs82jzeP1I02hSFgDnbn6lsJExY567A8v4xyUuuJLSsCN?=
 =?us-ascii?Q?J0DhQGa2B6npVTyEiPHw5vHDBt2o3MX6HCPhee48z5F6VrTKCG6b7EAXh0yM?=
 =?us-ascii?Q?F0AQonvE4haUkVbL5cPSAWcHDUsNFljQJsTQEs/hyneRJCqu2kpoirffPnM7?=
 =?us-ascii?Q?UR5d7aKTTjWztQqskxvoqpBmbqWmNl4G2ytH3e0+pCePx+kh8VI+REbuwEJp?=
 =?us-ascii?Q?XBXj4OnLtz0PmrIiWj6wNAEzHPZxkp6k4gxrHFfsYlgBydfIQ/M9UAyJYEf1?=
 =?us-ascii?Q?YPeAtd4+0WzRHIsNlv72I/93Pu0XLT38Ph9j9L9g71J2+p9qSg27X0lp7XW8?=
 =?us-ascii?Q?jJXZHYOPODQZirYJpul+mf//j4tT68jGdVNLSFHQGodw1FWz5UVOt1N4AIte?=
 =?us-ascii?Q?pV2z9bxbhx5a4BItO9AmRZBTzw5Ul1w3NY1LJGmoUsE99hH9/nhYZbIYQz5e?=
 =?us-ascii?Q?KWZm+vmAel53c82WrWk6jzGOtHyTyG5Ia3yestwNiXRhIx1+AB3VukgRpd5c?=
 =?us-ascii?Q?7lvyJ20UJhufzDC5vqpCyU6wDEi0x2ffz0QiuawD1ZIM1waSe/PMcJFqKxDI?=
 =?us-ascii?Q?EywcR3TkUVEoqAgbNmVPVU8FvmynjkN1t9S6EiitVlhPdL/MQjNTirgkKr0K?=
 =?us-ascii?Q?+1VnIssJQSTt8HEZM19JbaHaLzHNzOXLLMyCJrOO8zs0qqhjQlD47XOVrOuW?=
 =?us-ascii?Q?76bCHjJbX3GlL0sNyLCSZq9mVozhVvdzM2hQ1QLD9NwYV2bhE7mNBXkg+Lsz?=
 =?us-ascii?Q?7eAiKFF+b60MaOIKunH8PaNTfnlkjMHpRnWglQoAtpxibCAwzIoaWpfnkBfV?=
 =?us-ascii?Q?7cGMQXp6EwE86On4asRmA4UY4rHn79LAA/zWOR/MCt5v3vFiZmfTdFE/C6ho?=
 =?us-ascii?Q?G7ldDJROU5O/C9ohp5n1RI2N6iJa/F/M5PVFL/+kQGggevWs6Voel51/SypI?=
 =?us-ascii?Q?bCckIolmyPXNRDTarDc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c4f0d7-66f4-4a9c-0637-08db5c7235ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 16:16:20.3818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rWlNZpk/H/9DYWgF2vPJ4uhthNmKKS/rRzt734SfwlvNDdhSZbSePdPt5FqVFZU8f0wWWpyHdb60nzvvlhj06w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7313
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[AMD Official Use Only - General]

> -----Original Message-----
> From: Lukas Wunner <lukas@wunner.de>
> Sent: Wednesday, May 24, 2023 10:45 AM
> To: Limonciello, Mario <Mario.Limonciello@amd.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>; Mika Westerberg
> <mika.westerberg@linux.intel.com>; Rafael J . Wysocki <rafael@kernel.org>=
;
> linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; S-k, Shyam-sunda=
r
> <Shyam-sundar.S-k@amd.com>; Natikar, Basavaraj
> <Basavaraj.Natikar@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; linux-pm@vger.kernel.org; Iain Lane
> <iain@orangesquash.org.uk>
> Subject: Re: [PATCH v3] PCI: Don't assume root ports from > 2015 are powe=
r
> manageable
>
> On Wed, May 24, 2023 at 10:21:36AM -0500, Mario Limonciello wrote:
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -2976,6 +2976,9 @@ bool pci_bridge_d3_possible(struct pci_dev
> *bridge)
> >
> >     switch (pci_pcie_type(bridge)) {
> >     case PCI_EXP_TYPE_ROOT_PORT:
> > +           if (!platform_pci_power_manageable(bridge))
> > +                   return false;
> > +           fallthrough;
> >     case PCI_EXP_TYPE_UPSTREAM:
> >     case PCI_EXP_TYPE_DOWNSTREAM:
> >             if (pci_bridge_d3_disable)
>
> This will exempt the Root Ports from pcie_port_pm=3Dforce.
> Not sure if that's desirable.

Right; It will only exempt root ports from pcie_port_pm=3Dforce
if they aren't power manageable.

If it's still desirable to let pcie_port_pm=3Dforce work on these
I think it's worth refactoring the function otherwise it's going
to be a nested if that matches the same variable as the
switch.

Something like this:

bool pci_bridge_d3_possible(struct pci_dev *bridge)
{
        if (!pci_is_pcie(bridge))
                return false;

        switch (pci_pcie_type(bridge)) {
        case PCI_EXP_TYPE_ROOT_PORT:
        case PCI_EXP_TYPE_UPSTREAM:
        case PCI_EXP_TYPE_DOWNSTREAM:
                break;
        default:
                return false;
        }

        if (pci_bridge_d3_disable)
                return false;

        /*
         * Hotplug ports handled by firmware in System Management Mode
         * may not be put into D3 by the OS (Thunderbolt on non-Macs).
         */
        if (bridge->is_hotplug_bridge && !pciehp_is_native(bridge))
                return false;

        if (pci_bridge_d3_force)
                return true;

        /* Even the oldest 2010 Thunderbolt controller supports D3. */
        if (bridge->is_thunderbolt)
                return true;

        /* Platform might know better if the bridge supports D3 */
        if (platform_pci_bridge_d3(bridge))
                return true;

        /*
         * Hotplug ports handled natively by the OS were not validated
         * by vendors for runtime D3 at least until 2018 because there
         * was no OS support.
         */
        if (bridge->is_hotplug_bridge)
                return false;

        if (dmi_check_system(bridge_d3_blacklist))
                return false;

        /*
         * It should be safe to put PCIe ports from 2015 or newer
         * to D3.
         */
        if (dmi_get_bios_year() >=3D 2015)
                return true;

        return false;
}

Then the check I'm proposing can injected anywhere after the force like thi=
s:

if (pci_pcie_type(bridge) =3D=3D PCI_EXP_TYPE_ROOT_PORT &&
    !platform_pci_power_manageable(bridge)))
        return false;
