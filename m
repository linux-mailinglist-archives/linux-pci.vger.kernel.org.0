Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F138A4AB47D
	for <lists+linux-pci@lfdr.de>; Mon,  7 Feb 2022 07:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243907AbiBGGPn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Feb 2022 01:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236725AbiBGEbH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Feb 2022 23:31:07 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2046.outbound.protection.outlook.com [40.107.102.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001B0C043181;
        Sun,  6 Feb 2022 20:31:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CV7dAF3ZZCLkgyxI2XuH2zU0HQU0/6mRpuyIpsAuELEOYAIIEME7N3JBR97CrKGfirV/icHl78ds0lJg0aAAODqOe8E5FR6Fqy0ozEchq5/jz5BPy/q1j60Qb2nrgm9E9gBGx6lJxUvk2wl//iNBt5C+XacRZ4+rKRiHi1yMPfPtfL0W/e60yGZ1unzm5UCoQEjHUsbYuUPz5HOHe/q+iA8/7L/L6Hhry0CZcqq1AmAsYO2DtwsmbBcwNelg0gvniSh1+MxNPlRwMEvyip5MNkNViu4mPLCiPr79gJ1QXVI5YcOuY8/MDwfZAr/ub2lfGfVGsWTd5JvefgtRVyd21w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOKZIEe3d20wimC5sXmGSYZ7nU4QZjN/LDcbXJOBffI=;
 b=gE9x8c99nVIK3beeqSNThsz9DSPTyMY90gL19AKbYvhyNb02GROGQ9rXEq/OM8LKUNKQx66qJCRGeWKAdjLXKWmD/Lu6p5Css49jnHsStJ35a7NssM2OEZtjjspFeHaZQqlUFd3RhlM06U9fD89Gtf/D1psebLsrxQIB0NX0wdhhuGgj/CZArlTr9FrRziaBa+BSyQY3vr6TL3lTmmqlCVsq5vIYOSNgKmUy1hqs3Z3lt/XxW3SIfY2gplYRv5uLTBSbasQHXts+QLwfvMROvfEL9hnTn4LSRoffyKJPk9ca0tmroLcUKF5Nqu0xVI93Ay3z7FBdoIVtat07od5qkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOKZIEe3d20wimC5sXmGSYZ7nU4QZjN/LDcbXJOBffI=;
 b=QoNrDXl2Oi4D9e5umD3xd/7sQ28HsbJ5/uoRDLSYfYjKD0QDvZGinLgV5O2onMIrL/uZvTer1jeQjypjsfFdk8vMU8NqGd2V4X7Bm7fCup0p/vvcFp9wh4PK6T0ThlZzQ7NSfVTGocHyVKlGjrumqCx9KrpHnhMP4eKEARwgTuQ=
Received: from BY5PR02MB6947.namprd02.prod.outlook.com (2603:10b6:a03:23e::12)
 by BYAPR02MB6006.namprd02.prod.outlook.com (2603:10b6:a03:120::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 04:31:00 +0000
Received: from BY5PR02MB6947.namprd02.prod.outlook.com
 ([fe80::259b:b0b6:7574:328f]) by BY5PR02MB6947.namprd02.prod.outlook.com
 ([fe80::259b:b0b6:7574:328f%9]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 04:31:00 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Bharat Kumar Gogada <bharatku@xilinx.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Michal Simek <michals@xilinx.com>
Subject: RE: [PATCH 0/2] Add support for Xilinx Versal CPM5 Root Port
Thread-Topic: [PATCH 0/2] Add support for Xilinx Versal CPM5 Root Port
Thread-Index: AQHYG9j9fzCCB50+a0qHkmZFwkrjpayHfwrg
Date:   Mon, 7 Feb 2022 04:31:00 +0000
Message-ID: <BY5PR02MB6947DBD1D5DEFAF24EC3E5ACA52C9@BY5PR02MB6947.namprd02.prod.outlook.com>
References: <20220207041250.1658-1-bharat.kumar.gogada@xilinx.com>
In-Reply-To: <20220207041250.1658-1-bharat.kumar.gogada@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 877a1409-4dab-45ae-8e7e-08d9e9f2a4d2
x-ms-traffictypediagnostic: BYAPR02MB6006:EE_
x-microsoft-antispam-prvs: <BYAPR02MB60061CAC49932CB18B9CCE7AA52C9@BYAPR02MB6006.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ACiUA2E2kPg0H1do37bD0vytkJYWGPNxz8ekqhnkmM+MsZDPgdnry4Wn2RtIkCvRk8Rx+9jkqxms4j0s3SfcV7cFDJ+BGlWI21N1OJHVPI/d+Wjdw77U/ANBDQVzVhChVhruJAD0csqtCFD7bToTI5OgSIaOjn94BDHaHoD0CrfFmPoKXcke2J12KlfgC9P+G9L6ZQxdUPDKLgWzg7LuhkGO3zJHz8t7iuCMT3WtGSqail0dPsYqMOza7ZzE9LXdYUzHDBgBOAA/qWWeZCx9lzBn7Hb9cTTqp+A5s/WlyhaiBLZ75Ox4KWqt/ngk9wr1sLqmORvr6ohpVzMAh2hb8Lu/wV8/KEOHGN+hncwzzxm+4ANqW3OtQ9I1EYIyvVRM7KQcp2g9JTRlzxjzxs2PqwmDCSQxcdThtzV34GHnlP6HwKueWPHw8CS67L3y3/XZqIt1h7+uzKMhinfBYUkdVTsp6F+ABL7dH7B65nVOehrc/NFTj+Z49Wr7KmEh5cRS/vjH73Ord0eT24zgyuWs33ezvgpD93/mN3VmxBzBduxQcIKPgsHjQTsEALxV5g1HEYUqx2s8kLNiyBOGiGzoZhbD2X8dE9J9s1hdgq+Px2rKgvEMoyAEChJoubBbiYer9YdO6xOkfcLzJG+QuzqLmQu3mxKZZ4Gj/LG+4o6RrYunxy1B0cEkOf/+yswOTqEEMpkyBmBxS3B9T9fWH21cgg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6947.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(122000001)(9686003)(6506007)(38100700002)(53546011)(86362001)(38070700005)(110136005)(7696005)(54906003)(71200400001)(2906002)(186003)(316002)(76116006)(66946007)(83380400001)(66446008)(64756008)(55016003)(66476007)(52536014)(8936002)(4326008)(66556008)(107886003)(26005)(8676002)(33656002)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w8jtRWtHDpsymrcQwmVHizpa/mULhhW2swX7U1k2rRBlp5wjr1v3893qPZEE?=
 =?us-ascii?Q?Pvu18grRakvuMA6kyPdyYmOBxVqP9OEooiyOcSwHMRJjFiwYVuefDb1OvAV8?=
 =?us-ascii?Q?PDwKooVqNNoJzyxXsUJu9FJk4bxT6oe8Ee0ZoXvF8CZAFyWDDOBVFLKQZpw9?=
 =?us-ascii?Q?KavB2/u/MVsudrVzmYtpBqkknnYJ6Gts8LWf8MW0RwApsW6e9BTzbJUMqCrv?=
 =?us-ascii?Q?ie/XhyHHEhcQCj/EFlvuqSZLsX/AZmhNgPMnjYtB1xanA52JTBNSJTU0Z5WT?=
 =?us-ascii?Q?w7nJPaoC0AWyok1DBrIVJXJqgUyAOiF1QYcBwCQ6giBVHXPumjJX6yVHxpkW?=
 =?us-ascii?Q?P9QBE6RUHpLkizxambVHkWrJ2+8ElmxGG3IHSkHC8MKfHkWQP8lENpuuJwTk?=
 =?us-ascii?Q?OBzUS9pycyBuS20QZ+yzDsMUo+zY3nk4+8L1r8dnyjnxSYfMsVBwisdu4sJn?=
 =?us-ascii?Q?rDf3F0abDW105bSOu41M9geAHg0EKkCSVp+BZLvVrK4Uolo09ADZPhotNUbj?=
 =?us-ascii?Q?fXk0kDRJOVNVoiO/qVZvcUm2yvsIVzzGkoz0ZQJukYfa+9zQ8Jeij8LDHFCi?=
 =?us-ascii?Q?O4a7ECnjiS25ezBDyZNn0HBc7fvKeafv0b7b0D34C7e2OSzZTiqo3E7q+gjL?=
 =?us-ascii?Q?YcfgSHhbImhNoYkJnWsP9FzVF5R8HdCjaWk28ppPzqBdrKMiRAXpaG0tzpdK?=
 =?us-ascii?Q?0yXVRFI9kLzjMdWULSKFy5rd8dSbv63O0glbOhENck5KZg8pQJqiPTC37WvQ?=
 =?us-ascii?Q?5zkHbDjyAiofkkymaXoYYsp5HVAE/7gwQx/obZIgjslHlaoeiACB4WfjBeJT?=
 =?us-ascii?Q?qleGr8Kq/N2ffEcdatBY9api6eww/gLWTMG20TXUImiTqzlN2iDFSzsa8wxg?=
 =?us-ascii?Q?h3l/kDMlO/DUzYMhIFfriPhPpzdv+m2cN1jI0rFZPYjtGBiGGeMAl8VRqqIm?=
 =?us-ascii?Q?BH69+gZZvg+jF/M8+SHxasY7P4vnYNKiXjZLYHIVYmq1tgQI7xxtqGJa67c0?=
 =?us-ascii?Q?uKFnoLZDOjkmUwB7upP1Glnxup1PenNvFXD+Gu+J6kbNp7CQyTyhq7+iAmW7?=
 =?us-ascii?Q?+nNV8D7CcJm/neX1/Yp3m6AyOq9RCcA/3ss1nqRwTR2uZbX84Dk4gf/JvzOX?=
 =?us-ascii?Q?quQ53yv0kRmDQkZkCdZss/6OaasFSb3E7rV/dJjj9tMeMfJ2w9IOtC280brk?=
 =?us-ascii?Q?fIpKflF+myVEJ9hEcVPiGoVYLL2ImIG+rN7kNoabsT4jOeNSVuNl6UGK3EW0?=
 =?us-ascii?Q?OCKVMeyYopdrngRVtFN1d+WfOcaPlDC9kIFOvAxRaarGcYsUECvJ1MSaeN5d?=
 =?us-ascii?Q?rVZDdM4aywtODG1fBvf91zCu8QYmEoxP8/k+CuMnDxC+/k4sXLwbwii7m4/B?=
 =?us-ascii?Q?DMScd/Y8DcCDEfozyAXhq/EYtGdJMCbOdimeSMBQf2Ml8oxLk7PWnKD4r7H7?=
 =?us-ascii?Q?xepTkRv2QCXBg2AwU+7VS4vjA+Lv4Te6OnkNV9YeE4Io5v3v4PuEP4XTX4Cq?=
 =?us-ascii?Q?eqQxRA7b1oV7k0C+zLABQ9GlNbtzGnqlqVGBDxD2vRr08kRuJEvUIEKniOx7?=
 =?us-ascii?Q?dTpWy+7JL4trlNPDdonHSZMrhG1rlv2Uw358FLdw55PdhisJnOdI044mHGpO?=
 =?us-ascii?Q?G8cO26BtRbEupfIbjsmGu8Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6947.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 877a1409-4dab-45ae-8e7e-08d9e9f2a4d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2022 04:31:00.5317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N9JvLXQ8Ak34R4nfkHlIC5OxArEeAhOGuhIMzLUhM7W+hm0/azYEBXNRulTf9Subw3wqkLa5CiQS/AalDgHXag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB6006
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

Sorry for resending, my mailbox didn't show one patch, resent this assuming=
 patch was missing.

Regards,
Bharat

> -----Original Message-----
> From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> Sent: Monday, February 7, 2022 9:43 AM
> To: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: lorenzo.pieralisi@arm.com; bhelgaas@google.com; Michal Simek
> <michals@xilinx.com>; Bharat Kumar Gogada <bharatku@xilinx.com>
> Subject: [PATCH 0/2] Add support for Xilinx Versal CPM5 Root Port
>=20
> Xilinx Versal Premium series has CPM5 block which supports Root port
> functioning at Gen5 speed.
> Xilinx Versal CPM5 has few changes with existing CPM block.
> - CPM5 has dedicated register space for control and status registers.
> - CPM5 legacy interrupt handling needs additonal register bit
>   to enable and handle legacy interrupts.
>=20
> Bharat Kumar Gogada (2):
>   PCI: xilinx-cpm: Update YAML schemas for Versal CPM5 Root Port
>   PCI: xilinx-cpm: Add support for Versal CPM5 Root Port driver
>=20
>  .../bindings/pci/xilinx-versal-cpm.yaml       | 47 ++++++++++++++++---
>  drivers/pci/controller/pcie-xilinx-cpm.c      | 33 ++++++++++++-
>  2 files changed, 72 insertions(+), 8 deletions(-)
>=20
> --
> 2.17.1

