Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 947ECFADD5
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2019 10:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfKMJ7v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Nov 2019 04:59:51 -0500
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:54712 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726339AbfKMJ7v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Nov 2019 04:59:51 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id ECB9BC04A7;
        Wed, 13 Nov 2019 09:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1573639189; bh=EPafUyamXB6I05dQjZ/S0xT6/yVy4xI69Q55TpuL8J8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=AmxoAmCsnUz+OrhmXuCP68F/yCNDcqdCFbCuZcO0FJhhwxuL98nQAxluTeRaSmppC
         wRgqQZKzGmOTjvgW55xl1sCAdfuwtSloDugLgYKRqYnVi6fjWuppDuOZzuHVevLRSJ
         0C3vlBdD1hPzWWiHRTZH3JASlr3x9548eq8GCVt/DK6WPI/KJgviuRNlZ7dfuCc6fS
         BioTnxvL0jB6z2ZZEQuNJbDWciMZTxC4FZIx5iJ7RdPizcZ/wYoOfz1Lgplt/FDWuC
         K9G6CRozAgck9voQqqaCBihO6zSoQwMwej07rN8M+hSrDestxhumS8VPP/c1oPQt0o
         16w1v+iA/B/5Q==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 5CA87A0085;
        Wed, 13 Nov 2019 09:59:48 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 13 Nov 2019 01:59:48 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 13 Nov 2019 01:59:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgULvo0HBQwu4fscl3od/Qxxh0sSj9WUrl6LF5zHQtqPJcVCpjv5firVVw0dLTEvzaZQyb6iyaulSznhmgLJUis0MUgZrqr4bwDOGRdBwosPvZoqYp/VgsJzSlfjJPJsq4CxMns1ABQLWoOJ2hP6tuvI/zCCm2pq5q+IC5g1O/pjXxES9UtMvrSqBcITHBT8p0pftANQowOzDyBoK9EmNWTiL8QL+Us1FAn1xqM6fybDeKOFnzu8r/fF26+5juVO97vjw3VgnBbyQ5o8cTpeFTEyshPmPHMubE/4PQ0d4kw9Z/sbgFWkV1jQW10RYOV7vT63WUAeLxV+0oP6t9jGGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xwyWEU7xOlewE4g6IgUWJkauV4+yLzFHo0PjSzz7GQ=;
 b=mfhVd40iVfGG+uQIsU5xPh7pZh+d0FKf7tFUud+k4C1sYc4fnBIsCNgwFwkjwTq6dyeWW34K27yom3bZy+WPJM4uTaUeal3bL0OVmGgaM06btczOLKk7HmCyg9wzE/0IUdLj8eAN/+0H5o87kysB7TtVxLXoSTEG7r9WaxU4ndbfEnLOY8sSnsOzxjnZSEM2K/MeyYmZzSWNGmUDw+Xm28mGofiDdn6w+xSMnrHjcq6CQLmkSkybjpWhSjG6dIbhbEE26OKKspo4kF0YsX8UFGkztUU9uDNejeao8J5gYd8XA5LZiXwkWPSg+yIyLPOEZivPan2LFDO1zUrqss5hMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xwyWEU7xOlewE4g6IgUWJkauV4+yLzFHo0PjSzz7GQ=;
 b=nHf5LoIHHpW71DyQzHjHcZMgel8df/K2f5ENJMfk/3yKDLZva4RhfIVV2ghVpVMYqCH1HJJtveHFsgjA8SrMWQ4QXHFg/PyVUuoWdHCXryS3nVwI6MBda0wYwsvC5KRmEJ5BdLLkLVgFST/vNO6rWgMrQdTkwM3vlBKWi9xtATI=
Received: from CH2PR12MB4007.namprd12.prod.outlook.com (52.132.247.78) by
 CH2PR12MB3973.namprd12.prod.outlook.com (52.132.246.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Wed, 13 Nov 2019 09:59:46 +0000
Received: from CH2PR12MB4007.namprd12.prod.outlook.com
 ([fe80::f951:ad0f:4f40:12e9]) by CH2PR12MB4007.namprd12.prod.outlook.com
 ([fe80::f951:ad0f:4f40:12e9%5]) with mapi id 15.20.2430.027; Wed, 13 Nov 2019
 09:59:46 +0000
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Dilip Kota <eswara.kota@linux.intel.com>,
        "gustavo.pimentel@synopsys.com" <Gustavo.Pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "martin.blumenstingl@googlemail.com" 
        <martin.blumenstingl@googlemail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cheol.yong.kim@intel.com" <cheol.yong.kim@intel.com>,
        "chuanhua.lei@linux.intel.com" <chuanhua.lei@linux.intel.com>,
        "qi-ming.wu@intel.com" <qi-ming.wu@intel.com>
Subject: RE: [PATCH v6 2/3] dwc: PCI: intel: PCIe RC controller driver
Thread-Topic: [PATCH v6 2/3] dwc: PCI: intel: PCIe RC controller driver
Thread-Index: AQHVmfMQseZrYbzrikCy/usecdU4RqeI3hOA
Date:   Wed, 13 Nov 2019 09:59:45 +0000
Message-ID: <CH2PR12MB40074C910983FF97DDCF8478DA760@CH2PR12MB4007.namprd12.prod.outlook.com>
References: <cover.1573613534.git.eswara.kota@linux.intel.com>
 <897ef494f39291797a92efb87a59961d36384019.1573613534.git.eswara.kota@linux.intel.com>
In-Reply-To: <897ef494f39291797a92efb87a59961d36384019.1573613534.git.eswara.kota@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTRkMzc5YWYzLTA1ZmMtMTFlYS05ODkzLWE0NGNj?=
 =?us-ascii?Q?OGU5Y2YwNlxhbWUtdGVzdFw0ZDM3OWFmNS0wNWZjLTExZWEtOTg5My1hNDRj?=
 =?us-ascii?Q?YzhlOWNmMDZib2R5LnR4dCIgc3o9IjI3NzQxIiB0PSIxMzIxODExMjc3ODM3?=
 =?us-ascii?Q?ODg4ODkiIGg9ImoyU0QwN1JNMnpxcFdhT3VJWHFsUkFSRkVaMD0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUJRSkFB?=
 =?us-ascii?Q?QlpNWkFQQ1pyVkFTdUp5UGNPcFlVZUs0bkk5dzZsaFI0T0FBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQUNrQ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBRUdJWXpRQUFBQUFBQUFBQUFBQUFBSjRBQUFCbUFHa0Fi?=
 =?us-ascii?Q?Z0JoQUc0QVl3QmxBRjhBY0FCc0FHRUFiZ0J1QUdrQWJnQm5BRjhBZHdCaEFI?=
 =?us-ascii?Q?UUFaUUJ5QUcwQVlRQnlBR3NBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1lBYndCMUFHNEFaQUJ5QUhrQVh3?=
 =?us-ascii?Q?QndBR0VBY2dCMEFHNEFaUUJ5QUhNQVh3Qm5BR1lBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVpnQnZBSFVBYmdCa0FISUFlUUJmQUhBQVlRQnlBSFFBYmdC?=
 =?us-ascii?Q?bEFISUFjd0JmQUhNQVlRQnRBSE1BZFFCdUFHY0FYd0JqQUc4QWJnQm1BQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJtQUc4?=
 =?us-ascii?Q?QWRRQnVBR1FBY2dCNUFGOEFjQUJoQUhJQWRBQnVBR1VBY2dCekFGOEFjd0Jo?=
 =?us-ascii?Q?QUcwQWN3QjFBRzRBWndCZkFISUFaUUJ6QUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHWUFid0IxQUc0QVpBQnlBSGtB?=
 =?us-ascii?Q?WHdCd0FHRUFjZ0IwQUc0QVpRQnlBSE1BWHdCekFHMEFhUUJqQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFD?=
 =?us-ascii?Q?QUFBQUFBQ2VBQUFBWmdCdkFIVUFiZ0JrQUhJQWVRQmZBSEFBWVFCeUFIUUFi?=
 =?us-ascii?Q?Z0JsQUhJQWN3QmZBSE1BZEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQm1B?=
 =?us-ascii?Q?RzhBZFFCdUFHUUFjZ0I1QUY4QWNBQmhBSElBZEFCdUFHVUFjZ0J6QUY4QWRB?=
 =?us-ascii?Q?QnpBRzBBWXdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdZQWJ3QjFBRzRBWkFCeUFI?=
 =?us-ascii?Q?a0FYd0J3QUdFQWNnQjBBRzRBWlFCeUFITUFYd0IxQUcwQVl3QUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFB?=
 =?us-ascii?Q?QUNBQUFBQUFDZUFBQUFad0IwQUhNQVh3QndBSElBYndCa0FIVUFZd0IwQUY4?=
 =?us-ascii?Q?QWRBQnlBR0VBYVFCdUFHa0FiZ0JuQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFC?=
 =?us-ascii?Q?ekFHRUFiQUJsQUhNQVh3QmhBR01BWXdCdkFIVUFiZ0IwQUY4QWNBQnNBR0VB?=
 =?us-ascii?Q?YmdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBSE1BWVFCc0FHVUFjd0Jm?=
 =?us-ascii?Q?QUhFQWRRQnZBSFFBWlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFB?=
 =?us-ascii?Q?QUFBQ0FBQUFBQUNlQUFBQWN3QnVBSEFBY3dCZkFHd0FhUUJqQUdVQWJnQnpB?=
 =?us-ascii?Q?R1VBWHdCMEFHVUFjZ0J0QUY4QU1RQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFB?=
 =?us-ascii?Q?QUJ6QUc0QWNBQnpBRjhBYkFCcEFHTUFaUUJ1QUhNQVpRQmZBSFFBWlFCeUFH?=
 =?us-ascii?Q?MEFYd0J6QUhRQWRRQmtBR1VBYmdCMEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFIWUFad0JmQUdzQVpR?=
 =?us-ascii?Q?QjVBSGNBYndCeUFHUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFB?=
 =?us-ascii?Q?QUFBQUFDQUFBQUFBQT0iLz48L21ldGE+?=
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gustavo@synopsys.com; 
x-originating-ip: [198.182.37.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fda9a896-1e4e-4d3c-1cb3-08d7682036ad
x-ms-traffictypediagnostic: CH2PR12MB3973:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB3973466DC1ED72FD2652FE4BDA760@CH2PR12MB3973.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:210;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(376002)(366004)(39860400002)(189003)(199004)(8676002)(256004)(110136005)(6436002)(66066001)(11346002)(54906003)(76176011)(2906002)(446003)(14444005)(81156014)(81166006)(2501003)(316002)(8936002)(55016002)(186003)(229853002)(9686003)(2201001)(7696005)(6116002)(486006)(3846002)(99286004)(25786009)(5660300002)(33656002)(478600001)(102836004)(26005)(476003)(66946007)(14454004)(64756008)(7416002)(66556008)(30864003)(76116006)(6506007)(86362001)(6246003)(71200400001)(66476007)(7736002)(71190400001)(305945005)(4326008)(53546011)(52536014)(74316002)(66446008)(921003)(1121003)(559001)(579004);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR12MB3973;H:CH2PR12MB4007.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hGP1U6of6uxmQ7/Y1NV9OVeVwFCL7J/fonAY1rrXdg4vK+6Dy3VBWy8mumml0KEly5JB8J6k75FmZgkeWCvQr2QHyLWqOTtA2Eqfxc8zI8soTwyu2W3rJ4KE7y/FdYNHmvq3Bl7pzi9p92aaImNVohMrHiH2c6tlumM77KBAICEMGDYttMSd2g7XAFKYV50VxDEdJiZd+cVLfHvdwXf0UCCS6T6S8nakhV/qqQUh5JS2tz/VW19YxNZVs4ZM2gy275k2DqMQ06b4h7KzuuTAva20dIOo0Gte1rEZOxPhPtNWj97xdQUHjbw6Zwm7M1ZuOQGdOF/oykKOUFD4ajIFI8z1wM+IRqScNj1UPU+DUDyFhPPYK9+IWLUESnkSY3vVjBeyoL4ZQEAHnUSUbitIyrXXEeKdRLHp37MCLV1PYaZOtF/GEKy0Nwnfa6AHgr7i
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fda9a896-1e4e-4d3c-1cb3-08d7682036ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 09:59:46.0242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZD+jDZn7pN1fQ7uiN+Fg3HMoWuztSsGQi5lIFhVgymwuhGYQ6mUE/v7kKxy5GD1uUhlCH2SBhqJopg0KT5GzUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3973
X-OriginatorOrg: synopsys.com
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 13, 2019 at 7:21:21, Dilip Kota <eswara.kota@linux.intel.com>=20
wrote:

> Add support to PCIe RC controller on Intel Gateway SoCs.
> PCIe controller is based of Synopsys DesignWare PCIe core.
>=20
> Intel PCIe driver requires Upconfigure support, Fast Training
> Sequence and link speed configurations. So adding the respective
> helper functions in the PCIe DesignWare framework.
> It also programs hardware autonomous speed during speed
> configuration so defining it in pci_regs.h.
>=20
> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> Reviewed-by: Andrew Murray <andrew.murray@arm.com>
> ---
> Changes on v6:
> 	Add Reviewed-by: Andrew Murray <andrew.murray@arm.com>
> 	Address review comments:
> 	  Remove extra space in Kconfig
> 	  Fix style indents in switch case
> 	  Apply mask for the n_fts argument in dw_pcie_link_set_n_fts()
> 	   to prevent the case of n_fts value having outside the mask bits
> 	  Update PORT_LOGIC_N_FTS to PORT_LOGIC_N_FTS_MASK
> 	  Update BUS_IATU_OFFS to BUS_IATU_OFFSET
> 	  Update RST_INTRVL_DFT_MS to RESET_INTERVAL_MS
> 	  Reduce local variables in pcie_update_bits()
> 	  Remove blank lines
> 	  Remove extra paranthesis during readl_poll_timeout() call
> 	  Add error handling for dw_pcie_find_capability() call
> 	  Add blank line before dev_info() in probe()
>=20
> Changes on v5:
> 	Use new, old variables in pcie_update_bits()
> 	Correct naming:
> 	  s/Designware/DesignWare
> 	  s/pcie/PCIe
> 	  s/pci/PCI
> 	  s/Hw/HW
> 	  Upconfig to Upconfigure
> 	Remove extra lines after the intel_pcie_max_speed_setup() def.
> 	Use pcie_link_speed[] and remove enum for pcie gen.
> 	Remove dw_pcie_link_speed_change() def.
> 	Remove "linux,pci-domain" parsing.
> 	Remove 'id' variable in intel_pcie_port structure.
> 	Remove extra spaces for lpp->link_gen =3D
> 	Correct the offset of PCI_EXP_LNKCTL2_HASD to 0x0020.
> 	Remove programming of RCB and CCC bits in PCI_EXP_LCTL reg.
> 	Remove programming Slot clock cfg in PCI_EXP_LSTS reg.
> 	Update the comments at num_viewport setting.
> 	Update the description in Kconfig.
> 	Get PCIe cap offset from the registers using dw_pcie_find_capability()
> 	Define pcie_cap_ofst var in intel_pcie_port struct to store the same.
> 	Remove the PCIE_CAP_OFST macro.
> 	Move intel_pcie_max_speed_setup() function to DesignWare framework,
> 	 defined as dw_pcie_link_set_max_speed()
> 	Set EXPORT_SYMBOL_GPL for the newer functions defined in
> 	  pcie-designware.c
>=20
> Changes on v4:
> 	Rename the driver naming and description to
> 	 "PCIe RC controller on Intel Gateway SoCs".
> 	Use PCIe core register macros defined in pci_regs.h
> 	 and remove respective local definitions.
> 	Remove PCIe core interrupt handling.
> 	Move PCIe link control speed change, upconfig and FTS.
> 	configuration functions to DesignWare framework.
> 	Use of_pci_get_max_link_speed().
> 	Mark dependency on X86 and COMPILE_TEST in Kconfig.
> 	Remove lanes and add n_fts variables in intel_pcie_port structure.
> 	Rename rst_interval variable to rst_intrvl in intel_pcie_port structure.
> 	Remove intel_pcie_mem_iatu() as it is already perfomed in dw_setup_rc()
> 	Move sysfs attributes specific code to separate patch.
> 	Remove redundant error handling.
> 	Reduce LoCs by doing variable initializations while declaration itself.
> 	Add extra line after closing parenthesis.
> 	Move intel_pcie_ep_rst_init() out of get_resources()
>=20
> changes on v3:
> 	Rename PCIe app logic registers with PCIE_APP prefix.
> 	PCIE_IOP_CTRL configuration is not required. Remove respective code.
> 	Remove wrapper functions for clk enable/disable APIs.
> 	Use platform_get_resource_byname() instead of
> 	  devm_platform_ioremap_resource() to be similar with DWC framework.
> 	Rename phy name to "pciephy".
> 	Modify debug message in msi_init() callback to be more specific.
> 	Remove map_irq() callback.
> 	Enable the INTx interrupts at the time of PCIe initialization.
> 	Reduce memory fragmentation by using variable "struct dw_pcie pci"
> 	  instead of allocating memory.
> 	Reduce the delay to 100us during enpoint initialization
> 	  intel_pcie_ep_rst_init().
> 	Call  dw_pcie_host_deinit() during remove() instead of directly
> 	  calling PCIe core APIs.
> 	Rename "intel,rst-interval" to "reset-assert-ms".
> 	Remove unused APP logic Interrupt bit macro definitions.
>  	Use dwc framework's dw_pcie_setup_rc() for PCIe host specific
> 	 configuration instead of redefining the same functionality in
> 	 the driver.
> 	Move the whole DT parsing specific code to intel_pcie_get_resources()
>=20
>  drivers/pci/controller/dwc/Kconfig           |  10 +
>  drivers/pci/controller/dwc/Makefile          |   1 +
>  drivers/pci/controller/dwc/pcie-designware.c |  57 +++
>  drivers/pci/controller/dwc/pcie-designware.h |  12 +
>  drivers/pci/controller/dwc/pcie-intel-gw.c   | 546 +++++++++++++++++++++=
++++++
>  include/uapi/linux/pci_regs.h                |   1 +
>  6 files changed, 627 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-intel-gw.c
>=20
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/=
dwc/Kconfig
> index 0ba988b5b5bc..fb6d474477df 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -82,6 +82,16 @@ config PCIE_DW_PLAT_EP
>  	  order to enable device-specific features PCI_DW_PLAT_EP must be
>  	  selected.
> =20
> +config PCIE_INTEL_GW
> +	bool "Intel Gateway PCIe host controller support"
> +	depends on OF && (X86 || COMPILE_TEST)
> +	select PCIE_DW_HOST
> +	help
> +	  Say 'Y' here to enable PCIe Host controller support on Intel
> +	  Gateway SoCs.
> +	  The PCIe controller uses the DesignWare core plus Intel-specific
> +	  hardware wrappers.
> +
>  config PCI_EXYNOS
>  	bool "Samsung Exynos PCIe controller"
>  	depends on SOC_EXYNOS5440 || COMPILE_TEST
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller=
/dwc/Makefile
> index b30336181d46..99db83cd2f35 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -3,6 +3,7 @@ obj-$(CONFIG_PCIE_DW) +=3D pcie-designware.o
>  obj-$(CONFIG_PCIE_DW_HOST) +=3D pcie-designware-host.o
>  obj-$(CONFIG_PCIE_DW_EP) +=3D pcie-designware-ep.o
>  obj-$(CONFIG_PCIE_DW_PLAT) +=3D pcie-designware-plat.o
> +obj-$(CONFIG_PCIE_INTEL_GW) +=3D pcie-intel-gw.o
>  obj-$(CONFIG_PCI_DRA7XX) +=3D pci-dra7xx.o
>  obj-$(CONFIG_PCI_EXYNOS) +=3D pci-exynos.o
>  obj-$(CONFIG_PCI_IMX6) +=3D pci-imx6.o
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/c=
ontroller/dwc/pcie-designware.c
> index 820488dfeaed..479e250695a0 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -14,6 +14,8 @@
> =20
>  #include "pcie-designware.h"
> =20
> +extern const unsigned char pcie_link_speed[];
> +
>  /*
>   * These interfaces resemble the pci_find_*capability() interfaces, but =
these
>   * are for configuring host controllers, which are bridges *to* PCI devi=
ces but
> @@ -474,6 +476,61 @@ int dw_pcie_link_up(struct dw_pcie *pci)
>  		(!(val & PCIE_PORT_DEBUG1_LINK_IN_TRAINING)));
>  }
> =20
> +void dw_pcie_upconfig_setup(struct dw_pcie *pci)
> +{
> +	u32 val;
> +
> +	val =3D dw_pcie_readl_dbi(pci, PCIE_PORT_MULTI_LANE_CTRL);
> +	val |=3D PORT_MLTI_UPCFG_SUPPORT;
> +	dw_pcie_writel_dbi(pci, PCIE_PORT_MULTI_LANE_CTRL, val);
> +}
> +EXPORT_SYMBOL_GPL(dw_pcie_upconfig_setup);
> +
> +void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
> +{
> +	u32 reg, val;
> +	u8 offset =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +
> +	reg =3D dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCTL2);
> +	reg &=3D ~PCI_EXP_LNKCTL2_TLS;
> +
> +	switch (pcie_link_speed[link_gen]) {
> +	case PCIE_SPEED_2_5GT:
> +		reg |=3D PCI_EXP_LNKCTL2_TLS_2_5GT;
> +		break;
> +	case PCIE_SPEED_5_0GT:
> +		reg |=3D PCI_EXP_LNKCTL2_TLS_5_0GT;
> +		break;
> +	case PCIE_SPEED_8_0GT:
> +		reg |=3D PCI_EXP_LNKCTL2_TLS_8_0GT;
> +		break;
> +	case PCIE_SPEED_16_0GT:
> +		reg |=3D PCI_EXP_LNKCTL2_TLS_16_0GT;
> +		break;
> +	default:
> +		/* Use hardware capability */
> +		val =3D dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
> +		val =3D FIELD_GET(PCI_EXP_LNKCAP_SLS, val);
> +		reg &=3D ~PCI_EXP_LNKCTL2_HASD;
> +		reg |=3D FIELD_PREP(PCI_EXP_LNKCTL2_TLS, val);
> +		break;
> +	}
> +
> +	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCTL2, reg);
> +}
> +EXPORT_SYMBOL_GPL(dw_pcie_link_set_max_speed);
> +
> +void dw_pcie_link_set_n_fts(struct dw_pcie *pci, u32 n_fts)
> +{
> +	u32 val;
> +
> +	val =3D dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
> +	val &=3D ~PORT_LOGIC_N_FTS_MASK;
> +	val |=3D n_fts & PORT_LOGIC_N_FTS_MASK;
> +	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> +}
> +EXPORT_SYMBOL_GPL(dw_pcie_link_set_n_fts);
> +
>  static u8 dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
>  {
>  	u32 val;
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/c=
ontroller/dwc/pcie-designware.h
> index 5a18e94e52c8..3b0be5cd9235 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -30,7 +30,12 @@
>  #define LINK_WAIT_IATU			9
> =20
>  /* Synopsys-specific PCIe configuration registers */
> +#define PCIE_PORT_AFR			0x70C
> +#define PORT_AFR_N_FTS_MASK		GENMASK(15, 8)
> +#define PORT_AFR_CC_N_FTS_MASK		GENMASK(23, 16)
> +
>  #define PCIE_PORT_LINK_CONTROL		0x710
> +#define PORT_LINK_DLL_LINK_EN		BIT(5)
>  #define PORT_LINK_MODE_MASK		GENMASK(21, 16)
>  #define PORT_LINK_MODE(n)		FIELD_PREP(PORT_LINK_MODE_MASK, n)
>  #define PORT_LINK_MODE_1_LANES		PORT_LINK_MODE(0x1)
> @@ -46,6 +51,7 @@
>  #define PCIE_PORT_DEBUG1_LINK_IN_TRAINING	BIT(29)
> =20
>  #define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
> +#define PORT_LOGIC_N_FTS_MASK		GENMASK(7, 0)
>  #define PORT_LOGIC_SPEED_CHANGE		BIT(17)
>  #define PORT_LOGIC_LINK_WIDTH_MASK	GENMASK(12, 8)
>  #define PORT_LOGIC_LINK_WIDTH(n)	FIELD_PREP(PORT_LOGIC_LINK_WIDTH_MASK, =
n)
> @@ -60,6 +66,9 @@
>  #define PCIE_MSI_INTR0_MASK		0x82C
>  #define PCIE_MSI_INTR0_STATUS		0x830
> =20
> +#define PCIE_PORT_MULTI_LANE_CTRL	0x8C0
> +#define PORT_MLTI_UPCFG_SUPPORT		BIT(7)
> +
>  #define PCIE_ATU_VIEWPORT		0x900
>  #define PCIE_ATU_REGION_INBOUND		BIT(31)
>  #define PCIE_ATU_REGION_OUTBOUND	0
> @@ -273,6 +282,9 @@ void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg,=
 size_t size, u32 val);
>  u32 dw_pcie_read_atu(struct dw_pcie *pci, u32 reg, size_t size);
>  void dw_pcie_write_atu(struct dw_pcie *pci, u32 reg, size_t size, u32 va=
l);
>  int dw_pcie_link_up(struct dw_pcie *pci);
> +void dw_pcie_upconfig_setup(struct dw_pcie *pci);
> +void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen);
> +void dw_pcie_link_set_n_fts(struct dw_pcie *pci, u32 n_fts);
>  int dw_pcie_wait_for_link(struct dw_pcie *pci);
>  void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
>  			       int type, u64 cpu_addr, u64 pci_addr,
> diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/con=
troller/dwc/pcie-intel-gw.c
> new file mode 100644
> index 000000000000..76c11b089e7f
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
> @@ -0,0 +1,546 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCIe host controller driver for Intel Gateway SoCs
> + *
> + * Copyright (c) 2019 Intel Corporation.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/iopoll.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_pci.h>
> +#include <linux/of_platform.h>
> +#include <linux/pci_regs.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +
> +#include "../../pci.h"
> +#include "pcie-designware.h"
> +
> +#define PORT_AFR_N_FTS_GEN12_DFT	(SZ_128 - 1)
> +#define PORT_AFR_N_FTS_GEN3		180
> +#define PORT_AFR_N_FTS_GEN4		196
> +
> +/* PCIe Application logic Registers */
> +#define PCIE_APP_CCR			0x10
> +#define PCIE_APP_CCR_LTSSM_ENABLE	BIT(0)
> +
> +#define PCIE_APP_MSG_CR			0x30
> +#define PCIE_APP_MSG_XMT_PM_TURNOFF	BIT(0)
> +
> +#define PCIE_APP_PMC			0x44
> +#define PCIE_APP_PMC_IN_L2		BIT(20)
> +
> +#define PCIE_APP_IRNEN			0xF4
> +#define PCIE_APP_IRNCR			0xF8
> +#define PCIE_APP_IRN_AER_REPORT		BIT(0)
> +#define PCIE_APP_IRN_PME		BIT(2)
> +#define PCIE_APP_IRN_RX_VDM_MSG		BIT(4)
> +#define PCIE_APP_IRN_PM_TO_ACK		BIT(9)
> +#define PCIE_APP_IRN_LINK_AUTO_BW_STAT	BIT(11)
> +#define PCIE_APP_IRN_BW_MGT		BIT(12)
> +#define PCIE_APP_IRN_MSG_LTR		BIT(18)
> +#define PCIE_APP_IRN_SYS_ERR_RC		BIT(29)
> +#define PCIE_APP_INTX_OFST		12
> +
> +#define PCIE_APP_IRN_INT \
> +			(PCIE_APP_IRN_AER_REPORT | PCIE_APP_IRN_PME | \
> +			PCIE_APP_IRN_RX_VDM_MSG | PCIE_APP_IRN_SYS_ERR_RC | \
> +			PCIE_APP_IRN_PM_TO_ACK | PCIE_APP_IRN_MSG_LTR | \
> +			PCIE_APP_IRN_BW_MGT | PCIE_APP_IRN_LINK_AUTO_BW_STAT | \
> +			(PCIE_APP_INTX_OFST + PCI_INTERRUPT_INTA) | \
> +			(PCIE_APP_INTX_OFST + PCI_INTERRUPT_INTB) | \
> +			(PCIE_APP_INTX_OFST + PCI_INTERRUPT_INTC) | \
> +			(PCIE_APP_INTX_OFST + PCI_INTERRUPT_INTD))
> +
> +#define BUS_IATU_OFFSET			SZ_256M
> +#define RESET_INTERVAL_MS		100
> +
> +struct intel_pcie_soc {
> +	unsigned int pcie_ver;
> +	unsigned int pcie_atu_offset;
> +	u32 num_viewport;
> +};
> +
> +struct intel_pcie_port {
> +	struct dw_pcie		pci;
> +	void __iomem		*app_base;
> +	struct gpio_desc	*reset_gpio;
> +	u32			rst_intrvl;
> +	u32			max_speed;
> +	u32			link_gen;
> +	u32			max_width;
> +	u32			n_fts;
> +	struct clk		*core_clk;
> +	struct reset_control	*core_rst;
> +	struct phy		*phy;
> +	u8			pcie_cap_ofst;
> +};
> +
> +static void pcie_update_bits(void __iomem *base, u32 mask, u32 val, u32 =
ofs)
> +{
> +	u32 old;
> +
> +	old =3D readl(base + ofs);
> +	val =3D (old & ~mask) | (val & mask);
> +
> +	if (val !=3D old)
> +		writel(val, base + ofs);
> +}
> +
> +static inline u32 pcie_app_rd(struct intel_pcie_port *lpp, u32 ofs)
> +{
> +	return readl(lpp->app_base + ofs);
> +}
> +
> +static inline void pcie_app_wr(struct intel_pcie_port *lpp, u32 val, u32=
 ofs)
> +{
> +	writel(val, lpp->app_base + ofs);
> +}
> +
> +static void pcie_app_wr_mask(struct intel_pcie_port *lpp,
> +			     u32 mask, u32 val, u32 ofs)
> +{
> +	pcie_update_bits(lpp->app_base, mask, val, ofs);
> +}
> +
> +static inline u32 pcie_rc_cfg_rd(struct intel_pcie_port *lpp, u32 ofs)
> +{
> +	return dw_pcie_readl_dbi(&lpp->pci, ofs);
> +}
> +
> +static inline void pcie_rc_cfg_wr(struct intel_pcie_port *lpp, u32 val, =
u32 ofs)
> +{
> +	dw_pcie_writel_dbi(&lpp->pci, ofs, val);
> +}
> +
> +static void pcie_rc_cfg_wr_mask(struct intel_pcie_port *lpp,
> +				u32 mask, u32 val, u32 ofs)
> +{
> +	pcie_update_bits(lpp->pci.dbi_base, mask, val, ofs);
> +}
> +
> +static void intel_pcie_ltssm_enable(struct intel_pcie_port *lpp)
> +{
> +	pcie_app_wr_mask(lpp, PCIE_APP_CCR_LTSSM_ENABLE,
> +			 PCIE_APP_CCR_LTSSM_ENABLE, PCIE_APP_CCR);
> +}
> +
> +static void intel_pcie_ltssm_disable(struct intel_pcie_port *lpp)
> +{
> +	pcie_app_wr_mask(lpp, PCIE_APP_CCR_LTSSM_ENABLE, 0, PCIE_APP_CCR);
> +}
> +
> +static void intel_pcie_link_setup(struct intel_pcie_port *lpp)
> +{
> +	u32 val;
> +	u8 offset =3D lpp->pcie_cap_ofst;
> +
> +	val =3D pcie_rc_cfg_rd(lpp, offset + PCI_EXP_LNKCAP);
> +	lpp->max_speed =3D FIELD_GET(PCI_EXP_LNKCAP_SLS, val);
> +	lpp->max_width =3D FIELD_GET(PCI_EXP_LNKCAP_MLW, val);
> +
> +	val =3D pcie_rc_cfg_rd(lpp, offset + PCI_EXP_LNKCTL);
> +
> +	val &=3D ~(PCI_EXP_LNKCTL_LD | PCI_EXP_LNKCTL_ASPMC);
> +	pcie_rc_cfg_wr(lpp, val, offset + PCI_EXP_LNKCTL);
> +}
> +
> +static void intel_pcie_port_logic_setup(struct intel_pcie_port *lpp)
> +{
> +	u32 val, mask;
> +
> +	switch (pcie_link_speed[lpp->max_speed]) {
> +	case PCIE_SPEED_8_0GT:
> +		lpp->n_fts =3D PORT_AFR_N_FTS_GEN3;
> +		break;
> +	case PCIE_SPEED_16_0GT:
> +		lpp->n_fts =3D PORT_AFR_N_FTS_GEN4;
> +		break;
> +	default:
> +		lpp->n_fts =3D PORT_AFR_N_FTS_GEN12_DFT;
> +		break;
> +	}
> +
> +	mask =3D PORT_AFR_N_FTS_MASK | PORT_AFR_CC_N_FTS_MASK;
> +	val =3D FIELD_PREP(PORT_AFR_N_FTS_MASK, lpp->n_fts) |
> +	       FIELD_PREP(PORT_AFR_CC_N_FTS_MASK, lpp->n_fts);
> +	pcie_rc_cfg_wr_mask(lpp, mask, val, PCIE_PORT_AFR);
> +
> +	/* Port Link Control Register */
> +	pcie_rc_cfg_wr_mask(lpp, PORT_LINK_DLL_LINK_EN,
> +			    PORT_LINK_DLL_LINK_EN, PCIE_PORT_LINK_CONTROL);
> +}
> +
> +static void intel_pcie_rc_setup(struct intel_pcie_port *lpp)
> +{
> +	intel_pcie_ltssm_disable(lpp);
> +	intel_pcie_link_setup(lpp);
> +	dw_pcie_setup_rc(&lpp->pci.pp);
> +	dw_pcie_upconfig_setup(&lpp->pci);
> +	intel_pcie_port_logic_setup(lpp);
> +	dw_pcie_link_set_max_speed(&lpp->pci, lpp->link_gen);
> +	dw_pcie_link_set_n_fts(&lpp->pci, lpp->n_fts);
> +}
> +
> +static int intel_pcie_ep_rst_init(struct intel_pcie_port *lpp)
> +{
> +	struct device *dev =3D lpp->pci.dev;
> +	int ret;
> +
> +	lpp->reset_gpio =3D devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(lpp->reset_gpio)) {
> +		ret =3D PTR_ERR(lpp->reset_gpio);
> +		if (ret !=3D -EPROBE_DEFER)
> +			dev_err(dev, "failed to request PCIe GPIO: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Make initial reset last for 100us */
> +	usleep_range(100, 200);
> +
> +	return 0;
> +}
> +
> +static void intel_pcie_core_rst_assert(struct intel_pcie_port *lpp)
> +{
> +	reset_control_assert(lpp->core_rst);
> +}
> +
> +static void intel_pcie_core_rst_deassert(struct intel_pcie_port *lpp)
> +{
> +	/*
> +	 * One micro-second delay to make sure the reset pulse
> +	 * wide enough so that core reset is clean.
> +	 */
> +	udelay(1);
> +	reset_control_deassert(lpp->core_rst);
> +
> +	/*
> +	 * Some SoC core reset also reset PHY, more delay needed
> +	 * to make sure the reset process is done.
> +	 */
> +	usleep_range(1000, 2000);
> +}
> +
> +static void intel_pcie_device_rst_assert(struct intel_pcie_port *lpp)
> +{
> +	gpiod_set_value_cansleep(lpp->reset_gpio, 1);
> +}
> +
> +static void intel_pcie_device_rst_deassert(struct intel_pcie_port *lpp)
> +{
> +	msleep(lpp->rst_intrvl);
> +	gpiod_set_value_cansleep(lpp->reset_gpio, 0);
> +}
> +
> +static int intel_pcie_app_logic_setup(struct intel_pcie_port *lpp)
> +{
> +	intel_pcie_device_rst_deassert(lpp);
> +	intel_pcie_ltssm_enable(lpp);
> +
> +	return dw_pcie_wait_for_link(&lpp->pci);
> +}
> +
> +static void intel_pcie_core_irq_disable(struct intel_pcie_port *lpp)
> +{
> +	pcie_app_wr(lpp, 0, PCIE_APP_IRNEN);
> +	pcie_app_wr(lpp, PCIE_APP_IRN_INT,  PCIE_APP_IRNCR);
> +}
> +
> +static int intel_pcie_get_resources(struct platform_device *pdev)
> +{
> +	struct intel_pcie_port *lpp =3D platform_get_drvdata(pdev);
> +	struct dw_pcie *pci =3D &lpp->pci;
> +	struct device *dev =3D pci->dev;
> +	struct resource *res;
> +	int ret;
> +
> +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
> +	pci->dbi_base =3D devm_ioremap_resource(dev, res);
> +	if (IS_ERR(pci->dbi_base))
> +		return PTR_ERR(pci->dbi_base);
> +
> +	lpp->core_clk =3D devm_clk_get(dev, NULL);
> +	if (IS_ERR(lpp->core_clk)) {
> +		ret =3D PTR_ERR(lpp->core_clk);
> +		if (ret !=3D -EPROBE_DEFER)
> +			dev_err(dev, "failed to get clks: %d\n", ret);
> +		return ret;
> +	}
> +
> +	lpp->core_rst =3D devm_reset_control_get(dev, NULL);
> +	if (IS_ERR(lpp->core_rst)) {
> +		ret =3D PTR_ERR(lpp->core_rst);
> +		if (ret !=3D -EPROBE_DEFER)
> +			dev_err(dev, "failed to get resets: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D device_property_match_string(dev, "device_type", "pci");
> +	if (ret) {
> +		dev_err(dev, "failed to find pci device type: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (device_property_read_u32(dev, "reset-assert-ms", &lpp->rst_intrvl))
> +		lpp->rst_intrvl =3D RESET_INTERVAL_MS;
> +
> +	ret =3D of_pci_get_max_link_speed(dev->of_node);
> +	lpp->link_gen =3D ret < 0 ? 0 : ret;
> +
> +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "app");
> +	lpp->app_base =3D devm_ioremap_resource(dev, res);
> +	if (IS_ERR(lpp->app_base))
> +		return PTR_ERR(lpp->app_base);
> +
> +	lpp->phy =3D devm_phy_get(dev, "pcie");
> +	if (IS_ERR(lpp->phy)) {
> +		ret =3D PTR_ERR(lpp->phy);
> +		if (ret !=3D -EPROBE_DEFER)
> +			dev_err(dev, "couldn't get pcie-phy: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void intel_pcie_deinit_phy(struct intel_pcie_port *lpp)
> +{
> +	phy_exit(lpp->phy);
> +}
> +
> +static int intel_pcie_wait_l2(struct intel_pcie_port *lpp)
> +{
> +	u32 value;
> +	int ret;
> +
> +	if (pcie_link_speed[lpp->max_speed] < PCIE_SPEED_8_0GT)
> +		return 0;
> +
> +	/* Send PME_TURN_OFF message */
> +	pcie_app_wr_mask(lpp, PCIE_APP_MSG_XMT_PM_TURNOFF,
> +			 PCIE_APP_MSG_XMT_PM_TURNOFF, PCIE_APP_MSG_CR);
> +
> +	/* Read PMC status and wait for falling into L2 link state */
> +	ret =3D readl_poll_timeout(lpp->app_base + PCIE_APP_PMC, value,
> +				 value & PCIE_APP_PMC_IN_L2, 20,
> +				 jiffies_to_usecs(5 * HZ));
> +	if (ret)
> +		dev_err(lpp->pci.dev, "PCIe link enter L2 timeout!\n");
> +
> +	return ret;
> +}
> +
> +static void intel_pcie_turn_off(struct intel_pcie_port *lpp)
> +{
> +	if (dw_pcie_link_up(&lpp->pci))
> +		intel_pcie_wait_l2(lpp);
> +
> +	/* Put endpoint device in reset state */
> +	intel_pcie_device_rst_assert(lpp);
> +	pcie_rc_cfg_wr_mask(lpp, PCI_COMMAND_MEMORY, 0, PCI_COMMAND);
> +}
> +
> +static int intel_pcie_host_setup(struct intel_pcie_port *lpp)
> +{
> +	struct device *dev =3D lpp->pci.dev;
> +	int ret;
> +
> +	intel_pcie_core_rst_assert(lpp);
> +	intel_pcie_device_rst_assert(lpp);
> +
> +	ret =3D phy_init(lpp->phy);
> +	if (ret)
> +		return ret;
> +
> +	intel_pcie_core_rst_deassert(lpp);
> +
> +	ret =3D clk_prepare_enable(lpp->core_clk);
> +	if (ret) {
> +		dev_err(lpp->pci.dev, "Core clock enable failed: %d\n", ret);
> +		goto clk_err;
> +	}
> +
> +	if (!lpp->pcie_cap_ofst) {
> +		ret =3D dw_pcie_find_capability(&lpp->pci, PCI_CAP_ID_EXP);
> +		if (!ret) {
> +			ret =3D -ENXIO;
> +			dev_err(dev, "Invalid PCIe capability offset\n");
> +			goto app_init_err;
> +		}
> +
> +		lpp->pcie_cap_ofst =3D ret;
> +	}
> +
> +	intel_pcie_rc_setup(lpp);
> +	ret =3D intel_pcie_app_logic_setup(lpp);
> +	if (ret)
> +		goto app_init_err;
> +
> +	/* Enable integrated interrupts */
> +	pcie_app_wr_mask(lpp, PCIE_APP_IRN_INT, PCIE_APP_IRN_INT,
> +			 PCIE_APP_IRNEN);
> +	return 0;
> +
> +app_init_err:
> +	clk_disable_unprepare(lpp->core_clk);
> +clk_err:
> +	intel_pcie_core_rst_assert(lpp);
> +	intel_pcie_deinit_phy(lpp);
> +
> +	return ret;
> +}
> +
> +static void __intel_pcie_remove(struct intel_pcie_port *lpp)
> +{
> +	intel_pcie_core_irq_disable(lpp);
> +	intel_pcie_turn_off(lpp);
> +	clk_disable_unprepare(lpp->core_clk);
> +	intel_pcie_core_rst_assert(lpp);
> +	intel_pcie_deinit_phy(lpp);
> +}
> +
> +static int intel_pcie_remove(struct platform_device *pdev)
> +{
> +	struct intel_pcie_port *lpp =3D platform_get_drvdata(pdev);
> +	struct pcie_port *pp =3D &lpp->pci.pp;
> +
> +	dw_pcie_host_deinit(pp);
> +	__intel_pcie_remove(lpp);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused intel_pcie_suspend_noirq(struct device *dev)
> +{
> +	struct intel_pcie_port *lpp =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	intel_pcie_core_irq_disable(lpp);
> +	ret =3D intel_pcie_wait_l2(lpp);
> +	if (ret)
> +		return ret;
> +
> +	intel_pcie_deinit_phy(lpp);
> +	clk_disable_unprepare(lpp->core_clk);
> +	return ret;
> +}
> +
> +static int __maybe_unused intel_pcie_resume_noirq(struct device *dev)
> +{
> +	struct intel_pcie_port *lpp =3D dev_get_drvdata(dev);
> +
> +	return intel_pcie_host_setup(lpp);
> +}
> +
> +static int intel_pcie_rc_init(struct pcie_port *pp)
> +{
> +	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> +	struct intel_pcie_port *lpp =3D dev_get_drvdata(pci->dev);
> +
> +	return intel_pcie_host_setup(lpp);
> +}
> +
> +int intel_pcie_msi_init(struct pcie_port *pp)
> +{
> +	/* PCIe MSI/MSIx is handled by MSI in x86 processor */
> +	return 0;
> +}
> +
> +u64 intel_pcie_cpu_addr(struct dw_pcie *pcie, u64 cpu_addr)
> +{
> +	return cpu_addr + BUS_IATU_OFFSET;
> +}
> +
> +static const struct dw_pcie_ops intel_pcie_ops =3D {
> +	.cpu_addr_fixup =3D intel_pcie_cpu_addr,
> +};
> +
> +static const struct dw_pcie_host_ops intel_pcie_dw_ops =3D {
> +	.host_init =3D		intel_pcie_rc_init,
> +	.msi_host_init =3D	intel_pcie_msi_init,
> +};
> +
> +static const struct intel_pcie_soc pcie_data =3D {
> +	.pcie_ver =3D		0x520A,
> +	.pcie_atu_offset =3D	0xC0000,
> +	.num_viewport =3D		3,
> +};
> +
> +static int intel_pcie_probe(struct platform_device *pdev)
> +{
> +	const struct intel_pcie_soc *data;
> +	struct device *dev =3D &pdev->dev;
> +	struct intel_pcie_port *lpp;
> +	struct pcie_port *pp;
> +	struct dw_pcie *pci;
> +	int ret;
> +
> +	lpp =3D devm_kzalloc(dev, sizeof(*lpp), GFP_KERNEL);
> +	if (!lpp)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, lpp);
> +	pci =3D &lpp->pci;
> +	pci->dev =3D dev;
> +	pp =3D &pci->pp;
> +
> +	ret =3D intel_pcie_get_resources(pdev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D intel_pcie_ep_rst_init(lpp);
> +	if (ret)
> +		return ret;
> +
> +	data =3D device_get_match_data(dev);
> +	if (!data)
> +		return -ENODEV;
> +
> +	pci->ops =3D &intel_pcie_ops;
> +	pci->version =3D data->pcie_ver;
> +	pci->atu_base =3D pci->dbi_base + data->pcie_atu_offset;
> +	pp->ops =3D &intel_pcie_dw_ops;
> +
> +	ret =3D dw_pcie_host_init(pp);
> +	if (ret) {
> +		dev_err(dev, "cannot initialize host\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * Intel PCIe doesn't configure IO region, so set viewport
> +	 * to not to perform IO region access.
> +	 */
> +	pci->num_viewport =3D data->num_viewport;
> +
> +	dev_info(dev, "Intel PCIe Root Complex Port init done\n");
> +
> +	return ret;
> +}
> +
> +static const struct dev_pm_ops intel_pcie_pm_ops =3D {
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(intel_pcie_suspend_noirq,
> +				      intel_pcie_resume_noirq)
> +};
> +
> +static const struct of_device_id of_intel_pcie_match[] =3D {
> +	{ .compatible =3D "intel,lgm-pcie", .data =3D &pcie_data },
> +	{}
> +};
> +
> +static struct platform_driver intel_pcie_driver =3D {
> +	.probe =3D intel_pcie_probe,
> +	.remove =3D intel_pcie_remove,
> +	.driver =3D {
> +		.name =3D "intel-gw-pcie",
> +		.of_match_table =3D of_intel_pcie_match,
> +		.pm =3D &intel_pcie_pm_ops,
> +	},
> +};
> +builtin_platform_driver(intel_pcie_driver);
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.=
h
> index 29d6e93fd15e..548e22e07a52 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -673,6 +673,7 @@
>  #define  PCI_EXP_LNKCTL2_TLS_8_0GT	0x0003 /* Supported Speed 8GT/s */
>  #define  PCI_EXP_LNKCTL2_TLS_16_0GT	0x0004 /* Supported Speed 16GT/s */
>  #define  PCI_EXP_LNKCTL2_TLS_32_0GT	0x0005 /* Supported Speed 32GT/s */
> +#define  PCI_EXP_LNKCTL2_HASD		0x0020 /* HW Autonomous Speed Disable */
>  #define PCI_EXP_LNKSTA2		50	/* Link Status 2 */
>  #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	52	/* v2 endpoints with link end =
here */
>  #define PCI_EXP_SLTCAP2		52	/* Slot Capabilities 2 */
> --=20
> 2.11.0


Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>


