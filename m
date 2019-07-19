Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 860296E269
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2019 10:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbfGSIZN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Jul 2019 04:25:13 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:54544 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725853AbfGSIZN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jul 2019 04:25:13 -0400
Received: from mailhost.synopsys.com (dc8-mailhost2.synopsys.com [10.13.135.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CBD42C01D7;
        Fri, 19 Jul 2019 08:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1563524712; bh=9ySvO9nVpZXcAzDe1jqpJcGdHi4caqi/xUl/Lgx8E1c=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=DK/xGSrI7dTL8fDiILYu4p2VJKL6KyyLE3X8XlQRVJQ6j2zCKrZvJ+rf7nI1nI0W9
         JjU42BnZDlrAXaeO2GrERXM3+GomzrKjubr2wNTS6oZRO70h8jAQW5OfqRSqWTwtQK
         M7vhTIaW6lZYs7fnbkGZCUSDE9CzmDZguaoJ3mNPZHh60RTrftDIS4V1gml6RH1Aw/
         KS5zDgF2QFkoDNAKVBNrhqGlJzwtHC/I+Nonm1IWOKlCX/5udSLbR/lzQV87XgMplj
         1dKwjgyJBtLfrkEyUgTbSjIRDAo6Ps1a9gQpgxwRSIWLyi/PMTd/xNHxBUcJKWzf62
         JJq1q1gDFxkrQ==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id A611FA0067;
        Fri, 19 Jul 2019 08:24:51 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 19 Jul 2019 01:24:33 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 19 Jul 2019 01:24:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8gBqBEsUCGdyz35fQTRb2C+3x4LQuY3AQ9W9PigocA3+fl1AlfAhGjYBDwTWM0NTBcdmqge+rdzCNWmFSe1W60ylbn/M8Ftno+Gtr7P1EWn98LxHEfXG0S5N+bflzjnyIhxdvWhyFda2zhyzOcnfQTYjqjYnECoH0Um2b70QgUk1nkTS795EMwUQj6oOwUhQmMog9Xpa+wgVqs2g3cQAe23ryzvG+QN1qzPudHBryR8CAdn2HlKZNNgS5wdTmeoqzBknrYtwBj9I1JXMj/uhsRBwrlQD29+iWkfmLHmnMPj11FJL0nyB/6SseyJH1irg6xKtp3DayGEPf4WKPJh2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfmpOTa1yT2jUoNey2ACdDbzG+iPk71Dd5geitqkFng=;
 b=LZFkag7n+s4szGDCPnRWbSAxs/LRKLv7RbIDoN1XNOwUAW5e7tceD+vHN30yZjZGRFTxSk3HwENggr+cqRFMqJ7QXctpRP61GkKgyKleZ+rQSA1+ofy3Xx0F6qsh6Iwc0RGiGcUQvxwu+HKRJDSuEHLSgekovknK2HIDpmgS97JeU60uBo58tCc0F9dfXRWd9PHojh/ZmBGdp6J89M7YfmmywGf/Kw98a71EB+Og3YwmaewDOpSshXNJDvAwkZeJSiRyDC/AjzWEPBunL2diYDdwk/cqovkDsVzmQoodOFTm/oLWuHymus+zkd3bsuDHe4F0hAH9uYewBM+GQstJyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=synopsys.com;dmarc=pass action=none
 header.from=synopsys.com;dkim=pass header.d=synopsys.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfmpOTa1yT2jUoNey2ACdDbzG+iPk71Dd5geitqkFng=;
 b=I4dvG3HbQeZIjXltGTsD41+5MxSCUrPpReKBvWIDESVIUBLL1mZUJISgn36WYUUEP6IIGbSYZEE3bCPVG5bY31L2XTvnfMq6B6/Q9QK8QbJvcM4y5wQs42Xn6WTU9C9eqGZdCtCxB4VDP4Nphzml0oxbCN1Il+9t0BN2/4TsRio=
Received: from DM6PR12MB4010.namprd12.prod.outlook.com (10.255.175.83) by
 DM6PR12MB3690.namprd12.prod.outlook.com (10.255.76.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Fri, 19 Jul 2019 08:24:31 +0000
Received: from DM6PR12MB4010.namprd12.prod.outlook.com
 ([fe80::2dc8:6bc4:3d9d:9203]) by DM6PR12MB4010.namprd12.prod.outlook.com
 ([fe80::2dc8:6bc4:3d9d:9203%4]) with mapi id 15.20.2073.012; Fri, 19 Jul 2019
 08:24:31 +0000
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Jonathan Chocron <jonnyc@amazon.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <Gustavo.Pimentel@synopsys.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "alisaidi@amazon.com" <alisaidi@amazon.com>,
        "ronenk@amazon.com" <ronenk@amazon.com>,
        "barakw@amazon.com" <barakw@amazon.com>,
        "talel@amazon.com" <talel@amazon.com>,
        "hanochu@amazon.com" <hanochu@amazon.com>,
        "hhhawa@amazon.com" <hhhawa@amazon.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 3/8] PCI/VPD: Add VPD release quirk for Amazon's
 Annapurna Labs Root Port
Thread-Topic: [PATCH v2 3/8] PCI/VPD: Add VPD release quirk for Amazon's
 Annapurna Labs Root Port
Thread-Index: AQHVPU3WtsXRG+xtuUmLPkPGEvDZ1abRm9mQ
Date:   Fri, 19 Jul 2019 08:24:30 +0000
Message-ID: <DM6PR12MB4010BDFACD5974E310435D8BDACB0@DM6PR12MB4010.namprd12.prod.outlook.com>
References: <20190718094531.21423-1-jonnyc@amazon.com>
 <20190718094531.21423-4-jonnyc@amazon.com>
In-Reply-To: <20190718094531.21423-4-jonnyc@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTlmMzI1MzMyLWE5ZmUtMTFlOS05ODhjLWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFw5ZjMyNTMzNC1hOWZlLTExZTktOTg4Yy1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjE4NTciIHQ9IjEzMjA3OTk4MjY3OTI5?=
 =?us-ascii?Q?MzkwMyIgaD0iZ25DUDg4dnVDZFdNbkVTTUlKMEJudjAzajRFPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFE?=
 =?us-ascii?Q?UC80bGhDejdWQVNjbnRXZG91VEZySnllMVoyaTVNV3NPQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUhBQUFBQ2tDQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQVFBQkFBQUFGdGJCcHdBQUFBQUFBQUFBQUFBQUFKNEFBQUJtQUdrQWJn?=
 =?us-ascii?Q?QmhBRzRBWXdCbEFGOEFjQUJzQUdFQWJnQnVBR2tBYmdCbkFGOEFkd0JoQUhR?=
 =?us-ascii?Q?QVpRQnlBRzBBWVFCeUFHc0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHWUFid0IxQUc0QVpBQnlBSGtBWHdC?=
 =?us-ascii?Q?d0FHRUFjZ0IwQUc0QVpRQnlBSE1BWHdCbkFHWUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFB?=
 =?us-ascii?Q?QUFBQ2VBQUFBWmdCdkFIVUFiZ0JrQUhJQWVRQmZBSEFBWVFCeUFIUUFiZ0Js?=
 =?us-ascii?Q?QUhJQWN3QmZBSE1BWVFCdEFITUFkUUJ1QUdjQVh3QmpBRzhBYmdCbUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQm1BRzhB?=
 =?us-ascii?Q?ZFFCdUFHUUFjZ0I1QUY4QWNBQmhBSElBZEFCdUFHVUFjZ0J6QUY4QWN3QmhB?=
 =?us-ascii?Q?RzBBY3dCMUFHNEFad0JmQUhJQVpRQnpBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdZQWJ3QjFBRzRBWkFCeUFIa0FY?=
 =?us-ascii?Q?d0J3QUdFQWNnQjBBRzRBWlFCeUFITUFYd0J6QUcwQWFRQmpBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNB?=
 =?us-ascii?Q?QUFBQUFDZUFBQUFaZ0J2QUhVQWJnQmtBSElBZVFCZkFIQUFZUUJ5QUhRQWJn?=
 =?us-ascii?Q?QmxBSElBY3dCZkFITUFkQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCbUFH?=
 =?us-ascii?Q?OEFkUUJ1QUdRQWNnQjVBRjhBY0FCaEFISUFkQUJ1QUdVQWNnQnpBRjhBZEFC?=
 =?us-ascii?Q?ekFHMEFZd0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1lBYndCMUFHNEFaQUJ5QUhr?=
 =?us-ascii?Q?QVh3QndBR0VBY2dCMEFHNEFaUUJ5QUhNQVh3QjFBRzBBWXdBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFB?=
 =?us-ascii?Q?Q0FBQUFBQUNlQUFBQVp3QjBBSE1BWHdCd0FISUFid0JrQUhVQVl3QjBBRjhB?=
 =?us-ascii?Q?ZEFCeUFHRUFhUUJ1QUdrQWJnQm5BQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ6?=
 =?us-ascii?Q?QUdFQWJBQmxBSE1BWHdCaEFHTUFZd0J2QUhVQWJnQjBBRjhBY0FCc0FHRUFi?=
 =?us-ascii?Q?Z0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFITUFZUUJzQUdVQWN3QmZB?=
 =?us-ascii?Q?SEVBZFFCdkFIUUFaUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFB?=
 =?us-ascii?Q?QUFDQUFBQUFBQ2VBQUFBY3dCdUFIQUFjd0JmQUd3QWFRQmpBR1VBYmdCekFH?=
 =?us-ascii?Q?VUFYd0IwQUdVQWNnQnRBRjhBTVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFB?=
 =?us-ascii?Q?QnpBRzRBY0FCekFGOEFiQUJwQUdNQVpRQnVBSE1BWlFCZkFIUUFaUUJ5QUcw?=
 =?us-ascii?Q?QVh3QnpBSFFBZFFCa0FHVUFiZ0IwQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUhZQVp3QmZBR3NBWlFC?=
 =?us-ascii?Q?NUFIY0Fid0J5QUdRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFB?=
 =?us-ascii?Q?QUFBQUNBQUFBQUFBPSIvPjwvbWV0YT4=3D?=
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gustavo@synopsys.com; 
x-originating-ip: [83.174.63.141]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d47c449e-df89-4006-eab0-08d70c2285e4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR12MB3690;
x-ms-traffictypediagnostic: DM6PR12MB3690:
x-microsoft-antispam-prvs: <DM6PR12MB3690B0E58F77CA52665F30F4DACB0@DM6PR12MB3690.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01039C93E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(136003)(366004)(47630400002)(199004)(189003)(102836004)(66476007)(229853002)(66556008)(2501003)(64756008)(66946007)(476003)(66446008)(11346002)(53546011)(71190400001)(71200400001)(26005)(52536014)(256004)(54906003)(81156014)(7736002)(110136005)(76116006)(6506007)(86362001)(186003)(316002)(446003)(81166006)(76176011)(8936002)(5660300002)(4326008)(2906002)(25786009)(14454004)(99286004)(478600001)(305945005)(74316002)(7696005)(3846002)(33656002)(55016002)(6116002)(8676002)(7416002)(9686003)(53936002)(6246003)(486006)(68736007)(2201001)(66066001)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR12MB3690;H:DM6PR12MB4010.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 22xNC0qTeU3uiGg4LVZaIwufPMcIaqFyFvWjJxe/BpqGkQS9u9z0JT+K/3X8AvZnTqOWuTu4zcATxPm0p0YCnBGp082iHDG+cbUqGaAlYV7u91EFUX8mKHTWznSmBFPvOAUlBr0h4Tbs+YtrCFqPkgEgYFX5v4uD71mfvKGvgs0gU6G/qrOHjUolb0oLI43+l7aehUW6tPiPRUODI4wbyRba2yXnDlh66SI8kws/7NuFdA4PNLn0phV9iG/y+BXNHp9Z8v3BW4VzMs1op2eQsuI+A7aycgKI94ubOZqnokQ8+Y6EANsoZ76VJTfdTc0+SJtEqoW67Cdh2c9tSeTGlwIMfNjzcDl/b0NVxVJvk6DsX2S+ra6oTFPlZWytt/UB5meAXVPlWPk7CRbpTcLipYxB5PRmNlps8rTfeBlU1SA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d47c449e-df89-4006-eab0-08d70c2285e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2019 08:24:30.9188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gustavo@synopsys.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3690
X-OriginatorOrg: synopsys.com
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 18, 2019 at 10:45:26, Jonathan Chocron <jonnyc@amazon.com>=20
wrote:

> The Amazon Annapurna Labs PCIe Root Port exposes the VPD capability,
> but there is no actual support for it.
>=20
> The reason for not using the already existing quirk_blacklist_vpd()
> is that, although this fails pci_vpd_read/write, the 'vpd' sysfs
> entry still exists. When running lspci -vv, for example, this
> results in the following error:
>=20
> pcilib: sysfs_read_vpd: read failed: Input/output error
>=20
> This quirk removes the sysfs entry, which avoids the error print.
>=20
> Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
> ---
>  drivers/pci/vpd.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index 4963c2e2bd4c..c23a8ec08db9 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -644,4 +644,20 @@ static void quirk_chelsio_extend_vpd(struct pci_dev =
*dev)
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
>  			quirk_chelsio_extend_vpd);
> =20
> +static void quirk_al_vpd_release(struct pci_dev *dev)
> +{
> +	if (dev->vpd) {
> +		pci_vpd_release(dev);
> +		dev->vpd =3D NULL;
> +		pci_warn(dev, FW_BUG "Releasing VPD capability (No support for VPD rea=
d/write transactions)\n");
> +	}
> +}
> +
> +/*
> + * The 0031 device id is reused for other non Root Port device types,
> + * therefore the quirk is registered for the PCI_CLASS_BRIDGE_PCI class.
> + */
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x003=
1,
> +			      PCI_CLASS_BRIDGE_PCI, 8, quirk_al_vpd_release);
> +
>  #endif
> --=20
> 2.17.1

Seems ok.

Reviewed-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>



