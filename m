Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1199BB49A5
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2019 10:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389062AbfIQIhM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Sep 2019 04:37:12 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:33744 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730213AbfIQIhM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Sep 2019 04:37:12 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 48CEBC0DC0;
        Tue, 17 Sep 2019 08:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1568709430; bh=HB5kWNNAFgjZji6cvmV+dXpzClVm3jM2dkkAECk/V9g=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=GusOcEwk1k0XB0S8BATRffvfxjb8vy04EFYhrzo8Pv703CSMRM7FcixNmgiFsFqYj
         EfTQ+81mlDrjOl2qgXdTQeI/z3Vebo90DH19AvgmQ4IUi/839kcfxM2AEwPjDGPs06
         y03p+a1yhLMC84LM7VF2Gf3UJvCJXgbA5dlESsG/3KbF62a9iQcb7Na0FRTNDBGAtj
         Aa4bg4C2BipgywF/2mkC2cSJFvYCMhfAJWozKkGfwG25R/yZtJljOc+nfjvLZHpFLv
         Y6dJX5ow3GBHIQGgjMiJJau552jLKdinnAxeSqEOayux1k0mxo7dPjW6jILYBXpDz6
         GV4GKyTwoulvA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id A29BAA006C;
        Tue, 17 Sep 2019 08:37:09 +0000 (UTC)
Received: from US01WEHTC2.internal.synopsys.com (10.12.239.237) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 17 Sep 2019 01:36:53 -0700
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 17 Sep 2019 01:36:53 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Tue, 17 Sep 2019 01:36:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdlatGn5yK3QEG4r6R7MSoLAPt1MDraWnxE05uQ1GcxN+JpYcCEZJ4hmA3G10IgvtRLvVWk5awnRR9eGRnJ2GiCxCcEeTsfdo8IdXX8b2ViUqrC6XF0APYRe9LMbZDsBTU73ZcHt6TI9q8Z7Q4jDVkcdX10546zueKDWmf4pKk+xzE+xMnBusD831sKQit/lEcfJJhKePh3QYJHffXphQrvWYXi1/WcnguA4ZzPI9GJ2NGGL6jFL6w8bH79/7UNn0zQdbXLQUUBCSpVaR1eOi9DHKNC+l+Xv0fZXrUcidjOSwAFm636miYQho4G6mbQNBP5+sJObDdcmIoR5rzqMNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuvKNbjhZHhhAkeJdg5Cw0jyD7fzSoGjEvGA2XJZ6PU=;
 b=FJvrSiX8vUkRlOvRkABBoCHdIY+lzSK2B+ZX5JXUI5EwYU/1IlPH+4Ljy/az2sKshtoQZtJJCD/vKGTk4mWJTME/KGZDgF7hO5PPbYb6cuVr2fUrG4V5laBP/P3Azdac3n5MLqZl3T+PBZEMrc0ruiCH5E3u9op84u+bQvi0HJDWcYqsvnTRMzFwWg3LEg/H3q+5a3vv9cKwUjJLuOLEMv347ghQHjvxrdi0It6cVVCOCxa4TxQiJS+f0njtcQr/uKCPW5LBpRc/dDmdClAWqauu80NX3SxZHmJ3p1OWrRzoBXDJqS4dD5yz93bOlpCdmlJhAq1Ws0FlHs5j2Il4Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuvKNbjhZHhhAkeJdg5Cw0jyD7fzSoGjEvGA2XJZ6PU=;
 b=piEaS+R9lXBwAWd2on4fGkxEiDFWKaM/LSywk/m4EpIOKct9gEUUCM+UnbFi3JtKVZbGVL7u6R34mKMlbfqXfGlng0h4eYoY/2nhzQPRmG51cXbfQhKHoYSbCtThU1D8lDgoNbTxhNq11FOEkpCg37WBj8Mw1hyJoqxFFvuJ9AE=
Received: from DM6PR12MB4010.namprd12.prod.outlook.com (10.255.175.83) by
 DM6PR12MB3449.namprd12.prod.outlook.com (20.178.198.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.21; Tue, 17 Sep 2019 08:36:51 +0000
Received: from DM6PR12MB4010.namprd12.prod.outlook.com
 ([fe80::dd4:2e5:e564:8684]) by DM6PR12MB4010.namprd12.prod.outlook.com
 ([fe80::dd4:2e5:e564:8684%5]) with mapi id 15.20.2263.023; Tue, 17 Sep 2019
 08:36:51 +0000
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Denis Efremov <efremov@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Andrew Murray <andrew.murray@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: RE: [PATCH v3 03/26] PCI: dwc: Use PCI_STD_NUM_BARS
Thread-Topic: [PATCH v3 03/26] PCI: dwc: Use PCI_STD_NUM_BARS
Thread-Index: AQHVbM+dP1tVJVvtT0GBDBmZ0Xql2KcvjGtw
Date:   Tue, 17 Sep 2019 08:36:51 +0000
Message-ID: <DM6PR12MB401084E5728292359C93440CDA8F0@DM6PR12MB4010.namprd12.prod.outlook.com>
References: <20190916204158.6889-1-efremov@linux.com>
 <20190916204158.6889-4-efremov@linux.com>
In-Reply-To: <20190916204158.6889-4-efremov@linux.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTQ5NzQ2YjcyLWQ5MjYtMTFlOS05ODhmLWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFw0OTc0NmI3NC1kOTI2LTExZTktOTg4Zi1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjM5OTQiIHQ9IjEzMjEzMTgzMDA4NTk5?=
 =?us-ascii?Q?ODg5NyIgaD0iTnJzOG1oZlNCNU8zRDNjcU1VVEpuV2x4dlo0PSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFB?=
 =?us-ascii?Q?eFdjd0xNMjNWQVlQa3M5UW5aQXQyZytTejFDZGtDM1lPQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUhBQUFBQ2tDQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQVFBQkFBQUEvSG9zaVFBQUFBQUFBQUFBQUFBQUFKNEFBQUJtQUdrQWJn?=
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
x-ms-office365-filtering-correlation-id: 831237ca-feb6-406d-e18b-08d73b4a2fea
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR12MB3449;
x-ms-traffictypediagnostic: DM6PR12MB3449:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3449153F71F9430DCB825A78DA8F0@DM6PR12MB3449.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(199004)(189003)(26005)(6246003)(107886003)(71190400001)(53546011)(66476007)(66446008)(66556008)(446003)(6436002)(76116006)(66946007)(5660300002)(256004)(99286004)(498600001)(476003)(110136005)(64756008)(3846002)(6116002)(25786009)(9686003)(71200400001)(7696005)(7736002)(305945005)(74316002)(14454004)(186003)(229853002)(54906003)(6506007)(33656002)(11346002)(102836004)(86362001)(52536014)(76176011)(2906002)(486006)(66066001)(8936002)(55016002)(81166006)(81156014)(4326008)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR12MB3449;H:DM6PR12MB4010.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Hk987qDFqiKID5Kk1xgbgahvpCfcpVTvVErWlVBOPp9htirnGSnxtEK3ew2/ZdQWQZfDFV94NyJb0IH59ZuPmuT/41720SnYX/OLovHsPdguzruuHwzNotdCYj8IigSS6IBmWHUmx7fJvgqrXu4UYEViP3WTJqK+lwdTOV32EpyCkJMQ9wdITguk8SYepl4KpWgTo/1k91uwKZS1Sh1VssYYquwmaNIH5s3onP/T+et9ydVR2HhZcdUqIR17ckhw39ZOWRA4q3lMCJcIlniReWqYdEzBayhPh4seM/N5bIuaVRV9Wh0cm+0Bo3IABiIaeC+AVLZs5d1MtWfTNAwVVGLON2truo73a41TanqK/HPT/bqZ70Kp1xOhwtqFcmVMQSJiKAXUwiqXcG5btnH5w8Eo0nmIS/58FXmKIgomVNs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 831237ca-feb6-406d-e18b-08d73b4a2fea
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 08:36:51.2246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fGtHyU18LHP+Ieu6KWjKDnRYL7a4UI6JP/itkJf29ArliZbZORisB0tsYH1G16cZXdSMt0i8Yh4l1rfgldVE9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3449
X-OriginatorOrg: synopsys.com
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 16, 2019 at 21:41:35, Denis Efremov <efremov@linux.com>=20
wrote:

> To iterate through all possible BARs, loop conditions refactored to the
> *number* of BARs "i < PCI_STD_NUM_BARS", instead of the index of the last
> valid BAR "i <=3D BAR_5". This is more idiomatic C style and allows to av=
oid
> the fencepost error. Array definitions changed to PCI_STD_NUM_BARS where
> appropriate.
>=20
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c           | 2 +-
>  drivers/pci/controller/dwc/pci-layerscape-ep.c    | 2 +-
>  drivers/pci/controller/dwc/pcie-artpec6.c         | 2 +-
>  drivers/pci/controller/dwc/pcie-designware-plat.c | 2 +-
>  drivers/pci/controller/dwc/pcie-designware.h      | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/contro=
ller/dwc/pci-dra7xx.c
> index 4234ddb4722f..b20651cea09f 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -353,7 +353,7 @@ static void dra7xx_pcie_ep_init(struct dw_pcie_ep *ep=
)
>  	struct dra7xx_pcie *dra7xx =3D to_dra7xx_pcie(pci);
>  	enum pci_barno bar;
> =20
> -	for (bar =3D BAR_0; bar <=3D BAR_5; bar++)
> +	for (bar =3D 0; bar < PCI_STD_NUM_BARS; bar++)
>  		dw_pcie_ep_reset_bar(pci, bar);
> =20
>  	dra7xx_pcie_enable_wrapper_interrupts(dra7xx);
> diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci=
/controller/dwc/pci-layerscape-ep.c
> index be61d96cc95e..c84218d8ffd3 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> @@ -57,7 +57,7 @@ static void ls_pcie_ep_init(struct dw_pcie_ep *ep)
>  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
>  	enum pci_barno bar;
> =20
> -	for (bar =3D BAR_0; bar <=3D BAR_5; bar++)
> +	for (bar =3D 0; bar < PCI_STD_NUM_BARS; bar++)
>  		dw_pcie_ep_reset_bar(pci, bar);
>  }
> =20
> diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/cont=
roller/dwc/pcie-artpec6.c
> index d00252bd8fae..9e2482bd7b6d 100644
> --- a/drivers/pci/controller/dwc/pcie-artpec6.c
> +++ b/drivers/pci/controller/dwc/pcie-artpec6.c
> @@ -422,7 +422,7 @@ static void artpec6_pcie_ep_init(struct dw_pcie_ep *e=
p)
>  	artpec6_pcie_wait_for_phy(artpec6_pcie);
>  	artpec6_pcie_set_nfts(artpec6_pcie);
> =20
> -	for (bar =3D BAR_0; bar <=3D BAR_5; bar++)
> +	for (bar =3D 0; bar < PCI_STD_NUM_BARS; bar++)
>  		dw_pcie_ep_reset_bar(pci, bar);
>  }
> =20
> diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/=
pci/controller/dwc/pcie-designware-plat.c
> index b58fdcbc664b..73646b677aff 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-plat.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
> @@ -70,7 +70,7 @@ static void dw_plat_pcie_ep_init(struct dw_pcie_ep *ep)
>  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
>  	enum pci_barno bar;
> =20
> -	for (bar =3D BAR_0; bar <=3D BAR_5; bar++)
> +	for (bar =3D 0; bar < PCI_STD_NUM_BARS; bar++)
>  		dw_pcie_ep_reset_bar(pci, bar);
>  }
> =20
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/c=
ontroller/dwc/pcie-designware.h
> index ffed084a0b4f..7e0526bd71ad 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -205,7 +205,7 @@ struct dw_pcie_ep {
>  	phys_addr_t		phys_base;
>  	size_t			addr_size;
>  	size_t			page_size;
> -	u8			bar_to_atu[6];
> +	u8			bar_to_atu[PCI_STD_NUM_BARS];
>  	phys_addr_t		*outbound_addr;
>  	unsigned long		*ib_window_map;
>  	unsigned long		*ob_window_map;
> --=20
> 2.21.0


Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>


