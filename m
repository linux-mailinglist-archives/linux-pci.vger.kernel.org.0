Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84EC91278D1
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2019 11:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfLTKHn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Dec 2019 05:07:43 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:37748 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727180AbfLTKHn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Dec 2019 05:07:43 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 41C4F4245C;
        Fri, 20 Dec 2019 10:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1576836462; bh=JLRSs1nY9XXJmB7hWv7XvEZxVgMd5e5IMNiLoxvdhsQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=LEvYf7U9nsEilcBcuAKYX2Fg7mr5PzxfHkoAqh8OCSTD9sguEY/i/v46eEFSiHBr3
         KLMBdSeqyKG/il7m9kqRHcUf3wKdbFP8VY/eIOD8fKokSBg2ZLBrjJwvzsD/X2ks9e
         Gz5cGAL6ztb0x2AfalEK7qJ34LZldEeL6HN7ZRWiPm7zLVgPZqlHZGie6TZeB9c8E+
         MxESzS4OmXh3Sb1h7U0refq+KUiIi8vR8kQSdTwaeQiPCKfsvkWXWyhzEw9qPmerDX
         VN4fGpNTS9P9wrH1jhAOU+GgWp0gb3cLGXL60yk1+xFqqMDUswTC0PXAB+QHSIJ5kK
         XsBLaWFJOuZhA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id A8122A007D;
        Fri, 20 Dec 2019 10:07:41 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 20 Dec 2019 02:06:54 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 20 Dec 2019 02:06:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QR2uTENtoJEvM7z81Cns2uEfEGtopSI6p2udSqGTHXD1IRqdzARx5W0UjQF0P/Vgn7UnCHemVtxjvBBOtCvxVjtTNTjTx8VuKbBNclhUakpqUEcQ30D7CHOCA5bZ+YdLYVOssVbGa9asXK4lRsoN/6aysUOiJkJNDjLIlTw8Dc5HI+4zNzUIxpYiLiZWmK0dD5uHP/7k7f56Lf5Ebovh81bRIuK8+JfYfT+WgNX8UyKQVpfgIpFTBbbn7EUSmjYihrQD5TptYa+9TywIxGMO3Dl5+PmaAPBkI3WSBV2iJx/lgIwS1DOsV7d0toGETIYp/4dLPkPBJRFDbYZkiXgKHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNpmnyBhB2vOSPMZLpBb7GVqDEETJ79jtwE5Uk+9L6o=;
 b=ROwviWP90zzzhYqAaIgLth80Uel9W95BIrgLGWWWx3HGRNvkPyi82xTWYmSH7HzImYfvwJoJKmPiqOxlb9JBABWhcOE5yY9rk3HlzJN0ooeH8nIvu9Ujds9Yjm/+2Wdhkk4YTy8oDjO43guu9OdqSUqHWnGL1tTQhdp3U5RqBFVEOt7u7L5/qTa3B2jVLrcMxw/URcFzVUfhVjPV1RaArbu9ChQ5bMEX9LqlxR38AROmDvMRn8cH9TuCTw7JJU66HxAHpDMu7ObX8HEepdzrtNss03jZd0qCoyzOmSpa7JCHE1ZU00gKHGXTvNPYaQmsF0VEpgqUXRt167sD0iJKPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNpmnyBhB2vOSPMZLpBb7GVqDEETJ79jtwE5Uk+9L6o=;
 b=SDYzkeT7jFVszVcCuIQBfH9DVNJtNxwUnHNL5sKCZ2UNCLcWIdsGkDtNjrsVKYhF5x/jF6aqZkrHDRsNGmG3IDm75UoY8iiBIio3PsAd2py3pgDyBClqKY1VI4fZk+tl/JMr4DagPkJgHZ5ishNCXjGPTT6NVaSNCPIsfJBJca0=
Received: from CH2PR12MB4007.namprd12.prod.outlook.com (52.132.247.78) by
 CH2PR12MB3943.namprd12.prod.outlook.com (52.132.246.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.20; Fri, 20 Dec 2019 10:06:52 +0000
Received: from CH2PR12MB4007.namprd12.prod.outlook.com
 ([fe80::91dd:c9b2:778a:5b08]) by CH2PR12MB4007.namprd12.prod.outlook.com
 ([fe80::91dd:c9b2:778a:5b08%6]) with mapi id 15.20.2559.016; Fri, 20 Dec 2019
 10:06:52 +0000
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: dwc: Use private data pointer of "struct irq_domain"
 to get pcie_port
Thread-Topic: [PATCH] PCI: dwc: Use private data pointer of "struct
 irq_domain" to get pcie_port
Thread-Index: AQHVtxzsA9tmkyvMcEKavM47bnlVf6fCzBkQ
Date:   Fri, 20 Dec 2019 10:06:52 +0000
Message-ID: <CH2PR12MB40079F8FCD26E58EF9C5B48FDA2D0@CH2PR12MB4007.namprd12.prod.outlook.com>
References: <20191220100550.777-1-kishon@ti.com>
In-Reply-To: <20191220100550.777-1-kishon@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTZmOTI5ZTAxLTIzMTAtMTFlYS05ODllLWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFw2ZjkyOWUwMy0yMzEwLTExZWEtOTg5ZS1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjEzNjkiIHQ9IjEzMjIxMzEwMDA5Njgz?=
 =?us-ascii?Q?ODcyNiIgaD0iOVNvSHI0VFpmaUVPSWh0Yk5RWm8vbDh2QkF3PSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFC?=
 =?us-ascii?Q?RzNPd3hIYmZWQWJ0Wnk4bnhCdWQvdTFuTHlmRUc1MzhPQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: dbd70756-6715-4597-a947-08d785345619
x-ms-traffictypediagnostic: CH2PR12MB3943:
x-microsoft-antispam-prvs: <CH2PR12MB3943277BAA058D4DADE5F8F3DA2D0@CH2PR12MB3943.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-forefront-prvs: 025796F161
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(346002)(39860400002)(396003)(189003)(199004)(66446008)(54906003)(110136005)(53546011)(7696005)(186003)(8936002)(33656002)(86362001)(81166006)(8676002)(316002)(64756008)(4326008)(6506007)(66946007)(26005)(81156014)(76116006)(52536014)(66556008)(5660300002)(66476007)(2906002)(9686003)(55016002)(478600001)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR12MB3943;H:CH2PR12MB4007.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AwZ54cdMhpQwZhXNOZGzsTt8BbPomdZ0elz/zBwgp0d6oaRnpV590zETp6UjlrA1jgKUP/SpHL2atlggA9Hm6XBlf2Lb30CpQ6Ogv15PWNIvG3I578pBAzqCzIUwMgczOD82QpS8aKWE3dH7VCQiMpmJKsY1g9OjrNGAvA27VLyySeys18QYhJDLRSPlIzKtEi3fREYrion20O+138rdXtD5qPiqwF96B2S+TRcmcKIJYFZPTRG77RkSdBNCn/H6drdNm4Xra5z40FPhDylZy8vTTJKdpqRhTFwUaGsBQhWa5iHpRbjl2M5I3fTfqEqWXkfa4T0FMXVoHpCSfjpODPtIcCf2yswim7PXwf5q4Pt4wohj+bZ8DMVN+FcLtdn6qyFwtHt/21pfzJrf4oUjF5s+/CC+03DvpNA/7N+lOfW0nhFpmHFK/eG9Po9Hk7GF
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd70756-6715-4597-a947-08d785345619
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2019 10:06:52.4730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VxWUctLMWcTgUaBmE6Q1mkSKhUVdkJ5jnpEYe2t7ycJn7c3I97N8kwiungU8CX21Y5/en0/I1t6UN6R/bFljsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3943
X-OriginatorOrg: synopsys.com
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 20, 2019 at 10:5:50, Kishon Vijay Abraham I <kishon@ti.com>=20
wrote:

> No functional change. Get "struct pcie_port *" from private data
> pointer of "struct irq_domain" in dw_pcie_irq_domain_free() to make
> it look similar to how "struct pcie_port *" is obtained in
> dw_pcie_irq_domain_alloc()
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/=
pci/controller/dwc/pcie-designware-host.c
> index 395feb8ca051..c3d72b06e964 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -236,7 +236,7 @@ static void dw_pcie_irq_domain_free(struct irq_domain=
 *domain,
>  				    unsigned int virq, unsigned int nr_irqs)
>  {
>  	struct irq_data *d =3D irq_domain_get_irq_data(domain, virq);
> -	struct pcie_port *pp =3D irq_data_get_irq_chip_data(d);
> +	struct pcie_port *pp =3D domain->host_data;
>  	unsigned long flags;
> =20
>  	raw_spin_lock_irqsave(&pp->lock, flags);
> --=20
> 2.17.1


Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>


