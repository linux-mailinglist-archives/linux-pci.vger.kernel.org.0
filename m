Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75C3F135922
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2020 13:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbgAIMYV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jan 2020 07:24:21 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:56488 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729570AbgAIMYU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jan 2020 07:24:20 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 92BB0404FC;
        Thu,  9 Jan 2020 12:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1578572659; bh=mXKVk1YJUmZuXK/tURsj3Of2ftPlWP8eNgaINxS/J+g=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Iym9XyyfgRvUTPp0zqFB54FtPMEdMoUWA7m/WvgfjwAY48m9BTDolG/3IKOZseIJS
         4nJDywnAI7F77tRXG+bTdjgzcrLAEwpI/mRIGaGTWIbxKSwfuP+sokECTO+K9zUIdu
         5QA/aNbQCtTsNsTsDAd2DaDB33lB2vxBeXvik/Kae7VMC98JEMNovaHZf+us6gYxij
         M5tYzEfRQdXYjLIA9+dMgE2EhA1VrUdexfEpntQvLJwzfRxH4k3YQUCYXU55RMdXCG
         wKNWBxpB/Glg7/qXhIrsqqCGj9vHzz5dTuStPTAGaiGepBDPC5ycuqyZNl3dTIYzz0
         wn1/ZGY6TxyIg==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id DDBE2A007F;
        Thu,  9 Jan 2020 12:24:18 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 9 Jan 2020 04:24:19 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 9 Jan 2020 04:24:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRa4d/rBuNT7cZj1P4/dsDrYJTuAD9bXTSAfHtDjbI7olC1SqSolEvXEWs9NNuVmjFOm5e3027AaCSouPcYRQo5jQXJ4E/QXdfYr/StqJl51GRrwY31hqwcSjO6qqb1HmofE1iNLKHU9HvksZmKGnCCio1Esdmynu8ljEnUJm9nWNKl8LMa3fM/vxlXfgdj7fY4JW16YxuKgtWoG8KinETjqxivbgv/L9NatxmV3OJm7GkDu43mEQ8WVel7ZJo6S3S2krbmUx6oA5dBNgi1/ZFeJZd+OlT5FOl6oM9xJfWn2pP2WQZMJDXjEM2uz7XbavNvMS/BbtZpVujmSaZ6xUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7zUyeG9bYpMAPZejAT14KKn+stA0oje9cPvAo3lp10=;
 b=jpNNMx/5a0sLBG6V3cVSvNkqFjVmdB3xnmjtwL0XTMrP2jssVA85DgCJj6URrKhQWO4yNqsS9+AOXzSAC5GEiYvGYbUDQ5LwGjLv5aziv3n+r3KNl3E6ZQHygLTpqNAuFUmwjxFc/PXMNfNJDxUovP7tRTjWYLXbaptBrh9KaZRyj2y1iawmW32bIjZv2/VZEDgz5lx+u6A7RRVyA28yPPszweXhD9BA2WuZ/NVu4UIJWoYxoD+Tg6OF79J8wUzp7/9YeImoEwvs80LqEEl3F1d7WRUP9t/n22I6ow9aJAZIEBViIZ034s9exiKpzkQZO6j+5RzMK3Fz/E4EEIEYeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7zUyeG9bYpMAPZejAT14KKn+stA0oje9cPvAo3lp10=;
 b=ePXbQ8VHx0bZkOVJ4YpT9P0kHpKEaLlKDU1LyziwrMXldcVtMNKWGOF9I8FYttyLEGG9/Ujdozf/9EQhek4wrwzv4honu/ztB1eMwuVdinrS38f4iWJ+W8jkbkM1SbzPOWrtJyuXImnmwGItE0WzaXHiyEac4RjXBEtDiHmtZXM=
Received: from CH2PR12MB4007.namprd12.prod.outlook.com (52.132.247.78) by
 CH2PR12MB3656.namprd12.prod.outlook.com (52.132.247.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.15; Thu, 9 Jan 2020 12:24:17 +0000
Received: from CH2PR12MB4007.namprd12.prod.outlook.com
 ([fe80::f0e2:26d5:2de4:a4b7]) by CH2PR12MB4007.namprd12.prod.outlook.com
 ([fe80::f0e2:26d5:2de4:a4b7%6]) with mapi id 15.20.2602.017; Thu, 9 Jan 2020
 12:24:17 +0000
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Shawn Guo <shawn.guo@linaro.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Zaihai Yu <yuzaihai@hisilicon.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] PCI: dwc: Separate CFG0 and CFG1 into different ATU
 regions
Thread-Topic: [PATCH] PCI: dwc: Separate CFG0 and CFG1 into different ATU
 regions
Thread-Index: AQHVxrM2VgaKtZy4DEuFjdLeK+xovafiI44AgAALGQCAABIH4A==
Date:   Thu, 9 Jan 2020 12:24:17 +0000
Message-ID: <CH2PR12MB4007CC62E0939BAAABA0E64FDA390@CH2PR12MB4007.namprd12.prod.outlook.com>
References: <20200109060657.1953-1-shawn.guo@linaro.org>
 <CH2PR12MB40073FCB953227A37F7A1A91DA390@CH2PR12MB4007.namprd12.prod.outlook.com>
 <20200109111457.GA18850@T480>
In-Reply-To: <20200109111457.GA18850@T480>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLWYxZjI5YjBlLTMyZGEtMTFlYS05ODllLWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFxmMWYyOWIwZi0zMmRhLTExZWEtOTg5ZS1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjM2NDMiIHQ9IjEzMjIzMDQ2MjU1MTk3?=
 =?us-ascii?Q?MjI2NiIgaD0iVnFET1J4SFBlUE52V2s2bk1Jbm9RQXVRZTFnPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFD?=
 =?us-ascii?Q?cVdlVzA1OGJWQVVyeGs5SFZ5cHRnU3ZHVDBkWEttMkFPQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUhBQUFBQ2tDQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQVFBQkFBQUFFR0lZelFBQUFBQUFBQUFBQUFBQUFKNEFBQUJtQUdrQWJn?=
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
x-ms-office365-filtering-correlation-id: ad3bbb40-4ef4-4818-5b45-08d794fed87e
x-ms-traffictypediagnostic: CH2PR12MB3656:
x-microsoft-antispam-prvs: <CH2PR12MB36568EF6E1584D93F6329EDCDA390@CH2PR12MB3656.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(39850400004)(346002)(376002)(199004)(189003)(6916009)(54906003)(55016002)(9686003)(76116006)(71200400001)(86362001)(478600001)(316002)(6506007)(7696005)(26005)(66556008)(53546011)(186003)(33656002)(64756008)(66446008)(66476007)(4326008)(5660300002)(66946007)(52536014)(2906002)(81156014)(81166006)(8676002)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR12MB3656;H:CH2PR12MB4007.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mkKVQRl8NUxWZZMfFXOLWXd+ydcYzX9SnkZFofvVx07B8TZJGAUgPXVoFfHJSM94bjNIwOf7XxZBADht+NY2x2RIzy69+OID5P6XJ8r6+IKgrRO7K29T05xeHTB/4XlStPR7OIf4OhgZvySHgHMH5j4RnBiyX0fUkSoXw7pXqF5iIpgq8f8CBJ/5o+Led4oMudGBTWbrwiiAuatZOhXHf69PVaBTLm6givEhL7LF6+m4VdeYY1eAeXRuVqD3fXKkYCJb690VtlgaJWwkdMVg2G5U/vl8aj8D7mgV/SZxZLbwuQn4QQEwD+dCJEg95hAU5UTHB3eRGEIxh43f1gKM0tLw5SlSBatIzd2kR/VZKpXFI7pbhmsERC/DPKPsqGCZwypYytC8+pjBR80XWrUd1DVcEkumRha2d06IlSC+UdQBL0sTQqoaK+L6E9TzOhW/
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3bbb40-4ef4-4818-5b45-08d794fed87e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 12:24:17.0388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s1G2b3iMm7p1U92p0RGp7lOClf5dHSQqAyJ4y6cfQCGY9lA3NQ8Pwj0nAjkrPECPA34oQwgEqGWqnUYnmmBsxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3656
X-OriginatorOrg: synopsys.com
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 9, 2020 at 11:14:58, Shawn Guo <shawn.guo@linaro.org> wrote:

> Hi Gustavo,
>=20
> Thanks for taking a look.
>=20
> On Thu, Jan 09, 2020 at 10:37:14AM +0000, Gustavo Pimentel wrote:
> > Hi Shawn,
> >=20
> > On Thu, Jan 9, 2020 at 6:6:57, Shawn Guo <shawn.guo@linaro.org> wrote:
> >=20
> > > Some platform has 4 (or more) viewports.  In that case, CFG0 and CFG1
> >=20
> > Remove double space before "In that..."=20
>=20
> Hmm, that was intentional.  My writing practice is using two spaces
> after a period and single space after a comma.  Is it a bad habit?

I thought it was a typo. I personally don't have anything against it, but=20
I didn't see this style on the comments till now. To keep the coherence=20
between all patches, I know that Bjorn and Lorenzo like to have it the=20
most standardized possible. It is OK by Lorenzo and Bjorn, it's fine for=20
me too.

>=20
> @Lorenzo, @Bjorn, let me know if you guys think this should be fixed.
>=20
> >=20
> > > can be separated into different ATU regions.
> > >=20
> > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > ---
> > >  .../pci/controller/dwc/pcie-designware-host.c    | 16 ++++++++++++++=
+-
> > >  drivers/pci/controller/dwc/pcie-designware.h     |  1 +
> > >  2 files changed, 16 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/driv=
ers/pci/controller/dwc/pcie-designware-host.c
> > > index 0f36a926059a..504d2a192bba 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -532,6 +532,7 @@ static int dw_pcie_access_other_conf(struct pcie_=
port *pp, struct pci_bus *bus,
> > >  	u64 cpu_addr;
> > >  	void __iomem *va_cfg_base;
> > >  	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> > > +	int index =3D PCIE_ATU_REGION_INDEX1;
> > > =20
> > >  	busdev =3D PCIE_ATU_BUS(bus->number) | PCIE_ATU_DEV(PCI_SLOT(devfn)=
) |
> > >  		 PCIE_ATU_FUNC(PCI_FUNC(devfn));
> > > @@ -548,7 +549,20 @@ static int dw_pcie_access_other_conf(struct pcie=
_port *pp, struct pci_bus *bus,
> > >  		va_cfg_base =3D pp->va_cfg1_base;
> > >  	}
> > > =20
> > > -	dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX1,
> > > +	if (pci->num_viewport >=3D 4) {
> > > +		/*
> > > +		 * If there are 4 (or more) viewports, we can separate
> > > +		 * CFG0 and CFG1 into different ATU regions:
> > > +		 *  - region0: MEM
> > > +		 *  - region1: CFG0
> > > +		 *  - region2: IO
> > > +		 *  - region3: CFG1
> > > +		 */
> > > +		if (type =3D=3D PCIE_ATU_TYPE_CFG1)
> > > +			index =3D PCIE_ATU_REGION_INDEX3;
> > > +	}
> > > +
> > > +	dw_pcie_prog_outbound_atu(pci, index,
> > >  				  type, cpu_addr,
> > >  				  busdev, cfg_size);
> > >  	if (write)
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/p=
ci/controller/dwc/pcie-designware.h
> > > index 5a18e94e52c8..86225804f1e7 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > @@ -63,6 +63,7 @@
> > >  #define PCIE_ATU_VIEWPORT		0x900
> > >  #define PCIE_ATU_REGION_INBOUND		BIT(31)
> > >  #define PCIE_ATU_REGION_OUTBOUND	0
> > > +#define PCIE_ATU_REGION_INDEX3		0x3
> > >  #define PCIE_ATU_REGION_INDEX2		0x2
> > >  #define PCIE_ATU_REGION_INDEX1		0x1
> > >  #define PCIE_ATU_REGION_INDEX0		0x0
> > > --=20
> > > 2.17.1
> >=20
> > With the description fix,
> >=20
> > Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>=20
> Thanks!
>=20
> Shawn


