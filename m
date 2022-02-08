Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114354AD715
	for <lists+linux-pci@lfdr.de>; Tue,  8 Feb 2022 12:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359574AbiBHLbo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Feb 2022 06:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236391AbiBHKiM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Feb 2022 05:38:12 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E86CC03FEC0;
        Tue,  8 Feb 2022 02:38:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWJg6TetgadTsYJmjYwbXb/nxpkwCLloM3fID1I+l+uvzjNN8gtBgoUGC6FqCXY2TayMB5quyKDuQTV94t3A8NTZsi5ib8oAitGxWmyxLRPHyGLZGRBvp7wTTe0V2zidhpInwWhVJWY1wx5NbUeQsEMV/zgwZ67hS5VDbfdN2cuUrM8QadjZOv22idcFrJ8Pj8T06hKqVWMzwmUEpzWZ/RWkN4vvHmQPqDSsefaY6XB2UdvTt/YrJAAyHa0yqJHwqXBlOixtlIJBnuWJn3NQeb9XO8628htdHdlH6fkg7ukNE2DSHlFMY4ppJgIT2LuW1kAp5W8VQYcDTNZkQ8uWgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TukYXBqjaWcfBEdu+YPTNa3nRIzYSBx/A8swmqB0r4=;
 b=Iw7Vxao+heUia+pDLTcbTS/Ve0AqcU56hCi+3tSILz+Ps33mDmjq4jNi8e+b0C9bn2HV9QTAu52/1OBjoHcusjpPla55r+5y9BIHzCY5bDQ7yHD2Higmw1InV1LofsSYv5RZObxd5LiFCJkc0TMpoS2blp6Md2wEeyShNY3hDxqeTKfe+TzcvUUBHIT0NINx7o53S/VNeNl1zvKexf3tCjscKUO+7yZKrGEZQp55BKYHI39XrMfy9bnDm8SHeNIafqWtLwomRca6x6fGQAHS/5l6jT75Q5jjNITLJE9cETm+O71GEVB/MFM7cCk7Fz4zMhkDoDG2Bq9u2eENy6THZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TukYXBqjaWcfBEdu+YPTNa3nRIzYSBx/A8swmqB0r4=;
 b=Q4ckWUKCrjS3Qrt98/Q2svV1o7Sa6EgIAca+iZhw2nF7qtH4RrJsF0bSPvQZ118uMWs5n5GdXpzepx++rYTVk3PcQiSdRp5Ex7IeLmh3vQumgGqZq+doCmPrzV8EqqhK856elRApeyQr9ZKVxrWSQDc0BqCn4tW2qY/AoFJKxlw=
Received: from BY5PR02MB6947.namprd02.prod.outlook.com (2603:10b6:a03:23e::12)
 by DM6PR02MB7003.namprd02.prod.outlook.com (2603:10b6:5:255::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Tue, 8 Feb
 2022 10:38:08 +0000
Received: from BY5PR02MB6947.namprd02.prod.outlook.com
 ([fe80::259b:b0b6:7574:328f]) by BY5PR02MB6947.namprd02.prod.outlook.com
 ([fe80::259b:b0b6:7574:328f%9]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 10:38:08 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Michal Simek <michals@xilinx.com>
Subject: RE: [PATCH 1/2] PCI: xilinx-cpm: Update YAML schemas for Versal CPM5
 Root Port
Thread-Topic: [PATCH 1/2] PCI: xilinx-cpm: Update YAML schemas for Versal CPM5
 Root Port
Thread-Index: AQHYG9kAFKEhuJg1KE+3u5Sm8qGShKyIaTQAgAEOzVA=
Date:   Tue, 8 Feb 2022 10:38:07 +0000
Message-ID: <BY5PR02MB694796AB6735769F20D11E3FA52D9@BY5PR02MB6947.namprd02.prod.outlook.com>
References: <20220207041250.1658-2-bharat.kumar.gogada@xilinx.com>
 <20220207182806.GA408432@bhelgaas>
In-Reply-To: <20220207182806.GA408432@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 306f884f-671e-4e5e-3a4d-08d9eaef18a1
x-ms-traffictypediagnostic: DM6PR02MB7003:EE_
x-microsoft-antispam-prvs: <DM6PR02MB700398D15CDBD31AE7326B5DA52D9@DM6PR02MB7003.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4oeL3FW5kTjKMOLgG61MTiuItZEcr0xeMMoCn7irlMTLyty/Bcl8gn4/hpc7b/4Mx2gR7y6+QQHZ+3Vse0vkEm9HfxbCsARpFpy6jUaAL68VqB5mZVDeEE/MJ68ldEhzzVPs1zjn5c8Bk6g+25WP0owz5bdE4HhZSxqENuNMAa7ATh+pO990hFRUdIZJQx1quBLGXosjlyfucGFPmA1JOIqyIdAR6aKSff/ZnEYDXJLReQPL2m5neEg+UB2JgEWWCi3n5HqGEZqKgMgii29PUdWSDWFbJVEr77PH1w5jwx5Hk5FjA9dGIoy1nkW2GImzZWXk5KdujqwxmsCZKSoXGXiwBcH2Ds6N5hXHofUmhqjLjItjWJHA+Hw+nmNtoiOUavUKWzC50ijWrmDRRcrL8Ie5wOhc72LVXoR3C4P3j50CcH398uiZrvYasagxZFNrZKw+1OVJOcELbMVF/8j/xoBxHZRyaxv2dSdwC20nC1r0EBK05J7JndtUjm5atnNZLzAhuJ/S6w+GIb3zuMnMvBwkpOBlXMY7BHrFrcwumUDLD5tBTIOLBwwEfM4XF0Pk620vvH06/XqeHyEdSRMjMgVOrL1XteeVKMOnUNSw9Opx/gpR/oJruJwPxRTUG6l2jicczQh0kSbz+3cDiPebwCReJbq2yu682Cr2zexg9LOm/LkUXh7Ysa5LhSKSQwH5JNuODKmKDMhlAN3xCwIM1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6947.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(15650500001)(107886003)(4744005)(86362001)(508600001)(122000001)(55016003)(38070700005)(71200400001)(54906003)(38100700002)(6916009)(186003)(26005)(9686003)(2906002)(64756008)(66446008)(66476007)(76116006)(66946007)(66556008)(8936002)(8676002)(7696005)(5660300002)(52536014)(33656002)(83380400001)(6506007)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TzSn9mj80t2Z2JFAYeaT0J6gkpRs1X3t0ELDyuRQBrRrCxFRCKGBeA0XQGtO?=
 =?us-ascii?Q?halhuP6EIpdbx89pQlIwNnmmVnhXC6m/t+EgiKWEdXX0gDORb43iW/cOzZhS?=
 =?us-ascii?Q?QV/pUFpXuUv6h2y1eZ0Vh07X45RzsCXF6Qqv/ayTkujZRuIk8g2eJkj4PJeR?=
 =?us-ascii?Q?2vspbgw62Wlfng7garKD0hf2Jz0Er8UNPp4/Ruy+/0srncuUn2so6cD7f3x1?=
 =?us-ascii?Q?EVqsOZ+9HAiM4ZpuXhi5aHBIVD3JEgajkVqjbXanTKi8jb+C/+UWeg4KY1xF?=
 =?us-ascii?Q?w6X6K/qyHTjvFJmb2tPhCtZq+jvYWtPOZygZCqEovWOpct/afBFaMDCRW8Ql?=
 =?us-ascii?Q?g2beQiZqDSTTKl89hFpHuZ198XFsflG7cqmiwCxx7pUi/Kg5neHhCA8O2xEV?=
 =?us-ascii?Q?LN5oswlcHyfiMO4hH3FBrp4BM+QyqsqhadVx2XBLa9KGO1RdWmrhsQxPSytt?=
 =?us-ascii?Q?hwM1BeECHJUsO0AqFR9GgIWp75UaI64avO985o8xhhJuS1JpqnP6ld5drMTl?=
 =?us-ascii?Q?alB/8IYlFmzgOhn1QqpMv68HEMfmsJzqTt6Tn45zDH+Pz7ugr1Vt+rGBeOS5?=
 =?us-ascii?Q?98ng2H4TInoZpn71xkZhVAYyleCQ91oyLEysZH7vCOwvlHCGFFeB7e8ndLZQ?=
 =?us-ascii?Q?pFPhkg4V19UOT3/cQuLLs0Q2aLOjLZOHAZR/dky2VkFRO69h2S5BNvK7Nzw1?=
 =?us-ascii?Q?E2dr5nUgEelv90JjPH787xM6UqZJTSzl+PLk9URxamgJknwZwz6mAHT4f508?=
 =?us-ascii?Q?LTE8RgGuGJsmBIzAiwHAHOBGzyW7EzvEOl0Kb2edrfHJjlZ2aMVXoWToir1d?=
 =?us-ascii?Q?gq1S1fY0pR6384GlgnMX2IQ+9y0ViqKP9RSUGR4SRb1IQSbS9TKJueQcocTp?=
 =?us-ascii?Q?XKu0rOjxoyL6VO0SvrU8YhNNh3Fmc+KI+6hxPt3NNNO3Gjnt8+r81X6ACFDl?=
 =?us-ascii?Q?+rhhM79gMuVVKs1/7t0Gcp8qpmIJlO8lS2TPkbIfV7YABUF5WRyBjPpG9M6Q?=
 =?us-ascii?Q?3RRrAHaNTSl1WlXPP7mIrHCBMqqj8DQfWzcOaxC/EKzoHOhyzjRRfvRStyJL?=
 =?us-ascii?Q?F0SugvspaMVB6FVWu8OHFgsgIwjTvENyOYovuPSYP0CNp0lTqwJvsbcCGKZp?=
 =?us-ascii?Q?AAxuXBllWWJT/nfn+sLh5/u5pdBa2rgrCe+EI6xgpFqiDiGOc9eUxm9b4Mjd?=
 =?us-ascii?Q?7fElElWTbYv3x1HRe1QGGLefOt2nbYE93ArmjdrIWE4IAIm2Wd90CcmJXqKi?=
 =?us-ascii?Q?FQbG/jiuAtsqG6tlBy/Pr8hgUEFypInJwiwlnUKaM7m520k2P1EhJtQisWIH?=
 =?us-ascii?Q?G4Fx8yHKNjbI6r0XcgIZC2WMETmhfdfLswQ7RxlHnqCw72LMr7+E9XouUOOF?=
 =?us-ascii?Q?EupA0+EnUuG0WK1kiVk8U3/D4a/o+SFfgSb15oHwEWxSPJfiD7iMS7E3SPiz?=
 =?us-ascii?Q?eSruX05xGdZyUsxuiLWUKDe63VRS6QKnSKPj7z9THq5NbNbk3eaWGWuLEOoi?=
 =?us-ascii?Q?i4WkCB8MfnY2xWodCRE0IyMFNVW7IBsDAjBMzCFa5LMwBhqezQoweLOzqPVg?=
 =?us-ascii?Q?hMV3c0MC5DZx8R5YxHogPGuAL4PNASGr4zz+lJCBwFlvD1T+WqXK40bdUrh3?=
 =?us-ascii?Q?0v+G3uC1u/DyWMAWVPrufMA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6947.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 306f884f-671e-4e5e-3a4d-08d9eaef18a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 10:38:07.9844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bibQx75CZTxBJfV5gNDBDm7SRjcu9T27MEvlSa/cjFFEo8gYr2P3/GkqCz5gXCctDPZN9abSYdxVVIvBBCimeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB7003
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Subject: Re: [PATCH 1/2] PCI: xilinx-cpm: Update YAML schemas for Versal
> CPM5 Root Port
>=20
> It looks like the subject line convention here would be something
> like:
>=20
>   dt-bindings: PCI: xilinx-cpm: Add Versal CPM5 Root Port
>=20
> (From "git log --oneline Documentation/devicetree/bindings/pci/")
>=20
> On Mon, Feb 07, 2022 at 09:42:48AM +0530, Bharat Kumar Gogada wrote:
> > Xilinx Versal Premium series has CPM5 block which supports Root port
> > functioning at Gen5 speed.
> > Add support for YAML schemas documentation for Versal CPM5 Root Port
> driver.
>=20
> s/Root port/Root Port/ to be consistent.
> Add blank line between paragraphs.
>=20
Thanks Bjorn, will do the changes in next patch.

Regards,
Bharat
