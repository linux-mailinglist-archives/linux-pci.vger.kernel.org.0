Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F361D4F2C
	for <lists+linux-pci@lfdr.de>; Fri, 15 May 2020 15:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgEONXA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 May 2020 09:23:00 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:49868 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726140AbgEONXA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 May 2020 09:23:00 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 20A4DC0F08;
        Fri, 15 May 2020 13:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1589548979; bh=EWEN8MS75LrydY49G7dfILiA105fpIr+TZRt1qkDiYc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=hQG6DzozOvevUf7zcjpMeK97kB6IgGgQE7ft3VJb4Wypd5oo8UvjqFcQbbG3DG6L/
         EFrWKlNWz9crSavDUHb09Mso0ahGbsO4zU2ndP+YMaxUwQlF3bJkL6TuCewMnM2rT7
         f8ShTH/DF7wBPSss2n13O3poxGFVmrUXMwFlWDlpI49uD4TJZIfW6YZfkFGqTIZRhu
         EskH3SuQt+hLz10OXbviWgxiUF15wguHErUAQ1Jz7OfBoLAHiRiAvkmQ7MbK1MNdZ2
         oXHuUDev6X8s2Y4EUbtDTngd477fUpFmUwoCW76HjCiN+Co5rlnTC0r7gn19NsbiYo
         yWqo1ZRBqrY0g==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id BE7F6A00DE;
        Fri, 15 May 2020 13:22:58 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 15 May 2020 06:21:53 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Fri, 15 May 2020 06:21:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1D79RPCgFr7pPYF7l591yJylX/nIQ92DzilUJV7j3t+/1BmHGtRrV+6zqO7YPM6JsRBFVqbe9JbYR+lbPbqatcZXZYZYPWKwONTDE/kwj346N1DW4naUS9F0AIRkgJMg3QG3U9t9NQzTHWrklRFUlQZOR0rU9630dRavADtfiDmW2SXUeZujDMXevbpLM7Zgx1y573aX+ap4uupZ96uokCkv2HXuDlAc/bBmfEoydI6fP1p9C8snNvQ6y6MBNn3rDeiklhsd1p+fIccSKeZDLf7kVXHidll3ehbfvoVO6K7wqmpHwU0dT/iaQ9z5T2JJLKFWukeJrDhc5jEw+xYUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2IeESNOvwMbKK8xielUMAbo7uuwrKVRkDuXOn3nRQA=;
 b=fd2uc1KrDwGMl9n3jSA5WBvkvvZw2AQ4AtosMY4MVdbpt1anYvpNagYI0uYjy6egJdYjbTFXpgARvk3SaG5vloy29730AFekpiy3M1u8wbZwcGwKQEQ+g2IWESdyV5XdeMiyOpQ9YOt3uzy+dQXuinVqNDiCg09k82UaSjYMqLJHe028ifSeN2NyHYBUV2rOTVH6/vaxTNhRoM7vAc6jFRivt18mKOjjYOEioiU0b4s2u0PQfRTBt6mr+0+K9p9dMIXB0TatPjAY3GBfxo/+nF7ZV7aqqdorJAy5XfzkZlKIFV7tCcqeI1uWE2p7UTkftlGRHl0Tk7I+FjCU38JRww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2IeESNOvwMbKK8xielUMAbo7uuwrKVRkDuXOn3nRQA=;
 b=ezl+Gc+qbxm+RkyQFnzcEVuTQQKoWWIZFfzys7/r0kzEXIeHjKkTlfKUhuguJfY3ePzf98HMtnMDlQyHgDZrgz+Fjt3BG9cl3P1SCApV+L4uJSBCQ/QUwa24P6Yp8p5Klrho0wZ2EX1iUW+rq84qWmzCjYsw3d0UggYZFA/dGhw=
Received: from DM5PR12MB1276.namprd12.prod.outlook.com (2603:10b6:3:79::18) by
 DM5PR12MB2485.namprd12.prod.outlook.com (2603:10b6:4:bb::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.26; Fri, 15 May 2020 13:21:52 +0000
Received: from DM5PR12MB1276.namprd12.prod.outlook.com
 ([fe80::2062:f350:1cd1:1023]) by DM5PR12MB1276.namprd12.prod.outlook.com
 ([fe80::2062:f350:1cd1:1023%12]) with mapi id 15.20.3000.022; Fri, 15 May
 2020 13:21:52 +0000
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Marc Zyngier <marc.zyngier@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: RE: [PATCH v2 2/5] PCI: uniphier: Add misc interrupt handler to
 invoke PME and AER
Thread-Topic: [PATCH v2 2/5] PCI: uniphier: Add misc interrupt handler to
 invoke PME and AER
Thread-Index: AQHWKqn+J6PejP4smEyuAHg27gTxOKipIg/w
Date:   Fri, 15 May 2020 13:21:51 +0000
Message-ID: <DM5PR12MB1276B952144F1B282A2E4825DABD0@DM5PR12MB1276.namprd12.prod.outlook.com>
References: <1589536743-6684-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1589536743-6684-3-git-send-email-hayashi.kunihiko@socionext.com>
In-Reply-To: <1589536743-6684-3-git-send-email-hayashi.kunihiko@socionext.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTA4MmYxYTUwLTk2YWYtMTFlYS05OGI0LWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFwwODJmMWE1Mi05NmFmLTExZWEtOThiNC1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjQ1NDciIHQ9IjEzMjM0MDIyNTA5OTA2?=
 =?us-ascii?Q?OTAyMyIgaD0iejkrU0tJZmQyMisrYkVrTFRFTEJwaFZ0Rk1zPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQlFKQUFC?=
 =?us-ascii?Q?ZmRvYkt1eXJXQVgrbWhlOHhQR3E2ZjZhRjd6RThhcm9PQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUhBQUFBQ2tDQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQVFBQkFBQUFFbU1la3dBQUFBQUFBQUFBQUFBQUFKNEFBQUJtQUdrQWJn?=
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
authentication-results: socionext.com; dkim=none (message not signed)
 header.d=none;socionext.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [83.174.63.141]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed123073-fcd4-4035-bfa1-08d7f8d2ee52
x-ms-traffictypediagnostic: DM5PR12MB2485:
x-microsoft-antispam-prvs: <DM5PR12MB248552E2A38AF04562272BDFDABD0@DM5PR12MB2485.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 04041A2886
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4i4otP6MZuq3BXIL5MCPyflFfxnJziHsiQ5yp+ij2PZSiQ0IwiMgktyL5zZoKh3T0be/ZsduJzc7D/hRzein9Rl3nkfbKt6P8uyZEAar3w0QQtEnULWyYFjUxo5Bju/E3NkcMja5679sKkRvJjR10HJ26BQh+RgQAxV3fnRHYsNIXKtQCKc22WZo4V4AFZXUgThj0zEBeuYBHOAMtYcXxZQQdGGv0d2B8jLajqgau6Xw9Q2TNudtb9/CbfQKHXoERLZ/FdyZ+phHCeOeQRxyFYB/4ls5Zk3OWDiziPwB3kflT3tCXb7fYEt9P8aWdgveHlVPqKMOkyk3uTGw9sgxtHlLIhy2dnYeTE/Ba0Jk8CNpX798EdoL/tNMG5XQENvZpgeuH0p8jZmZeFS0mWg7zATe+5X7dyRMKJ+rHqGO+U2qrImqC/oT4L+vuKDT8oYs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1276.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(396003)(376002)(39860400002)(366004)(136003)(8676002)(66476007)(52536014)(26005)(66556008)(66446008)(64756008)(66946007)(76116006)(55016002)(4326008)(9686003)(316002)(110136005)(2906002)(54906003)(478600001)(7416002)(8936002)(5660300002)(33656002)(86362001)(186003)(71200400001)(6506007)(7696005)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 2jcOPnUcslIWGusotZb/7A7r09b2Oxj466HW13ABhwzp3dAXlI3dvNtOfGm05zEm+piQXWeL2zoipZIk/gNzF/mlVKJQoUpt5ZvWhgqf5sZcfmRVYrB+AcdfCLLxE/k9/Af7ZuFaU/uAN/G+bxQce91FSw0bPQERRUbuC7APzaEkshFkfX20q20mJFX1hNdTF8S09pxcnEHJOskVYaa1SkNcY9lNo7NjmlPvxITD+uJzQ7xVc8S9Tr+6XN8gINoX0ML/nmCM0rNirdNf4HxWCYgkBDtXwuzXVJRZ67/7qtM2R0mw0QmXqF8jTGqqvB/YZgLHmQIMGIncek9FrOu/5SRGP9FosU9xMHjCNbG27FwWI0GKBmGULOrTFNQGK9jzCv8mkPs9Z1A0ZsGbjuqmn6bQZdWQj/jbeIoUH0c3NOzqQ8xY2iDQEOLxA+nXObkS0U2LGaR1IKS/MPw4VKfAGXspINro2ky3zNMdNuBL22U=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ed123073-fcd4-4035-bfa1-08d7f8d2ee52
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2020 13:21:51.9966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dq4tPoSz0VNTrk4XyHXAG59nzdJJMl/1T2VgxQm6PSo2/a6hyHAQ3DGJxYEeylbTZdk9DepAViBqQ3wwwvK0Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2485
X-OriginatorOrg: synopsys.com
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Marc; IRQ DOMAINS (IRQ NUMBER MAPPING LIBRARY) maintainer]

On Fri, May 15, 2020 at 10:59:0, Kunihiko Hayashi=20
<hayashi.kunihiko@socionext.com> wrote:

> The misc interrupts consisting of PME, AER, and Link event, is handled
> by INTx handler, however, these interrupts should be also handled by
> MSI handler.
>=20
> This adds the function uniphier_pcie_misc_isr() that handles misc
> intterupts, which is called from both INTx and MSI handlers.
> This function detects PME and AER interrupts with the status register,
> and invoke PME and AER drivers related to INTx or MSI.
>=20
> And this sets the mask for misc interrupts from INTx if MSI is enabled
> and sets the mask for misc interrupts from MSI if MSI is disabled.
>=20
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/pci/controller/dwc/pcie-uniphier.c | 53 +++++++++++++++++++++++-=
------
>  1 file changed, 42 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/con=
troller/dwc/pcie-uniphier.c
> index a5401a0..a8dda39 100644
> --- a/drivers/pci/controller/dwc/pcie-uniphier.c
> +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
> @@ -44,7 +44,9 @@
>  #define PCL_SYS_AUX_PWR_DET		BIT(8)
> =20
>  #define PCL_RCV_INT			0x8108
> +#define PCL_RCV_INT_ALL_INT_MASK	GENMASK(28, 25)
>  #define PCL_RCV_INT_ALL_ENABLE		GENMASK(20, 17)
> +#define PCL_RCV_INT_ALL_MSI_MASK	GENMASK(12, 9)
>  #define PCL_CFG_BW_MGT_STATUS		BIT(4)
>  #define PCL_CFG_LINK_AUTO_BW_STATUS	BIT(3)
>  #define PCL_CFG_AER_RC_ERR_MSI_STATUS	BIT(2)
> @@ -167,7 +169,15 @@ static void uniphier_pcie_stop_link(struct dw_pcie *=
pci)
> =20
>  static void uniphier_pcie_irq_enable(struct uniphier_pcie_priv *priv)
>  {
> -	writel(PCL_RCV_INT_ALL_ENABLE, priv->base + PCL_RCV_INT);
> +	u32 val;
> +
> +	val =3D PCL_RCV_INT_ALL_ENABLE;
> +	if (pci_msi_enabled())
> +		val |=3D PCL_RCV_INT_ALL_INT_MASK;
> +	else
> +		val |=3D PCL_RCV_INT_ALL_MSI_MASK;
> +
> +	writel(val, priv->base + PCL_RCV_INT);
>  	writel(PCL_RCV_INTX_ALL_ENABLE, priv->base + PCL_RCV_INTX);
>  }
> =20
> @@ -231,28 +241,48 @@ static const struct irq_domain_ops uniphier_intx_do=
main_ops =3D {
>  	.map =3D uniphier_pcie_intx_map,
>  };
> =20
> -static void uniphier_pcie_irq_handler(struct irq_desc *desc)
> +static void uniphier_pcie_misc_isr(struct pcie_port *pp)
>  {
> -	struct pcie_port *pp =3D irq_desc_get_handler_data(desc);
>  	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
>  	struct uniphier_pcie_priv *priv =3D to_uniphier_pcie(pci);
> -	struct irq_chip *chip =3D irq_desc_get_chip(desc);
> -	unsigned long reg;
> -	u32 val, bit, virq;
> +	u32 val, virq;
> =20
> -	/* INT for debug */
>  	val =3D readl(priv->base + PCL_RCV_INT);
> =20
>  	if (val & PCL_CFG_BW_MGT_STATUS)
>  		dev_dbg(pci->dev, "Link Bandwidth Management Event\n");
> +
>  	if (val & PCL_CFG_LINK_AUTO_BW_STATUS)
>  		dev_dbg(pci->dev, "Link Autonomous Bandwidth Event\n");
> -	if (val & PCL_CFG_AER_RC_ERR_MSI_STATUS)
> -		dev_dbg(pci->dev, "Root Error\n");
> -	if (val & PCL_CFG_PME_MSI_STATUS)
> -		dev_dbg(pci->dev, "PME Interrupt\n");
> +
> +	if (pci_msi_enabled()) {
> +		if (val & PCL_CFG_AER_RC_ERR_MSI_STATUS) {
> +			dev_dbg(pci->dev, "Root Error Status\n");
> +			virq =3D irq_linear_revmap(pp->irq_domain, 0);
> +			generic_handle_irq(virq);
> +		}
> +
> +		if (val & PCL_CFG_PME_MSI_STATUS) {
> +			dev_dbg(pci->dev, "PME Interrupt\n");
> +			virq =3D irq_linear_revmap(pp->irq_domain, 0);
> +			generic_handle_irq(virq);
> +		}
> +	}
> =20
>  	writel(val, priv->base + PCL_RCV_INT);
> +}
> +
> +static void uniphier_pcie_irq_handler(struct irq_desc *desc)
> +{
> +	struct pcie_port *pp =3D irq_desc_get_handler_data(desc);
> +	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> +	struct uniphier_pcie_priv *priv =3D to_uniphier_pcie(pci);
> +	struct irq_chip *chip =3D irq_desc_get_chip(desc);
> +	unsigned long reg;
> +	u32 val, bit, virq;
> +
> +	/* misc interrupt */
> +	uniphier_pcie_misc_isr(pp);
> =20
>  	/* INTx */
>  	chained_irq_enter(chip, desc);
> @@ -330,6 +360,7 @@ static int uniphier_pcie_host_init(struct pcie_port *=
pp)
> =20
>  static const struct dw_pcie_host_ops uniphier_pcie_host_ops =3D {
>  	.host_init =3D uniphier_pcie_host_init,
> +	.msi_host_isr =3D uniphier_pcie_misc_isr,
>  };
> =20
>  static int uniphier_add_pcie_port(struct uniphier_pcie_priv *priv,
> --=20
> 2.7.4


