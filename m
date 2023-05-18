Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D99707963
	for <lists+linux-pci@lfdr.de>; Thu, 18 May 2023 06:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjERE6o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 May 2023 00:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjERE6o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 May 2023 00:58:44 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD11271C;
        Wed, 17 May 2023 21:58:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mw1F741JuGNV9Ek0lJYAZLdCyhsBruheMUrf2oj7IQbqvbj+2xSppXPuRKZLfP5UojvFD4vaojL1zVP8kqcMIofzayQeyAs1e/2vc7DsXnr3uAs4/wKPtYOAV8793rFJsdzojLn9U42Fg1du7dydejpCSSyEzwrkmIbemFpYiKpZDej5TYjCcoOc3554FPg52PLGCIi2FV0Z7yetkRbE+IPLNOmhmavCTCaz9PebJw5aQae2CkSydo2ySfQ5KHXZd2JlcnlqMbX9L8DtRm6QcUGZBhcwlwtQwQxpoAvQKctmyR4+7YwWnoofn5M3RdWz9yuv+Mystg06kHdUdEofNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOku1OpwFkMynR9HRkczYSWiOJRot9kdbGhCrqvFkXQ=;
 b=lIpSKNqnj4PWUCTD8IqnTXidS3exmjyBt2Zvi0+jmgCoS0ipqCd9zB1vJdzLSFCJ/RPHXqYwgMjq1pYpUGWYETFbn+Yrf46cCsobYLdPirW8ipvqOzg9xpOH7MvLu2MwIp3XS8KFPtCUr0M/X5SKeCpOcYLweklhooXfkBzT+kQjWgoGzb3DWWV6jNkFkrBmwBm6KqKzuPWUj+cpbqfs2b8iA1YI2yVTlzAhIh8iBfbPDH1J1Y1Gld3QRGza0HSV38WQ7AIPZk9xRgNpTb6pnGzAsH5s1c6v5itNil5iFBqt2cV+p0q043bnSn7U47lDBpRJWas+Hc+lPuaF/aY2iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOku1OpwFkMynR9HRkczYSWiOJRot9kdbGhCrqvFkXQ=;
 b=cM6RNVSSVRC0peDpx/9eh5kp4AaPP7K2Xh65z9xk1fztwcTrEcTJoOvGbZV83v7/3hCykYsHWIPWS51YurmYb2HMBV5FzDyfA/q2mftT4pKP2FIyLKd5qZT8YmXdcmwd0csKOn8bTD+rbxOEmAsE+kXz1ti3E3F3EQIcf+JdqDo=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by CY8PR12MB7681.namprd12.prod.outlook.com (2603:10b6:930:84::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 04:58:39 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::d31e:12f8:bbac:31b1]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::d31e:12f8:bbac:31b1%7]) with mapi id 15.20.6411.019; Thu, 18 May 2023
 04:58:39 +0000
From:   "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "michals@xilinx.com" <michals@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Yeleswarapu, Nagaradhesh" <nagaradhesh.yeleswarapu@amd.com>,
        "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
Subject: RE: [PATCH v2 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver
Thread-Topic: [PATCH v2 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port
 driver
Thread-Index: AQHZhJrntUaPjNRHKk2++3mbbOWIBK9XB9EAgAh5VFA=
Date:   Thu, 18 May 2023 04:58:38 +0000
Message-ID: <SN7PR12MB720147CE15B2F018F3E7D5AF8B7F9@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20230512062725.1208385-4-thippeswamy.havalige@amd.com>
 <ZF6UWBd0x9LxAhoJ@bhelgaas>
In-Reply-To: <ZF6UWBd0x9LxAhoJ@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|CY8PR12MB7681:EE_
x-ms-office365-filtering-correlation-id: 30a24f2d-f0ef-4047-3bb3-08db575c8b66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uS1LrVgOWbxMQhhFselqaSaXigxEp8J/jp/t4ik0LC7r/8plkdAh4dQsYBAklVo0NhBx7/6BAIgVGXmsBZv6ylgtSj2fzTQ1M6MyLeIkyHs9OCV1YGQBbjPvVF0B+34LKS1mYEbRON9QUhvNf4TT16DaMqIQNxWNWEUS0NcS3vj5oPTg7Piz/kRNK2LMYo/dl6Cms2HW+EFgzaTyvssqrNT1ejjjQc79A1TEuZM9torPi3xgCqpZf0cLqI2nJx9YX0U+TsFlMlXY8O3M8eQkEoV3MSKQO6m2zVd2fPVsXtQPGJDQDwqOLxOErNWC+MPRwHjs1a+9VzSZTSryCXkGe0ZRQGQctkmJ0XS+1aP+hjWtfF2m2AuAU/FoBZhyOkv+ubaJ840hSxV4gUyB7PnihTxU+ct1NUb8bcZqEcGOzxXwobl24XdtXaYc/FJ2XLviPj2z5ovtkdjAUDit51cRNpDx94lpJUni/arWKepkjvK4lLIc+qUmViUCh4Gu9X3fpxd2PZPrisnQ+K0ZYYGkqqany8eVhH4vifpc1YXIJc2nG9UHTO76q4F+4RfWcBEriBo4ACqd45WMxWlKP1CF8CVI9uN13QObugbRiLhdnz4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199021)(26005)(9686003)(6506007)(53546011)(7696005)(83380400001)(33656002)(86362001)(38070700005)(122000001)(38100700002)(55016003)(186003)(54906003)(478600001)(316002)(2906002)(6916009)(4326008)(8936002)(8676002)(41300700001)(52536014)(5660300002)(64756008)(66446008)(66476007)(66946007)(66556008)(76116006)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GZZDDyDsS/rpvEC0Ij8C7ruL33sjvF4oSsqWZwbC3XSRpI1wb+T4cyLweol8?=
 =?us-ascii?Q?OW8VhqUqMubAtUfsF4hJhkYVch4EPKbQORAw+mey9VADxhUGdB8p1zDzNOJe?=
 =?us-ascii?Q?sLSoBWiDvKv3D5c3/XukVi9q2Je027V8wtzzWrXAcqX8Nc90mBkr6aRuw/VV?=
 =?us-ascii?Q?ctKMKxk6cNS8BBGNtdioflAYyF0AH3UB2/eDHXKN6mFqMPdwZ+T8idsF8+u8?=
 =?us-ascii?Q?NBny15ncJrkUNGorz+i83qv9X4dgFO7uajRBKQK9RKQCcO9WfhmjouObPiXP?=
 =?us-ascii?Q?zjuDhjAlFycZydVcGQUgPLJPg8tWWwvuTkVgViDlqYRKlPuaj9xwUSi99b9Y?=
 =?us-ascii?Q?hyT+QEk2T+h5+6SdeMyKn2OZ0WesTZr3IMvOMBbugTRF8tjcS11YMW8SxZxa?=
 =?us-ascii?Q?qoLbgi20HZij5PQl+q63rsyPzGvFOXzD8brKur90OPLYxdMdlc/EbBELXM1N?=
 =?us-ascii?Q?y3FR4C96wLivjo0x6hBtxbpl3/GkXgTcGOFVAEt+YJh7iJlXkHyDRklsC6RT?=
 =?us-ascii?Q?SsoukZJ/e279hXhiYaKnfbVI41foaos2Ikoo8hR962pnxBfNcmPJlVAZIuTO?=
 =?us-ascii?Q?m0zgRxCWLXLLlrlZ/YHODF3J/l0PXjf4JGFrysauH3H/c4A5RZstI0aAuXkr?=
 =?us-ascii?Q?CxX3IqghjrQZYXsQmL40UndHccp/2MElJd1GY4mudm9HSxuZlkqxZ1qpoo6G?=
 =?us-ascii?Q?8CxMPXbXOW76AqSw8WaEJ7J2uYoXIje4I1IWqfm7r2CvfSb91vejcrgOM5wR?=
 =?us-ascii?Q?GBXcD9K03UkV6+MrVQw/W7+7YPj7i0Cq6o15cEJsYpB4+ioLvjIli9/pvmk5?=
 =?us-ascii?Q?PjsX5XKeanq/ohqQNsPrEwemadhg24yepQz1cHbag/hnS2yj4WD0BewvpEha?=
 =?us-ascii?Q?n8iPG/OonipKnw7Bz2xlxnvSdM/iMKs5LDBUqMjo1ZyXU34DlgYmBrDMUQHz?=
 =?us-ascii?Q?Gqf3jS9OjDAvygVfpB7Y+JwMJPuUwCAHDQrSxz7gjwE+mhNVe33cf6llokoE?=
 =?us-ascii?Q?MiKIR/k5jXURuYlPy5aWctXwXGnKuY7hUVswINHPv681VUQB0VWE5ZUX12JJ?=
 =?us-ascii?Q?9hYqDhxy6d/xRlYqLg/gmDlrDd3kkxxg2eF2RFWW0EWgmqbLtpIQp+NPVa7Q?=
 =?us-ascii?Q?bXwpfEHVBG29CSGV+v1h5DTfiJ67L4CV7WkeNnWcsgA4PhSdt1HIE9R3AcX5?=
 =?us-ascii?Q?f/K10EPGmI6mPIXT+pSN/sLifN/n/M/Y1ELtw3XNaSv+PwfQwr3hWUw8dr+s?=
 =?us-ascii?Q?et+IqYbBtdubY4Euj+J1Pn9Trn2kCDYW4BLnJ+bX5yDdyaOt9C7FSJZuJY9H?=
 =?us-ascii?Q?vU0mit2faSk4C03Z7Qcf8g2tSh2PWe6nuyS0O0nJ9rQsc0lkol9bvVPYj22J?=
 =?us-ascii?Q?CYw8k+M/U3bF4Zsf76NEc0bOTSlhXDAcmMYRT6iOVDE05OufYDIZ5mkpMWKI?=
 =?us-ascii?Q?lpQLBh4yA5uvkC67/ntYhBGURvc1hNzhLmGW5Xi1UVg0FzmriKNf22ZYMh/R?=
 =?us-ascii?Q?eMqmFusHuQ9Dl6j+hACGzxP0piVtCDqwUFh0xCVWmDlEfzdQ3DcTW22fwJla?=
 =?us-ascii?Q?7qWit0PrVE8U0GcNf3Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a24f2d-f0ef-4047-3bb3-08db575c8b66
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2023 04:58:39.0015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RCWWVJKZoCnA47UaxUATwZOj0uaA1shYlrHkkDyl4mHvnA3/gXL9Db7D3AipMogdWtilUZ75VWSuKzv2WvQY8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7681
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Regards,
Thippeswamy H
> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Saturday, May 13, 2023 1:03 AM
> To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>
> Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; krzysztof.kozlowski@linaro.org;
> bhelgaas@google.com; michals@xilinx.com; robh+dt@kernel.org;
> Yeleswarapu, Nagaradhesh <nagaradhesh.yeleswarapu@amd.com>; Gogada,
> Bharat Kumar <bharat.kumar.gogada@amd.com>;
> lorenzo.pieralisi@arm.com
> Subject: Re: [PATCH v2 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port d=
river
>=20
> On Fri, May 12, 2023 at 11:57:25AM +0530, Thippeswamy Havalige wrote:
> > Add support for Xilinx XDMA Soft IP core as Root Port.
> > ...
>=20
> > +#include <linux/of_pci.h>
> > +#include <linux/irqchip/chained_irq.h>
>=20
> The trend seems to be to alphabetize the system includes above.
- Agreed, fix it in next patch
> > +#include "pcie-xilinx-common.h"
> > +
> > +#include "../pci.h"
- Agreed, fix it in next patch
> Put the pcie-xilinx-common.h include here, as you did for
> pcie-xilinx-cpm.c:
>=20
>   #include <linux/irqchip/chained_irq.h>
>=20
>   #include "../pci.h"
>   #include "pcie-xilinx-common.h"
- Agreed, fix it in next patch
> pcie-xilinx.c has a very similar list of register definitions, which make=
s me
> wonder why it can't share pcie-xilinx-common.h as well.
>=20
> Obviously it would take a bit of rework since it uses BIT(x) instead of j=
ust "x".
> But you hide the "BIT()" inside IMR(), which is arguably slightly obscure=
 since
> the #define value is not a register mask:
>=20
> > +#define IMR(x) BIT(XILINX_PCIE_INTR_ ##x)
>=20
> I don't really care either way, but it seems like a possibly needless dif=
ference.
> Bjorn
