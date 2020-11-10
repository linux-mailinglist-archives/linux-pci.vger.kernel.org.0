Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC12B2AC99F
	for <lists+linux-pci@lfdr.de>; Tue, 10 Nov 2020 01:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbgKJAQy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Nov 2020 19:16:54 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:33368 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730305AbgKJAQx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Nov 2020 19:16:53 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 183DC4014F;
        Tue, 10 Nov 2020 00:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1604967413; bh=f0V3to2fdib0NQgVAbsxRciniv9RbKPdyO3lHQ0A5+Y=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=MDPO5WQEurmMImiTfzcYglwddv4T0PEUJtpamC4mJlKen6FQ8DDyyq7A7xsGfnMIh
         hqNj7xZu+NChdFDMEaPBxnWA5VJVwCyadzM28q21z2ZA1gU/zHNYgHOp2wAdx1mgMg
         lGwbLITsJrjCFAECI9uBPXPNyngzU64cTHOAb1JUetWVXQDs1AqAr5wuPljoYHaZcL
         pHQng+xBhrKX1n5cLnu+UmQVSVZeMqY84BJyVPvaX46SFv1qAJfuNPzqOSZPMrOKIs
         409OJiBPRFXGhmPvg82twTW6R65Q95Xk+bPlfA8VBb0EbvLvHZC9ZDiViIEK21SglV
         Hc7OaJkKmU6gw==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 8B32FA0069;
        Tue, 10 Nov 2020 00:16:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id EF5AB4004A;
        Tue, 10 Nov 2020 00:16:51 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=gustavo@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="Ag8deJGL";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=civb765/V5N4Y2w1YofBS0McxUynYGGzt4v4fZ3azpIiV+Fl/zF5aDjuN08UpCfxeyEVGg8oCsOKmpSS8GBrL4I9yKH5GEQ259sholeFTPTz/D2jYsxuqCIWkyM64Abn1bf2DV/rS5j2XQK/0KJqbczDjOyIOzLjfR7e2RcvnkFc/0uqTXcAgH+9t218KaQG706Nd3SvrM5FXuHVwUmiKtb0GTIg9uEdjP/NXgRzAbJ7kzfJAStwWeJudcEsiPGwQv24eUxuoPK1Ymg1GfisRus4Fld4P+DWK4vt5VU7NJ7Zf3vb2yx/jxb61UZrZUBWkHMQ+lqynZRShv5axFbN2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goyL0YAbCXaTWTGzytLLUTEtlI/9KOOjBrhZQmTXVWI=;
 b=WlZPUKg5CZsbEUNDn9hxsOWdUGl5A4yGOgwKBRVwBj27BJAHMJgAuyZSEypFJqcACZZqnfPVqzK+8CjBZiyofW4H4cKKBaZK5LCE1L/i4LjqfdHjHGNJf6e7Zcfd+v+2at+qm7SC8y/1hOLFUsGGbiYD6lcuD7xuoiwRS8xTkx+r5h/cnfwcovwJ78OrBZ//eG1EWPkYJYDieJy+XqCLwWFXXROwmSL9rXZ/wIIuvWzSj+SGuCoQ9HDFecijvAmpBb4AFnewvSErNqVv1aN66BFoJn6M0J/8Lox6NtXMUhdmV9zo3KwRCBOgyxZMRzBZZXTLRurdcB9g2glNofuhdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goyL0YAbCXaTWTGzytLLUTEtlI/9KOOjBrhZQmTXVWI=;
 b=Ag8deJGLlsP2YAkNxbmJ1uuaNqjRRVc7sF8AqdgvhCiFjNQf1RTXtWTUcamzR0yVI/h0FNOQOZ7ohQncM0Rf3NBPQVCcIYDU0kaCOMTjM43/AspUAaGGqToiyYHNGy55fBK5Z6opDIBeo3TDWjtxeEOINDleTei8qkIpF0HClSo=
Received: from DM5PR12MB1835.namprd12.prod.outlook.com (2603:10b6:3:10c::9) by
 DM5PR1201MB0123.namprd12.prod.outlook.com (2603:10b6:4:50::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.23; Tue, 10 Nov 2020 00:16:49 +0000
Received: from DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::48e2:11e1:d2f:d12f]) by DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::48e2:11e1:d2f:d12f%8]) with mapi id 15.20.3541.024; Tue, 10 Nov 2020
 00:16:48 +0000
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: RE: [PATCH v2] MAINTAINERS: Add missing documentation references to
 PCI Endpoint Subsystem
Thread-Topic: [PATCH v2] MAINTAINERS: Add missing documentation references to
 PCI Endpoint Subsystem
Thread-Index: AQHWdNTa9Ze13IkX60Wh/EtGazx5a6mBwY4AgD9B4JA=
Date:   Tue, 10 Nov 2020 00:16:48 +0000
Message-ID: <DM5PR12MB183506A9436D4A8CF81A96F8DAE90@DM5PR12MB1835.namprd12.prod.outlook.com>
References: <4fa78c7a24e8f8ec3206e1e8960dc18f505c9e29.1597695880.git.gustavo.pimentel@synopsys.com>
 <20200930181500.GA3165690@bogus>
In-Reply-To: <20200930181500.GA3165690@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTA0MTU2YmRhLTIyZWEtMTFlYi05OGQ2LWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFwwNDE1NmJkYy0yMmVhLTExZWItOThkNi1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjgzNyIgdD0iMTMyNDk0NDEwMDYxMjg1?=
 =?us-ascii?Q?Nzk0IiBoPSJsc3VxTVREWkZCbXVVbkVpOTJvN2k4WHVGaFk9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFCUUpBQUNp?=
 =?us-ascii?Q?aVczRzlyYldBZU5MQUNGU1ZUMm80MHNBSVZKVlBhZ09BQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFDa0NBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUFCQUFBQU5yU1YzZ0FBQUFBQUFBQUFBQUFBQUo0QUFBQm1BR2tBYmdC?=
 =?us-ascii?Q?aEFHNEFZd0JsQUY4QWNBQnNBR0VBYmdCdUFHa0FiZ0JuQUY4QWR3QmhBSFFB?=
 =?us-ascii?Q?WlFCeUFHMEFZUUJ5QUdzQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdZQWJ3QjFBRzRBWkFCeUFIa0FYd0J3?=
 =?us-ascii?Q?QUdFQWNnQjBBRzRBWlFCeUFITUFYd0JuQUdZQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFaZ0J2QUhVQWJnQmtBSElBZVFCZkFIQUFZUUJ5QUhRQWJnQmxB?=
 =?us-ascii?Q?SElBY3dCZkFITUFZUUJ0QUhNQWRRQnVBR2NBWHdCakFHOEFiZ0JtQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCbUFHOEFk?=
 =?us-ascii?Q?UUJ1QUdRQWNnQjVBRjhBY0FCaEFISUFkQUJ1QUdVQWNnQnpBRjhBY3dCaEFH?=
 =?us-ascii?Q?MEFjd0IxQUc0QVp3QmZBSElBWlFCekFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1lBYndCMUFHNEFaQUJ5QUhrQVh3?=
 =?us-ascii?Q?QndBR0VBY2dCMEFHNEFaUUJ5QUhNQVh3QnpBRzBBYVFCakFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVpnQnZBSFVBYmdCa0FISUFlUUJmQUhBQVlRQnlBSFFBYmdC?=
 =?us-ascii?Q?bEFISUFjd0JmQUhNQWRBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJtQUc4?=
 =?us-ascii?Q?QWRRQnVBR1FBY2dCNUFGOEFjQUJoQUhJQWRBQnVBR1VBY2dCekFGOEFkQUJ6?=
 =?us-ascii?Q?QUcwQVl3QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHWUFid0IxQUc0QVpBQnlBSGtB?=
 =?us-ascii?Q?WHdCd0FHRUFjZ0IwQUc0QVpRQnlBSE1BWHdCMUFHMEFZd0FBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFD?=
 =?us-ascii?Q?QUFBQUFBQ2VBQUFBWndCMEFITUFYd0J3QUhJQWJ3QmtBSFVBWXdCMEFGOEFk?=
 =?us-ascii?Q?QUJ5QUdFQWFRQnVBR2tBYmdCbkFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnpB?=
 =?us-ascii?Q?R0VBYkFCbEFITUFYd0JoQUdNQVl3QnZBSFVBYmdCMEFGOEFjQUJzQUdFQWJn?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUhNQVlRQnNBR1VBY3dCZkFI?=
 =?us-ascii?Q?RUFkUUJ2QUhRQVpRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFB?=
 =?us-ascii?Q?QUNBQUFBQUFDZUFBQUFjd0J1QUhBQWN3QmZBR3dBYVFCakFHVUFiZ0J6QUdV?=
 =?us-ascii?Q?QVh3QjBBR1VBY2dCdEFGOEFNUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFC?=
 =?us-ascii?Q?ekFHNEFjQUJ6QUY4QWJBQnBBR01BWlFCdUFITUFaUUJmQUhRQVpRQnlBRzBB?=
 =?us-ascii?Q?WHdCekFIUUFkUUJrQUdVQWJnQjBBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBSFlBWndCZkFHc0FaUUI1?=
 =?us-ascii?Q?QUhjQWJ3QnlBR1FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFB?=
 =?us-ascii?Q?QUFBQ0FBQUFBQUE9Ii8+PC9tZXRhPg=3D=3D?=
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [89.155.14.32]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12bd35ab-69cd-47af-25ef-08d8850dea94
x-ms-traffictypediagnostic: DM5PR1201MB0123:
x-microsoft-antispam-prvs: <DM5PR1201MB01236A2BC0C3F864F77E91EEDAE90@DM5PR1201MB0123.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Js5syCy48l0tSrrKSZwgr3xMgCjljAldfGVwillW+fLrm1YpQUa7EbvXOX2DPMsawOlo8vPeCotEMUE5hmxNAV/Tl9wPXGClCxnGPnIgsBwWP+bqIereePtCCzcNoqi8B+xcmruS9BHvpyvXNS+KaPJtPpo+8Wm32iLtKx56JqMFOeLCd2kBu0tTcVuywv1zQyZGnzvObbbUe4peojA6AIl6TX3SK1HMw6Q0NiB8cX+aljuNomEc+Si+taMzKT/KeLgMZceJuPS8bTfCo9vh3vGROC9t0ifxzK7Th6DT3gbYhb/sdicA33nP9GI2pxfIWAURcwmheNjqfnjEpdqjiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1835.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(33656002)(66476007)(7696005)(316002)(9686003)(26005)(6506007)(8676002)(71200400001)(478600001)(83380400001)(86362001)(53546011)(5660300002)(186003)(54906003)(55016002)(4326008)(52536014)(2906002)(66556008)(66446008)(66946007)(76116006)(6916009)(64756008)(8936002)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: B7Bz/RAhjOPhrw7k/6DhfU+HNTwqN3Sf7XDQ0tjT9/xE+OaQTGzemIU4BnbNUdVK3wxQKqKp2Z+AYpJNQslDg1JCH+YXfP0+gxB9Pxo8K3F3yj7ZWZyhvTiLrlBnq0fuXE0ZgOm1nyLRwAOONZh/fVeTa+Wt3J3K97I/SsX/B2pwHLte46r2pKMz9kgYvUYLR+NHYDf7cO+Uhg5Aa4z7PovmPeJi5CRu/QO15mb800vxR7ZawzEua5ESji/1ecOmeQyaV11et/4NS3ObM1Ud2EkISAGAtCrwx242nl8OBKFSYMVCFOl6/CxJCTq7ubza5z1sIAYVilyQWRmG5Ul7bBvzHTUwYYRhzImlMbTEi5Ispurk2kOTiJhW6jM1XTdL8AmkINLhkMERZ/iwGVGbzwf35uqadrIyAbFISbjIbvdLyUCYigGCb5jJGa/9iNxKZA3OocbcFryYgB1qCY3VPsCaoMZ1/wF0JfJHLq/lGQfxDnjRqg6fMzGZCSOKThY/GuHqud0BunrMLLSHqv9P2WpUxK2ejvcq/wPQe58TVXMkgxPyte2xUIv4snlv02jzPBVayjHQ4aA8bwSdinHJbm6BF23K5xNRHzdqAntW0rt0jJsYW4LUAhaiTwowMtL2GW7rFara7AgWLs1QR1qOnA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12bd35ab-69cd-47af-25ef-08d8850dea94
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 00:16:48.7822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anT+ADu65DAdk+uxgnnb0DVLVLw45HXviDOjXnZseE6VoWLsOFw/MHrB+z0Wc0/Cze8YWBV9L2w+Bd/q4GHbSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0123
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On Wed, Sep 30, 2020 at 19:15:0, Rob Herring <robh@kernel.org> wrote:

> On Mon, 17 Aug 2020 22:27:34 +0200, Gustavo Pimentel wrote:
> > Adds documentation reference created by Kishon Abraham to the
> > MAINTAINERS list relative with the PCI endpoint subsystem section.
> >=20
> > Cc: Kishon Vijay Abraham I <kishon@ti.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > ---
> > Changes V2:
> > 	Replace file extestion from txt to rst
> >=20
> >  MAINTAINERS | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
>=20
> Acked-by: Rob Herring <robh@kernel.org>

Perhaps this patch has passed unnoticed.

-Gustavo
