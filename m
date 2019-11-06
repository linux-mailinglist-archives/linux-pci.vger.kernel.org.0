Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB58F1295
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2019 10:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfKFJnQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Nov 2019 04:43:16 -0500
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:57540 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725937AbfKFJnP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Nov 2019 04:43:15 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 11E6DC0F34;
        Wed,  6 Nov 2019 09:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1573033395; bh=3hOsAPlIY3ER4FvlpOULmlRL1vF082rfIarwjIxXuGA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=mMDmakd7ARGHOPIAtXUQ79fIcDxB/8GSFy4gZX8w1XrKHQ9r97qZmKeV+j58PFlks
         wY2CxpD/XbyqxvBfwDaNpG5ka5YcEWHkzWrBMAPIEpc8SFV0PUVZTyAOcayqWKkhF+
         +bCBCxGd4UkBOgwBCn/USJFs1N7SOWGjbkJTQTqcpWuF4bQVrOF7nwO4ObMCMyGmne
         BIIvh+w5K/pWpwzo8bzecloCzbB1ZUjAIHAklqxxJxwpOk/ZNV9XZwEedvst5+l5SZ
         Gszyybso32nlvTqxrI3NAjdFP8bSp7Xge82ZsoPPcsas8bBin8sMtSe92F3LPM1U/S
         GOzv+UGnQQV5Q==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id B0D92A006C;
        Wed,  6 Nov 2019 09:43:14 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 6 Nov 2019 01:43:14 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 6 Nov 2019 01:43:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epPSJjARggHILQMzfnaCWoh15RNLKcIC8OtmX1u3ml0Kk5OesAepnXYHG7GBPqX7W28NyMTn0l6qND5MHWEOIAbPp7m/ndey0R4+AA0/Bd47Zl0ENJW0UfFrN+VWQKeHX5vlYjAWMOy7yKFWhxv7B/mpPLa9YM9HpSv/q/RfngBWEoHStWyvqMjUPz9E7yXs6jed2zcpErP2PoQdFqlUlCyig/kafqA+e5N542QHl6RxVxo+q6v1gTzrsUV5qDkkI8AvUjVJYW+R5wGuJEMos1eTbOrHH9m7heuOBEJ53Sy8hL5PStcQGufpzwUZxoAg0Gci/Ajx6owmugbm2u4Olw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUqoSBuPBCCbiySCtCvZKkHXXWG17JVubdqll4QczRw=;
 b=kXasmizrUPcL9+ihDdpEMCiT7oqRtJe7UGA7KzYwfQXLn4n1HyUzTmntn9mUwRSiIG7MxmASaR97Vo5HMmngo3lBF2BiSnvLzJ3ewL+hpymktfCezSI6iitBK0UoICVIhgB3ZlyuBJb8NXdkerLFPjdyDP38b3UgJXtkKBFQitHBMCjPzPchCIHErZhJG547i13yLGwq04DOR3GbTJvI0YX2DD9UaDSutVDVTXIGW7US8Ky4/5GvlPZDTwLT2y/wQ5vrx1E8X2I+jDjryR+CRoy4H/sFf5+E6v2yRVB8usVs9DGPbQFRtYAv9USK8TX+Q2DWaxKYI0U/ux7ia9By1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUqoSBuPBCCbiySCtCvZKkHXXWG17JVubdqll4QczRw=;
 b=N2m2zsMHEAeAkw2WmYvr9C+LgXkHpEOoFM6Dkl+g3RE12TtKf7meRM6zXkccBgdyMlV5AuSz0PUlpA1CQsmPeubTHi/gRYmyctxtkeQo/EIMS8CSoezWU/Lc0yZxVLDCncoeNAtz1qza9XlE3zYgomQFx2DbUZZC/TZmAO1PllU=
Received: from DM6PR12MB4010.namprd12.prod.outlook.com (10.255.175.83) by
 DM6PR12MB3146.namprd12.prod.outlook.com (20.178.30.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 6 Nov 2019 09:43:11 +0000
Received: from DM6PR12MB4010.namprd12.prod.outlook.com
 ([fe80::89b8:dea4:cfcb:a241]) by DM6PR12MB4010.namprd12.prod.outlook.com
 ([fe80::89b8:dea4:cfcb:a241%7]) with mapi id 15.20.2430.020; Wed, 6 Nov 2019
 09:43:11 +0000
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
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>,
        "cheol.yong.kim@intel.com" <cheol.yong.kim@intel.com>,
        "chuanhua.lei@linux.intel.com" <chuanhua.lei@linux.intel.com>,
        "qi-ming.wu@intel.com" <qi-ming.wu@intel.com>
Subject: RE: [PATCH v5 3/3] PCI: artpec6: Configure FTS with dwc helper
 function
Thread-Topic: [PATCH v5 3/3] PCI: artpec6: Configure FTS with dwc helper
 function
Thread-Index: AQHVlFSRmTvknTCkuEuaIAbD8VWYD6d95E+A
Date:   Wed, 6 Nov 2019 09:43:11 +0000
Message-ID: <DM6PR12MB4010413DC722963F00461666DA790@DM6PR12MB4010.namprd12.prod.outlook.com>
References: <cover.1572950559.git.eswara.kota@linux.intel.com>
 <90a64d72a32dbc75c03a58a1813f50e547170ff4.1572950559.git.eswara.kota@linux.intel.com>
In-Reply-To: <90a64d72a32dbc75c03a58a1813f50e547170ff4.1572950559.git.eswara.kota@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLWQ2ZTUyYWIwLTAwNzktMTFlYS05ODkzLWE0NGNj?=
 =?us-ascii?Q?OGU5Y2YwNlxhbWUtdGVzdFxkNmU1MmFiMi0wMDc5LTExZWEtOTg5My1hNDRj?=
 =?us-ascii?Q?YzhlOWNmMDZib2R5LnR4dCIgc3o9IjE3ODEiIHQ9IjEzMjE3NTA2OTg5NDYx?=
 =?us-ascii?Q?NzE5NSIgaD0iQXFiSE11V3hpNGNPekdBNFl6QVh4Mm53YTZvPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFC?=
 =?us-ascii?Q?cktEdVpocFRWQVJQOXk1Tktvc2FqRS8zTGswcWl4cU1PQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: a1abda53-e425-4bef-4e85-08d7629dbd1c
x-ms-traffictypediagnostic: DM6PR12MB3146:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3146375A7DB4CA320BA7A8F7DA790@DM6PR12MB3146.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(376002)(346002)(366004)(189003)(199004)(316002)(476003)(11346002)(110136005)(54906003)(33656002)(7696005)(446003)(486006)(2906002)(305945005)(8936002)(6246003)(4326008)(71200400001)(6436002)(2201001)(229853002)(186003)(71190400001)(86362001)(9686003)(26005)(102836004)(66066001)(99286004)(2501003)(53546011)(256004)(6506007)(76176011)(14454004)(52536014)(66946007)(66476007)(66556008)(64756008)(66446008)(25786009)(76116006)(478600001)(3846002)(6116002)(7416002)(81166006)(74316002)(8676002)(81156014)(55016002)(7736002)(5660300002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR12MB3146;H:DM6PR12MB4010.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mc+NMmJorklXpKlonl6cEhVla+IsUwKFU9RB2L10FqYHOkFbOmBmAmmhleKRFDT21liGjHryzaGT2Z3GJxyX4ejoKLKjaLS+iCF6wpT5UKnAhtxGHbXy+CsWGtRG46SCeFkMJqbJxvQiTgt6qf1iqERLDFnnxYVzZfwnC8Di9KRclYxvLIgsSF8svm1dYwXrGNNuUuVxOmkfZOEYCYloJLLegNgA9rrHI3yo0xqTvcgoOK4PRZXKuTRn9oL4lF+apRHg2kenqksF8AiP27Tp4d6T6HxoCdLGO9L3HvZiKd0F31dkavg6/ESezug43HWiz1AuL2lMAlaW/JymeOSszjUg4Bh5Ub5gX0UgjhtOmD1moO3rFHVZ8GkElzIoFpyqiFzhmCzuV9Nj2n+tOzRvnly38vah4pkcCalBewV8oKFfYUKuqf4I8CU4PiCGb+lX
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a1abda53-e425-4bef-4e85-08d7629dbd1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 09:43:11.7031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B2D5PcOWqDEN4AGz65YHde92w48iSm8gGcXXURqlJh7pYPpARtIR3dzObGxx6eRbvjPMWdXvX31vEQQZW9LZ3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3146
X-OriginatorOrg: synopsys.com
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 6, 2019 at 3:44:3, Dilip Kota <eswara.kota@linux.intel.com>=20
wrote:

> Utilize DesugnWare helper functions to configure Fast Training
> Sequence. Drop the respective code in the driver.

Please fix
s/DesugnWare/DesignWare

>=20
> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> ---
>  drivers/pci/controller/dwc/pcie-artpec6.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/cont=
roller/dwc/pcie-artpec6.c
> index d00252bd8fae..02d93b8c7942 100644
> --- a/drivers/pci/controller/dwc/pcie-artpec6.c
> +++ b/drivers/pci/controller/dwc/pcie-artpec6.c
> @@ -51,9 +51,6 @@ static const struct of_device_id artpec6_pcie_of_match[=
];
>  #define ACK_N_FTS_MASK			GENMASK(15, 8)
>  #define ACK_N_FTS(x)			(((x) << 8) & ACK_N_FTS_MASK)
> =20
> -#define FAST_TRAINING_SEQ_MASK		GENMASK(7, 0)
> -#define FAST_TRAINING_SEQ(x)		(((x) << 0) & FAST_TRAINING_SEQ_MASK)
> -
>  /* ARTPEC-6 specific registers */
>  #define PCIECFG				0x18
>  #define  PCIECFG_DBG_OEN		BIT(24)
> @@ -313,10 +310,7 @@ static void artpec6_pcie_set_nfts(struct artpec6_pci=
e *artpec6_pcie)
>  	 * Set the Number of Fast Training Sequences that the core
>  	 * advertises as its N_FTS during Gen2 or Gen3 link training.
>  	 */
> -	val =3D dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
> -	val &=3D ~FAST_TRAINING_SEQ_MASK;
> -	val |=3D FAST_TRAINING_SEQ(180);
> -	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> +	dw_pcie_link_set_n_fts(pci, 180);
>  }
> =20
>  static void artpec6_pcie_assert_core_reset(struct artpec6_pcie *artpec6_=
pcie)
> --=20
> 2.11.0


