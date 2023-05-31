Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD10C717760
	for <lists+linux-pci@lfdr.de>; Wed, 31 May 2023 08:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjEaG7y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 May 2023 02:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234363AbjEaG7v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 May 2023 02:59:51 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A416A8F;
        Tue, 30 May 2023 23:59:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUsP/2KDZQLtgmc8EhvAWL3cT5NTEce0sldC31PwARE2By5NuZPvwQ1s4ijuXA567YaXXgHee5CIJzlbQ/Agb4s6C8iLtgrT4k6HlF8dlM3fYE7yFpM4RbAL981PKIqgPsd7PXSq+XAOaqblo0oKhCzlmAxcTXbqZCJ0wiZ60UmHgdXwFSDC3UHfWWToDVcEP6u/jLpAefo86cvi/dhOIzom6KZ0KaN9fJb+NUAeberlRou0CpkSk4opCJizKVR4s9Yv0yNKkQBUCB+gXxG/UbvX2WewH8hFbH6hHYsYVBOgqGawVCkf44GKQY6YA25g74JYY1qET7IuaoTH+0LyKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNbFtgaER4SXBNVmEtjF+mOJXxR4mFLrD+KZYETKCZw=;
 b=ldRdHmeZ5TvB2fSY77hSo/qIJB0tE0SmbTRXGaEDCMHIrV3PJZj+viQiaUWMeMwukvDzErFHz4FGMSkN+CBJH3fVPYKwuRJhhtXQLrfbZ9kzJnzQgBI5GhOx6ZvGXDIEyjiv7Um/gk63k5na4z7NbFK7e2N90TwYN5xWxgi76R85fSQlTZzwg/1L9TbA0hZOp5nqgma7mg/K6ych4Iyrt46YbOJ8hF1kos3A6GHADt8MIWWjlMaOsma45NDi7B6GizPkUGqTyv8VVlIl4LBdl2/jRxyzwb5fFQl1Epf431bwN+zbS6KLW5czI4i1wXwmpESwcEPxBZ7GqxM5iPOF2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNbFtgaER4SXBNVmEtjF+mOJXxR4mFLrD+KZYETKCZw=;
 b=zD9HwtQNhJxRs6As7Ray49Ler8CRF8OOboghswHwUVNWagU+X+qlpuEbqaosCnBjrCty64CKaxW3uc/14Hpw0+SfdNFGsB9xAy1yzYn7y2E99HugOd9CCJHuhO/dsB32dpwPjOswJItuoY1069mrWSjLfurzDM/yNIV1TP3bN9E=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by PH7PR12MB7282.namprd12.prod.outlook.com (2603:10b6:510:209::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Wed, 31 May
 2023 06:59:48 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::d31e:12f8:bbac:31b1]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::d31e:12f8:bbac:31b1%7]) with mapi id 15.20.6433.024; Wed, 31 May 2023
 06:59:47 +0000
From:   "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To:     Conor Dooley <conor@kernel.org>
CC:     "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Yeleswarapu, Nagaradhesh" <nagaradhesh.yeleswarapu@amd.com>
Subject: RE: [PATCH v3 2/3] dt-bindings: PCI: xilinx-xdma: Add YAML schemas
 for Xilinx XDMA PCIe Root Port Bridge
Thread-Topic: [PATCH v3 2/3] dt-bindings: PCI: xilinx-xdma: Add YAML schemas
 for Xilinx XDMA PCIe Root Port Bridge
Thread-Index: AQHZikESjhxtvc15p0SvfrT286EYT69h94wAgBIOahA=
Date:   Wed, 31 May 2023 06:59:47 +0000
Message-ID: <SN7PR12MB720180769155197B862CB1098B489@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20230519105901.2399452-1-thippeswamy.havalige@amd.com>
 <20230519105901.2399452-3-thippeswamy.havalige@amd.com>
 <20230519-decidable-prelude-2f0d58041f02@spud>
In-Reply-To: <20230519-decidable-prelude-2f0d58041f02@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|PH7PR12MB7282:EE_
x-ms-office365-filtering-correlation-id: a18ec69a-fba6-4654-d2c9-08db61a49f48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jEnueUWbTYqf+RzyHzrsxabyBm1aL25msHdZ0fWLRbwTK/Wdk9y72Kt2e2R+rYvnYIeeIYBoy7EWSnLF8xga7dH6fCDlXTqV5f5UXFIWCwXmfZzeRnwIqIIdfBSgcEOFvgCYOZmFCemfLYZVLHOLytFfLUkq70v5IhIit5FnL5pcZ9FrXh7VdNMQ0rktuFwXZs9eMf8Q51AaFBjerEWtyFqpXQBfVWvTvMFOryH+pfAVo2POMVk8tWRzLYKWkw+5AXGWOc2zcaerhXrlaulq/9dvVFEdFgJhFXlyHzKInESsgZ+i1fxkNTX9uaz7JbsgmipKOr4vrJBB4nS4B8EFf22tNwnI8NvfB+JrK82qIVogw7JMDmss8PyCtM7O31nWgLfFPD8hOCKS4J8lGF1kYCEwrwq6N5d/n9y88r0/7x0NGP7ltMtOGx1IDN+7Gm1sFu/nsP+mzx+H6ShfMnNFXPZ6EwDMUuB72ep6hQNeTXCFsVA8OLh5Ja8SbnmffpXqkH7sdCDSXM6GtQEC+ZLe05IPygTHj2yOLezd9+7ECRYtMFAOO7kHO5RYcKmXpNNpo8wednYIwEXwZ1oM2Q7PB7GlAOWIXBj3qaEQu2QkkNq/JvjvFs/gavB7pSOfZhmh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199021)(38070700005)(33656002)(41300700001)(7696005)(186003)(316002)(9686003)(6506007)(26005)(86362001)(55016003)(5660300002)(8936002)(8676002)(52536014)(4744005)(2906002)(122000001)(38100700002)(54906003)(478600001)(6916009)(4326008)(71200400001)(66946007)(76116006)(64756008)(66446008)(66556008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?280Uhq0x0ZRopXwaBeokKYFCI3unbs4zyQYDfKMO2jmbfGngXzODY35fG3sl?=
 =?us-ascii?Q?l26EalAkkGDMM0ca7s2XqlnYJrO54qJwimczIbhExGnR4ieiYLEnFnMrTON8?=
 =?us-ascii?Q?ZNnXrvVXwGU1zCT8fwQ/h3hdne8t1Sw6eBjXt0nizeHBjFa0PuITojRkU0qH?=
 =?us-ascii?Q?N5mpqU8cNFGyzdvMIzNl97D61hfOTq/H1gWQXyejG4ODaRKx1dojp8PdHUkI?=
 =?us-ascii?Q?pW0urYoFR98wmhghu2SUnOyoisdBoV5KL/hYxO0ebbdixABc9wIf4lRs5j3j?=
 =?us-ascii?Q?3p8TaxPHPiEI+95l+SbOr7P+dwYRn8RZwaxDG1wStJ1MwXPEtY0LxgDyVHWv?=
 =?us-ascii?Q?bmVo2EUUMZTF89M014MNCGNAXzgs1j1MwQKahEhdVM7EhjneGCBejz9MMzvE?=
 =?us-ascii?Q?8NzZdIBlGb56hxlYba5eO+vjFCJz8xz9vtUyF3cerwOLG78DUdTRyH131iEg?=
 =?us-ascii?Q?KM+QtRI4Bh9bicI0y1gWvaKCux5mjbuoJAAkdM++lL6jOqp/FEih7sSym7Fx?=
 =?us-ascii?Q?yj3L/OX8uiQS/9eoy/335IhXlT+ICFePLtPm5flnv7JIN90aj++ZJbnFxLax?=
 =?us-ascii?Q?Eml189Efh2B3afYNOfHxAFSfJKu5waKzo0EAP6yGJxF5VzuUkBUmShDXMHYS?=
 =?us-ascii?Q?96Vj77vXTLttASwJG/F8h0BYxU8P0Tfl7sVN8GJTfH+vu2sEPfh68ML8eFB0?=
 =?us-ascii?Q?FHkFO8GFk+DvbZAfbpdjVc9PxOR/j3GjgEIWaIQyyDrGwFnn3rz3E5IJCC7i?=
 =?us-ascii?Q?ZLEvxN1hP4+zvOCW7wMjO0k09b336OhcIjxLg9Qts/XFKb9TNhdDK+hAlx7r?=
 =?us-ascii?Q?berfXmqnHuVMbo5ICkQ3QJmfhhpc6R6ewwLDtBk3kMVz9nBMr5vmfk7Y1P2R?=
 =?us-ascii?Q?cRi8Trpcx38zHp4zQ8MEnli6VLPnD3sXyW2P0uQFQtY0UOfx6R5HlbLkNF2w?=
 =?us-ascii?Q?RAEgKntAUqMpsMLASLRrZH6WvUYgGAFAdxITIYNJuhPkJCTRQh7Ui+5MnQKP?=
 =?us-ascii?Q?nBQ+hPCOgkPEWMeur3emHaxCIIRaHc3JVYPjq5sAWyfH5hkpPpUAxTnCWKD9?=
 =?us-ascii?Q?+Cl0UC1BZRgDMcZowfqbOjyRMwvUQp6I+BknKPUOiRQfS+n+c4QaPa0bq4fA?=
 =?us-ascii?Q?50hWsR6RfDKPGQim1kzhQWq1ilTgu1mi4O1Om/4XvWo3rh5R10KqBquE83Z3?=
 =?us-ascii?Q?o/3xn1HykmwqKIOk0Yj2Cz5u4HrgTfczBPJj5Sw++saaaJIOvm0uNHHsT5g3?=
 =?us-ascii?Q?XrKNI1PKX1m5dd5/NQBXrb+aTBywo7NdHmXVyzSjlzURZTHckNunbWQ9vNtK?=
 =?us-ascii?Q?P946V519E9OCUPD//1peVHsU1RFcbkhGLdn4syldWl4YQPArBNeo1KG5m7az?=
 =?us-ascii?Q?chmkFgiySTSKGOsCpzSVEX3a/XfXyzd7Px+ustlrJ8i7kdZoM6C4EWf7c0sn?=
 =?us-ascii?Q?vwScNgpl+Zv8IiTPl5MRU6FdPY9exOs/p1ab4iPp7RBupcnp9SIjprLgf1Zf?=
 =?us-ascii?Q?EqjyE+Yf1ZXDHV8kMPAGg2HOQSe2EXdXtJGCmAKbJfKN2gtkXIk6Bt7caGOG?=
 =?us-ascii?Q?yq4s8BjO9kMS1A08QdE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a18ec69a-fba6-4654-d2c9-08db61a49f48
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 06:59:47.7418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u459AGrF8zoUGBJgWJrZhYbZv/vv5kfcS5bpyL6xUkjUeq62yGk5TyfrBqxYqn/wSjIWF2E4Srj/Bpl77RJK4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7282
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Hi Conor Dooley,

Please find inline response.

Regards,
Thippeswamy H
>=20
> > +properties:
> > +  compatible:
> > +    const: xlnx,xdma-host-3.00
>=20
> Perhaps not a question for you Thippeswamy, but is there a reason for PCI
> root ports not having any soc-specific compatibles? Rob (if you see this =
when
> you're back)?
>=20
> > +                interrupt-controller ;
>=20
> Looks like you didn't see Michal's comment about the extra space.
> If you resubmit for some other reason, you should fix that in the process=
 :)
- Agreed, Will fix it in next patch.
> Cheers,
> Conor.
