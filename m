Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F9F1EC0B2
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 19:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgFBRHU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jun 2020 13:07:20 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:58034 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725969AbgFBRHT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jun 2020 13:07:19 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C19CB403BB;
        Tue,  2 Jun 2020 17:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1591117639; bh=++9dOwBPuNwE08U7KknoLw79l8LM3t7sdlA9mRjkLDg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=OmiXCK4DuW/KnNmxfxQPqiL53RaZk52yrTD4P28Qn54X+CEHQsTtTFSBwVaksLRDd
         kh2szq8DsxRIHZAsvb1FCg7QTWBS1c4qodrW+2T1UlyeG3sRGkyxH0/PrMfuXOTXJM
         UQCQUXehMuv/DxfpEBj+C1FLc5wnfTxfHIJJMvvrBk+Mr9+qJdAifIZLy8TrfAPnOl
         QsFTgOptezS2ORnr5RrRrr0QHGPX7Z+3BYFHvTRf3inYFB/wKuUgUAPUZkiGl7EloH
         IpQGAuG9vBX4gs58wYIN5OY1AgBdFaRVal42YQkKF18YKeCioFO4Ks1Hk/4DvrxwUy
         FT7A0i943LuEA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id B4F33A0083;
        Tue,  2 Jun 2020 17:07:17 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 2 Jun 2020 10:07:18 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Tue, 2 Jun 2020 10:07:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QkEzT2Z0SI5Z5o4A+nVOPLjAg92QbnKVqCmOhFMWazXxUcpzSjuhQmBaoZLI5J3zjwrOGLxvTCu1qmHW2/4U6HGOPPxqYcl/M5gASQDmun3GO9f8gCndMSpble3dqQ7dBC1yaqVaRjgj4dBbHnb3QFAwRskKk5GYOQLOOsBV1M/ENnWIi8rC7xnoWdQ4rn0foL4kT3T69GKgVNkJ5YTAysNfH+96Dn1Wt8deS84zzaQuBK8Tbr8VBfGRWjA6eXQfG03M2htOZHUxXTN5A1ZiVLErP5rfVv0H2KTqOPjJnC/gD3x7fDwt1mI9CmxOOQCqinWMAceZk8VhP8MdjLOqmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkYZfOCoVYvIv3qV7ADLLByjHhpiUDNkAlJlcQ5eWM0=;
 b=SghB/SZtaIR7iBuKm80hd8cGbHUK+2Hw76jFIkZCogVQJO78+GlMNi3aEdzmqF/s+4eg/pP4eqbc1eHuTHVcJlZoxBCIQi0AvncMKyxGGdsIte0X27IXkTylwviXRJTAMPT+WRaScCLBDGGb/mkFQ+GAkY8SEq9PO/8sQSrhKlkB38OT9gch4+Kk898Fq6vNEBMvGTmOo0EMrihuwH17NXOrlhEjedsiWLo8AdU+bBCH7sZ1/vsBOBLyGqdZnSH4QUX5B7WfDKEsUMru063o8DEcnaKiZ2O01n7eDFy35E0oezVzb52Lo/k0CpBfNc9cMAxdZyScAb7Ghsm5ibDBSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkYZfOCoVYvIv3qV7ADLLByjHhpiUDNkAlJlcQ5eWM0=;
 b=EwiBnEp1YZQKAOWSdz2KH+MIu2eS2SQQvTL4x+GBiQdiRi70JOlQG/rwB9DPjLGbAythYFlSXuTWVG+zPK7WP8KU2S+Rh8DkKKQ9RXOZjzJWp8IZ2ruQOauk9H49G+qqgms555Ra62ZY3423I1jsybdqs1kIhluYdBW98e8bsTo=
Received: from DM5PR12MB1276.namprd12.prod.outlook.com (2603:10b6:3:79::18) by
 DM5PR12MB2487.namprd12.prod.outlook.com (2603:10b6:4:af::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18; Tue, 2 Jun 2020 17:07:15 +0000
Received: from DM5PR12MB1276.namprd12.prod.outlook.com
 ([fe80::f533:4c74:1224:cd32]) by DM5PR12MB1276.namprd12.prod.outlook.com
 ([fe80::f533:4c74:1224:cd32%5]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 17:07:15 +0000
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Vidya Sagar <vidyas@nvidia.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>,
        "robh@kernel.org" <robh@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>
Subject: RE: [PATCH 0/2] PCI: dwc: Add support to handle prefetchable memory
 separately
Thread-Topic: [PATCH 0/2] PCI: dwc: Add support to handle prefetchable memory
 separately
Thread-Index: AQHWOMYE7ODbO2RSVE6Pntnec2wuFqjFjjdg
Date:   Tue, 2 Jun 2020 17:07:15 +0000
Message-ID: <DM5PR12MB127675E8C053755CB82A54BCDA8B0@DM5PR12MB1276.namprd12.prod.outlook.com>
References: <20200602100940.10575-1-vidyas@nvidia.com>
In-Reply-To: <20200602100940.10575-1-vidyas@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTgwNzhiYzljLWE0ZjMtMTFlYS05OGI4LWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFw4MDc4YmM5ZS1hNGYzLTExZWEtOThiOC1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjE5NTYiIHQ9IjEzMjM1NTkxMjMzNzc2?=
 =?us-ascii?Q?OTcyNyIgaD0iR3FZWlVvSEJYSWdQY3FoaWNNUTJ0MzY3ZVFvPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFE?=
 =?us-ascii?Q?L3hOQkNBRG5XQWM4dDNHNXZCbXE5enkzY2JtOEdhcjBPQUFBQUFBQUFBQUFB?=
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
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [83.174.63.141]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d65408d-3ed0-4e86-3617-08d807176682
x-ms-traffictypediagnostic: DM5PR12MB2487:
x-microsoft-antispam-prvs: <DM5PR12MB2487DC520181F684C923F4CBDA8B0@DM5PR12MB2487.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0422860ED4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xEvhBVk6alzQ19fjeWPtyjsJoahwPxRswikrIcdLDu0+4S3wiqeRkDHJkZaqZr+BXMNw0mCVBlWYEr846xP6iVoDiii4ojofb2Gm16sq+uMfwXy9zSdjHMT/E8U8SZ0Z0xQNwMhjU5iGACL+G/r6IQ9fpui7I5RQvVarowrVg/DPybJqzffU8M2y13SAttecDJYMoUmeQzEN2nOUfSi1vLEZR0Hu7A10kPGWWsIVgcO9jESOKaomFHT6bx3dO+3XQDde+DbzQAd0BeulwDIvZyAkQ83Ss+5XcVh86dL0lt6+C81idzHTaylDhRuF8pUzT1j0eXTsirwyOMAjG1WeGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1276.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(39860400002)(366004)(136003)(396003)(54906003)(478600001)(64756008)(66476007)(66446008)(316002)(110136005)(66556008)(76116006)(66946007)(5660300002)(7696005)(86362001)(52536014)(6506007)(33656002)(53546011)(83380400001)(8936002)(26005)(8676002)(186003)(4326008)(2906002)(55016002)(9686003)(71200400001)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: FA8xPdkI8M06f3jChpYOWSfYa5PgpSECJOoTLm2ZNiYV306OA4kMQL9GqLYISWfc/mfrRmWfDDaI2T0pnqr5vfXR1trTUqbB1D18NGrOWCaQ5nqOp79cCYXJP0h/BVNW11AJ0WgCW2X3vubyA7LipoishtpF8lz3b5Bwn6V3+BC2x/lKRUF7eVSHzPAFEQ1iHNF4FeyjRNHQO0tmR36JPgg/TKVKiHdrQ2/E+J/e/WdjGg4wudML7PLT75TnrZdcElJxSQSAKhw3kmESIaZ+qUaY2qyO8unHMXK70Bb6BXvgcSwh5eVc8aO9xSvbrhwxeGwuaK2S8Xl6guunRXCqQPmV4pFG4n+WsIPaY3WOBVpJDs0E49MOz4EcEKkID+aEl0322ZRRyl0+uWg9IfpUH0uxyu6BD8DVynI3vji9o2QrvgmIfjKP3Q0RXO3/jN4t4HISmNGTu6ZviQWun8wWHuSj2/ldI8tcYmD4qreoVrY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d65408d-3ed0-4e86-3617-08d807176682
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 17:07:15.7407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xlvXf/JNsJ5FkpbiXXwc4zHHCqigdZq7jrZsNabNawQDHGhCikS5KuwCp1AMlJxIWYEB1eTvkLnkOjW2nX+Mpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2487
X-OriginatorOrg: synopsys.com
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 2, 2020 at 11:9:38, Vidya Sagar <vidyas@nvidia.com> wrote:

> In this patch series,
> Patch-1
> adds required infrastructure to deal with prefetchable memory region
> information coming from 'ranges' property of the respective device-tree n=
ode
> separately from non-prefetchable memory region information.
> Patch-2
> Adds support to use ATU region-3 for establishing the mapping between CPU
> addresses and PCIe bus addresses.
> It also changes the logic to determine whether mapping is required or not=
 by
> checking both CPU address and PCIe bus address for both prefetchable and
> non-prefetchable regions. If the addresses are same, then, it is understo=
od
> that 1:1 mapping is in place and there is no need to setup ATU mapping
> whereas if the addresses are not the same, then, there is a need to setup=
 ATU
> mapping. This is certainly true for Tegra194 and what I heard from our HW
> engineers is that it should generally be true for any DWC based implement=
ation
> also.
> Hence, I request Synopsys folks (Jingoo Han & Gustavo Pimentel ??) to con=
firm
> the same so that this particular patch won't cause any regressions for ot=
her
> DWC based platforms.

Hi Vidya,

Unfortunately due to the COVID-19 lockdown, I can't access my development=20
prototype setup to test your patch.
It might take some while until I get the possibility to get access to it=20
again.

-Gustavo

>=20
> Vidya Sagar (2):
>   PCI: dwc: Add support to handle prefetchable memory separately
>   PCI: dwc: Use ATU region to map prefetchable memory region
>=20
>  .../pci/controller/dwc/pcie-designware-host.c | 46 ++++++++++++++-----
>  drivers/pci/controller/dwc/pcie-designware.c  |  6 ++-
>  drivers/pci/controller/dwc/pcie-designware.h  |  8 +++-
>  3 files changed, 45 insertions(+), 15 deletions(-)
>=20
> --=20
> 2.17.1


