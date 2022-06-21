Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A9F5530EB
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jun 2022 13:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349409AbiFULeY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 07:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348826AbiFULeX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 07:34:23 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB4619C0F;
        Tue, 21 Jun 2022 04:34:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKdxQ2sGiP8eqZkD050/1zMV5GRSi/5VjEYIsvRr+lFl0sdzhn0O+Ta9ou9ahyvCRp0bXYAeTq3kohu9Z5sHogvUPK4BY/yP7uftcgYjJJzXuD42+1rdE1cB421pRNj2i95OlCM7nNnY1afWBKs4MuQBouYHs2tvmgNBLvWlbistpxpOHjM+fWHomqdCQDcTssYTT6AC8lUGwc7Qx4xh9OeNXpyvjM6+fNE8qJDtcOk3RqsloliL3zUPNZ+71hXiZD/uoUXFlDsg8+VCtwzHLYM6Ui8EfZSeaYzTPVLqVNU4KU0esQE29j9gIDDeJjK+vNggRKaZR7lrHaQSUQW/TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJ4xn8X+Im0HdKxWQRJNP+zyT0H5V3FlXr+K5nlopkI=;
 b=U769VRcL/CzbmGYSHPmpMsr3Dr0Xyelw1+7l9Yk2xRVayhvy2t30nZNjsTVSRJuu4MqBkyLxvl/V9++xWpdu6cPJZdskDU4FdUuL0TyiFK+2VGL2orustyAgnDuOTu3SqcRp2tAKfX0c05dAn/5PKdZTdnlc4n9c65hg+QK+VNUDe3iSNoC8tdOA/CxoDxcI/PgGapZ1B9dgK+pzrRvocRmq4FOtugBoMPBEW5b7/tj+zSxRXhjKjxqU5hTaqUabWOaRTvXNeDjNv0fDjNX6w8eqBFRRHqf9P9NDL3gGsDeaORTaGMh3CBgq6QPkmxcnLy+oZg9hJAzo5t8NQ2hbnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJ4xn8X+Im0HdKxWQRJNP+zyT0H5V3FlXr+K5nlopkI=;
 b=pDQLT8HITgTQQWi+Y8ENNM6GuTix9Rw+oOTD+se2z8KP2CktWkCnB37V/lBn6D1WTvJFtaI+DUnIogb9s8wEzX9oXYCg8IoW7UFCoLdBFswkDyo7TsCV8h0MELgIR8MIH5NaDceROLJKd984UtlTtg8mGYnub6D8TYX0dH81JYA=
Received: from MW3PR12MB4411.namprd12.prod.outlook.com (2603:10b6:303:5e::24)
 by CY4PR1201MB0101.namprd12.prod.outlook.com (2603:10b6:910:1c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.20; Tue, 21 Jun
 2022 11:34:19 +0000
Received: from MW3PR12MB4411.namprd12.prod.outlook.com
 ([fe80::5913:7dab:a686:710b]) by MW3PR12MB4411.namprd12.prod.outlook.com
 ([fe80::5913:7dab:a686:710b%6]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 11:34:19 +0000
From:   "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
To:     Rob Herring <robh@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michals@xilinx.com" <michals@xilinx.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v5 1/2] dt-bindings: PCI: xilinx-cpm: Add Versal CPM5 Root
 Port
Thread-Topic: [PATCH v5 1/2] dt-bindings: PCI: xilinx-cpm: Add Versal CPM5
 Root Port
Thread-Index: AQHYgr1xBTQAv+aYmUiDtlSDWh1jh61W/DOAgALDyyA=
Date:   Tue, 21 Jun 2022 11:34:19 +0000
Message-ID: <MW3PR12MB4411E3A3A8BD74191AC7754EBAB39@MW3PR12MB4411.namprd12.prod.outlook.com>
References: <20220618024459.7554-1-bharat.kumar.gogada@xilinx.com>
 <20220618024459.7554-2-bharat.kumar.gogada@xilinx.com>
 <1655659215.212817.1922479.nullmailer@robh.at.kernel.org>
In-Reply-To: <1655659215.212817.1922479.nullmailer@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd6cbd08-c24e-445f-b3d0-08da5379fb1e
x-ms-traffictypediagnostic: CY4PR1201MB0101:EE_
x-microsoft-antispam-prvs: <CY4PR1201MB010120766D22A7ED08911782BAB39@CY4PR1201MB0101.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PDoo6px/H3Dw3vXyJJo7BwB353plJ6U8kGAzQtSEXtmISlKFz08BGxAhY/K1kaUT/M3Kyj+jrzGr3YYgHGYceayzcI1qbva2CpSvJAM1VWI4uf4vS5FR77Bqr1483CeyX3VJtR5xGdZxj/Dr6Ji9qhnRbI3Cq6pO+OVqEp9+MhvovTXoJkyrp5RwaIjmniZMeAJfVyqCnTlhsCCB8TPf5mVeD4+Vm8F/4tQzxoRacQwG42/OV8o1V9N63b1DyA2aTIlI3BiFe/XrGRYHH/0EB5OIwAPlwsGyseYQm8/5To4sd4BANuZz0bQPNO8wZgsWMLArcZjkbSe2Kk+rtlgvS5adYKLtgJVSqKlnsnKqWQ+be2SYOBne8mlbRVOZMPK085gg4hV7yvlR90J/JKyHuImoc3snjG1zbQ4SQ5Z6AZ6+07v6zGxDG5YY5reOg7rTflIOB59/iXvUW+eiEUw0Y1H3eg+MQe7uIthVu+vY5dLggA/VDMpUx710Mo2RAfjdNV0fpQhTEzlTDKpEUxdxWsy00ZRXN8Jtm47Dq/NPLX7bgGVOw2kTPQvCxkXULm9WipPjobjVh2no+r/iYNrdMIpktLPN4liePmoY0tkLweNQ+4kWrLhfXpk6vdLiUZyD56VPN24tlDQzQdKd65T5sQUN8AErVi0ALDI5MHs7QXr9RVUuD/PsmcoZD/+Sagi18jhTAPK0MzCbz1kTmyXlTpULFJ9fQjgxkk2pMy+lsggSUYrmoeiBXyMFmPnV2fi0p2jbacof+IHXBUbBBf8tb5wDPKZzbX5a6qj6ZZoJfcY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(66946007)(66556008)(55016003)(8936002)(66476007)(8676002)(478600001)(64756008)(122000001)(66446008)(4326008)(76116006)(86362001)(316002)(54906003)(110136005)(41300700001)(186003)(5660300002)(966005)(6506007)(9686003)(33656002)(38070700005)(7696005)(52536014)(38100700002)(71200400001)(26005)(83380400001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oV9Hr4gf4EmhYzTd4+v9acVsXxhw1FIqdti9iOroY390S3iMEyKaIomhqUau?=
 =?us-ascii?Q?kCBjKx3gUTtISDqgEl/8TZ1w49fIRtTL221BmrFYw0QA1+Ap2ZQse4XqrHyf?=
 =?us-ascii?Q?MI6lywLXL078S41ux7UBAkgxKsFp5ZrRHvaz76H2mbs/gcAqmPM89zy4qbmN?=
 =?us-ascii?Q?TNZV+lzx/kTTTGLufKR6mbDaikTFAk+VWsTBjtP2hS4LM/b94zAZHz16pW4k?=
 =?us-ascii?Q?A3oSUKYFNeGhvVyvpTQthPCz4sthHQxNGbjod8cM651RptrMfS/g2UDc6orF?=
 =?us-ascii?Q?w2TQUTzIJ4ovYdcOFAri9jJaD/ZQqFuTQs39DhbOd7cZH9IvQJC3FTv+VWau?=
 =?us-ascii?Q?cXdzeHuhP3QvmE+0y+KZ2+Cl12HunnFjYOeCCTrco3Qz0PtR8/owicLpC4tQ?=
 =?us-ascii?Q?vlzuNU95T50sHe3A/A58/sab7cllubr4QLJl00q3AEPj4Bh8cEPZG817sE/X?=
 =?us-ascii?Q?GC5PXHBmZe1Jv0yyOvo+gK4ddOlVbgHnu8mN5gaZP1MmI7DKs39U9/1ifglC?=
 =?us-ascii?Q?GTMOXQMbmH2EcpJP8jS9VBY7JAiQT030GLjppUvB7CZSFwhKxMDoxZxxzqoV?=
 =?us-ascii?Q?l0ts6oLc0eEr5FQhCvuNug0Fjs00d424VEe9W6ud9eolct0/V4uR/LJm0BCt?=
 =?us-ascii?Q?hBoOWOUk7y+CLPJ1cf5pumwOw4qgJYkAYqwXfaeFRr6BGSlZocFTO+t4+cHN?=
 =?us-ascii?Q?8CagaSH3s2hD5cWMSApgnpYPn2VBhMu+lkRSaGznPJrOAAsuTZqv7lP4WdFr?=
 =?us-ascii?Q?mQxS+j+IWs0wtg5v56AGgMZSttf93fR0G512vZLr/fjbCVp5GnO8mMEteoU7?=
 =?us-ascii?Q?kPu2Fv3TgsBeWxygJEZkO7LjXdEdRt0+HTi5ZQCDeLO+G9pv9sulLlQdapex?=
 =?us-ascii?Q?O9Jv4oIh6/G1Xf0HwdISAOHzuoIU1ngDKpxdRLc3N2aChbmcNdEkOSXZbqph?=
 =?us-ascii?Q?dK4wk8LYyyod+K+eAEv0W9eLhZ8Ll3Q1iIC+xZTwmm81ynr3PFNXDBGCsV2j?=
 =?us-ascii?Q?jRj3duNqJdfuZYiXGWsbwHu66kKKygFGW1CWTLLOrOzeInTMbW0mNLFwabW1?=
 =?us-ascii?Q?xVp90rGFQGoDDC8Hw43iRR3DehCysygaE9rkho2RSSJBfDjiMzQ0cAEkKTrB?=
 =?us-ascii?Q?QgKAnf50K/fSJd6WSVjIrSusgNUQRHY58yuWeOCG95JiIeB2i4kUVqa8pfvr?=
 =?us-ascii?Q?Cvtx6Qu3C1e/sWmZBUxglV1uRXMcSJcgScee7QpuBbb/YkcSldWFRyMLq076?=
 =?us-ascii?Q?R10SHvAiTp9YBvUZAX4xBel91f2bHh8Bqn8gQNmN6L0EO/vc1cExhJStoAL4?=
 =?us-ascii?Q?O9baMdOeR7CFbtia4UR013ut6B8QTIfw1TSIGUpPmA/IeCYKQk3lph0Bd4nF?=
 =?us-ascii?Q?zNyJuEpB9fr5pFXqCsXLrc/w6mXKfHWd0bFgCbSYQSjW7/1LyOyCcY8LLbgL?=
 =?us-ascii?Q?U/IAsOpf08OVmFysT1K7BYP++MmDUV03KH1zaz8W0vnCq12T6TWD1wcnFr+R?=
 =?us-ascii?Q?py34lJDevrSIjmwLgtejI/KaK+p0Q2eYo2W9bPBrzr2q/L8/Qc/yfNVNC280?=
 =?us-ascii?Q?78I9BbuyasiPhsN8i8esBaySnVwyhUN1fzRyA2xsjwr99rIZ1AVFjikuHAUe?=
 =?us-ascii?Q?2RMzBiIWte3DbiyQlA7YHXiNJUsO8F8gB9owZFS5F6qz5TN6dibaih0JQXcA?=
 =?us-ascii?Q?Hv7AI/3Yn6o+BDm2AQ4jBrB+9Vp7NQkyESCMWEhJu7wayl0gAtwfLCe7TUCM?=
 =?us-ascii?Q?lmZI8J9HSQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6cbd08-c24e-445f-b3d0-08da5379fb1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 11:34:19.5119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o+HrN/eHxAKRaEXK6DYO0OiiwZlgEAJpqp3s9p2DhHYEaTsaQVJkMnp/QA2NjVHUAj4dnlJDXm4j2+OdXa0clA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0101
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> On Sat, 18 Jun 2022 08:14:58 +0530, Bharat Kumar Gogada wrote:
> > Xilinx Versal Premium series has CPM5 block which supports Root Port
> > functionality at Gen5 speed.
> >
> > Add support for YAML schemas documentation for Versal CPM5 Root Port
> driver.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > ---
> >  .../bindings/pci/xilinx-versal-cpm.yaml       | 38 ++++++++++++++++++-
> >  1 file changed, 37 insertions(+), 1 deletion(-)
> >
>=20
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m
> dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>=20
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml:17:7:
> [warning] wrong indentation: expected 4 but found 6 (indentation)
>=20
> dtschema/dtc warnings/errors:
>=20
> doc reference errors (make refcheckdocs):
>=20
> See https://patchwork.ozlabs.org/patch/
>=20
> This check can fail if there are any dependencies. The base for a patch s=
eries
> is generally the most recent rc1.
>=20
> If you already ran 'make dt_binding_check' and didn't see the above error=
(s),
> then make sure 'yamllint' is installed and dt-schema is up to
> date:
>=20
> pip3 install dtschema --upgrade
>=20
> Please check and re-submit.
Hi Rob, will check and re submit.

Regards,
Bharat
