Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72EB8DE665
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 10:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfJUIaE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 04:30:04 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:32876 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725972AbfJUIaD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Oct 2019 04:30:03 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1E75DC0CD6;
        Mon, 21 Oct 2019 08:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1571646603; bh=WNPc+5LhCobsGOARvc3Pqybc5zfn6eAvo07KWMdZ2DU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=BdWcZ3c6gLMEQ8mN2L1cLxriliSdZPZv0Br7AcTFfA/COVNg1DZHDU9o4ceyyEjju
         bF3QjuWzlqQJ3hQH4ZKljXhRRADSDklkO6POfsiOuLXDa3fOlqpGtr6cUU8RScsMQ8
         XKrC1PxB8TmwEAzRyAqO0tlxR3Ta3f7hUbXb84n2/CU25ukxRG/mQ9luwLMB2ee0UM
         nA0Gms/YVhlwzENy3+Va2AdbZAhzWLJYEh8duDzrHWPqbVkHYQJCXYIX7Hlr1QKO2R
         LM+OAXLRyZGBiYzav3tz6KjlFyWOGYMJEPsNSML1pA/oRKBVHil9NGhZJ6awsNk1r9
         edXWujrxBhv7Q==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id A9B26A006D;
        Mon, 21 Oct 2019 08:29:57 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 21 Oct 2019 01:29:45 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 21 Oct 2019 01:29:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nteWJQViQnLm+MTE+oq2lnwMG/H4tMeq+vkZJXZtaPkR0DqtRfaT4QBM/TE+9j7nzBYes3ujYKa5SSBFletSfjTuyDZagGleIqwWPny7l8hKBgwabujUMi3XOK3Ye83fr1FVt0Jh6v083IP/f1uK+aNShmz+yjr8oH1q+MV0/PskqjuuIkdxOSjWKvJAKe0NSHz6BFWGUi+ExEHoEy5oegxy5L15BD0AShtErbxG1EXwnZer71SXe0PAjfJkNsV/3MxATRPAtqSkWlCvwF6ssZYh4hZk/JXGBDmz4bnGRXjapCWVUN2ILJLmFCgf7FzwULToTLSb8Ii0qj+STkZVvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFZveXVwm7ryiVaZg5kXWNEgV4PkGF4n4TTivZxOAe8=;
 b=ZhygePmYj6qyYx9zilKGL3sUw/lSSFdgToCUkG3EMn0E3v1v70MRIwa6KBZDTqtWIxHm/eyz+Zn1hh0I3fZ2CuXYwhT/ueQh0l+f3hxZdWzAjO6mJLFdBPUYER30u2WI1jblFqSCG/KBOiggXg47fAH6DXxCwBdSka/KYlBA3fDzldRMG6KUP0Pe5NSnTb9BJVLvnqSJmIxdWiSFfR6DQ6y0nN3jLK/hGBF1IBLRHQ0H9Ws7AOBT1HvDtqdjHgQ7HicVhKS3FUxPlvvrP1YQ52egKQiEII9Sz3+evSCaTUc5+HuzxvghTqPPandyicSxcbAdVRmnJ6i5MKE/hdXhfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFZveXVwm7ryiVaZg5kXWNEgV4PkGF4n4TTivZxOAe8=;
 b=NeVGScSj5CXpDPCwPuE7lvCMaNqGr+xUPyfsHdF6K6/PD5TlVYpIFPyo9JFKT8hmnWsYyexlyDTgTgiwLjcI3UATl9dDYV8Cd1g2WKoLqZ5v7KMU65/z4ibDmkFYrGoXqiJq5uZUilC7tgBAFhtE9+G+Jn5US/XDlwI/GU9ZgXo=
Received: from CH2PR12MB4007.namprd12.prod.outlook.com (52.132.247.78) by
 CH2PR12MB3781.namprd12.prod.outlook.com (52.132.245.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.20; Mon, 21 Oct 2019 08:29:43 +0000
Received: from CH2PR12MB4007.namprd12.prod.outlook.com
 ([fe80::c0b:d777:b62d:9a5]) by CH2PR12MB4007.namprd12.prod.outlook.com
 ([fe80::c0b:d777:b62d:9a5%7]) with mapi id 15.20.2347.028; Mon, 21 Oct 2019
 08:29:43 +0000
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Dilip Kota <eswara.kota@linux.intel.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <Gustavo.Pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "martin.blumenstingl@googlemail.com" 
        <martin.blumenstingl@googlemail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>,
        "cheol.yong.kim@intel.com" <cheol.yong.kim@intel.com>,
        "chuanhua.lei@linux.intel.com" <chuanhua.lei@linux.intel.com>,
        "qi-ming.wu@intel.com" <qi-ming.wu@intel.com>
Subject: RE: [PATCH v4 2/3] dwc: PCI: intel: PCIe RC controller driver
Thread-Topic: [PATCH v4 2/3] dwc: PCI: intel: PCIe RC controller driver
Thread-Index: AQHVh9pjVPbSO9FdE0WnO4EtdR2wBqdkvrQQ
Date:   Mon, 21 Oct 2019 08:29:43 +0000
Message-ID: <CH2PR12MB400751D01BCEE7ABB708280BDA690@CH2PR12MB4007.namprd12.prod.outlook.com>
References: <cover.1571638827.git.eswara.kota@linux.intel.com>
 <c46ba3f4187fe53807948b4f10996b89a75c492c.1571638827.git.eswara.kota@linux.intel.com>
In-Reply-To: <c46ba3f4187fe53807948b4f10996b89a75c492c.1571638827.git.eswara.kota@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLWU5ZjkzNzU3LWYzZGMtMTFlOS05ODkzLWE0NGNj?=
 =?us-ascii?Q?OGU5Y2YwNlxhbWUtdGVzdFxlOWY5Mzc1OC1mM2RjLTExZTktOTg5My1hNDRj?=
 =?us-ascii?Q?YzhlOWNmMDZib2R5LnR4dCIgc3o9IjI2MzQzIiB0PSIxMzIxNjEyMDE4MDk2?=
 =?us-ascii?Q?OTAxOTUiIGg9Ikswd1FZU0FPbHZhR0pvOURvK3ljWUZTU1NSaz0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUJRSkFB?=
 =?us-ascii?Q?QlRqdlN1NllmVkFlWldwNG56R3VndzVsYW5pZk1hNkRBT0FBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQUNrQ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBRUdJWXpRQUFBQUFBQUFBQUFBQUFBSjRBQUFCbUFHa0Fi?=
 =?us-ascii?Q?Z0JoQUc0QVl3QmxBRjhBY0FCc0FHRUFiZ0J1QUdrQWJnQm5BRjhBZHdCaEFI?=
 =?us-ascii?Q?UUFaUUJ5QUcwQVlRQnlBR3NBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1lBYndCMUFHNEFaQUJ5QUhrQVh3?=
 =?us-ascii?Q?QndBR0VBY2dCMEFHNEFaUUJ5QUhNQVh3Qm5BR1lBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVpnQnZBSFVBYmdCa0FISUFlUUJmQUhBQVlRQnlBSFFBYmdC?=
 =?us-ascii?Q?bEFISUFjd0JmQUhNQVlRQnRBSE1BZFFCdUFHY0FYd0JqQUc4QWJnQm1BQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJtQUc4?=
 =?us-ascii?Q?QWRRQnVBR1FBY2dCNUFGOEFjQUJoQUhJQWRBQnVBR1VBY2dCekFGOEFjd0Jo?=
 =?us-ascii?Q?QUcwQWN3QjFBRzRBWndCZkFISUFaUUJ6QUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHWUFid0IxQUc0QVpBQnlBSGtB?=
 =?us-ascii?Q?WHdCd0FHRUFjZ0IwQUc0QVpRQnlBSE1BWHdCekFHMEFhUUJqQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFD?=
 =?us-ascii?Q?QUFBQUFBQ2VBQUFBWmdCdkFIVUFiZ0JrQUhJQWVRQmZBSEFBWVFCeUFIUUFi?=
 =?us-ascii?Q?Z0JsQUhJQWN3QmZBSE1BZEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQm1B?=
 =?us-ascii?Q?RzhBZFFCdUFHUUFjZ0I1QUY4QWNBQmhBSElBZEFCdUFHVUFjZ0J6QUY4QWRB?=
 =?us-ascii?Q?QnpBRzBBWXdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdZQWJ3QjFBRzRBWkFCeUFI?=
 =?us-ascii?Q?a0FYd0J3QUdFQWNnQjBBRzRBWlFCeUFITUFYd0IxQUcwQVl3QUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFB?=
 =?us-ascii?Q?QUNBQUFBQUFDZUFBQUFad0IwQUhNQVh3QndBSElBYndCa0FIVUFZd0IwQUY4?=
 =?us-ascii?Q?QWRBQnlBR0VBYVFCdUFHa0FiZ0JuQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFC?=
 =?us-ascii?Q?ekFHRUFiQUJsQUhNQVh3QmhBR01BWXdCdkFIVUFiZ0IwQUY4QWNBQnNBR0VB?=
 =?us-ascii?Q?YmdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBSE1BWVFCc0FHVUFjd0Jm?=
 =?us-ascii?Q?QUhFQWRRQnZBSFFBWlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFB?=
 =?us-ascii?Q?QUFBQ0FBQUFBQUNlQUFBQWN3QnVBSEFBY3dCZkFHd0FhUUJqQUdVQWJnQnpB?=
 =?us-ascii?Q?R1VBWHdCMEFHVUFjZ0J0QUY4QU1RQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFB?=
 =?us-ascii?Q?QUJ6QUc0QWNBQnpBRjhBYkFCcEFHTUFaUUJ1QUhNQVpRQmZBSFFBWlFCeUFH?=
 =?us-ascii?Q?MEFYd0J6QUhRQWRRQmtBR1VBYmdCMEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFIWUFad0JmQUdzQVpR?=
 =?us-ascii?Q?QjVBSGNBYndCeUFHUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFB?=
 =?us-ascii?Q?QUFBQUFDQUFBQUFBQT0iLz48L21ldGE+?=
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gustavo@synopsys.com; 
x-originating-ip: [83.174.63.141]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6dc27db-6628-4acb-7add-08d75600d30a
x-ms-traffictypediagnostic: CH2PR12MB3781:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB3781544B35023983FB9347E0DA690@CH2PR12MB3781.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:428;
x-forefront-prvs: 0197AFBD92
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(136003)(366004)(39860400002)(346002)(199004)(189003)(86362001)(186003)(3846002)(6116002)(66066001)(476003)(30864003)(2201001)(110136005)(54906003)(4326008)(6246003)(305945005)(11346002)(74316002)(2906002)(316002)(76176011)(7736002)(446003)(66946007)(25786009)(6436002)(66476007)(66556008)(66446008)(7696005)(5660300002)(76116006)(64756008)(256004)(14444005)(81166006)(8936002)(229853002)(99286004)(71190400001)(81156014)(71200400001)(33656002)(2501003)(8676002)(486006)(9686003)(26005)(6506007)(53546011)(52536014)(102836004)(14454004)(7416002)(55016002)(478600001)(921003)(1121003)(559001)(579004);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR12MB3781;H:CH2PR12MB4007.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NQWLnRwdwpP4kVx/XONH99fvNsXoCBdf6+ADwrw4VfaWJperyTpGyXSBjz1AgqVpAhnBovOtr/OLFj9TehN50RIx2vRfmztqvU6lOuJCLxcfj0IOwyBAPrvK8MTPsYj0g4nj9rWi8AaW1df328U44OD+N89CaBu3kthCv8mAxurnq1pShu8qwCyLtZlbsG1XqxykAWP7ApGnewrk5VxiEdySrFOUkXBY8eUSf/xACzDBFFnYnS+9hzoxc5SKmUuDLgDiip2L4NWIxriptFZtDXnPvT+vFWq6rwT7pxtzk2KocqhTzAJczkdv3qGlg8aDyKs5m4lfpXhKjWyc0yJG7cEQaphH9wAQALUNOzB44fdLEdVZc3c9FEP7NQfmebW6eYw/3OeN6Xm0v+g+J+tHWTZUkd/+/bEJPmsSU/TYozSAV0hVT4qlwUmAQ7lKlwDX
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c6dc27db-6628-4acb-7add-08d75600d30a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2019 08:29:43.4374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T2lgnXpQIdAbMyCjHD3TnLBnHsOh+dAEYSEPL96W5Ajsn9TSymGR/cX3aisrzhBNchg+/ErSOsO7zl3IFaIWOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3781
X-OriginatorOrg: synopsys.com
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi

On Mon, Oct 21, 2019 at 7:39:19, Dilip Kota <eswara.kota@linux.intel.com>=20
wrote:

> Add support to PCIe RC controller on Intel Gateway SoCs.
> PCIe controller is based of Synopsys DesignWare pci core.
>=20
> Intel PCIe driver requires Upconfig support, fast training
> sequence configuration and link speed change. So adding the
> respective helper functions in the pcie DesignWare framework.
> It also programs hardware autonomous speed during speed
> configuration so defining it in pci_regs.h.

Please do the replacement in all of your patches

s/pcie/PCIe
s/pci/PCI

Also I think the correct term is Upconfigure and not Upconfig

>=20
> Changes on v4:
> 	Rename the driver naming and description to
> 	 "PCIe RC controller on Intel Gateway SoCs".
> 	Use PCIe core register macros defined in pci_regs.h
> 	 and remove respective local definitions.
> 	Remove pcie core interrupt handling.
> 	Move pcie link control speed change, upconfig and FTS.
> 	configuration functions to DesignWare framework.
> 	Use of_pci_get_max_link_speed().
> 	Mark dependency on X86 and COMPILE_TEST in Kconfig.
> 	Remove lanes and add n_fts variables in intel_pcie_port structure.
> 	Rename rst_interval variable to rst_intrvl in intel_pcie_port structure.
> 	Remove intel_pcie_mem_iatu() as it is already perfomed in dw_setup_rc()
> 	Move sysfs attributes specific code to separate patch.
> 	Remove redundant error handling.
> 	Reduce LoCs by doing variable initializations while declaration itself.
> 	Add extra line after closing parenthesis.
> 	Move intel_pcie_ep_rst_init() out of get_resources()
>=20
> changes on v3:
> 	Rename PCIe app logic registers with PCIE_APP prefix.
> 	PCIE_IOP_CTRL configuration is not required. Remove respective code.
> 	Remove wrapper functions for clk enable/disable APIs.
> 	Use platform_get_resource_byname() instead of
> 	  devm_platform_ioremap_resource() to be similar with DWC framework.
> 	Rename phy name to "pciephy".
> 	Modify debug message in msi_init() callback to be more specific.
> 	Remove map_irq() callback.
> 	Enable the INTx interrupts at the time of PCIe initialization.
> 	Reduce memory fragmentation by using variable "struct dw_pcie pci"
> 	  instead of allocating memory.
> 	Reduce the delay to 100us during enpoint initialization
> 	  intel_pcie_ep_rst_init().
> 	Call  dw_pcie_host_deinit() during remove() instead of directly
> 	  calling PCIe core APIs.
> 	Rename "intel,rst-interval" to "reset-assert-ms".
> 	Remove unused APP logic Interrupt bit macro definitions.
>  	Use dwc framework's dw_pcie_setup_rc() for PCIe host specific
> 	 configuration instead of redefining the same functionality in
> 	 the driver.
> 	Move the whole DT parsing specific code to intel_pcie_get_resources()
>=20
> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> ---
>  drivers/pci/controller/dwc/Kconfig           |  10 +
>  drivers/pci/controller/dwc/Makefile          |   1 +
>  drivers/pci/controller/dwc/pcie-designware.c |  34 ++
>  drivers/pci/controller/dwc/pcie-designware.h |  12 +
>  drivers/pci/controller/dwc/pcie-intel-gw.c   | 590 +++++++++++++++++++++=
++++++
>  include/uapi/linux/pci_regs.h                |   1 +
>  6 files changed, 648 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-intel-gw.c
>=20
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/=
dwc/Kconfig
> index 0ba988b5b5bc..b33ed1cc873d 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -82,6 +82,16 @@ config PCIE_DW_PLAT_EP
>  	  order to enable device-specific features PCI_DW_PLAT_EP must be
>  	  selected.
> =20
> +config PCIE_INTEL_GW
> +        bool "Intel Gateway PCIe host controller support"
> +	depends on OF && (X86 || COMPILE_TEST)
> +	select PCIE_DW_HOST
> +	help
> +          Say 'Y' here to enable support for PCIe Host controller driver=
.
> +	  The PCIe controller on Intel Gateway SoCs is based on the Synopsys
> +	  DesignWare pcie core and therefore uses the DesignWare core
> +	  functions for the driver implementation.
> +
>  config PCI_EXYNOS
>  	bool "Samsung Exynos PCIe controller"
>  	depends on SOC_EXYNOS5440 || COMPILE_TEST
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller=
/dwc/Makefile
> index b30336181d46..99db83cd2f35 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -3,6 +3,7 @@ obj-$(CONFIG_PCIE_DW) +=3D pcie-designware.o
>  obj-$(CONFIG_PCIE_DW_HOST) +=3D pcie-designware-host.o
>  obj-$(CONFIG_PCIE_DW_EP) +=3D pcie-designware-ep.o
>  obj-$(CONFIG_PCIE_DW_PLAT) +=3D pcie-designware-plat.o
> +obj-$(CONFIG_PCIE_INTEL_GW) +=3D pcie-intel-gw.o
>  obj-$(CONFIG_PCI_DRA7XX) +=3D pci-dra7xx.o
>  obj-$(CONFIG_PCI_EXYNOS) +=3D pci-exynos.o
>  obj-$(CONFIG_PCI_IMX6) +=3D pci-imx6.o
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/c=
ontroller/dwc/pcie-designware.c
> index 820488dfeaed..4c391bfd681a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -474,6 +474,40 @@ int dw_pcie_link_up(struct dw_pcie *pci)
>  		(!(val & PCIE_PORT_DEBUG1_LINK_IN_TRAINING)));
>  }
> =20
> +
> +void dw_pcie_upconfig_setup(struct dw_pcie *pci)
> +{
> +	u32 val;
> +
> +	val =3D dw_pcie_readl_dbi(pci, PCIE_PORT_MULTI_LANE_CTRL);
> +	dw_pcie_writel_dbi(pci, PCIE_PORT_MULTI_LANE_CTRL,
> +			   val | PORT_MLTI_UPCFG_SUPPORT);
> +}
> +
> +void dw_pcie_link_speed_change(struct dw_pcie *pci, bool enable)
> +{
> +	u32 val;
> +
> +	val =3D dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
> +
> +	if (enable)
> +		val |=3D PORT_LOGIC_SPEED_CHANGE;
> +	else
> +		val &=3D ~PORT_LOGIC_SPEED_CHANGE;
> +
> +	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> +}
> +
> +void dw_pcie_link_set_n_fts(struct dw_pcie *pci, u32 n_fts)
> +{
> +	u32 val;
> +
> +	val =3D dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
> +	val &=3D ~PORT_LOGIC_N_FTS;
> +	val |=3D n_fts;
> +	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> +}
> +
>  static u8 dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
>  {
>  	u32 val;
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/c=
ontroller/dwc/pcie-designware.h
> index 5a18e94e52c8..3beac10e4a4c 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -30,7 +30,12 @@
>  #define LINK_WAIT_IATU			9
> =20
>  /* Synopsys-specific PCIe configuration registers */
> +#define PCIE_PORT_AFR			0x70C
> +#define PORT_AFR_N_FTS_MASK		GENMASK(15, 8)
> +#define PORT_AFR_CC_N_FTS_MASK		GENMASK(23, 16)
> +
>  #define PCIE_PORT_LINK_CONTROL		0x710
> +#define PORT_LINK_DLL_LINK_EN		BIT(5)
>  #define PORT_LINK_MODE_MASK		GENMASK(21, 16)
>  #define PORT_LINK_MODE(n)		FIELD_PREP(PORT_LINK_MODE_MASK, n)
>  #define PORT_LINK_MODE_1_LANES		PORT_LINK_MODE(0x1)
> @@ -46,6 +51,7 @@
>  #define PCIE_PORT_DEBUG1_LINK_IN_TRAINING	BIT(29)
> =20
>  #define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
> +#define PORT_LOGIC_N_FTS		GENMASK(7, 0)
>  #define PORT_LOGIC_SPEED_CHANGE		BIT(17)
>  #define PORT_LOGIC_LINK_WIDTH_MASK	GENMASK(12, 8)
>  #define PORT_LOGIC_LINK_WIDTH(n)	FIELD_PREP(PORT_LOGIC_LINK_WIDTH_MASK, =
n)
> @@ -60,6 +66,9 @@
>  #define PCIE_MSI_INTR0_MASK		0x82C
>  #define PCIE_MSI_INTR0_STATUS		0x830
> =20
> +#define PCIE_PORT_MULTI_LANE_CTRL	0x8C0
> +#define PORT_MLTI_UPCFG_SUPPORT		BIT(7)
> +
>  #define PCIE_ATU_VIEWPORT		0x900
>  #define PCIE_ATU_REGION_INBOUND		BIT(31)
>  #define PCIE_ATU_REGION_OUTBOUND	0
> @@ -273,6 +282,9 @@ void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg,=
 size_t size, u32 val);
>  u32 dw_pcie_read_atu(struct dw_pcie *pci, u32 reg, size_t size);
>  void dw_pcie_write_atu(struct dw_pcie *pci, u32 reg, size_t size, u32 va=
l);
>  int dw_pcie_link_up(struct dw_pcie *pci);
> +void dw_pcie_upconfig_setup(struct dw_pcie *pci);
> +void dw_pcie_link_speed_change(struct dw_pcie *pci, bool enable);
> +void dw_pcie_link_set_n_fts(struct dw_pcie *pci, u32 n_fts);
>  int dw_pcie_wait_for_link(struct dw_pcie *pci);
>  void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
>  			       int type, u64 cpu_addr, u64 pci_addr,
> diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/con=
troller/dwc/pcie-intel-gw.c
> new file mode 100644
> index 000000000000..9142c70db808
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
> @@ -0,0 +1,590 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCIe host controller driver for Intel Gateway SoCs
> + *
> + * Copyright (c) 2019 Intel Corporation.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/iopoll.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_pci.h>
> +#include <linux/of_platform.h>
> +#include <linux/pci_regs.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +
> +#include "../../pci.h"
> +#include "pcie-designware.h"
> +
> +#define PCIE_CAP_OFST			0x70
> +
> +#define PORT_AFR_N_FTS_GEN12_DFT	(SZ_128 - 1)
> +#define PORT_AFR_N_FTS_GEN3		180
> +#define PORT_AFR_N_FTS_GEN4		196
> +
> +/* PCIe Application logic Registers */
> +#define PCIE_APP_CCR			0x10
> +#define PCIE_APP_CCR_LTSSM_ENABLE	BIT(0)
> +
> +#define PCIE_APP_MSG_CR			0x30
> +#define PCIE_APP_MSG_XMT_PM_TURNOFF	BIT(0)
> +
> +#define PCIE_APP_PMC			0x44
> +#define PCIE_APP_PMC_IN_L2		BIT(20)
> +
> +#define PCIE_APP_IRNEN			0xF4
> +#define PCIE_APP_IRNCR			0xF8
> +#define PCIE_APP_IRN_AER_REPORT		BIT(0)
> +#define PCIE_APP_IRN_PME		BIT(2)
> +#define PCIE_APP_IRN_RX_VDM_MSG		BIT(4)
> +#define PCIE_APP_IRN_PM_TO_ACK		BIT(9)
> +#define PCIE_APP_IRN_LINK_AUTO_BW_STAT	BIT(11)
> +#define PCIE_APP_IRN_BW_MGT		BIT(12)
> +#define PCIE_APP_IRN_MSG_LTR		BIT(18)
> +#define PCIE_APP_IRN_SYS_ERR_RC		BIT(29)
> +#define PCIE_APP_INTX_OFST		12
> +
> +#define PCIE_APP_IRN_INT \
> +			(PCIE_APP_IRN_AER_REPORT | PCIE_APP_IRN_PME | \
> +			PCIE_APP_IRN_RX_VDM_MSG | PCIE_APP_IRN_SYS_ERR_RC | \
> +			PCIE_APP_IRN_PM_TO_ACK | PCIE_APP_IRN_MSG_LTR | \
> +			PCIE_APP_IRN_BW_MGT | PCIE_APP_IRN_LINK_AUTO_BW_STAT | \
> +			(PCIE_APP_INTX_OFST + PCI_INTERRUPT_INTA) | \
> +			(PCIE_APP_INTX_OFST + PCI_INTERRUPT_INTB) | \
> +			(PCIE_APP_INTX_OFST + PCI_INTERRUPT_INTC) | \
> +			(PCIE_APP_INTX_OFST + PCI_INTERRUPT_INTD))
> +
> +#define BUS_IATU_OFFS			SZ_256M
> +#define RST_INTRVL_DFT_MS		100
> +
> +enum {
> +	PCIE_LINK_SPEED_AUTO =3D 0,
> +	PCIE_LINK_SPEED_GEN1,
> +	PCIE_LINK_SPEED_GEN2,
> +	PCIE_LINK_SPEED_GEN3,
> +	PCIE_LINK_SPEED_GEN4,
> +};
> +
> +struct intel_pcie_soc {
> +	unsigned int pcie_ver;
> +	unsigned int pcie_atu_offset;
> +	u32 num_viewport;
> +};
> +
> +struct intel_pcie_port {
> +	struct dw_pcie		pci;
> +	unsigned int		id; /* Physical RC Index */
> +	void __iomem		*app_base;
> +	struct gpio_desc	*reset_gpio;
> +	u32			rst_intrvl;
> +	u32			max_speed;
> +	u32			link_gen;
> +	u32			max_width;
> +	u32			n_fts;
> +	struct clk		*core_clk;
> +	struct reset_control	*core_rst;
> +	struct phy		*phy;
> +};
> +
> +static void pcie_update_bits(void __iomem *base, u32 mask, u32 val, u32 =
ofs)
> +{
> +	u32 orig, tmp;
> +
> +	orig =3D readl(base + ofs);
> +
> +	tmp =3D (orig & ~mask) | (val & mask);
> +
> +	if (tmp !=3D orig)
> +		writel(tmp, base + ofs);
> +}

I'd suggest to the a take on FIELD_PREP() and FIELD_GET() and use more=20
intuitive names such as new and old, instead of orig and tmp.

> +static inline u32 pcie_app_rd(struct intel_pcie_port *lpp, u32 ofs)
> +{
> +	return readl(lpp->app_base + ofs);
> +}
> +
> +static inline void pcie_app_wr(struct intel_pcie_port *lpp, u32 val, u32=
 ofs)
> +{
> +	writel(val, lpp->app_base + ofs);
> +}
> +
> +static void pcie_app_wr_mask(struct intel_pcie_port *lpp,
> +			     u32 mask, u32 val, u32 ofs)
> +{
> +	pcie_update_bits(lpp->app_base, mask, val, ofs);
> +}
> +
> +static inline u32 pcie_rc_cfg_rd(struct intel_pcie_port *lpp, u32 ofs)
> +{
> +	return dw_pcie_readl_dbi(&lpp->pci, ofs);
> +}
> +
> +static inline void pcie_rc_cfg_wr(struct intel_pcie_port *lpp, u32 val, =
u32 ofs)
> +{
> +	dw_pcie_writel_dbi(&lpp->pci, ofs, val);
> +}
> +
> +static void pcie_rc_cfg_wr_mask(struct intel_pcie_port *lpp,
> +				u32 mask, u32 val, u32 ofs)
> +{
> +	pcie_update_bits(lpp->pci.dbi_base, mask, val, ofs);
> +}
> +
> +static void intel_pcie_ltssm_enable(struct intel_pcie_port *lpp)
> +{
> +	pcie_app_wr_mask(lpp, PCIE_APP_CCR_LTSSM_ENABLE,
> +			 PCIE_APP_CCR_LTSSM_ENABLE, PCIE_APP_CCR);
> +}
> +
> +static void intel_pcie_ltssm_disable(struct intel_pcie_port *lpp)
> +{
> +	pcie_app_wr_mask(lpp, PCIE_APP_CCR_LTSSM_ENABLE, 0, PCIE_APP_CCR);
> +}
> +
> +static void intel_pcie_link_setup(struct intel_pcie_port *lpp)
> +{
> +	u32 val;
> +
> +	val =3D pcie_rc_cfg_rd(lpp, PCIE_CAP_OFST + PCI_EXP_LNKCAP);
> +	lpp->max_speed =3D FIELD_GET(PCI_EXP_LNKCAP_SLS, val);
> +	lpp->max_width =3D FIELD_GET(PCI_EXP_LNKCAP_MLW, val);
> +
> +	val =3D pcie_rc_cfg_rd(lpp, PCIE_CAP_OFST + PCI_EXP_LNKCTL);
> +
> +	val &=3D ~(PCI_EXP_LNKCTL_LD | PCI_EXP_LNKCTL_ASPMC);
> +	val |=3D (PCI_EXP_LNKSTA_SLC << 16) | PCI_EXP_LNKCTL_CCC |
> +	       PCI_EXP_LNKCTL_RCB;
> +	pcie_rc_cfg_wr(lpp, val, PCIE_CAP_OFST + PCI_EXP_LNKCTL);
> +}
> +
> +static void intel_pcie_max_speed_setup(struct intel_pcie_port *lpp)
> +{
> +	u32 reg, val;
> +
> +	reg =3D pcie_rc_cfg_rd(lpp, PCIE_CAP_OFST + PCI_EXP_LNKCTL2);
> +	switch (lpp->link_gen) {
> +	case PCIE_LINK_SPEED_GEN1:
> +		reg &=3D ~PCI_EXP_LNKCTL2_TLS;
> +		reg |=3D PCI_EXP_LNKCTL2_HASD|
> +			PCI_EXP_LNKCTL2_TLS_2_5GT;
> +		break;
> +	case PCIE_LINK_SPEED_GEN2:
> +		reg &=3D ~PCI_EXP_LNKCTL2_TLS;
> +		reg |=3D PCI_EXP_LNKCTL2_HASD|
> +			PCI_EXP_LNKCTL2_TLS_5_0GT;
> +		break;
> +	case PCIE_LINK_SPEED_GEN3:
> +		reg &=3D ~PCI_EXP_LNKCTL2_TLS;
> +		reg |=3D PCI_EXP_LNKCTL2_HASD|
> +			PCI_EXP_LNKCTL2_TLS_8_0GT;
> +		break;
> +	case PCIE_LINK_SPEED_GEN4:
> +		reg &=3D ~PCI_EXP_LNKCTL2_TLS;
> +		reg |=3D PCI_EXP_LNKCTL2_HASD|
> +			PCI_EXP_LNKCTL2_TLS_16_0GT;
> +		break;
> +	default:
> +		/* Use hardware capability */
> +		val =3D pcie_rc_cfg_rd(lpp, PCIE_CAP_OFST + PCI_EXP_LNKCAP);
> +		val =3D FIELD_GET(PCI_EXP_LNKCAP_SLS, val);
> +		reg &=3D ~PCI_EXP_LNKCTL2_HASD;
> +		reg |=3D val;
> +		break;
> +	}
> +
> +	pcie_rc_cfg_wr(lpp, reg, PCIE_CAP_OFST + PCI_EXP_LNKCTL2);
> +	dw_pcie_link_set_n_fts(&lpp->pci, lpp->n_fts);
> +}
> +
> +

Reduce the number of empty lines here.

> +
> +static void intel_pcie_port_logic_setup(struct intel_pcie_port *lpp)
> +{
> +	u32 val, mask;
> +
> +	switch (lpp->max_speed) {
> +	case PCIE_LINK_SPEED_GEN3:
> +		lpp->n_fts =3D PORT_AFR_N_FTS_GEN3;
> +		break;
> +	case PCIE_LINK_SPEED_GEN4:
> +		lpp->n_fts =3D PORT_AFR_N_FTS_GEN4;
> +		break;
> +	default:
> +		lpp->n_fts =3D PORT_AFR_N_FTS_GEN12_DFT;
> +		break;
> +	}
> +
> +	mask =3D PORT_AFR_N_FTS_MASK | PORT_AFR_CC_N_FTS_MASK;
> +	val =3D FIELD_PREP(PORT_AFR_N_FTS_MASK, lpp->n_fts) |
> +	       FIELD_PREP(PORT_AFR_CC_N_FTS_MASK, lpp->n_fts);
> +	pcie_rc_cfg_wr_mask(lpp, mask, val, PCIE_PORT_AFR);
> +
> +	/* Port Link Control Register */
> +	pcie_rc_cfg_wr_mask(lpp, PORT_LINK_DLL_LINK_EN,
> +			    PORT_LINK_DLL_LINK_EN, PCIE_PORT_LINK_CONTROL);
> +}
> +
> +static void intel_pcie_rc_setup(struct intel_pcie_port *lpp)
> +{
> +	intel_pcie_ltssm_disable(lpp);
> +	intel_pcie_link_setup(lpp);
> +	dw_pcie_setup_rc(&lpp->pci.pp);
> +	dw_pcie_upconfig_setup(&lpp->pci);
> +	intel_pcie_port_logic_setup(lpp);
> +	intel_pcie_max_speed_setup(lpp);
> +}
> +
> +static int intel_pcie_ep_rst_init(struct intel_pcie_port *lpp)
> +{
> +	struct device *dev =3D lpp->pci.dev;
> +	int ret;
> +
> +	lpp->reset_gpio =3D devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(lpp->reset_gpio)) {
> +		ret =3D PTR_ERR(lpp->reset_gpio);
> +		if (ret !=3D -EPROBE_DEFER)
> +			dev_err(dev, "failed to request PCIe GPIO: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Make initial reset last for 100us */
> +	usleep_range(100, 200);
> +
> +	return 0;
> +}
> +
> +static void intel_pcie_core_rst_assert(struct intel_pcie_port *lpp)
> +{
> +	reset_control_assert(lpp->core_rst);
> +}
> +
> +static void intel_pcie_core_rst_deassert(struct intel_pcie_port *lpp)
> +{
> +	/*
> +	 * One micro-second delay to make sure the reset pulse
> +	 * wide enough so that core reset is clean.
> +	 */
> +	udelay(1);
> +	reset_control_deassert(lpp->core_rst);
> +
> +	/*
> +	 * Some SoC core reset also reset PHY, more delay needed
> +	 * to make sure the reset process is done.
> +	 */
> +	usleep_range(1000, 2000);
> +}
> +
> +static void intel_pcie_device_rst_assert(struct intel_pcie_port *lpp)
> +{
> +	gpiod_set_value_cansleep(lpp->reset_gpio, 1);
> +}
> +
> +static void intel_pcie_device_rst_deassert(struct intel_pcie_port *lpp)
> +{
> +	msleep(lpp->rst_intrvl);
> +	gpiod_set_value_cansleep(lpp->reset_gpio, 0);
> +}
> +
> +static int intel_pcie_app_logic_setup(struct intel_pcie_port *lpp)
> +{
> +	intel_pcie_device_rst_deassert(lpp);
> +	intel_pcie_ltssm_enable(lpp);
> +
> +	return dw_pcie_wait_for_link(&lpp->pci);
> +}
> +
> +static void intel_pcie_core_irq_disable(struct intel_pcie_port *lpp)
> +{
> +	pcie_app_wr(lpp, 0, PCIE_APP_IRNEN);
> +	pcie_app_wr(lpp, PCIE_APP_IRN_INT,  PCIE_APP_IRNCR);
> +}
> +
> +static int intel_pcie_get_resources(struct platform_device *pdev)
> +{
> +	struct intel_pcie_port *lpp =3D platform_get_drvdata(pdev);
> +	struct dw_pcie *pci =3D &lpp->pci;
> +	struct device *dev =3D pci->dev;
> +	struct resource *res;
> +	int ret;
> +
> +	ret =3D device_property_read_u32(dev, "linux,pci-domain", &lpp->id);
> +	if (ret) {
> +		dev_err(dev, "failed to get domain id, errno %d\n", ret);
> +		return ret;
> +	}
> +
> +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
> +
> +	pci->dbi_base =3D devm_ioremap_resource(dev, res);
> +	if (IS_ERR(pci->dbi_base))
> +		return PTR_ERR(pci->dbi_base);
> +
> +	lpp->core_clk =3D devm_clk_get(dev, NULL);
> +	if (IS_ERR(lpp->core_clk)) {
> +		ret =3D PTR_ERR(lpp->core_clk);
> +		if (ret !=3D -EPROBE_DEFER)
> +			dev_err(dev, "failed to get clks: %d\n", ret);
> +		return ret;
> +	}
> +
> +	lpp->core_rst =3D devm_reset_control_get(dev, NULL);
> +	if (IS_ERR(lpp->core_rst)) {
> +		ret =3D PTR_ERR(lpp->core_rst);
> +		if (ret !=3D -EPROBE_DEFER)
> +			dev_err(dev, "failed to get resets: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D device_property_match_string(dev, "device_type", "pci");
> +	if (ret) {
> +		dev_err(dev, "failed to find pci device type: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (device_property_read_u32(dev, "reset-assert-ms", &lpp->rst_intrvl))
> +		lpp->rst_intrvl =3D RST_INTRVL_DFT_MS;
> +
> +	ret =3D of_pci_get_max_link_speed(dev->of_node);
> +		lpp->link_gen =3D ret < 0 ? 0 : ret;
> +
> +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "app");
> +
> +	lpp->app_base =3D devm_ioremap_resource(dev, res);
> +	if (IS_ERR(lpp->app_base))
> +		return PTR_ERR(lpp->app_base);
> +
> +	lpp->phy =3D devm_phy_get(dev, "pcie");
> +	if (IS_ERR(lpp->phy)) {
> +		ret =3D PTR_ERR(lpp->phy);
> +		if (ret !=3D -EPROBE_DEFER)
> +			dev_err(dev, "couldn't get pcie-phy: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void intel_pcie_deinit_phy(struct intel_pcie_port *lpp)
> +{
> +	phy_exit(lpp->phy);
> +}
> +
> +static int intel_pcie_wait_l2(struct intel_pcie_port *lpp)
> +{
> +	u32 value;
> +	int ret;
> +
> +	if (lpp->max_speed < PCIE_LINK_SPEED_GEN3)
> +		return 0;
> +
> +	/* Send PME_TURN_OFF message */
> +	pcie_app_wr_mask(lpp, PCIE_APP_MSG_XMT_PM_TURNOFF,
> +			 PCIE_APP_MSG_XMT_PM_TURNOFF, PCIE_APP_MSG_CR);
> +
> +	/* Read PMC status and wait for falling into L2 link state */
> +	ret =3D readl_poll_timeout(lpp->app_base + PCIE_APP_PMC, value,
> +				 (value & PCIE_APP_PMC_IN_L2), 20,
> +				 jiffies_to_usecs(5 * HZ));
> +	if (ret)
> +		dev_err(lpp->pci.dev, "PCIe link enter L2 timeout!\n");
> +
> +	return ret;
> +}
> +
> +static void intel_pcie_turn_off(struct intel_pcie_port *lpp)
> +{
> +	if (dw_pcie_link_up(&lpp->pci))
> +		intel_pcie_wait_l2(lpp);
> +
> +	/* Put endpoint device in reset state */
> +	intel_pcie_device_rst_assert(lpp);
> +	pcie_rc_cfg_wr_mask(lpp, PCI_COMMAND_MEMORY, 0, PCI_COMMAND);
> +}
> +
> +static int intel_pcie_host_setup(struct intel_pcie_port *lpp)
> +{
> +	int ret;
> +
> +	intel_pcie_core_rst_assert(lpp);
> +	intel_pcie_device_rst_assert(lpp);
> +
> +	ret =3D phy_init(lpp->phy);
> +	if (ret)
> +		return ret;
> +
> +	intel_pcie_core_rst_deassert(lpp);
> +
> +	ret =3D clk_prepare_enable(lpp->core_clk);
> +	if (ret) {
> +		dev_err(lpp->pci.dev, "Core clock enable failed: %d\n", ret);
> +		goto clk_err;
> +	}
> +
> +	intel_pcie_rc_setup(lpp);
> +	ret =3D intel_pcie_app_logic_setup(lpp);
> +	if (ret)
> +		goto app_init_err;
> +
> +	/* Enable integrated interrupts */
> +	pcie_app_wr_mask(lpp, PCIE_APP_IRN_INT, PCIE_APP_IRN_INT,
> +			 PCIE_APP_IRNEN);
> +	return 0;
> +
> +app_init_err:
> +	clk_disable_unprepare(lpp->core_clk);
> +clk_err:
> +	intel_pcie_core_rst_assert(lpp);
> +	intel_pcie_deinit_phy(lpp);
> +
> +	return ret;
> +}
> +
> +static void __intel_pcie_remove(struct intel_pcie_port *lpp)
> +{
> +	intel_pcie_core_irq_disable(lpp);
> +	intel_pcie_turn_off(lpp);
> +	clk_disable_unprepare(lpp->core_clk);
> +	intel_pcie_core_rst_assert(lpp);
> +	intel_pcie_deinit_phy(lpp);
> +}
> +
> +static int intel_pcie_remove(struct platform_device *pdev)
> +{
> +	struct intel_pcie_port *lpp =3D platform_get_drvdata(pdev);
> +	struct pcie_port *pp =3D &lpp->pci.pp;
> +
> +	dw_pcie_host_deinit(pp);
> +	__intel_pcie_remove(lpp);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused intel_pcie_suspend_noirq(struct device *dev)
> +{
> +	struct intel_pcie_port *lpp =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	intel_pcie_core_irq_disable(lpp);
> +	ret =3D intel_pcie_wait_l2(lpp);
> +	if (ret)
> +		return ret;
> +
> +	intel_pcie_deinit_phy(lpp);
> +	clk_disable_unprepare(lpp->core_clk);
> +	return ret;
> +}
> +
> +static int __maybe_unused intel_pcie_resume_noirq(struct device *dev)
> +{
> +	struct intel_pcie_port *lpp =3D dev_get_drvdata(dev);
> +
> +	return intel_pcie_host_setup(lpp);
> +}
> +
> +static int intel_pcie_rc_init(struct pcie_port *pp)
> +{
> +	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> +	struct intel_pcie_port *lpp =3D dev_get_drvdata(pci->dev);
> +
> +	return intel_pcie_host_setup(lpp);
> +}
> +
> +int intel_pcie_msi_init(struct pcie_port *pp)
> +{
> +	/* PCIe MSI/MSIx is handled by MSI in x86 processor */
> +	return 0;
> +}
> +
> +u64 intel_pcie_cpu_addr(struct dw_pcie *pcie, u64 cpu_addr)
> +{
> +	return cpu_addr + BUS_IATU_OFFS;
> +}
> +
> +static const struct dw_pcie_ops intel_pcie_ops =3D {
> +	.cpu_addr_fixup =3D intel_pcie_cpu_addr,
> +};
> +
> +static const struct dw_pcie_host_ops intel_pcie_dw_ops =3D {
> +	.host_init =3D		intel_pcie_rc_init,
> +	.msi_host_init =3D	intel_pcie_msi_init,
> +};
> +
> +static const struct intel_pcie_soc pcie_data =3D {
> +	.pcie_ver =3D		0x520A,
> +	.pcie_atu_offset =3D	0xC0000,
> +	.num_viewport =3D		3,
> +};
> +
> +static int intel_pcie_probe(struct platform_device *pdev)
> +{
> +	const struct intel_pcie_soc *data;
> +	struct device *dev =3D &pdev->dev;
> +	struct intel_pcie_port *lpp;
> +	struct pcie_port *pp;
> +	struct dw_pcie *pci;
> +	int ret;
> +
> +	lpp =3D devm_kzalloc(dev, sizeof(*lpp), GFP_KERNEL);
> +	if (!lpp)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, lpp);
> +	pci =3D &lpp->pci;
> +	pci->dev =3D dev;
> +	pp =3D &pci->pp;
> +
> +	ret =3D intel_pcie_get_resources(pdev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D intel_pcie_ep_rst_init(lpp);
> +	if (ret)
> +		return ret;
> +
> +	data =3D device_get_match_data(dev);
> +	pci->ops =3D &intel_pcie_ops;
> +	pci->version =3D data->pcie_ver;
> +	pci->atu_base =3D pci->dbi_base + data->pcie_atu_offset;
> +	pp->ops =3D &intel_pcie_dw_ops;
> +
> +	ret =3D dw_pcie_host_init(pp);
> +	if (ret) {
> +		dev_err(dev, "cannot initialize host\n");
> +		return ret;
> +	}
> +
> +	/* Intel PCIe doesn't configure IO region, so configure
> +	 * viewport to not to access IO region during register
> +	 * read write operations.
> +	 */
> +	pci->num_viewport =3D data->num_viewport;
> +	dev_info(dev, "Intel PCIe Root Complex Port %d init done\n", lpp->id);
> +
> +	return ret;
> +}
> +
> +static const struct dev_pm_ops intel_pcie_pm_ops =3D {
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(intel_pcie_suspend_noirq,
> +				      intel_pcie_resume_noirq)
> +};
> +
> +static const struct of_device_id of_intel_pcie_match[] =3D {
> +	{ .compatible =3D "intel,lgm-pcie", .data =3D &pcie_data },
> +	{}
> +};
> +
> +static struct platform_driver intel_pcie_driver =3D {
> +	.probe =3D intel_pcie_probe,
> +	.remove =3D intel_pcie_remove,
> +	.driver =3D {
> +		.name =3D "intel-gw-pcie",
> +		.of_match_table =3D of_intel_pcie_match,
> +		.pm =3D &intel_pcie_pm_ops,
> +	},
> +};
> +builtin_platform_driver(intel_pcie_driver);
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.=
h
> index 29d6e93fd15e..f6e7e402f879 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -673,6 +673,7 @@
>  #define  PCI_EXP_LNKCTL2_TLS_8_0GT	0x0003 /* Supported Speed 8GT/s */
>  #define  PCI_EXP_LNKCTL2_TLS_16_0GT	0x0004 /* Supported Speed 16GT/s */
>  #define  PCI_EXP_LNKCTL2_TLS_32_0GT	0x0005 /* Supported Speed 32GT/s */
> +#define  PCI_EXP_LNKCTL2_HASD		0x0200 /* Hw Autonomous Speed Disable */

s/Hw/HW

>  #define PCI_EXP_LNKSTA2		50	/* Link Status 2 */
>  #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	52	/* v2 endpoints with link end =
here */
>  #define PCI_EXP_SLTCAP2		52	/* Slot Capabilities 2 */
> --=20
> 2.11.0


