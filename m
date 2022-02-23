Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C82B4C0992
	for <lists+linux-pci@lfdr.de>; Wed, 23 Feb 2022 03:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238448AbiBWCof (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Feb 2022 21:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238127AbiBWCnT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Feb 2022 21:43:19 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A1E47AE6
        for <linux-pci@vger.kernel.org>; Tue, 22 Feb 2022 18:37:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBIU7BFHMuq2b1vXEj4yz6+GHxiMaiZ4nMh8LYVJHFEG62ilZ39cdcwZQTaNK333B3EfjVzo6CYR7RFlfQTSIGap/KBBvraxceH5qmrqU/KVcAXhJaQXTxpowMeAEv7XPkWBRlzmmpIW47FISeB2MOqeT8tHiSGJuaR9BMDYDh4ws+jQJ7YQDJNuN6ctxto1P449lGF/VNn4my1R1XmweTlBM5XHGQ/aH6CBr9/jH5wYA2kAZh0fME7HC0rDh/cX2LcGV936qCBwmMGAxoA/DrWUro0I7bWVk8JcQ57pvQm4rbjxQctDOI4YseRJGW5Re25AhACwzKuuiRiNKtZQog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfgR/ezmHhZ62TFBWfXbMnDDTmhU1J7Gl8f8JHuRlZM=;
 b=YHNdsDqEloEuVPvfXwb8VP65spnCCK3R26bgBHcqWhChKJwgt/WnwFuiTwRcTsjdDt6loua2fAYNdBvdNw7F8gn2fSGNzX3ikyQKUcroi+/SXsgAo+dFupkxInzxTLRWuQBDvjXiM3Jh96dtuv4O+YnH1UwyJrQZ9AjPgxIFnRtbYPcbK1cpuWMZ0GaeX3PUcrxJtTTqErGOoi8D7O1tqo4jCxZAGXEx568gRCwXrRlSWSfwOJCN2equYyZwQ5Qinw6L4M8nNGEY6xBX9yKpsknZgQ5RX4GNpaKK16398AGyjTkk+dNCc9j9XFWeclT4DTU6mENtfC+RWKejndEiVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfgR/ezmHhZ62TFBWfXbMnDDTmhU1J7Gl8f8JHuRlZM=;
 b=daay26Wbnom3+H0horPww6Uc7s5rbyhesvAuBhQm4dp7V4RcgGG/huy6JMTIc1WsU9rJit+YmvC90MIpB9j63h90Hup127tUWRbBi++GKEp2SVGqZ3Cj6iXWNdBbj9p6JjL6x1o1ZJpRjMFkTFSmCB16HFrRx5fbOI3M9lKBnPM=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 MWHPR1201MB0269.namprd12.prod.outlook.com (2603:10b6:301:5b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Wed, 23 Feb
 2022 02:37:15 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::612d:cd2a:369b:17c6]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::612d:cd2a:369b:17c6%6]) with mapi id 15.20.5017.022; Wed, 23 Feb 2022
 02:37:15 +0000
From:   "Chen, Guchun" <Guchun.Chen@amd.com>
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] PCI: Apply quirk_amd_harvest_no_ats to all navi10 and 14
 asics
Thread-Topic: [PATCH] PCI: Apply quirk_amd_harvest_no_ats to all navi10 and 14
 asics
Thread-Index: AQHYKAZxkDMOw9+W/Ee6TIjq/RLshqyga5ew
Date:   Wed, 23 Feb 2022 02:37:14 +0000
Message-ID: <DM5PR12MB2469B1512F32DEFB1979F1F9F13C9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220222160801.841643-1-alexander.deucher@amd.com>
In-Reply-To: <20220222160801.841643-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 683b5c1e-0b00-4e79-d940-08d9f6756722
x-ms-traffictypediagnostic: MWHPR1201MB0269:EE_
x-microsoft-antispam-prvs: <MWHPR1201MB0269CB49AA07F8719D628694F13C9@MWHPR1201MB0269.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZMlBJwryqycPa+f7gn0xpN0C1WxQ8y0E2OhTY+/tlbmni+e4ee95hOegMCQIGnIiOyHTxofQ05gw8al/c0pGVR6GaNUL/wKjpfFlTPmPGZWC7kW4aDQy+qe0atj+GoeJjMMws7+vDDkiaboKkjcbmp7heWxhvKLrcTexkXE+46fZHniGMhmhvNU2IGyjlPMRmzknL0KNdmYA4k9jqnrOlDeWgR1953RYIp7RyySZurHayhkYd5yJ44KX0LUh99AgUYg/WlHhqwnJVVWAvBdc5w2A6v5oGfLLTRCCigUUlmEcGnPPuADwlVRb9I+JjvuWDrWJHZUbOKTAUEgREU5KtJ3+MzO+yas9BQfIHHbLVA5BuAZhAgdN+0WAN4Oe/Fd9CMAE8/Bwkk9mp/4rbTAv7l03YNP1+NWepjEIYWxSTRbx2UqYLR63XihCQGLQI9y8QGu+Eptd7i8B1aKvB79xpXVLi+9BZS5reNF8gK/Afv75Yl5N7Sb9YyrlQopkOaWqFFxmmqboZQZZ2TMFd+CP3aBxc+JBI1n+AgrPNvGVzrDUOdvrsRJkaVXZPXr6LY+8g25gm0rNt3e27VPLL8EiGuvPW9jqjeBKLSR8I0zVkBMJZP3Bs86z1yBLXPCWAiYrdufId/iILIeULzFDSuZgQh9s4t8YqWIUpgE0V90qKdpKjWTceNrZay/IHT1kTiO9H+yigDDsX+xNeWhyQ24RCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(53546011)(26005)(66946007)(45080400002)(76116006)(9686003)(66556008)(66476007)(6506007)(7696005)(966005)(316002)(110136005)(86362001)(71200400001)(64756008)(66446008)(508600001)(122000001)(8676002)(38070700005)(83380400001)(52536014)(4326008)(38100700002)(55016003)(5660300002)(8936002)(33656002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SpHl8PQ+vFgAOHdmaZqk0fk4yNCHUXUDwsl25XnlZZpWZk0qsgs090tKlmzd?=
 =?us-ascii?Q?kuLJbw/7jnDWsccfWXQdmlkdiZsiDueyaillUHRa86p7T7lW4AXJTORTU1Ny?=
 =?us-ascii?Q?2WCWGKFPJyCoap6CBN1tGB6jua/PJbD50grrTHc4Y45BNETaPzJbFddS9svU?=
 =?us-ascii?Q?Ym/NiTUu/s874HdxyX2w1MkklI9buJg31LB+BwX8x6ZANTp67Rc4l9LB9iKz?=
 =?us-ascii?Q?DVKvc2JyofuK0BISM88ixNnHnFvmvPZEl8trvJlQGLcLjzuvhT6Lr6ZVxjFo?=
 =?us-ascii?Q?3bB9oCg2K+Q4ZjyIiRxlT8w5kJQ0y2OrBiRMtkjQTSnrscysS4LW4F1R9nxu?=
 =?us-ascii?Q?4qNjeRmFG9lOVo/8fS9Kdk5NdJobWWv8IeoxqcDm/H+uoV4AYnOqKgn5nsAj?=
 =?us-ascii?Q?AN7POfvA/lYe4/U+jv1aUMLXIEbCibgGSiMGdNgSxiwNQwatZF3aR92+Ycom?=
 =?us-ascii?Q?7J92ROZSqL+NvSdXARsnh14ICbQzIMq25JZiS23CKt7rTAygSXAdOiAeN6ou?=
 =?us-ascii?Q?rWNi4y4H3NNUm+Cn1c3Y87N13ObjfhxRvuWqrJLbDDV5X3cJ6Zly/Zrc4sik?=
 =?us-ascii?Q?chegBy7BytI9G/+i96wIKTs3p/WHOOffveM10/J33omuaARBccxwkcxkekfM?=
 =?us-ascii?Q?jy+SSbnjDCZucy2Z0PdV66VNx+8Fq4zdDeJgUYQCDZvFUczs7xvcvXYzmhYU?=
 =?us-ascii?Q?iuB7AtPN4JCEzidmeuslazADw4epZQtXgLsamfwlz/FiVB3JiZbQt6Yu9ziK?=
 =?us-ascii?Q?Nw2yOlqs207n/l2zJGr0OzpG4D+MiAYCcjk7VzUoj/RpJ+Bk/clhEVZrhh0q?=
 =?us-ascii?Q?jSYLYmCqcoVMc2mKlA/1Ak/3DT+HhHatinVfEmvuu4s0wWMb0VKZtNud1qb7?=
 =?us-ascii?Q?yTMEKRwgQXSMaktKGS1OLVNGS7qBM8ZcaaIdWcMNhHBl3fAipca4YJ6HENQG?=
 =?us-ascii?Q?M07IfhqIakNmO5DeojpO/WL5+N/ruTRVcX3+8ccGp6C0UUsL3JLx1xtSmgwd?=
 =?us-ascii?Q?Eeb20oxaJ2h5FKxRIDURLQSbHj08sW4vKE6R/T8y5JFVweiIX8fuv1BG9y9g?=
 =?us-ascii?Q?CmhuB3gY06E5z9L3WvD4EHGy/yfHtxgLUTLDdhBQKkHz1tMZzBMa1WI+HFEs?=
 =?us-ascii?Q?Zk7FjOZ6VRFTjcVPRK+oE0ZGDI/vwK7Xfo4D0/fOZbql1JdQKMjRDoPXQ7N1?=
 =?us-ascii?Q?I0ApBwTrjchpbrGoYq7gdF9701LxRPf6MVlLg0L++lFQGE8/689vxI7X1iju?=
 =?us-ascii?Q?ne98tYVEX4h9lyIX6yUxOmBbwrXSKhggSa3oJ9ekvjeW7L5lu+60q88pTVKB?=
 =?us-ascii?Q?xICXjPDjmQQhtwsPtVYCNLj7kZ31RCP1zVw1k7FQkO0YCGUaluR3YvUxWgX8?=
 =?us-ascii?Q?wtDipBf4H6NiBFWaJKHtpv19G8wvyDSxvIGq0bUozK2ejvYgr9KmIUnoCEZ1?=
 =?us-ascii?Q?3b4xIf4qA5NcQvRiX3wv+CfEbshhidF+fytmcOdJ34hpOOJxCM1EkEhe2TS1?=
 =?us-ascii?Q?wimHS1aF4keXM5vtKocmYFAejy/p6SVvqDd8TNBeG6hCA7L9nr9CIO3sGmp/?=
 =?us-ascii?Q?pjgz4K1CLFTyCuI/qI7fxjkaKgH19I29Lwxdhu571cQ3Kr9o1T8U8k6ErVZc?=
 =?us-ascii?Q?Kby5+fuIQIJbqkd/D5YBZws=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 683b5c1e-0b00-4e79-d940-08d9f6756722
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 02:37:15.0017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W0JsRbu2Kq6IJFNuMQskmZ0wQcKN6P2dvaieqBKdKeb8dFy5ibWPn8t9BNPczX/5Voh60GX6xCCL9QKbSUFEPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0269
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Acked-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Wednesday, February 23, 2022 12:08 AM
To: amd-gfx@lists.freedesktop.org; bhelgaas@google.com; linux-pci@vger.kern=
el.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] PCI: Apply quirk_amd_harvest_no_ats to all navi10 and 14 a=
sics

There are enough vbios escapes without the proper workaround that some user=
s still hit this.  MS never productized ATS on windows so OEM platforms tha=
t were windows only didn't always validate ATS.

The advantages of ATS are not worth it compared to the potential instabilit=
ies on harvested boards.  Just disable ATS on all navi10 and 14 boards.

Bug: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi=
tlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1760&amp;data=3D04%7C01%7Cg=
uchun.chen%40amd.com%7C1f54cd26c00041e476d008d9f61d92e8%7C3dd8961fe4884e608=
e11a82d994e183d%7C0%7C0%7C637811429151667411%7CUnknown%7CTWFpbGZsb3d8eyJWIj=
oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sda=
ta=3D1seVVxNb09HvAGelvuyN3WuHI%2BkCkfU%2F50Zzx4rifT4%3D&amp;reserved=3D0
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/pci/quirks.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c index 003950c738d2=
..ea2de1616510 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5341,11 +5341,6 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0=
x0422, quirk_no_ext_tags);
  */
 static void quirk_amd_harvest_no_ats(struct pci_dev *pdev)  {
-	if ((pdev->device =3D=3D 0x7312 && pdev->revision !=3D 0x00) ||
-	    (pdev->device =3D=3D 0x7340 && pdev->revision !=3D 0xc5) ||
-	    (pdev->device =3D=3D 0x7341 && pdev->revision !=3D 0x00))
-		return;
-
 	if (pdev->device =3D=3D 0x15d8) {
 		if (pdev->revision =3D=3D 0xcf &&
 		    pdev->subsystem_vendor =3D=3D 0xea50 && @@ -5367,10 +5362,19 @@ DECL=
ARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x98e4, quirk_amd_harvest_no_ats);
 /* AMD Iceland dGPU */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6900, quirk_amd_harvest_no_at=
s);
 /* AMD Navi10 dGPU */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7310,=20
+quirk_amd_harvest_no_ats);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7312, quirk_amd_harvest_no_at=
s);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7318,=20
+quirk_amd_harvest_no_ats); DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI,=20
+0x7319, quirk_amd_harvest_no_ats);=20
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x731a,=20
+quirk_amd_harvest_no_ats); DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI,=20
+0x731b, quirk_amd_harvest_no_ats);=20
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x731e,=20
+quirk_amd_harvest_no_ats); DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI,=20
+0x731f, quirk_amd_harvest_no_ats);
 /* AMD Navi14 dGPU */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7340, quirk_amd_harvest_no_at=
s);  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7341, quirk_amd_harvest_n=
o_ats);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x7347,=20
+quirk_amd_harvest_no_ats); DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI,=20
+0x734f, quirk_amd_harvest_no_ats);
 /* AMD Raven platform iGPU */
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x15d8, quirk_amd_harvest_no_at=
s);  #endif /* CONFIG_PCI_ATS */
--
2.35.1

