Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65D81C544F
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 13:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgEELYv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 07:24:51 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:47166 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728233AbgEELYv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 May 2020 07:24:51 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7384FC1385;
        Tue,  5 May 2020 11:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1588677890; bh=LGq/UCiR9Vo3JcnnqMj1BTLPAIyOLirZBke9pgoS4EY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=cTqDJox2A8dYrRbOrUZXXryl5PMVR+lF5UdSpDbW71hX+jgmnVU4VE7Oafl+vdT4W
         bRjtX+McDNIFJgIpa7dwi+q/ixoTr0rUJjgClwTYFZqpXMI/VZ26AQOmiKRaCXQqSd
         pdRdhwF0mxrHRPO1kq5wGxbDjtG1mHe84UqN5HNrBM/Akp//1ssBfFySJM7xTNRMf0
         0xdzKc5Unl4puZkk957oHhYuc0AwGoKayupquyJoVe0ads0yj1jDgvzvb/R16aD1Vy
         5N9hDHd1ajcoFu6OJLiBXA5pzMd515yagZvwNK1fzwsbzJc/tzkOyCI+c9i4TEtvz4
         EmvwpSWkN04Aw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 131CBA006E;
        Tue,  5 May 2020 11:24:50 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 5 May 2020 04:24:42 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Tue, 5 May 2020 04:24:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLrQBgKNzwtx40jZ4P7YVH2KN14CzztqFsNpIPn1gokevqRYy+vJK3YOHm73bvTucVCdR90+pT39+09yrZE4zGI7zAKdsAcjuO5SRndi+u1+hZRQRuJj55apOsHYaMTJoUKk2yro3KoVxbuM0g0gj/4KFDIyv5Y5gkGA7hQEgjMLUbmZFKoxplGW9QTR3FqxbIFEYRZXYsqlSnaXNwF2O1TumK5Z5eNv/jDWc86nEBZWdzTKs0Nz8su06aKSt9D5n9d6b8HOYbs/8WKK7A9g7cdxC9zVeshoBMHBssl0xIeIxDXWf3ce/0Gqz7Z8SjMFxADbPLZ9CnVcQTN1kLLBFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzIAcH/yNCOu2A9EreFWlZbSs96seOKtwWSMs1SrJJc=;
 b=S1Fjl7x/CqPXUMlCnqGmdUNKf7CR4c6jsrpcxD+2uqtG+VjaOVpUhDoAtG9kY9YT9nAstjsWd0jEIwiOqbwHLSLJ46PUypV/yp6s+2whwq2DOABcOqIyVVeHH1QmuyDWiiksFlLIP7hITxEC4gDhFcIIBQrqgP0foTapcBK+i+cBnFiafZUxNea9FmUt0XvaFyVKgxrJ3n739+ydtVHKWisP4+h/iWqv1CgUwBc2JrNjYfVmQhlK22RvJS8mQ22PlefpiXP1tSeBRzE3OU0wQ1APLZ3XVgTNtll/ZQe3FOvB+OFTZFUQLGDLPGYeDbbKgLwaUyxfCD2yLcH5/OBaSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzIAcH/yNCOu2A9EreFWlZbSs96seOKtwWSMs1SrJJc=;
 b=K/zr9u/TVHOVkCQuDqy9dVPpb6fJt/iwdCOkHaqwUoK8TWU9LUpCqDHCfU4xBeDMnuaoaG8vQLi+6mZYWgYqpb64eUH5kkSzkEtwLW3Bf2sbojxXxwF05HQzs7pa6Zw19ykTko7JjW485MHZmUiFEjLW1z3T15FCshJy1zaNeCA=
Received: from DM5PR12MB1276.namprd12.prod.outlook.com (2603:10b6:3:79::18) by
 DM5PR12MB1322.namprd12.prod.outlook.com (2603:10b6:3:70::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.27; Tue, 5 May 2020 11:24:40 +0000
Received: from DM5PR12MB1276.namprd12.prod.outlook.com
 ([fe80::2062:f350:1cd1:1023]) by DM5PR12MB1276.namprd12.prod.outlook.com
 ([fe80::2062:f350:1cd1:1023%12]) with mapi id 15.20.2958.030; Tue, 5 May 2020
 11:24:39 +0000
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Alan Mikhak <alan.mikhak@sifive.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>
Subject: RE: [PATCH] PCI: dwc: Program outbound ATU upper limit register
Thread-Topic: [PATCH] PCI: dwc: Program outbound ATU upper limit register
Thread-Index: AQHWCIGHea+WiWXwD0OZucyQkv3tqaiZfx+AgAANL/A=
Date:   Tue, 5 May 2020 11:24:39 +0000
Message-ID: <DM5PR12MB1276A9B377E9A8DF36ADB007DAA70@DM5PR12MB1276.namprd12.prod.outlook.com>
References: <1585785493-23210-1-git-send-email-alan.mikhak@sifive.com>
 <20200505102933.GD12543@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200505102933.GD12543@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLWZmYzRlZmQ5LThlYzItMTFlYS05OGFkLWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFxmZmM0ZWZkYS04ZWMyLTExZWEtOThhZC1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjIzNzQiIHQ9IjEzMjMzMTUxNDc2ODA2?=
 =?us-ascii?Q?NzUyMiIgaD0iemFFSmExZ1FJWGVpK0MxRnFHYy9Qc0MxVHNvPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFE?=
 =?us-ascii?Q?Q0MxZkN6eUxXQVpYcWxVdkRNN3lVbGVxVlM4TXp2SlFPQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: 9ea7b7c4-567d-42b5-9fb2-08d7f0e6e6a4
x-ms-traffictypediagnostic: DM5PR12MB1322:
x-microsoft-antispam-prvs: <DM5PR12MB132214AD13C1CFDF2DD671CBDAA70@DM5PR12MB1322.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0394259C80
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yucAux03pNQSBjqDPyMSGJCV0hxcPbpiWYFdFj61NHJmIzPhPiagnrILLmtsxvT1+gJ4Rg9hE1UGQ0QvL1VFq6ApUAFn2WTI6r2fIBV1PTgfwbslayx+sJRoZJUiPzEQSuTP907Pw7uJMNtWvCr4o3OPdAOA4eZWgd85WgYINQsw7PEfGsZGqmPyQBJ2jGgc/9nVRQhC9JfR7/o7k0mpZ03f35FzINAA0m7CAI4RrdL8gZfD1y8SBXpZExgbSkPwPiYMJCM4SMMeLkwCfn8haedmnZ0PUxZU6T9sDqfgJQNW+XsoGS44l/AmqA/NdkeKPWJ3oGPYTVFM85+567NjlmMBI/rdi1xnulT9VpTAkwXWdwj6R1S3HTwC0R/why8KTknv4tpiKGQMdi4YJoWxcPpA7ijluwOSKPhfS/YiAwRoAElWSRu8ZmADKE42cwui9Txl1v1VBUh/eCQKorVucilGemxJqa3z2I50SEDPMf0topoHsc78CNNDDy/SS/g+H3FjUVfpa3aL8SV8fKbK5/FJ1PYEYH6ZGAIbGk1DoFqnr4EZWLl8IwdmpUe4TI5a/Mu2bdosfaJYfSEPgc+pzm1oOeIqFiPl58fxuKqItxY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1276.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(396003)(346002)(39860400002)(376002)(366004)(33430700001)(8676002)(52536014)(186003)(55016002)(5660300002)(4326008)(8936002)(2906002)(33440700001)(33656002)(9686003)(54906003)(7696005)(71200400001)(86362001)(966005)(26005)(478600001)(316002)(6506007)(53546011)(110136005)(66446008)(64756008)(76116006)(66476007)(66946007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: AvZeYtw1v2cyeA8aNA9/80cpRg0nP+uj84po4MFLNMyjXIpvjPdRFsHEQYlUdyoFxRpPk712RQVN+3DQdvcoaVavcxwpNcnW0xGDaQJ9lUc5O9Ym979z9rG/T9RkGOadJGR09wz/TLUDlcb7GzxIZCsyK1KvCc6bVpvqQKF56AyHCUXStfOiveKM3WfAyrTQ3UEhG3Rk5OzW1gFExy2aRVsQXc2sLR27NGcWDbY6Nw6osf+RG0OyaPplNXEsmOiRNDm4j+VqSwB6A6o0qMZiv7M+NQHiRwGG2rV+KttNbfl6JhlFCHL0FyQu32vv+mTgH/pLdji+ymmxyXh3qAQvlVmz2jIc+Y82vrBhbRMPBpnffSKmO0+If/X8g59td7esoPqlXdBZU12lzYrKmaW1hMcF4hipZl6nbYYhPO1tzR77H8jUykKQ7kkYRZNwPup8FTH0T7JBjpjWdb3IXUey/522/YIwf1UwWJPZOPtK8rDmfW2bjLbcu6uM5Z73dW4fQXy8r6EtSk2SBoXn4xQ2F5TyD82hAKtccOUIALX/krHsYWUib3U1fjQ43y7jFWMRjMr+GYNPNUu7PGNL1/79fHXtl6huMbZx0fpjhTKRY7NKgG1xqW2G/EuYj1MjI5jNX9viv3ML2BmESIgIrmhePBcCN5IBL+Nsjc/7TYxb8zDAVZ+vwEbVhGiv+e27sDqKlJt8hXHXc7s83n/pod4WDT2t7u3My4Dp+W/uPmrw6pSRW7OXWsCN0mEwrpAQIuRh0QJhyL1/PFPsMzJYmSqy5oybUcE7Ja2VP4oK4B2no0M=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea7b7c4-567d-42b5-9fb2-08d7f0e6e6a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2020 11:24:39.7727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m4gqiNIEt25zg5TGhxhS4iDdwo4dBlkN0RPMweBDTnXKTEMHtGSKZfoq2702BaFZrproDVumt6kjbc6ZdhBFgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1322
X-OriginatorOrg: synopsys.com
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On Tue, May 5, 2020 at 11:29:33, Lorenzo Pieralisi=20
<lorenzo.pieralisi@arm.com> wrote:

> On Wed, Apr 01, 2020 at 04:58:13PM -0700, Alan Mikhak wrote:
> > From: Alan Mikhak <alan.mikhak@sifive.com>
> >=20
> > Function dw_pcie_prog_outbound_atu_unroll() does not program the upper
> > 32-bit ATU limit register. Since ATU programming functions limit the
> > size of the translated region to 4GB by using a u32 size parameter,
> > these issues may combine into undefined behavior for resource sizes
> > with non-zero upper 32-bits.
> >=20
> > For example, a 128GB address space starting at physical CPU address of
> > 0x2000000000 with size of 0x2000000000 needs the following values
> > programmed into the lower and upper 32-bit limit registers:
> >  0x3fffffff in the upper 32-bit limit register
> >  0xffffffff in the lower 32-bit limit register
> >=20
> > Currently, only the lower 32-bit limit register is programmed with a
> > value of 0xffffffff but the upper 32-bit limit register is not being
> > programmed. As a result, the upper 32-bit limit register remains at its
> > default value after reset of 0x0.
> >=20
> > These issues may combine to produce undefined behavior since the ATU
> > limit address may be lower than the ATU base address. Programming the
> > upper ATU limit address register prevents such undefined behavior despi=
te
> > the region size getting truncated due to the 32-bit size limit.
> >=20
> > Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 7 +++++--
> >  drivers/pci/controller/dwc/pcie-designware.h | 3 ++-
> >  2 files changed, 7 insertions(+), 3 deletions(-)
>=20
> I would appreciate some feedback and possibly and ACK from DWC
> maintainers. Should this go to stable kernels ? It seems so,
> let me know if we want to add a stable tag.
>=20
> I will merge it, along with:
>=20
> https://urldefense.com/v3/__https://patchwork.kernel.org/patch/11468465/_=
_;!!A4F2R9G_pg!NoymSJCWmOx51jB7LdQQAbXFin14nfuVIQNQxROnskLmmGkzFeNOrf8nFWX_=
-KgsgO87N9M$=20
>=20
> Lorenzo

Sorry for the delay. I just gave the ACK to that patch. For me, it makes=20
sense to me to send it along with the patch that you just referred to the=20
stable kernels.

-Gustavo
