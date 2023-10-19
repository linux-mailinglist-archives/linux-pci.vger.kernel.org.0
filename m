Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B9C7CEE8C
	for <lists+linux-pci@lfdr.de>; Thu, 19 Oct 2023 06:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjJSEI7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Oct 2023 00:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjJSEI6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Oct 2023 00:08:58 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2090.outbound.protection.outlook.com [40.107.113.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742A3119;
        Wed, 18 Oct 2023 21:08:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggjRLGsBKZUiuguWQyjskoimYU55mw7NTB+OeqxfOlCG58DMQRQuPoA61Eb28SPIP26fP1OzMx/TURQv7Ri/Rfut2Ok8oWonCge3eDF5/9+QudwHhxMiIysikzPQw6zijtHYLi6pboBMo3+Xata9ZqxsSOwK3vIAap4oX88ZVrP0DLtXOkt6Ahunzds02+msBC+aJz1K2s3T4+4c7wc97WaYWIMbsj1GmZ4D9M5V1TAKhMIqhDdwga0Aldz0IXz7SWIEpgXgdizbtk22tCBZcr2Jl+2azArh22gZZ2ZNfzr8KESW5QsiHTxCwTHoGFoUYQlT+bF90sWeipmzrh6NZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkH5jfdaYT8PT8wen0pmv+5IAsCE/sUArv5M1/KjPjk=;
 b=HvORF7/V6LbKCl6Dce1pjgzXdWCH+Y9/dZ9hfuQzFaIF+kOAu377AJck64U2cAVZebJNL2KQvHM5UsFCyP6r32i4Y80h4BQPCDsVRnoRev2w3PApVF+5+s2+pQiCd1IG0acJJEqkKjWSDfGVcDlrIKsfTaKD/dn6wIHUihYYv4tjMsiMMlR2yYYrkwuyDQdv5aTrjNj3S7Jm7aYw5xbVD6agOcCHTa9qrKXjtBB57wLHJfZbcp8N4MY7jSufwvCiEkUdJsf3aTknczQv4bgSWM4mcvAPPk9HIQw/ok5s54JBkHxqGtU/P9/NOUNSevNVpRwkKJE97MXWmOFgCnpA2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkH5jfdaYT8PT8wen0pmv+5IAsCE/sUArv5M1/KjPjk=;
 b=mUWOexu2MhuNBO7MFxDrvzQbV/zy2ZWHIxxQRIDjeSmu7F8lTvM+Zi43tgQz7jZh2qYsmAeYoSbZUw99ATFH8kMDhrFRFmxZppkkOGOSOPsLL3xvR7Lf4iDTzz0M2XgNnDBV5OPD6Wf8b8WlDMYAs49cUIzRL+gI8jQgpNK/ib4=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYAPR01MB5881.jpnprd01.prod.outlook.com
 (2603:1096:404:8055::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25; Thu, 19 Oct
 2023 04:08:52 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::a188:9424:be62:e5fb]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::a188:9424:be62:e5fb%6]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 04:08:52 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v25 00/15] PCI: dwc: rcar-gen4: Add R-Car Gen4 PCIe
 support
Thread-Topic: [PATCH v25 00/15] PCI: dwc: rcar-gen4: Add R-Car Gen4 PCIe
 support
Thread-Index: AQHaAaEPwnq5Mag780e6hMOhN4NTKrBQcG0AgAANx7A=
Date:   Thu, 19 Oct 2023 04:08:52 +0000
Message-ID: <TYBPR01MB5341B3E0062E61EE5F2C84D8D8D4A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20231018085631.1121289-1-yoshihiro.shimoda.uh@renesas.com>
 <20231019031042.GA1385745@bhelgaas>
In-Reply-To: <20231019031042.GA1385745@bhelgaas>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYAPR01MB5881:EE_
x-ms-office365-filtering-correlation-id: 0ecfcf7a-fa79-41e2-acc9-08dbd0591ab7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aj35jEZcbd/ahTz1Kr8dq6e6CMheioxaoWNBGc37YlNWZ1/Ed3tlEfYsiNlgjvzIZuAouSNZliPX5PvrkmS+HhvUp3VT0XFmk0CfL1syFNlBnHCWhgzpgcJY3sJh2Z8GMzQuHPmr4rrAyUKhUvUVwss2c8vgadccvnLadbdgBGjGxfhnJw7Uma8QZmid0F3CPrW/kIbxVU8FJmMgtecx/o50xvRUzXfyZTwI7vSqDmhuDjGsKawXpUT90Dq7gRVLZODAbsTwPobvMSWByhFtokcsOZ5yqqnvFTRmL/PxpKi+bZWZcbbN6+Alt4ghuF4486TVz8OFog5gRw7CAETJrTjia05ePWFInvp+DCZ2qWyWCG1Uo/0LsOfgfsYVubPvAIa4d2BUClEJeohQc5STxoczmKps+MZTLWANkCgkuNYNgqVvid0VIN5slEy+JpxbDU21Uajb61dXaei+yGNHdedxCTKuhqg0Px6a2Wc3fpdK4edZuAIPAE8KXPQIVN7T+1LAbxXBA2Cz5nIFgvkSgQ0sp2+pyBJY6p5Hrsvlv23jzOxH/1B8byKZAs0NN4MVCGUD+Hwj9+BoEyWpmKucQ4ihdZP601ec26M35NJpfeg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(122000001)(38100700002)(41300700001)(6506007)(38070700005)(7696005)(9686003)(83380400001)(966005)(478600001)(6916009)(55016003)(71200400001)(316002)(66476007)(64756008)(66446008)(66946007)(66556008)(54906003)(76116006)(2906002)(86362001)(33656002)(5660300002)(52536014)(8676002)(4326008)(8936002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UTXR5ErAca4Uq70e5d/fMbdVxbm0QlDRK97MMr9rdMaVBlpB3w11TDPr1nKC?=
 =?us-ascii?Q?kjtsZeu8q0QnsqKsL/zz1LwJTjHGHqheOyiRbdn/i149V7wk2AXPpo0wTNtN?=
 =?us-ascii?Q?QJ+q3LNdpB9Qsr/EEBznGc1AqCVWUzBFqn6iksHG7duTQ7ifeTpgS845uC60?=
 =?us-ascii?Q?gaCX6rUvqfVgGOO3Mcmy68N2QoW40zRdYb972Tbljg22h9WzsId7qZV4Vms/?=
 =?us-ascii?Q?g62cVcy24BPZrW7Okp18qUDI7kOJGqzYl5x00gqjxZvhruN/60NycH8UrwFm?=
 =?us-ascii?Q?DO4LWGNuzXwTAGtOURJ8PLK6TGFTu/eEro4qK5gP6aSItMsQ5GCoJXpkk0he?=
 =?us-ascii?Q?k+VNHrQ9j3Ha7F4bdDSompoZYVHS1DaRenDIx7g5nkzCxEShVIZMzfpv98Dh?=
 =?us-ascii?Q?OuGaFyuYAPvMSad4ygYYX62Sgiba7aWybGIzpoyCJjHRNbZ0h3NGeQGrH8EQ?=
 =?us-ascii?Q?Bvs7pCGpYgF5D/0WQyV2ABee0r/FBsx0vahLuUJjYoy8ilU48ntdwZ2P6G2w?=
 =?us-ascii?Q?DMhBqveab5kW0qFDLWOtmo6tVnkZeGfsQIZU2MX4nqFDHfXExazSKCc2sn9G?=
 =?us-ascii?Q?elFHO3mqn8trrOI5zyvRsAneo5VPNY/Lm4KGBYFS27L7zQhqN1odMSh0FuOE?=
 =?us-ascii?Q?f72qb2/Nlq5zHmTs6/4J4Lyi55v/E3au6qIaq/MIMvgq8pBXBEOkDU3avYuI?=
 =?us-ascii?Q?oX3y7yHvi9J+jYap1qjirtvngclUzZrfcjhPnm9a8fRhf/XNjlPfLSZsTOo/?=
 =?us-ascii?Q?nYi71QWGhCWJ2wqdUxcGHtl5tLqS+yUQtV2DiRgmO/FLRavkPmi+aWT0F5AS?=
 =?us-ascii?Q?OnmvG72qrql8KHJ5pOXKKYOxdlYVR/JjvTG+Ed7YTUHfMQZQcmVqfwH4PO7w?=
 =?us-ascii?Q?QvQdf15xoX4s7tihpSzN2JBNZYCt77DVjXtdMOTDPwlY8G6xe8rGdJclz/wt?=
 =?us-ascii?Q?ez2KVQxmzZET34vHOZt1tSEV77Pig+id40l0Yk1AS5nYcJxOvTSIjbd7ao79?=
 =?us-ascii?Q?Q07i5Zn3gwbg+EHyP6EMtZ7aben59eB6JqWLVdJaGn7UksAVFG554fDjXHuJ?=
 =?us-ascii?Q?rCvpTeMLse3tNjJFC7Sftmu6Wc0pwU2+dMnIOPhl6Ix7gQNy58polu/WXAn4?=
 =?us-ascii?Q?R3nuEUFVoxF8Sot4N6G5KIv1OfFezFjVEZCN59HC0aXq9DrqXR9YQuiz3VXq?=
 =?us-ascii?Q?uH1Zm7nJ0m++NorWZUJV//Tet6jr3cMPv7EasM2N5QV+4hyTLY9bH/51vVn2?=
 =?us-ascii?Q?6LlXsqplolgWxnF2T2+RLazchFzEIi5MCOMgsNBKSmh6WW71rcNp749Msa+K?=
 =?us-ascii?Q?AVScEcDP0cp4OMhgZMTa0UpxP1KzqO+e1BcbiCKcN4yDjYyOT4H3SEG30QkE?=
 =?us-ascii?Q?XVEHmg9CEg4uf2J83iFKrRKkl/Ev+tpbUqPgh+WKFG5nZ1IQaxMp4TPLIUkK?=
 =?us-ascii?Q?YPqYt9JsQCmu02IiFD7yAWsikQknXyDOfRfwnXc0lthsLgGzFVZxy0fWqz+J?=
 =?us-ascii?Q?3S7H3HkIv5VdN66VzjtYRmpoj7juh09gz9fA2YbnDHEK/vrkB75VF/xErpb3?=
 =?us-ascii?Q?hX+I3QSDJW/iIgbnngy7QaoB+vI46C5nanpsnog0VlE8mR5mTG5RA2MGZsgK?=
 =?us-ascii?Q?PsBaaSS7Z/avUAFeU9mAQ8nARqlPFJHk/XcyIgQFvdAiZri8V7hWIjkSlLaQ?=
 =?us-ascii?Q?4vMjTw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ecfcf7a-fa79-41e2-acc9-08dbd0591ab7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2023 04:08:52.1640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c2U95QuRp9ohstxX3eObbp2yfWnGTb6uP8SKxb5tBVwh232hlK0Er5clOxicE+DBq5tUF15+saCt9ZcS+rvHdFSLFP5rrEFX5nrENzwZYkwIfo+fKLXQZ9KQtkJ1aubT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5881
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Bjorn,

> From: Bjorn Helgaas, Sent: Thursday, October 19, 2023 12:11 PM
>=20
> On Wed, Oct 18, 2023 at 05:56:16PM +0900, Yoshihiro Shimoda wrote:
> > Add R-Car S4-8 (R-Car Gen4) PCIe controller for both host and endpoint =
modes.
> > To support them, modify PCIe DesignWare common codes.
> >
> > Changes from v24:
> >
<snip URL>
> >  - Based on the latest pci.git / next branch.
> >  - Reordering the patches. (This is suggested by Bjorn.)
> >  - Drop "PCI: dwc: Disable two BARs to avoid unnecessary memory assignm=
ent"
> >    because break other platforms.
>=20
> Does R-Car Gen4 still work without this patch?

Yes, R-Car Gen4 still work without this patch because I added this code int=
o
the patch 12/15 again:

---
+static int rcar_gen4_pcie_host_init(struct dw_pcie_rp *pp)
+{
...
+	/*
+	 * According to the section 3.5.7.2 "RC Mode" in DWC PCIe Dual Mode
+	 * Rev.5.20a and 3.5.6.1 "RC mode" in DWC PCIe RC databook v5.20a, we
+	 * should disable two BARs to avoid unnecessary memory assignment
+	 * during device enumeration.
+	 */
+	dw_pcie_writel_dbi2(dw, PCI_BASE_ADDRESS_0, 0x0);
+	dw_pcie_writel_dbi2(dw, PCI_BASE_ADDRESS_1, 0x0);
---

I also mentioned about this on the cover-letter like below, but it may be d=
ifficult
to understand. I'm sorry about lack explanation... I should have explained =
one sentence
about that...

>> - Add specific-setting by using dbi2 again in the patch 12/15.
>> - Modify commend of the specific-setting in the patch 12/15. Serge sugge=
sted
>>   this on v23 but I missed to modify this on v24.

> The previous commit log said host mode didn't work:
>=20
>   PCI: dwc: Disable two BARs to avoid unnecessary memory assignment
>=20
>   According to the section 3.5.7.2 "RC Mode" in DWC PCIe Dual Mode
>   Rev.5.20a, we should disable two BARs to avoid unnecessary memory
>   assignment during device enumeration. Otherwise, Renesas R-Car Gen4
>   PCIe controllers cannot work correctly in host mode.
>=20
> (from https://lore.kernel.org/all/20231011071423.249458-9-yoshihiro.shimo=
da.uh@renesas.com/)
>=20
> I don't think we want to merge the driver unless it actually works.

I understood it.

Best regards,
Yoshihiro Shimoda

> Bjorn
