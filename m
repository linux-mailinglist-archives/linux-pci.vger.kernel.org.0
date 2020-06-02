Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1BE91EB63D
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 09:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgFBHLF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jun 2020 03:11:05 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:37348 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725921AbgFBHLE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jun 2020 03:11:04 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 28B1E40556;
        Tue,  2 Jun 2020 07:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1591081864; bh=t3LqRQ5yj1Ovopl4FvYyFn0kYVtRSf3/l5HfCbWX7gI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=dYjDJ5nbvoAM2+47mJXImHsBo7D7BAvhrM35YzWLVVAEmKM8cL2YvwJuWWIQ3LxTu
         Jf3mEo0uabRsBpKrTsl0lfwYjW5382JTQe4Tr7KzKcn/HcESU/C+NsGuixH0Ug3ThC
         PQRBloivTWtl2od/sYgBEdd4baXuUuPjEabYte8ojKgWVUd+IWLWw4GnzWCegFGsye
         r6SX8tEAf/9jJGrQ+x+8hrBgIoJz8TFItRKXsumoOaXTP8KxBVFTSI4RkC67yyrG5B
         CYSv8uzYD50B9BC77g8o7q5h329C2ixIy46PKKM+8zRC6zKksy/f3u7wzGitmcs5ob
         kSDavkkE0G1Dw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 992DBA0069;
        Tue,  2 Jun 2020 07:11:02 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 2 Jun 2020 00:11:02 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Tue, 2 Jun 2020 00:11:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEsLeBOuzdXz5VyXOh1i6VDm8FJDBeU0G1Nb41kjK09v9Wvq6PuvVlGEFrwqByLzULlwPSJ0YZMxHYmIllT+MxGtt8X6cm+NyMffiJV+a7vdTVO7kYx1l9xI3NXZXIMbY/Z6Q2uRScgrlbhHul7tzKaFTgrMrakH5dl5+TsV4GUYKEuU7aTG9T12sMKxqJ5LJudGXZ9s0T3eyArbTQcek/lTlXlPU2MQb7ICMk0vQMsShKtmbwcK1HUBPrgXljTtreSVirkRgOiearXM9DEr0Ny6WUWnIKmlh4KMs6sLWUPZIZN9R5Nr57iJ33l1E1TKrQIjiF/xQ162Eg2jYXsHVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxyZUlbLVHWh6I8Anaw/wwDrLQsyRufFpiyW2WHmut4=;
 b=lKc3v33lCcKbZlBuV78A0tzc66e4pRWz0/PrU1TSheQrVh5ihd/s0maEdJfCoqDRN8Sh28YmuOnIIFn83S2j8SKIvWu1k8TgGQ0NFUAQgVcFLse+fuWPLoP70VdZjTstxUoGU7WmsiYvxKRfX7sfqF1aYm3LCK19Z6MSVyeAXpexCHJ8wVs4MyzmosoE39UVSPZYBah9kw3BlhO9iC4HiHp1A9xGYNEqi+uvH3o7oJDrkjtk1Vj1EBlWdjKq6jAm+5pmvIuOS+ga9GpZrURpzbSWntv708ZGRjvDS824m0sOMEJGk15QepoeuWM9O5uABV7/mxc5sKr5yXUEH2MJXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxyZUlbLVHWh6I8Anaw/wwDrLQsyRufFpiyW2WHmut4=;
 b=prjuh7J+AKDGnMrxYKAvEGuLonYJINWc3klk/mfJ3TYqH9FN0fZmBirUkUqBO4tIe7+CUjCrV8i1Hw/QN7HvNtTNafOZWC5ScPrMCx4rQRBd1PV/7gyeqptoEqacuxwvvmYDT/uaz6A+PLnWgNTygriQgb5/EbYIH2FXjGIJPGo=
Received: from DM5PR12MB1276.namprd12.prod.outlook.com (2603:10b6:3:79::18) by
 DM5PR12MB2534.namprd12.prod.outlook.com (2603:10b6:4:b4::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19; Tue, 2 Jun 2020 07:11:00 +0000
Received: from DM5PR12MB1276.namprd12.prod.outlook.com
 ([fe80::f533:4c74:1224:cd32]) by DM5PR12MB1276.namprd12.prod.outlook.com
 ([fe80::f533:4c74:1224:cd32%5]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 07:11:00 +0000
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Dejin Zheng <zhengdejin5@gmail.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
        "agross@kernel.org" <agross@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] PCI: dwc: convert to
 devm_platform_ioremap_resource_byname()
Thread-Topic: [PATCH v1] PCI: dwc: convert to
 devm_platform_ioremap_resource_byname()
Thread-Index: AQHWNQtFPRKU/5PQpUKyvyNa3OTanajE78mg
Date:   Tue, 2 Jun 2020 07:11:00 +0000
Message-ID: <DM5PR12MB1276BA103B8EB0115D3738C0DA8B0@DM5PR12MB1276.namprd12.prod.outlook.com>
References: <20200528161510.31935-1-zhengdejin5@gmail.com>
In-Reply-To: <20200528161510.31935-1-zhengdejin5@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTM0MWNlZjVmLWE0YTAtMTFlYS05OGI4LWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFwzNDFjZWY2MS1hNGEwLTExZWEtOThiOC1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjEyMjI0IiB0PSIxMzIzNTU1NTQ1NzQ0?=
 =?us-ascii?Q?MDkzNDkiIGg9IlBsTjlZemRvUVltUjZOeDU5RTB0aVExYXp6cz0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUJRSkFB?=
 =?us-ascii?Q?Q0ZIblgyckRqV0FXdk00RGNkTFJjbmE4emdOeDB0RnljT0FBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQUNrQ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBRW1NZWt3QUFBQUFBQUFBQUFBQUFBSjRBQUFCbUFHa0Fi?=
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
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [83.174.63.141]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51d859c7-d03d-4025-7e30-08d806c41aa2
x-ms-traffictypediagnostic: DM5PR12MB2534:
x-microsoft-antispam-prvs: <DM5PR12MB253495C203D2AAFA3F203FD0DA8B0@DM5PR12MB2534.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:109;
x-forefront-prvs: 0422860ED4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fo/F7CqX99o1xNUInNq27xO0FV8nDq62/ppmBW3aIROsaBeGvg8kxn6vsVsuKPhk3CmRrbv3Md6Bn2IBWFVjUDWHul75jHcY8weu2Q//5drsHEszle+nWwimvQgIWWGAk8d8PpSWmfQjfwdfPED8OX7Uj1AXOd+6qjGXPWRl8PS4OPpf8v5CqzQv8RbBsnCEsuSjY09uYdKDmDnULbTcoVnXLNRP7Q7ns/goXGmuKsY+MwfWIh33b8sl6cO+al7jeDUhFfBasFhukcM+t+BvCg1VUCPMMmLLI9kwAZaeeZolIWxT6jJrwYQM8R6K3HkK/45W4jITxK0QtKnXnm6+pw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1276.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(366004)(396003)(376002)(346002)(478600001)(9686003)(52536014)(8936002)(53546011)(55016002)(7696005)(6506007)(33656002)(186003)(2906002)(86362001)(4326008)(83380400001)(26005)(66946007)(76116006)(316002)(66556008)(64756008)(66476007)(30864003)(66446008)(5660300002)(110136005)(8676002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: l2homRsZHGpniquPXnJvC487w2n1YK9XJqevaZjmgLNz9htC9ZvhRX4LZSWmeyxisgyOVvR9FoRsKK7GHzc474mjYMPqvvf4TQ5s148hrwI3l83Pq2tY1UijoEc84RcDBIjpJCE3PE//IZwfeD/7JmhLtWtXDtOXjrET0uXEMeZ174De2nXUy4ua25xe/pEo1EqnLUlfAWYpR7TQ/VgmTXIKBBPPaQ18nvqYQCKc6gTMxjVvZ5v0HnyPKcQf+Ur+bXG0q+NA3RuiWotKxzvGKsaasA93s6EyUN8bgT3cIK9DlSGkbCm9G7IGgdfSHFPpUNcMYk9B11XfbySwyYa3pjsh7xtn0gXrEWpxe/NMI1gy9o8OnhsDb3GPP+wkIr1zjfTry+pEX4qSGc+g7RcMjMn8b8pOn1n/lLJng/VSIZJPLPgM5+bSTzwWKhTqalzcQqb4iNeqI69TAtEDnxuVeKOEgkz/lJ8rWctwyk715b4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d859c7-d03d-4025-7e30-08d806c41aa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 07:11:00.1379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4iArtyDeEBRdcpt/0YtMzcDZaQdubEUaqJ+UhRTgZ2NtCFZgjGNCpyLs/lOJMuzY8V6kj8sDhwK5prTfk2CZBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2534
X-OriginatorOrg: synopsys.com
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 28, 2020 at 17:15:10, Dejin Zheng <zhengdejin5@gmail.com>=20
wrote:

> Use devm_platform_ioremap_resource_byname() to simplify codes.
> it contains platform_get_resource_byname() and devm_ioremap_resource().
>=20
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c         | 11 ++++-------
>  drivers/pci/controller/dwc/pci-keystone.c       |  7 +++----
>  drivers/pci/controller/dwc/pcie-artpec6.c       | 12 ++++--------
>  .../pci/controller/dwc/pcie-designware-plat.c   |  3 +--
>  drivers/pci/controller/dwc/pcie-histb.c         |  7 ++-----
>  drivers/pci/controller/dwc/pcie-intel-gw.c      |  7 ++-----
>  drivers/pci/controller/dwc/pcie-kirin.c         | 17 ++++++-----------
>  drivers/pci/controller/dwc/pcie-qcom.c          |  6 ++----
>  drivers/pci/controller/dwc/pcie-uniphier.c      |  3 +--
>  9 files changed, 25 insertions(+), 48 deletions(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/contro=
ller/dwc/pci-dra7xx.c
> index 6184ebc9392d..e5d0c7ac09b9 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -593,13 +593,12 @@ static int __init dra7xx_add_pcie_ep(struct dra7xx_=
pcie *dra7xx,
>  	ep =3D &pci->ep;
>  	ep->ops =3D &pcie_ep_ops;
> =20
> -	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "ep_dbics");
> -	pci->dbi_base =3D devm_ioremap_resource(dev, res);
> +	pci->dbi_base =3D devm_platform_ioremap_resource_byname(pdev, "ep_dbics=
");
>  	if (IS_ERR(pci->dbi_base))
>  		return PTR_ERR(pci->dbi_base);
> =20
> -	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "ep_dbics2")=
;
> -	pci->dbi_base2 =3D devm_ioremap_resource(dev, res);
> +	pci->dbi_base2 =3D
> +		devm_platform_ioremap_resource_byname(pdev, "ep_dbics2");
>  	if (IS_ERR(pci->dbi_base2))
>  		return PTR_ERR(pci->dbi_base2);
> =20
> @@ -626,7 +625,6 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_=
pcie *dra7xx,
>  	struct dw_pcie *pci =3D dra7xx->pci;
>  	struct pcie_port *pp =3D &pci->pp;
>  	struct device *dev =3D pci->dev;
> -	struct resource *res;
> =20
>  	pp->irq =3D platform_get_irq(pdev, 1);
>  	if (pp->irq < 0) {
> @@ -638,8 +636,7 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_=
pcie *dra7xx,
>  	if (ret < 0)
>  		return ret;
> =20
> -	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "rc_dbics");
> -	pci->dbi_base =3D devm_ioremap_resource(dev, res);
> +	pci->dbi_base =3D devm_platform_ioremap_resource_byname(pdev, "rc_dbics=
");
>  	if (IS_ERR(pci->dbi_base))
>  		return PTR_ERR(pci->dbi_base);
> =20
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/cont=
roller/dwc/pci-keystone.c
> index 790679fdfa48..5ffc3b40c4f6 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -1228,8 +1228,8 @@ static int __init ks_pcie_probe(struct platform_dev=
ice *pdev)
>  	if (!pci)
>  		return -ENOMEM;
> =20
> -	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "app");
> -	ks_pcie->va_app_base =3D devm_ioremap_resource(dev, res);
> +	ks_pcie->va_app_base =3D
> +		devm_platform_ioremap_resource_byname(pdev, "app");
>  	if (IS_ERR(ks_pcie->va_app_base))
>  		return PTR_ERR(ks_pcie->va_app_base);
> =20
> @@ -1323,8 +1323,7 @@ static int __init ks_pcie_probe(struct platform_dev=
ice *pdev)
>  	}
> =20
>  	if (pci->version >=3D 0x480A) {
> -		res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "atu");
> -		atu_base =3D devm_ioremap_resource(dev, res);
> +		atu_base =3D devm_platform_ioremap_resource_byname(pdev, "atu");
>  		if (IS_ERR(atu_base)) {
>  			ret =3D PTR_ERR(atu_base);
>  			goto err_get_sync;
> diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/cont=
roller/dwc/pcie-artpec6.c
> index 28d5a1095200..7d2cfa288b01 100644
> --- a/drivers/pci/controller/dwc/pcie-artpec6.c
> +++ b/drivers/pci/controller/dwc/pcie-artpec6.c
> @@ -455,8 +455,7 @@ static int artpec6_add_pcie_ep(struct artpec6_pcie *a=
rtpec6_pcie,
>  	ep =3D &pci->ep;
>  	ep->ops =3D &pcie_ep_ops;
> =20
> -	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi2");
> -	pci->dbi_base2 =3D devm_ioremap_resource(dev, res);
> +	pci->dbi_base2 =3D devm_platform_ioremap_resource_byname(pdev, "dbi2");
>  	if (IS_ERR(pci->dbi_base2))
>  		return PTR_ERR(pci->dbi_base2);
> =20
> @@ -481,8 +480,6 @@ static int artpec6_pcie_probe(struct platform_device =
*pdev)
>  	struct device *dev =3D &pdev->dev;
>  	struct dw_pcie *pci;
>  	struct artpec6_pcie *artpec6_pcie;
> -	struct resource *dbi_base;
> -	struct resource *phy_base;
>  	int ret;
>  	const struct of_device_id *match;
>  	const struct artpec_pcie_of_data *data;
> @@ -512,13 +509,12 @@ static int artpec6_pcie_probe(struct platform_devic=
e *pdev)
>  	artpec6_pcie->variant =3D variant;
>  	artpec6_pcie->mode =3D mode;
> =20
> -	dbi_base =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
> -	pci->dbi_base =3D devm_ioremap_resource(dev, dbi_base);
> +	pci->dbi_base =3D devm_platform_ioremap_resource_byname(pdev, "dbi");
>  	if (IS_ERR(pci->dbi_base))
>  		return PTR_ERR(pci->dbi_base);
> =20
> -	phy_base =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy");
> -	artpec6_pcie->phy_base =3D devm_ioremap_resource(dev, phy_base);
> +	artpec6_pcie->phy_base =3D
> +		devm_platform_ioremap_resource_byname(pdev, "phy");
>  	if (IS_ERR(artpec6_pcie->phy_base))
>  		return PTR_ERR(artpec6_pcie->phy_base);
> =20
> diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/=
pci/controller/dwc/pcie-designware-plat.c
> index 73646b677aff..712456f6ce36 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-plat.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
> @@ -153,8 +153,7 @@ static int dw_plat_add_pcie_ep(struct dw_plat_pcie *d=
w_plat_pcie,
>  	ep =3D &pci->ep;
>  	ep->ops =3D &pcie_ep_ops;
> =20
> -	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi2");
> -	pci->dbi_base2 =3D devm_ioremap_resource(dev, res);
> +	pci->dbi_base2 =3D devm_platform_ioremap_resource_byname(pdev, "dbi2");
>  	if (IS_ERR(pci->dbi_base2))
>  		return PTR_ERR(pci->dbi_base2);
> =20
> diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/contro=
ller/dwc/pcie-histb.c
> index 811b5c6d62ea..6d3524c39a9b 100644
> --- a/drivers/pci/controller/dwc/pcie-histb.c
> +++ b/drivers/pci/controller/dwc/pcie-histb.c
> @@ -304,7 +304,6 @@ static int histb_pcie_probe(struct platform_device *p=
dev)
>  	struct histb_pcie *hipcie;
>  	struct dw_pcie *pci;
>  	struct pcie_port *pp;
> -	struct resource *res;
>  	struct device_node *np =3D pdev->dev.of_node;
>  	struct device *dev =3D &pdev->dev;
>  	enum of_gpio_flags of_flags;
> @@ -324,15 +323,13 @@ static int histb_pcie_probe(struct platform_device =
*pdev)
>  	pci->dev =3D dev;
>  	pci->ops =3D &dw_pcie_ops;
> =20
> -	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "control");
> -	hipcie->ctrl =3D devm_ioremap_resource(dev, res);
> +	hipcie->ctrl =3D devm_platform_ioremap_resource_byname(pdev, "control")=
;
>  	if (IS_ERR(hipcie->ctrl)) {
>  		dev_err(dev, "cannot get control reg base\n");
>  		return PTR_ERR(hipcie->ctrl);
>  	}
> =20
> -	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "rc-dbi");
> -	pci->dbi_base =3D devm_ioremap_resource(dev, res);
> +	pci->dbi_base =3D devm_platform_ioremap_resource_byname(pdev, "rc-dbi")=
;
>  	if (IS_ERR(pci->dbi_base)) {
>  		dev_err(dev, "cannot get rc-dbi base\n");
>  		return PTR_ERR(pci->dbi_base);
> diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/con=
troller/dwc/pcie-intel-gw.c
> index 2d8dbb318087..c3b3a1d162b5 100644
> --- a/drivers/pci/controller/dwc/pcie-intel-gw.c
> +++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
> @@ -253,11 +253,9 @@ static int intel_pcie_get_resources(struct platform_=
device *pdev)
>  	struct intel_pcie_port *lpp =3D platform_get_drvdata(pdev);
>  	struct dw_pcie *pci =3D &lpp->pci;
>  	struct device *dev =3D pci->dev;
> -	struct resource *res;
>  	int ret;
> =20
> -	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
> -	pci->dbi_base =3D devm_ioremap_resource(dev, res);
> +	pci->dbi_base =3D devm_platform_ioremap_resource_byname(pdev, "dbi");
>  	if (IS_ERR(pci->dbi_base))
>  		return PTR_ERR(pci->dbi_base);
> =20
> @@ -291,8 +289,7 @@ static int intel_pcie_get_resources(struct platform_d=
evice *pdev)
>  	ret =3D of_pci_get_max_link_speed(dev->of_node);
>  	lpp->link_gen =3D ret < 0 ? 0 : ret;
> =20
> -	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "app");
> -	lpp->app_base =3D devm_ioremap_resource(dev, res);
> +	lpp->app_base =3D devm_platform_ioremap_resource_byname(pdev, "app");
>  	if (IS_ERR(lpp->app_base))
>  		return PTR_ERR(lpp->app_base);
> =20
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/contro=
ller/dwc/pcie-kirin.c
> index c19617a912bd..e5e765038686 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -147,23 +147,18 @@ static long kirin_pcie_get_clk(struct kirin_pcie *k=
irin_pcie,
>  static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
>  				    struct platform_device *pdev)
>  {
> -	struct device *dev =3D &pdev->dev;
> -	struct resource *apb;
> -	struct resource *phy;
> -	struct resource *dbi;
> -
> -	apb =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "apb");
> -	kirin_pcie->apb_base =3D devm_ioremap_resource(dev, apb);
> +	kirin_pcie->apb_base =3D
> +		devm_platform_ioremap_resource_byname(pdev, "apb");
>  	if (IS_ERR(kirin_pcie->apb_base))
>  		return PTR_ERR(kirin_pcie->apb_base);
> =20
> -	phy =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy");
> -	kirin_pcie->phy_base =3D devm_ioremap_resource(dev, phy);
> +	kirin_pcie->phy_base =3D
> +		devm_platform_ioremap_resource_byname(pdev, "phy");
>  	if (IS_ERR(kirin_pcie->phy_base))
>  		return PTR_ERR(kirin_pcie->phy_base);
> =20
> -	dbi =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
> -	kirin_pcie->pci->dbi_base =3D devm_ioremap_resource(dev, dbi);
> +	kirin_pcie->pci->dbi_base =3D
> +		devm_platform_ioremap_resource_byname(pdev, "dbi");
>  	if (IS_ERR(kirin_pcie->pci->dbi_base))
>  		return PTR_ERR(kirin_pcie->pci->dbi_base);
> =20
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> index 138e1a2d21cc..91e2e9086564 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1358,8 +1358,7 @@ static int qcom_pcie_probe(struct platform_device *=
pdev)
>  		goto err_pm_runtime_put;
>  	}
> =20
> -	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "parf");
> -	pcie->parf =3D devm_ioremap_resource(dev, res);
> +	pcie->parf =3D devm_platform_ioremap_resource_byname(pdev, "parf");
>  	if (IS_ERR(pcie->parf)) {
>  		ret =3D PTR_ERR(pcie->parf);
>  		goto err_pm_runtime_put;
> @@ -1372,8 +1371,7 @@ static int qcom_pcie_probe(struct platform_device *=
pdev)
>  		goto err_pm_runtime_put;
>  	}
> =20
> -	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "elbi");
> -	pcie->elbi =3D devm_ioremap_resource(dev, res);
> +	pcie->elbi =3D devm_platform_ioremap_resource_byname(pdev, "elbi");
>  	if (IS_ERR(pcie->elbi)) {
>  		ret =3D PTR_ERR(pcie->elbi);
>  		goto err_pm_runtime_put;
> diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/con=
troller/dwc/pcie-uniphier.c
> index a5401a0b1e58..3a7f403b57b8 100644
> --- a/drivers/pci/controller/dwc/pcie-uniphier.c
> +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
> @@ -416,8 +416,7 @@ static int uniphier_pcie_probe(struct platform_device=
 *pdev)
>  	if (IS_ERR(priv->pci.dbi_base))
>  		return PTR_ERR(priv->pci.dbi_base);
> =20
> -	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "link");
> -	priv->base =3D devm_ioremap_resource(dev, res);
> +	priv->base =3D devm_platform_ioremap_resource_byname(pdev, "link");
>  	if (IS_ERR(priv->base))
>  		return PTR_ERR(priv->base);
> =20
> --=20
> 2.25.0


Reviewed-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>


