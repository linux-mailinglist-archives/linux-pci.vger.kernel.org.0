Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD98D6EE11B
	for <lists+linux-pci@lfdr.de>; Tue, 25 Apr 2023 13:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbjDYLeE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Apr 2023 07:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbjDYLeC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Apr 2023 07:34:02 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2099.outbound.protection.outlook.com [40.107.113.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAA33C04;
        Tue, 25 Apr 2023 04:34:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMT6wzeyNhmmwIrxslGRvx6xm5jdGAApi2lYlro9WtdZJFUG2eNdr2JVUQpmgNQ9NBKNQH79jpxZurZvH8qAK2tb4AlWAF2UVfbGzgx/I8mLcEo/QN5iFDFNokUaABWk6kNdDj6AE7JiPRCDrMgUk53PYwrUE4nUcYjF/tCkoQa9xkhNpgGGlOorvEemf9oU0P2n3Wzie76GoCG6opM1f6DsX7F6+SgD6JxGX8WbtzZ5HKEfbL7FBItD0omdUAAZhGO+Bs6oKOB2kdlxCe2wa4rZcflKql2p5p7ZzPp9WZ3w3rh5P26tD+HCnVlfhM9YtqC8Dl/tz1SBnl65GteIXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFNgwKVMM4p3P5JDMe7it9xa+kc6lc+mZZ95kcqmPH0=;
 b=ZxDAOikC1VIGAa1RJVzkKWnACEhd85LkowCCHQddddmyNE4gwS+aWqGZmOO673BzFvJIsMjHmNJFORInOGyERmKQbEUehXYB6wL9e3nqaL0jKyp8pLcqeBdVLWjnCGbtGKZmQv7Tw44o77wp73BLiqxlO9Trkmu5GjN20rIBl/Pw4twoVJ8rdPasBEImEr2LfdzOTS8p6z689F6NcyE1eTAIqFRkoa5xr66lSm0up3fE14GMKW2yY9N5r2knq0Ycn3yAiynz+w2Ov6IzijgbQBo9/yehD32V6vnebx96ZAa5zTilOi4Qus0JkecK1mDCVRdryYe/kGO1EhEW/6SMyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFNgwKVMM4p3P5JDMe7it9xa+kc6lc+mZZ95kcqmPH0=;
 b=gamuQj7xOxjO5dswWaB6KnbUhCzRtupYV6Cd51MuQwRGjXgyTY4ZLvUAuwf7s9+MIgydkm4iKEE4LY182IZlTD69Zw13o01VHKpVnRoeKm1GCckq0R1EBWbmN9fO6XtXclgkzbO/JQA43XprpBB/LAETWPRTiKYRlLUuPohj6vE=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYWPR01MB10631.jpnprd01.prod.outlook.com
 (2603:1096:400:2a3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 11:33:58 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003%5]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 11:33:58 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v12 00/19] PCI: rcar-gen4: Add R-Car Gen4 PCIe support
Thread-Topic: [PATCH v12 00/19] PCI: rcar-gen4: Add R-Car Gen4 PCIe support
Thread-Index: AQHZbpioU+BQJONFN0aPxrMcO53bQ680s8aAgAABQACABz/tsA==
Date:   Tue, 25 Apr 2023 11:33:58 +0000
Message-ID: <TYBPR01MB5341BD8037B4E82C4E5CEBB9D8649@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230414061622.2930995-1-yoshihiro.shimoda.uh@renesas.com>
 <20230420204129.azbopwklu2yetfrf@mobilestation>
 <20230420204558.4csplhtkz2co4att@mobilestation>
In-Reply-To: <20230420204558.4csplhtkz2co4att@mobilestation>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYWPR01MB10631:EE_
x-ms-office365-filtering-correlation-id: 74c3ab82-79ae-4a9a-5a37-08db4580f5cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Bg47jZDxyUHbuFt+BfGjcD14XLt/fL1hFvdX+hFnEeneHE3Fjg0pQXbXy39QeEeEM6UYmBMdMQeXkUir7x9knid/CQO52ojCcK8/wKO50zHN1A/mdb51EbfglLvZxanNd1yOEq/eKh0LDRAmmxLY3LjmEl1NSe4LWLY8smbKEUhB1syGaWZ/PusXL2hbuRgekPvRlpgcrhAVO50gfLU1Z3qm4+q0ueK7In0iHpV/8fVb91P/NPsp5pBHxOOivAI0+PqKahEqaaPH+l35wUw5Ixu2I0CzVxF/za8JS9tOWoTAx4NtbBZZPOgU1OrDt/fxQ/8jr+zDsz6T3WmAYAI3ipXIzqhUfJQuoBFdTfroxhXG2Qf98sht3lgyMqOeH9crpc97MonHx79vTW9qU0na5Qa2fBLfEpbweQneT1jBmxPMd6SJ8LPMjdFQcphhEUqOenpWdZEYki8+IQZLp5AECFjknylRX0b+LVhliwJ8Xm96Zwip1vJky9B4eDmIsrNGtNN+i/CXG3IudtDcSxxQIFaUH2XcTVzjQ89WnMzJ2G3nGzpTF8jWMTMyJtBAD/r2KbCN+B0c8z9/ysKJw2VX2L1eLUQxZnhTf3okA/Zf7AhNyi1N4NTmFuAZO7XbThx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(4744005)(76116006)(2906002)(66446008)(66476007)(66556008)(66946007)(64756008)(6916009)(4326008)(316002)(7416002)(52536014)(5660300002)(8936002)(8676002)(41300700001)(33656002)(86362001)(55016003)(38070700005)(186003)(26005)(9686003)(122000001)(71200400001)(38100700002)(478600001)(7696005)(83380400001)(6506007)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J1EvfKn/6gMk20rEmC0K33xx2OzkCr59zW+AQnFT/U1PifoNBcpuPZDZbDda?=
 =?us-ascii?Q?DFayp+9ttwO1arRqlIBIlzajg+65/uoJo+gesV3/VAFhzY1Fl8LNSJzVCuKR?=
 =?us-ascii?Q?9WidlbvBY9iHZlOscTws79z6mWw2a5RZzkfiUGpUaLDZle/9E2KCDOo8YZb8?=
 =?us-ascii?Q?PBO+b2QG5MG192w1mcTlomSt3Xhk4Cptu5Uyoo80o/3MfCZtGbhGw1io9OUF?=
 =?us-ascii?Q?63umZw9N9T9rtNJwL/a6x1c64nXcUwHWyLbhnaYQzCWbapUhTI5gtHUWtghE?=
 =?us-ascii?Q?dnz0hKSONlEx4Y0PiCv48taKDAED12g6MrSjmQ/5xmurTY8is/7rpyR8vQq1?=
 =?us-ascii?Q?M0Ibg2syBmQ02OazfQWIEvEKlyBjK7S0uvflZ42j+vunfRlZwSMoAOhU3I9U?=
 =?us-ascii?Q?BOqFOfqo/WrHU/kA1IWoHYYRYYW4ClStot1avl48+VmUlconJ0Nj1FGUfy45?=
 =?us-ascii?Q?TWKH+RQzlFfmHH807bhJSHLMoOYpj8JgrWqzFVJ+KMltPCYSnq0vs89SVns4?=
 =?us-ascii?Q?5wFd+4GgcmUk/o9KNAMoTkFCCIlpcm1brBQhey6pguxEO8l3svB+Q3GztLJV?=
 =?us-ascii?Q?CNoRyn7Yn0WHFage/DUlj4wF1KdRrMhgNejqPfpAzFiysc3X8juRLj2Riqoo?=
 =?us-ascii?Q?SxdIuIpEWtJvAMdV9ART416IRV74TOM3fSS+O8PXr70XiIyyr2ayhz69t6IA?=
 =?us-ascii?Q?rDzJxO2ZFhPbwqugECeRcIaGVMGDVmGd72e4JXZ4GRC56VlW+1RTo+VCikNp?=
 =?us-ascii?Q?5BrapI7gmiZGP0BRwFozWBRex445Um7+yPThFNOuxez6riH1lyVoeziwdRVE?=
 =?us-ascii?Q?UIYNaq6UjQ63V5sUTHG0TwDp4eCpYTb4mfsDw2jaXkjjVDt9gXkCKmYAI+SD?=
 =?us-ascii?Q?mieeeWO+GsmjY/esuFoOAjZHhe+43Qp9T424rlG04IsufFn+cE6I9VVvy/UE?=
 =?us-ascii?Q?rEzVFiSDfjC2bv8L4cPSzJNsLdgDnuVONeBYmzfSuqUVZ+PS4ICJjmh1WWhy?=
 =?us-ascii?Q?l4uRHA9/T+ew6DMPeW4HfnSKQR1W/dvZbWYwp2MJALhzvsGwjvGVkSMGeGu1?=
 =?us-ascii?Q?wAKHICUluOgcc449OT7nZ9PUExycQkzuqBUZadEE+TWIjageblzSUM2fuzmZ?=
 =?us-ascii?Q?LreCJfIWjLgLVyDRsPDADpp47jXnIrpTKVKZdmJiCCaADbm8qgkG4H4EqRW4?=
 =?us-ascii?Q?N8WNCncv4MkbtZig+tYC7BviYh9W9hCmVg4M1/KHLX26lm1SXppgDFauXVfW?=
 =?us-ascii?Q?NxK/ROuOijlOn3aCt1XYkIO1qsRG4wdEo2BBJ0+1aberEm3hGA1QehKVrMuj?=
 =?us-ascii?Q?BHqvhysmCsgAzheOCB+aU5rz7OEa80VXHwrlG5Vh5Sw/CFAHvVnE9h8JArCn?=
 =?us-ascii?Q?DH9mcWgAVXQjyRcR6Kyztk3MUD5LgtveLCZseG8dLxKPJd62b5kyAr+WQR/q?=
 =?us-ascii?Q?PzqltRZ3vsvBB0MFGpp89CXiBCUVpvHeMMVOd40pzShzbd4MH0yYSBBIkAE0?=
 =?us-ascii?Q?A9eYxYdqz03j39tb49gtjeuwLmnADN8l+t+78u0+rCmFRv2m332Hpx+2bkS0?=
 =?us-ascii?Q?eVI5/a3PVEmrKOC/Kil6wBthN4Db5ZzVCZvo2JHXVOdiNA6z4se10Saagv5g?=
 =?us-ascii?Q?EQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c3ab82-79ae-4a9a-5a37-08db4580f5cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2023 11:33:58.5154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ka3fnrK4U2+tcqLgc58pSOObt8AGTuoHl2b+UYWZZErt2flDtBPUmAtwX7DAlYN3mLZNRW0LK7DQT1Kv4YJGv3VEkgl7gY+FLdscUFJDhcr5+Pg0yLXbRZ1v7e8DiAM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10631
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Serge,

> From: Serge Semin, Sent: Friday, April 21, 2023 5:46 AM
>=20
> On Thu, Apr 20, 2023 at 11:41:32PM +0300, Serge Semin wrote:
> > Hi Yoshihiro
> >
> > On Fri, Apr 14, 2023 at 03:16:03PM +0900, Yoshihiro Shimoda wrote:
> > > Add R-Car S4-8 (R-Car Gen4) PCIe Host and Endpoint support.
> > > To support them, modify PCIe DesignWare common codes.
> >
> > Thanks for the updates. I'll have a look at the series on the next
> > week.
>=20
> Oh, I see there is v13 already submitted. I'll send my comments there
> then.

Thank you very much for your support!
I got a lot of great feedback from Manivannan, and I modified the patches.
But, should I wait for your review on v13? Or, should I submit v14?

Best regards,
Yoshihiro Shimoda

