Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4A826BFE7
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 10:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgIPIyQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 04:54:16 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:59844 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726068AbgIPIyM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Sep 2020 04:54:12 -0400
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3F52AC033D;
        Wed, 16 Sep 2020 08:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1600246450; bh=fZiGVnwnQwKbOsytf0ymY2kAvg/aLHKFgLePByre9rE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=TlUugnegT3lV4EfKVMRBQJYWUKNiXMY7paA1lN8b4iy31eBs6jOG9cN1X9CEYTOj1
         Q4x7nKH1AdeR0vlKBcTgyb30aG5MYoFio2bMFhrNRU7YDq+QrT/lkb2C3kDTX6D6g3
         1zgSYAh2mWLM1TyD+RskOwnF/LbrmhjIQDcfpY8yoqirbKfY1FTlIHyNSLeOUXuR/x
         //HNrUnRu8+4v7E39n4jaQIFkP+oF/qPCldOWDttR7nKqpkNwR2aJ92Yl/1emZbIiS
         Md122ozYljiREJlCz2z7Q2PH6vCCTy0MKdTkqX5Tg1pNNBMfSu722Xoj8m0BsXKlIe
         fP8WYuJAqMlog==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id C5538A0070;
        Wed, 16 Sep 2020 08:54:09 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 73F2C400AD;
        Wed, 16 Sep 2020 08:54:09 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=gustavo@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="cQNOh9tM";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/jmv2ISrff5BXBhMLQiHeUNuSO1D0nFd/Gl+WXWXSufFNa9Ikz7ImBSVm6N/Lr0sQ9mkgtTJdlRc+Fx7gCUKDk8ruxvu0LT0ybiJbtGwAALwo5yYDDzBeToS3P5K4TUXgUmhhHYh5VfNQivdntQeMaovS/gN6foR0H3K0CQ71RsdJ6jAZu+Vs99uLr/iKPt3IhT6HB5YXUHXOCnxjzo5rKp0tW18+0/ksE9jQxshBSb3+PC/LDS+IzLEVEQruqpFA8EuL3kU3uCasWVU1wkmE4AP+tHCNW5+L2MVVY3PD5xmikjGftXlYpCpf4HhYwPDEfnEa57y6GvnKTf7j6aSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xj6+hJzCEn2PZPWcnY7NseW+8aiJI7UX9FI+R3STRuQ=;
 b=DNkqZwByfjHLS34RHqr/yfOzcFox/jgQfI+nH0xSpU8LlqKhdFVerZTPxW+9mzxjkZlrVvY2VTSMbHQCYte2mhblAvON/M5pjlynF21zU0GToW6NsMQtAfhMmFgzE56QU9COMncLhLB+IUIQ7dGPOCuDt0LYjW6YebVqONw6OG2aOKFPP3ttiIBBy0mc07uvrnAO6ovPE6YD36gUzlJzq8vhvkzcb4yQMOZYKLT9l5Cbcdxk1FTS91xLevYVnqBt82ttvLkaeW6T7IN6BG3AA4DlvowFdI8bOBrBUpSDe24lSfnkA5qiXQiDfUU3RzDu1Wdx53+F6FacRAQ7xIHRnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xj6+hJzCEn2PZPWcnY7NseW+8aiJI7UX9FI+R3STRuQ=;
 b=cQNOh9tMShu/k4+4uegDh2Xho3dkDj3Cju/RuAi1ewvEEtB7HCgAP23GI/k5N876j88R4J9L9c3mjwoA2N+067IMG708kICch9K8/8z3zxIpVLWrf6tTqZzY2ehE1CvhDzP5cSXV97fqtdBc6cLw++nteWo4xTgvQeX1i2loCzc=
Received: from DM5PR12MB1276.namprd12.prod.outlook.com (2603:10b6:3:79::18) by
 DM6PR12MB3194.namprd12.prod.outlook.com (2603:10b6:5:184::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Wed, 16 Sep 2020 08:54:07 +0000
Received: from DM5PR12MB1276.namprd12.prod.outlook.com
 ([fe80::742c:dafa:9df7:4f4]) by DM5PR12MB1276.namprd12.prod.outlook.com
 ([fe80::742c:dafa:9df7:4f4%10]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 08:54:07 +0000
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Rob Herring <robh@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: pcie-designware.c sparse warning
Thread-Topic: pcie-designware.c sparse warning
Thread-Index: AQHWhhnF8GpMCN+rk0meuimcQdmW1qlq//UQ
Date:   Wed, 16 Sep 2020 08:54:07 +0000
Message-ID: <DM5PR12MB1276B23D84E9C8D9F66BDAFBDA210@DM5PR12MB1276.namprd12.prod.outlook.com>
References: <20200908195343.GA627554@bjorn-Precision-5520>
In-Reply-To: <20200908195343.GA627554@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTJhOTY4OWY4LWY3ZmEtMTFlYS05OGNkLWE0NGNj?=
 =?us-ascii?Q?OGU5Y2YwNlxhbWUtdGVzdFwyYTk2ODlmOS1mN2ZhLTExZWEtOThjZC1hNDRj?=
 =?us-ascii?Q?YzhlOWNmMDZib2R5LnR4dCIgc3o9IjU2NTgiIHQ9IjEzMjQ0NzIwMDQzOTQ5?=
 =?us-ascii?Q?NjgzMCIgaD0iemRwcU5nR3RpYktkakpzQ1ppek94VWc1bVlFPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFC?=
 =?us-ascii?Q?KzhMRHRCb3pXQVZBSHovMjhWYVczVUFmUC9ieFZwYmNPQUFBQUFBQUFBQUFB?=
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
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [89.155.14.32]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf454e04-beb3-49e0-bf51-08d85a1e122e
x-ms-traffictypediagnostic: DM6PR12MB3194:
x-microsoft-antispam-prvs: <DM6PR12MB319435C28931B1480BBB3FFFDA210@DM6PR12MB3194.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:341;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vg4HSp8pZ4E9bVBrKOmTCd0DkFpArfLz+/m3qyPE5dgXiFjSb2VGPnFbpXSkqHNO2ZZ++e4/PHC55aZ3SaGGbCNqOrm/1xyuhWaFQQVQ8ZG33bkUUruncoITZOk+uVu48930DCwMU9FUBExeVPoMnJJsbOtfw0df//LlzJ5z9IJBsFfCW5Rk4AzSGRDmvawp4MkAVas6htcsGymTo7UfTO/l0U1dHTwQxyuq2w+PekECBcr86T9s7V5GsZt/s4AXJCkC39F3UWH0NJ8/gnBZxBsfa/wT3W948Zc5ypBPsPooe7gBg2S0QtRbNNJLCx0LJ/BaXxSMj6VD67TXVqZdgwKS561f7VIbJdcpLAoiGOozCjG2Z7btnFugd5lOw5Dz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1276.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(39860400002)(136003)(396003)(55016002)(5660300002)(3480700007)(66476007)(110136005)(64756008)(186003)(66946007)(478600001)(66446008)(76116006)(8936002)(2906002)(52536014)(86362001)(66556008)(9686003)(6506007)(26005)(83380400001)(8676002)(71200400001)(316002)(33656002)(53546011)(4326008)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: oCL0h7GpSFS8WnnqQXziboLUuI5bFdC8tLjKGqyfm6KAe1wHvt0Vmuax6TSd0ZsUafev1wetLLifyXqqRme0gYeJR8sxABGRuE6yNV+Q0R4pVB4pp4mmdDwVPrp2bdJtyAXTp4QHpI/C1hn/gBTEzfCY5qkH3v71NMue2qbZSLSNKluzM37DVxdrvJo4dHF6AujG05u7OhAqya8izxIMiurayQuIYD+FZm4UueG/3o2L33vIyzutvg4Whio5PU17vUsDt9HIZ4szsMYWNQXm8RlcATw+521C6EGd2scR++ow8IMKiOgPvdQhN/v7F4G5hYDlY1H6qSubUIADGli2oc4m1TWi8GljvN4NkhWyXTEWRsVu1l8C4sDhxzkLBHvloxvewHz6srxZ9UDzxyIyl5f/rKGOsmlPGOpzuWZfh2+WN/1VOXx8rxPvzPgAD1JAGzVjRkeYgdx6qQgWrVYUY6NUVdMj33O6/eYNTns7/xV+hy6F2RyD2kbQ6VIjUsC2IiDmoh1BuxjJKP7R2RT4XFyLMEfAM4erQpvKlgyHuxcMUV/2E5gMhF3G0MDmLREJV00URjXuViBLZWjGIF6x5B66Dm+FKGnS2BBMiiS1+pIObBw+cO75hBBtQUWtiKjUVfr28vXEmB6lImcQ8mcUQg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1276.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf454e04-beb3-49e0-bf51-08d85a1e122e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2020 08:54:07.1408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hO4X9wXhNOnSMJqEOh2hYuvgXVxyrVZrwtQTw9pgzM6UECO9BAxNxr36Z/L2zRzWSW64LsgiuGYGoC68NEHrLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3194
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

I've ran the sparse tool on your "next" branch, but I don't see the error=20
that you pointed out.

BTW I'm using the latest development version of sparse retrieved from=20
[1].

Please check my output.

make C=3D2 drivers/pci/
  CHECK   scripts/mod/empty.c
  CALL    scripts/checksyscalls.sh
  CALL    scripts/atomic/check-atomics.sh
  DESCEND  objtool
  CHECK   drivers/pci/access.c
  CHECK   drivers/pci/bus.c
  CHECK   drivers/pci/probe.c
  CHECK   drivers/pci/host-bridge.c
  CHECK   drivers/pci/remove.c
  CHECK   drivers/pci/pci.c
drivers/pci/pci.c:1001:13: warning: restricted pci_power_t degrades to=20
integer
drivers/pci/pci.c:1001:21: warning: restricted pci_power_t degrades to=20
integer
drivers/pci/pci.c:1001:31: warning: restricted pci_power_t degrades to=20
integer
drivers/pci/pci.c:1001:39: warning: restricted pci_power_t degrades to=20
integer
drivers/pci/pci.c:1010:35: warning: restricted pci_power_t degrades to=20
integer
drivers/pci/pci.c:1010:54: warning: restricted pci_power_t degrades to=20
integer
drivers/pci/pci.c:1011:19: warning: restricted pci_power_t degrades to=20
integer
drivers/pci/pci.c:1011:37: warning: restricted pci_power_t degrades to=20
integer
drivers/pci/pci.c:1041:23: warning: invalid assignment: |=3D
drivers/pci/pci.c:1041:23:    left side has type unsigned short
drivers/pci/pci.c:1041:23:    right side has type restricted pci_power_t
drivers/pci/pci.c:1046:57: warning: restricted pci_power_t degrades to=20
integer
drivers/pci/pci.c:1068:28: warning: incorrect type in assignment=20
(different base types)
drivers/pci/pci.c:1068:28:    expected restricted pci_power_t [usertype]=20
current_state
drivers/pci/pci.c:1068:28:    got int
drivers/pci/pci.c:1117:36: warning: incorrect type in assignment=20
(different base types)
drivers/pci/pci.c:1117:36:    expected restricted pci_power_t [usertype]=20
current_state
drivers/pci/pci.c:1117:36:    got int
drivers/pci/pci.c:1295:13: warning: restricted pci_power_t degrades to=20
integer
drivers/pci/pci.c:1295:21: warning: restricted pci_power_t degrades to=20
integer
drivers/pci/pci.c:1297:18: warning: restricted pci_power_t degrades to=20
integer
drivers/pci/pci.c:1297:26: warning: restricted pci_power_t degrades to=20
integer
drivers/pci/pci.c:1320:13: warning: restricted pci_power_t degrades to=20
integer
drivers/pci/pci.c:1320:22: warning: restricted pci_power_t degrades to=20
integer
drivers/pci/pci.c:1327:46: warning: restricted pci_power_t degrades to=20
integer
drivers/pci/pci.c:1327:54: warning: restricted pci_power_t degrades to=20
integer
drivers/pci/pci.c:1870:36: warning: incorrect type in assignment=20
(different base types)
drivers/pci/pci.c:1870:36:    expected restricted pci_power_t [usertype]=20
current_state
drivers/pci/pci.c:1870:36:    got int
drivers/pci/pci.c:2266:44: warning: restricted pci_power_t degrades to=20
integer
drivers/pci/pci.c:2567:61: warning: restricted pci_power_t degrades to=20
integer
drivers/pci/pci.c:2568:45: warning: restricted pci_power_t degrades to=20
integer
drivers/pci/pci.c:2734:20: warning: restricted pci_power_t degrades to=20
integer
drivers/pci/pci.c:2734:38: warning: restricted pci_power_t degrades to=20
integer
drivers/pci/pci.c:2757:49: warning: restricted pci_power_t degrades to=20
integer
drivers/pci/pci.c:2757:67: warning: restricted pci_power_t degrades to=20
integer
drivers/pci/pci.c:4642:13: warning: invalid assignment: |=3D
drivers/pci/pci.c:4642:13:    left side has type unsigned short
drivers/pci/pci.c:4642:13:    right side has type restricted pci_power_t
drivers/pci/pci.c:4647:13: warning: invalid assignment: |=3D
drivers/pci/pci.c:4647:13:    left side has type unsigned short
drivers/pci/pci.c:4647:13:    right side has type restricted pci_power_t
  CHECK   drivers/pci/pci-driver.c
drivers/pci/pci-driver.c:497:42: warning: restricted pci_power_t degrades=20
to integer
drivers/pci/pci-driver.c:497:61: warning: restricted pci_power_t degrades=20
to integer
drivers/pci/pci-driver.c:698:28: warning: restricted pci_power_t degrades=20
to integer
drivers/pci/pci-driver.c:698:46: warning: restricted pci_power_t degrades=20
to integer
  CHECK   drivers/pci/search.c
  CHECK   drivers/pci/pci-sysfs.c
  CHECK   drivers/pci/rom.c
  CHECK   drivers/pci/setup-res.c
  CHECK   drivers/pci/irq.c
  CHECK   drivers/pci/vpd.c
  CHECK   drivers/pci/setup-bus.c
  CHECK   drivers/pci/vc.c
  CHECK   drivers/pci/mmap.c
  CHECK   drivers/pci/setup-irq.c
  CHECK   drivers/pci/pcie/portdrv_core.c
  CHECK   drivers/pci/pcie/portdrv_pci.c
  CHECK   drivers/pci/pcie/err.c
  CHECK   drivers/pci/pcie/aspm.c
  CHECK   drivers/pci/pcie/pme.c
  CHECK   drivers/pci/proc.c
  CHECK   drivers/pci/slot.c
  CHECK   drivers/pci/pci-acpi.c
drivers/pci/pci-acpi.c:1009:64: warning: restricted pci_power_t degrades=20
to integer
drivers/pci/pci-acpi.c:1013:17: warning: restricted pci_power_t degrades=20
to integer
  CHECK   drivers/pci/quirks.c
drivers/pci/quirks.c:2287:57: warning: restricted pci_power_t degrades to=20
integer
  CHECK   drivers/pci/msi.c
  CHECK   drivers/pci/pci-label.c

[1] git://git.kernel.org/pub/scm/devel/sparse/sparse.git

-Gustavo

On Tue, Sep 8, 2020 at 20:53:43, Bjorn Helgaas <helgaas@kernel.org>=20
wrote:

> FYI, got the following warning from "make C=3D2 drivers/pci/":
>=20
>   CHECK   drivers/pci/controller/dwc/pcie-designware.c
> drivers/pci/controller/dwc/pcie-designware.c:432:52: warning: cast trunca=
tes bits from constant value (ffffffff7fffffff becomes 7fffffff)
>=20
> This is on my "next" branch.


