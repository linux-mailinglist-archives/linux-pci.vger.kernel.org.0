Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0789A1DA444
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 00:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgESWI7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 May 2020 18:08:59 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:48648 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725885AbgESWI6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 May 2020 18:08:58 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E7FC940194;
        Tue, 19 May 2020 22:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1589926138; bh=m+z07ONVnK8MGwl27NPR2ZWjdyunRHOszikxFnBMZMU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=amkzozrJ/8PGVBUn9EglN/RKHJ1qOH8gT/YIzxvt42HX3ABJ4bCxV9xbW5fQSI+VG
         LW+seJn6Lyhojw8/0IXDNgdTymBcHqEY4+ouivHFzLzoh7bMtxYjS+Yiuyx9kWfj/N
         KQ0+xcfMP0NX4/Sonw/RENph1OfIZngTkfv1JQZRkR0uIbaT5HdJaxO6RAxdVTylob
         j2MSVSU45MnW9RUl+sK6Cg+CKiWeYDf7R+Puvz5UiKchS6dDWjJ7wyO/YBuArX7LeY
         8Fxc1keeGW7ilGEhA1mVQg3B5Uag0fw2XT4tQsbgV0QBYyXbsadxHxnlPVRDp/5spl
         4ckXc1YEgwI3w==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id B984DA0069;
        Tue, 19 May 2020 22:08:56 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 19 May 2020 15:08:56 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Tue, 19 May 2020 15:08:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWorrI+l/qycldEMfUNkOdGPkhD49I2Bvz8SI74vKOX0SEMtHnohlBngLVMVUjL8I2o04ZrPI8X2duCc5qOfOaXJuE8ti7SbxM5GPjOYnq4VpVhYGuRSUP+9OC1O/l+RWAErImy11kFArQwQLciPQ+iYjDTTccTdjlS7uItZGB1mlOI6Vn6LvKeuWG0TauTNyz55SZgenZivij1q12Lo+YNv26Xwz9OMFQRq9OlIChHWTP0FEE7lq2b2kEaD7aufTwZj99s+/vDJQYyT07Dk1QT7khRde9GbIqqAMKzn6DOGx+sJfWXCNKOZSmVvwoRQJiZrc/z/fLM1ugDNHfQPhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lg1MZErjhnvY72qh56J3uGqyNbJnV09g/saZhRl8ChU=;
 b=ZhQCJUbqUvz1VfQzbwjhh07VIg+Sd8QhTh6gCAnDCx2fXtlv20obTsYnXyfUAVGIji3CQpOd2vS0r5XzQ742ZsLIMpgryHqLcm39W8X9dRiz31xxZ+qxggrj44E3+kiixdm6p1t+PwnslEO4jjTcAFQ5OfxweiQXcvqRRTSElQK0dwqpRzvl4/bgQegugmaXL4cv1VJ8UVcGDzrbbqVqdlqHSMOrgtGOpxnbSV+p+0lJ4p8EFZ/Zb7Mk7Y2nWAFSoZ1JimEL7yujgncZ/2ZP0Qq+OnMSF5yZmjYI6bma3gBMA2Ee15cC4DYzGgagp8P4BGEwzumhhwby483q+jDQwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lg1MZErjhnvY72qh56J3uGqyNbJnV09g/saZhRl8ChU=;
 b=oOty5TVPISdsfyg0fmMmYr6gba1pZA8sWat3Cb8TP9wk+F1AQIPKEKurEin3p8fUhNDi8DGGZb1Wl1/ZAnc94b9lrw1d4v7iX/qHbI54C5YD0VtEHLZ59Tktz8pi20LIUmMl8cCxeJ7BiTBisJ2jpdhzQqrIcGpkl6bZMpdNlGI=
Received: from DM5PR12MB1276.namprd12.prod.outlook.com (2603:10b6:3:79::18) by
 DM5PR12MB2567.namprd12.prod.outlook.com (2603:10b6:4:b2::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.27; Tue, 19 May 2020 22:08:54 +0000
Received: from DM5PR12MB1276.namprd12.prod.outlook.com
 ([fe80::2062:f350:1cd1:1023]) by DM5PR12MB1276.namprd12.prod.outlook.com
 ([fe80::2062:f350:1cd1:1023%12]) with mapi id 15.20.3021.020; Tue, 19 May
 2020 22:08:54 +0000
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vidya Sagar <vidyas@nvidia.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>,
        "Alan Mikhak" <alan.mikhak@sifive.com>
Subject: RE: [PATCH] PCI: dwc: Warn only for non-prefetchable memory resource
 size >4GB
Thread-Topic: [PATCH] PCI: dwc: Warn only for non-prefetchable memory resource
 size >4GB
Thread-Index: AQHWKVoGJtzjEG2zZkS3sMjotsveRaimms4AgAdrv4CAAXDuAIAAEaoAgABluSA=
Date:   Tue, 19 May 2020 22:08:54 +0000
Message-ID: <DM5PR12MB1276C836FEE46B113112FA92DAB90@DM5PR12MB1276.namprd12.prod.outlook.com>
References: <20200513190855.23318-1-vidyas@nvidia.com>
 <20200513223508.GA352288@bjorn-Precision-5520>
 <20200518155435.GA2299@e121166-lin.cambridge.arm.com>
 <cd62a9da-5c47-ceb2-10e7-4cf657f07801@nvidia.com>
 <20200519145816.GB21261@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200519145816.GB21261@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTUxNmNlOTY3LTlhMWQtMTFlYS05OGI1LWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFw1MTZjZTk2OC05YTFkLTExZWEtOThiNS1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjUyMTkiIHQ9IjEzMjM0Mzk5NzMxODQ0?=
 =?us-ascii?Q?MzQzMiIgaD0iR0g4U0VnM1hpeE5XcnR0QlhDSzF6R250R1VzPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFD?=
 =?us-ascii?Q?b01WSVVLaTdXQVg0bnVBWVo4cGhKZmllNEJobnltRWtPQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUhBQUFBQ2tDQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQVFBQkFBQUFFbU1la3dBQUFBQUFBQUFBQUFBQUFKNEFBQUJtQUdrQWJn?=
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
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [89.155.7.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22ec244a-6a2e-46e3-55a8-08d7fc413867
x-ms-traffictypediagnostic: DM5PR12MB2567:
x-microsoft-antispam-prvs: <DM5PR12MB2567031024C5DC3BE185E972DAB90@DM5PR12MB2567.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 040866B734
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uYQj50qHSdszRLkUcgg1OmWJIFskBv0/UTJMrCLvXRIGQ+f/Z6tMx7EAYQBHEkLe7LKb3FpdWSeUTxaTlduKOS4DDR0tWphIb3NaefDiuCYyrsGgclAAXyHTUXIG+V36MgTP6Nq5Ku2Rhwb8GixmNDrtUQZpxxmKwZt3XD18GjI4iNpb7TmpPWqzDo84o5tvsOEh/mBn/sPo34X4HB5SO14CMxBldjP3R2+3pOG2eMbHjcyHgLbn2tEpB8BFzw9FjCbxJCyqCsuqnMshtxPiv8XpTqmhBUkTMx1d+tAH11oY50yLa3yE8tkFQrj9JMpfjVH2nlkfsuxzvEwn+l36jhkrFRsYCXxneMc77Fotie5XpkvwLR1Dxt7QhmgYp/HJMGNQdYxiIk1b491oUkDIUW1kQniP4MAbNLEp+bABdxtpHlaJh0F9bDofx9jD6lhM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1276.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(366004)(346002)(39860400002)(376002)(396003)(66946007)(8936002)(55016002)(478600001)(9686003)(33656002)(6506007)(7696005)(53546011)(86362001)(52536014)(316002)(54906003)(26005)(4326008)(5660300002)(8676002)(66476007)(66556008)(76116006)(71200400001)(7416002)(66446008)(64756008)(110136005)(186003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: uuQ0op2CUoZ7q+SeOyvd34Z23nMse04+P4FdMC0gxIBMT1yjzGZnioIuV2muHd8GJ1SNETavwcnguNoLxLV6PaxrZj5wiwkQYa80/EBcEeGP6EVrpJXP5zxdSw+Z/GcEt6qK2pzzyllRX+wwGf9xCaOMjCOqXFOBDk4L0N+PQTyyXizKSjh3XWU7uKHOCJ+QHt+X/RMVDIz+C994w26irykGYVxaulb+6I88lx0Vrqnquhv5Tln2um7ui2mTGVwUrdtMWJXh0Q8B19DL5WwVeUqsbzz3yPXayLyDerN+cWEM0HGQATUzj/1/DQtoXEW49NTTv6mwrnGwYMjvrfRiHhSGlGYAydoHZ8kSdKuNK+kQVHFFRIKKDgzu+gU5dV+3joVMrGGIpzJC+LbX9MkivHxepU2GAMYxvfF9w8tzXkiILN/H1eYSrF5zWhrieFcwyOjQO1zsWcskSduCTODOzKwGdLbb0n0JwSwEeZqyLlA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ec244a-6a2e-46e3-55a8-08d7fc413867
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2020 22:08:54.3795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uB9FLn519ueZKnVESuKuQwtUnXYR2M2LU36Wyk5gYqcPzO0qowtqxnWtDGoZ/OsnsMcdxyzjle16xooGSfkh1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2567
X-OriginatorOrg: synopsys.com
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 19, 2020 at 15:58:16, Lorenzo Pieralisi=20
<lorenzo.pieralisi@arm.com> wrote:

> On Tue, May 19, 2020 at 07:25:02PM +0530, Vidya Sagar wrote:
> >=20
> >=20
> > On 18-May-20 9:24 PM, Lorenzo Pieralisi wrote:
> > > External email: Use caution opening links or attachments
> > >=20
> > >=20
> > > On Wed, May 13, 2020 at 05:35:08PM -0500, Bjorn Helgaas wrote:
> > > > [+cc Alan; please cc authors of relevant commits,
> > > > updated Andrew's email address]
> > > >=20
> > > > On Thu, May 14, 2020 at 12:38:55AM +0530, Vidya Sagar wrote:
> > > > > commit 9e73fa02aa009 ("PCI: dwc: Warn if MEM resource size exceed=
s max for
> > > > > 32-bits") enables warning for MEM resources of size >4GB but pref=
etchable
> > > > >   memory resources also come under this category where sizes can =
go beyond
> > > > > 4GB. Avoid logging a warning for prefetchable memory resources.
> > > > >=20
> > > > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > > > ---
> > > > >   drivers/pci/controller/dwc/pcie-designware-host.c | 3 ++-
> > > > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/=
drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > index 42fbfe2a1b8f..a29396529ea4 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > @@ -366,7 +366,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
> > > > >                      pp->mem =3D win->res;
> > > > >                      pp->mem->name =3D "MEM";
> > > > >                      mem_size =3D resource_size(pp->mem);
> > > > > -                   if (upper_32_bits(mem_size))
> > > > > +                   if (upper_32_bits(mem_size) &&
> > > > > +                       !(win->res->flags & IORESOURCE_PREFETCH))
> > > > >                              dev_warn(dev, "MEM resource size exc=
eeds max for 32 bits\n");
> > > > >                      pp->mem_size =3D mem_size;
> > > > >                      pp->mem_bus_addr =3D pp->mem->start - win->o=
ffset;
> > >=20
> > > That warning was added for a reason - why should not we log legitimat=
e
> > > warnings ? AFAIU having resources larger than 4GB can lead to undefin=
ed
> > > behaviour given the current ATU programming API.
> > Yeah. I'm all for a warning if the size is larger than 4GB in case of
> > non-prefetchable window as one of the ATU outbound translation
> > channels is being used,
>=20
> Is it true for all DWC host controllers ? Or there may be another
> exception whereby we would be forced to disable this warning altogether
> ?
>=20
> > but, we are not employing any ATU outbound translation channel for
>=20
> What does this mean ? "we are not employing any ATU outbound...", is
> this the tegra driver ? And what guarantees that this warning is not
> legitimate on DWC host controllers that do use the ATU outbound
> translation for prefetchable windows ?
>=20
> Can DWC maintainers chime in and clarify please ?

Before this code section, there is the following function call=20
pci_parse_request_of_pci_ranges(), which performs a simple validation for=20
the IORESOURCE_MEM resource type.
This validation checks if the resource is marked as prefetchable, if so,=20
an error message "non-prefetchable memory resource required" is given and=20
a return code with the -EINVAL value.

In other words, to reach the code that Vidya is changing, it can be only=20
if the resource is a non-prefetchable, any prefetchable resource will be=20
blocked by the previous call, if I'm not mistaken.

Having this in mind, Vidya's change will not make the expected result=20
aimed by him.

I don't see any problem by having resources larger than 4GB, from what=20
I'm seeing in the databook there isn't any restricting related to that as=20
long they don't consume the maximum space that is addressable by the=20
system (depending on if they are 32-bit or 64-bit system address).

To be honest, I'm not seeing a system that could have this resource=20
larger than 4GB, but it might exist some exception that I don't know of,=20
that's why I accepted Alan's patch to warn the user that the resource=20
exceeds the maximum for the 32 bits so that he can be aware that he=20
*might* be consuming the maximum space addressable.

-Gustavo

>=20
> > prefetchable window and they can be greater than 4GB in size for all
> > right reasons. So, logging a warning for prefetchable region doesn't
> > seem correct to me. Please let me know if my understanding is wrong.
>=20
> I think your patch is wrong and it is applied on top of a patch that
> is wrong too, so I won't apply yours and it is likely I will revert
> Alan's because it seems to solve nothing (and warn spuriously).
>=20
> It is time for people who maintain DWC please to speak up because I
> don't have the HW details required to make a judgment.
>=20
> Lorenzo
>=20
> > - Vidya Sagar
> > >=20
> > > Alan ? I want to understand what's the best course of action before
> > > merging these patches.
> > >=20
> > > Lorenzo
> > >=20


