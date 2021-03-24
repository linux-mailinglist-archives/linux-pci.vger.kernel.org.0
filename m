Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7093C347451
	for <lists+linux-pci@lfdr.de>; Wed, 24 Mar 2021 10:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbhCXJQQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Mar 2021 05:16:16 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:55228 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234493AbhCXJPy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Mar 2021 05:15:54 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id EDD43C00F3;
        Wed, 24 Mar 2021 09:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1616577353; bh=P459Tg5LNJptcsoBOWXfr5kFv9oPdrmBo4iNPmWJ/Nc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Xmsl76gdja6HaiAUADZlTDytnxhrAtB6AmMngkJpoQCsD7B3KdLTvymdRMbe9Ma69
         cF7M95f5Puel6X2gTTuPNTRILTKFB175N3yF8P3yP0CofSa5evEkt2le30eL63l9lV
         AKzfzZPAsqWw6Ox9ranyxZa3+yYBTc1Zz4H1Ftp/zPr4OY0+iRRx1WGYwZUlj1fOpx
         gIw23yw38t3/ItioZl0K89WCg37ReioIlfQQuHY0WTStToRN/kBswzZHiKQxh8CEva
         vY2TSR6NyjlL3M68WPwMDXLgNwT6sQv7wp7W/KskIzKA1uBM3F3EB7fhOYmTouOSDJ
         4j5maZ55cJeDQ==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 2C52AA007D;
        Wed, 24 Mar 2021 09:15:49 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 2CEAB800C0;
        Wed, 24 Mar 2021 09:15:47 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=gustavo@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="JKJ2rSDG";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEjTfFiiiZDGCa73cQvStye6ESGKscvK79r9wq/XaBJDYvZ0WWQM/+oe8OCJAOYB7hxV8S4JkZ5/5OGg7ZnPmkfc2kgDtEzG6LQUZoU78Lp4sVW2Fi2OHjmqzB2kwF/OesHORWAIfIf2BSPfo0Ggh7fQ+xLyiqsdNRIH0QvrPCG4br3MmCk5LRFFePSVOgGDSUqYwEQxazmucqnrd14SRSzFHlu10lWgKlvjGPwPFSPczidz1s5AUYkxMy3oCRQLxa6VE5ncJIg+M+Y/3ezzAgGFR4ZQpzwDnVPL+I5VRgnUK2AAZNveFdjB8L6x40TB/q2LO/D+DJ84TjW09W4hpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avgdCVKSR2ETb62chX0IjX+kR6JoHx2IuwvL3wqMIMQ=;
 b=kylqELlkQwPb3tAxxWQ7kQpX2pZ0xsvThfEEhSTu3tyVqcIzdEuK+ohUZykuGs3PmUVV8dY4ysehzlpTOLvNvZwXvlAF2xaOs0NcBB+qi+UbyycUgwdNv3QLEP4P88lHoFuzSwsBd27QgZI2rGKJsP4inJHjgXtcK5xu5EZXSkMGVKDxJu8cGNqWSqCpz1N7cyDgo0lqXoTjrW5yb0nbhq9UiEls2OeTAD7077w5X05TAyJ5mFIjsQI6h4vgyyl5nv2Nz11eBk5Bp6WdKSo0hDVG0I8K1GtM2hgA4JGmFGYvULhIq3iEqhtKDWB7cQZUkzSIKo5ovrW43P0s+GRrYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avgdCVKSR2ETb62chX0IjX+kR6JoHx2IuwvL3wqMIMQ=;
 b=JKJ2rSDG2gOZOHCg9At9ZG9Nc+/iNu3vOh4Rirthb0tWNlfhiRwubdO9/FLLxio7GQITwMceve+SzdiB5N0BdiIJFhh5G5FTOJhA7QTeCLBfmMMAN+S/afUHKRjyuDrd3mg9r0awMlDdOwhXy9PSuIm3NPyHUcbnolhC+aTxk8k=
Received: from DM5PR12MB1835.namprd12.prod.outlook.com (2603:10b6:3:10c::9) by
 DM5PR1201MB0028.namprd12.prod.outlook.com (2603:10b6:4:5a::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.25; Wed, 24 Mar 2021 09:15:46 +0000
Received: from DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052]) by DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052%10]) with mapi id 15.20.3977.024; Wed, 24 Mar
 2021 09:15:46 +0000
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
Subject: RE: [PATCH v6 1/5] misc: Add Synopsys DesignWare xData IP driver
Thread-Topic: [PATCH v6 1/5] misc: Add Synopsys DesignWare xData IP driver
Thread-Index: AQHXAWRyZ/bohfNdJka5lU7p25Gw8KqRxhkAgAFTW/A=
Date:   Wed, 24 Mar 2021 09:15:46 +0000
Message-ID: <DM5PR12MB18355EDB515CE57C38ECF6D4DA639@DM5PR12MB1835.namprd12.prod.outlook.com>
References: <cover.1613150798.git.gustavo.pimentel@synopsys.com>
 <724f5d30e3a9b86448df7e32fb5ed1e814416368.1613150798.git.gustavo.pimentel@synopsys.com>
 <YFnmVEB86JcAENcN@kroah.com>
In-Reply-To: <YFnmVEB86JcAENcN@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTgyNjQxZjFmLThjODEtMTFlYi05OGVkLWE0NGNj?=
 =?us-ascii?Q?OGU5Y2YwNlxhbWUtdGVzdFw4MjY0MWYyMS04YzgxLTExZWItOThlZC1hNDRj?=
 =?us-ascii?Q?YzhlOWNmMDZib2R5LnR4dCIgc3o9IjMxNDkiIHQ9IjEzMjYxMDUwOTQ0MTM0?=
 =?us-ascii?Q?NTk3MiIgaD0iSk5aUXg4c3Izd09hYnpmenVUclFaOTYxVzQwPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBSFlJQUFD?=
 =?us-ascii?Q?MEtieEVqaURYQWFQNFlxN2V6QmQ3by9oaXJ0N01GM3NOQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUhBQUFBQUdDQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQVFBQkFBQUFnbk1odXdBQUFBQUFBQUFBQUFBQUFKNEFBQUJtQUdrQWJn?=
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
 =?us-ascii?Q?ZFFCdUFHUUFjZ0I1QUY4QWNBQmhBSElBZEFCdUFHVUFjZ0J6QUY4QWN3QnRB?=
 =?us-ascii?Q?R2tBWXdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdZQWJ3QjFBRzRBWkFCeUFIa0FY?=
 =?us-ascii?Q?d0J3QUdFQWNnQjBBRzRBWlFCeUFITUFYd0J6QUhRQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNB?=
 =?us-ascii?Q?QUFBQUFDZUFBQUFaZ0J2QUhVQWJnQmtBSElBZVFCZkFIQUFZUUJ5QUhRQWJn?=
 =?us-ascii?Q?QmxBSElBY3dCZkFIUUFjd0J0QUdNQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCbUFH?=
 =?us-ascii?Q?OEFkUUJ1QUdRQWNnQjVBRjhBY0FCaEFISUFkQUJ1QUdVQWNnQnpBRjhBZFFC?=
 =?us-ascii?Q?dEFHTUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR2NBZEFCekFGOEFjQUJ5QUc4?=
 =?us-ascii?Q?QVpBQjFBR01BZEFCZkFIUUFjZ0JoQUdrQWJnQnBBRzRBWndBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFB?=
 =?us-ascii?Q?Q0FBQUFBQUNlQUFBQWN3QmhBR3dBWlFCekFGOEFZUUJqQUdNQWJ3QjFBRzRB?=
 =?us-ascii?Q?ZEFCZkFIQUFiQUJoQUc0QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ6?=
 =?us-ascii?Q?QUdFQWJBQmxBSE1BWHdCeEFIVUFid0IwQUdVQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFITUFiZ0J3QUhNQVh3QnNB?=
 =?us-ascii?Q?R2tBWXdCbEFHNEFjd0JsQUY4QWRBQmxBSElBYlFCZkFERUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFB?=
 =?us-ascii?Q?QUFDQUFBQUFBQ2VBQUFBY3dCdUFIQUFjd0JmQUd3QWFRQmpBR1VBYmdCekFH?=
 =?us-ascii?Q?VUFYd0IwQUdVQWNnQnRBRjhBY3dCMEFIVUFaQUJsQUc0QWRBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFB?=
 =?us-ascii?Q?QjJBR2NBWHdCckFHVUFlUUIzQUc4QWNnQmtBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUEiLz48L21ldGE+?=
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [89.155.14.32]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4bacea5-fc2d-42e7-d060-08d8eea5687b
x-ms-traffictypediagnostic: DM5PR1201MB0028:
x-microsoft-antispam-prvs: <DM5PR1201MB002802B80545FF6F2DD16402DA639@DM5PR1201MB0028.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zte9o36TDvP6eTlyjgv1L78jghvzdJBz6NHb5Ey+R8eA5k4ePJLcin+VVsRz+yOE1/SjHkVzKIK/ug2/XbfXrbrC5jTUJG1rkeNo5PshtxwAoOUezR043hcn3W5D2svWEDpIJl3VNjytcmSktOKr+GqupJaOcDQC0jVzx0JmJfYrKyaURe+fpWF8gFuTfhuXdKtAkbOkin7yYEEmHfQaZGG/DDG22PCz3xbHXv8g8RFqqHODlRXI5IppA3yPJEvcLPKs0cjPVph+HQl4raZppEstMuUn2utnJlJwIq2feH+CamyX3X7Q+hVWQDlRUP46eV3+7WYH6C2sEGlDEIPPG9AasZgvcVs4D0OsQt/VEdsl4ZkMiTgLEpEwpST+IWPMzrX93Ap+6h4yvwRtv+HoLtLksWsD32ziXiSYDq1s8RChu+PmojjMul3Az4SsZNYT7giHX63wzcEP9OF/7a1vlnbjqeOr2qBVLR/0ZTWGuP0TwE7WyqPGBwANk2QIutT+X03dIC1ltdrhA6fzAx3m6zaJN9dfx30P98CtaPvZlGPpoM5JKlFsbxRhWTYY8v/AatM1Fff8lcRQBPrG3wIQMLHM7u8gcMXw7HFNZ9CRk6ab0f+7GxxFvCT97ls7hl85iZZd6qJ4WjyHMhbavzdPiaqq/TRXby/iF03pcLJUb3Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1835.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(376002)(396003)(136003)(346002)(55016002)(316002)(53546011)(9686003)(66476007)(6506007)(2906002)(66556008)(6916009)(8936002)(52536014)(478600001)(5660300002)(54906003)(8676002)(33656002)(86362001)(76116006)(186003)(26005)(7696005)(66946007)(71200400001)(7416002)(66446008)(64756008)(4326008)(38100700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?wLtQwDCU1OQlH9a+FPpi6SGEXtLo2SyxFvuhdBhvj0MnzttVjGH/X2aSaNYB?=
 =?us-ascii?Q?Mb5YQU8WKdyXxDMRZkg3iWZfIfSR4eNfoqj+RJVyd/l4Co6dKQhwJkaUMDBc?=
 =?us-ascii?Q?EbLFLqjBX/H4hXPJeki6XsiOkKcpr8BuQVLYSkb6zFJf/Acd3xctX+XOIlkY?=
 =?us-ascii?Q?PTbHDhnBaezSLTQW3Pzm/8xfwp6LS0NfT9KdWnZmxdkcO6ERlkSE5LO5W01H?=
 =?us-ascii?Q?R+Fwnut5cVW8RB2MAc9N7+si8lOEoQWONKjZNplcJokz140rMV2a6klIw1aW?=
 =?us-ascii?Q?xilGDTXDKEoY8lbpoZBcz7+xUdkKRpvFwICwYsCOlqVnIJgvaxQNH/oC2GQq?=
 =?us-ascii?Q?zoZESfrtfWfxNz9jiwqJxQaN/7jNkJuvi1xQP+cjRtjBzgG3l0+Q/xqclFTk?=
 =?us-ascii?Q?tLtaPO4Rpee8wLtPFKt5cg+mKkaKoAu27JFvJu7i+L8GbiqaT7TdkQju99DE?=
 =?us-ascii?Q?w2D0Tnf7eoWRwmWQd3sZsw44jMatzEhUSc5bngLUqBWJu15sEgmNiYYGXXXg?=
 =?us-ascii?Q?CJVbXqXesTUlgCWgxSF9eJ+HGktDaXkABY5v3lZy84qJPVFqT6bbNQ5994gk?=
 =?us-ascii?Q?WecM9OsAAbeLAM6BZtRh7APfs3+pNrgl5PU/ffximxIWQ5GCKX3osv4om9m0?=
 =?us-ascii?Q?EFNwU9jBnpkx+6O8Su5QxMYkwlsBWpjg2csftry2hlLeiqKKE3bIGWh7dqpt?=
 =?us-ascii?Q?eIBe2HN6Mzv4IvUDuifc7SnpiElJ5xupPGHP3C8UmO+JxEIVcO+Do0EGEG/x?=
 =?us-ascii?Q?/O31TBzU+Y4S2XCWORmMuOcwHFeK7Pwpr+3f/nUqqYNpvTzrBQ7l3fBYOV3N?=
 =?us-ascii?Q?eJ6/U1Xvcw7fmjrm+LLR3dyVNHue8hR1h91WBmTBtYwLC1yEjHDiM8XjeGX8?=
 =?us-ascii?Q?PTWvwpqr/sAr99B+YhA4aaw9WcCGM9BQEthWes6kXByEx6B+9+6zK40B3+OL?=
 =?us-ascii?Q?KsCLbcuJUoz+vBrBPRRdaErRLC9ZGeaahfeTkFTBIP9XRcfyxwJMMt0BGTRd?=
 =?us-ascii?Q?dFHUkrZ6RfPh95WrtO41SKfhU9xn8757qEaL5n/kU98YTchBPyfZd5jYNbEA?=
 =?us-ascii?Q?56xpRvcBTzO1EllfjenS2h1t1fk7iuRda7mOD0iTGI8xquaHkAnVtBzM0xJ8?=
 =?us-ascii?Q?EidftA2wgBn4s7z6NjjzvymjaJh1ODVcz8G66lVyQXyP4svrM2aslHHsyWlo?=
 =?us-ascii?Q?7awZeMlhrLSnLf5lyZczx6q6FMUJyPCjU4C3Bsu7QLuyIbu2xIAYopen3QE+?=
 =?us-ascii?Q?QNdgWuld4nqaS9r5mFeSapxm9lcoMp7V56kJMzc36nNR9dzqBW/kQ+ui+Lti?=
 =?us-ascii?Q?Ud+rzMDsVSRbrGK0vMhpmABV?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4bacea5-fc2d-42e7-d060-08d8eea5687b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2021 09:15:46.2094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3cQoLuVgwWdMl9hCLK2Wv8+KT1MfQ95sI6/iXXlZ44DPQSh7ApT8MnOx6XjzBH47CnZdk4ZKL3zhcbVs+/bLfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0028
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Greg,

On Tue, Mar 23, 2021 at 13:0:4, Greg Kroah-Hartman=20
<gregkh@linuxfoundation.org> wrote:

> On Fri, Feb 12, 2021 at 06:28:03PM +0100, Gustavo Pimentel wrote:
> > +static const struct attribute_group xdata_attr_group =3D {
> > +	.attrs =3D default_attrs,
> > +	.name =3D DW_XDATA_DRIVER_NAME,
> > +};
>=20
> ATTRIBUTE_GROUPS()?

Nicely catched!

>=20
> > +static int dw_xdata_pcie_probe(struct pci_dev *pdev,
> > +			       const struct pci_device_id *pid)
> > +{
> > +	const struct dw_xdata_pcie_data *pdata =3D (void *)pid->driver_data;
> > +	struct dw_xdata *dw;
> > +	u64 addr;
> > +	int err;
> > +
> > +	/* Enable PCI device */
> > +	err =3D pcim_enable_device(pdev);
> > +	if (err) {
> > +		pci_err(pdev, "enabling device failed\n");
> > +		return err;
> > +	}
> > +
> > +	/* Mapping PCI BAR regions */
> > +	err =3D pcim_iomap_regions(pdev, BIT(pdata->rg_bar), pci_name(pdev));
> > +	if (err) {
> > +		pci_err(pdev, "xData BAR I/O remapping failed\n");
> > +		return err;
> > +	}
> > +
> > +	pci_set_master(pdev);
> > +
> > +	/* Allocate memory */
> > +	dw =3D devm_kzalloc(&pdev->dev, sizeof(*dw), GFP_KERNEL);
> > +	if (!dw)
> > +		return -ENOMEM;
> > +
> > +	/* Data structure initialization */
> > +	mutex_init(&dw->mutex);
> > +
> > +	dw->rg_region.vaddr =3D pcim_iomap_table(pdev)[pdata->rg_bar];
> > +	if (!dw->rg_region.vaddr)
> > +		return -ENOMEM;
> > +
> > +	dw->rg_region.vaddr +=3D pdata->rg_off;
> > +	dw->rg_region.paddr =3D pdev->resource[pdata->rg_bar].start;
> > +	dw->rg_region.paddr +=3D pdata->rg_off;
> > +	dw->rg_region.sz =3D pdata->rg_sz;
> > +
> > +	dw->max_wr_len =3D pcie_get_mps(pdev);
> > +	dw->max_wr_len >>=3D 2;
> > +
> > +	dw->max_rd_len =3D pcie_get_readrq(pdev);
> > +	dw->max_rd_len >>=3D 2;
> > +
> > +	dw->pdev =3D pdev;
> > +
> > +	writel(0x0, &(__dw_regs(dw)->RAM_addr));
> > +	writel(0x0, &(__dw_regs(dw)->RAM_port));
> > +
> > +	addr =3D dw->rg_region.paddr + DW_XDATA_EP_MEM_OFFSET;
> > +	writel(lower_32_bits(addr), &(__dw_regs(dw)->addr_lsb));
> > +	writel(upper_32_bits(addr), &(__dw_regs(dw)->addr_msb));
> > +	pci_dbg(pdev, "xData: target address =3D 0x%.16llx\n", addr);
> > +
> > +	pci_dbg(pdev, "xData: wr_len=3D%zu, rd_len=3D%zu\n",
> > +		dw->max_wr_len * 4, dw->max_rd_len * 4);
> > +
> > +	/* Saving data structure reference */
> > +	pci_set_drvdata(pdev, dw);
> > +
> > +	/* Sysfs */
> > +	err =3D sysfs_create_group(&pdev->dev.kobj, &xdata_attr_group);
>=20
> You just raced with userspace and lost :(
>=20
> Have the driver core properly create/remove your sysfs files, set the
> default groups pointer in your driver and all will be fine.

I've gone around and around, searched in other drivers, but I'm not=20
understanding your PoV or what I should do. Can you throw me a bone here?
I'm starting to pull my hair off, lol

I would like to ask you about something, it's you the maintainer of misc=20
drivers right?
After fixing this issue, does this driver have a chance to be pulled on=20
5.13?

-Gustavo

>=20
> thanks,
>=20
> greg k-h


