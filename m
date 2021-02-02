Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB6E30BC34
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 11:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhBBKjm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 05:39:42 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:40572 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229739AbhBBKjg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Feb 2021 05:39:36 -0500
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 84F7D401AD;
        Tue,  2 Feb 2021 10:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1612262313; bh=WXAJYu1QZeFlPvUCbAsXC+yxW9J0aeSxUz99b/HlMmM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=erOqLS5NPhVbE0FvLk+XFkgA4BYVRSKt9HRcb9ohSjAOUwcdmEN2Sg9LOLYmUFfnN
         r8cBspVTCzYWhUvhnsBy3G4C576TdjPpq1BzMfGJKx1egAe+c1ukD+b0m4OnTJ9dNr
         EezTR1QOQiJaCM0mxbc9zra282ksOPEJaxyZ/r0yQ6s1Hm/J48NIE6x/H7wsxRgaTw
         RT2P4HzCX8WrSqOEDNNoKB10ooA/RfohSdG0gNv+SVPkQsqsdeNhLQF/rwQhoZq7H+
         1HnMw78XwA1BXr8RmvC3ni6WFOltw+jnPDALf90FAW6v9LdHYZMXRXJxNAFoCq5V2c
         oExRxnXIiooqw==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 003A4A006F;
        Tue,  2 Feb 2021 10:38:32 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 66955400CC;
        Tue,  2 Feb 2021 10:38:31 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=gustavo@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="nlfRtnkH";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oM1q1uJq5ydvWZBd3HWIsB+6y7JON8BmPiaC4EXHGFnryiiFO+mjWDBXNFlCN1GmmQQkhJcI0+dBaScjtbYD9NT0mhEOBwxalibNpkQXyJOI2Xhu5Djb0ekVihPaAAab9r6rAcxWLVbeTB2twmQWk/ZK4MdHCYT7NNS+UN53nmBUBoVEP97pKMrUjh+bhgGyB3UZngG2S+9/92Y/81YnveDpHS4/qMHlaukOkk7ejW3/GABftMH+lXGxkq7eUGmMupjmXHmuxa6fljLgZi7YJrWmP+qSEi+v3iuNKZAVC5cs+JqYAum/pJBeYRSjIPINAvr4zZUDXgJxdUio5DL94A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXAJYu1QZeFlPvUCbAsXC+yxW9J0aeSxUz99b/HlMmM=;
 b=htOgjYyo68j1B5FR14SlalBusfLFlYQctjdKAFJ+GckJa3WYVGJuAP1SA//kLHrdb0L1kthDNWt5lBwym4ANZEDL0URS5bqdeKCg7/7ffq5H+gZrcG9xiEOuktKiKa0Av811m3HLX+C2JRzu0on9BWZNLTBXM8yPSQGg7jrmL7ZFfpuuzZ/pmayBKSsGxCaAkOHklKa+W+FMis3dz5OJmu7/01UHbdDBzBg3zTq8HbrRKPrwkPjQWX/MQZ+z9c4o1GHnO3PENCUmuqlMdZsxlw9lAITTrA8Q6dR+I4LiV5HQSvjg/7v8HNq/C0PrqdbaXQ60C6XyWbC0EaATfyQIug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXAJYu1QZeFlPvUCbAsXC+yxW9J0aeSxUz99b/HlMmM=;
 b=nlfRtnkHIZNyIdRsEVODUU8/e3BUGDG5I1An8InjGRyaKOy4A5OGQBdeyfe7dYPN4G8q+e0SiXRr4b9U+1LqabeXTOYRKrQ3HRT0S6o/33f0jB3IWJniFLRtzBpurZYlKY4R3J3mb1lcprCeVZP9lxu4G3LGgypPmaeLAUroZEc=
Received: from DM5PR12MB1835.namprd12.prod.outlook.com (2603:10b6:3:10c::9) by
 DM5PR12MB2470.namprd12.prod.outlook.com (2603:10b6:4:b4::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.20; Tue, 2 Feb 2021 10:38:30 +0000
Received: from DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052]) by DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052%10]) with mapi id 15.20.3805.028; Tue, 2 Feb 2021
 10:38:29 +0000
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 0/5] misc: Add Add Synopsys DesignWare xData IP driver
Thread-Topic: [PATCH v3 0/5] misc: Add Add Synopsys DesignWare xData IP driver
Thread-Index: AQHWvlUnrEoqwwtzmk2HTCBmG0B2lKpFBCnAgAAWroCAAAXKUA==
Date:   Tue, 2 Feb 2021 10:38:29 +0000
Message-ID: <DM5PR12MB183515FF24DC1C306CDCD718DAB59@DM5PR12MB1835.namprd12.prod.outlook.com>
References: <cover.1605777306.git.gustavo.pimentel@synopsys.com>
 <DM5PR12MB183527AA0FECE00D7A3D46DBDAB59@DM5PR12MB1835.namprd12.prod.outlook.com>
 <YBklScf1HPCVKQPf@kroah.com>
In-Reply-To: <YBklScf1HPCVKQPf@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLWM4NDczNmE3LTY1NDItMTFlYi05OGU2LWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFxjODQ3MzZhOC02NTQyLTExZWItOThlNi1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjY2MiIgdD0iMTMyNTY3MzU5MDc5MzQ4?=
 =?us-ascii?Q?MTA4IiBoPSI5eUJQTFRUNlBUdVgwblplSjRjWFd0N3YwTjQ9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFCUUpBQUNN?=
 =?us-ascii?Q?ZDd5S1QvbldBWTRtMHVWS3Z5cEtqaWJTNVVxL0trb09BQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFDa0NBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUFCQUFBQU5yU1YzZ0FBQUFBQUFBQUFBQUFBQUo0QUFBQm1BR2tBYmdC?=
 =?us-ascii?Q?aEFHNEFZd0JsQUY4QWNBQnNBR0VBYmdCdUFHa0FiZ0JuQUY4QWR3QmhBSFFB?=
 =?us-ascii?Q?WlFCeUFHMEFZUUJ5QUdzQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdZQWJ3QjFBRzRBWkFCeUFIa0FYd0J3?=
 =?us-ascii?Q?QUdFQWNnQjBBRzRBWlFCeUFITUFYd0JuQUdZQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFaZ0J2QUhVQWJnQmtBSElBZVFCZkFIQUFZUUJ5QUhRQWJnQmxB?=
 =?us-ascii?Q?SElBY3dCZkFITUFZUUJ0QUhNQWRRQnVBR2NBWHdCakFHOEFiZ0JtQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCbUFHOEFk?=
 =?us-ascii?Q?UUJ1QUdRQWNnQjVBRjhBY0FCaEFISUFkQUJ1QUdVQWNnQnpBRjhBY3dCaEFH?=
 =?us-ascii?Q?MEFjd0IxQUc0QVp3QmZBSElBWlFCekFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1lBYndCMUFHNEFaQUJ5QUhrQVh3?=
 =?us-ascii?Q?QndBR0VBY2dCMEFHNEFaUUJ5QUhNQVh3QnpBRzBBYVFCakFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVpnQnZBSFVBYmdCa0FISUFlUUJmQUhBQVlRQnlBSFFBYmdC?=
 =?us-ascii?Q?bEFISUFjd0JmQUhNQWRBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJtQUc4?=
 =?us-ascii?Q?QWRRQnVBR1FBY2dCNUFGOEFjQUJoQUhJQWRBQnVBR1VBY2dCekFGOEFkQUJ6?=
 =?us-ascii?Q?QUcwQVl3QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHWUFid0IxQUc0QVpBQnlBSGtB?=
 =?us-ascii?Q?WHdCd0FHRUFjZ0IwQUc0QVpRQnlBSE1BWHdCMUFHMEFZd0FBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFD?=
 =?us-ascii?Q?QUFBQUFBQ2VBQUFBWndCMEFITUFYd0J3QUhJQWJ3QmtBSFVBWXdCMEFGOEFk?=
 =?us-ascii?Q?QUJ5QUdFQWFRQnVBR2tBYmdCbkFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnpB?=
 =?us-ascii?Q?R0VBYkFCbEFITUFYd0JoQUdNQVl3QnZBSFVBYmdCMEFGOEFjQUJzQUdFQWJn?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUhNQVlRQnNBR1VBY3dCZkFI?=
 =?us-ascii?Q?RUFkUUJ2QUhRQVpRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFB?=
 =?us-ascii?Q?QUNBQUFBQUFDZUFBQUFjd0J1QUhBQWN3QmZBR3dBYVFCakFHVUFiZ0J6QUdV?=
 =?us-ascii?Q?QVh3QjBBR1VBY2dCdEFGOEFNUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFC?=
 =?us-ascii?Q?ekFHNEFjQUJ6QUY4QWJBQnBBR01BWlFCdUFITUFaUUJmQUhRQVpRQnlBRzBB?=
 =?us-ascii?Q?WHdCekFIUUFkUUJrQUdVQWJnQjBBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBSFlBWndCZkFHc0FaUUI1?=
 =?us-ascii?Q?QUhjQWJ3QnlBR1FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFB?=
 =?us-ascii?Q?QUFBQ0FBQUFBQUE9Ii8+PC9tZXRhPg=3D=3D?=
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [89.155.14.32]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9643980-fb81-4b33-0c56-08d8c766ae62
x-ms-traffictypediagnostic: DM5PR12MB2470:
x-microsoft-antispam-prvs: <DM5PR12MB247052B1897E7245216A7438DAB59@DM5PR12MB2470.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ohDPc85yYogzGGiyC46ksF26nM+/u2cneiUdzu/jvnmuyGcM6kKiTBeX0mQdvlAj191iYag2zDcDe3aR2TiQY4Vr9CjImmcRmdKJxsOg5jvgaQe26SWv2K2Ynp7PWfwov2NlYCuEGONJnywl6C01LquKL8Gz35iAsgPV2vyqXCpQ3perqmGLk5x1gcCOA2HFHUjxY1CKYj/T4Ydvd2hcvN0LgU5aTQhgTXgZDHI29Rzpk5M9FTAZM7sS0Zav7ZilYp+cODoiBcnnTib0kz6Yf58xWL4qhk+KRvaCd7dA9n6U7Qd/cBCchsTyqgMeuomE7H9E62dyhAqudXg2plfJoNb01u648SlfHyX76DkLFujLiRx6xS/4QmYJyTQGeTP9doAKa0SJxIjtAmmWXm+JebLc8cDuMgc4hOn//x5oyfrbnRxFj+cVUbvi/6wK13NB3ghDv3r50r1uSEbNhUV6oVVR7orVevpDwsJwbWQ0kj2aPZnjwy+N0IiTL8sqdJTBkQNc00axFdNUYQ8ff+7Ung==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1835.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(39860400002)(396003)(376002)(6916009)(71200400001)(7696005)(186003)(54906003)(53546011)(2906002)(4326008)(8936002)(6506007)(26005)(86362001)(55016002)(316002)(33656002)(8676002)(66556008)(66476007)(478600001)(76116006)(83380400001)(66446008)(4744005)(9686003)(52536014)(5660300002)(66946007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?uBLTuPlp+eXehA374B0s/++ydH6R6HVE3Cfy0et+iX8QMa8mcHDO/BiCJ9yH?=
 =?us-ascii?Q?6PUnT8UkkMkNQgXtXFANghiQcu561jG8th2yh3t+lxuesfuVIg3KaBdx4G6e?=
 =?us-ascii?Q?X15BSbDPgA+l2EH6fVqaV6GYMASI3Q5BgfUGrSRtDhh1ff22Jf2x8jjdR/5j?=
 =?us-ascii?Q?raV9jyscsPwnYxfBi0WVyfCRblQMtI57xhov/lT65URWPEnVLSiKsVleeJBY?=
 =?us-ascii?Q?vvuWUvgoZClAu2IlwICrlmK6IjFu8skOdZi81ARpQ/h4EPmParCSD2QHr2zA?=
 =?us-ascii?Q?oO+4+Il3JR2pbteWUonf4mFKkPIl/ITix7wy8FJTbdLyX9ZIfRP/lCkivS1g?=
 =?us-ascii?Q?ghcdcd+heC1O0OCcWsT5ts31y5v9E0KY45y2PtIKqTJbMafgAehdcHob20Z5?=
 =?us-ascii?Q?8WskPBCwTmegwFYoLO8C+9wqecP5YQKzL9dCpz9XAr7M5dtXPiVR1f/HAGNf?=
 =?us-ascii?Q?oIirLbysluU9SY2EIq0N0UBXCLGnXQfnIemWZC1WlNvGvHYGvFO4/tCGKzYx?=
 =?us-ascii?Q?e5v6EH1QQa0zerS9SrsjxaozvwklNjZt78/syuCAtFkkbs/n2tNzL49ecHEE?=
 =?us-ascii?Q?6qiRuR4s+McJ0DnqoFzh4FOu+q9dqJKZxXKjQIs8iCIuWqAkhrmBb4kxV/eo?=
 =?us-ascii?Q?XJmWSP5X4mpathyYByLEh4OMKVISsd/S8/bWkNJH5Tpm+EoF1l+cxTwfu5t6?=
 =?us-ascii?Q?j7nHUY3+nvMoXFrHAqbYJOHw12/OSit++QcGtHHlw9C8aRKxxxcleA42gfIp?=
 =?us-ascii?Q?i78E3AJeHgfoas0EB6T5CZLHcxKLgRnQrZdIzbKmPpQUoho1Ock68x9MeQlE?=
 =?us-ascii?Q?XijIpTTdRiSvvf3mK3NU1o2OTIU3A3gEHUpoBS0G4yaSk2WrKQxhz66V+bsY?=
 =?us-ascii?Q?N+H/augovL5TNVUJQ3VCgl/xAKkRis6od6wA4YgdYBLHHntkHYY+aS4zmIkl?=
 =?us-ascii?Q?mEaDlCpkZ3pQxPfefuc08EBapju5MxiIDxUjETMfKBHWjqcU48xrSLWdGtdU?=
 =?us-ascii?Q?f8nH8Lml0jNP/rKgmTD1DUsUwbpfSgJWZP0WIOizjdaM1znjrWi7VYi6E881?=
 =?us-ascii?Q?q2szHJTR?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9643980-fb81-4b33-0c56-08d8c766ae62
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 10:38:29.8368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2V5DmD6zgjbfY3XICHNqj3uoaP0z7UF4jCqLj2dtut6QKVNYDlQ8Y8DM8D679MicDsrvpUXAgu1e/8gw6GkCvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2470
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 2, 2021 at 10:11:21, Greg Kroah-Hartman=20
<gregkh@linuxfoundation.org> wrote:

> On Tue, Feb 02, 2021 at 08:51:10AM +0000, Gustavo Pimentel wrote:
> > Just a kindly reminder.
>=20
> reminder of what?

To review the patch set. I've done the requested modifications, but I=20
didn't get any feedback if this patch series is fine or it needs=20
something more to have an ACK.

If some feedback was provided, please accept my apologies. My email=20
account was having some issues some time ago and I might not have=20
received some emails.

-Gustavo
