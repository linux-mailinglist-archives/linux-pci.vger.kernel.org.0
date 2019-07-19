Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD7216E338
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2019 11:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbfGSJPa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Jul 2019 05:15:30 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:56456 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725794AbfGSJPa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jul 2019 05:15:30 -0400
Received: from mailhost.synopsys.com (dc8-mailhost2.synopsys.com [10.13.135.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 52AA6C1C29;
        Fri, 19 Jul 2019 09:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1563527729; bh=glP5uP2ggifjoKelpQdu/6mj220AVeBpAfQ/z5KcnYI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=MRl26UQeyzPtLrWOYHlc9rnAxMnez03wKUO6UpCKxbaR9H+SbGNHFYigo2475DeP6
         fi9lySdI49vibKKGmHtNZpPgr5DAxtw/LhosZsYj3CGc8j6kNQ6zQgwHmbpj2+r8up
         18kNp8KW+t2tVFxLu+k7U+ixcPDCFy5tCZoyr6BemjcF0Ct5eK6qLO77nfXrvqaUOm
         A9siCu5Y2qUTVs/XiPcn2cvhKLpiNUpVPHTe2Xbt1Nu2Co7KiyuryIKVZ6ZXNlQbui
         xKqN8ijMQJwOQ8U+ry8DKPaR0O8uPyzIm7WbUDF879XB1bUSxqTgUNmz5ryWKp+cNT
         eodg+3n7YM6rw==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 304DCA0067;
        Fri, 19 Jul 2019 09:15:29 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 19 Jul 2019 02:15:18 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 19 Jul 2019 02:15:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRZEiifqO5wGHhLb9uXftbzxROZL/VEUdKlJZYA+SDEZz6EDnUIehqekZLgkntV/lTfhygknk5myuYaAVroUOMggdrCYSaFFgE/Dy0QleHJ1I47HJD1p246spIUImjDD9bjPUSPde/Up5PUV87MmdqkMRnKP18z1pb9wy2o9r9i249wE0uEq6zNF/Dar954R+VLpMD+Ef5Rb3Yc5hpwM+90Z6hXW/yNnnx/zuliFMFRA0hhkrIkMPxDGuu1i0tkqhvpony+XIaOed1NLYZdyLouBYtUuxHteZbYR2QVmSJW7iCLzFDcLnINPstEUrckkZ7EhXu+XqxpaRkwQKVFgfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8jwzaU9i6tupe+Lp8qj48r9inQNcL9+O1vvYWu++L4=;
 b=VVqjvn1M0vr0TiRN75tZaJbWT5ELGkP8+wfrM3A9P4z5cePM8LfdZb86+CGQ3DzLgnyEYWMukTZMhXojHcYyRd3r6WKJgckroYsJAmOYnCoU9+aDBHoIh6kzn7Sr7CtTaOQMwZ18gpL1m6v31Bdqf7B7idF1uZvY9Iy7Y9Fph97mNeslJ/Pylmy+JAvNGcrqzyRtMsLwF1maIVdRF6je1EEK4OVUVWhborR/KRJlN2IN3wtZfqoNCwF+7i9TrTbxpPbUqess9zdEU/13QBDsMNMKIkuO1B9zTP4JzswTRMfhqmQhDijQZeoBhiDnOTC15eVAQfCuKfWJnxzGxbkvpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=synopsys.com;dmarc=pass action=none
 header.from=synopsys.com;dkim=pass header.d=synopsys.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8jwzaU9i6tupe+Lp8qj48r9inQNcL9+O1vvYWu++L4=;
 b=uaTHgBtDcVR1EbzMM7675CkHBM7hYY1id3uEo3O/eUcYIC+PdrGyT6REwCNwEK52ZRfhA3+YpNxWuauqtY9n2Tl4K23R+wDPJSZM3ksd0ZL1QM8RCY3ZLz5fevE1zRGhAxRRqkCHzExeDsz5Ng5KV+0psQ1yCSZz8i5C33DL5nk=
Received: from DM6PR12MB4010.namprd12.prod.outlook.com (10.255.175.83) by
 DM6PR12MB3515.namprd12.prod.outlook.com (20.179.106.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.14; Fri, 19 Jul 2019 09:15:16 +0000
Received: from DM6PR12MB4010.namprd12.prod.outlook.com
 ([fe80::2dc8:6bc4:3d9d:9203]) by DM6PR12MB4010.namprd12.prod.outlook.com
 ([fe80::2dc8:6bc4:3d9d:9203%4]) with mapi id 15.20.2073.012; Fri, 19 Jul 2019
 09:15:16 +0000
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
Subject: RE: [PATCH v2 7/8] PCI: dw: Add validation that PCIe core is set to
 correct mode
Thread-Topic: [PATCH v2 7/8] PCI: dw: Add validation that PCIe core is set to
 correct mode
Thread-Index: AQHVPU4E178VJy6TjkK4KITScO7kRKbRqjIw
Date:   Fri, 19 Jul 2019 09:15:16 +0000
Message-ID: <DM6PR12MB40105D55ECC90DB9A1DF783DDACB0@DM6PR12MB4010.namprd12.prod.outlook.com>
References: <20190718094531.21423-1-jonnyc@amazon.com>
 <20190718094718.25083-3-jonnyc@amazon.com>
In-Reply-To: <20190718094718.25083-3-jonnyc@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLWI2YWJmOTUxLWFhMDUtMTFlOS05ODhjLWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFxiNmFiZjk1My1hYTA1LTExZTktOTg4Yy1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjI3MTUiIHQ9IjEzMjA4MDAxMzEzNzkx?=
 =?us-ascii?Q?NzAzNSIgaD0iVU0yS1pGVmptQWt2d1Y2MndBUEtqYkxSOU9VPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFC?=
 =?us-ascii?Q?cnRBTjVFajdWQVlOTUE1bFJNdlp2ZzB3RG1WRXk5bThPQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: 47f37403-430c-406e-dc91-08d70c299d5b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM6PR12MB3515;
x-ms-traffictypediagnostic: DM6PR12MB3515:
x-microsoft-antispam-prvs: <DM6PR12MB3515DC1FE6241E73246107A1DACB0@DM6PR12MB3515.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01039C93E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(396003)(366004)(39860400002)(189003)(199004)(478600001)(14454004)(7696005)(76176011)(66946007)(229853002)(66476007)(66556008)(64756008)(99286004)(476003)(76116006)(5660300002)(25786009)(14444005)(256004)(7736002)(2501003)(66446008)(102836004)(186003)(33656002)(74316002)(8936002)(305945005)(81156014)(26005)(81166006)(446003)(66066001)(486006)(4326008)(11346002)(53546011)(6506007)(2201001)(7416002)(52536014)(9686003)(54906003)(110136005)(86362001)(6436002)(6116002)(8676002)(3846002)(316002)(68736007)(53936002)(2906002)(6246003)(55016002)(71190400001)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR12MB3515;H:DM6PR12MB4010.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 27E25VmXnMkFqWX1Wqd3sEZfJcax1Io+KsnHYqMhLbmO7ipKLdFNXC4itn0B1+hqv921OdEGZULxA53aGqluvyZjifncaqTaJZaOtXcctdqfBKpTpKs1bgyvSNqf17Tg1GU91Hd174tq1da1WqwAATj+3Q5dDkloe9E1ZruQaHTaeKe62nEIY4EqYBuXBv7yATn/sY2Nn44fKMPczP0qaNuqyl6YwSMfb19/F9cp4XC9wzkqbBO9cxF5FmWfh4d9E8rlpgZhl2v/XWqWrKlXhw2eBKGXoI0Le6urky6HgEQISHBk7SlHDGxj43vPjpJhaZRr7GdV2WHlnMEoJ+wfmpKpH4ZSrfF6AQOCzfRD+iuZWqITSifzrm6VAZvtNoylFYxEneEfW3rMNAI6df3pJDv8zbQdA6bo6zEwmQK6IcY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f37403-430c-406e-dc91-08d70c299d5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2019 09:15:16.7761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gustavo@synopsys.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3515
X-OriginatorOrg: synopsys.com
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 18, 2019 at 10:47:17, Jonathan Chocron <jonnyc@amazon.com>=20
wrote:

> Some PCIe controllers can be set to either Host or EP according to some
> early boot FW. To make sure there is no discrepancy (e.g. FW configured
> the port to EP mode while the DT specifies it as a host bridge or vice
> versa), a check has been added for each mode.
>=20
> Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c   | 8 ++++++++
>  drivers/pci/controller/dwc/pcie-designware-host.c | 8 ++++++++
>  2 files changed, 16 insertions(+)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pc=
i/controller/dwc/pcie-designware-ep.c
> index 2bf5a35c0570..00e59a134b93 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -531,6 +531,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  	int ret;
>  	u32 reg;
>  	void *addr;
> +	u8 hdr_type;
>  	unsigned int nbars;
>  	unsigned int offset;
>  	struct pci_epc *epc;
> @@ -543,6 +544,13 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  		return -EINVAL;
>  	}
> =20
> +	hdr_type =3D dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE);
> +	if (hdr_type !=3D PCI_HEADER_TYPE_NORMAL) {
> +		dev_err(pci->dev, "PCIe controller is not set to EP mode (hdr_type:0x%=
x)!\n",
> +			hdr_type);
> +		return -EIO;
> +	}
> +
>  	ret =3D of_property_read_u32(np, "num-ib-windows", &ep->num_ib_windows)=
;
>  	if (ret < 0) {
>  		dev_err(dev, "Unable to read *num-ib-windows* property\n");
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/=
pci/controller/dwc/pcie-designware-host.c
> index f93252d0da5b..d2ca748e4c85 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -323,6 +323,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	struct pci_bus *child;
>  	struct pci_host_bridge *bridge;
>  	struct resource *cfg_res;
> +	u8 hdr_type;
>  	int ret;
> =20
>  	raw_spin_lock_init(&pci->pp.lock);
> @@ -396,6 +397,13 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  		}
>  	}
> =20
> +	hdr_type =3D dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE);
> +	if (hdr_type !=3D PCI_HEADER_TYPE_BRIDGE) {
> +		dev_err(pci->dev, "PCIe controller is not set to bridge type (hdr_type=
: 0x%x)!\n",
> +			hdr_type);
> +		return -EIO;
> +	}
> +
>  	pp->mem_base =3D pp->mem->start;
> =20
>  	if (!pp->va_cfg0_base) {
> --=20
> 2.17.1

It doesn't harm.
Thanks.

Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>


