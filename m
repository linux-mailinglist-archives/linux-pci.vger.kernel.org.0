Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA071C5438
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 13:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgEELQb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 May 2020 07:16:31 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:46952 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727090AbgEELQa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 May 2020 07:16:30 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9A8A0C1385;
        Tue,  5 May 2020 11:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1588677389; bh=9qqYUdiSVns2PyMASC9ap7aD0pPPHsjSn+405Mo7w/o=;
        h=From:To:Subject:Date:References:In-Reply-To:From;
        b=RZJHJnPxFidso3IDGG2nVJ7S5rHzxUey4npTzyY0x+QC7rA3ZTtiTPcw9SQCUDswF
         6nSK9TBMkD/HUbgh0vCb0nnip0q6TsCoYFLfReext7TwHU53wqZYV6C+96I9c43Vov
         Ebngv9UTt/dtCSBkIVSWIJ6mB9WZUJqu2FOHizrckGT8UmFdWrkm0JnqHYekS8ZezH
         lscBGAdRdnNZeFDYSTrdWYnKOKph8zhO1BKHcEzNVYEJGVdJQO89cQGNG2LUXwwBTi
         IXfV5z2PdlAI4Z1lz8/qsGz5qI8WaSKNpQfP85h0bQOFR790JRt4e2qsiBM9Xvro/v
         veNwA2h3Se0pA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id BB554A0070;
        Tue,  5 May 2020 11:16:27 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 5 May 2020 04:16:05 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Tue, 5 May 2020 04:16:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMyBnKOu2DRfQe+64YzpjzQ5oHIbW0DNXm7ALrNQf3nbzEykO+2QJwFV2yJq0M8JSLlOSxWhtPRkijBR9VVeLQ7RyyCwOOJtWx/uTJZT5EnjQ9LyUExaT/OiAc6CVEovYAc5jg0lTss7QHpS0biu4ik//LwNdDHkgrQ6q/6htP8Gw9Vz15IXG6FZCLYtjVZ+P89thN0162qH5j+fPDNZpKSwIxdexIHbWd0FxJ4ep4kJZArcG9u+hYZnxcqAI/zNyc+5acN5RbA69RRO5MrkY9qvl/P2c7jJozYMb+6qhyjqyFRNnCN3WPw+pe+MfcDfFTNs97/eFIqHs6wWRtnmYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3A/mKCL0ri9XcFHpuOx6ITWrZVGiPsJNOfBPDL/qMI=;
 b=TqdzM3XSnGDOQ1l3fOS/LiePr5s1AoaCfze7lbSn2yMP+dlOGy6/aA2UJ4MZZqx/cAsKe1yW3MqXrB16tvnasIJKo9jTuDKL5h2IC2J62lNOuchnhvflDuUB9bZEDIHnK0xASXZACXQcxCNRmkJ3iMU/qaY3Kk+QOi+O9EXWwjiYJzqM/d1xtS9sk3wOAsTSMjX7VgZFTwJnafyvDuGMVJcUUIuzurkn4bDibZpFkS3H2PRL/19SJlpPFMwPmbiZ1p+2C4w5PNW9F8v/ixCqRpZK8gfUUA+j7hzlRcwU4foyFNCwaUaOdyDr1NWFc8HGtQyjssXMiouF+370EtW02Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3A/mKCL0ri9XcFHpuOx6ITWrZVGiPsJNOfBPDL/qMI=;
 b=Cp4/nvDD72+gXKk1Gx1jnRUcmIsJo3s9HIl6iHkc8cY2v3gEB5eKAs/9mZFpJNUFFrPK5UhunrhumMAU/D1fO1c2OjfD72qg4DFIariAtryxaJDUx4ow4ZGQp18hO/bHw6t/oMsCLstVySZpz9AWgXcD+XQj3FnlAGEU7wF60Wk=
Received: from DM5PR12MB1276.namprd12.prod.outlook.com (2603:10b6:3:79::18) by
 DM5PR12MB1466.namprd12.prod.outlook.com (2603:10b6:4:d::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.29; Tue, 5 May 2020 11:16:03 +0000
Received: from DM5PR12MB1276.namprd12.prod.outlook.com
 ([fe80::2062:f350:1cd1:1023]) by DM5PR12MB1276.namprd12.prod.outlook.com
 ([fe80::2062:f350:1cd1:1023%12]) with mapi id 15.20.2958.030; Tue, 5 May 2020
 11:16:03 +0000
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Alan Mikhak <alan.mikhak@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>
Subject: RE: [PATCH] PCI: dwc: Program outbound ATU upper limit register
Thread-Topic: [PATCH] PCI: dwc: Program outbound ATU upper limit register
Thread-Index: AQHWCIGHea+WiWXwD0OZucyQkv3tqaiZjArA
Date:   Tue, 5 May 2020 11:16:03 +0000
Message-ID: <DM5PR12MB1276259AC5AB41916CBD93A5DAA70@DM5PR12MB1276.namprd12.prod.outlook.com>
References: <1585785493-23210-1-git-send-email-alan.mikhak@sifive.com>
In-Reply-To: <1585785493-23210-1-git-send-email-alan.mikhak@sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLWNjZDlkZWQ0LThlYzEtMTFlYS05OGFkLWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFxjY2Q5ZGVkNi04ZWMxLTExZWEtOThhZC1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjM2MTEiIHQ9IjEzMjMzMTUwOTYxNDk5?=
 =?us-ascii?Q?MzkxMiIgaD0iamViZEJKS1EvKzNMYlhzVExUVmc0NmVBWXljPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFE?=
 =?us-ascii?Q?NFlUR1B6aUxXQVVlVTU4enpqa1UvUjVUbnpQT09SVDhPQUFBQUFBQUFBQUFB?=
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
authentication-results: sifive.com; dkim=none (message not signed)
 header.d=none;sifive.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [89.155.7.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d718da5-bc1b-41dd-9b68-08d7f0e5b2ef
x-ms-traffictypediagnostic: DM5PR12MB1466:
x-microsoft-antispam-prvs: <DM5PR12MB14667CB2C0011077A78CF438DAA70@DM5PR12MB1466.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0394259C80
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kj325mBCMpqx279/kNQFgWq9XaHclSrrVrqV9LFM3q0obhWBc2f2YpBASQWdNxVxd1uMkSD2VnHBDhxReDQIZKodRBKDUWTlP7A+3+bXYDkZA3LXgcj/9/FS1YtNYgiejR6CrmZ+xdKAQIRdhMEzgxqLqQ9lr8NkUsHoqGI71m4wG8EwuFP6+jbaK7Nil45qwZXhgjIdThXC31MUQJORuGhzNwSiL9NtrQxms4eTEScHVtROfynmLwdwC4J0KkEVQVtEpaEbJc4dmMPad+Uj7wpzvT4v0whnTTDr/gDww9jljNfD86B/WdsPuFDSlSejTIb6FyTYn5J0djk1M+nAHQt7FO6npnFnEibNyd7ralKF9je0CbQiv0d5jjqvabgfPlQOSt52BG2spwMWANupnUGKexJYr8H12cKfh4Yo/Q3o/hnjYYZK0AlIN4Wj+M0kZ1AGl46X+lSqOBxBsPxqo/YfoEr/vl9VkPx7G1K9ulZ3x76X8iA1nKjN8J3h9mb+jDf3nVTRkmbdziLH2FOhig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1276.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(346002)(136003)(39860400002)(376002)(33430700001)(86362001)(55016002)(9686003)(52536014)(2906002)(71200400001)(5660300002)(478600001)(33440700001)(33656002)(66446008)(64756008)(66476007)(66556008)(110136005)(76116006)(7696005)(66946007)(26005)(186003)(6506007)(8936002)(53546011)(316002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Vi4DiMlKwSlIhKfUtzSkDHtaq7nKhGPI70xGzYvbxINNzQR0A15HIsHTiR6Jny+YTRWE2FLe/AQZiXVkoed2krYwVJrhx8Ri6rK/uqWtyK1KVSSrGFSMK0ANDEQ7bz7qyE4LDrRVCKx/7O0V2l737x9W8qJyqEHLCp1xc9gffmVUF5xrtP6z1lOnffzR/ZrAiD7S+l3WaogrgvCUljMP3AceHINQrJaadHyiuG37VE3WlmoOeSJuLKo4w7K40B8M+GrEHzqX5aMOZLfcTy4jafdQwqHfBzrsxnyssMGbKFJt4RswzW9wo3yELhXyebqm1gFwpEbuVpVUnCwNWKkwUeQg4cp9CVyZ9WpMEDfY7VwM5f5bxGZdhM5HzAlFX5bBr38i7wcU05NMsOwe35huOkem2R4Ya5o069UdJ3oJNTe4tzsikovyUJQMB7Q+8tzh8HAQ9Krn3Vk+sX9KHFUQKx9kSc8ksRdmsxTVEqVEKU83miZfGT9oF1hKFEKm3h+I7PDfGsy+jIFtXyobeC55abB4qwSxYgpJdjauNvCP1UJqV7fSVXxfsbx+xMYThdtL/zhPVoMeYLfEI1wh9Gggkg9MoMs8miotaC2p9wH6fo63J2+2l7eweBHfbPY5PtoHW78497eNlK1Fm4q6uLwo2Wx+Y93KEwf2wb+6Fo80RbFZHLoY0Y/Vsc0Cf4vun1ROKr2gTHWeONUjlHdySvxrMuOmc4iSsCkfuLmaiC+Why2m3qKDHANzFHJdkCDZ9hk6LaUXiep2Qk5asHJtsCUcKdo1JxxXYJK/5/aFl/Y2a+M=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d718da5-bc1b-41dd-9b68-08d7f0e5b2ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2020 11:16:03.5369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WnKn3n8rodEDKRJ2WdqMGpErnMTodPTVj1IBLO66lxjqgJhhjXwkJjAISaq94aGsKQHkSo+Si281Eg3rGuWXQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1466
X-OriginatorOrg: synopsys.com
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 2, 2020 at 0:58:13, Alan Mikhak <alan.mikhak@sifive.com>=20
wrote:

> From: Alan Mikhak <alan.mikhak@sifive.com>
>=20
> Function dw_pcie_prog_outbound_atu_unroll() does not program the upper
> 32-bit ATU limit register. Since ATU programming functions limit the
> size of the translated region to 4GB by using a u32 size parameter,
> these issues may combine into undefined behavior for resource sizes
> with non-zero upper 32-bits.
>=20
> For example, a 128GB address space starting at physical CPU address of
> 0x2000000000 with size of 0x2000000000 needs the following values
> programmed into the lower and upper 32-bit limit registers:
>  0x3fffffff in the upper 32-bit limit register
>  0xffffffff in the lower 32-bit limit register
>=20
> Currently, only the lower 32-bit limit register is programmed with a
> value of 0xffffffff but the upper 32-bit limit register is not being
> programmed. As a result, the upper 32-bit limit register remains at its
> default value after reset of 0x0.
>=20
> These issues may combine to produce undefined behavior since the ATU
> limit address may be lower than the ATU base address. Programming the
> upper ATU limit address register prevents such undefined behavior despite
> the region size getting truncated due to the 32-bit size limit.
>=20
> Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 7 +++++--
>  drivers/pci/controller/dwc/pcie-designware.h | 3 ++-
>  2 files changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/c=
ontroller/dwc/pcie-designware.c
> index 681548c88282..c92496e36fd5 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -244,13 +244,16 @@ static void dw_pcie_prog_outbound_atu_unroll(struct=
 dw_pcie *pci, int index,
>  					     u64 pci_addr, u32 size)
>  {
>  	u32 retries, val;
> +	u64 limit_addr =3D cpu_addr + size - 1;
> =20
>  	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_LOWER_BASE,
>  				 lower_32_bits(cpu_addr));
>  	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_BASE,
>  				 upper_32_bits(cpu_addr));
> -	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_LIMIT,
> -				 lower_32_bits(cpu_addr + size - 1));
> +	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_LOWER_LIMIT,
> +				 lower_32_bits(limit_addr));
> +	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_LIMIT,
> +				 upper_32_bits(limit_addr));
>  	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_LOWER_TARGET,
>  				 lower_32_bits(pci_addr));
>  	dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/c=
ontroller/dwc/pcie-designware.h
> index a22ea5982817..5ce1aef706c5 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -112,9 +112,10 @@
>  #define PCIE_ATU_UNR_REGION_CTRL2	0x04
>  #define PCIE_ATU_UNR_LOWER_BASE		0x08
>  #define PCIE_ATU_UNR_UPPER_BASE		0x0C
> -#define PCIE_ATU_UNR_LIMIT		0x10
> +#define PCIE_ATU_UNR_LOWER_LIMIT	0x10
>  #define PCIE_ATU_UNR_LOWER_TARGET	0x14
>  #define PCIE_ATU_UNR_UPPER_TARGET	0x18
> +#define PCIE_ATU_UNR_UPPER_LIMIT	0x20
> =20
>  /*
>   * The default address offset between dbi_base and atu_base. Root contro=
ller
> --=20
> 2.7.4


Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>


