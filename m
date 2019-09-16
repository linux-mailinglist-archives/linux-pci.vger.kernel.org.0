Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10C5CB3AB8
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2019 14:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732805AbfIPMwK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Sep 2019 08:52:10 -0400
Received: from dc2-smtprelay2.synopsys.com ([198.182.61.142]:45346 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732709AbfIPMwJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Sep 2019 08:52:09 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 12FC5C22FA;
        Mon, 16 Sep 2019 12:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1568638329; bh=THFRojX2sdVHUmeyTM6QIwmZRY9ESljDZAaqFZeKcMk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=LFcg/PiBKs/F65os4bbRflybGfE/+RNSBkITIZCG74sneJlf1HNW+hRVzttMieGRH
         u/ssJycBR2nrtQcxJDqX+P55v0/2y3D465Fy/M7up1adCPgQea/GA/QqyySiZkv8r/
         0xcNJCFVGdXHRspyA6MuZMHyc0Ue52YT2lVeItdmGtllbwoHssSB4F7zk0MzUGd1Wt
         qzCju7DiuS/ScNhx25Ffi90MGRqfsZUfYAc88+c5zVjcnZwo9GYyKGJ5aPdHB5b4lb
         btdErkDUon9GzSoUwSbyeK7JdGirTUaHGdAETYV5fYvucSGu9GQR1VV3aeDh1vUrHg
         qgse9j8j8U24A==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 2A3BAA005A;
        Mon, 16 Sep 2019 12:52:08 +0000 (UTC)
Received: from US01WEHTC2.internal.synopsys.com (10.12.239.237) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 16 Sep 2019 05:52:07 -0700
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 16 Sep 2019 05:52:07 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 16 Sep 2019 05:52:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oq5uXDNRDAxmU3UIzVeZ09nhAaYwHSpqx2VX7BX9Xxiob0cYGCpsIv+HIOfIQkDVQ9cuG0JcJOv+uyZE7a1mnMUgKTcnAoIr5Pwd0BHHAOri8mDi3fKHdA2ICZtpQ3iJv42xlauw97D8TVfzIWKj2PDm9aHgF/ivC0Ui/RXyqqYJlTpbiwTDkY4tB8314dQLM+uvvuDzz6aVRfawlX8zy9i59Wcxp8RunOCoZbFEzqeD+mV0TkXmLLbtyCuixJDxma1/Sn+T7J6MVND3/vJkqicJ4r6OoeKJ/AgRDS9Mq4eWMgo2XTdLahT3V8I8OZKbd4Gi+GCFjHVXm6xzOpAmJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmMPhYkzHrM6/W6v6QNJbsHzrOiLRWp4drwy3PLept4=;
 b=NpDSMJJBcBbMHX5zrfLa/EXtc+0ftv0hwWCugg1PQbf0Wk73AH7qR8fLe1G8LjB/+UvtTtER9T6qQmvYYyWO1esfHNkWQYdkXWgaFcIOXP20uUSKuYBHIaEkfUDHuK20tW084gnD+xdAyoGkW5UwgV6oeCc3WzLqbLLgi5p+kApGS+0W8/LOEI0POS0S3kAjiyRLlQTMJoV+mfqv+NCW65uudkFAfI6NeNiae8+0Q2bgUZsO3OkAskTzJ6ZCmSVuv1Q2eQBWrIH5YWv0ZZUlvW6mw4KbfGN5UrMTDkUtSfalPDUL8NGXNAoOapt9GEVaQffPqH9nViLn/eFTa4L74Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmMPhYkzHrM6/W6v6QNJbsHzrOiLRWp4drwy3PLept4=;
 b=Y54U/6MO6iH3XvqiBcJ476V7Q7nZiqkfrQbmZ7UtwehWO0FDdHwe+mgeGW1pHWWQfrONXTwGxnFrom0GOvSdM0X73C0hGp7UBPcp/iO6vfXKjCwA3tPQS2vHank0+mZDodsAq8avMrA8y8uOYgd2t1d20cvwlRhBhNIWO8Dh0RE=
Received: from DM6PR12MB4010.namprd12.prod.outlook.com (10.255.175.83) by
 DM6PR12MB3068.namprd12.prod.outlook.com (20.178.30.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.24; Mon, 16 Sep 2019 12:52:05 +0000
Received: from DM6PR12MB4010.namprd12.prod.outlook.com
 ([fe80::dd4:2e5:e564:8684]) by DM6PR12MB4010.namprd12.prod.outlook.com
 ([fe80::dd4:2e5:e564:8684%5]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 12:52:05 +0000
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Andrew Murray <andrew.murray@arm.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <Gustavo.Pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        'Anvesh Salveru' <anvesh.s@samsung.com>
Subject: RE: [PATCH v2] PCI: dwc: Add support to add GEN3 related equalization
 quirks
Thread-Topic: [PATCH v2] PCI: dwc: Add support to add GEN3 related
 equalization quirks
Thread-Index: AQHVah+5gF0/hNt1Nki2L2svv36Tq6cuGyYAgAAOM4CAABWlgIAAB0ww
Date:   Mon, 16 Sep 2019 12:52:05 +0000
Message-ID: <DM6PR12MB4010AE07CC6F1CC60A715EE4DA8C0@DM6PR12MB4010.namprd12.prod.outlook.com>
References: <CGME20190913104018epcas5p3d93265a6786dc2b7b8a7d3231bfe9c14@epcas5p3.samsung.com>
 <1568371190-14590-1-git-send-email-pankaj.dubey@samsung.com>
 <20190916101543.GM9720@e119886-lin.cambridge.arm.com>
 <00a401d56c7e$cf3abd30$6db03790$@samsung.com>
 <20190916122400.GO9720@e119886-lin.cambridge.arm.com>
In-Reply-To: <20190916122400.GO9720@e119886-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLWM2ZjgxYjY4LWQ4ODAtMTFlOS05ODhmLWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFxjNmY4MWI2YS1kODgwLTExZTktOTg4Zi1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjU5NzQiIHQ9IjEzMjEzMTExOTIyNzIy?=
 =?us-ascii?Q?MjYwMiIgaD0iUzkxYU5nUlJJR1FYVm1CTlZ5NEZRVEJEdndRPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFC?=
 =?us-ascii?Q?S09sQ0pqV3pWQVpnMy9OQkFkajR2bURmODBFQjJQaThPQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUhBQUFBQ2tDQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQVFBQkFBQUEvSG9zaVFBQUFBQUFBQUFBQUFBQUFKNEFBQUJtQUdrQWJn?=
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
x-ms-office365-filtering-correlation-id: 3aee7533-bd14-416b-4ba6-08d73aa4ad56
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR12MB3068;
x-ms-traffictypediagnostic: DM6PR12MB3068:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3068C7FD64D61FC848579ED0DA8C0@DM6PR12MB3068.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:597;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(136003)(396003)(376002)(13464003)(189003)(199004)(229853002)(486006)(33656002)(2906002)(66066001)(256004)(6116002)(3846002)(8936002)(55016002)(6436002)(53936002)(9686003)(6306002)(476003)(86362001)(11346002)(81166006)(8676002)(81156014)(446003)(102836004)(66556008)(64756008)(66446008)(6246003)(66476007)(54906003)(110136005)(305945005)(26005)(478600001)(76116006)(52536014)(66946007)(71200400001)(71190400001)(316002)(7736002)(53546011)(5660300002)(4326008)(6506007)(186003)(74316002)(99286004)(966005)(25786009)(14454004)(76176011)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR12MB3068;H:DM6PR12MB4010.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /af5o9Suc+9y9UBKQ/iP6Wef51J6KxE/cQL545WXhKQ4GW2TH/j6e/6EoAAEkdGtRv5muPeALFp6nQ7zPnJgs2bZ+0kV9DbRQE5B3RyQ3s0OF7zCAdxUkKtD0ze+k3K25LynQN8KfuLeLdBjR4CaPnx96fXbwtUsDZIRhRpUZ9JdHzLPnc4piaQvhP2PrJzLPxjl/nPvUV1O8Oo4Qr5/kHZWzxQjLIpYMPEHS+sUwLJc1LrJJFxZOgMp4gu7mp7GjNK2QE1WL5Y+tkV61Ivf47xv4gmpn6rKJLNDDy2dN/7ZxJgXXE8QkKn5dhbaSMowVlAIVAPx7XROeQTsxn/DN4JlsvCwsLACbATi6WGj+uTtgkCAeT4SblQWf9e7eKUm/ruQLF/S22CuRxMkDklfWlMrNddjPYxe+p82O5u5kx4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aee7533-bd14-416b-4ba6-08d73aa4ad56
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 12:52:05.2246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IsC4Ma9Nc3F6rw5xuSo2zB0ierjla6Jx3YYngPEu5ATPhygi18L7IctTwGEeIS9Ite4xSC+NU+epxU5MxAcslA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3068
X-OriginatorOrg: synopsys.com
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 16, 2019 at 13:24:1, Andrew Murray <andrew.murray@arm.com>=20
wrote:

> On Mon, Sep 16, 2019 at 04:36:33PM +0530, Pankaj Dubey wrote:
> >=20
> >=20
> > > -----Original Message-----
> > > From: Andrew Murray <andrew.murray@arm.com>
> > > Sent: Monday, September 16, 2019 3:46 PM
> > > To: Pankaj Dubey <pankaj.dubey@samsung.com>
> > > Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > jingoohan1@gmail.com; gustavo.pimentel@synopsys.com;
> > > lorenzo.pieralisi@arm.com; bhelgaas@google.com; Anvesh Salveru
> > > <anvesh.s@samsung.com>
> > > Subject: Re: [PATCH v2] PCI: dwc: Add support to add GEN3 related
> > equalization
> > > quirks
> > >=20
> > > On Fri, Sep 13, 2019 at 04:09:50PM +0530, Pankaj Dubey wrote:
> > > > From: Anvesh Salveru <anvesh.s@samsung.com>
> > > >
> > > > In some platforms, PCIe PHY may have issues which will prevent link=
up
> > > > to happen in GEN3 or higher speed. In case equalization fails, link
> > > > will fallback to GEN1.
> > > >
> > > > DesignWare controller gives flexibility to disable GEN3 equalizatio=
n
> > > > completely or only phase 2 and 3 of equalization.
> > > >
> > > > This patch enables the DesignWare driver to disable the PCIe GEN3
> > > > equalization by enabling one of the following quirks:
> > > >  - DWC_EQUALIZATION_DISABLE: To disable GEN3 equalization all phase=
s
> > > >  - DWC_EQ_PHASE_2_3_DISABLE: To disable GEN3 equalization phase 2 &=
 3
> > > >
> > > > Platform drivers can set these quirks via "quirk" variable of "dw_p=
cie"
> > > > struct.
> > > >
> > > > Signed-off-by: Anvesh Salveru <anvesh.s@samsung.com>
> > > > Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> > > > ---
> > > > Patchset v1 can be found at:
> > > >  - 1/2: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lkml=
.org_lkml_2019_9_10_443&d=3DDwIBAg&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3DbkWxpLoW-=
f-E3EdiDCCa0_h0PicsViasSlvIpzZvPxs&m=3DMtEKKeJsQvi2UM1eSZUv2vPLLxrYU0aI1Ry4=
ICIDaiQ&s=3Ds_nPmMNbQFswYRxQgBkeg4H9J_0FEtzRE-0AruC5WI4&e=3D=20
> > > >  - 2/2: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lkml=
.org_lkml_2019_9_10_444&d=3DDwIBAg&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3DbkWxpLoW-=
f-E3EdiDCCa0_h0PicsViasSlvIpzZvPxs&m=3DMtEKKeJsQvi2UM1eSZUv2vPLLxrYU0aI1Ry4=
ICIDaiQ&s=3DkkfdwcX6bYcLrnJSgw_GcMMGAjnDTMtN2v6svWuANpk&e=3D=20
> > > >
> > > > Changes w.r.t v1:
> > > >  - Squashed two patches from v1 into one as suggested by Gustavo
> > > >  - Addressed review comments from Andrew
> > > >
> > > >  drivers/pci/controller/dwc/pcie-designware.c | 12 ++++++++++++
> > > > drivers/pci/controller/dwc/pcie-designware.h |  9 +++++++++
> > > >  2 files changed, 21 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c
> > > > b/drivers/pci/controller/dwc/pcie-designware.c
> > > > index 7d25102..97fb18d 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > > @@ -466,4 +466,16 @@ void dw_pcie_setup(struct dw_pcie *pci)
> > > >  		break;
> > > >  	}
> > > >  	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> > > > +
> > > > +	if (pci->quirk & DWC_EQUALIZATION_DISABLE) {
> > > > +		val =3D dw_pcie_readl_dbi(pci, PCIE_PORT_GEN3_RELATED);
> > > > +		val |=3D PORT_LOGIC_GEN3_EQ_DISABLE;
> > > > +		dw_pcie_writel_dbi(pci, PCIE_PORT_GEN3_RELATED, val);
> > > > +	}
> > > > +
> > > > +	if (pci->quirk & DWC_EQ_PHASE_2_3_DISABLE) {
> > > > +		val =3D dw_pcie_readl_dbi(pci, PCIE_PORT_GEN3_RELATED);
> > > > +		val |=3D PORT_LOGIC_GEN3_EQ_PHASE_2_3_DISABLE;
> > > > +		dw_pcie_writel_dbi(pci, PCIE_PORT_GEN3_RELATED, val);
> > > > +	}
> > > >  }
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.h
> > > > b/drivers/pci/controller/dwc/pcie-designware.h
> > > > index ffed084..e428b62 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > > > @@ -29,6 +29,10 @@
> > > >  #define LINK_WAIT_MAX_IATU_RETRIES	5
> > > >  #define LINK_WAIT_IATU			9
> > > >
> > > > +/* Parameters for GEN3 related quirks */
> > > > +#define DWC_EQUALIZATION_DISABLE	BIT(1)
> > > > +#define DWC_EQ_PHASE_2_3_DISABLE	BIT(2)
> > > > +
> > > >  /* Synopsys-specific PCIe configuration registers */
> > > >  #define PCIE_PORT_LINK_CONTROL		0x710
> > > >  #define PORT_LINK_MODE_MASK		GENMASK(21, 16)
> > > > @@ -60,6 +64,10 @@
> > > >  #define PCIE_MSI_INTR0_MASK		0x82C
> > > >  #define PCIE_MSI_INTR0_STATUS		0x830
> > > >
> > > > +#define PCIE_PORT_GEN3_RELATED		0x890
> > >=20
> > > I hadn't noticed this in the previous version - what is the proper na=
me
> > for this
> > > register? Does it end in _RELATED?
> >=20
> > As per SNPS databook the name of the register is "GEN3_RELATED_OFF". It=
 is
> > port logic register so, to keep similarity with other port logic regist=
ers
> > in this file we named it as "PCIE_PORT_GEN3_RELATED".=20
>=20
> OK.
>=20
> Reviewed-by: Andrew Murray <andrew.murray@arm.com>
>=20
> Also is the SNPS databook publicly available? I'd be interested in readin=
g
> it.

The databook isn't openly available, sorry.

Gustavo

>=20
> Thanks,
>=20
> Andrew Murray
>=20
> >=20
> > >=20
> > > Thanks,
> > >=20
> > > Andrew Murray
> > >=20
> > > > +#define PORT_LOGIC_GEN3_EQ_PHASE_2_3_DISABLE	BIT(9)
> > > > +#define PORT_LOGIC_GEN3_EQ_DISABLE		BIT(16)
> > > > +
> > > >  #define PCIE_ATU_VIEWPORT		0x900
> > > >  #define PCIE_ATU_REGION_INBOUND		BIT(31)
> > > >  #define PCIE_ATU_REGION_OUTBOUND	0
> > > > @@ -244,6 +252,7 @@ struct dw_pcie {
> > > >  	struct dw_pcie_ep	ep;
> > > >  	const struct dw_pcie_ops *ops;
> > > >  	unsigned int		version;
> > > > +	unsigned int		quirk;
> > > >  };
> > > >
> > > >  #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pc=
ie,
> > > > pp)
> > > > --
> > > > 2.7.4
> > > >
> >=20


