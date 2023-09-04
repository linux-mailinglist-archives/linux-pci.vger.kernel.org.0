Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8102579179C
	for <lists+linux-pci@lfdr.de>; Mon,  4 Sep 2023 14:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345281AbjIDMyh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Sep 2023 08:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239018AbjIDMyg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Sep 2023 08:54:36 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2113.outbound.protection.outlook.com [40.107.113.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9CC189;
        Mon,  4 Sep 2023 05:54:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7W9qlYYwghc3y0rtK7RUu/ns+bhOLMA3h19b+If4ugRgagOkxPt+pBlGqeoceEcuzLwpRcamNPcv7uLFH1MeJw0w21+eHgy1uNS/A2oLVF5z9Vt1cXODGcrgpqjuexZzu0wQRPLtpqutWsimOpM4ie0SGHJVwT+Kd+INwe4vmtkxXlQJBLx2xrmxMEUW1nMdCP8AJ7gF3eYGC3yG2pOBBlufl5xjKSMDljXaK8v3aF+cqrlIgg1AOR5S4/aWrha+XqjH3OkZh+8OsEGAP6TtbL/wfvPA6yF1li2a+BpntHeGSC1c/u6OEl/+xSJrJdaeit6bZrWuuwjRsy2V4GOkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XadpBjixzeRNBbnKGaT3HwdzfK9ZzwmAb5itPm1FZ7s=;
 b=h3DpAs6sEz+kgBq0l1HFkNBV1BGZpUzXJ0zi4xqyyQiugKAZRZ2AW6xS6ydabokFa3C/COYNWSnHgCZc9ztFSrHVJJXhGTsQqCGSga9Jb2C9iBSMDxqaPgrR4AbNRsM/WakSelhcJXu4XsZd7YUSPn72HUoUrQIRx2fGOLsLoq8Svc1JUadksgCAIZ4z7K7jtIPQ3qBw6E4CisYDzwL/1mQdMV90voJT/iFuBrgiX6Qb5zzOSJyDbL8QYaLBULT2cdhtXAsrnQ94YB8Yo8LLHb7eQIFOuySgRRVLYTc/rPiwRNJf7MQgyFI5J2DGbZsgiBBwGG2VR59E2cRUJk4sHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XadpBjixzeRNBbnKGaT3HwdzfK9ZzwmAb5itPm1FZ7s=;
 b=QmFmHOTia4XzxpCifEnwbmYv+c0BC2hkNN1XcUSAg/b1e6WzcIUuYVM4GHD3sYbfesaPLnQithkepsr4tEtvBa0ZS86+PkmO7jMV5af7IZUVufQsO9DOaG6sZuTlJ+fDJPvU5Wm6xBmq+oDbGAL6wpYNplpOArWYHgKlndZZQ4k=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OS3PR01MB5942.jpnprd01.prod.outlook.com
 (2603:1096:604:c1::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Mon, 4 Sep
 2023 12:54:28 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30%4]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 12:54:28 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Conor Dooley <conor@kernel.org>
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
Subject: RE: [PATCH 0/3] dt-bindings: PCI: Revise dwc and rcar-gen4-pcie
Thread-Topic: [PATCH 0/3] dt-bindings: PCI: Revise dwc and rcar-gen4-pcie
Thread-Index: AQHZ3Naplycjp7NP70OsPUeoiqAJOLAGHzUAgASEgrA=
Date:   Mon, 4 Sep 2023 12:54:28 +0000
Message-ID: <TYBPR01MB5341C44AA9A78270C9097815D8E9A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230901131711.2861283-1-yoshihiro.shimoda.uh@renesas.com>
 <20230901-squeak-pacifism-00639bfab28a@spud>
In-Reply-To: <20230901-squeak-pacifism-00639bfab28a@spud>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|OS3PR01MB5942:EE_
x-ms-office365-filtering-correlation-id: 6f0e4de6-5f05-4c34-a1f2-08dbad461371
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n064l/BxR+6UH5TkoywWg8vrYyhSLyJhpJbWhsSYHBZuzfcrLv2CDYxcxeKFUmYtfxiML6scfRDtcUKkJ+lmv//2k+el/DlditrYpMiDVkbWag/N1YBCa1dPQP4rlcZ7n3FqB3xwUYmKxC+VHiYbshoaSePWOpOqu4iYEGylbdH/9Cp8AsDxD8Io6YWnUVrEuO9G1Wed295TPSPlDj3zDQjtRmGPyuCSd67q4D0RQRzncEtnW/64fJVdYvDS6+xpDaS49JrE5VWnCu62yubfytOGi4qgRjUriVrmrc8cCnaCAnmmaeCFKeDqBmXbk3wSPrv8XWbXXqHbKSJ15Jm7CY1w1VDm053TYqJdmNQzjkYSKNZqOroBwEHcrKxj+/oUXQooc9jdoHA7vD3em6JqHYCqJl1Re7sGQgjC5MJkpJ+fyGJlKjwQodZhM6Gq2KsPeEHymd3OO+Y31b00QSkDCIFuUovlWENMjpviCAVRCFMvm0b+way3ypFJse5buuGywQJAHure4UVQfaAIWv5pbUe0w/SAB4RxC1SMQwrOLNdgVItH+gM4mcq+5mNLukmgwl/jVUdZUzxJs9UfcKVRJ8o2wZ/SZZHyDXALtEc6HiA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(39860400002)(366004)(186009)(1800799009)(451199024)(6506007)(7696005)(9686003)(66899024)(38100700002)(38070700005)(122000001)(33656002)(86362001)(83380400001)(55016003)(966005)(7416002)(8936002)(41300700001)(6916009)(52536014)(316002)(64756008)(66446008)(66556008)(66476007)(54906003)(66946007)(5660300002)(76116006)(8676002)(4326008)(2906002)(71200400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Dx3JylMI/7jxHgJKrafqt6nvhs6NbbpeIrhBVFiGnoM8g6wfkTmqT9d4/Wwi?=
 =?us-ascii?Q?30zPxZbC/NTXSTGC1M2mHDvaro50V6A/T6SyZtKPjQDpQygTDYA4E7aTDhSm?=
 =?us-ascii?Q?CNzzFvnxhy1/GSS9PMyc7ESk4NjsnbhSbn/hl4rUl6DfN7DW/F1SiEwSuopR?=
 =?us-ascii?Q?Y0q0zWIpT4qGJ8fLOQm5GbWGb5smRVDZ7OIfyWtSlag18nt/e7PKP+W6QNpF?=
 =?us-ascii?Q?d+gTu6i5fPq2Uz98jqSlEr0Y1yeAXcZWr2rDa/rdxviUIg5FpplPX+2Q3ERI?=
 =?us-ascii?Q?Yy4o+q3Mh7Q4Dd0qsaQofxpcBIoJw+b/VrDXdsD+nO+D9BhDV4OhEgMRF/dS?=
 =?us-ascii?Q?FoHGPD1Y88rMz8eb6bg+wr2VQMte6Md7k53xleadW20wIUGnZqmcUxzWAoWV?=
 =?us-ascii?Q?Hpn9yhqnCC4eFhQ3gUwRCyCnkirWGDofcrHvcbub55qrt86+VjD0w4jw9xcl?=
 =?us-ascii?Q?fveT9EfBCWMnfXbDk6wYbbXK2Xjvxzca4drLwB7ODUsrO9XhjKiyV0XEsbDG?=
 =?us-ascii?Q?2DE4e5eXcdQ0mhCTyrYrmp0yNP8+g4eUgqoZyxFi72FnumWYNOBTULQMCW6R?=
 =?us-ascii?Q?W2aRBUwb+w0zmC8R9Ftx8JJPjwzZ5g4AoSo1NHoWnGZ0197Bft4+EXhQCIa6?=
 =?us-ascii?Q?7uZ8LbzQ2HIxKOLOdWXyRIcl69UZjDwnlA1u97JNDt1HWDPvZzwgRwZq4Llt?=
 =?us-ascii?Q?sO98LtD/IiCFor3otYRlEVVTnB//v2Z2pd6PDq85TrCFbaE3RlpfRHU66j68?=
 =?us-ascii?Q?agtk+yw7Qo0bBEy+O5s4i0SJVTjVO5tL4y+mvlBEOfPCvjsh58jqm1bEfmsy?=
 =?us-ascii?Q?qE0l/Qy273ng9uTHkfpyC0Bg5tmvDYs7S1GDv8RseHI9mf7ERBAIW/ngWZY5?=
 =?us-ascii?Q?qXkbaJlCcb/yDCAj1yrqX4YZniBYhy8tqR6F6pg0orefYutw8o7TJjV2h6z3?=
 =?us-ascii?Q?0FDPwuDxUP74uojJM/9mtKPuYxe7bph3i+LDDjLUM2vZsaIKJDkmXw18gJgo?=
 =?us-ascii?Q?D26+5ghVxPpK1X3qJT9kU2WNnnMRkrO8rpdpYSDbdPnhfAu9jtHe2+S5Yj8e?=
 =?us-ascii?Q?FzOl2shOE6gQttgCvfXiu6OPpff1G63/IkWtFFg2Ye/i8PfLjrE6+EekDR8E?=
 =?us-ascii?Q?FnMIYwymnPZKKKURuEn5BJq3MxSnEkgIbeO+m7bWuPyU41+AZ2wB3ruCNZIO?=
 =?us-ascii?Q?g/gpWiBwCdBUmn5LH/VljGxMPKW6ZFtgvK21ysKQJZMaQWJFynbpGoj2w0Mj?=
 =?us-ascii?Q?K86I061PKmtq9O6eG/Ai09Pso/DWYR6YamdSANgIOhW7/KZLV8bGysaoWxw3?=
 =?us-ascii?Q?fwM0rrF1nXwyPKwFwcTiY7GBWXjbm5pcerNHBE37FNcR9G+aEJq96BIoqJDI?=
 =?us-ascii?Q?h8qnFE6acZzacComlifE0t9+ehl7CdbOxak0y9zERR/Aw6f7Y8cmnwZ00YhB?=
 =?us-ascii?Q?UrMqJnN+bK6ynquyltKKIxt0/BbU4v02NOrweg+NaiVk8GsPNot+1Zh6gIXv?=
 =?us-ascii?Q?YBmU4qzQRdvEQ/ugmBurYgzs9whVqTrbpUtH1LOmIOjGUVLvpK0IfyzVEl+x?=
 =?us-ascii?Q?1Rc6uiI9OMdD5JtvcBJcLYqy2OV9FU91x1yJePMATZ6I7YppKoj1wUkd3eeo?=
 =?us-ascii?Q?9sjZ8FwWUGdyqsnOr9EqgD8ud1KX7ZarQK3dgjuccg0EUTX+fdQp9AU8OKzQ?=
 =?us-ascii?Q?CcGutQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0e4de6-5f05-4c34-a1f2-08dbad461371
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2023 12:54:28.8086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HEAOSVSmC5NIX+fQKeAxVoZiNUAkB6bu0CB0e9AuqLL3jsY9Ttt6nGR7i6TMXMV3Mz82FWAZRsSCOYGcTtuuYglw8KYvxpWs8ppVGMxI6PcEEQ3RGbMn+HBu6G7ytgMb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5942
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Conor,

> From: Conor Dooley, Sent: Saturday, September 2, 2023 12:53 AM
>=20
> On Fri, Sep 01, 2023 at 10:17:08PM +0900, Yoshihiro Shimoda wrote:
> > This patch series is based on pci.git / controller/rcar branch
> > to fix dt-bindings doc patches. Krzysztof mentioned that the paches
> > will be squashed everything later [1].
> >
> > [1]
> > https://lore.kernel.org/linux-pci/20230831140426.GA255922@rocinante/
>=20
> On the basis of it being squashed:
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thank you for your Acked-by!

> Otherwise, the commit messages don't offer explanation of what the
> problems are etc. "Fix minor issues of rcar-gen4-pci-ep.yaml." means
> nothing to me, for example. A link to the comments you were addressing
> would have been nice.

Thank you for your suggestion! I understood it. I'll do that if I have next=
 time.

Best regards,
Yoshihiro Shimoda

> Thanks,
> Conor.
>=20
> >
> > Yoshihiro Shimoda (3):
> >   dt-bindings: PCI: dwc: Update maxItems of reg and reg-names take 2
> >   dt-bindings: PCI: rcar-gen4-pcie: Fix minor issues
> >   dt-bindings: PCI: rcar-gen4-pcie-ep: Fix minor issues
> >
> >  .../bindings/pci/rcar-gen4-pci-ep.yaml        | 39 ++++++++++++-------
> >  .../bindings/pci/rcar-gen4-pci-host.yaml      | 36 +++++++++--------
> >  .../bindings/pci/snps,dw-pcie-common.yaml     |  4 +-
> >  .../bindings/pci/snps,dw-pcie-ep.yaml         |  4 +-
> >  .../devicetree/bindings/pci/snps,dw-pcie.yaml |  4 +-
> >  5 files changed, 50 insertions(+), 37 deletions(-)
> >
> > --
> > 2.25.1
> >
