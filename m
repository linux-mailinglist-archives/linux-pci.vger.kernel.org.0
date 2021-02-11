Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5063188C3
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 11:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhBKKz2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 05:55:28 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:60396 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230402AbhBKKxE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Feb 2021 05:53:04 -0500
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 27B20C00C1;
        Thu, 11 Feb 2021 10:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613040721; bh=huvHkCN1Y5rpI/VOe6O10x3h0qkXAcQQiwtF1wyQca0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ZWj7smFBybFdNrkV7PRVDgvmpIzpG9tN5BaVcrMVln5Lnd2Ffv2tICEi8m80V31+T
         U8cof/imIcBYbt1bSAw1A5j5s4ZB0eACA31sYonuphPFIOSbWazAmQqhyFkBZ1ear9
         dwcPAtgnq0K3/smhpq1ZPerU9H054QJN45Pgvv9MVG0CrNuzLTfoqeV4LzVLqC8Yuj
         oWgGdm7LBweBdWOxVKQG9OktCW3EP8iiW1BC4KgHHuq1+TmNlO1xtkzfNCcLE3l3pY
         8ygWv3YXHuBfcO/rjZMORyK0/VUJEp96YtK8B9xkoSeUx03K5QaDthjytxpbK+9nu5
         5v45iRaIEczeA==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 9361EA0081;
        Thu, 11 Feb 2021 10:52:00 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 8AD48800BF;
        Thu, 11 Feb 2021 10:51:58 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=gustavo@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="lLE8Socp";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2Af5hgYaIH81LPlS8oJoIqr0CwXI9BlA6SMtV5tsb6lzz3dUAyv5xQW13w8Xla6A+uubrnytZJjILUkyc8/zVjGr5krVsrnz+7KxAQhfV1tC2IwI8r/vGyKpxqZPh2Pjz6CY3vOscv5KBcyNrl5w3FQwShwF4/qHgoOkq4bwceS5Q5uhGcUF7TP6ljbuJEloZgH30cn66LkzBK37FMXSXCreJvW7s5YWh0kBBV+nKjXnD/mWm7qmJgffzoq6r1JIdnRKi3b/LhMsJnVxoXrqvp+pvOirpu36TxoSOeEza0TZ1gVybsKysQeGTSqSCw0abbe5b2QPNe9lJ1CqtdPhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/nhDLQXmyacdcvKTxDIl7wH2TbhS/hhITsR4LaNWWU=;
 b=imx8biU/qok1DtTruJrZrogD54CW2dEO/62nQhkQGWylQqH9Kr36QWNzlRh3mEghKgVN70Y4ylQaBuHHV5Yuj0SwVnQrUS2zIiMjB0TiaZ37fEznHSTCK79vt/MLkloVbZLsLinLSiK6SUSxGwb6snx6+n77HOmpp67e8J7+SGfBEKwfDsYng+bHmMjRKyl2hKWdAiup8/9jR8rL6a6DkDIYfUR7/cLQZlUL+L37rAuvI2TdMu7IXWL+NHA4d7WiBCepFq7QDD+Pjuwul6FW4t6sSMX99LY3kUWnPN/rhT8aqyG2X/9omB8+co1kzQlCXTE1zCUZq3XWsS3HBgONIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/nhDLQXmyacdcvKTxDIl7wH2TbhS/hhITsR4LaNWWU=;
 b=lLE8SocpcShzRE7Pe2zksuU7Yx3wlrVQ3UO7GJSp9ou/tv2qyFJdzRndScy9qiJM4MVIhZtzQH3ihL9R/wQsVXB/HFLni//dvayqWwVKFNjh6nK9xAAfny+mouv0S2ozqliMP1I4VmQdgpDJpzjl31x8LIW69YTc4xyrlcnDXDw=
Received: from DM5PR12MB1835.namprd12.prod.outlook.com (2603:10b6:3:10c::9) by
 DM5PR1201MB0121.namprd12.prod.outlook.com (2603:10b6:4:56::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.24; Thu, 11 Feb 2021 10:51:56 +0000
Received: from DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052]) by DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052%10]) with mapi id 15.20.3825.030; Thu, 11 Feb
 2021 10:51:56 +0000
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: RE: [PATCH v5 1/6] misc: Add Synopsys DesignWare xData IP driver
Thread-Topic: [PATCH v5 1/6] misc: Add Synopsys DesignWare xData IP driver
Thread-Index: AQHXAFWPyAqykiKVp0+x9nNcxSm5BKpSsFcAgAAErwCAAAN3AIAAAIDggAAI/4CAAASkIA==
Date:   Thu, 11 Feb 2021 10:51:56 +0000
Message-ID: <DM5PR12MB1835BC7CFD840E60A92EA56EDA8C9@DM5PR12MB1835.namprd12.prod.outlook.com>
References: <cover.1613034397.git.gustavo.pimentel@synopsys.com>
 <02835da8fc8c9293fecbe666a8db3fb79276fdde.1613034397.git.gustavo.pimentel@synopsys.com>
 <YCT5KDnAWex8fvbz@kroah.com>
 <DM5PR12MB1835A23E60363C730E4D69AFDA8C9@DM5PR12MB1835.namprd12.prod.outlook.com>
 <YCT//nmQpOJD9row@kroah.com>
 <DM5PR12MB1835522220E35874106BB924DA8C9@DM5PR12MB1835.namprd12.prod.outlook.com>
 <YCUH9eCwiJiB5t3g@kroah.com>
In-Reply-To: <YCUH9eCwiJiB5t3g@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTI0OGI5NzljLTZjNTctMTFlYi05OGU2LWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFwyNDhiOTc5ZS02YzU3LTExZWItOThlNi1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjMyOTkiIHQ9IjEzMjU3NTE0MzEwNjIy?=
 =?us-ascii?Q?NDE4MCIgaD0iVXNEejQyNFg0T3JvQWlWcDJCL0w3dTJueUljPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFB?=
 =?us-ascii?Q?MG9PVG1Zd0RYQWR1cVhTZ0Z0STlhMjZwZEtBVzBqMW9PQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUhBQUFBQ2tDQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQVFBQkFBQUFOclNWM2dBQUFBQUFBQUFBQUFBQUFKNEFBQUJtQUdrQWJn?=
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
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [89.155.14.32]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2933ea20-62e2-48eb-d8a6-08d8ce7b0cfa
x-ms-traffictypediagnostic: DM5PR1201MB0121:
x-microsoft-antispam-prvs: <DM5PR1201MB0121EF164189BB31B4990063DA8C9@DM5PR1201MB0121.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 34s1OJhTzcJE28aFUWNCx0wXpHn1TaB/ug99rQ7ILmBFPXsjmG7j1vvrv4qLFK577SPVpJRbn4ILcGGRNXDdKTHs10WHF+Yy+0x1xZi1s2tXgDY5vPgk7KrEz7NGlIDnCCfme/j15mNNvaqco7l9Lf+pC9q7hxCFjeDe/tSjEUj7xyo8pPwj06amrqlNY8PwigvRXjiq8TszN9b6nJNDwScgtpW81xSyaSw357J1tDs3FeU5d+MRVIlJp+u6afL7LiCGvr7sDUKDrmVosvFMH4SYbVhlmOexOKmLXDEEAyvm/WhjoHMpTnB0XOoOsbh8DT0JN320HdnFbgQTlhbp2Ujve5VGbhT4vcW4lm6Bv3eNt7TAO8/RP73ZVQIncfxrYC8mphNTFL4UTLXATF2A3FdmP5G3QymooDrRJ3i7+swjpc2IoQMjkxzroBVMPVXkO/J7VIu8uGwTED2WsqUCFaNUYD+z3l1P860QGu6gZ+JLBt2xS09KiBOJSSuJ7Lzp6ts/Lu3cJbwbenL9h2L+Wg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1835.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(376002)(346002)(366004)(66946007)(2906002)(66556008)(66446008)(66476007)(76116006)(7416002)(478600001)(4326008)(7696005)(8936002)(6916009)(5660300002)(71200400001)(316002)(86362001)(6506007)(53546011)(9686003)(83380400001)(26005)(186003)(33656002)(52536014)(54906003)(8676002)(64756008)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?silK5wjm/VJMM8vhCnP4T7hLVeX+iqgW/6/5Kis4DSEVD9udZZYGCs6QqoMK?=
 =?us-ascii?Q?Av2vGTe0tmBp09gPxDWrwYJ6zT2sGT8GgKLWTVPgR0Re8NwlJ/uNkK+NPf8Y?=
 =?us-ascii?Q?mJLAJpOMleLBthLrNGwL/a4N7UP+G7/M3yVDiYKotw0ZjlsnUnc//IutBeTB?=
 =?us-ascii?Q?S3tjTZK94fqDgGNQ5LeGQqbVOHjmICSPVCMw4LAinibuX4Af18sAAo3EEjSK?=
 =?us-ascii?Q?z5fDXUPanw3UmcDia3uFPJL8XCaFtO8vjXG+vPZYWfW02IgmJdGx+eShU3m9?=
 =?us-ascii?Q?4ez9pWGCEU/tBD90Gnsh4P2W0RubvaypYWqmRCCSYFcEKAs7YidYIAcMeIR6?=
 =?us-ascii?Q?kJDEfOJuzqdGcFMv2e9BK5Cx5xveJW+IX2w/FJ7k/9PgeQYTYSaUsAfGJ7RA?=
 =?us-ascii?Q?ITxEudZyWIhUbtBZ8swFLltRw3is8ip7WBM96byzZrJiD3vQwRcZcOGK0q6E?=
 =?us-ascii?Q?ovwyW/8c7e4tAU83OAkqDRNp/vyUenhO/423FLt9MqOzipYJHdPDk3+xl+yU?=
 =?us-ascii?Q?j8xscUFTAZNwdzet+42zwW+erO1oD/B28YORhImuCmedhL9v+HSzLfKe7NYs?=
 =?us-ascii?Q?sLj+H8GaW/uMdhtM+0EvaP+TfbFWi9BXm27wnd2Xtyje6wsB9WG7XRKagBMc?=
 =?us-ascii?Q?KBnenMdcgapEcP/z+pE5O+VUZJrD20bWbKy4R+9D9Pl7grRofWUAc6+xOvnO?=
 =?us-ascii?Q?2PiRcC5wx2JczZIlsa6wcw9YLSAdVAusShzgfYs6ul8wKn+Qxtkm991WlGhp?=
 =?us-ascii?Q?N6vmnV6A/m3LDpU7VnpyU2b6rwSRUAs2mysgBA8C8uXlZ3nDdCvZvrFVZXjL?=
 =?us-ascii?Q?af2oMsa4OQPl5xBCjbGjT5eWPZrhZe/RBdIbEYY0ZXOhhnJqc13qlN1Zjuwy?=
 =?us-ascii?Q?GrGpH4dutAsWKP7+YDpqhbzrbARd+DEHn1BE7tryaMtD697WEY7+My1pV91b?=
 =?us-ascii?Q?J6jmDvBWX2Bo7ZkBC/yG5Wb0b0Pjno5cfjYgyq2oco0zsjbeJFCGHZHerSS6?=
 =?us-ascii?Q?szNhF/fmoBiC4BPSFXUq3Pibyi38SF9G44kQnXvQP0NZJmb/1YtwO1sb2B/G?=
 =?us-ascii?Q?mG4ieYKobCn0vx0Hzam47O58JSEll0i8xsdbF/sXexylFbgNnWxu6AS833rO?=
 =?us-ascii?Q?CN6RL/bjR9YDk1ar4LnS8M24a5la2GWiZd2EQPLHmbO1tiTy5U8GyFE8VyVP?=
 =?us-ascii?Q?HRnsf9zVB6HNe03QOcvMRv5nlns+6Mou0hjzaYjYU31vnizP5qHv5lBIbOos?=
 =?us-ascii?Q?7cqIcR5IIbT+JC9QyiISl2X7f+biG9bTWsQxW7D4AhlrYgeWLUrT/E3bksnf?=
 =?us-ascii?Q?1TfrEqRIfVI2fARiPD3A6lgV?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2933ea20-62e2-48eb-d8a6-08d8ce7b0cfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2021 10:51:56.5671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P7k45yjvqHv5Y6Wf8WDSZdmWTRlHqJwUDPifYR9xMrYLGHkbJBdjzNSS48TNehO0eRcum9zig1Xnepm/uh7V9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0121
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 11, 2021 at 10:33:25, Greg Kroah-Hartman=20
<gregkh@linuxfoundation.org> wrote:

> On Thu, Feb 11, 2021 at 10:21:07AM +0000, Gustavo Pimentel wrote:
> > On Thu, Feb 11, 2021 at 9:59:26, Greg Kroah-Hartman=20
> > <gregkh@linuxfoundation.org> wrote:
> >=20
> > > On Thu, Feb 11, 2021 at 09:50:33AM +0000, Gustavo Pimentel wrote:
> > > > On Thu, Feb 11, 2021 at 9:30:16, Greg Kroah-Hartman=20
> > > > <gregkh@linuxfoundation.org> wrote:
> > > >=20
> > > > > On Thu, Feb 11, 2021 at 10:08:38AM +0100, Gustavo Pimentel wrote:
> > > > > > +static ssize_t write_show(struct device *dev, struct device_at=
tribute *attr,
> > > > > > +			  char *buf)
> > > > > > +{
> > > > > > +	struct pci_dev *pdev =3D to_pci_dev(dev);
> > > > > > +	struct dw_xdata *dw =3D pci_get_drvdata(pdev);
> > > > > > +	u64 rate;
> > > > > > +
> > > > > > +	mutex_lock(&dw->mutex);
> > > > > > +	dw_xdata_perf(dw, &rate, true);
> > > > > > +	mutex_unlock(&dw->mutex);
> > > > > > +
> > > > > > +	return sysfs_emit(buf, "%llu MB/s\n", rate);
> > > > >=20
> > > > > Do not put units in a sysfs file, that should be in the documenta=
tion,
> > > > > otherwise this forces userspace to "parse" the units which is a m=
ess.
> > > >=20
> > > > Okay.
> > > >=20
> > > > >=20
> > > > > Same for the other sysfs file.
> > > > >=20
> > > > > And why do you need a lock for this show function?
> > > >=20
> > > > Maybe I understood it wrongly, please correct me in that case. The=
=20
> > > > dw_xdata_perf() is called on the write_show() and read_show(), to a=
void a=20
> > > > possible race condition between those calls, I have added this mute=
x.
> > >=20
> > > What race?  If the value changes with a write right after a read, wha=
t
> > > does it matter?
> > >=20
> > > What exactly are you trying to protect with this lock?
> >=20
> > The write_store() does a procedure to enable the traffic on the write=20
> > direction, however, the write_show() does a different procedure to=20
> > calculate the link throughput speed, which uses a different set of=20
> > registers on the HW.
> >=20
> > Similar happens on the read_store() (which enable the traffic on the re=
ad=20
> > direction) and on the read_show()
> >=20
> > To summarize write_store() follows the same approach of read_store() an=
d=20
> > the write_show() of the read_show(). I added the mutex on those functio=
ns=20
> > for instance to avoid while during the write_show() call the possibilit=
y=20
> > of been called the read_show() messing up the link throughput speed=20
> > calculation.
> > Or while during the write_store() call to be called the read_store or=20
> > even the write_show() for the same reasons.
>=20
> If you need to protect these types of things, but the lock down in the
> function that does this, not above it which forces people to audit
> everything and manually try to determine what lock is doing what for
> what.
>=20
> Make it impossible to get wrong, as it is, you have to do extra work
> here to keep things working properly, always a bad idea in an api.

I think I understood what you mean, I will *reduce* the mutex scope to=20
the basic functions that are called by the sysfs *_store() and *_show().

-Gustavo

>=20
> thanks,
>=20
> greg k-h


