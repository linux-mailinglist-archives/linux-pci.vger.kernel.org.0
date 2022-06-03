Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D9F53C3D5
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jun 2022 06:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236629AbiFCEwY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jun 2022 00:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiFCEwX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jun 2022 00:52:23 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0325FE6;
        Thu,  2 Jun 2022 21:52:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXE7acPOVuk5UASA7pAJUqM8fKuAXCxU5sV8AhIjz1kgRdL1EwT66FUIQ1GWnmOEbSV3Xu+JED00EfKF8Q0lsCkLS5aInF72sKL1g8IJWr/s8Rn3QpJtVzZuZV2Nr5hXxjCYf+4MpeX1VE6mHm25fxvqfp42OatydmkMASvnUR5q188axJ3Gk2QNRc3oUXVAXFkZcf7H8UB+EbUpjVnku81k084oT3Ak3f/1qiPvwAWJIC1XsMx8pPDrFSy7r9woVYcQWufcDhRbbx7OcCwrivFL04cZTmzddoe69hgi9atUg24ji3JTfk3PdRMNu0RK1jwJ4fI+5tcb3Um3Jpfmcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfUvMhtO0l/xKs8aLnolKCumRTYenWoEJhUY0YQCh0Y=;
 b=lY3iH8u8K9xQE6k7OHQPUEx+3SU4UFNb8XPZl7J5cOoikKt7XqM0tajyaCVCrVcqKaa4qy0FrAGBbCOM4IpED32kIMEAmPcyD3GHLjLKZb4c6cUgGIrIi4DHvSZbuhVd77ppvqFI19+YRTZeTH84ZxMQ6oY4TFUuzmoNIwwfzci+Kx4naRGDIYGKv3PBYU8Z9DwcHgMnIOA7/8EVQ2511cYOpz8/jZ8gnYlBkHa4cEw54agT26jz95jmQ+F6xRKYW70BdQ/h0y10TfLd8j+8P7KYcNmhMsFWM9ODzu4GgeyW7ds7G+/c0c+tZO/7qnZ3Dv7FO0YOZ+9N0ZX9KrE4PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfUvMhtO0l/xKs8aLnolKCumRTYenWoEJhUY0YQCh0Y=;
 b=NCZcDJxML0+notMRb6+OOjCPWjK8G7hrCL4nFtEI1S4bC0X8UDyzJeXqTpFJtpUZD7g6M0QXab4jV8c21OMdokrh1Oq1Zw9PEyMvqrEAJzvI/MYk+AtONfpevDeFYfh6LXYqx98DRupFcduEhqXI4WEuruSHsAVlGqQJvUILAP4=
Received: from BY5PR02MB6947.namprd02.prod.outlook.com (2603:10b6:a03:23e::12)
 by BL3PR02MB8233.namprd02.prod.outlook.com (2603:10b6:208:340::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Fri, 3 Jun
 2022 04:52:18 +0000
Received: from BY5PR02MB6947.namprd02.prod.outlook.com
 ([fe80::70fe:1953:96d4:dd88]) by BY5PR02MB6947.namprd02.prod.outlook.com
 ([fe80::70fe:1953:96d4:dd88%9]) with mapi id 15.20.5314.015; Fri, 3 Jun 2022
 04:52:18 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2] dt-bindings: PCI: xilinx-cpm: Fix reg property order
Thread-Topic: [PATCH v2] dt-bindings: PCI: xilinx-cpm: Fix reg property order
Thread-Index: AQHYaQ7VIq93UpHHX0WumtBeKR0BEK07EPGAgAIoNNA=
Date:   Fri, 3 Jun 2022 04:52:18 +0000
Message-ID: <BY5PR02MB69471153D6BBAC2197A7AFD6A5A19@BY5PR02MB6947.namprd02.prod.outlook.com>
References: <20220516102217.25960-1-bharat.kumar.gogada@xilinx.com>
 <20220601195523.GA328031-robh@kernel.org>
In-Reply-To: <20220601195523.GA328031-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27bd5677-4281-43cd-39ab-08da451cd688
x-ms-traffictypediagnostic: BL3PR02MB8233:EE_
x-microsoft-antispam-prvs: <BL3PR02MB8233CB0A81E5B3B1BF81E68DA5A19@BL3PR02MB8233.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P0yMd6wqP9UyZWDuksVDwMC8KQVrRmygdrjqB9NjJSf7KuAWbcz35glWuFjClVZ+/pj6M8miJlETFhknDeBeLh9acpKdvPkdTUIMCr8HxiNhYUzW4d57duTmfgu8n19Sh6aCKZ+Js/322nWhREZOOIEvaENIvrxhMzSsz5d2wRQNC9gzNQB8tUTjIl7Ga/iOutSxu+fI3riiIfceRD3JDGsqEwC004/lnocbtbrH2r0s2jRxvSntvbNhAPhI77BXUART98QfTRnVrf2Pj0WrOU8zVlySnUuhAu8ZdGgcnid65jvJyMHEV6uPugFULvsZUWHHrVSr/iXrADpS0/QaBLKd8EiAE3uzG/oidHC2Ee/vz1BtiZ0W+63NWOJ74LGr1IehPZtqVL63dXpHTjNTAHyeaWOPYwq6yjGjnQgBvZvKWwSuBs+3RzM2jQvX87Q8CHa5Pz1BLudeVEsFN4J244bqNxhhMPrclFrVvuV2wntkfzk8YBSMXDXazkkMG+XFx3xaQiyZndDkmqmRvUzCZifrYNEtD2sOnUuNwRLWsHKeo2Z7bb/3ucBXnBu7DT3EquPoRPKh9jDPyzX++m6jHldSPrcciMFo0WtCZdHI8BYWyvxjuEn0sMf5QfKlUpTuryQd2u/1oP2jT/+GhdF6cYibm8D0P2/fVfMdImB4H/pBribXp94n57tsvCcRBDoHKrUPx6t2MavzZ7P+vRxwFg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6947.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(186003)(66446008)(71200400001)(7696005)(316002)(55016003)(26005)(6506007)(6916009)(9686003)(54906003)(66946007)(76116006)(4326008)(8676002)(86362001)(64756008)(66556008)(66476007)(2906002)(38100700002)(5660300002)(8936002)(83380400001)(122000001)(33656002)(52536014)(38070700005)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fy1PaYKvEDHjUT8+PxisGZd1igFKPweaE8GPjgEoC5G7Tem6d+3m1SCT26EL?=
 =?us-ascii?Q?4ApIarN5qBddOJB78veQ85INmScaM05RWWt8OM5NIY7AkUGhGZHYeqjwC1kN?=
 =?us-ascii?Q?ufPn067BkyNxOLWuwYretUPpYJTBmSOLSyJXy+NNsWiGbOFw2NuArRIp8QdF?=
 =?us-ascii?Q?2q8BAZOx2jwMh1+e0VM6sZGqPMdN/ocpXc8SaL8oRgI9zAIn7OI/H+9iQCW2?=
 =?us-ascii?Q?qtbpHZLPSnC8BUCSbeziqY1DiwS0WYsR2+5GZvODRUtKX0mV3MfnXI1aoGJ5?=
 =?us-ascii?Q?6Z5JGxQFGa8V6Oo3SHsNhgKKgLOX5G7pgV5jZTnQ9IRkXE49GV25CBh1vUh7?=
 =?us-ascii?Q?2KKdx8F4kVyl2W5GSq4OYdO50/7iL0DVkFir5dL1mVVmVr9d9uf2lphLVWsD?=
 =?us-ascii?Q?X8C8LcYmxNH/M9AoUeMqkv4tT4xCF9UmQq2NSX6gPR7BqyAUK2p/3fRooj7t?=
 =?us-ascii?Q?f/3CuHtrpidKnKnSYobidVxY0JSo/jg4I37NV0TUfVgCWsMXnGamJpnIrd42?=
 =?us-ascii?Q?bdKPtAiuPb4Vd0xapqdOeLmz9erTIbbrBtjKEGFy4GArUozh926TK0zvs2Un?=
 =?us-ascii?Q?czsK2wvLFnZjrU2E1YzxO11m9aHN7u4wv5m4kGL39K7nRQbXbQJJ8BZKXbyl?=
 =?us-ascii?Q?9E4syJ+G+EPdorD14EvNKU5bBIIQHJELKRwhYGpOw0o8+YBo/yPUyHOthnzh?=
 =?us-ascii?Q?UfBE5/MUzyLkhAAEap42uy5glYWuP6cf/ry012LC7iq51KaK27E3sLgz9GoS?=
 =?us-ascii?Q?VB1hwwYzXENVXwslez079RLqB1U6Jz3U9ggf+hBrzqOczGUA+axrk1LhofeM?=
 =?us-ascii?Q?RhKV1rmMmKKGFUsl2E+HSa9vS1vLo3+ZZSLxNgu2733siDEhushzHAWMKgjJ?=
 =?us-ascii?Q?wleYD+ZfJ+vmmzSml9SES602Sd8t/UN11c07anw6v+2VT1/aZGPeXbBsJ4Fg?=
 =?us-ascii?Q?DEqOPm567w7jSuzxfeEFbdYbDHaLri1qZi5M0aiJA0kHnzZggljGCalGPsET?=
 =?us-ascii?Q?8v2dvxV1RtcZqs74M0Yzt7Lx9CkVARARbNSmxUIE8FXpws9cCojC5SlkqTAM?=
 =?us-ascii?Q?kukNxOgIQHO77Mauq250WCa0QHW5hU5zoY65jWbkRC9t27mx0+O0R5V8p9MS?=
 =?us-ascii?Q?skV/IDVJVGhbeKIjZpTjjoWkHiBJVOp0tC1PO81c2VTrcJCoVKLnzVuHmak3?=
 =?us-ascii?Q?T1Br1Gzpq0SjFYkxm4dUDXJTGtQ42m2lOoyegOBw3+9Hz7Je4XcmhOupe8Dn?=
 =?us-ascii?Q?07vsiwbiO7zcrZc989re757qZBVB0uc6FKCd2UwlbKBJyF5AtpZW0WGNEdR7?=
 =?us-ascii?Q?GlicyDQvF2/yNImYjuPfskmQ3T5EHV87gsLuDXHSTdbNPu2NA5gsnIkBfNfE?=
 =?us-ascii?Q?ihlc/qkZuiGHOg0bvvXqWuOYLPCE7YrGzKNjsbLFylRXE+Jp1yGh5IfMNXOf?=
 =?us-ascii?Q?5oIBTN/9+7mXliN7j7wtSA1O9KSILoLNBnhAMe0QES7A4XM9nz2wwHfpl1Ch?=
 =?us-ascii?Q?Mir59HsuuoopzwOiF3IxAmo9t+zjrwjqF2gCHW+jeooU0OL9K5QKKEcxGMdo?=
 =?us-ascii?Q?IhWGm+RkP+mg8K6uNFGcDw2VxA7vFCZg/HiwhJT9j+qkZ66cBjHEz3YcAR1Q?=
 =?us-ascii?Q?4NpuXLvHv3Hr6HJtpihToflF14fIYVb95c5eOCtR9z853Udwz+vHh0CYLMUh?=
 =?us-ascii?Q?rMDlMDj+APIRZD6Yc80+AcasJ/ppJE8T2cuZVUfYbQAEUon82NVyUFiknGxM?=
 =?us-ascii?Q?+p5v46lKoA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6947.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27bd5677-4281-43cd-39ab-08da451cd688
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2022 04:52:18.6374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EfGyxO8P3HKzacgWSmIXBa/46cWShd1Mucnokqs32RmROJeQyGKT0YOTIXNFIsD3ls7+ZFb8cTUU3dfEWSmBcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8233
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Subject: Re: [PATCH v2] dt-bindings: PCI: xilinx-cpm: Fix reg property or=
der
>=20
> On Mon, 16 May 2022 15:52:17 +0530, Bharat Kumar Gogada wrote:
> > All existing vendor DTSes are using "cpm_slcr" reg followed by "cfg" re=
g.
> >
> > This order is also suggested by node name which is pcie@fca10000 which
> > suggests that cpm_slcr register should be the first.
> >
> > Driver itself is using devm_platform_ioremap_resource_byname() for
> > both names that's why there is no functional change even on
> > description which are using current order.
> >
> > But still prefer to change order to cover currently used description.
> > Fixes: e22fadb1d014 ("PCI: xilinx-cpm: Add YAML schemas for Versal CPM
> > Root Port")
> >
> > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > ---
> >  .../devicetree/bindings/pci/xilinx-versal-cpm.yaml     | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
>=20
> Applied, thanks!

Thanks Rob.
