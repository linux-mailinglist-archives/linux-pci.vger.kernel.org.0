Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2FED6E271
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2019 10:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfGSI0X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Jul 2019 04:26:23 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:43596 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727007AbfGSI0W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jul 2019 04:26:22 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CBA86C0AE6;
        Fri, 19 Jul 2019 08:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1563524782; bh=Sf8eQZVf7xi3zpRszdsCx9Lmg4aK0Fhb8Yw4BEOjn3Y=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=GWa1wLZTLm12vkL/tn6UU4v+KHylzoPCAt9EpoCq6NCWBX1mR6nBRqzlgZAgYJxtD
         iVoQ8U2tYOCRjQS7eUGHCIMm+r2d01JFq4X1xm9seJgnwhzfwN2tcZ0eoVLaGb/A55
         4dhOb0d6ueJkYOkH4ghztc4C9aADoO7NnsmdFRJX4/hIcQ00YJHGmqdOReP3Wy9iZ7
         pQeCSwUhHiAWwKjJncuQo4k6eNFQpM/QWqJRRWPXAa5m1gh6mRvrzFMcF/bS2kodqm
         RPgXqXAGFshhCNLzHGX+/ihYB0C7nnAN7oePFJKyeMAH9hJbvv66L+OSqTVKAxOpla
         dDX7Uzq49AypQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 5DC68A0091;
        Fri, 19 Jul 2019 08:26:20 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 19 Jul 2019 01:25:55 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 19 Jul 2019 01:25:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oa3Jxg9+JbQCS8NnwHq/j2fnHVWshSnIgrCRbLNoNb6L2037e6+WIPEigAONGQaafz+iq0/7wRNhHXzuzpmZvihSULL3+sGffopcLLnJaDUto9XJRcWjh3g1IWBwlGzGF/amFa8Zqx0LZ7x7NpUkTMIO3cGR1fDeavswUyjHmPMW5J7+ieT19kovTRoYkrrNldRvnhFru6TCbm82Ytoy59du7b9kFDCSLxJ6+G7JoM/Gz6XQb3yc8BSGFYoUuO986yjKt9i4ADKzUKFLBh00/kqg/4AM8+pZlh3vxp5ACo6nSZ7zh7QEMXzNtDhrksmQ9ybq/u2d5PkK2UY/Bq4AUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MohgqyeHANcijeuDdUqtYBwprZliMDAF6WXblIuqraU=;
 b=aoDlVXVkjx/dSgC1Btw4cNJbyJbCF6nABGSCzmp09wy5mhKrLInHPyF1Y/6ZhfqsjVvrIisH3cZmMGG3yuqesaxxUWLJrSbgyi/nj3lhyC02ZWagcu2g7M2MQizoxtJLLluGw8ChgTeBd3VFA/vhsZWBQtcJfYJ8XC8IP6mX5hjG2CWFvQcygDQcdwg9nI02NDOnRMpi6sS4eNw2hpoLVNSynQu01SkOnCY6/4yYRK0lLnHtHbrm7Kw0dLceTF+8IFZxg/nHBWDBZB8vsFi0lZIvjQrnF5dN7eFA6CsB7QFoQj9lsq6zaLCZCRsFEJC45zK1ZNFs8EbPmZ4o5EZndw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=synopsys.com;dmarc=pass action=none
 header.from=synopsys.com;dkim=pass header.d=synopsys.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MohgqyeHANcijeuDdUqtYBwprZliMDAF6WXblIuqraU=;
 b=EnQ7SI5rqQWoQhQxT2ZyhgWTrvAxMMGSiGfiWayhzaZdcFrJO+XdayG0N7U7ErnCwh7lpU+fTgIzaGEztDL/zLIusfrhvC3YThRFk4P0m/qdfFgQeAuXhBnipyUHW4HRxE0KMPTbLEeS0KRdGX9C7zXDbsf1g2bsevulsF1hSLM=
Received: from DM6PR12MB4010.namprd12.prod.outlook.com (10.255.175.83) by
 DM6PR12MB3690.namprd12.prod.outlook.com (10.255.76.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Fri, 19 Jul 2019 08:25:53 +0000
Received: from DM6PR12MB4010.namprd12.prod.outlook.com
 ([fe80::2dc8:6bc4:3d9d:9203]) by DM6PR12MB4010.namprd12.prod.outlook.com
 ([fe80::2dc8:6bc4:3d9d:9203%4]) with mapi id 15.20.2073.012; Fri, 19 Jul 2019
 08:25:53 +0000
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
Subject: RE: [PATCH v2 2/8] PCI: Add ACS quirk for Amazon Annapurna Labs root
 ports
Thread-Topic: [PATCH v2 2/8] PCI: Add ACS quirk for Amazon Annapurna Labs root
 ports
Thread-Index: AQHVPU3Y2R7KTbmymkShpQNWiD85vKbRnGaQ
Date:   Fri, 19 Jul 2019 08:25:52 +0000
Message-ID: <DM6PR12MB40103BEB4F4050FBBDCD7C95DACB0@DM6PR12MB4010.namprd12.prod.outlook.com>
References: <20190718094531.21423-1-jonnyc@amazon.com>
 <20190718094531.21423-3-jonnyc@amazon.com>
In-Reply-To: <20190718094531.21423-3-jonnyc@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLWQwOWU2OTk1LWE5ZmUtMTFlOS05ODhjLWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFxkMDllNjk5Ny1hOWZlLTExZTktOTg4Yy1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjIyMjkiIHQ9IjEzMjA3OTk4MzUwODQ5?=
 =?us-ascii?Q?Njg3NSIgaD0idEdZL3owNjVkNGdLZ0xQZCs5ZVdCdDdiK0FvPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFE?=
 =?us-ascii?Q?cm9mYVNDejdWQWZjTU5PS0RkWk1WOXd3MDRvTjFreFVPQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: c4305cb5-d4ff-4c18-dac9-08d70c22b6bc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR12MB3690;
x-ms-traffictypediagnostic: DM6PR12MB3690:
x-microsoft-antispam-prvs: <DM6PR12MB3690DB91F6B47B6678AE638EDACB0@DM6PR12MB3690.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01039C93E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(136003)(366004)(47630400002)(199004)(189003)(102836004)(66476007)(229853002)(66556008)(2501003)(64756008)(66946007)(476003)(66446008)(11346002)(53546011)(71190400001)(71200400001)(26005)(52536014)(256004)(54906003)(81156014)(7736002)(110136005)(76116006)(6506007)(86362001)(186003)(316002)(14444005)(446003)(81166006)(76176011)(8936002)(5660300002)(4326008)(2906002)(25786009)(14454004)(99286004)(478600001)(305945005)(74316002)(7696005)(3846002)(33656002)(55016002)(6116002)(8676002)(7416002)(9686003)(53936002)(6246003)(486006)(68736007)(2201001)(66066001)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR12MB3690;H:DM6PR12MB4010.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GVeSJIdB4iBjHEGifrz6c5kY4OTrnGLJW9ToJomxU1/EPNKKlfNj6NO1chzSj4PG6qVaMWVzzfFejS266c+SmMOiCBe7lqrft8YxPdAqnxBc1ATgaGuPLxdKLJqNIO7amJw3IA9rEZ5qLJXuj9sj0KVNVH1UckGLcmnyC6roSELO9MkjDxYgEQuVPWBtcLVRrte67KB7vbRj/wOHsMq5ecI5cbBMCJf5KwzpVteeP/qPowXcGQhh33QiajNWLawNciiADix6z2lTeRntnCbX4jMy401GOg2ef+5X8v6zCC3I9ujBUn7jO5cNX3GPdbjZD//xpo2HrOqnEWCZMlIPsollX2IDVNyR35tyPjm23xZ21ZAsl7jBj/JN+pYmTjpH6Zxst52FThL7PRBlv19toK4uF9CVCjK7A5c66W9+ifA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c4305cb5-d4ff-4c18-dac9-08d70c22b6bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2019 08:25:52.8557
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

On Thu, Jul 18, 2019 at 10:45:25, Jonathan Chocron <jonnyc@amazon.com>=20
wrote:

> From: Ali Saidi <alisaidi@amazon.com>
>=20
> The Amazon's Annapurna Labs root ports don't advertise an ACS
> capability, but they don't allow peer-to-peer transactions and do
> validate bus numbers through the SMMU. Additionally, it's not possible
> for one RP to pass traffic to another RP.
>=20
> Signed-off-by: Ali Saidi <alisaidi@amazon.com>
> Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
> ---
>  drivers/pci/quirks.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 208aacf39329..23672680dba7 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4366,6 +4366,23 @@ static int pci_quirk_qcom_rp_acs(struct pci_dev *d=
ev, u16 acs_flags)
>  	return ret;
>  }
> =20
> +static int pci_quirk_al_acs(struct pci_dev *dev, u16 acs_flags)
> +{
> +	/*
> +	 * Amazon's Annapurna Labs root ports don't include an ACS capability,
> +	 * but do include ACS-like functionality. The hardware doesn't support
> +	 * peer-to-peer transactions via the root port and each has a unique
> +	 * segment number.
> +	 * Additionally, the root ports cannot send traffic to each other.
> +	 */
> +	acs_flags &=3D ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_SV | PCI_ACS_UF);
> +
> +	if (pci_pcie_type(dev) !=3D PCI_EXP_TYPE_ROOT_PORT)
> +		return -ENOTTY;
> +
> +	return acs_flags ? 0 : 1;
> +}
> +
>  /*
>   * Sunrise Point PCH root ports implement ACS, but unfortunately as show=
n in
>   * the datasheet (Intel 100 Series Chipset Family PCH Datasheet, Vol. 2,
> @@ -4559,6 +4576,8 @@ static const struct pci_dev_acs_enabled {
>  	{ PCI_VENDOR_ID_AMPERE, 0xE00A, pci_quirk_xgene_acs },
>  	{ PCI_VENDOR_ID_AMPERE, 0xE00B, pci_quirk_xgene_acs },
>  	{ PCI_VENDOR_ID_AMPERE, 0xE00C, pci_quirk_xgene_acs },
> +	/* Amazon Annapurna Labs */
> +	{ PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031, pci_quirk_al_acs },
>  	{ 0 }
>  };
> =20
> --=20
> 2.17.1

Seems ok.

Reviewed-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>


