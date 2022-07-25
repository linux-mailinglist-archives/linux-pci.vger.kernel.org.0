Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9914557F8DE
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jul 2022 06:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbiGYEmL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jul 2022 00:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiGYEmK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jul 2022 00:42:10 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F144EDFE3;
        Sun, 24 Jul 2022 21:42:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+1tkt/xgMZUgcVQ+b0LKXr/CHDS7yJceYs2CiaWF+SCDLm5DbO8+2+JkTjHDa2eiEz6a54qBKk8r/DW0cOrGuLkvgCQSVwkhaOswceXfVYHoZH+4K1yJHsLwTfKTL/FACIquRunhaahimeHnK35vHgPO7vVvgAvteeKo6Kz4iID2vV3TC1KjkjoiL3PMdUGUMHCKlcrLnBGMNNrV8nAvsNALMlbSrU+Tx2E3d+V2fLYaQyhh7nSxEL9nkrdx+IDg/h+4H9xKrmLC273c/h+Va3ibAUJXMUXq5hrou1hEA2astcTfpaVblfyRci9U9RS3EjO5JO+HndTCM6sUCfaMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mOkT84wdSfMomhr3gQ5jNMmuRTRno0f+BEivpKaMF8=;
 b=SoCnZkhA7+8a9x0ifSFlCF6ZoWsR3vFkbnEyXjpcTpwyGSj/t4/rhAOzRStSNVXzZm3Nji4teOyVZPZEwyZhsqAdkgAuS9nMYb7Z34eTVvmON9E8vHGcn2GmVfxDLDIUXMsSqifrHpqe4bMwSDGls8Pc1maWZrI6TABhC3gaWAhjyXPiwZze+SEJBGeUbxbHktyFgRXbXEX1bAxflCiC79nvFv2W2v76Kaj55aormFiv1UIFhrUXk6MtzRg4I2j2xgvMGBmHap+LqlYxmDggDBN5fdHQ+xMoEiucD2P+wSKfxY8DyeeXdLl/iddKxliOfGsa2cQPZu04zJZJG27EDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mOkT84wdSfMomhr3gQ5jNMmuRTRno0f+BEivpKaMF8=;
 b=K4jRimu9qz9BgQcEKVq6Cfg2aevzBogN294GaV0F1uuR6szLmzByd3IA0eb79oo1suB3EBGQOHdWw4AW0oufrRoDioju4NShV0rsRIUI2+Ppt1cuAP36HYz9axAf1aREx6uk1GvAK9y8jLY4eQJwt42G7aMDvxHkC/b9Z7+6guc=
Received: from MW3PR12MB4411.namprd12.prod.outlook.com (2603:10b6:303:5e::24)
 by CY4PR1201MB0071.namprd12.prod.outlook.com (2603:10b6:910:1f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Mon, 25 Jul
 2022 04:42:06 +0000
Received: from MW3PR12MB4411.namprd12.prod.outlook.com
 ([fe80::ac68:8cd3:1191:f639]) by MW3PR12MB4411.namprd12.prod.outlook.com
 ([fe80::ac68:8cd3:1191:f639%9]) with mapi id 15.20.5458.019; Mon, 25 Jul 2022
 04:42:06 +0000
From:   "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "michals@xilinx.com" <michals@xilinx.com>
Subject: RE: [PATCH] MAINTAINERS: Add Xilinx Versal CPM Root Port maintainers
Thread-Topic: [PATCH] MAINTAINERS: Add Xilinx Versal CPM Root Port maintainers
Thread-Index: AQHYgtMikIqnNwLe1kep57k5GJqCGq2K+8oAgAPATiA=
Date:   Mon, 25 Jul 2022 04:42:06 +0000
Message-ID: <MW3PR12MB4411127938BC5C09ED2AE5D1BA959@MW3PR12MB4411.namprd12.prod.outlook.com>
References: <20220618052022.10388-1-bharat.kumar.gogada@xilinx.com>
 <20220722192454.GA1923798@bhelgaas>
In-Reply-To: <20220722192454.GA1923798@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3bb5d49-7959-41f7-ac5e-08da6df80746
x-ms-traffictypediagnostic: CY4PR1201MB0071:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3QrWbhx4EVV+HVXU4jHJFASxGydjDx5MS+8JIqQY7NN3PtM4hQLFE7O9crN/PiZKbajs8akPmVOtHcZmeGxPVU3busQ/cKYq0C456/lcyXTBixWlqIZrpi3Z5eXRba6KtxZpic9bk06rJ9HEfsaypxjANk8S5+O3alzz7G6UFzf3JzRe0iRSM/wPPz6tOAn+xicmWBwHJNNYyRoxUiQu1wo+U9FPHPg+UnebnXjGoARPVVpr7qDc5jzwSw2obnZsHI8eTTXWrRo4fOKQmFjKU68ryTIS+S5H0fRclNJ9NjwwjHKwNUaFRBh06z3QcM7U9wSBh8jccLWYgUXYodUOjD9Xp5EoN9wsLIrlNq195IQn7ma7QzOqOeITa4QiqDnXRDDAwdsCD5MjwNnghJ7TxEpvBjHy+UPSH+7zwwUJ4iNlMEDGup9crp5Ikwf3gk0FXkSCkyOUp68WC8nV8Izf971S6hJTrGiyYw77ujbtDav6xYR4jXAIjdXWQ+88Pgc3W/RYLHS+EgaNPHD7bA7wCjb9i5Tj2K0sbIE2kCU8dNAGx3FGZEse2qf9LE8Aa9XBfbUP/vOod2+olt9VrFeS4O//Totx6Criu35uGZhmwLTAHnbbRNMDMJfzqw+yhMfJkFmNJYuI2gNKp81Rwhii/sIEoNe5+piMlpE42KrCsUDEjwiYAdRcAAbuYk00Xd3fRX14KOprOot24cx6zvo+lJyv5Ip9FsOkexUzGp1OKKr1yRS8kh02Qy7a/PkmgrDXsnx7m7qR2GVpXe5zohcOH2faDgyjtO9dj9HzkTa6q2Wr6wn/AfhTgtoH1qqY43v8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(122000001)(186003)(55016003)(38070700005)(38100700002)(66946007)(76116006)(64756008)(4326008)(66446008)(8676002)(66556008)(316002)(66476007)(110136005)(54906003)(6506007)(7696005)(55236004)(71200400001)(33656002)(41300700001)(2906002)(86362001)(9686003)(26005)(107886003)(4744005)(5660300002)(52536014)(478600001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AB6EE8J4k/JM8Kteva8uHH2u6wJQBHvvS3oJU0tAWdIlTQQiONQjEgrHRn+X?=
 =?us-ascii?Q?Znk1R89BvLqN/QNQ0dY41cCIdFtUuRRiU4GtwfkwkbEM0T5QiPgOoBG3D4ur?=
 =?us-ascii?Q?UPbWbNOrs7BBL4Q7O/BpuFvli65qe2gsSm0WzBh1w+8nt8zxPt040xF5bWcu?=
 =?us-ascii?Q?ehSANV87of6RJhqWBD1YVslJ8yZJ6WKBxluHbmrZo86dLnPn3VoCwFTjTe22?=
 =?us-ascii?Q?vZvmZ5DAmIm55fb4HYCWoI82RZ6lkF5NRBrM9OTpQvmWEwO2DM3/D93JxEYx?=
 =?us-ascii?Q?3WGj9x5t7JGZDcMaHquPG+yPaVxpyeUDhh71kwEgCzqPGl0dPNTTvSjWGgw/?=
 =?us-ascii?Q?Pf99VYeSHOKDOH/Eo9ZdPuwLrh70IpVo2iBw63YtTcs4ck7aVxPpo5+3Quji?=
 =?us-ascii?Q?zx2N0uI2OgR5FKqeEDbSmLWvDvQFiFE8llbs1rdSB8ro0xiaNWwwv9R5+aRB?=
 =?us-ascii?Q?/U0OtIJjQxm5xv6PlXLPz6gN6MxPuWX15eF1AJL2NIyU2pLpFQLfEHdvPMh2?=
 =?us-ascii?Q?fKsBUpUFSXwBUQ5VGPICVaacPFZsB5bpE5NzGds8LWegrX6tHsFp0GDQCWyg?=
 =?us-ascii?Q?Poq0X5SWvjxJsCc3NTJE8msuvFafR4Hv1xzwMhFtZnF5+YxMb7W3eDkcu9na?=
 =?us-ascii?Q?QyF+lwLn5eaYyqbxIDKxScSZ7qGJyEE/O0q36SDKVWJVIT7hu8KEBN84w+cU?=
 =?us-ascii?Q?fUVaMeyjtnc6CsZQ1taiBJBSJ3qHQopzfZOTUWP44mlRIAcW6HjgiAad9+rJ?=
 =?us-ascii?Q?SPMaEvVv0RMvp7VQ0cCRl93ZBb0JCNXY2qihR1btv59fLu2oCgFN2AHTr7f9?=
 =?us-ascii?Q?jXO1uCwakXgCvg6/6f3lrufAkRL+oiSsHMQl+pX/9fwaHUzLY/Ea8ohCJzAg?=
 =?us-ascii?Q?C1EvqkWJ2JO8lHYbECoNtuQvWIYs0pBmv+XrnY39Mj3ha8TIPJ6ZNYmjbnEM?=
 =?us-ascii?Q?ErbUJ0hKe0zAklp125ozVa8F9akPOAbh3YBCLIL+w2P6iHRWi5kKWfTK2WKg?=
 =?us-ascii?Q?dlywpJ2OCM4jTFe+6ST729dK3hCit2yVgwFzEz8OyYLRNQafk4aTP2ZAH+I7?=
 =?us-ascii?Q?DEt8UAqCAhRe4SfZOIP+C+Sa8fakJZ5FbVy+xsVjlmzn/P29hcTB19PlQtYl?=
 =?us-ascii?Q?ZoItsQOlU9q6hwXID09vnoEIxKugkC9EK77p2Fck6upIcNDqAZLI5Vzy+cEr?=
 =?us-ascii?Q?UznYNR4De5hgAiwX9lSa/DWjAF34Yiy5NdEfvZ+aCbvQOc5sZdXh6ppkFZey?=
 =?us-ascii?Q?e2fi+D+jJ8KL5C9EUi0/VsnOKiszf1xl0ChSSAFe9XDDwdgO2wArybOF932i?=
 =?us-ascii?Q?89MRnixkchJoLaIDN6Dh0nfqyDU7PCJnpH/JBnvvxBtS5RAALs+36Vrlr4fR?=
 =?us-ascii?Q?EXYUQh7hu3JwQC13eJrnCR7qFyL13Jdju4Veo8wXXjo26+iwJESJpXY/mrwG?=
 =?us-ascii?Q?GG837p7aeC+QB/6cLRRc2VCmUaSbzc9jn8uuAi48A/2wHAu11B6mL28KE3BT?=
 =?us-ascii?Q?paMa/gyOOdHJeuaAqS9qVI7bx4AnvtpCn87PAxRfDsfzeyiTq3remCTPb/+W?=
 =?us-ascii?Q?DjqsRn4CoUxfJbgiAI4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3bb5d49-7959-41f7-ac5e-08da6df80746
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 04:42:06.7186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L9pVtGQV3FOIVWiQ3mklGlNcbIG26HChcFLKu0V9SD+E0b00FXv4tnRMIbzrzyQ9V9u7i40CEug8KA1Wo8Nt8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0071
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks Bjorn.
>=20
> On Sat, Jun 18, 2022 at 10:50:22AM +0530, Bharat Kumar Gogada wrote:
> > Add maintainer for driver and documentation of Xilinx Versal CPM Root
> > Port device.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
>=20
> Applied to pci/ctrl/xilinx-cpm for v5.20, thanks!
>=20
> > ---
> >  MAINTAINERS | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS index
> > ea3e6c914384..a07f926d7e93 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -15063,6 +15063,14 @@ L:   linux-pci@vger.kernel.org
> >  S:   Maintained
> >  F:   drivers/pci/controller/dwc/*spear*
> >
> > +PCI DRIVER FOR XILINX VERSAL CPM
> > +M:   Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
> > +M:   Michal Simek <michal.simek@amd.com>
> > +L:   linux-pci@vger.kernel.org
> > +S:   Maintained
> > +F:   Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
> > +F:   drivers/pci/controller/pcie-xilinx-cpm.c
> > +
> >  PCMCIA SUBSYSTEM
> >  M:   Dominik Brodowski <linux@dominikbrodowski.net>
> >  S:   Odd Fixes
> > --
> > 2.17.1
> >
