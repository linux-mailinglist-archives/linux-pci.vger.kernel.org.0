Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD87359BE8
	for <lists+linux-pci@lfdr.de>; Fri,  9 Apr 2021 12:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhDIKXr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Apr 2021 06:23:47 -0400
Received: from us-smtp-delivery-115.mimecast.com ([170.10.133.115]:48164 "EHLO
        us-smtp-delivery-115.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231621AbhDIKXq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Apr 2021 06:23:46 -0400
X-Greylist: delayed 308 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Apr 2021 06:23:46 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
        s=selector; t=1617963811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=vOpVvvLpZ8ZylfWd/NWNdjmtXSrQqw+sBtc3OfQwTI8=;
        b=Uzc1fiLgZndzualgjwapW9fWBD6lL3Osy48nlzk2N1eqbCfdzzNFqdST+UQ9wf5zoGU6b6
        W6v1N6L0lK2vO2u/M1ankieqh8zQG4xL+J33XhXOmZnD+olw6D+yvsq0JGWUXZwGZls9oo
        R3IZhs4pyJ3pxS1KSUMPZFvjPWoceL4=
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
 (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-xMe5o3zcPPWVCikyPLkzAQ-1; Fri, 09 Apr 2021 06:17:15 -0400
X-MC-Unique: xMe5o3zcPPWVCikyPLkzAQ-1
Received: from MN2PR19MB3693.namprd19.prod.outlook.com (2603:10b6:208:18a::19)
 by BL0PR1901MB2018.namprd19.prod.outlook.com (2603:10b6:207:1b::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Fri, 9 Apr
 2021 10:17:12 +0000
Received: from MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::1cd9:22:e5ef:6d10]) by MN2PR19MB3693.namprd19.prod.outlook.com
 ([fe80::1cd9:22:e5ef:6d10%7]) with mapi id 15.20.3933.039; Fri, 9 Apr 2021
 10:17:12 +0000
From:   Rahul Tanwar <rtanwar@maxlinear.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Cheol Yong Kim <ckim@maxlinear.com>,
        Qiming Wu <qwu@maxlinear.com>,
        Lei Chuan Hua <lchuanhua@maxlinear.com>
Subject: Re: [PATCH] PCI: dwc/intel-gw: Fix enabling the legacy PCI interrupt
 lines
Thread-Topic: [PATCH] PCI: dwc/intel-gw: Fix enabling the legacy PCI interrupt
 lines
Thread-Index: AQHXLLdhGXi/61G7b0m/GnclevcsPA==
Date:   Fri, 9 Apr 2021 10:17:12 +0000
Message-ID: <MN2PR19MB36934176A011B86624E1EA2BB1739@MN2PR19MB3693.namprd19.prod.outlook.com>
References: <20210106135540.48420-1-martin.blumenstingl@googlemail.com>
 <20210323113559.GE29286@e121166-lin.cambridge.arm.com>
 <CAFBinCBaa_uGBg8x=nPTs6sYNqv_OCU2PgCaUKLQGNSN+Up99A@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [222.164.90.248]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71b94de1-4ae7-4f89-81c3-08d8fb40a473
x-ms-traffictypediagnostic: BL0PR1901MB2018:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR1901MB2018A7BF537F9526FF9D34A0B1739@BL0PR1901MB2018.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: 2NqtQwl3mOGU3CfQgjGi8qIGswAHmRDQ5CjhgHb2YwHroTJBDSs5BdR+x664O/pe6ivXfcyEoiXE3WuNL5jgmXrO2PTTyMj7z1tZ0PwcBf277mi3HKlHx6mI5zXmVBBdPt5VZNbEp/qgFkKn+mJpRA+AQIv+naRcPBU3WlcU8DH50dhWEe14kR//Rl1BL35lYu3ZQXBmGYb4SVrk7T7FSQ5m5I1KN0rOdKkjgvGFhzJNMbUacxkJrrABCS3r+J00UBKEDJlX0SODUNKBQ4GRVGRS5HshXeCuKs5NChoL+NeLlwZOO3NpgJ4ZQg+tbcP4v/A2yk285ZGs0KFX/W8UE1Zz98ATSrdF0osIR4wHTaD5tP575Yc/P2ALl+czVjuWhP4pHzes+N6C5oKOaIsTGB3bVIxc7OPP0RpmoFjioiuTaSjZiy5eOjkd+t6GNqOO4nb0xlPgwyfJPatFE+1krseRotlKXcvogamQ/Kie8b7fWt5ZOiDMKR2mISYIbxXnki1/5umPASk2RDLb4ZIHczNdScGjnRj6paXFPrE+RXSUy4+ecau6Kpz885iswwlnYPUOSyIH3Kf31DPM75VA01lyM1gc8+3pGhqA4YxDOVMCFvK8z0JT7UjTfR9VN2EI2yLfor+36LiFtLjZEfskDKTAiPMSY+JyHH+dogarhPOG8/1uFLPd9LbnvuMgC5rz4rxRv7XQ/XGlrTzzS7+H778nETFo1vEP8SdFTb7/Zt4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR19MB3693.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39850400004)(366004)(346002)(376002)(396003)(966005)(55016002)(6506007)(107886003)(8676002)(71200400001)(316002)(86362001)(110136005)(53546011)(8936002)(52536014)(33656002)(478600001)(26005)(54906003)(38100700001)(76116006)(83380400001)(66446008)(7696005)(66946007)(66476007)(9686003)(91956017)(4326008)(186003)(5660300002)(66556008)(2906002)(64756008);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ayeU+VvBY22hF9urTg+XeVY7xM3N8Wh8qBu5ILDVh9FT17X3FSuZ0RocyLvT?=
 =?us-ascii?Q?/nkMJpsNJLRKDxLQ/AQdaiW5gO5I3kxntYL72X0EYaDGV7gtWYT7IPe7iXTE?=
 =?us-ascii?Q?RSKDxd5laHSN60S2f0prQdN3KOZturFZVpbI8/N1zQYfdKV5hxvWS+jWhqzQ?=
 =?us-ascii?Q?/m2YBA8bCl80h67SihEXi5X39kcTzj8YAuL+SaLnaO0YRCr/k6M7+F+mCwGd?=
 =?us-ascii?Q?svn4ZEThP9LfDdkEqfe935w2ioqJTa43ZM2dzB35+BS9xjJXWgv0xCVlm73U?=
 =?us-ascii?Q?45fue87QYtIj+VYRvGMgd/pYzpf8AGgCgbwENgSj1hZxLhwaaI/XchTV6efL?=
 =?us-ascii?Q?HDpPJBv0lPjqASxRFsugZIGi0ZJIR07DCqtweGxBlTAE4OcY1TS5Ae3ubtyX?=
 =?us-ascii?Q?Ci/8a0jkdXYDAnVTo3GWDagP2e7BY6A0roHtqGxMe3hgiWilQiKYOcnXlhAA?=
 =?us-ascii?Q?o7ZmIhZQzSi0Qqbzn6bwHrECQ3RppU4LdOuU8Q7dRoIH1o4/yueT3ERlaO57?=
 =?us-ascii?Q?eKmdSzfN6srQmV+Gs3x0i22PLsH/h4opdxWXsNbDfHsCIU3IlhQeap5ir6Do?=
 =?us-ascii?Q?Gnmfno+8iRm17bqcKB2ywZXaxOvHr0mvlm/xloWXYOUACkVQNqr91o5G1jZa?=
 =?us-ascii?Q?NZMCUDnMDsQUAg7GUnegHXdh5LRbA49YcHhGHPhDO7+43M0xxpPdTvvrPMzb?=
 =?us-ascii?Q?bF9xw7s2OsaADL/2mCXiktzzcFqbtp6EwIgz8jCx+P/rW/4ROjBpFgU3G0vw?=
 =?us-ascii?Q?zpsD9PcqTVAMhD+0j9Mrlle59tKeEChSiu0GiM4cnu7cXOxwzp63Gal/Vex5?=
 =?us-ascii?Q?iNkyNVguYBTtDsFpWD7EVMavnUDMa1JJ1SbAEbAA5tLGrIGSrdjb8JhJqQRN?=
 =?us-ascii?Q?/KJKbMLbiR5NIHxi6vsFeyc8VeOXkPrDxe4oGSV8nwjRTI+gdXz05ZSMehoI?=
 =?us-ascii?Q?DInx4dSuWe+71Py4BEHQTZ4wyk6EErcvMer+xhiForuFZFYWMz5Z8ejZWgf2?=
 =?us-ascii?Q?P1f3YYOlEzPypPm8d+l+0loWf6PpFtjWn2Z4IK0+Ly6wI/A8dhHmtVqEWqRq?=
 =?us-ascii?Q?dJA982lWYDedh2ZVt/JyjNDXh/xW8/+lgHLEGIt0WfkTvz39WmHazysj1h2P?=
 =?us-ascii?Q?J9sEJVfwkNnD5mrBO9ldhHRbFuFlOP4Z4CZmFZhgAv02Lz5FvoOMr9jQpqwi?=
 =?us-ascii?Q?1uVbBENQxA81SOkSN3hQgv/jbtM/Tk9ytKkSHlw1aDATDHU7tOxRZ9MXdkK9?=
 =?us-ascii?Q?QnRFEIRD52D3IVwADweLwrbupHXnyHMCObH8HFbQ8F5QNSjW6Krz4dGGV7bf?=
 =?us-ascii?Q?XT0DcsdyQrOVw5qvLx11YKy9?=
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR19MB3693.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b94de1-4ae7-4f89-81c3-08d8fb40a473
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2021 10:17:12.7507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FRTFb69U6wz8nuXFLvpWfzxWzou2DetqTcQKVbv7aQoUaN3HJ5Dpsi3KYQlvRujnWvDYK1ep5EYI5/imeu3Cvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1901MB2018
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA115A51 smtp.mailfrom=rtanwar@maxlinear.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: maxlinear.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/4/2021 4:40 am, Martin Blumenstingl wrote:=0A> This email was sent fro=
m outside of MaxLinear.=0A>=20=0A> Hi Lorenzo,=0A>=20=0A> On Tue, Mar 23, 2=
021 at 12:36 PM Lorenzo Pieralisi=0A> <lorenzo.pieralisi@arm.com> wrote:=0A=
>  >=0A>  > On Wed, Jan 06, 2021 at 02:55:40PM +0100, Martin Blumenstingl w=
rote:=0A>  > > The legacy PCI interrupt lines need to be enabled using PCIE=
_APP_IRNEN=0A>  > > bits 13 (INTA), 14 (INTB), 15 (INTC) and 16 (INTD). The=
 old code=20=0A> however=0A>  > > was taking (for example) "13" as raw valu=
e instead of taking BIT(13).=0A>  > > Define the legacy PCI interrupt bits =
using the BIT() macro and then use=0A>  > > these in PCIE_APP_IRN_INT.=0A> =
 > >=0A>  > > Fixes: ed22aaaede44 ("PCI: dwc: intel: PCIe RC controller dri=
ver")=0A>  > > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@goog=
lemail.com>=0A>  > > ---=0A>  > > drivers/pci/controller/dwc/pcie-intel-gw.=
c | 10 ++++++----=0A>  > > 1 file changed, 6 insertions(+), 4 deletions(-)=
=0A>  > >=0A>  > > diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c=
=20=0A> b/drivers/pci/controller/dwc/pcie-intel-gw.c=0A>  > > index 0cedd1f=
95f37..ae96bfbb6c83 100644=0A>  > > --- a/drivers/pci/controller/dwc/pcie-i=
ntel-gw.c=0A>  > > +++ b/drivers/pci/controller/dwc/pcie-intel-gw.c=0A>  > =
> @@ -39,6 +39,10 @@=0A>  > > #define PCIE_APP_IRN_PM_TO_ACK BIT(9)=0A>  > =
> #define PCIE_APP_IRN_LINK_AUTO_BW_STAT BIT(11)=0A>  > > #define PCIE_APP_=
IRN_BW_MGT BIT(12)=0A>  > > +#define PCIE_APP_IRN_INTA BIT(13)=0A>  > > +#d=
efine PCIE_APP_IRN_INTB BIT(14)=0A>  > > +#define PCIE_APP_IRN_INTC BIT(15)=
=0A>  > > +#define PCIE_APP_IRN_INTD BIT(16)=0A>  > > #define PCIE_APP_IRN_=
MSG_LTR BIT(18)=0A>  > > #define PCIE_APP_IRN_SYS_ERR_RC BIT(29)=0A>  > > #=
define PCIE_APP_INTX_OFST 12=0A>  > > @@ -48,10 +52,8 @@=0A>  > > PCIE_APP_=
IRN_RX_VDM_MSG | PCIE_APP_IRN_SYS_ERR_RC | \=0A>  > > PCIE_APP_IRN_PM_TO_AC=
K | PCIE_APP_IRN_MSG_LTR | \=0A>  > > PCIE_APP_IRN_BW_MGT | PCIE_APP_IRN_LI=
NK_AUTO_BW_STAT | \=0A>  > > - (PCIE_APP_INTX_OFST + PCI_INTERRUPT_INTA) | =
\=0A>  > > - (PCIE_APP_INTX_OFST + PCI_INTERRUPT_INTB) | \=0A>  > > - (PCIE=
_APP_INTX_OFST + PCI_INTERRUPT_INTC) | \=0A>  > > - (PCIE_APP_INTX_OFST + P=
CI_INTERRUPT_INTD))=0A>  > > + PCIE_APP_IRN_INTA | PCIE_APP_IRN_INTB | \=0A=
>  > > + PCIE_APP_IRN_INTC | PCIE_APP_IRN_INTD)=0A>  > >=0A>  > > #define B=
US_IATU_OFFSET SZ_256M=0A>  > > #define RESET_INTERVAL_MS 100=0A>  >=0A>  >=
 This looks like a significant bug - which in turn raises the question=0A> =
 > on how well this driver has been tested.=0A> to give them the benefit of=
 doubt: maybe only MSIs were tested=0A>=20=0A>  > Dilip, can you review and=
 ACK asap please ?=0A>  From "Re: MaxLinear, please maintain your drivers w=
as Re: [PATCH]=0A> leds: lgm: fix gpiolib dependency" [0]:=0A>  > Please se=
nd any Lightning Mountain SoC related issues email to Rahul=0A>  > Tanwar (=
rtanwar@maxlinear.com) and I will ensure that I address the=0A>  > issues i=
n a timely manner.=0A> so I added rtanwar@maxlinear.com to this email=0A>=
=20=0A>=20=0A> Best regards,=0A> Martin=0A>=20=0A>=20=0A> [0] https://lkml.=
org/lkml/2021/3/16/282=20=0A> <https://lkml.org/lkml/2021/3/16/282>=0A=0A=
=0ADilip has left the org. So not sure how exactly he tested it (maybe only=
=20=0AMSIs). But i have confirmed it to be a bug. Thanks Martin for fixing =
it.=0A=0AAcked-by: Rahul Tanwar <rtanwar@maxlinear.com>=0A=0ARegards,=0ARah=
ul=0A=0A=0A=0A

