Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEDAC135719
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2020 11:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgAIKha (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jan 2020 05:37:30 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:52960 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729151AbgAIKha (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jan 2020 05:37:30 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C1F0B404D4;
        Thu,  9 Jan 2020 10:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1578566249; bh=pje9qkt+ZdBW8GQ53tKIULBnthM7EhWrxkCQEKze480=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=J+8XmRfGVZJsobGgPLSmuTwZ1gbGgQA7YrVLTBPfSvQE9G0z6SWlZFJCHDkqr86Sa
         Tv+FIfKfYGAGcLwKrlDUgkESaHqfj3Izagj4j4XV/QobHy9AkO1hBnDfWZms2t5rzP
         2Q0BQNMLqag2/DgPvohruUcnwgYWCF9wfF43Vx1ZztAZX1pKf/DuQEK+Ard1ojgsQa
         AEIDPZmOgDb94o5O+JmcKlqGqxecUzQ+JV7OmwK3069a34UbA8jDttmWi3UlWxMXVM
         BcUxT5dcRjGa8bmvoDMYxArvtErFIqp8S74FSD3PvOJvJU1nri95G7Dlz8eLwVXSHc
         Nc46ZIzT41VTg==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 19E76A008E;
        Thu,  9 Jan 2020 10:37:28 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 9 Jan 2020 02:37:17 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 9 Jan 2020 02:37:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JR175jryQI+Yn1WncFarYUPZ3souSecWqkk8qVb7ypKcn0EXBQF2KWkoutcF7FHWy+Oo3z+6Na1jQfLQMPZZAKPlsGacfgTKkzl2ZyRYa/slSAN1QnmqvOfgzkMq8bKdUZ4z0WfnB7n714fuc/pSIHIhmqPf7zjHmj2Dl4VrCwdcHiYyqoZgXZOAGFHHeXBPCOYMqPbyuFfxoiulGc5D88ig8x3R2p895j8UjQbl8OE2/9hPclNdF5rSfkQHrKqiTefXjEmT7Ij+BUqQVOmhtso/r+hyrn11P3Va83vnjph1KR5wSQRKvWnYvj5aO2MIsaZJNi04w7GyqsV9mlgI/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxJMS3DhWp0Pxo434W6lnUGIuu8ZKlnDIXPUdgs3pUQ=;
 b=Kwb8zQll5yZ8ijPDCKMG4GRdTUSqy95nJmGDKowx+uocwzgUQfim9SlHNDOeUvXl3o/r/vA9sJWij7N0CIxOl5XtY79442NfvCSgBRc9YlGNL1VsFuW1lkTiADMwIAs68xt6QwpigcVRX/H932a3ge0g/WzvDb0qkyOC7Tymjae5cWCO6KOThrDgSTzJoQZMHIzZwenpQwUj/kJ6UqLpH8h5NlfTZJN6VHhpljGMR2+H3ZMmR7JZ4pt4wPgVp+3ZwponJ9xqs7RZHKZXCCwPDGDoE1g3PTAVflSbkZh9QGuveSD3NhK06cy64UKiDg1LATysGom3rZ0aTQ4VS1eL4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxJMS3DhWp0Pxo434W6lnUGIuu8ZKlnDIXPUdgs3pUQ=;
 b=mC3sfE98Fg4Fr4eu3EIJUxKikrRfUmgZcIPpSCtK01nxOyiWZOZZX2WAqRnun1pNOa9ZBUVp8qtN70SnKOV0P+QV8xw3fnatzadUN0Y3xpwQP5tpAjiRJ51CNu7KcD0jc6YGyecOJuHdDzumlEyMBrILSPKl/VvQrWK8nyk3qFA=
Received: from CH2PR12MB4007.namprd12.prod.outlook.com (52.132.247.78) by
 CH2PR12MB3928.namprd12.prod.outlook.com (52.132.244.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Thu, 9 Jan 2020 10:37:14 +0000
Received: from CH2PR12MB4007.namprd12.prod.outlook.com
 ([fe80::f0e2:26d5:2de4:a4b7]) by CH2PR12MB4007.namprd12.prod.outlook.com
 ([fe80::f0e2:26d5:2de4:a4b7%6]) with mapi id 15.20.2602.017; Thu, 9 Jan 2020
 10:37:14 +0000
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Shawn Guo <shawn.guo@linaro.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Pratyush Anand" <pratyush.anand@gmail.com>,
        Zaihai Yu <yuzaihai@hisilicon.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] PCI: dwc: Separate CFG0 and CFG1 into different ATU
 regions
Thread-Topic: [PATCH] PCI: dwc: Separate CFG0 and CFG1 into different ATU
 regions
Thread-Index: AQHVxrM2VgaKtZy4DEuFjdLeK+xovafiI44A
Date:   Thu, 9 Jan 2020 10:37:14 +0000
Message-ID: <CH2PR12MB40073FCB953227A37F7A1A91DA390@CH2PR12MB4007.namprd12.prod.outlook.com>
References: <20200109060657.1953-1-shawn.guo@linaro.org>
In-Reply-To: <20200109060657.1953-1-shawn.guo@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLWZkZmIyNTI3LTMyY2ItMTFlYS05ODllLWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFxmZGZiMjUyOS0zMmNiLTExZWEtOTg5ZS1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjI2MDkiIHQ9IjEzMjIzMDM5ODMxOTE5?=
 =?us-ascii?Q?NTM2MyIgaD0iM1hYRXhIZGdxRjRJYmsva3FsRHRUNXdtTUlRPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFE?=
 =?us-ascii?Q?ajlGTEEyTWJWQWFkYkoxU3QwSDMwcDFzblZLM1FmZlFPQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: 7211cf3e-8977-4715-7cd2-08d794efe450
x-ms-traffictypediagnostic: CH2PR12MB3928:
x-microsoft-antispam-prvs: <CH2PR12MB39286CACC7E10F91C6B6673ADA390@CH2PR12MB3928.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39850400004)(366004)(346002)(376002)(396003)(136003)(189003)(199004)(316002)(6506007)(54906003)(110136005)(7696005)(5660300002)(53546011)(8936002)(81156014)(4326008)(86362001)(186003)(8676002)(81166006)(26005)(2906002)(71200400001)(66946007)(66476007)(9686003)(52536014)(76116006)(33656002)(478600001)(55016002)(66446008)(66556008)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR12MB3928;H:CH2PR12MB4007.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0qNV39kMSV6LiqLWvBAKzEZ3vkPQkN4K9zbG9Q/nV4/MAbxcScu20wIfRvjMoF1icMU6NbAOvhzAQXCS+5KZpsWa9FKdLmR4ZXuhzTyketxhrDsy0KMGXCco0DjfCPZB2DxYTL361w9A+rIateGE2smaQam2VVKrzQZ5iyMbNe+wLcHdrfxKQ0Z44YFZt0aiA+iRhhhS4liOn9JUoTndQsHDMtvsv22cTnnCBvYYgZS7g74KfKIzR03FS0WLqPkOgQACOx9+umZ0V1UkNU223bLFnp++KCbQLQRKLICyNOyIFOONhz+2EHoC3AB8P1qwA2KlEjUT/jlHUdq/BRIcLxoT+Z9z8Cl5RcFO+t2Tkmmxq7p6CQyrgh4ZWPhDI8Ai9sLXp7iZHv7WlBHnQdJqVPLyefGFXMtOlSeqxkmY04ZCMjKWViR+V6fIa3v8wSF2
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7211cf3e-8977-4715-7cd2-08d794efe450
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 10:37:14.2660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gWrPMwa7BCIdIs5w13yPvILOfmPcLqIjZajdIshm23MA/3QpzWUIcFCgtKgpKeItlv8ZkZ0O90p/+qz0rNJaig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3928
X-OriginatorOrg: synopsys.com
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Shawn,

On Thu, Jan 9, 2020 at 6:6:57, Shawn Guo <shawn.guo@linaro.org> wrote:

> Some platform has 4 (or more) viewports.  In that case, CFG0 and CFG1

Remove double space before "In that..."=20

> can be separated into different ATU regions.
>=20
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c    | 16 +++++++++++++++-
>  drivers/pci/controller/dwc/pcie-designware.h     |  1 +
>  2 files changed, 16 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/=
pci/controller/dwc/pcie-designware-host.c
> index 0f36a926059a..504d2a192bba 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -532,6 +532,7 @@ static int dw_pcie_access_other_conf(struct pcie_port=
 *pp, struct pci_bus *bus,
>  	u64 cpu_addr;
>  	void __iomem *va_cfg_base;
>  	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> +	int index =3D PCIE_ATU_REGION_INDEX1;
> =20
>  	busdev =3D PCIE_ATU_BUS(bus->number) | PCIE_ATU_DEV(PCI_SLOT(devfn)) |
>  		 PCIE_ATU_FUNC(PCI_FUNC(devfn));
> @@ -548,7 +549,20 @@ static int dw_pcie_access_other_conf(struct pcie_por=
t *pp, struct pci_bus *bus,
>  		va_cfg_base =3D pp->va_cfg1_base;
>  	}
> =20
> -	dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX1,
> +	if (pci->num_viewport >=3D 4) {
> +		/*
> +		 * If there are 4 (or more) viewports, we can separate
> +		 * CFG0 and CFG1 into different ATU regions:
> +		 *  - region0: MEM
> +		 *  - region1: CFG0
> +		 *  - region2: IO
> +		 *  - region3: CFG1
> +		 */
> +		if (type =3D=3D PCIE_ATU_TYPE_CFG1)
> +			index =3D PCIE_ATU_REGION_INDEX3;
> +	}
> +
> +	dw_pcie_prog_outbound_atu(pci, index,
>  				  type, cpu_addr,
>  				  busdev, cfg_size);
>  	if (write)
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/c=
ontroller/dwc/pcie-designware.h
> index 5a18e94e52c8..86225804f1e7 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -63,6 +63,7 @@
>  #define PCIE_ATU_VIEWPORT		0x900
>  #define PCIE_ATU_REGION_INBOUND		BIT(31)
>  #define PCIE_ATU_REGION_OUTBOUND	0
> +#define PCIE_ATU_REGION_INDEX3		0x3
>  #define PCIE_ATU_REGION_INDEX2		0x2
>  #define PCIE_ATU_REGION_INDEX1		0x1
>  #define PCIE_ATU_REGION_INDEX0		0x0
> --=20
> 2.17.1

With the description fix,

Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>


