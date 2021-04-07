Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD93335713B
	for <lists+linux-pci@lfdr.de>; Wed,  7 Apr 2021 17:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhDGP5w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Apr 2021 11:57:52 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:50560 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243050AbhDGP5v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Apr 2021 11:57:51 -0400
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 212E3C0962;
        Wed,  7 Apr 2021 15:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617811060; bh=ZSOnZ/loOD0IzvsSHbcmVS+gJrjcbkUoB/bRA1mAF6Q=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=NaPNpQiLaFxOFdXHwYxtmr3iEfZsaHdZK2kRTst8wibE50Aq6u2l1likkcnJFyBv0
         ibY+9BB0oINE0gmHGWVfXIN4sFZvPqqHoGAtPM41AS0lkNlPVpkK9c28/Gab2FTsc8
         31yeYTmagtld9HrnJBej09VDYB3WlfjxfGNR7SJJIujcd4L/bL+NxgKTBy4qJshsh+
         FdRFWxh7vJJqBmOYmn6RCr6oJ14OGJ9gPItns+DRFCNBRc4KBWDHY1KuZjVkFgrnDE
         rVlIq+WNqKqBTJP40AoCc+b17NP68IDlRAF/LnqOi7i4VTOAejB176IktZzb25slSH
         zv1peyLbi8Baw==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 9C85FA007C;
        Wed,  7 Apr 2021 15:57:35 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 3B0C540132;
        Wed,  7 Apr 2021 15:57:33 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=gustavo@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="Kt6eNVa+";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLqtIe3CIfCejGjtLnZxo6mWcb/77uqnq+kJt2vStPyFlqZF8yofX0ll86UX000PQ0sJ9R4HN2xLvRKFuXjsV6jcN2rc7/8dti4wbEJC3gBdt+4gzrD220ut80X7a+48QYcA+5Xj2nf5D0XPy7Pbz9aaLYnwm2SHILP1QS7EKyVog9ghWi3dFTCJZymwzIjdSGtwmzzPOIfTqvj5oqZOYvN9QQl0JlYKcxlBBp7KUNooma5okhQXnhcLCasEBpqvX2vnrsIvJBjVKiUu9+jYefZSktGbogh8vKVcAdCCwdxtknX1cfa8NDtqRu7axYpMCFCnQOqCOIzhXaWv55ks8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zuLSx22/KawCY0hPUUlM+q3b5lD7skTnj1X/HHnNeE=;
 b=O8a3Omj33f9mV/W3GSYgFzsdhtkMMEkl4EG7UYDJCqqI846DHluLFcDDTE/4mluwX7ML2G/b3H80jYuOtm7z+wrCTVo8wDU9gNfgkQ1siaJjad71RKZwqRClEGSecP/BtlwyJ0GBcMpZlQ23qJiyjec9oG+7ome0B6oZiGzTDWJpYWq8oOFyM+hnXF/091YBkAL3ZzkyCacAQeLNdbnCfYVFtOMesTLMl7pL4lY4FoVkbzsAchp/nkSx95QR793XUEjeByL9agkShAlCOXp5Jjxi4AjJ9CU5Ucv6eEm20yg6SnQZPG+iUxA/DlWhO4qDqF7nvNMmqZ0KJg/i1oPupg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zuLSx22/KawCY0hPUUlM+q3b5lD7skTnj1X/HHnNeE=;
 b=Kt6eNVa+yv/r77lrgal9HmeCesbZTZbs8iocLXDcDv3Pwl/zFP4S6ftD4LoTXSXvAXds23PUr99dFryoi35vQm6EzkcPKJDdoIGZEEBAOdZRfLgCfFcYQN8OY7oblV9wb7sARKFuoAQ6vjDZFM+BlG1m/kYxVEso4bQaasd/a6I=
Received: from DM5PR12MB1835.namprd12.prod.outlook.com (2603:10b6:3:10c::9) by
 DM6PR12MB3580.namprd12.prod.outlook.com (2603:10b6:5:11e::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.32; Wed, 7 Apr 2021 15:57:31 +0000
Received: from DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::5e:b693:6935:78cb]) by DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::5e:b693:6935:78cb%12]) with mapi id 15.20.4020.018; Wed, 7 Apr 2021
 15:57:31 +0000
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
        Bjorn Helgaas <bhelgaas@google.com>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: RE: [PATCH v2 1/2] Documentation: misc-devices: Fix indentation,
 formatting, and update outdated info
Thread-Topic: [PATCH v2 1/2] Documentation: misc-devices: Fix indentation,
 formatting, and update outdated info
Thread-Index: AQHXKypdwVe497OlBUiL4vQIGQWHJqqolPYAgABJ+BA=
Date:   Wed, 7 Apr 2021 15:57:31 +0000
Message-ID: <DM5PR12MB183598B5F93D4DBC515F61B1DA759@DM5PR12MB1835.namprd12.prod.outlook.com>
References: <cover.1617743702.git.gustavo.pimentel@synopsys.com>
 <95bef5f98380bc91b4d321c2638d08da61ef6d6e.1617743702.git.gustavo.pimentel@synopsys.com>
 <YG1OaKU7slMHfweX@kroah.com>
In-Reply-To: <YG1OaKU7slMHfweX@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-2?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1?=
 =?iso-8859-2?Q?xhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4?=
 =?iso-8859-2?Q?NGJhMjllMzViXG1zZ3NcbXNnLWY0MDY2MGFkLTk3YjktMTFlYi05OGVkLW?=
 =?iso-8859-2?Q?E0NGNjOGU5Y2YwNlxhbWUtdGVzdFxmNDA2NjBhZS05N2I5LTExZWItOThl?=
 =?iso-8859-2?Q?ZC1hNDRjYzhlOWNmMDZib2R5LnR4dCIgc3o9IjE3NTIiIHQ9IjEzMjYyMj?=
 =?iso-8859-2?Q?g0NjQ5NjA0ODUxNiIgaD0iVTQzZ3BiQ2M4b0Nza0dySXBidmh2VFc3aGxz?=
 =?iso-8859-2?Q?PSIgaWQ9IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTk?=
 =?iso-8859-2?Q?NnVUFBSFlJQUFDRWhYKzJ4aXZYQWFBdWM2SlovYXJ3b0M1em9sbjlxdkFO?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUhBQUFBQUdDQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUVBQVFBQkFBQUFDQzFsQ2dBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFKNEFBQUJtQUdrQWJnQmhBRzRBWXdCbEFGOEFjQUJzQUdFQWJnQnVBR2?=
 =?iso-8859-2?Q?tBYmdCbkFGOEFkd0JoQUhRQVpRQnlBRzBBWVFCeUFHc0FBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQU?=
 =?iso-8859-2?Q?FHWUFid0IxQUc0QVpBQnlBSGtBWHdCd0FHRUFjZ0IwQUc0QVpRQnlBSE1B?=
 =?iso-8859-2?Q?WHdCbkFHWUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBWmdCdkFI?=
 =?iso-8859-2?Q?VUFiZ0JrQUhJQWVRQmZBSEFBWVFCeUFIUUFiZ0JsQUhJQWN3QmZBSE1BWV?=
 =?iso-8859-2?Q?FCdEFITUFkUUJ1QUdjQVh3QmpBRzhBYmdCbUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQm1BRzhBZFFCdUFHUU?=
 =?iso-8859-2?Q?FjZ0I1QUY4QWNBQmhBSElBZEFCdUFHVUFjZ0J6QUY4QWN3QnRBR2tBWXdB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdZQWJ3QjFBRzRBWkFCeUFIa0FY?=
 =?iso-8859-2?Q?d0J3QUdFQWNnQjBBRzRBWlFCeUFITUFYd0J6QUhRQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUNBQUFBQUFDZUFBQUFaZ0J2QUhVQWJnQmtBSElBZVFCZkFIQUFZUU?=
 =?iso-8859-2?Q?J5QUhRQWJnQmxBSElBY3dCZkFIUUFjd0J0QUdNQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQU?=
 =?iso-8859-2?Q?FBQUFBSjRBQUFCbUFHOEFkUUJ1QUdRQWNnQjVBRjhBY0FCaEFISUFkQUJ1?=
 =?iso-8859-2?Q?QUdVQWNnQnpBRjhBZFFCdEFHTUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5n?=
 =?iso-8859-2?Q?QUFBR2NBZEFCekFGOEFjQUJ5QUc4QVpBQjFBR01BZEFCZkFIUUFjZ0JoQU?=
 =?iso-8859-2?Q?drQWJnQnBBRzRBWndBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQWN3Qm?=
 =?iso-8859-2?Q?hBR3dBWlFCekFGOEFZUUJqQUdNQWJ3QjFBRzRBZEFCZkFIQUFiQUJoQUc0?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ6QUdFQWJBQmxB?=
 =?iso-8859-2?Q?SE1BWHdCeEFIVUFid0IwQUdVQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFITUFiZ0J3QUhNQVh3QnNBR2?=
 =?iso-8859-2?Q?tBWXdCbEFHNEFjd0JsQUY4QWRBQmxBSElBYlFCZkFERUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFDQUFBQUFBQ2VBQUFBY3dCdUFIQUFjd0JmQUd3QWFRQmpBR1VB?=
 =?iso-8859-2?Q?YmdCekFHVUFYd0IwQUdVQWNnQnRBRjhBY3dCMEFIVUFaQUJsQUc0QWRBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?SUFBQUFBQUo0QUFBQjJBR2NBWHdCckFHVUFlUUIzQUc4QWNnQmtBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQU?=
 =?iso-8859-2?Q?EiLz48L21ldGE+?=
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [89.155.14.32]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d984152d-c86c-4b98-f3c5-08d8f9ddda05
x-ms-traffictypediagnostic: DM6PR12MB3580:
x-microsoft-antispam-prvs: <DM6PR12MB358084F7BE4441EEDF3BA5C9DA759@DM6PR12MB3580.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OIywh1iXAmFodaVh2Nef4XPzesAKpPXQrQZERmcpZ3E4aBkO1MWfhyehgZMcfoAq0F5BdSswxihLJTAs66HRWv5AS9jn52DELWBZBGCBxuAyU2mn7PuAlpTEXx9LLQQY3gjr0jQa2QgX6Xb5aC49d2CR0uLX0vdxLOf/bdSIY9wjgwmSxoYJR393QSOVW+W1mfnwcrz2HqCcsd3MnZ8W+vcek7ehEBAZs1+epTXhzvlJO5tFwIGyi4jenngLLYcAmOIedaYaT7T60ZSYeiAPm9l699f/bRn1PNrbvhXQ52XvNNEIcTz5IGZG/BiXTf0tBtPdTnrAn9hRZFnndlN76B2uXZ91+D3WxF3ton4OD6jlXb5TaSqq85krFq6GMy3Sz19dD1C/VGh0uVb5ePAJLvMZH70FErLPehcAyPZY7wo7/tmYZOvCXDmxa8R+BExBXSXZq42mF9k39LoJhdiRbVUA2PDcJ+VU/OUcWRgId09LJxl5nxMCxRP29QkqpgLu49+W11fF4z24ujdx4dn4f7BpY/1OT3Mpmxjo3D9jhi9cXrXEYerPCMhcHcPirli2yIVQVUALIa0VXLSWTFEcRkSU3fJkz7BhWC1dWgOX0fpcaiubY9anNlEJReXM4nTtqCP4vowH6UROqyXxaGGXspUH+sNFv29FuvQ//F2XtIynaCcf9mynU9GFcPnO59sMBf+fQ5lfXGkUEWz2F5bnK/j1IUe8d0RhbaMTABNMRyFkoci/aW5lsKi0SWqpclsf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1835.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(366004)(136003)(346002)(396003)(26005)(83380400001)(9686003)(186003)(66446008)(76116006)(7696005)(66946007)(66556008)(64756008)(66476007)(2906002)(52536014)(55016002)(7416002)(316002)(4326008)(5660300002)(54906003)(478600001)(38100700001)(6916009)(966005)(6506007)(53546011)(33656002)(8676002)(86362001)(71200400001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-2?Q?CNtnUUoPW8/ZNuBqKuvlYpadpnRtyQntVPBLpJAci51RZ1IpLxuKeaL37s?=
 =?iso-8859-2?Q?7XFppIRCG2hGfHb39fro+/EmvWrQBZ3bgUkqQlHTvR3V8Ff9HWMua8zclv?=
 =?iso-8859-2?Q?M9TrG02cqSbbtIVI1l2v9Wx96jODunPYWsoFMltRbavON/LGqEy9mkP0rB?=
 =?iso-8859-2?Q?PUlQ2ZvTFr43DomQ7ehNdeFPncZs5F2E1MTqRjQLPozzB4ezkq02bDbjpJ?=
 =?iso-8859-2?Q?7Hp9/ckvdE7iy+xC/rznfiYmrD67tFiHbkE8flnWoAPpHRTgZ44j+5pjsX?=
 =?iso-8859-2?Q?rAmEBcq9vFhUljPX8cONFojw17A2AzYLDgj2HTpCrBn+bH1IPXFDRxWtct?=
 =?iso-8859-2?Q?owODQgLXGyBwpWBrL5X/Dy++JGwdx2Z5mK4a+BJIjmFcPTwQx3V/OhLLq4?=
 =?iso-8859-2?Q?z5+mF0mEgexwtcwmoPWTEbDJ7Adm4HfSv2Fow1y1Jh0jqpAQKgJrzq6W7Q?=
 =?iso-8859-2?Q?h1vt8F80yQDMUrU4vPIgs6zsAR/18plY7esuYYnTxBIa38zW5+jlIjrAbG?=
 =?iso-8859-2?Q?uWm4UpS807N+uHFnQZa/KOdfCuCIQp2wDyjkKd0RHYfepYoNUmNhY98Ton?=
 =?iso-8859-2?Q?ARfn7SfgvgujQzirbAcUjxZY0wp+n3WmsXh2ZZSKWJfWAi+mHooPXEpZTk?=
 =?iso-8859-2?Q?yYKxeVsbV2qW0vxPaFy2VCPcVcIEaUjapKnLt7u4inhKW8v+IWuRkieKIh?=
 =?iso-8859-2?Q?xAwz/9XC9vvy4sR0CY9XM5w6T/Nd0KvjeOiqBfrNqJNQJHV+u6QJud/UwD?=
 =?iso-8859-2?Q?vi/bAJ0eiW+71vsdtGuqRAErOzJKHyabfKR+5SwxaENrILWj7Xwdxj1Xwo?=
 =?iso-8859-2?Q?49PH9yGJP+5qnsJjOzJFSBuuMKRfdS9HDpdtJ9a9o1IQKSYQG3rDBbiHqq?=
 =?iso-8859-2?Q?2H/NUAPROhRBrdtLaqMxULv3HJyrgIU/Y7IB1qIK7dgoKSX3jrWE8SThOX?=
 =?iso-8859-2?Q?XnC7hQKsmvHQ0JNh0TIqJUygLLsuGjyrQUwLLpmQNjjl7227nOvqd7vaW3?=
 =?iso-8859-2?Q?mhC7vIKnEljvtYtrseDJv5m3L8HXy1VRaHGhzsM8A2tO4Dk+MTTTVmQQtU?=
 =?iso-8859-2?Q?klh0FK2/I2hHXrTvE81lDB05L62J62xjtuehWSBf0M7m66pZuqAafhVN9z?=
 =?iso-8859-2?Q?lqG+5HGO6+IoCd767X/h7jt/CIqPlsiCwEkdep9daIMI8NW/086nnuHgHK?=
 =?iso-8859-2?Q?aNLmWQbhfElHKnaUPrSnD4R9Z3M/iTQEM6e8IgCzs5rLZO6DAb4gIqniLG?=
 =?iso-8859-2?Q?roTnV5czNV5hW0Je3HkhbMY68/q/SLH1dV8RMTPKXszWul04dJNl3IM6zR?=
 =?iso-8859-2?Q?aSmfQS6KmTUXWFBVKbPu+t9dWEjvEWtHq+p7psFUP/VMc2F1no25FpfENA?=
 =?iso-8859-2?Q?uo4Ykh7x3l?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d984152d-c86c-4b98-f3c5-08d8f9ddda05
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2021 15:57:31.2447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zgn0afXXiK/zmX54DPFv0XQiOe4Dz7awgZiw3oi/d3xFhtqwUlzhtBlzbeP1yL5lecH89qwLdxEJVjN82BmvcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3580
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 7, 2021 at 7:17:12, Greg Kroah-Hartman=20
<gregkh@linuxfoundation.org> wrote:

> On Tue, Apr 06, 2021 at 11:17:48PM +0200, Gustavo Pimentel wrote:
> > Fixes indentation issues reported by doing *make htmldocs* as well some
> > text formatting.
> >=20
> > Besides these fixes, there was some outdated information related to sto=
p
> > file interface in sysfs.
>=20
> You are not doing this for all "misc-devices", you are doing this only
> for one specific driver file.
>=20
> Please look at the example I provided for how to name this and fix up.

Sorry Greg, I didn't see an example provided. Perhaps you forgot it?

>=20
> >=20
> > Fixes: e1181b5bbc3c ("Documentation: misc-devices: Add Documentation fo=
r dw-xdata-pcie driver")
> > Link: https://urldefense.com/v3/__https://lore.kernel.org/linux-next/20=
210406214615.40cf3493@canb.auug.org.au/__;!!A4F2R9G_pg!MeIXpmOYi4yJTBq19JEA=
Dll7-g6cYBmmwG92EWipqsBiPzeubfMGVllrpMt8FpwvW5ZemHY$=20
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > ---
> >  Documentation/misc-devices/dw-xdata-pcie.rst | 62 +++++++++++++++++++-=
--------
> >  1 file changed, 43 insertions(+), 19 deletions(-)
>=20
> What changed from v1?  Always put that below the --- line.

I've considered the V1 the 2 patches sent wrongly separately, based on=20
your feedback I've generated a v2 to include the cover letter and the=20
reported-by, link, and fixes tags.
Was this wrong?

I also placed the change list on the cover letter. Or do you prefer on=20
each patch?

>=20
> thanks,
>=20
> greg k-h


