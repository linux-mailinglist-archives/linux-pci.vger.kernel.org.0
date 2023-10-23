Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2F87D3DE3
	for <lists+linux-pci@lfdr.de>; Mon, 23 Oct 2023 19:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjJWRg1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Oct 2023 13:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjJWRg0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Oct 2023 13:36:26 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17ACB94;
        Mon, 23 Oct 2023 10:36:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+V1340Zn4gi9eH7KOMw9euxwwZBJWR+V4CkX+MF1vK46e7PidE61MTUOPzitMQRNojZYZA0Qyl80lqyN5hljQ/zX73mFdaz0haaZi00UVZjxWpxNEbecRh2EMEmlSv/+n8+8lRl+Obl4LzZ5lS49/GsqmVNaOQ1UqzT8RVQtE24W2fFNn7kORKTcTfleRW7VXcof8RX5F3fMnI3TA8rjXfA9pzkMyk0WbMwfkgZfllWlfY4OVvb+hE+ieqsUXu1MwPk4sNy2eZ7p+cZukcPv2IHEJaIfRtpL14Rp6MtENUBpxnyrxzO42YFu3U8XhSqH8U30MOEl5or4WHpbwGmCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpeozGvoSEtstxeCLbSaaHHLTKButJugnsChcdKLN/s=;
 b=cMWfbWbUOrC+NLcJw5SoxjpfEWoDCWSMor06HLGq82p9qHW5fr1vDK+OB89TyMPNFnWYEtUWiySrCa7HuRAvBw8xLYQobXBj/vXITAbGH1lCDVogHzOUa9BLJJ0WWoUO1zswP3JS9D4JstOKiuHSldXEQcyuf0AFkNBB1YEMPcebZNnSFcF22QP3adsTIFFCrX5nFnY9Z6mvDHsQu0z/PAy6YGefdUH8mPg5YbG6BYACKKAtUE0LjyarzFtv9rIMSRJR+PK8V6/W3zn4wz1oVsxst2lTs5YpSRr8t7tA/I/0enKyoNM/4jZXkjq4qzZsov4EWSv0rrbA9KwaodrCTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpeozGvoSEtstxeCLbSaaHHLTKButJugnsChcdKLN/s=;
 b=m9KwzjhQbFyiK3PtA4z17OqqM753wVBTZ6dr2io/7V29DhFFRXJgI1ORmU6zB0eR51a4uOP7j1HIrOWcwNHN1cVSGvfXbd066+s5hdp0ItDXRExmNcZsKaHmCFekfODBalmefBowU4nlf0T84zV8lMAbmkJvW6zln+O3ZYVVSN4=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by SJ1PR12MB6243.namprd12.prod.outlook.com (2603:10b6:a03:456::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Mon, 23 Oct
 2023 17:36:21 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b900:6805:abb1:bc0]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::b900:6805:abb1:bc0%6]) with mapi id 15.20.6907.030; Mon, 23 Oct 2023
 17:36:21 +0000
From:   "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
Subject: RE: [PATCH v5 RESEND 0/4] increase ecam size value to discover 256
 buses during
Thread-Topic: [PATCH v5 RESEND 0/4] increase ecam size value to discover 256
 buses during
Thread-Index: AQHZ/+89QXgcS12G7EKSCK4TL1ydHbBSgl0ggAUp7wCAAAIhcA==
Date:   Mon, 23 Oct 2023 17:36:21 +0000
Message-ID: <SN7PR12MB72016B115DE57CDCAEACB57B8BD8A@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <SN7PR12MB7201A57631FB1E0FB60A9BC08BDBA@SN7PR12MB7201.namprd12.prod.outlook.com>
 <20231023172530.GA1602129@bhelgaas>
In-Reply-To: <20231023172530.GA1602129@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|SJ1PR12MB6243:EE_
x-ms-office365-filtering-correlation-id: 6889d097-7b32-4e0b-077a-08dbd3ee9257
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AmDtDALHiufC/+8LKUCmoDXxDNEyq1fhlfSCHNzc8XwLinEYwAeFCqOp4TAYokufKe0he/pVo2pni/xGkVAWo0kS40YVSAmVCjutPw6daxRMacTrGNA8AtAaayAHslUrSPlCtY5BHGExwQIM2c4UjiNqiWfxDWb+ykTYiDUU8DQVFufaVJTvnar2ExVOckJY+st4S37u1co9jsiC0vety+gXU5okWqZzadB8UByix3D3Qnnb7/F9wLtWjFslapsCg7XZZClbml4nJC+yXDGDuAFleHxh6Vk9tzhh+MwDw0l4BDjc25ceKKE8Q+wSJ/XQ/pFeww67yobwZgCo+FcC8rIg/vxd9Pd5zafCzUqtyiczLPId510R5nvSPoZ7QeYmaglFR4Sfkux9BAxGx0b09Lhbq1J3LHhgfCFu7aSD3x/N/yX2PFHb5aOEgfIc1gbLR/3lzAA68SlMsBpipshvGbYuqBEI6pVpX2fWIExGKuQQOADxfkywgUjopvd9a/X12IwsmxwrFzB9dHbiUxKdozDU8uusWmGFAsU/R/hSfnGrINEDsWvRjPlu9K8krEW3lpOvLPcZ3Wm66CpgC5LakCsBtLhKWFOewhbDaJoLiQA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(376002)(346002)(366004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(38070700009)(38100700002)(2906002)(55016003)(52536014)(86362001)(5660300002)(41300700001)(7416002)(33656002)(8936002)(4326008)(8676002)(478600001)(71200400001)(7696005)(6506007)(6916009)(316002)(122000001)(66946007)(66556008)(66476007)(54906003)(66446008)(64756008)(76116006)(966005)(83380400001)(53546011)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?euZFGZb4sTqvainuCziJKLSKreyXlDGu9vrsPQl9IZylZFpde5gFXxe7+Gls?=
 =?us-ascii?Q?fsEp3FP4K4J87YzrDzJmdFMawLuxX2sI/fIIMtW54fWg4UlR9tNGp/9RRH3l?=
 =?us-ascii?Q?OsAPqOmqRKo64DNTXFvisL4LKEiAjktoAr8S7A/xDkoLIBt+z0VVJOpXx3HP?=
 =?us-ascii?Q?6NEiquaVjwSxd7U812m8yJgIBnFOkRAbIPT0syj/TbpLW2/8V3A1Ya8HGZJu?=
 =?us-ascii?Q?QneGivw6ScR7xGr1UmHk3OUVesXE2wqeU05G/nouVbDq2okqRFkkTFdfnc7W?=
 =?us-ascii?Q?HPi0GUTIkOxStj4VDIs90nDmgii+pz+neqMzvyYZQ35YT08l3i6IzOqIbwdj?=
 =?us-ascii?Q?+DqyyJvh/Whqmga+9zgoJH4HJXBVSeI8r6piQG3HnV2lS+OZizaIN7+K0ACY?=
 =?us-ascii?Q?XPkuuaqStL6nWdP73m7xSKI4tb4IsMSumaVlBd2t2JL2aAC6YbmPM0m2e0mg?=
 =?us-ascii?Q?SFeNGZ68TM0kSrFtuo1C6xxDEJZ6oLhu4auiQqyjcK27MOUYdvN6br9FE74c?=
 =?us-ascii?Q?6of+2LO+OruOKP/H2qMOyImBdLKXzOzXSAr17JPTh2/4MNvKCqY1G71wqMpD?=
 =?us-ascii?Q?G3SbnQnVdMdnHJKEHZjLufg39z+t6GmM8XCpuN/CVEQdq8AU9aaCPzEyJeaQ?=
 =?us-ascii?Q?2wQu/Q5AaYugje4y8DmfTPY4sEVu28hdQtUdViPurTaBEBSW5gNT/OyC2ZyX?=
 =?us-ascii?Q?TFDXhMqU/HDQyRvr9CjXmXSVvP7brWWssEuCRKNzI77v/tqcmXnB/HKODcOK?=
 =?us-ascii?Q?I+KL9B8rotHfrbHrQdqoVdvLXUzI3UYWzCthw5vN2kQXbt8IryT6KecE8Bsn?=
 =?us-ascii?Q?AHtMM7vMVexX4tbmyQrz0PQG73tNhX9+Eijba/Dry0DJJYPTS9mKqvLCBC4r?=
 =?us-ascii?Q?QRu3tVMdTw4ZUBg8y8PFusd+wVGgF6gd8Rlkhn0Yi+X/oy8jGn/CJX5o2gG1?=
 =?us-ascii?Q?tVgwpDYhJw6m/S8HlJt5GrzuS8c1zL3PsdVKZrdJPwJgsFDFYF5CofsvfM1R?=
 =?us-ascii?Q?k4rDELzMsDqHUJG7+O9TLSpjkpUqAK+cXD/FTGA1cD3Ha8PnMJ7Dot9vyuYU?=
 =?us-ascii?Q?dU4+FZpp7mr11RfPNMCnhueuQAEJJNzcMcO7biMUsR25acwMw0GYpHwJiDYn?=
 =?us-ascii?Q?0NBrtezJaGKaG6BYBfG8XIUsnqyhzSruryOpjXBasbPb3NVtVqJlVGIrIflu?=
 =?us-ascii?Q?XSWXSEtD8qgffLilwDViWt0PDszsR8q1GdF94XyQyIpTzH0OEksgZJ1iQFpn?=
 =?us-ascii?Q?h3etgUtKK7KISbpQKMLpZ4hIGcPZbqTRgbrUT+Z7aWc9ZY5iK1rg9AAj6HJR?=
 =?us-ascii?Q?v4bIfmww7zXptIdhPoxMtLyodDYB23uwNch00t5oqB2bLMVdm33yPHG6tWX5?=
 =?us-ascii?Q?kU56WRJfebWehaBlxTkuieyBPuKmf3UGnEMdU3625CH03JfVaxcX0aIMo3W2?=
 =?us-ascii?Q?6SakuSJ/4py7zUMjnhb6cnn5AcdzSpTvl2TXGSiUaAiZHAwJQZBAQsB6W46w?=
 =?us-ascii?Q?x1MqCHyDfLbCqrD6MkLwznpqB0dAUaaVccmkvXscVgwntP71K5Q56gXt/IX+?=
 =?us-ascii?Q?Tnenu0uMCJzN52RPcU5jYVNXIMHsUuNb7B9az7mfS7F8XeHRMN9zRoPKnDJL?=
 =?us-ascii?Q?G7N9OqYnq3bttfyjfj638aM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6889d097-7b32-4e0b-077a-08dbd3ee9257
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 17:36:21.3386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uFtOS2kzyG4rEejedojZhHAoT1pbKaaT7iAehiPL6fYJm9n2NveqKT1lrxejMbtzx3OzELziwRO5wkUDCi7RXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6243
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thanks for update, provided list consist of all submitted patches for both =
the series.

Regards,
Thippeswamy H
> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Monday, October 23, 2023 10:57 PM
> To: Havalige, Thippeswamy <thippeswamy.havalige@amd.com>
> Cc: linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
> robh@kernel.org; krzysztof.kozlowski+dt@linaro.org; Simek, Michal
> <michal.simek@amd.com>; Gogada, Bharat Kumar
> <bharat.kumar.gogada@amd.com>
> Subject: Re: [PATCH v5 RESEND 0/4] increase ecam size value to discover 2=
56
> buses during
>=20
> On Fri, Oct 20, 2023 at 10:35:46AM +0000, Havalige, Thippeswamy wrote:
> > Hi Bjorn,
> >
> > Can you please provide an update on this patch series.
>=20
> As with your Xilinx XDMA Soft IP series, I hope to get this merged for v6=
.7.
>=20
> Would you take a quick look at patchwork here:
> https://patchwork.kernel.org/project/linux-pci/list/?submitter=3D207519
> to make sure that everything you're waiting on is listed there?
>=20
> I cleaned out things that appeared to be older versions of the "Increase =
ECAM
> size" and the "Add support for Xilinx XDMA Soft IP"
> series, but the subject lines didn't always match exactly, so it's possib=
le I
> incorrectly marked something as "superseded".
>=20
> Bjorn
>=20
> > > -----Original Message-----
> > > From: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> > > Sent: Monday, October 16, 2023 10:41 AM
> > > To: linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > > Cc: bhelgaas@google.com; lpieralisi@kernel.org; kw@linux.com;
> > > robh@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > > colnor+dt@kernel.org; Havalige, Thippeswamy
> > > <thippeswamy.havalige@amd.com>; Simek, Michal
> > > <michal.simek@amd.com>; Gogada, Bharat Kumar
> > > <bharat.kumar.gogada@amd.com>
> > > Subject: [PATCH v5 RESEND 0/4] increase ecam size value to discover
> > > 256 buses during
> > >
> > > Current driver is supports up to 16 buses. The following code fixes
> > > to support up to 256 buses.
> > >
> > > update "NWL_ECAM_VALUE_DEFAULT " to 16  can access up to 256MB
> ECAM
> > > region to detect 256 buses.
> > >
> > > Update ecam size to 256MB in device tree binding example.
> > >
> > > Remove unwanted code.
> > >
> > > Thippeswamy Havalige (4):
> > >   PCI: xilinx-nwl: Remove unnecessary code which updates primary,
> > >     secondary and sub-ordinate bus numbers
> > >   dt-bindings: PCI: xilinx-nwl: Modify ECAM size in example
> > >   PCI: xilinx-nwl: Rename ECAM size default macro
> > >   PCI: xilinx-nwl: Increase ECAM size to accommodate 256 buses
> > >
> > >  .../devicetree/bindings/pci/xlnx,nwl-pcie.yaml |  2 +-
> > >  drivers/pci/controller/pcie-xilinx-nwl.c       | 18 +++-------------=
--
> > >  2 files changed, 4 insertions(+), 16 deletions(-)
> > >
> > > --
> > > 2.25.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
