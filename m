Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD880318810
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 11:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhBKKYp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 05:24:45 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:59256 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230029AbhBKKWX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Feb 2021 05:22:23 -0500
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A34E0C00B8;
        Thu, 11 Feb 2021 10:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613038876; bh=1SPFbJeLGnCF2egVTDG4bn93M0+YWFNe0NmH/1ZWlf8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=RY9VE5lrXlknirBnkfqBo/1C2n7WnYdpjc6uytVB9FKDlUYN8pr/J5ldEpBGd8jt2
         5w1xWWdvGT9USw1w+AFJaYZqRl+c+RobmTZi8hi19+g1Zv8jKjBph3JwuehlK/8hvG
         FJQxYtlpfexaYMexOrVi9PIwQQetPmugfGOknDniKeY4QTY574xJAX9f+kcYXnkO7/
         og45EHcNaTf+TRDDLf8XPUxWE4zUpbAtSgakVkHfyjXTmC1w7B8Kn74x9IX53fIX1n
         hpJaexubbCkPxwnggQ9UIb47zWQ+L89WbecYn0YUOyBBA0gE75rXm4f0qCClZTeWTj
         WbzWD86ux8q6A==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 2B13FA0096;
        Thu, 11 Feb 2021 10:21:13 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id D239B80214;
        Thu, 11 Feb 2021 10:21:11 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=gustavo@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="qVlPr8lY";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uzla69jE4mehzYxlYsVYrehN64nDlzecLJxMfk1co43W0UyQbHiGKd146wBOMrUSTGeSj/LzWDPVVi0vrOnxZsEGsJkVUixi7Z4ArpGdfrYRMjHq2gZqesxCCQ4uI2lCa2qzpi4cftkSultXH6Ijb1saN3qczuTzqM9kL6FjCwM3Zv0uo4FA+aedCum1LH+APgJO6vAY5Zw6WatvwqIaQ7P099PScH2HGi/nyaErocQCAm2WIaCQ3SQ2J4k1z+T+qdXJ92NBzIRR1U9nXxb2tjf9AgWBktaZh+A6Xc60VqaVXOMrLv5VqG63aQxDUSeGP6QMZbFW6i4fzm4ui8P9ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghb3D4kn1AlEHT7rm1JF1jpzl0qerz4aQFm1SVR54Io=;
 b=cfjHAae4jbY2xZr+e3sc0SNhbv4LnIY3Of0ODYxHUaxrgpRzH/LvU/TKT26/BJWOSx9YepVbs+NzysD7bOyBujxDuoOR1WVWyUJL3/aeVfDPcQAwtnsGwlspjMfR2kLE7Ef4EJqGSTT/9Amt8Zq+ERPLpxBinOToZ2Q41gcgieOjLsRJmOiX7gYPItwsRBDKrrrK18YSt6AzDYKa+ysL5kWJ4AbyOwg1SsLWccL/Dpw7qWk8d/dcAMJpXcut5CJD69YIDnMUK+ftKA/Q2u0co0j+C/GaivjWCDDi0Eq4pL6rwtfrdz8kSMmXpyFKgnlBueIo/s+GeTvqykUERqWnxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghb3D4kn1AlEHT7rm1JF1jpzl0qerz4aQFm1SVR54Io=;
 b=qVlPr8lYpodH4wxlGkHA8FDwKpu/6EBSPNEzprw+LEw3tnf0TeW+hhZVEhe7tUGPCuhzlXOql6gmmVzFo8idtkQZNhbFwSRSdmxr0tyXWv63QU+Y/3dDOxA8iNDZyry0fdxWMSBnUdeJaY4J8TNPL4/GaWEcpWS+UwP6E8x+Nek=
Received: from DM5PR12MB1835.namprd12.prod.outlook.com (2603:10b6:3:10c::9) by
 DM6PR12MB4957.namprd12.prod.outlook.com (2603:10b6:5:20d::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11; Thu, 11 Feb 2021 10:21:07 +0000
Received: from DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052]) by DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052%10]) with mapi id 15.20.3825.030; Thu, 11 Feb
 2021 10:21:07 +0000
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
Thread-Index: AQHXAFWPyAqykiKVp0+x9nNcxSm5BKpSsFcAgAAErwCAAAN3AIAAAIDg
Date:   Thu, 11 Feb 2021 10:21:07 +0000
Message-ID: <DM5PR12MB1835522220E35874106BB924DA8C9@DM5PR12MB1835.namprd12.prod.outlook.com>
References: <cover.1613034397.git.gustavo.pimentel@synopsys.com>
 <02835da8fc8c9293fecbe666a8db3fb79276fdde.1613034397.git.gustavo.pimentel@synopsys.com>
 <YCT5KDnAWex8fvbz@kroah.com>
 <DM5PR12MB1835A23E60363C730E4D69AFDA8C9@DM5PR12MB1835.namprd12.prod.outlook.com>
 <YCT//nmQpOJD9row@kroah.com>
In-Reply-To: <YCT//nmQpOJD9row@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLWQ1ZDcwMjNlLTZjNTItMTFlYi05OGU2LWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFxkNWQ3MDIzZi02YzUyLTExZWItOThlNi1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjI1NDciIHQ9IjEzMjU3NTEyNDYxMjQy?=
 =?us-ascii?Q?OTUzMyIgaD0iZTg0dDQ4aHNTNS9RcXVYb1E4V0l6S0dpZFBFPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFE?=
 =?us-ascii?Q?ZHRwT1lYd0RYQWNaV0c1UWFySnFieGxZYmxCcXNtcHNPQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: 6be8513f-314d-470a-c96f-08d8ce76bed0
x-ms-traffictypediagnostic: DM6PR12MB4957:
x-microsoft-antispam-prvs: <DM6PR12MB495725F154BCF3908BBA2CD4DA8C9@DM6PR12MB4957.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5lUwsTLZS7/V4ly51B7pEIG6nzRy2oWXRjLUs+FIW22utiDxOapvW8oZ5Y0lCIgmPVAUFdgZVxX2CjQjRXOFbJzYRgkRokpc67pqZpnhi9+iRz/iO/KuWgmqS4gxuLTipfaiWp1uv/A3eBaZ9vkAz08r5i0vyO8rDu8q+QBIQykg0VVr8cAul/ZG4uwKtfwUqQXtdp+rt0EM2wTclI6vAHtDgXdRNC16n9kTAQeec6XFJuuzO7ijLilAoKz5ZHX518v68DDRjyZ3SvQ9bXHNFvos1F6OuLgtJDgZCj5/x/dJjjXQPRWK3xMG7vn3waViMUeGvbUTWWBPXI/7kqab4qQCK03AEK90VMYShjxLIqkkiynuTameNNkxuyMOSqrhTnw3owyqKQxdKVdmCsxTTXTOaCfz03UZzD655nMSTxz/SDGm4HEhHS/HPbCCcAw3/XjDBK+kkCKqvmEAzM54earerAjdvPmnWbnPkfwgzBhnBt+pZyyxgTyyMVn7Vmwy70nm0gVVB1nMs/0lKbOS8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1835.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(346002)(136003)(376002)(66446008)(64756008)(66556008)(66476007)(71200400001)(2906002)(6916009)(26005)(6506007)(33656002)(7416002)(55016002)(66946007)(8676002)(53546011)(316002)(76116006)(478600001)(4326008)(83380400001)(86362001)(5660300002)(54906003)(52536014)(8936002)(9686003)(186003)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?tqUM2epquuwlwqQXYWPFF2iVvVClRwYmybLxd/Ty9cjkPyyypp0EiYeuA5VI?=
 =?us-ascii?Q?7xpKDE7VRnzNorb8tZTKzIjZnFb6NNdxu4qMLrieWRD222UrbAZ82IiCwA2l?=
 =?us-ascii?Q?pPhNZf6PI/6o3PRbYElSGthwtoNxIpcLOS6db1YlsezFVX6ZIVUIfn5NJAVu?=
 =?us-ascii?Q?5x7A83z8bdLq6RhHiA+44lfp7syPDp+sRshRcV+5whMIlTd1ElKPs2aWZ3eu?=
 =?us-ascii?Q?CiJG1BPnBH0XJ3wre58XgQFigIKdVbAtTyz7H9PpE//cHknRsgg7cZ1Bgi+9?=
 =?us-ascii?Q?2h07FzlW0OGLtlWnv9gFDfOWdW3Mfv1rRhhwkIJuxWh5JoNN5is0CAK/SAVa?=
 =?us-ascii?Q?vwX7fdXEoLrjLDUfH6IW57PJlQ3oNcbZll/cl53eSmoFbAhUvJzx1dRHJ/Kb?=
 =?us-ascii?Q?WSBA+VHZO9TaNY4VTxek9KK1tHBgNRLBCnkvLUqr6+1iZNozU7E+CG4HHGkK?=
 =?us-ascii?Q?M9Ub2lloYUFd9W879N42ir7EugENkclR8NTqR7FqDn1pZBLoGRkKH6OGiMF8?=
 =?us-ascii?Q?zzmsd5OLwjrI6Lp/zB4o4zEbawzN+9W+LSvp0mQDdlOY+MLjeIsw2YwHCYIa?=
 =?us-ascii?Q?DxUMr0sVtFjAU/iGPzEEY/zADUPqryFEq/ffw/bHZqhng4A6Brjff2Gi9Iqm?=
 =?us-ascii?Q?VxjPiymr3GlpuY6H6k4IaLPOxECFhrfU9BIlOI3FRS4Joa1Db9Uo6eeNwyis?=
 =?us-ascii?Q?eJVnGveO0wyPVoKsps9UFkYIPtvI0HH0D/jAzbuzVDSNr91dtRDYBiGVMOyp?=
 =?us-ascii?Q?6+KnUCFaRQ+9nTFvdqJJA1A+mH3x7fEM19FqnjxNw4UlDCSd/Tx7XRwlGgj4?=
 =?us-ascii?Q?HRK552/QqxSYxE43d56IM2F3umK41N9CR04GA8rQJOZz4Ipl24dZhjuRGxxk?=
 =?us-ascii?Q?CenB4cewgo973HDDS5apVjghQtp2AcEcmJxLTnd09oiI7NZ9ZWhI4JLuQVNu?=
 =?us-ascii?Q?NsuMjGRrmhtgd1EhC9aemE1xzqTxyuURQXRIe29T1aHVinhS8AiUDCaPZgNJ?=
 =?us-ascii?Q?33IC/VMyDeyAY2eyAkOBHiBg5oXSXB9an9A+I2dfSZFR4T4q2B2sdR7wEHaa?=
 =?us-ascii?Q?4S2JDkLlSWju1DKpcZwYe0VwW6PuYoSQzu/CIEXo0i78TstpXXpO8H2WTIn/?=
 =?us-ascii?Q?iW6ZGMJm1mYNe5wVvkTwDw6T+BZfCTscNm+PETiQft00wMXQ0h/iiMCZR4qV?=
 =?us-ascii?Q?1ZMisPvC5/kJMalZ0FrFOniubvbEzYnVSS7Yq/oU145OvIyC7/19VXnDUxqc?=
 =?us-ascii?Q?Xud1iJQiTgOW+m9FdGdNT7d92BWCQN25CeRFrVvvoJsRP/RuWw1HfhIN9AuO?=
 =?us-ascii?Q?oXQKiTAYOvi4SAgLDYeWzag/?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be8513f-314d-470a-c96f-08d8ce76bed0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2021 10:21:07.4212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nd2kc/na+G9yijTBw6rR7kyzCa6YPpRkT5LQekqNtZawHlVCyCVsHQdUhyZ2SJM1KNiU+g5A9v4+YRGcCywYUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4957
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 11, 2021 at 9:59:26, Greg Kroah-Hartman=20
<gregkh@linuxfoundation.org> wrote:

> On Thu, Feb 11, 2021 at 09:50:33AM +0000, Gustavo Pimentel wrote:
> > On Thu, Feb 11, 2021 at 9:30:16, Greg Kroah-Hartman=20
> > <gregkh@linuxfoundation.org> wrote:
> >=20
> > > On Thu, Feb 11, 2021 at 10:08:38AM +0100, Gustavo Pimentel wrote:
> > > > +static ssize_t write_show(struct device *dev, struct device_attrib=
ute *attr,
> > > > +			  char *buf)
> > > > +{
> > > > +	struct pci_dev *pdev =3D to_pci_dev(dev);
> > > > +	struct dw_xdata *dw =3D pci_get_drvdata(pdev);
> > > > +	u64 rate;
> > > > +
> > > > +	mutex_lock(&dw->mutex);
> > > > +	dw_xdata_perf(dw, &rate, true);
> > > > +	mutex_unlock(&dw->mutex);
> > > > +
> > > > +	return sysfs_emit(buf, "%llu MB/s\n", rate);
> > >=20
> > > Do not put units in a sysfs file, that should be in the documentation=
,
> > > otherwise this forces userspace to "parse" the units which is a mess.
> >=20
> > Okay.
> >=20
> > >=20
> > > Same for the other sysfs file.
> > >=20
> > > And why do you need a lock for this show function?
> >=20
> > Maybe I understood it wrongly, please correct me in that case. The=20
> > dw_xdata_perf() is called on the write_show() and read_show(), to avoid=
 a=20
> > possible race condition between those calls, I have added this mutex.
>=20
> What race?  If the value changes with a write right after a read, what
> does it matter?
>=20
> What exactly are you trying to protect with this lock?

The write_store() does a procedure to enable the traffic on the write=20
direction, however, the write_show() does a different procedure to=20
calculate the link throughput speed, which uses a different set of=20
registers on the HW.

Similar happens on the read_store() (which enable the traffic on the read=20
direction) and on the read_show()

To summarize write_store() follows the same approach of read_store() and=20
the write_show() of the read_show(). I added the mutex on those functions=20
for instance to avoid while during the write_show() call the possibility=20
of been called the read_show() messing up the link throughput speed=20
calculation.
Or while during the write_store() call to be called the read_store or=20
even the write_show() for the same reasons.

This is the reason why I added those mutexes, maybe this isn't necessary=20
and it's overkill. Please advise me if a different approach can be done.

-Gustavo

>=20
> thanks,
>=20
> greg k-h


