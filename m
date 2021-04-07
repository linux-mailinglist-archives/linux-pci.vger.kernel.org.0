Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C1F357624
	for <lists+linux-pci@lfdr.de>; Wed,  7 Apr 2021 22:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbhDGUev (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Apr 2021 16:34:51 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:35298 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229685AbhDGUev (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Apr 2021 16:34:51 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2D05EC0967;
        Wed,  7 Apr 2021 20:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617827681; bh=TTB/o0RzE/swUFolUAtiXyXLq1+Xhk3w+Cc78Yno0QM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=LaoYBm+5oOUgER21OjCsBa2OlHVsSqGWHm4B7sJPaW2F4niCJjmlybOJyL5lxyOpq
         LT357wDU+oPgZX6ESpBf9A8sNOmtGwT9ncSB85rRhAmdZppK5WV6DZ09lPbewvzUf9
         uCVPQwBT0xHxQoYxGqxRBlMW/UmGVr8+WCSFuDMUGIByDvxW0q6zHrvIUB8sDYPtc4
         u9mDWyZGoCAqT+9U56sz9Nw5y/3jYF2aIAfa3FhS51w+RnhB+vngU0wtcHhObtJdMH
         ZVCVN6TBazmSUpuZe9B0TBwsWHkPXfPaWPO++iz6nZPOoDHM7EUiALXQKfERueNktO
         e6cJHon5O867w==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 1F63CA0067;
        Wed,  7 Apr 2021 20:34:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7526F80091;
        Wed,  7 Apr 2021 20:34:35 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=gustavo@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="WjyW7jWN";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzBZJic0O0bSu2VB7uwI8WtojvBpcxGFVmytPn1iPGpzyFver6RkVu7HExWvaXmXG3qd2bNkJD345Gf+ozTyoeVgf4O04xfokV+dzWfjT86kA7BPK7Av9bsDyEDlTRyfnaHPrPvQBhxUycZVflr3vL8+SR2ipQrbqJqw3xjFId+2gd9DIGRNfiFvIHbEzSpVfhpyGp64lJ+MsvPWFo3KS0aidYz4l6uT2rjA+i1s857ZX562jB/6iwLfKUnfWUPu6ImIBmcHLqrEfhH34kzCw4E1T6bKsmC7oY6DSxLphXW5JGjGDSt9zFdQnOcfDcRanjFly4o5/gmhUFa5ALWF1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTB/o0RzE/swUFolUAtiXyXLq1+Xhk3w+Cc78Yno0QM=;
 b=LFTS9/0u29ZjOz0TPhMmFrGSYlHmw80vyfkVD2E4isU+HwVdEUVN0b+u+VbJ6nj/KYlXZ5R/JAL+64jzR+8Xv0e0khK4nx1SR8E4aUoq/TeqL94OavspY4G7j2vWoIFG9jvpy9eg8phUKhfZGZMbHIJ7BHG7PNeCzkdhjPqazoyX8IKDkW+ctKdGah3J8b6HW7lCKYJlzAgDwL+HT3PZKeO5mfBm6Nmac3syzDKgICbREptAT1IVRiim/kcnms1Xjw7kcrjKWft+1PFEq43nt5f+6gy044xuJBwjfo5/2paXJ1cFbAYAXBGrfGOCWmL7mTBn1S55gGSFFWsHij6gOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTB/o0RzE/swUFolUAtiXyXLq1+Xhk3w+Cc78Yno0QM=;
 b=WjyW7jWNtq3VGkUgByGsyKxYueLkwj9Y0doe7goRUVEktRYPf8wXcUrm6BAjR/1zJUGYqTHq2UC5waP8vSiPkEkaq3pafB24niEDHwngLcVZS2rJBlZAEARwjOkgRytIo0cSSrM59h0DFD5m1sYBlEWeAGTKALkYEm2N/BlxUkw=
Received: from DM5PR12MB1835.namprd12.prod.outlook.com (2603:10b6:3:10c::9) by
 DM5PR1201MB2504.namprd12.prod.outlook.com (2603:10b6:3:e3::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.18; Wed, 7 Apr 2021 20:34:33 +0000
Received: from DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::5e:b693:6935:78cb]) by DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::5e:b693:6935:78cb%12]) with mapi id 15.20.4020.018; Wed, 7 Apr 2021
 20:34:33 +0000
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
Thread-Index: AQHXKypdwVe497OlBUiL4vQIGQWHJqqolPYAgABJ+BCAAHN7AIAAMYIg
Date:   Wed, 7 Apr 2021 20:34:33 +0000
Message-ID: <DM5PR12MB1835E5B979F1B5E338FFB63ADA759@DM5PR12MB1835.namprd12.prod.outlook.com>
References: <cover.1617743702.git.gustavo.pimentel@synopsys.com>
 <95bef5f98380bc91b4d321c2638d08da61ef6d6e.1617743702.git.gustavo.pimentel@synopsys.com>
 <YG1OaKU7slMHfweX@kroah.com>
 <DM5PR12MB183598B5F93D4DBC515F61B1DA759@DM5PR12MB1835.namprd12.prod.outlook.com>
 <YG3tVEnjUEg5g7mz@kroah.com>
In-Reply-To: <YG3tVEnjUEg5g7mz@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-2?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1?=
 =?iso-8859-2?Q?xhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4?=
 =?iso-8859-2?Q?NGJhMjllMzViXG1zZ3NcbXNnLWE3MzgzN2M2LTk3ZTAtMTFlYi05OGVkLW?=
 =?iso-8859-2?Q?E0NGNjOGU5Y2YwNlxhbWUtdGVzdFxhNzM4MzdjOC05N2UwLTExZWItOThl?=
 =?iso-8859-2?Q?ZC1hNDRjYzhlOWNmMDZib2R5LnR4dCIgc3o9IjEyNzkiIHQ9IjEzMjYyMz?=
 =?iso-8859-2?Q?AxMjcwOTAzOTUxMyIgaD0iWGEydW1UVnFJU2hHakZoc2V0Y0tsUEVBV1Nz?=
 =?iso-8859-2?Q?PSIgaWQ9IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTk?=
 =?iso-8859-2?Q?NnVUFBSFlJQUFDWmZaQnA3U3ZYQVJPZlY4b1hyb2QxRTU5WHloZXVoM1VO?=
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
x-ms-office365-filtering-correlation-id: c0886eb9-d6e4-4e2c-5170-08d8fa048da5
x-ms-traffictypediagnostic: DM5PR1201MB2504:
x-microsoft-antispam-prvs: <DM5PR1201MB2504F734305F11F86AF48440DA759@DM5PR1201MB2504.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x6U3oGNfHhnIbFJlFandM+jzje2PXOqspHZgPCJbivyPrBMefE0MQbPWMgkvKqiLRfm44OBkHv6Dq2z0imloyFj2b6yL6AmUr64h/QlV0CzNjq2pUXCniVndoIskOLIzlGYVQunPWjRyGp26QIgbmdAdwWR0IjvWVFEj4dwk1De6pU75mAStu19U2wnOI5u3hFT/UZf6saSxyDORSegWzE3b/c9QqbFqPV3aSAILLVX5jtmj3WDdB6sRm8nIvL1/PYuOVIix/EgaCafMDFWbrBwIyCbvQl+GDOd6b1rVcHB7wAM30kDvpb49XxPb4T2NyhXXYkKWwkdRjk0XnsG/xtmFyDE3Nwbu4Lq1BXU1oaCK++xJNGBz7bUBpEpst2mGbL0NLtkbdz/XdDAjlBD2u6A1XCawGKU3t4o/f6H9oCcns38L7ijav8BFXuWbdIzODziicoy61+EBGpcXaYHtECbRz5SM073j6HsaLMJfBnN3F95zYZDzwsX9WGW1lawJ5U7Q1Gix5JhC/KAqeO8mTW5n1k0bL79W/M2FnxY1UfR1t7UmfPk2mFcn+aaGI9q22pxThsiU1KEUPgffOSPI/tLuyWnBQMd6sCEg82oBQ4y0qgRuK0mUPPd0a9wsx8W7sldjRpkyU+a/PakCdn4x01HJ2gMwq2+HDV/76WKoBIzu8Zg/qhwg1oC6bXf4FYq0WAd6qxmXuAPZEHb4i6JAbmht1/58rXCAkpH2h0jSsO5CqsVpEvnU72wVoeRIyDph
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1835.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(366004)(136003)(39860400002)(86362001)(4326008)(8936002)(186003)(54906003)(478600001)(316002)(33656002)(2906002)(66446008)(6506007)(7416002)(7696005)(53546011)(38100700001)(9686003)(66556008)(66476007)(55016002)(64756008)(5660300002)(26005)(71200400001)(6916009)(8676002)(76116006)(66946007)(52536014)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-2?Q?8jpgGxznQPAdQmHWUzjD36Q5SQpwxsHwDHEJg9H32vDR9XB4FFGEiyiBS9?=
 =?iso-8859-2?Q?x/y5swucb1svXq6/QkWd94HRtBJxvlKH0D0BRhd0Jr9wNeWPy2s783PiWp?=
 =?iso-8859-2?Q?uVHHHXeX2zEN1awg9RjVEICZzpF4ZTkMMvVDCiEwuxA7DqTIXIa2TnQ7YA?=
 =?iso-8859-2?Q?6lC0APnJrco2EGYxpbQ45xVLFdP5bbxd6Y4iJfQ8MRzbKlSQjbU5eLzmDH?=
 =?iso-8859-2?Q?iLikl9OlaNbsMKmJ4KZLrqETrpAYhoc2PihjOJ6GBeflVhJ232SkPxClKe?=
 =?iso-8859-2?Q?cKKSuM0A+7fZ93u90AD46tqEtM6GrW2R6Cpc8B9C1D3W54TlMC887IwN9I?=
 =?iso-8859-2?Q?mBikq977GZ4CsjT/Bz17ThRQ7Xpsxu0GBfg6PkQ8QFXLBjYzPxKu7Fkt3x?=
 =?iso-8859-2?Q?qkJrLZcrZr1xbK8v4LsUqysisREiprkRd9wAk815iy1JphsXI4rYGuCs4h?=
 =?iso-8859-2?Q?tAUOIlCFl7rnmhgJYm7s/FN8cUy6pp/EUMtAHvN18vio/kv7OwR+hakZ62?=
 =?iso-8859-2?Q?8Xx5kSQHU7QZxBJ+MAg2tKc66R+rWNuiRwCudDnhNxFarIBGVwStP4XH0p?=
 =?iso-8859-2?Q?BEB3b9RyYYHNrQ6RzuacQa40KxKiyu0867cBVeKZDkOvVLOiMXmdbAbFzZ?=
 =?iso-8859-2?Q?89aMtLkMayw1HVFK/AAGWyxqdn6F6iTUELZHt2G1XxHJTNuR7aR4lpXAxG?=
 =?iso-8859-2?Q?Xg8X2UGX5ICu73a4wvt6PLBTzKuIDaHd6P0wxJQofwIIlhXj/v+80CLsz9?=
 =?iso-8859-2?Q?AyAa2tzNreWXSq/byjjjhcz3pNy5Y3jl1soUMMCur1ozB1AEdUCNc6331b?=
 =?iso-8859-2?Q?O6a1LMAfW9+DDI289sgU27RTC3aeMIEg48uaNLNWP/BIeYN0h8C09+R5i2?=
 =?iso-8859-2?Q?VmqgndNDULF83jNyw91s15LpOPbSr1sO6TgtU3/WbFNinQX1xpf0ufapfJ?=
 =?iso-8859-2?Q?cVyu+iOlHdCUDfniniOK770ajXoibsoJsXPzQ8yRUJ9O0kB9A7h8sQcV7l?=
 =?iso-8859-2?Q?eJzJHHEz2FH/xFskxI2lq3iuDuTD24M/MtWUWZ6/6Xzs723l3FLYm7hxaj?=
 =?iso-8859-2?Q?xpXtM2roCFUU0ijTZe+ljQ2WhrSSJ+nYaTd65zgg5QmG+lsLmPN4zKWT/L?=
 =?iso-8859-2?Q?VQ7XFK4kjGYzDnVstaIz+Fj6TSsguZUloL6H5rH8rKY/su43Mn9W4/hlAr?=
 =?iso-8859-2?Q?Y8adG98+3Y2CS0IrIsySiLVcKiK3pUmplvvvRyCEfp5XmKARDxQ/QLG2K6?=
 =?iso-8859-2?Q?NwLRBlLVZosEzQLAHaK27BMW8igRPn8cdblH9uud9Zc6fQ7bHA3/HeTVEd?=
 =?iso-8859-2?Q?JIdaHtcnrglayzBZm5CglaT5Tc8jQuu76/qF8dU1+FH9VcHy0uDjfTMCk/?=
 =?iso-8859-2?Q?cODYRpVBHS?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0886eb9-d6e4-4e2c-5170-08d8fa048da5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2021 20:34:33.4390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 94PoBrNDNBCO4sFdqw4zl69cWjPS/x1kNp6mJXfdfhgcFO7m5dUaoIt2zNXE6SMLR/DgNYRd0vdj4gHNOMSkGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2504
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 7, 2021 at 18:35:16, Greg Kroah-Hartman=20
<gregkh@linuxfoundation.org> wrote:

> On Wed, Apr 07, 2021 at 03:57:31PM +0000, Gustavo Pimentel wrote:
> > On Wed, Apr 7, 2021 at 7:17:12, Greg Kroah-Hartman=20
> > <gregkh@linuxfoundation.org> wrote:
> >=20
> > > On Tue, Apr 06, 2021 at 11:17:48PM +0200, Gustavo Pimentel wrote:
> > > > Fixes indentation issues reported by doing *make htmldocs* as well =
some
> > > > text formatting.
> > > >=20
> > > > Besides these fixes, there was some outdated information related to=
 stop
> > > > file interface in sysfs.
> > >=20
> > > You are not doing this for all "misc-devices", you are doing this onl=
y
> > > for one specific driver file.
> > >=20
> > > Please look at the example I provided for how to name this and fix up=
.
> >=20
> > Sorry Greg, I didn't see an example provided. Perhaps you forgot it?
>=20
> Nope: https://urldefense.com/v3/__https://lore.kernel.org/r/YGyl7OWHJm1Nu=
aV2@kroah.com__;!!A4F2R9G_pg!P8mbZ8v-lsQ9vFXveIVRhy11GV8pgDdGWP7FW51NwcuaI2=
WpDfsuBeCFXIzdFzkTHKTv3oU$=20

That's right, for some reason I was stuck thinking that was some kind of=20
link. My bad.

-Gustavo


