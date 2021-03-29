Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E81F34CE49
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 12:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbhC2Kxy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 06:53:54 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:51636 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232743AbhC2Kxp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Mar 2021 06:53:45 -0400
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7C2E8C00C7;
        Mon, 29 Mar 2021 10:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617015225; bh=62cmHsFMiPsurnD/0Y1pU5Y8vn9XmXgmU9c/ocnOSPw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=NIkxxpbbtp8fJVlYFDG8ldJa9WI84Y3mjpz2OFEYzc0CsNerj2Dv9W6CbznPUoyOy
         Z+zt30LS8fGCxj2a3iGYhJvE+MdP3Ibcu3bOQnb979cBB2uaLNB7QjVVyyrlzK5GVV
         OUmtymRRO/m3B5kPrVkE+xNvLmUzYjZ6CY6ri7Rr7H6POvlVkZUxUGPCbRK0Si9hcw
         qGJg9zBfy8Fhs2+4+qFgBkIYPvsf0H9spqbhS2MNXe2xCPv3phMQ7erAiDuufyEsOa
         tEppjKqhiJTAU10yIrcaTOG5D4cp7JDlsFzdIQjcz5DlhtnOJntVZRGOB1SK/EHLOh
         8XMbSi5oSefLA==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 61DA2A0096;
        Mon, 29 Mar 2021 10:53:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 30C2C400E5;
        Mon, 29 Mar 2021 10:53:42 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=gustavo@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="eXpw5Q40";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRViQ+u8eCfiWEewGFOZSVq1fPqiIhz/oOLdmOUI7DRFrGHS65dfPYw1qLACT4bV5Oz6Myg4rv/d2JsTG6AYrUgR0ArYzES1RuTaOzK/Uzp6zWYRW3mHzWsggYVf186/22kzPmLvPc/w9KexMZzA2pJzaexpm+sGEPbaJCskKwstVcJKGrTCXW2VTm5VHq671EFot046zLTheNSjg5qTZwZ5l9IP/oCVxkJVRPb4jTj5enxcI0m9/ZBgfiCOLdpe/ApQeYvoV66YnMd9axSydzXxfZUZA+ikCmCCpOc2FE02wlHok7BHvHs8BF+6jAWa7QTj+11uTq3HhlY6dl+wmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REddBD67z20VMJiWpynKS6NnE3PPTU2cgIsWfWBcZlc=;
 b=nJXyxTU5jktnz0FqvCDT8GWbty5JcEoCINb95ENlqfeSXqtwftFNO1JADvzHdhYm5NFS7hSDl/tCUL+H4FDLivtZVVVR8gcEgua8YDtCP70Yw6BrvT8YK1o9auixq0gDblfOaghYj89hPiSRaMBWSW0PmmljK5YWUaTP2pLffaB89onNCfUm9DxmmNsxNMaG5w5KQVEcrUdcXN9yk/uCRUJWsE/ViA3QNjn2DgKddT7POkA/FJr0U9Q4aLdrHNmB/tBmhsvp6iWUL9D9QPScYo3fYPHrFg2//vXKt+Rba1+etmdqf4J8eLyJjkZrbRocVx5hTBPGO2B68cBZbSmxBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REddBD67z20VMJiWpynKS6NnE3PPTU2cgIsWfWBcZlc=;
 b=eXpw5Q40UeD1s6fK/lwVn0QMlCheksi65p2SFe2hgTAofGSoAaSu7aBOH8HGiqeX4uL6SdTvJSm3zb5FA0YEoeI7/ATbDmNI9Q9Vd6owy4tjfRchefEACeQpsU52yu83nagW3EyF2T2s02if7RkXr6dkzv6yzeo/XZCJ1wxMFdc=
Received: from DM5PR12MB1835.namprd12.prod.outlook.com (2603:10b6:3:10c::9) by
 DM6PR12MB3180.namprd12.prod.outlook.com (2603:10b6:5:182::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.24; Mon, 29 Mar 2021 10:53:39 +0000
Received: from DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052]) by DM5PR12MB1835.namprd12.prod.outlook.com
 ([fe80::508b:bdb3:d353:9052%10]) with mapi id 15.20.3977.033; Mon, 29 Mar
 2021 10:53:39 +0000
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
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>
Subject: RE: [PATCH v9 4/4] docs: ABI: Add sysfs documentation interface of
 dw-xdata-pcie driver
Thread-Topic: [PATCH v9 4/4] docs: ABI: Add sysfs documentation interface of
 dw-xdata-pcie driver
Thread-Index: AQHXJIJG60dvF/r8ckWOtxY3dz7xnKqavdSAgAAAuiCAAAhLAIAAADwg
Date:   Mon, 29 Mar 2021 10:53:38 +0000
Message-ID: <DM5PR12MB1835FDEFEFE4C8865CDB17F6DA7E9@DM5PR12MB1835.namprd12.prod.outlook.com>
References: <cover.1617011831.git.gustavo.pimentel@synopsys.com>
 <5840637a206dd1287caf142a0dbedf0dac9ccd48.1617011831.git.gustavo.pimentel@synopsys.com>
 <YGGnC8LouF+paZ6G@kroah.com>
 <DM5PR12MB18353C0E6935F94C457F9595DA7E9@DM5PR12MB1835.namprd12.prod.outlook.com>
 <YGGunNguZTiRS8FP@kroah.com>
In-Reply-To: <YGGunNguZTiRS8FP@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-2?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1?=
 =?iso-8859-2?Q?xhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4?=
 =?iso-8859-2?Q?NGJhMjllMzViXG1zZ3NcbXNnLTAyZjA2ODQwLTkwN2QtMTFlYi05OGVkLW?=
 =?iso-8859-2?Q?E0NGNjOGU5Y2YwNlxhbWUtdGVzdFwwMmYwNjg0MS05MDdkLTExZWItOThl?=
 =?iso-8859-2?Q?ZC1hNDRjYzhlOWNmMDZib2R5LnR4dCIgc3o9IjIzMDQiIHQ9IjEzMjYxND?=
 =?iso-8859-2?Q?g4ODE3MzUwMTM5NSIgaD0icC9PY0NHZndKcHZJY3JmcWxjY3R6RjRBTmhz?=
 =?iso-8859-2?Q?PSIgaWQ9IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTk?=
 =?iso-8859-2?Q?NnVUFBSFlJQUFEVGU0TEZpU1RYQWZUejYrTzdGWmt2OVBQcjQ3c1ZtUzhO?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUhBQUFBQUdDQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUVBQVFBQkFBQUFnbk1odXdBQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: 0db4e655-b26e-4159-7e36-08d8f2a0e8fc
x-ms-traffictypediagnostic: DM6PR12MB3180:
x-microsoft-antispam-prvs: <DM6PR12MB31808B881018C8D9CC965D35DA7E9@DM6PR12MB3180.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iWn2xVT7ro23BB3NNtHOsL3MNhomoXQrMX70K3zdzT+KcGxtSdliVvlE93YhR2A9Iu/Zfg2tjFdPQGn3xT85bGwZ4YdsYlLHKvcdZ/JdPLDF6RL58He6czj8/hMdCXPk6rR8Bb8hHH3UUBdBSjHN7BkWlnP6122pCO6qM+J9dJLJSB9YIby422DYWHBq1bqp34JexLelXNW8oevxfjuni+T/wJC91gvUwfBCJP46wP6HU5habMfZ/qZVoxTfH54GV1y8xoKkstSgulGjnW7XUN5/lnNBk165gV/qCaXFJE9I0QQcmulzDNFHFCfC/hgBCihF41vo5z3h1V86K3ntrefvv+pq5H19Mj4BddEXvL0gFFplxifJv+bdLJXo0hDXZPS2ct12YQcyZksHw8GKgtbDjmJX1gJyp8SLIBkvO0jDrVHjVWiTiFKno6tr4gCOQCAFeXLL/V+SSXv31wK1Ijx8uEAo+JCHBQ4bHR00vgep+tXYydi1hlnldZG9nUirMRt+4aYGgK8TO1Ugvz1TgiDoVXB0Iyo/+Patqqf893j9abPTWxfg4d5bMr/y9pSgwEePy2cDfaMlr2fZedTzwHIuE82zpFbmQQkboWERH0sTfQ31HB6EdRPyufQ7MwihnysrwDm+s6UGEuTVMjc1d37/0lFSW4Gx2hmLRISZUnk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1835.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(39860400002)(396003)(366004)(66556008)(66446008)(66476007)(64756008)(2906002)(9686003)(66946007)(54906003)(186003)(71200400001)(6506007)(52536014)(76116006)(53546011)(55016002)(7696005)(5660300002)(86362001)(478600001)(33656002)(83380400001)(7416002)(6916009)(4326008)(8936002)(316002)(26005)(38100700001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-2?Q?3glW1NgrvEJXif/iJmbYPKnuZiMJyaLyq+Tik5OBMaQF3mQxLY272gkrf3?=
 =?iso-8859-2?Q?xL0yNYizPKVOf/cIgi/dCgxj5F3imxTiEBPHzaHa1/JE+gZdaWEIAF0bqo?=
 =?iso-8859-2?Q?T0owyyhk711GKvgCNAHx5KhDBNA0s2PMqbUNvKCeODiUxxA7gMkTB9Tell?=
 =?iso-8859-2?Q?sP9vX7Fsa5apmIofq8OqPw9yL6f1YzhtIKoqBuHAHTPsP+H3Rjx/9SkFjQ?=
 =?iso-8859-2?Q?DQ3wKSgUMLKbHzhX4WRwtutrBsYw1lSkNq9VM8nPj2SSZGPFVisVjESkmR?=
 =?iso-8859-2?Q?gI44eNDfsADzK5F+GJ/U8QD6oMW6h9gnDMccys8ikUixo2nc/8hcroMFcx?=
 =?iso-8859-2?Q?e9THcPLsrRxcRVGZSPwsO+/l3JszGtIm2lRa4qKvCCViEBs0PIuh65tmcv?=
 =?iso-8859-2?Q?L1NE4hhukq+BIYCv87znDyPZxz5Zkxp4mP2lqOsK16QsxJP7Y35+QPqtRo?=
 =?iso-8859-2?Q?oxVKbH+dlWeWb29ouLda5unA/aPPVNY20TPGnfzSGHDhup9xG8BPMZs8P3?=
 =?iso-8859-2?Q?gUEPllld8dDyrQcEUBVgClnmNPsSzDI2FRftDlP5MMTYv8WirZj5ZkDoR3?=
 =?iso-8859-2?Q?1njHJYkJZtDxrc6K7y9P0/dQLj/3ShWhKp9loaJz0aqTSSEl45rmJUENDw?=
 =?iso-8859-2?Q?t8sYWKVsYN0im6QJn223nwZXtmAPS8B7ktyV9/irt+ezljk7tQgg/6ta8b?=
 =?iso-8859-2?Q?b0Yf3LhHGhPlLJwxYYKuwGi7IK4592LONKlp4Hm3ni9QTrT1AVKwe/Zbur?=
 =?iso-8859-2?Q?eYTY5a+tWLon8ItaNxLZWfbj4TsaORnQMuLhDGiaPMzHEeZraRIDgFtshD?=
 =?iso-8859-2?Q?naS4g012Hz07jKgExlsYLty7E9BRaor0qCE0cB8jB86zNE2sozuyz8pvOj?=
 =?iso-8859-2?Q?+RTnqN03vKhy/JfmH3j/dUx5YiLT8RtphVwTs9OhA+yxlteAY9ZhKMdPOI?=
 =?iso-8859-2?Q?kgGCGFLjh9ByIAlYERPktuYESXq3dbKWBU49GViDbtkdkkV/b51+uVTpdM?=
 =?iso-8859-2?Q?2Eb4LTLL0KeYjf6ZnhrcbKzgwVhfT1WZAW6c3Fd77NTIgOw8LaIbNDf03y?=
 =?iso-8859-2?Q?4gVBWdqW4GSyjH2XHnUs+hGkmNE6z1+zmns78C0dG8F7Pw5fZCBMa6tPGL?=
 =?iso-8859-2?Q?PpOknf0nCiRcMcSktQu+RNMZaEAjOoVpVWjW5aBMefCLZOfPE9rdxQ8Ed3?=
 =?iso-8859-2?Q?1Psug49L0FHS7RjqaPm1iIq5skTP0c0BJgXjXJf9G/uieOAG3rIQ/JOVYu?=
 =?iso-8859-2?Q?gPw6lkw6d42OZuODjOVDDmuronlTQU8LDLCVpUUM9OvjWlCO6GkVTDVlGO?=
 =?iso-8859-2?Q?CtB2/aJDnXi5o3JA1U06AUc+SBkW7VrBBIqCR+/tIfnH1kE=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db4e655-b26e-4159-7e36-08d8f2a0e8fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2021 10:53:38.9056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zCssutolLu5bQYdoRnMcZiiefW+xV9MK30s1LZ+yiQnxqA5SvgFiZ2Pnu78R4mZBj8Cd5bIBcKPFcpZ5DSjx7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 29, 2021 at 11:40:28, Greg Kroah-Hartman=20
<gregkh@linuxfoundation.org> wrote:

> On Mon, Mar 29, 2021 at 10:25:25AM +0000, Gustavo Pimentel wrote:
> > On Mon, Mar 29, 2021 at 11:8:11, Greg Kroah-Hartman=20
> > <gregkh@linuxfoundation.org> wrote:
> >=20
> > > On Mon, Mar 29, 2021 at 11:59:40AM +0200, Gustavo Pimentel wrote:
> > > > This patch describes the sysfs interface implemented on the dw-xdat=
a-pcie
> > > > driver.
> > > >=20
> > > > Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > > > ---
> > > >  Documentation/ABI/testing/sysfs-driver-xdata | 46 ++++++++++++++++=
++++++++++++
> > > >  1 file changed, 46 insertions(+)
> > > >  create mode 100644 Documentation/ABI/testing/sysfs-driver-xdata
> > > >=20
> > > > diff --git a/Documentation/ABI/testing/sysfs-driver-xdata b/Documen=
tation/ABI/testing/sysfs-driver-xdata
> > > > new file mode 100644
> > > > index 00000000..66af19a
> > > > --- /dev/null
> > > > +++ b/Documentation/ABI/testing/sysfs-driver-xdata
> > > > @@ -0,0 +1,46 @@
> > > > +What:		/sys/class/misc/drivers/dw-xdata-pcie.<device>/write
> > > > +Date:		April 2021
> > > > +KernelVersion:	5.13
> > > > +Contact:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > > > +Description:	Allows the user to enable the PCIe traffic generator =
which
> > > > +		will create write TLPs frames - from the Root Complex to the
> > > > +		Endpoint direction.
> > > > +		Usage e.g.
> > > > +		 echo 1 > /sys/class/misc/dw-xdata-pcie.<device>/write
> > >=20
> > > Again, this does not match the code.  Either fix the code (which I
> > > recommend), or change this and the other sysfs descriptions of writin=
g
> > > values here.
> >=20
> > I've commented about this previously, but I didn't get feedback on it,=
=20
> > therefore I assumed that justification was okay.
> > I will change the code to accept only the "1" input on the *_store()
>=20
> Why not use the built-in function to parse "1/y/Y" that the kernel
> provides for this type of thing?

I found kstrtobool() just now. I'm adapting the code as we speak.
After testing I will send the v10 as soon as possible.

-Gustavo

>=20
> thanks,
>=20
> greg k-h


