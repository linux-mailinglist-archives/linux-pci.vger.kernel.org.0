Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8BE5DE6C5
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 10:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfJUIl1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 04:41:27 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:47050 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726181AbfJUIl0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Oct 2019 04:41:26 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E5F0EC25D7;
        Mon, 21 Oct 2019 08:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1571647285; bh=eEUBnv1pzf3UoYfKVpCpY5eRFV7GDUKzXN0EzlLRFZg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=l/3HO8dgD1mQVOZmys/QmfInfK3nYsyOZuTNWtswMzzwK90yIsubjJmC+7QnMW6pn
         l8cndv6vutnUVIap9DJpm7hOF8D3Wt4N6bq4Qvj4otKEXebFx++FTcbcJ4rzdunpDh
         HFCOIXhBVZ/wOHdCkExyVcIwZbDKdIXo7WthgbyNfbwVq7KCfLe3dGt/eyo2L8JGj0
         dT5EmG4LaMjzAfJJ50ap/nL6xJJYI7Kd4ZovGyib7LXrhvErXTwS9V0AEkYsMyArVw
         Xr7PtE4mhi+o0fU3NuGsYQ/A9Z15Xj0D/Z2BfFQX0YCy61ciI2YltfMqwfRN7XHo9Y
         8CwePkCx1vfAQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 68D0DA00B2;
        Mon, 21 Oct 2019 08:41:19 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 21 Oct 2019 01:40:04 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 21 Oct 2019 01:40:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzMlvOWMc3CBpgk0trqVwu41A1ZjJWCZfCfZtcmGjmPK+rfSJ61Nqi87NuBjzXuwOrFbjWyx2VGvSOu+MaLvxUyv4WnRTckXQw45u1eMTgsKtfubkjAI9BFr7rrGc5EGdKz12lA/r9+YzvPsuU1/HKwzMqAoBs02Hf/cNL0x/0aFe5jWspq0sNrvUX/v4CmM0FOEzqJJE8rt0V10VhTM89EAeWQ6cySn6HPKWuxVxHfJMUwLk6nYVjprn0Q/3I/zQ8bCKGDr3xMu32d2strsB5oP2O/X68KBD+pg5BG5yJMJh562AuudPaJDm2uap9XbspfyKlIYi03rykKUS2calw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3NNPn+PlCfLKkw9rNpShwQ3XpCLt3/jwa57PLrfj60=;
 b=WtJFUfVHs8AjViZfsUC3upqf1I1aI9fT1tfx/6WgXUns0aghPnXMukBz4kBVMVvVVYrcmOB2zbFROcDaof5LYS2raPCy8f55xHWABF32+o0PAohboOz0unn+pV0YG9AS0xeQiFL4OPF7m6oW85SyixBAYmrJv8q3nV072ki0Vy1I4IPoTXN5QmO5reZFJgbP/gB4LUE0PH556fEcydpGfdUDRRKmgotCQbQrnpH4PX3fmvGu6wtTLx5iPVFc03Em77z/X+a0tOk2Co0L9YsR2UINVNToQcbwa3g2h+oPWLSi/q2Dpim5kivbutEZmXYINZhHokCIz4d6wfIg0lri1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3NNPn+PlCfLKkw9rNpShwQ3XpCLt3/jwa57PLrfj60=;
 b=bscryb/JVjCsRpZeX+lK3K6oBEFKJsyjeAmzVroIgXKvNmBfvmg3qtgUy81PXY6ZZl//jGMPCDIJoy63Yse7KJ3U/IF4jLwQSnZIvKpXpd2KYIi5/Q/n3D+KdQtpq1sWELyl0tP7p5IjW8T0gwUVp88FnM1Hw/uEHGSYaxrBDyU=
Received: from CH2PR12MB4007.namprd12.prod.outlook.com (52.132.247.78) by
 CH2PR12MB3926.namprd12.prod.outlook.com (52.132.245.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Mon, 21 Oct 2019 08:40:01 +0000
Received: from CH2PR12MB4007.namprd12.prod.outlook.com
 ([fe80::c0b:d777:b62d:9a5]) by CH2PR12MB4007.namprd12.prod.outlook.com
 ([fe80::c0b:d777:b62d:9a5%7]) with mapi id 15.20.2347.028; Mon, 21 Oct 2019
 08:40:01 +0000
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
Subject: RE: [PATCH v4 3/3] pci: intel: Add sysfs attributes to configure pcie
 link
Thread-Topic: [PATCH v4 3/3] pci: intel: Add sysfs attributes to configure
 pcie link
Thread-Index: AQHVh9pkg5qa2l7qKkufp5bM7YjXW6dkxV8w
Date:   Mon, 21 Oct 2019 08:40:01 +0000
Message-ID: <CH2PR12MB400776877B54F866691CA201DA690@CH2PR12MB4007.namprd12.prod.outlook.com>
References: <cover.1571638827.git.eswara.kota@linux.intel.com>
 <d8574605f8e70f41ce1e88ccfb56b63c8f85e4df.1571638827.git.eswara.kota@linux.intel.com>
In-Reply-To: <d8574605f8e70f41ce1e88ccfb56b63c8f85e4df.1571638827.git.eswara.kota@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTVjNmI2Y2Q4LWYzZGUtMTFlOS05ODkzLWE0NGNj?=
 =?us-ascii?Q?OGU5Y2YwNlxhbWUtdGVzdFw1YzZiNmNkOS1mM2RlLTExZTktOTg5My1hNDRj?=
 =?us-ascii?Q?YzhlOWNmMDZib2R5LnR4dCIgc3o9IjY4NDkiIHQ9IjEzMjE2MTIwNzk5MzMy?=
 =?us-ascii?Q?NzcxOCIgaD0idVZHY3llSmFjcjk1SGZibmdLRk1oeXBGRXdNPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFC?=
 =?us-ascii?Q?bVlJY2Y2NGZWQVJEQlFsQ3lRN3BBRU1GQ1VMSkR1a0FPQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: 004be349-487d-4d0e-53ed-08d756024362
x-ms-traffictypediagnostic: CH2PR12MB3926:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB3926F5E4F0E8AEAA3E984B51DA690@CH2PR12MB3926.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-forefront-prvs: 0197AFBD92
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(396003)(366004)(376002)(136003)(39860400002)(199004)(189003)(76176011)(446003)(6436002)(7696005)(55016002)(2906002)(25786009)(478600001)(11346002)(14454004)(486006)(476003)(33656002)(71190400001)(99286004)(71200400001)(256004)(14444005)(186003)(53546011)(6506007)(26005)(110136005)(54906003)(102836004)(316002)(9686003)(86362001)(7416002)(66946007)(66476007)(66556008)(64756008)(66446008)(4326008)(76116006)(8936002)(3846002)(6116002)(305945005)(7736002)(5660300002)(2201001)(52536014)(66066001)(81156014)(81166006)(2501003)(6246003)(8676002)(229853002)(74316002)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR12MB3926;H:CH2PR12MB4007.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VB0Zq+tUX37tQzbdfxkVRjtgwVNHz2M6LCcxnZe31gNlQ2SiNKaNt4qc+1KADzvFUy4oS79NZQXTRdCo7prUReQftVuzX9pwonSMrhhdvRGmCGsCzjbduknqJSaENJh93Nzg9DtKzq62yteIcoQypseYnpHWlxoY4JFmG7Sh2PhC2DhU75GdtuNSmJNTmyVgN5NT/10G2vqyWsBN7R2ncC3ePQT5K/jbFepY17wE0pyZS95xHtzsgVSbJaGVG1ZpYNxjzDMkh2LXu27AAyu8rV7wFxfUywPXa7Dg07pYVeWpblbLZyj7zngAftu86Z+XeRUnUrcg7d+oeg3r93qyjAhFJZUumdkoBUTNQ+5P14VtWhq5x3eq7A9puPwElmnrbnF50c/NlBGVv2ya84IHWoaj3YvrWRPrFbxXVLQvAps=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 004be349-487d-4d0e-53ed-08d756024362
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2019 08:40:01.5146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LHI/zRvB5ym40rJlcGBP11ppr66qVdlxEilvzhwhuEpCfv9QHzVTk32bHKGOPbni6Mg/gQI1tTYgBFZ83PjSrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3926
X-OriginatorOrg: synopsys.com
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 21, 2019 at 7:39:20, Dilip Kota <eswara.kota@linux.intel.com>=20
wrote:

> PCIe RC driver on Intel Gateway SoCs have a requirement
> of changing link width and speed on the fly.
> So add the sysfs attributes to show and store the link
> properties.
> Add the respective link resize function in pcie DesignWare
> framework so that Intel PCIe driver can use during link
> width configuration on the fly.
>=20
> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c |   9 +++
>  drivers/pci/controller/dwc/pcie-designware.h |   3 +
>  drivers/pci/controller/dwc/pcie-intel-gw.c   | 112 +++++++++++++++++++++=
+++++-
>  3 files changed, 123 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/c=
ontroller/dwc/pcie-designware.c
> index 4c391bfd681a..662fdcb4f2d6 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -474,6 +474,15 @@ int dw_pcie_link_up(struct dw_pcie *pci)
>  		(!(val & PCIE_PORT_DEBUG1_LINK_IN_TRAINING)));
>  }
> =20
> +void dw_pcie_link_width_resize(struct dw_pcie *pci, u32 lane_width)
> +{
> +	u32 val;
> +
> +	val =3D  dw_pcie_readl_dbi(pci, PCIE_PORT_MULTI_LANE_CTRL);
> +	val &=3D ~(PORT_MLTI_LNK_WDTH_CHNG | PORT_MLTI_LNK_WDTH);
> +	val |=3D PORT_MLTI_LNK_WDTH_CHNG | lane_width;
> +	dw_pcie_writel_dbi(pci, PCIE_PORT_MULTI_LANE_CTRL, val);
> +}
> =20
>  void dw_pcie_upconfig_setup(struct dw_pcie *pci)
>  {
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/c=
ontroller/dwc/pcie-designware.h
> index 3beac10e4a4c..fcf0442341fd 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -67,6 +67,8 @@
>  #define PCIE_MSI_INTR0_STATUS		0x830
> =20
>  #define PCIE_PORT_MULTI_LANE_CTRL	0x8C0
> +#define PORT_MLTI_LNK_WDTH		GENMASK(5, 0)
> +#define PORT_MLTI_LNK_WDTH_CHNG		BIT(6)
>  #define PORT_MLTI_UPCFG_SUPPORT		BIT(7)
> =20
>  #define PCIE_ATU_VIEWPORT		0x900
> @@ -282,6 +284,7 @@ void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg,=
 size_t size, u32 val);
>  u32 dw_pcie_read_atu(struct dw_pcie *pci, u32 reg, size_t size);
>  void dw_pcie_write_atu(struct dw_pcie *pci, u32 reg, size_t size, u32 va=
l);
>  int dw_pcie_link_up(struct dw_pcie *pci);
> +void dw_pcie_link_width_resize(struct dw_pcie *pci, u32 lane_width);
>  void dw_pcie_upconfig_setup(struct dw_pcie *pci);
>  void dw_pcie_link_speed_change(struct dw_pcie *pci, bool enable);
>  void dw_pcie_link_set_n_fts(struct dw_pcie *pci, u32 n_fts);
> diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/con=
troller/dwc/pcie-intel-gw.c
> index 9142c70db808..b9be0921671d 100644
> --- a/drivers/pci/controller/dwc/pcie-intel-gw.c
> +++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
> @@ -146,6 +146,22 @@ static void intel_pcie_ltssm_disable(struct intel_pc=
ie_port *lpp)
>  	pcie_app_wr_mask(lpp, PCIE_APP_CCR_LTSSM_ENABLE, 0, PCIE_APP_CCR);
>  }
> =20
> +static const char *pcie_link_gen_to_str(int gen)
> +{
> +	switch (gen) {
> +	case PCIE_LINK_SPEED_GEN1:
> +		return "2.5";
> +	case PCIE_LINK_SPEED_GEN2:
> +		return "5.0";
> +	case PCIE_LINK_SPEED_GEN3:
> +		return "8.0";
> +	case PCIE_LINK_SPEED_GEN4:
> +		return "16.0";
> +	default:
> +		return "???";
> +	}
> +}
> +
>  static void intel_pcie_link_setup(struct intel_pcie_port *lpp)
>  {
>  	u32 val;
> @@ -444,6 +460,91 @@ static int intel_pcie_host_setup(struct intel_pcie_p=
ort *lpp)
>  	return ret;
>  }
> =20
> +static ssize_t pcie_link_status_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	struct intel_pcie_port *lpp =3D dev_get_drvdata(dev);
> +	u32 reg, width, gen;
> +
> +	reg =3D pcie_rc_cfg_rd(lpp, PCIE_CAP_OFST + PCI_EXP_LNKCTL);
> +	width =3D FIELD_GET(PCI_EXP_LNKSTA_NLW, reg >> 16);
> +	gen =3D FIELD_GET(PCI_EXP_LNKSTA_CLS, reg >> 16);
> +
> +	if (gen > lpp->max_speed)
> +		return -EINVAL;
> +
> +	return sprintf(buf, "Port %2u Width x%u Speed %s GT/s\n", lpp->id,
> +		       width, pcie_link_gen_to_str(gen));
> +}
> +static DEVICE_ATTR_RO(pcie_link_status);

Dilip please check pci.h there are there already enums and strings=20
relatively to PCIe speed and width, that you can use.

> +
> +static ssize_t pcie_speed_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t len)
> +{
> +	struct intel_pcie_port *lpp =3D dev_get_drvdata(dev);
> +	unsigned long val;
> +	int ret;
> +
> +	ret =3D kstrtoul(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val > lpp->max_speed)
> +		return -EINVAL;
> +
> +	lpp->link_gen =3D val;
> +	intel_pcie_max_speed_setup(lpp);
> +	dw_pcie_link_speed_change(&lpp->pci, false);
> +	dw_pcie_link_speed_change(&lpp->pci, true);
> +
> +	return len;
> +}
> +static DEVICE_ATTR_WO(pcie_speed);
> +
> +/*
> + * Link width change on the fly is not always successful.
> + * It also depends on the partner.
> + */
> +static ssize_t pcie_width_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t len)
> +{
> +	struct intel_pcie_port *lpp =3D dev_get_drvdata(dev);
> +	unsigned long val;
> +	int ret;
> +
> +	lpp =3D dev_get_drvdata(dev);
> +
> +	ret =3D kstrtoul(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val > lpp->max_width)
> +		return -EINVAL;
> +
> +	/* HW auto bandwidth negotiation must be enabled */
> +	pcie_rc_cfg_wr_mask(lpp, PCI_EXP_LNKCTL_HAWD, 0,
> +			    PCIE_CAP_OFST + PCI_EXP_LNKCTL);
> +	dw_pcie_link_width_resize(&lpp->pci, val);
> +
> +	return len;
> +}
> +static DEVICE_ATTR_WO(pcie_width);
> +
> +static struct attribute *pcie_cfg_attrs[] =3D {
> +	&dev_attr_pcie_link_status.attr,
> +	&dev_attr_pcie_speed.attr,
> +	&dev_attr_pcie_width.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(pcie_cfg);
> +
> +static int intel_pcie_sysfs_init(struct intel_pcie_port *lpp)
> +{
> +	return devm_device_add_groups(lpp->pci.dev, pcie_cfg_groups);
> +}
> +
>  static void __intel_pcie_remove(struct intel_pcie_port *lpp)
>  {
>  	intel_pcie_core_irq_disable(lpp);
> @@ -490,8 +591,17 @@ static int intel_pcie_rc_init(struct pcie_port *pp)
>  {
>  	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
>  	struct intel_pcie_port *lpp =3D dev_get_drvdata(pci->dev);
> +	int ret;
> =20
> -	return intel_pcie_host_setup(lpp);
> +	ret =3D intel_pcie_host_setup(lpp);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D intel_pcie_sysfs_init(lpp);
> +	if (ret)
> +		__intel_pcie_remove(lpp);
> +
> +	return ret;
>  }
> =20
>  int intel_pcie_msi_init(struct pcie_port *pp)
> --=20
> 2.11.0


