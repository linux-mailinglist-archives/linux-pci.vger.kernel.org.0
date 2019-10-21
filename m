Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 348DBDE5F1
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 10:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfJUIJG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 04:09:06 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:60316 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725972AbfJUIJF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Oct 2019 04:09:05 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E8BDAC0CD8;
        Mon, 21 Oct 2019 08:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1571645344; bh=IeTzdLsOc7n9rD1NZYxEcT5yGYfy7aIWY05cTs/j2LM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=E8m2HBvbLslFeqZyLi/1BQyJxhHnMaGw26Tjclagdwq+YJM5sqynrJcG63WXVHO1S
         2UHEv59oT5UNGp6XsrsBTmgj0RDuP0jLisFp/RCMdcqGRVPp5xzD+reV6mdh0LRaS9
         7T/GNXoEEEM70cNXtC6uitNI4bMYrG5wHNLCeqzbgGW2fITyYly1utd9GTDxKMKIN4
         jkEqzeAhW790MF/06BZ9a5NYDSxL8hqjCJfw42hyvfJA90e5sWrNuoMjYpQ+GYZ0yt
         m/uI2S3im3p1osfSfKQvcLYXsNKD8twxiJtZj5TwdS+5QswYz4xQo5gbc9juU0IIdI
         j+5IgcX3oAFvQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id C501CA008A;
        Mon, 21 Oct 2019 08:09:02 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 21 Oct 2019 01:08:50 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 21 Oct 2019 01:08:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8YoxxCVX6aV/TtWjZjNF8wHOOyp3RB84zmNUD486cN3CK14KWUELMtGfze2tkJHf/G1vGLjuNt/ZG34PFe37YjHsG5RM01JzpQA8eD7aR1CskZceEnAzm40LikdY5OtuvwKDgnzVxo0/xzt0SHCoyNufyz+pHjvnV+Dr/LhiQW5G3VpfT/4DOf8OM4iNXZ/KzjHhWiaJo4IL9aCwZ55wACKde6sO9NVDIit53OxTDFnNiZuVupvEBmQs0VmVGeB4ZKTfxzi1HOHbPYR5hmglZMCSVjWVCNp+W4ACF4h1r6qbdc3oZ5OEhcBvJxfVVjtsICipq1TOvnd5o1YvE0HvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZqrELJwVGUEN5ydY1fkbkYvTmMq1xMcxCsYT3FK1cw=;
 b=llFtgICXsejH4EYAqpl1zyURltpdWh1OR7NxHGxONqtVqX27fuHMXieTXnzN0zjYDgiW9apbKLTVG2JHy22AgSOy1FJlypt0HhLw79wfwupIEtaKSMbKWYw3pIpDT2EYMZq3A4KsHgEhxEnBp2YZb/MBsU+IkeNtqfnhrepORvawocaTEAMm8ZwLkq8DY+PDDQyl85w1Vhqt9E81ELzB++L0ZPujv/aaXW5tZrPCfOrDn9eZ1+Zy4ZRE/gawwWrvLdBsC6GMgTGjeeDNpL30JasrGLECKvZsNztnzGCh4Oh90y8FaB9P6A8HmCvS9r4QW02gl6weQxtraofZ0ZR8sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZqrELJwVGUEN5ydY1fkbkYvTmMq1xMcxCsYT3FK1cw=;
 b=nDMymhCtkV17ULB3Yi5AZz0YD3acJNmnA7OQ5eY4mCWL7ZQ7YmfN6jaISJZNGtqDkAxpWKP9KXgIDXZZfyqgJowCglvkDUF9cbRRWpS5EIAlFY2jIuDGA7HPHzFk2aw3AUBO7ZtxjEdNZxQQIaPAaScgALsOBpSN7WlVu15tRuQ=
Received: from CH2PR12MB4007.namprd12.prod.outlook.com (52.132.247.78) by
 CH2PR12MB3974.namprd12.prod.outlook.com (52.132.246.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.20; Mon, 21 Oct 2019 08:08:48 +0000
Received: from CH2PR12MB4007.namprd12.prod.outlook.com
 ([fe80::c0b:d777:b62d:9a5]) by CH2PR12MB4007.namprd12.prod.outlook.com
 ([fe80::c0b:d777:b62d:9a5%7]) with mapi id 15.20.2347.028; Mon, 21 Oct 2019
 08:08:48 +0000
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Dilip Kota <eswara.kota@linux.intel.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <Gustavo.Pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "martin.blumenstingl@googlemail.com" 
        <martin.blumenstingl@googlemail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>,
        "cheol.yong.kim@intel.com" <cheol.yong.kim@intel.com>,
        "chuanhua.lei@linux.intel.com" <chuanhua.lei@linux.intel.com>,
        "qi-ming.wu@intel.com" <qi-ming.wu@intel.com>
Subject: RE: [PATCH v4 0/3] PCI: Add Intel PCIe Driver and respective
 dt-binding yaml file
Thread-Topic: [PATCH v4 0/3] PCI: Add Intel PCIe Driver and respective
 dt-binding yaml file
Thread-Index: AQHVh9pfHFDGvyZpOU2LFPQUYlLn5KdkvV+A
Date:   Mon, 21 Oct 2019 08:08:48 +0000
Message-ID: <CH2PR12MB4007759DFE5F7F105A7D3363DA690@CH2PR12MB4007.namprd12.prod.outlook.com>
References: <cover.1571638827.git.eswara.kota@linux.intel.com>
In-Reply-To: <cover.1571638827.git.eswara.kota@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTAwMzA0NTAzLWYzZGEtMTFlOS05ODkzLWE0NGNj?=
 =?us-ascii?Q?OGU5Y2YwNlxhbWUtdGVzdFwwMDMwNDUwNS1mM2RhLTExZTktOTg5My1hNDRj?=
 =?us-ascii?Q?YzhlOWNmMDZib2R5LnR4dCIgc3o9IjE5NjYiIHQ9IjEzMjE2MTE4OTI1MzI1?=
 =?us-ascii?Q?MDU3MyIgaD0ic013ZmpnMmRQMHJzM0h6a242NUErQlZuOWlRPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFB?=
 =?us-ascii?Q?TmZvakM1b2ZWQVZ1NDlmaGZKNUNMVzdqMStGOG5rSXNPQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: 35a43bf2-fa8f-47be-19e4-08d755fde6d1
x-ms-traffictypediagnostic: CH2PR12MB3974:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB397498C73A3EA29168A3F4B6DA690@CH2PR12MB3974.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 0197AFBD92
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(366004)(39860400002)(136003)(189003)(199004)(186003)(86362001)(6116002)(3846002)(66066001)(476003)(54906003)(2201001)(110136005)(6246003)(4326008)(305945005)(74316002)(11346002)(2906002)(316002)(7736002)(66946007)(446003)(25786009)(6436002)(66476007)(66556008)(76176011)(66446008)(5660300002)(7696005)(76116006)(64756008)(256004)(81156014)(81166006)(8936002)(229853002)(99286004)(71190400001)(71200400001)(33656002)(2501003)(8676002)(486006)(9686003)(26005)(53546011)(6506007)(52536014)(102836004)(14454004)(7416002)(55016002)(478600001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR12MB3974;H:CH2PR12MB4007.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7tc2TgLWbBgLxLfwDYXaH7zg7qDOuNoQcKU0snAScUayROVLpQ3X6b2OmZW3hV332N1yFPDfGD06Ikfza+N+YTWxd+XlRALnUNOZvvfLd00XDGZRC31jXX1VWuvmLQKMV8wcuqo7mNTsd3kTzLwiej8WaQp78VYLmhXRHW3DrZSK/mdSKygbGtcCU8b7wYd0PsYEJdi3TSSGbiSoYvJocXevMzDeoZ07gUC9YEK2ejhP58LmvYXq5ONM4INO/8KEo9sQBNlX8fvYDROsJuriUdhn3erZx/iIc0CtWdtKzZzXkqP6xXPODmRkx2b3YrIDusIFDuy5LRIotw8XU2eth2gW3NgkDm1116kKuaHrKCo14bqo54myYTE4GHym0O039G3rZPOd0Xh70bKKIUwro40rPbMvwoRlKGtRon22O3hmMeB/jeDygBMnE5F3W4+8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a43bf2-fa8f-47be-19e4-08d755fde6d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2019 08:08:48.1785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W3+k4zaj1keNEPg3ZQKVou28KMLJVtwzexlRuJ4rLEOgb0eTqQQQDtApiahaNKdSF1n3n+/uxvj+0LeU7xQbqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3974
X-OriginatorOrg: synopsys.com
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,


On Mon, Oct 21, 2019 at 7:39:17, Dilip Kota <eswara.kota@linux.intel.com>=20
wrote:

> Intel PCIe is synopsys based controller utilizes the Designware

Please do this general replacement in all your patches.

s/synopsys/Synopsys

and

s/Designware/DesignWare

> framework for host initialization and intel application
> specific register configurations.
>=20
> Changes on v4:
> 	Add lane resizing API in PCIe DesignWare driver.
> 	Intel PCIe driver uses it for lane resizing which
> 	 is being exposed through sysfs attributes.
> 	Add Intel PCIe sysfs attributes is in separate patch.
> 	Address review comments given on v3.
>=20
> Changes on v3:
> 	Compared to v2, map_irq() patch is removed as it is no longer
> 	  required for Intel PCIe driver. Intel PCIe driver does platform
> 	  specific interrupt configuration during core initialization. So
> 	  changed the subject line too.
> 	Address v2 review comments for DT binding and PCIe driver
>=20
> Dilip Kota (3):
>   dt-bindings: PCI: intel: Add YAML schemas for the PCIe RC controller
>   dwc: PCI: intel: PCIe RC controller driver
>   pci: intel: Add sysfs attributes to configure pcie link
>=20
>  .../devicetree/bindings/pci/intel-gw-pcie.yaml     | 135 ++++
>  drivers/pci/controller/dwc/Kconfig                 |  10 +
>  drivers/pci/controller/dwc/Makefile                |   1 +
>  drivers/pci/controller/dwc/pcie-designware.c       |  43 ++
>  drivers/pci/controller/dwc/pcie-designware.h       |  15 +
>  drivers/pci/controller/dwc/pcie-intel-gw.c         | 700 +++++++++++++++
>  include/uapi/linux/pci_regs.h                      |   1 +
>  7 files changed, 905 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/intel-gw-pcie.y=
aml
>  create mode 100644 drivers/pci/controller/dwc/pcie-intel-gw.c
>=20
> --=20
> 2.11.0


