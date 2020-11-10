Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C442ADE2A
	for <lists+linux-pci@lfdr.de>; Tue, 10 Nov 2020 19:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgKJSXU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Nov 2020 13:23:20 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:48138 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726307AbgKJSXU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Nov 2020 13:23:20 -0500
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0412CC00A7;
        Tue, 10 Nov 2020 18:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1605032599; bh=0sB/nYtFX6rFQDA95JuKo/3VlLGwZcrZpfZll8DCzQo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=PcwIcdMvJclbXznCEZlZ71rdAzYo6AiseDzYCo/7OtPZ82z77Npdov6IEILLbTfhl
         0pzYA9AIneqylFrcRawF5pPMk/IK4HdbpZjAgg2z6tDCkLGRgFF8hlxRVbHGIJKTfw
         yDkc0WMdw3JA8T/IdaPuc5lyaFUiMJ46+SJX+f2OyxM+H5BvgajcFXoOnw/w1tKJoO
         gr5bThOnVK16AOzP3ns/pW2S6tXlYvGtFTUZmrg1yRYCT8+Q4hKVEtlwb6ZC6frzcs
         ctisMkZDy27qK3ic18uAZhmgjrB3S0sPJHpshp2ObBlxCNY881D+dGKYceknE3yiFp
         xjL7cOP6sT5yw==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id A1BB2A0084;
        Tue, 10 Nov 2020 18:23:16 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2053.outbound.protection.outlook.com [104.47.37.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 465EA80256;
        Tue, 10 Nov 2020 18:23:16 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=gustavo@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="C6mZdmB+";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z51ZTSxrVxpmVHujK5vqkdbm3mXr+k/vDUw6Ux4cR5b4GziQBnpvtD4N2xxc+vuAJSJsbdXlAeXla7f/KvbjZJDrdwn9p/s3/4NiPHVmRZi5npWP3mzNvPTJyfgGx9AkLMjUYc4f7FOEJkNArMRfJGqwQOXuUYIl80rMQY1z8oNbV1dG2BV+ns6t6Op4i5hLOHWMiMVSzE3GqgjRDklD5XInO91iRvv4Qn64e6DP2BR2VdgFxTd8jKZ6jkEHnGBeAwPSQrRoPLoWvDne621a7mXfBCGZplk0cOm5g4jldEH6tURWRaNmZpwaqlAUlyt7ybnNthpoBvFlDt/d1bHcbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+mBGlBPPpplnmXu3UbzvUIL3sa3R6U8qaleB/Di3EU=;
 b=k/bxIOA55mmc/N2odULzLD0aY815y23SZKVcARjbZiGQLXmrcYrTBy2PIUDDDjkQzgKbLJ9Zcbnq4Lkk07JdjRBd0/z44hxjR39B8nne8bWYM3dwDJU0bRH9obZctuzRaF+NxYLkMHmsa1yq3uzPuD3CLdHYCorn+Cg0jCxMdZPUtC2JKj3OeR+mXNHsGfc1v0TMWHxY1BLLp6iDrpHiX10o66XkwUfPzpBviE7yjtBfeNwQBcGtaLV/o9uzz3QJ97mzt+1qsyCQPaekYZreajeW5gsvD2JtObRp/m7sFtqNq+rhA+t0i7fO4BN3v3m8uA3KmWT2QR/kLjo+V5+p1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+mBGlBPPpplnmXu3UbzvUIL3sa3R6U8qaleB/Di3EU=;
 b=C6mZdmB+lPEP1x3PUnOBRQvrvKr4ErTEXVdBaZLju0mBnIX5IblWUVRyrLautYokZFg4yaugiq+ylkdN9XaDWghMkn4hBkiT59R0/j3jHsT/TcUiaE6BW9YylBa20CguFDjz3LpqluKwqWpRI4q4QgroTsLpALBBnXltL41ecY0=
Received: from DM5PR12MB1835.namprd12.prod.outlook.com (2603:10b6:3:10c::9) by
 DM6PR12MB4699.namprd12.prod.outlook.com (2603:10b6:5:36::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.24; Tue, 10 Nov 2020 18:23:13 +0000
Received: from DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::48e2:11e1:d2f:d12f]) by DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::48e2:11e1:d2f:d12f%8]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 18:23:13 +0000
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH 1/5] misc: Add Synopsys DesignWare xData IP driver
Thread-Topic: [PATCH 1/5] misc: Add Synopsys DesignWare xData IP driver
Thread-Index: AQHWriel+eqJsOA+OU+SbQ480k3k0qnAH+gAgAFbN0CAADbSgIAABN0Q
Date:   Tue, 10 Nov 2020 18:23:12 +0000
Message-ID: <DM5PR12MB18358312F9C5246A0662E329DAE90@DM5PR12MB1835.namprd12.prod.outlook.com>
References: <cover.1603998630.git.gustavo.pimentel@synopsys.com>
 <f60c0cbb87bd1505669bf0cf62c56cbaa8d4c1d2.1603998630.git.gustavo.pimentel@synopsys.com>
 <20201109173108.GA2371851@kroah.com>
 <DM5PR12MB183554F4B1DF1AEA157401BFDAE90@DM5PR12MB1835.namprd12.prod.outlook.com>
 <X6rOHaF6dT9VWLJl@kroah.com>
In-Reply-To: <X6rOHaF6dT9VWLJl@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLWM4OTEyNTA1LTIzODEtMTFlYi05OGQ2LWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFxjODkxMjUwNi0yMzgxLTExZWItOThkNi1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjgyMDIiIHQ9IjEzMjQ5NTA2MTkxMDU0?=
 =?us-ascii?Q?NTQwOSIgaD0icWxpWnhLZno5bCtEMDZsV2VWSWczS3RmUERzPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFB?=
 =?us-ascii?Q?QjVLdUxqcmZXQWNLMUZlMEJzRnpBd3JVVjdRR3dYTUFPQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: ff4f7c87-7648-449f-09d3-08d885a5af51
x-ms-traffictypediagnostic: DM6PR12MB4699:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4699E529C2EE681B487D5594DAE90@DM6PR12MB4699.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BG6wRbzTYXAdloBLo///rhjLTqF5HFkHonBxRmpNHi1jnUFo8PJ1W4VQfBNsjkCqG+Sbs2D58gs1gSlHQP2Waf6DXcJRMCuuKujPyALBGGueJ5rn+BI8FJHiPZUgI7Yd7EDzobnEFuP2VKW/8CdLTrW8IDNyKdsOwm1YbJg7N9b770aTTRZCFyNa/50qGSqdBlLS0WluYK/Nqav5Bk/IPfn+WJIAaYxGWD6sAhsNvKr6/Hb3eAa7Mzwcdm2MnYSkqWrjbAt34WRKMuxefSWqaN9BYuF+cXic82qgR5IfHsvgH+skZG1nsAKyH3zWtVS/hbegn12TK8WFDxjNlfGb3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1835.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(76116006)(66946007)(8676002)(64756008)(66556008)(478600001)(66476007)(33656002)(66446008)(8936002)(7696005)(4326008)(83380400001)(6506007)(86362001)(26005)(5660300002)(2906002)(55016002)(52536014)(9686003)(316002)(186003)(53546011)(6916009)(71200400001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 8qnx46d7PoXzab0gva30eCGqsPxzCbYduB43dzzMqX4mhST5h4lzLlH/Z+1v7UTPjXZzAMM0LFUJprVHYpCLi1W1rlKF4CSeeeIcxg301URhcv9jJ7PbPMcpFX2ljO9knyQIa+kSqGzCcrov283pqkOGWaR0G6C0U9QWIkl1scqqKO2KvjoxhFvoHIP7tNnQTDTAZP/PBBxFuPOBng98ey2e7P7XEHz99+ZLfwmVgoKOkuwkORsX4mBQexT3GasEfO6PrO8dEgKpmst/+JvFnwOkIy5Aak1mntWiP7Ubx1Fi77vRJ6RdLrjDifV1i5JvQpPupWlKYo1F3w8dkDBqmPqTuWVLpojogzWk8+rRA7YY5Z7tKeh1iM+tEPLD5ltJOK/fyIBRVs4n6KlLQjpcZ2XdLwh3QoVdIRBCy0nMjxqwhJcKruhMuBugM/aPwAEddGcMfaYbdQVwaVSQbfJiFbN5EQ9XkdAzLrwd/+4HXqOAVcsHhmGDsn9YJmAl5UXPcLcx2prtaI2x3wIncQH/XFo5SleDhwWbZMWsLHNyPYFlvN+f4P9pTLHUJElp8NO8IXRbdVE40xSKeJs8oS8m+EbTkwp22lOtDTl4zqC4EcyfkyFJc7qr6h2+fSZ8+DH1Jw0o3hvnilFuuGlyXTZ8bA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4f7c87-7648-449f-09d3-08d885a5af51
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 18:23:12.9027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bft9AqnM+DtC4kDWIMSYC4Elsvo7Pp+fGJPte8MKbnQN6z1v0dJfnVMTqJJIlPQg6DAp9cqkkY8s7S/DZSuUzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4699
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 10, 2020 at 17:30:5, Greg Kroah-Hartman=20
<gregkh@linuxfoundation.org> wrote:

> On Tue, Nov 10, 2020 at 03:17:54PM +0000, Gustavo Pimentel wrote:
> > Hi Greg,
> >=20
> > On Mon, Nov 9, 2020 at 17:31:8, Greg Kroah-Hartman=20
> > <gregkh@linuxfoundation.org> wrote:
> >=20
> > > On Thu, Oct 29, 2020 at 08:13:36PM +0100, Gustavo Pimentel wrote:
> > > > Add Synopsys DesignWare xData IP driver. This driver enables/disabl=
es
> > > > the PCI traffic generator module pertain to the Synopsys DesignWare
> > > > prototype.
> > > >=20
> > > > Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > > > ---
> > > >  drivers/misc/dw-xdata-pcie.c | 395 +++++++++++++++++++++++++++++++=
++++++++++++
> > > >  1 file changed, 395 insertions(+)
> > > >  create mode 100644 drivers/misc/dw-xdata-pcie.c
> > > >=20
> > > > diff --git a/drivers/misc/dw-xdata-pcie.c b/drivers/misc/dw-xdata-p=
cie.c
> > > > new file mode 100644
> > > > index 00000000..b529dae
> > > > --- /dev/null
> > > > +++ b/drivers/misc/dw-xdata-pcie.c
> > > > @@ -0,0 +1,395 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Copyright (c) 2020 Synopsys, Inc. and/or its affiliates.
> > > > + * Synopsys DesignWare xData driver
> > > > + *
> > > > + * Author: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > > > + */
> > > > +
> > > > +#include <linux/pci-epf.h>
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/device.h>
> > > > +#include <linux/delay.h>
> > > > +#include <linux/pci.h>
> > > > +
> > > > +#define DW_XDATA_EP_MEM_OFFSET		0x8000000
> > > > +
> > > > +static DEFINE_MUTEX(xdata_lock);
> > > > +
> > > > +struct dw_xdata_pcie_data {
> > > > +	/* xData registers location */
> > > > +	enum pci_barno			rg_bar;
> > > > +	off_t				rg_off;
> > > > +	size_t				rg_sz;
> > > > +};
> > > > +
> > > > +static const struct dw_xdata_pcie_data snps_edda_data =3D {
> > > > +	/* xData registers location */
> > > > +	.rg_bar				=3D BAR_0,
> > > > +	.rg_off				=3D 0x00000000,   /*   0 Kbytes */
> > > > +	.rg_sz				=3D 0x0000012c,   /* 300  bytes */
> > > > +};
> > > > +
> > > > +static int dw_xdata_command_set(const char *val, const struct kern=
el_param *kp);
> > > > +static const struct kernel_param_ops xdata_command_ops =3D {
> > > > +	.set =3D dw_xdata_command_set,
> > > > +};
> > > > +
> > > > +static char command;
> > > > +module_param_cb(command, &xdata_command_ops, &command, 0644);
> > > > +MODULE_PARM_DESC(command, "xData command");
> > >=20
> > > Please do not add new module parameters.  This is not the 1990's, we
> > > have better ways of getting data into a driver.
> >=20
> > Ok, I'll move this towards into the future, lol I'll use debugfs instea=
d.
> >=20
> > >=20
> > > > +
> > > > +static struct pci_dev *priv;
> > >=20
> > > You are only going to support one PCI device in the system at once?
> > > That's not needed, again, this isn't the 1990's, please use
> > > device-specific data and you will be fine, no "global" variables need=
ed.
> > >=20
> > > > +
> > > > +union dw_xdata_control_reg {
> > > > +	u32 reg;
> > > > +	struct {
> > > > +		u32 doorbell    : 1;			/* 00 */
> > > > +		u32 is_write    : 1;			/* 01 */
> > > > +		u32 length      : 12;			/* 02..13 */
> > > > +		u32 is_64       : 1;			/* 14 */
> > > > +		u32 ep		: 1;			/* 15 */
> > > > +		u32 pattern_inc : 1;			/* 16 */
> > > > +		u32 ie		: 1;			/* 17 */
> > > > +		u32 no_addr_inc : 1;			/* 18 */
> > > > +		u32 trigger     : 1;			/* 19 */
> > > > +		u32 _reserved0  : 12;			/* 20..31 */
> > > > +	};
> > > > +} __packed;
> > >=20
> > > What is the endian-ness of these structures?  That needs to be define=
d
> > > somewhere, right?
> >=20
> > What you suggest? Use __le32 instead of u32? Or some comment referring=
=20
> > the expected endianness?
>=20
> Use bitmasks, that way it works on any endian system.

All platforms used in prototype validation are little endian and this=20
structures were validated using those platforms. I can put my the backlog=20
to do a general driver rework on the driver to use bitmasks, but for now,=20
I rather not do it right now due to the equipment access=20
limitation/restrictions caused by the pandemic. Can you accept this?

>=20
> >=20
> > >=20
> > > > +
> > > > +union dw_xdata_status_reg {
> > > > +	u32 reg;
> > > > +	struct {
> > > > +		u32 done	: 1;			/* 00 */
> > > > +		u32 _reserved0  : 15;			/* 01..15 */
> > > > +		u32 version     : 16;			/* 16..31 */
> > > > +	};
> > > > +} __packed;
> > > > +
> > > > +union dw_xdata_xperf_control_reg {
> > > > +	u32 reg;
> > > > +	struct {
> > > > +		u32 _reserved0  : 4;			/* 00..03 */
> > > > +		u32 reset       : 1;			/* 04 */
> > > > +		u32 enable      : 1;			/* 05 */
> > > > +		u32 _reserved1  : 26;			/* 06..31 */
> > > > +	};
> > > > +} __packed;
> > > > +
> > > > +union _addr {
> > > > +	u64 reg;
> > > > +	struct {
> > > > +		u32 lsb;
> > > > +		u32 msb;
> > > > +	};
> > > > +};
> > > > +
> > > > +struct dw_xdata_regs {
> > > > +	union _addr addr;				/* 0x000..0x004 */
> > > > +	u32 burst_cnt;					/* 0x008 */
> > > > +	u32 control;					/* 0x00c */
> > > > +	u32 pattern;					/* 0x010 */
> > > > +	u32 status;					/* 0x014 */
> > > > +	u32 RAM_addr;					/* 0x018 */
> > > > +	u32 RAM_port;					/* 0x01c */
> > > > +	u32 _reserved0[14];				/* 0x020..0x054 */
> > > > +	u32 perf_control;				/* 0x058 */
> > > > +	u32 _reserved1[41];				/* 0x05c..0x0fc */
> > > > +	union _addr wr_cnt;				/* 0x100..0x104 */
> > > > +	union _addr rd_cnt;				/* 0x108..0x10c */
> > > > +} __packed;
> > >=20
> > > Why packed?  Does this cross the user/kernel boundry?  If so, please =
use
> > > the correct data types for the (__u32 not u32).
> >=20
> > The idea behind this was to be a *mask* of the HW registers. By using t=
he=20
> > packed attribute would ensure that the struct would be matching with wh=
at=20
> > is defined on the HW.
> > Since the used unions definitions are already packed, maybe this packed=
=20
> > attribute on this structure is not needed. What this what you meant?
>=20
> No, that's fine, just that if this does cross the user/kernel boundry,
> like you say, then you need to specify the endian of the variables, and
> use the correct types, which you are not doing anywhere here.

Understood, but on this case it will not. These registers will be used=20
only HW initialization and setting HW behaviors.

>=20
> > > > +	status.reg =3D GET(dw, status);
> > > > +	if (!status.done)
> > > > +		pci_info(pdev, "xData: started %s direction\n",
> > > > +			 write ? "write" : "read");
> > >=20
> > > Don't be noisy if all is well.  You have a lot of "debugging" message=
s
> > > in this driver, please drop them all down to the debug level, or just
> > > remove them.
> >=20
> > I understand and I agree with that, but this driver will be only used t=
o=20
> > assist a HW bring up. It's focus will be only on FPGA prototype=20
> > solutions, restricted to only some cases. This help messages will be=20
> > important for a HW design or a solutions tester to find a problem root=
=20
> > cause.
> > In this case can this messages be an exception to the rule?
>=20
> Why not use ftrace if you are supposed to be tracing the data flow
> through the driver?  Or tracepoints?  Don't rely on printk for this.

This trace message is not for my debug, it's for the HW IP validation=20
testers and designer.
For instance in this driver they want to know upon the driver loading=20
which are certain values set on the HW and if they match what was defined=20
on the FPGA design. Since this under prototyping scope sometimes the HW=20
might block/hang by multiple reasons, having this debug messages, can=20
help them to understand where was the last "heartbeat" was taken and=20
point them to probable the root cause.
As I said, this driver will be use on the prototype validation (basically=20
internal to the company), by persons that will have the bare minimal=20
Linux knowledge, because their focus and base knowledge is the HW itself.

>=20
> thanks,
>=20
> greg k-h


