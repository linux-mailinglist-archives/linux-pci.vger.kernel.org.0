Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1401318752
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 10:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhBKJq5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 04:46:57 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:57744 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230186AbhBKJlJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Feb 2021 04:41:09 -0500
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D9386C00B9;
        Thu, 11 Feb 2021 09:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613036408; bh=TwSUFQflXY5XXlksHpZosh4T8hbdcw1v+gRu82XrGns=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ii7xp7dlOi12MMp5XyGlR6aT1Of29g0cwvjNo1P60fBZ9JtSgEVRIVE3HB9LfOmSZ
         GJXVbZU+akATQoknpIA3G7oPUBJw4HlHzB6Brl15vNoFNGPtvFMPXMtxkSCGt+CaPd
         gfO/e0UVbaPpIYHjkP2HEUcnSV8EVf3yEvkx2BdETd51fTd1ruqY//oBJJ8n+wnMfg
         7ICxTInmWxLxt+qqeoMGCJkqZT1kEkvy9Zwsi+V8kbalST7d+6O4IEBqo24AtkfMkP
         UIWK0HYrCvGCm1bf34asgYh/5cqxzA6CcSAb2FJzrqn6UmnEUqBPvxKCTI70/NarAn
         6+p8VHZjTPhnw==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id D71ADA0063;
        Thu, 11 Feb 2021 09:40:06 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id E834940050;
        Thu, 11 Feb 2021 09:40:04 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=gustavo@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="FuAjkRbS";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ToZAFkGnAkuS2lgHc7TYKTtobOH3IUbuiQA8jfl9X6YbztgzSmPzMJFCZ8IDX34ViwF0AWVGcOhh04DcVl/NzyIzFoDryApBVGOGqFuwL5Uf+mig1Ue2jKxPTA/960CmBgHfYmzkp/BOx5hkwawACpKIs8avlno8JSUMKLKFSqN0fSyiW2JqKIv34/iEvHi8fOCfLJfhhTFMHMKOc1sVOr8He+kLv/x3z4SdJgXwOCwYNlcD3z1PAyyEAUlzs9XJpumdB7fVfcxK7wlmH08b55fBEtMEIQfLyNjRaQnlHa7kVVoYrExki7kFgtOHN0cCOHDs8Io2VeK2pJK3BrYEOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ig6n6bqYc2utpwyHaHVB4PTfl4rwTePZ7RefjtHt5M=;
 b=FarDkmPH6VNPWSCpMqc+NZnlalXLfa7i9EKsVKtolfmLT5TtFaJ9Lv8OpQomSZZA9lTmR/Da2PJgrfxjs4pVmsXa9ulZP4vI11lTeBhdGB6E5YH6Wf6LVCPMrd6T6tVxWELc8Q55qS/TG/mqXiqAv09UOC5UzJl41hqU8TqD+008YNSUCNIgUZq8+0xihsGv6EaKIs3YsA7e8clPzEriohYNtKbh8prwqFE1kLOpznlRP6ADdipvNK6BPEr2YYvlfRu+8usgZAZI4gT8zCPxHRO1uYeT7tGOIZZFTT47xEa6pDBTrO/Vh3z6596Gl6J76+yd99hoNR0PBFSpvbPNlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ig6n6bqYc2utpwyHaHVB4PTfl4rwTePZ7RefjtHt5M=;
 b=FuAjkRbSY3DA+d+VWQ415jUVqPoFxdi+ZyF1fHapi+7TowiqvwLLGUdF+2xN0ZSdk8IjFWYaNhpn93IQ44rDvYqbbH4svQqKM5An27yyFno4xMmcNw+hBlFGpvaO73iN9PwpKu8Ye1vBDfzwG+HIaqF9y7jsB4/Qg71YTAaztnw=
Received: from DM5PR12MB1835.namprd12.prod.outlook.com (10.175.88.9) by
 DM5PR12MB1356.namprd12.prod.outlook.com (10.168.237.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.20; Thu, 11 Feb 2021 09:40:02 +0000
Received: from DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052]) by DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052%10]) with mapi id 15.20.3825.030; Thu, 11 Feb
 2021 09:40:01 +0000
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
Subject: RE: [PATCH v5 2/6] misc: Add Synopsys DesignWare xData IP driver to
 Makefile
Thread-Topic: [PATCH v5 2/6] misc: Add Synopsys DesignWare xData IP driver to
 Makefile
Thread-Index: AQHXAFWQQbq2j0UBFUqUdSEWybriUqpSr8CAgAADF3A=
Date:   Thu, 11 Feb 2021 09:40:01 +0000
Message-ID: <DM5PR12MB1835ED3B888F29A575832835DA8C9@DM5PR12MB1835.namprd12.prod.outlook.com>
References: <cover.1613034397.git.gustavo.pimentel@synopsys.com>
 <04060811848603958d9d3c1f2b577169c9021ce4.1613034397.git.gustavo.pimentel@synopsys.com>
 <YCT4qS673nWKJVeA@kroah.com>
In-Reply-To: <YCT4qS673nWKJVeA@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTE4NzAzZDYyLTZjNGQtMTFlYi05OGU2LWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFwxODcwM2Q2NC02YzRkLTExZWItOThlNi1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9Ijg2OCIgdD0iMTMyNTc1MDk5OTUzNDA3?=
 =?us-ascii?Q?ODU2IiBoPSJkbm1sYWdvZXoveEg5UUpkTzV5dWc5NlpPYmM9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFCUUpBQUJ3?=
 =?us-ascii?Q?NThqYVdRRFhBWGYvUXgxQnZXS2FkLzlESFVHOVlwb09BQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: d8871468-9e2d-46eb-d00f-08d8ce710129
x-ms-traffictypediagnostic: DM5PR12MB1356:
x-microsoft-antispam-prvs: <DM5PR12MB13566536BA06DF4EB84C8F93DA8C9@DM5PR12MB1356.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:133;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /r/fTC9JaPOtIKPMp/+EmHZKc0W0Fuaj4pHlViuZB2Bjlmlv9oxXOT9AsvW4xanZP2M6JIUIHJhgzpDfHk8F8cLolNJhSrogDsU2b8QqAb9stkcvLWSQzj0IhHy5MouhNsWpVNZbh7YVBtAG+2v0Pi9libdfVeopIoIF7ujNGx7qdLRvqDdfBYz4cmlXmpBpckdM0y9PHYuP5G0jQaPq7c0VSZ4ABd6ifjs00k82c2AWeTKgH2o8CSO6nj3bYrvPkAkQnDT0mKMB8gu7YXkdpielem/JebNlG3v+sSvJ0f8PWU/WGPli72V+Xfgq9xDMojApU2wvYMtaB/SnRXE/NIowu0uOfEQDlO/FPKHZ669pl4viwQNc0xPLJPRRVJU3dS8vu4GYdGdXJ6njcXaf5E+9n4DKwh8Zp5uSbrYyr99pYEyog8Ei9+nt1YjMBZnrvvn2DvK+A2yM6W7rgEgmrF5jTE7/8I+WZvCmKTbVHnhIGA7oaCy54mEh3KvGqUWuGto/7vWnKO1/Yd8T20IUdw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1835.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(136003)(366004)(39860400002)(5660300002)(26005)(86362001)(7696005)(478600001)(186003)(4744005)(8936002)(66946007)(9686003)(6916009)(55016002)(316002)(4326008)(7416002)(6506007)(52536014)(53546011)(71200400001)(2906002)(8676002)(66446008)(33656002)(64756008)(66556008)(54906003)(66476007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?oa4tMkdP/ocLpmMZ4LoxHMpigEyfIG96HCsAFocd17WwlYTDzKq03SLxDaKZ?=
 =?us-ascii?Q?C+uMne5vg9mZXj25+Q5j8B9h4wYwlGT46nvYC5uX3+ZStoxYYIFgqcrbpY0M?=
 =?us-ascii?Q?M1u3GEpc0uE7mXNkzi/TwkWZc9vXP19H5PU17QWZe2tEOaboDFwseMdNmAB9?=
 =?us-ascii?Q?w4HNCa/YLVQW0IqaJ6Zu0w09io8wWcHpgBBxaLjDg8CKGSVIu4WKfcPXRb1O?=
 =?us-ascii?Q?PP7YwfpNohJgzwuAffCQjHechUH5LFAYkOHUXjVIQeoE3Uez/Xqsd6GEvG3/?=
 =?us-ascii?Q?cLTY5WkRd3qicPc8U73M2gxzGIevM0g4DNS+rgNx86C5NXHMipxDPnGO1dKS?=
 =?us-ascii?Q?/0OKZHTFjGDB/RRHojyu+uUciwxk0VLk1YmBGLCcCNM4ewc9ddK2yk+fkBy3?=
 =?us-ascii?Q?9+VXVYOdfqkkfcsNWQy+T5T5J5NLP9O8xeP6Eef6/+PP3uhRW1XrpqVLbagn?=
 =?us-ascii?Q?hQ//h2aNP0zfmO+eQ5ZxVW/yWTsXd9BmPV0c6bx0WvL1QiMluWvULW3d9SMc?=
 =?us-ascii?Q?uFktDlBjLDQ1XX9zcPw3+FsRLyyEgSUDgj6IaFnNYTLjXRQkVMga1qwQsd25?=
 =?us-ascii?Q?evdtEP9Zeo4YOHHmz+LbExv9bgN2dl/WLkmIJGARiWzhVSRx5fg+ONCESOIq?=
 =?us-ascii?Q?hxUt+vwo/eaptsAMFRjTG+ANn+gcjCeimSq5BHDJBQy6lHB9wWHNUxFjrY2o?=
 =?us-ascii?Q?2cwuH4qC5D7OzOGgeHzYntvyAxD9ivqf5U8nycibdRYZR4XZjl7pM+bQ1/WF?=
 =?us-ascii?Q?b5/XjtXRp1PYGPbW5/GyiIMM4G85eL/Fv5xRERCZphXsr1HQE5iFoSLzWEb5?=
 =?us-ascii?Q?k6GH3Evxr1APlwJ/lrQlJLJjhcl+pZI9sjSXnecFTNMpyd1u0997c/MW2MV/?=
 =?us-ascii?Q?vlVABvI9S6FD1pCr92DkLY1zaqUXUqQvatT4dRyKWmM3uiChWZGLj+WLS18E?=
 =?us-ascii?Q?Dwzl8mSLPB5yalrXcVpdAtHejQJ9BVDkt1SsLGBXYQAmQGprPNxxwN8ZTWwh?=
 =?us-ascii?Q?A32fwgJxSaG7U0yokrMB0hWrLJiEtIqCt5Ott5QXCXhRyeNR9SubECF8vJTe?=
 =?us-ascii?Q?ndWBqn/F87lU+ay9YSi1NPdtqXp2BygKutDBkNrcoAoFwa78fZNvjAzcHCNE?=
 =?us-ascii?Q?g8HMfzuoLGQjVzTzRLPcjSHblhj8f8anTtSXam08KQmjghPRoiqSqSrw8Lyh?=
 =?us-ascii?Q?bSbNrCBdqnO+wlogVaAqzo78uMdf/gEMtXPMZe0agjh1MwiNMQokMPjXrBWE?=
 =?us-ascii?Q?ccjMxki3DL1AD8Y4XK3RtMToLRXG4nHvKkv0ZjwXyIXDphL9yMw9nOMCHivx?=
 =?us-ascii?Q?ZBh8XMekbDHRXuZVnAK8lguh?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8871468-9e2d-46eb-d00f-08d8ce710129
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2021 09:40:01.7449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MBp0RoXGthW1B1DPYOoQSgodyKG/JoheJFkDQ5kGomD5n+JsgGrxSKo0skr+Kbw2cc4ILD9bFxmGcyLU6jeGlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1356
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 11, 2021 at 9:28:9, Greg Kroah-Hartman=20
<gregkh@linuxfoundation.org> wrote:

> On Thu, Feb 11, 2021 at 10:08:39AM +0100, Gustavo Pimentel wrote:
> > Add Synopsys DesignWare xData IP driver to Makefile.
> >=20
> > This driver enables/disables the PCIe traffic generator module
> > pertain to the Synopsys DesignWare prototype.
> >=20
> > Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > ---
> >  drivers/misc/Makefile | 1 +
> >  1 file changed, 1 insertion(+)
>=20
> I said patch 2 and 3 should be merged into 1 before, right?  Why ignore
> that suggestion?  Otherwise build errors/issues will get attributed to
> the wrong commit...

I didn't saw that suggestion, sorry. I can do that, no problem.

>=20
> greg k-h


