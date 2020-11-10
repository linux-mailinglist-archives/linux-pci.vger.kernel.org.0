Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4A32AE425
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 00:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbgKJXg3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Nov 2020 18:36:29 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:59528 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726706AbgKJXg2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Nov 2020 18:36:28 -0500
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 578E6C00A7;
        Tue, 10 Nov 2020 23:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1605051387; bh=dlLJ0ZOOF9ixE0n3Wg5M1jfmQZIpOIjlDugJyr1gNqo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=PrN7Bg7IChtN6Q5J7vZbbtSj540hXmwsfsVQK0FK+5d8DVZ0HVFdQm2M8sLe/5mQH
         Ejgd7NsW6T1p30QwQyAmuBzHBc4moxO3UbW7gzFghKkO1NVyas9vIh/hDxXDLqsN7D
         SxASZ8LNeYjlWHi2+e0WbN9+2UqPsAuQEFrk6dUIn29QbF7uh47nMonkJJomMHrLfw
         /KpTmrKM7iZjaic0JPL6nw1kcQfUPVLwNRxeUdSRJnTzyS6prfBLeLBq8BTHq5Tcgt
         UroDt4qa/gOoxfQ/QiOCxxLvLf9LVM1DCWPMadyDloNBAq6qtNlJ9Ct7Tjae202ulh
         Sy9vSwYiF7TLQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 15176A0063;
        Tue, 10 Nov 2020 23:36:27 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id AE55B40143;
        Tue, 10 Nov 2020 23:36:26 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=gustavo@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="smLCC5+/";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lL7dkBKTLZDMG6WXBC/Ue8R/iJaifmIK/qIB4BJQKTW4v4U3dmYTrWNWld4SAK4X19KRuTuXRsjKyiOOEVMNpqWTVUmCxNlNmhmhIT+vLBCBsR5fj08fv/+LvXjzmuAzkKevzRv8H2ZCIx82DqGl8n7wxGt5KYEeCx6KnjwmzQe/UUv4B5bA1j2VahkrZZxAY8dM6Rx61HbpQd1Awb0aFP8Ct7Hxp7lX+tbE03HNDe1ZcmnOhJnmc2bAd2tmGnodJqm4CSxRx/wZi80Dp/IYZEeVq0zdpUbY/E0MvGVxPIHonAA2zhFPN8A8os4kvchUED308OMZHGQb/lHXK1K1vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhbN08EG9ksfpOuhe2HN6iSjWbT5m2Qr9zWBTadqk80=;
 b=bt1aqw6uiWMig4t/W/RXM7JYbyts7+cKysd8rpBuOO2KLIt9rcJB+Y32/47E8fGJnciR5ljV691cjSMEwP3qe/NsoAaDx/WhXTdf4g1v1cSCLoj+x6CibVyjoinCJs1JF6mR/COAcNywTGj3jPeyEsR8FbEnoTF8SqsUeynfSL5y3hkdcZUvfIiasn21iM9ys/5u6wtTJwsGW/Y7E+2hz+KEGJniqTDobVZ8MFH/MSkhz2+c9FJKyUu06q/I/CZvQcIcX3RPOuag3z6iBTjw4WjBDj6M6d3wt0IjFgtYyHJ5HmzEKQJP0FQn8cxJwZxAAHKIyHlRk8tM4/oNhywfkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhbN08EG9ksfpOuhe2HN6iSjWbT5m2Qr9zWBTadqk80=;
 b=smLCC5+/8MM1ROcYPVaYpt51++ylypKZf1C96M7S5xNEoIw0evknQ4YS71hpTjq8nmTwy94BpVUFvnkrVlvBH6EMbFge/05foS2f5CaRei6c8vBQD5YM9RHmcmmKf0WHXFdaMV2AxFUtIFCKdNl5Fmt0OXS+SoH/kgqnxJJnijU=
Received: from DM5PR12MB1835.namprd12.prod.outlook.com (2603:10b6:3:10c::9) by
 DM6PR12MB4959.namprd12.prod.outlook.com (2603:10b6:5:208::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21; Tue, 10 Nov 2020 23:36:25 +0000
Received: from DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::48e2:11e1:d2f:d12f]) by DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::48e2:11e1:d2f:d12f%8]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 23:36:25 +0000
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>
Subject: RE: New Defects reported by Coverity Scan for Linux
Thread-Topic: New Defects reported by Coverity Scan for Linux
Thread-Index: AQHWt4VFEBCU7cZ0OUuvCuyULH8Dk6nCA92g
Date:   Tue, 10 Nov 2020 23:36:24 +0000
Message-ID: <DM5PR12MB183506CDEA67A7A65B0F1F29DAE90@DM5PR12MB1835.namprd12.prod.outlook.com>
References: <20201110171641.GA679781@bjorn-Precision-5520>
In-Reply-To: <20201110171641.GA679781@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTg5ZmU0NGY0LTIzYWQtMTFlYi05OGQ2LWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFw4OWZlNDRmNS0yM2FkLTExZWItOThkNi1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjE4NjgiIHQ9IjEzMjQ5NTI0OTgyOTky?=
 =?us-ascii?Q?MzA3NSIgaD0ibTlnNjk5Z3g2YnRQckY3dFg1RVppYVhOVzhzPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFB?=
 =?us-ascii?Q?RENZcE11cmZXQVh4MzQ3UVM5UUhvZkhmanRCTDFBZWdPQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: 4b77fa0a-18c7-448a-19ee-08d885d17036
x-ms-traffictypediagnostic: DM6PR12MB4959:
x-microsoft-antispam-prvs: <DM6PR12MB4959BC6636DDEFFB0A418EBFDAE90@DM6PR12MB4959.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ai9ugzyZHlqh0tMzexJ91DUyPt8W3W9SafE9ZqPIDpSZg382TlBzQm7H8XdfVt2kMhcNZHerIunQD9TWTaUScwjhJl2LpWE98DwtFHH/rQ38A9zsviVPTxiosjYuKnC/NXqJyZKm1pulx9CRGZmJltL34+nX6k/aXYOg4xvo9FlxATs6LhEF0dQ+ebuIx4aT/HQUyxQc//n+gahyovheXLijaxT/ytvsTuPFsi58O9aTG8caBRu5IJCh+JS4VydELPpw8UAYl+zhq1xHMd7FeN3DVWUos44SN2hFRbEEcRKeDEIneIFEpEDj19EvE6f9WQHKfAHQzyhsZAbL4peMig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1835.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(376002)(346002)(366004)(136003)(396003)(8676002)(110136005)(66476007)(66556008)(7696005)(6506007)(33656002)(8936002)(53546011)(54906003)(64756008)(2906002)(9686003)(316002)(71200400001)(478600001)(76116006)(66946007)(66446008)(52536014)(5660300002)(26005)(186003)(83380400001)(55016002)(4326008)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: xlQvPUETo0BLOliFiHN0S/p2/t6X/1iEIDYzCR9PLxlg9ByXeoIJnIU33BJpStB+BbV9URhWO2BnUpO0XMY7RpLXMEZIV5OOBUBE/88t2WH418/rcf6KplFTzyW0jHVwRr5KAcs9Bz6sLVLr//FI4MseQaM0tBFnFWpS1PQO7snzVyr4+zhKbP9JZLoSazsUvLJeFJawHdiNbdPDtXnU70kMEn/yR3391lUCuOZ3USzJQ4Z5SEiL1imw/6VMyCnOlb9hOvtn3/TfLtkfrMHwddGc0TILYG/iBlGxTa9sycwt/E2UPDp9C0a8czgfCFOle/Ti/d1Q4KWqFDnKf4QCJGJxrvMvtVQAhXlKIneXtfPaaLxLZA/HeKWSsexl2Sw46wrEEobr/vQQPq8F8ldA1ktT6xf4tuU7fwOl8XUhOuiWMUMFKqP/zdmPRmbXmjqNzCfF7fVI3oS6olj1eGds3z7sIbsT8EBqZMIZjs9QyY+i4MtuDqd2zQDKfDLzC+Z4qzfVVWndcuGiOQEIe1P3FD+ojvhCt5cPaNnjYTLU6TV2trpL2Yr8GM7mO91Q9zeB/2JY+U/JM00x50hvjYGAd7an28SHZiQXCSo7qwJMQQWWBLN7gC1/IHnNXxxAJzNq0PCL2uVgFiY5pCCETgXOhg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b77fa0a-18c7-448a-19ee-08d885d17036
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 23:36:24.9378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WL9eh4v9LFqtt1N0pR7Ha1LcStu6jZyYB3gjaxpKtS41AmiU7cQfJyUPtUTMBEGlfv3LlqzEdH6AkQ1XQBT2xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4959
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 10, 2020 at 17:16:41, Bjorn Helgaas <helgaas@kernel.org>=20
wrote:

> New Coverity complaint about v5.10-rc3, resulting from 9fff3256f93d
> ("PCI: dwc: Restore ATU memory resource setup to use last entry").
>=20
> I didn't try to figure out if this is real or a false positive, so
> just FYI.
>=20
> ----- Forwarded message from scan-admin@coverity.com -----
>=20
> Date: Mon, 09 Nov 2020 11:13:37 +0000 (UTC)
> From: scan-admin@coverity.com
> To: bjorn@helgaas.com
> Subject: New Defects reported by Coverity Scan for Linux
> Message-ID: <5fa924618fb3b_a62932acac7322f5033088@prd-scan-dashboard-0.ma=
il>
>=20
>=20
> ** CID 1469110:  Null pointer dereferences  (FORWARD_NULL)
> /drivers/pci/controller/dwc/pcie-designware-host.c: 596 in dw_pcie_setup_=
rc()
>=20
>=20
> _________________________________________________________________________=
_______________________________
> *** CID 1469110:  Null pointer dereferences  (FORWARD_NULL)
> /drivers/pci/controller/dwc/pcie-designware-host.c: 596 in dw_pcie_setup_=
rc()
> 590    =20
> 591     		/* Get last memory resource entry */
> 592     		resource_list_for_each_entry(tmp, &pp->bridge->windows)
> 593     			if (resource_type(tmp->res) =3D=3D IORESOURCE_MEM)

Can the pp->bridge->windows list be empty in a typical use case?

> 594     				entry =3D tmp;
> 595    =20
> >>>     CID 1469110:  Null pointer dereferences  (FORWARD_NULL)
> >>>     Dereferencing null pointer "entry".
> 596     		dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX0,
> 597     					  PCIE_ATU_TYPE_MEM, entry->res->start,
> 598     					  entry->res->start - entry->offset,
> 599     					  resource_size(entry->res));
> 600     		if (pci->num_viewport > 2)
> 601     			dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX2,


