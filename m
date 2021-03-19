Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22784341ECA
	for <lists+linux-pci@lfdr.de>; Fri, 19 Mar 2021 14:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhCSNvm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Mar 2021 09:51:42 -0400
Received: from mail-bn8nam12on2048.outbound.protection.outlook.com ([40.107.237.48]:18305
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229785AbhCSNvN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Mar 2021 09:51:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQsh/5uMB8lIr84OEBsvh6aAu+Gz7IBhVKEDCrtwcR7GLpnSBdirZ3jmrlhFAF1QGPQFd+SMvpr3QTueCoNN8te9tOJyyv4lfrZ79EVJyAuHv3ZqGtJP6IGDczmHgQxAC/+lNAbw+1jjbPlkP2UCFV9QkrvIjnJFL9KU4VbqirGDtvgErM7BTR9WPSaB9BpD5ahAzyuwD76VZmChRi0QpoemAzx0kFSMxqi4+kH3M4NdCyqXp/loSNnlg4LDuL+KKL96MjWCYcxUL1oco8NI4HS5fNhVAsfB201xP4m7SMot71nq4irdwmoxSb/Sl2au4QxGXmCIhCARrU0Mw4GKag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kb/BsPH8uX7QHsJ/cyYgNoToou7c0wdfmtQxYjQ5Txc=;
 b=UXCY4lQXVFdfizCI4eIWNN32IXtdEAGN4Z9GP40iWLR5zOXG/ZgMbaV02bGkok91F4J9rbn2o//khU7sAwBmjkkM6BXtjDH9B7vhuQJHsbR5F8PLLE/NIxmoaBFvXaS+8Fd69tVlvniaeat9lRAhUgZxgrmr93n0Z3Gw5ZW+BKroeOTxW28V0h5zUYsp3x4/pAKdzanmVSQFgk8QvCTinrFwCTHIlVjAGdzI1W+A9iEpQsveMA9UF9r0qz/sTLxCI2mq6QrY4byKgm77UVXScVX8W6TxbrgnsS1acuLHrPs2scxG2fNZTYhq8TJGgosc/U77ttKku0UzR/fkKo5XTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kb/BsPH8uX7QHsJ/cyYgNoToou7c0wdfmtQxYjQ5Txc=;
 b=ZnJV7e9AyK38DZ8KjLQwC9xbSRoAv3ZdfypkyFhhg9zA9bJPigZNvvxyXRiiECtEd4LpcxFmRsKd5S4N8IUSaMMspVA99cfugBC8B/BJcLz7ZY93hYToI3/KVRpwsz/Vy29zyjSSNK0YJFAk5iET0H/BqZ5C9UdInbGoxNUtnH4=
Received: from SN1PR12MB2352.namprd12.prod.outlook.com (2603:10b6:802:25::13)
 by SA0PR12MB4351.namprd12.prod.outlook.com (2603:10b6:806:71::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 13:51:11 +0000
Received: from SN1PR12MB2352.namprd12.prod.outlook.com
 ([fe80::d1b:6232:d444:4330]) by SN1PR12MB2352.namprd12.prod.outlook.com
 ([fe80::d1b:6232:d444:4330%4]) with mapi id 15.20.3955.024; Fri, 19 Mar 2021
 13:51:11 +0000
From:   "Schroeder, Julian" <Julian.Schroeder@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "S, Shirish" <Shirish.S@amd.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Drake <drake@endlessm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: RE: [PATCH] PCI: Add AMD RV2 based APUs, such as 3015Ce, to D3hot to
 D3 quirk table.
Thread-Topic: [PATCH] PCI: Add AMD RV2 based APUs, such as 3015Ce, to D3hot to
 D3 quirk table.
Thread-Index: AQHXFjDf5flW2OWgCk2cPUWWKvSWjqp+vqcAgAygzXA=
Date:   Fri, 19 Mar 2021 13:51:11 +0000
Message-ID: <SN1PR12MB2352A8037F7C248F024DF3E695689@SN1PR12MB2352.namprd12.prod.outlook.com>
References: <20210311044135.119942-1-shirish.s@amd.com>
 <20210311125322.GA2122226@bjorn-Precision-5520>
In-Reply-To: <20210311125322.GA2122226@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-19T13:50:53Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=2f0dc422-fd6c-4c8c-a58b-99120f3f941d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.77.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aeafdcfd-39dd-4340-dc7f-08d8eade0e3d
x-ms-traffictypediagnostic: SA0PR12MB4351:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR12MB4351FCB9E509FCDAEC38293095689@SA0PR12MB4351.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:747;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pqmy+5yzaAaFehGuYr7Rxxa8uhsAvUl6PDgzZLY8o6dQoRgGn1vGfBCiF0mLa7x5JiDvXxA1hmwrQGpOZMTYa+RQpNcqjoCHHZXAkh2Ki1qJH6VHwmH7rdbldmDC5IC3GCDZ/Rj0xNbqlD2x4oiluBT1pwWTghlRyNBDAM/4vrBVcnvYfquLMk6gp9zKPK+yuSmQtr+TtTO2rUgPH/C99jsOPpMeYh+hDcg+2dMp5V+HJQuAnWihP0fLwXx5sUeOFQiiP6aXMi1OkUXfc2iIVTWaH2aLtR7FgI4hvRM/Jz5OdQ+NvK/lcWU6DD0snZB7f3/0+rlil0QgJHtNiR5in57Hbbkh6RVMOdqxk66rRUF0KYCE+qOgjlj3KtQhem7f8sPu/abdUHYrQ+tlCcxX7K4Vca+9VCGXoLAe3GHkh+InJKqjn51exIRRPis9J/KK2z3/+gEy0w5e1Zfon+NKtWaBsR9pfoNxYMuLX53kLnAh1i+dzTBBYheqhUfDGUECjUZ1icaiD9jASm/qMMxXljKOJyftCq3Hj5YCOLFgjQREjlI35t9nqFyBIBjAYnoy8cyDliJh+Q49AffinH6SCtF5SuOBwPovmiE+Gqj+0e1Y94r0RfNETfIhW4i24CMd0A8T72pT6rUUKpVNLssRgYyWpcMlS19oRbKND/wMet/yeI4kWQZxg7sHtAcaeMjU/+D4M10mruXBycJow8pp0wLFf6M4RFAjxsZewEutWAT5B8KLt2+JwlC6NBKyksugOpB/5omMaVorGpMJs1JyxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2352.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(66946007)(8936002)(64756008)(186003)(66556008)(2906002)(33656002)(316002)(38100700001)(76116006)(9686003)(110136005)(54906003)(6636002)(66476007)(66446008)(45080400002)(26005)(7696005)(71200400001)(52536014)(966005)(8676002)(6506007)(86362001)(55016002)(478600001)(4326008)(53546011)(5660300002)(83380400001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?z4oMH/+eVI6rNFniovsUHzGBYp/gUxUXSi2V29x14KnxEfUrSOFCgTbTa3xg?=
 =?us-ascii?Q?PDMGCoG+zmfaCNIfGF5/Q9NwjOCCqKTPS3QKD/MIjG52FRMY47VJVLaqnice?=
 =?us-ascii?Q?0vDvPlmA8cWOhbNSJWtXnKJ+4msdhLm6Zo2le6s7h2X8daKRSeihp24JmY1t?=
 =?us-ascii?Q?14P4wAOzZgKj+KllpzF3BSH50sQ3BYBZm4yO+4bPs58IFTHh6XPicwl+5xdm?=
 =?us-ascii?Q?5gFwQj+2/kEZv2H+UdGAVhQaHpjzDrn5SBlVhvgyr3EiL5bRxykYPstIwmuT?=
 =?us-ascii?Q?irWveKVbNVoUFK2RZhBF9gUu9vWoCnU/vmSSOhT7ubDcmo6egLv1RGmV3TUZ?=
 =?us-ascii?Q?hBFtrXFlYfoRuxx6TPFcDV674FuLCbtCq2pbXLJeHNqGLOLgjJnqCHi6OLJZ?=
 =?us-ascii?Q?2kILFrXiOzuUMGYLL9ZKXVAGTphZaz7SuKvrJ92DOwmLh5QO9xYgrSPn1QRH?=
 =?us-ascii?Q?kWfEUKnfxdVeIKBvYveRqOQ9IJ4joqsHAMS3UznuNlgWSSeDrJyHZo8JwO0G?=
 =?us-ascii?Q?31AcnnFwo1saeyxD5bJwh20hzi/aU7lQnjWwFUMnC/dQ8mtjykC8b/W+I3NZ?=
 =?us-ascii?Q?omBobHFf+cb7RpP7B42FHvSyxCvPoEB26Q8Hn+Dycm1ZI/PpfoK3nvIJ9nqn?=
 =?us-ascii?Q?BqY5WDxfGVGlPRmIe9ujfr5xdHB8gKaB/wYFb2j81WxnIpYwZRfEx0Zrk2SM?=
 =?us-ascii?Q?NGByoC/zk5T6SqheEKofltXn9Oah97YF5aOeKY+hY3SY+mw8ICla7Lggs9jz?=
 =?us-ascii?Q?SRzE6+8atT+nhoL1/Q74YuZpw/mdAU+k+EEaiwtfyPhSylaVlog89TdSDKc3?=
 =?us-ascii?Q?QZUbmMnTqmlVXfwLzuXnto0MscuHNr3O7D1ld/on0D2uoFe3oFCtn6VB5NMZ?=
 =?us-ascii?Q?pGWgZXVNlJJWny3Bgweak2aIT7bloliJXZYzeQlqLVeoeb37pcH/kLCA5vNM?=
 =?us-ascii?Q?UXB9Hekg1XJarAM1iqvoQLfR5HKCEuUhH6XFjH1afhLTMrIE66ypmpgunTS5?=
 =?us-ascii?Q?9q82/sd6nC8zQgjuJVzwCl4NSc/OXTJppgCtNKXF+F9CLvzX8UIkypD1rN6j?=
 =?us-ascii?Q?n6L2elzpXwbCTPVX+sN4KlQaLjxG2jyDLLu/e8eP046Q6xu/XfxBctSiCUXP?=
 =?us-ascii?Q?pgpJUXVv0bAiT4I1klIeq7EjQg+gLx/sX0q38BcAOYwx6P2fHOMsyitywytg?=
 =?us-ascii?Q?CbnXG3BEXV3kUMoDmUTV6PwfMlw+IW4CI8/wsbaq2PLQvc7EU3rccqQnVRVA?=
 =?us-ascii?Q?KcdE/2/QIpD6B4DISAylAGNDxkuga5nzHMWkLa0XYTNor5pyFlP4WfY9RyL9?=
 =?us-ascii?Q?w8J+6DrjjJblUBEjDpa6GUM3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2352.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeafdcfd-39dd-4340-dc7f-08d8eade0e3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2021 13:51:11.3800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yElS6eFyBK2xN8HgTPNymW+LVaAZhZ5+mB5aiDUqExkeRPCw4/HOxGGVkM0RYJjRyh3FxiCoCzhkIRiJkyfdeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4351
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[AMD Official Use Only - Internal Distribution Only]

I observed an issue with D3hot to D0 transition on 3015e APUs.
Since the peripheral device IP of the APUs already covered by this quirk is=
 almost identical. I added the 3015e.=20
Further testing an a great many machines has not shown the issue occur agai=
n.

-----Original Message-----
From: Bjorn Helgaas <helgaas@kernel.org>=20
Sent: Thursday, March 11, 2021 6:53 AM
To: S, Shirish <Shirish.S@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>; linux-pci@vger.kernel.org; linux-k=
ernel@vger.kernel.org; Schroeder, Julian <Julian.Schroeder@amd.com>; Daniel=
 Drake <drake@endlessm.com>; Mika Westerberg <mika.westerberg@linux.intel.c=
om>
Subject: Re: [PATCH] PCI: Add AMD RV2 based APUs, such as 3015Ce, to D3hot =
to D3 quirk table.

[CAUTION: External Email]

[+cc Daniel, Mika (author, reviewer of 3030df209aa8]

On Thu, Mar 11, 2021 at 10:11:35AM +0530, Shirish S wrote:
> From: Julian Schroeder <julian.schroeder@amd.com>
>
> This allows for an extra 10ms for the state transition.
> Currently only AMD PCO based APUs are covered by this table.

I'm really glad to see this coming straight from AMD.  Is this a documented=
 erratum?  Please provide a reference to that.

The point is that quirks are for working around hardware defects.  If the d=
evice is not defective, and it is actually following the spec correctly, th=
ere should be a way to fix this in a generic way that doesn't require quirk=
s.  That avoids the need to add more quirks for future devices.

> WIP. Working on commit to kernel.org.

I'm not sure what "WIP. Working on commit to kernel.org." means.  Does it m=
ean I should ignore this and wait for the final posting?

I'm OCD enough that I like commits doing the same thing to have the same su=
bject line.  This is an extension of 3030df209aa8 ("PCI:
Increase D3 delay for AMD Ryzen5/7 XHCI controllers"), so it should look li=
ke that.

> Signed-off-by: Julian Schroeder <julian.schroeder@amd.com>

This appears to require an additional signoff from you, Shiresh; see [1].

Bjorn

[1] https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Ftre=
e%2FDocumentation%2Fprocess%2Fsubmitting-patches.rst%23n356&amp;data=3D04%7=
C01%7Cjulian.schroeder%40amd.com%7C7fc41008b90e486b882008d8e48ca91c%7C3dd89=
61fe4884e608e11a82d994e183d%7C0%7C0%7C637510640444272647%7CUnknown%7CTWFpbG=
Zsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C=
3000&amp;sdata=3DnyJcTD5Vy%2BV1raz%2Fb7ZSiRdp7quMXcydjMdcD2FmQYs%3D&amp;res=
erved=3D0

> ---
>  drivers/pci/quirks.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index=20
> 653660e3ba9e..7d8f52524ada 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -1904,6 +1904,7 @@ static void quirk_ryzen_xhci_d3hot(struct=20
> pci_dev *dev)  }  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15e0,=20
> quirk_ryzen_xhci_d3hot);  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,=20
> 0x15e1, quirk_ryzen_xhci_d3hot);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15e5,=20
> +quirk_ryzen_xhci_d3hot);
>
>  #ifdef CONFIG_X86_IO_APIC
>  static int dmi_disable_ioapicreroute(const struct dmi_system_id *d)
> --
> 2.17.1
>
