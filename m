Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1B371567
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2019 11:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbfGWJkX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Jul 2019 05:40:23 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:52430 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726370AbfGWJkW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jul 2019 05:40:22 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 54613C01DE;
        Tue, 23 Jul 2019 09:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1563874821; bh=SXNA7Fe5EHQO/0n01mcOXEhXpMC970RyHDEXcyCjl0s=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=TIDYbGUw8L+qJdqDezqZY4jqRmPihumQJPRhHuQ/iAoqms0/EBi0JvRszKfdMSg5k
         EGnaTtx//wMtYV/4NOerzewBEJhBidTYPE5BCajPjtp76ECxVfFKOf4HsHau1RMFIY
         iB3pXQfhLc9g2bO6hT6eZfOtJWtGsDy1duA1pzp48zehRVuLLdQfj9dp5V/8ilSm7Z
         EMEmNwMMJ9gxPHKIZCucf23PCZi23tkdmsF+SCyOYSur7Byw02+UoBz8e+SC31ns1F
         vlGDt3KzsTQgEX5fENRC24+Q/+8oDsrysXMVfcWEyCdlqG82Ei4krNP3RRokP8skgl
         9ApIOFNzTqB/w==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id AFBEBA006A;
        Tue, 23 Jul 2019 09:40:19 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 23 Jul 2019 02:40:19 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Tue, 23 Jul 2019 02:40:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJwuGuYVn6nqqTGWL1XoEpS7HNU5f8rwhjlTwj/ojRjAWOr1cYdXU4/ho9valZ8Hs9g+vpmUnonTdV06qhCSbetExzP76qF+NHStUmWvi+MUqgCOARISGkSyxDmT2DnObshyZxVp3bcfKLcjOqHx3RbZ7h23QdZ9PCVbCO4Xb53ts2ZUJ9SkgxyDi9eIxeRhmZAWX9sqvLrSLvgtRwRTx4R4LAYytYYvjFd9Z0DNlMJbOFblzFgam6u3xRo7dvQtFwmFi08oWBdzWEZho5P8ycH5/uz/OxNew8c86Z1jkCLgRBRTUX01b0M7n+8ueF1615V3qInJMjnItr7gr1Bj9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKOSAb84eO4uO4Pr+Xve81N1TKI19VPsACPXugEGQi4=;
 b=eMQERSs6GHO7oFyJMTuAdXt8dLKoEyS1fwl1f5cVn03tQujr15g4lLMSdM0Meu8hYAMOcYde6ldxQFsyP17veA8Gj2pOhvA3Gl2L7KIHyVsHHd/cJuMfpTAAQ4EpzqeF1aLQREVTyYtLRsyeqIMHtZe4Q5sgcmAvLrJPCK5oysYc8sZMIUKeiUE46sNBlQR1pb+kEhlWkS0c9hb7Wv2SfUUvMVIGi7rcIQJoYP1aMMWKjeyAnwD//SBC0r56y5GUUK/faE6nz4To5Xc2NQzJ69aRwRPA5DnDcoBztOzbu8BVUa86ihsMw0Alit1rE7zlB3n3R9Cifljh7EH8KSp5Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=synopsys.com;dmarc=pass action=none
 header.from=synopsys.com;dkim=pass header.d=synopsys.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector1-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKOSAb84eO4uO4Pr+Xve81N1TKI19VPsACPXugEGQi4=;
 b=NCYRA+DZY8PJNFxu/K4nNITFiuz32WqWGFZA3hkuLowIg87J9smw8fciFDPpNvHIaxZiGJCk9KsbMx/uAFVoDpo66fMXIfju0Ssvy8/Pv+FEB5h5OocHqHK729qfU7F3oUht4n8DmH6iMogIXEM/vknWDmHkoiuK5UegFivVMvo=
Received: from DM6PR12MB4010.namprd12.prod.outlook.com (10.255.175.83) by
 DM6PR12MB2603.namprd12.prod.outlook.com (20.176.116.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Tue, 23 Jul 2019 09:40:18 +0000
Received: from DM6PR12MB4010.namprd12.prod.outlook.com
 ([fe80::1508:71eb:20f6:b4e6]) by DM6PR12MB4010.namprd12.prod.outlook.com
 ([fe80::1508:71eb:20f6:b4e6%6]) with mapi id 15.20.2094.013; Tue, 23 Jul 2019
 09:40:18 +0000
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Jonathan Chocron <jonnyc@amazon.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <Gustavo.Pimentel@synopsys.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "alisaidi@amazon.com" <alisaidi@amazon.com>,
        "ronenk@amazon.com" <ronenk@amazon.com>,
        "barakw@amazon.com" <barakw@amazon.com>,
        "talel@amazon.com" <talel@amazon.com>,
        "hanochu@amazon.com" <hanochu@amazon.com>,
        "hhhawa@amazon.com" <hhhawa@amazon.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v3 6/8] PCI: al: Add support for DW based driver type
Thread-Topic: [PATCH v3 6/8] PCI: al: Add support for DW based driver type
Thread-Index: AQHVQTjpWTPYgP8OUkGBrBIF6QRUR6bX8rvA
Date:   Tue, 23 Jul 2019 09:40:18 +0000
Message-ID: <DM6PR12MB401059F49388C33E9335E55BDAC70@DM6PR12MB4010.namprd12.prod.outlook.com>
References: <20190723092529.11310-1-jonnyc@amazon.com>
 <20190723092711.11786-2-jonnyc@amazon.com>
In-Reply-To: <20190723092711.11786-2-jonnyc@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLWRlMWE4OTU3LWFkMmQtMTFlOS05ODhjLWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFxkZTFhODk1OS1hZDJkLTExZTktOTg4Yy1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjEyODk0IiB0PSIxMzIwODM0ODQxMzMw?=
 =?us-ascii?Q?OTkxMzQiIGg9IkFiaklydWswZ1hQUXFJa2hNcWxHQ21TT2QyTT0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUJRSkFB?=
 =?us-ascii?Q?QitCbk9nT2tIVkFSZXVUeXNJaElSS0Y2NVBLd2lFaEVvT0FBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQUNrQ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBRnRiQnB3QUFBQUFBQUFBQUFBQUFBSjRBQUFCbUFHa0Fi?=
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
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gustavo@synopsys.com; 
x-originating-ip: [83.174.63.141]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b42a3bc1-65c4-4ef6-ce78-08d70f51c5e0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM6PR12MB2603;
x-ms-traffictypediagnostic: DM6PR12MB2603:
x-microsoft-antispam-prvs: <DM6PR12MB2603DAB983B8E5A45A9FFD09DAC70@DM6PR12MB2603.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0107098B6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(366004)(396003)(376002)(39860400002)(189003)(199004)(64756008)(9686003)(446003)(66556008)(66946007)(66446008)(11346002)(476003)(66476007)(7416002)(6246003)(74316002)(76116006)(7736002)(305945005)(55016002)(8676002)(54906003)(102836004)(26005)(2906002)(110136005)(256004)(486006)(53546011)(86362001)(71190400001)(71200400001)(6506007)(229853002)(186003)(99286004)(478600001)(68736007)(2501003)(30864003)(2201001)(76176011)(66066001)(4326008)(52536014)(33656002)(316002)(8936002)(53936002)(25786009)(5660300002)(14454004)(3846002)(6436002)(81166006)(81156014)(7696005)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR12MB2603;H:DM6PR12MB4010.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LhAJkIjok03VTq4h9m5FjmB5Rw8cUyYzBJinji3Nn9qBzLWudhlnX9p47Jb+E7sMHonsPxVfnNHtFsDEGDLQHGSmJFW8GypheWip+u1BWEiv3hONVB7rkJ8+dKTAuO4Vvgn9DP2sfm5WM9sMCdr8viDQO3jyQyConaUgKBlQQlCzeI27VkYjY9dOvAd2PAK0WjFCX+ux3NxPw1IbO80YukwOOq8UYNYIGwPVxWpW5TRo/ir/VtGReQiunvFj/nfKjkpmHpMSKqxAyCxRa/Esr+afp3LJpS5L8rHi1nLImaeh/wlNhUUVEpHsfiyiP2rUIueva1dwkyY3/fAUDDsM4jfIOTnwXfip/reZycuKM7WPMc1k2axI7tCKEwO5IQKipzpFEY3/fqqlqOgzMrEAsFCXSq8Y78T3XmTjPPP2rEk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b42a3bc1-65c4-4ef6-ce78-08d70f51c5e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2019 09:40:18.1797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gustavo@synopsys.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2603
X-OriginatorOrg: synopsys.com
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 23, 2019 at 10:27:9, Jonathan Chocron <jonnyc@amazon.com>=20
wrote:

> This driver is DT based and utilizes the DesignWare APIs.
> It allows using a smaller ECAM range for a larger bus range -
> usually an entire bus uses 1MB of address space, but the driver
> can use it for a larger number of buses.
>=20
> All link initializations are handled by the boot FW.
>=20
> Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
> ---
>  drivers/pci/controller/dwc/Kconfig   |  12 +
>  drivers/pci/controller/dwc/pcie-al.c | 367 +++++++++++++++++++++++++++
>  2 files changed, 379 insertions(+)
>=20
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/=
dwc/Kconfig
> index 6ea778ae4877..3c6094cbcc3b 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -230,4 +230,16 @@ config PCIE_UNIPHIER
>  	  Say Y here if you want PCIe controller support on UniPhier SoCs.
>  	  This driver supports LD20 and PXs3 SoCs.
> =20
> +config PCIE_AL
> +	bool "Amazon Annapurna Labs PCIe controller"
> +	depends on OF && (ARM64 || COMPILE_TEST)
> +	depends on PCI_MSI_IRQ_DOMAIN
> +	select PCIE_DW_HOST
> +	help
> +	  Say Y here to enable support of the Amazon's Annapurna Labs PCIe
> +	  controller IP on Amazon SoCs. The PCIe controller uses the DesignWare
> +	  core plus Annapurna Labs proprietary hardware wrappers. This is
> +	  required only for DT-based platforms. ACPI platforms with the
> +	  Annapurna Labs PCIe controller don't need to enable this.
> +
>  endmenu
> diff --git a/drivers/pci/controller/dwc/pcie-al.c b/drivers/pci/controlle=
r/dwc/pcie-al.c
> index 3ab58f0584a8..3ffdd3c97617 100644
> --- a/drivers/pci/controller/dwc/pcie-al.c
> +++ b/drivers/pci/controller/dwc/pcie-al.c
> @@ -91,3 +91,370 @@ struct pci_ecam_ops al_pcie_ops =3D {
>  };
> =20
>  #endif /* defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS) */
> +
> +#ifdef CONFIG_PCIE_AL
> +
> +#include <linux/of_pci.h>
> +#include "pcie-designware.h"
> +
> +#define AL_PCIE_REV_ID_2	2
> +#define AL_PCIE_REV_ID_3	3
> +#define AL_PCIE_REV_ID_4	4
> +
> +#define AXI_BASE_OFFSET		0x0
> +
> +#define DEVICE_ID_OFFSET	0x16c
> +
> +#define DEVICE_REV_ID			0x0
> +#define DEVICE_REV_ID_DEV_ID_MASK	GENMASK(31, 16)
> +
> +#define DEVICE_REV_ID_DEV_ID_X4		0
> +#define DEVICE_REV_ID_DEV_ID_X8		2
> +#define DEVICE_REV_ID_DEV_ID_X16	4
> +
> +#define OB_CTRL_REV1_2_OFFSET	0x0040
> +#define OB_CTRL_REV3_5_OFFSET	0x0030
> +
> +#define CFG_TARGET_BUS			0x0
> +#define CFG_TARGET_BUS_MASK_MASK	GENMASK(7, 0)
> +#define CFG_TARGET_BUS_BUSNUM_MASK	GENMASK(15, 8)
> +
> +#define CFG_CONTROL			0x4
> +#define CFG_CONTROL_SUBBUS_MASK		GENMASK(15, 8)
> +#define CFG_CONTROL_SEC_BUS_MASK	GENMASK(23, 16)
> +
> +struct al_pcie_reg_offsets {
> +	unsigned int ob_ctrl;
> +};
> +
> +struct al_pcie_target_bus_cfg {
> +	u8 reg_val;
> +	u8 reg_mask;
> +	u8 ecam_mask;
> +};
> +
> +struct al_pcie {
> +	struct dw_pcie *pci;
> +	void __iomem *controller_base; /* base of PCIe unit (not DW core) */
> +	struct device *dev;
> +	resource_size_t ecam_size;
> +	unsigned int controller_rev_id;
> +	struct al_pcie_reg_offsets reg_offsets;
> +	struct al_pcie_target_bus_cfg target_bus_cfg;
> +};
> +
> +#define PCIE_ECAM_DEVFN(x)		(((x) & 0xff) << 12)
> +
> +#define to_al_pcie(x)		dev_get_drvdata((x)->dev)
> +
> +static inline u32 al_pcie_controller_readl(struct al_pcie *pcie, u32 off=
set)
> +{
> +	return readl(pcie->controller_base + offset);
> +}
> +
> +static inline void al_pcie_controller_writel(struct al_pcie *pcie, u32 o=
ffset,
> +					     u32 val)
> +{
> +	writel(val, pcie->controller_base + offset);
> +}
> +
> +static int al_pcie_rev_id_get(struct al_pcie *pcie, unsigned int *rev_id=
)
> +{
> +	u32 dev_rev_id_val;
> +	u32 dev_id_val;
> +
> +	dev_rev_id_val =3D al_pcie_controller_readl(pcie, AXI_BASE_OFFSET +
> +						  DEVICE_ID_OFFSET +
> +						  DEVICE_REV_ID);
> +	dev_id_val =3D FIELD_GET(DEVICE_REV_ID_DEV_ID_MASK, dev_rev_id_val);
> +
> +	switch (dev_id_val) {
> +	case DEVICE_REV_ID_DEV_ID_X4:
> +		*rev_id =3D AL_PCIE_REV_ID_2;
> +		break;
> +	case DEVICE_REV_ID_DEV_ID_X8:
> +		*rev_id =3D AL_PCIE_REV_ID_3;
> +		break;
> +	case DEVICE_REV_ID_DEV_ID_X16:
> +		*rev_id =3D AL_PCIE_REV_ID_4;
> +		break;
> +	default:
> +		dev_err(pcie->dev, "Unsupported dev_id_val (0x%x)\n",
> +			dev_id_val);
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(pcie->dev, "dev_id_val: 0x%x\n", dev_id_val);
> +
> +	return 0;
> +}
> +
> +static int al_pcie_reg_offsets_set(struct al_pcie *pcie)
> +{
> +	switch (pcie->controller_rev_id) {
> +	case AL_PCIE_REV_ID_2:
> +		pcie->reg_offsets.ob_ctrl =3D OB_CTRL_REV1_2_OFFSET;
> +		break;
> +	case AL_PCIE_REV_ID_3:
> +	case AL_PCIE_REV_ID_4:
> +		pcie->reg_offsets.ob_ctrl =3D OB_CTRL_REV3_5_OFFSET;
> +		break;
> +	default:
> +		dev_err(pcie->dev, "Unsupported controller rev_id: 0x%x\n",
> +			pcie->controller_rev_id);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static inline void al_pcie_target_bus_set(struct al_pcie *pcie,
> +					  u8 target_bus,
> +					  u8 mask_target_bus)
> +{
> +	u32 reg;
> +
> +	reg =3D FIELD_PREP(CFG_TARGET_BUS_MASK_MASK, mask_target_bus) |
> +	      FIELD_PREP(CFG_TARGET_BUS_BUSNUM_MASK, target_bus);
> +
> +	al_pcie_controller_writel(pcie, AXI_BASE_OFFSET +
> +				  pcie->reg_offsets.ob_ctrl + CFG_TARGET_BUS,
> +				  reg);
> +}
> +
> +static void __iomem *al_pcie_conf_addr_map(struct al_pcie *pcie,
> +					   unsigned int busnr,
> +					   unsigned int devfn)
> +{
> +	struct al_pcie_target_bus_cfg *target_bus_cfg =3D &pcie->target_bus_cfg=
;
> +	unsigned int busnr_ecam =3D busnr & target_bus_cfg->ecam_mask;
> +	unsigned int busnr_reg =3D busnr & target_bus_cfg->reg_mask;
> +	struct pcie_port *pp =3D &pcie->pci->pp;
> +	void __iomem *pci_base_addr;
> +
> +	pci_base_addr =3D (void __iomem *)((uintptr_t)pp->va_cfg0_base +
> +					 (busnr_ecam << 20) +
> +					 PCIE_ECAM_DEVFN(devfn));
> +
> +	if (busnr_reg !=3D target_bus_cfg->reg_val) {
> +		dev_dbg(pcie->pci->dev, "Changing target bus busnum val from 0x%x to 0=
x%x\n",
> +			target_bus_cfg->reg_val, busnr_reg);
> +		target_bus_cfg->reg_val =3D busnr_reg;
> +		al_pcie_target_bus_set(pcie,
> +				       target_bus_cfg->reg_val,
> +				       target_bus_cfg->reg_mask);
> +	}
> +
> +	return pci_base_addr;
> +}
> +
> +static int al_pcie_rd_other_conf(struct pcie_port *pp, struct pci_bus *b=
us,
> +				 unsigned int devfn, int where, int size,
> +				 u32 *val)
> +{
> +	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> +	struct al_pcie *pcie =3D to_al_pcie(pci);
> +	unsigned int busnr =3D bus->number;
> +	void __iomem *pci_addr;
> +	int rc;
> +
> +	pci_addr =3D al_pcie_conf_addr_map(pcie, busnr, devfn);
> +
> +	rc =3D dw_pcie_read(pci_addr + where, size, val);
> +
> +	dev_dbg(pci->dev, "%d-byte config read from %04x:%02x:%02x.%d offset 0x=
%x (pci_addr: 0x%px) - val:0x%x\n",
> +		size, pci_domain_nr(bus), bus->number,
> +		PCI_SLOT(devfn), PCI_FUNC(devfn), where,
> +		(pci_addr + where), *val);
> +
> +	return rc;
> +}
> +
> +static int al_pcie_wr_other_conf(struct pcie_port *pp, struct pci_bus *b=
us,
> +				 unsigned int devfn, int where, int size,
> +				 u32 val)
> +{
> +	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> +	struct al_pcie *pcie =3D to_al_pcie(pci);
> +	unsigned int busnr =3D bus->number;
> +	void __iomem *pci_addr;
> +	int rc;
> +
> +	pci_addr =3D al_pcie_conf_addr_map(pcie, busnr, devfn);
> +
> +	rc =3D dw_pcie_write(pci_addr + where, size, val);
> +
> +	dev_err(pci->dev, "%d-byte config write to %04x:%02x:%02x.%d offset 0x%=
x (pci_addr: 0x%px) - val:0x%x\n",
> +		size, pci_domain_nr(bus), bus->number,
> +		PCI_SLOT(devfn), PCI_FUNC(devfn), where,
> +		(pci_addr + where), val);
> +
> +	return rc;
> +}
> +
> +static void al_pcie_config_prepare(struct al_pcie *pcie)
> +{
> +	struct al_pcie_target_bus_cfg *target_bus_cfg;
> +	struct pcie_port *pp =3D &pcie->pci->pp;
> +	unsigned int ecam_bus_mask;
> +	u32 cfg_control_offset;
> +	u8 subordinate_bus;
> +	u8 secondary_bus;
> +	u32 cfg_control;
> +	u32 reg;
> +
> +	target_bus_cfg =3D &pcie->target_bus_cfg;
> +
> +	ecam_bus_mask =3D (pcie->ecam_size >> 20) - 1;
> +	if (ecam_bus_mask > 255) {
> +		dev_warn(pcie->dev, "ECAM window size is larger than 256MB. Cutting of=
f at 256\n");
> +		ecam_bus_mask =3D 255;
> +	}
> +
> +	/* This portion is taken from the transaction address */
> +	target_bus_cfg->ecam_mask =3D ecam_bus_mask;
> +	/* This portion is taken from the cfg_target_bus reg */
> +	target_bus_cfg->reg_mask =3D ~target_bus_cfg->ecam_mask;
> +	target_bus_cfg->reg_val =3D pp->busn->start & target_bus_cfg->reg_mask;
> +
> +	al_pcie_target_bus_set(pcie, target_bus_cfg->reg_val,
> +			       target_bus_cfg->reg_mask);
> +
> +	secondary_bus =3D pp->busn->start + 1;
> +	subordinate_bus =3D pp->busn->end;
> +
> +	/* Set the valid values of secondary and subordinate buses */
> +	cfg_control_offset =3D AXI_BASE_OFFSET + pcie->reg_offsets.ob_ctrl +
> +			     CFG_CONTROL;
> +
> +	cfg_control =3D al_pcie_controller_readl(pcie, cfg_control_offset);
> +
> +	reg =3D cfg_control &
> +	      ~(CFG_CONTROL_SEC_BUS_MASK | CFG_CONTROL_SUBBUS_MASK);
> +
> +	reg |=3D FIELD_PREP(CFG_CONTROL_SUBBUS_MASK, subordinate_bus) |
> +	       FIELD_PREP(CFG_CONTROL_SEC_BUS_MASK, secondary_bus);
> +
> +	al_pcie_controller_writel(pcie, cfg_control_offset, reg);
> +}
> +
> +static int al_pcie_host_init(struct pcie_port *pp)
> +{
> +	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> +	struct al_pcie *pcie =3D to_al_pcie(pci);
> +	int link_up;
> +	int rc;
> +
> +	rc =3D al_pcie_rev_id_get(pcie, &pcie->controller_rev_id);
> +	if (rc)
> +		return rc;
> +
> +	rc =3D al_pcie_reg_offsets_set(pcie);
> +	if (rc)
> +		return rc;
> +
> +	al_pcie_config_prepare(pcie);
> +
> +	return 0;
> +}
> +
> +static const struct dw_pcie_host_ops al_pcie_host_ops =3D {
> +	.rd_other_conf =3D al_pcie_rd_other_conf,
> +	.wr_other_conf =3D al_pcie_wr_other_conf,
> +	.host_init =3D al_pcie_host_init,
> +};
> +
> +static int al_add_pcie_port(struct pcie_port *pp,
> +			    struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	int ret;
> +
> +	pp->ops =3D &al_pcie_host_ops;
> +
> +	ret =3D dw_pcie_host_init(pp);
> +	if (ret) {
> +		dev_err(dev, "failed to initialize host\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct dw_pcie_ops dw_pcie_ops =3D {
> +};
> +
> +static int al_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct resource *controller_res;
> +	struct resource *ecam_res;
> +	struct resource *dbi_res;
> +	struct al_pcie *al_pcie;
> +	struct dw_pcie *pci;
> +	int ret;
> +
> +	al_pcie =3D devm_kzalloc(dev, sizeof(*al_pcie), GFP_KERNEL);
> +	if (!al_pcie)
> +		return -ENOMEM;
> +
> +	pci =3D devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
> +	if (!pci)
> +		return -ENOMEM;
> +
> +	pci->dev =3D dev;
> +	pci->ops =3D &dw_pcie_ops;
> +
> +	al_pcie->pci =3D pci;
> +	al_pcie->dev =3D dev;
> +
> +	dbi_res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
> +	pci->dbi_base =3D devm_pci_remap_cfg_resource(dev, dbi_res);
> +	if (IS_ERR(pci->dbi_base)) {
> +		dev_err(dev, "couldn't remap dbi base %pR\n", dbi_res);
> +		return PTR_ERR(pci->dbi_base);
> +	}
> +
> +	ecam_res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "config=
");
> +	if (!ecam_res) {
> +		dev_err(dev, "couldn't find 'config' reg in DT\n");
> +		return -ENOENT;
> +	}
> +	al_pcie->ecam_size =3D resource_size(ecam_res);
> +
> +	controller_res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +						      "controller");
> +	al_pcie->controller_base =3D devm_ioremap_resource(dev, controller_res)=
;
> +	if (IS_ERR(al_pcie->controller_base)) {
> +		dev_err(dev, "couldn't remap controller base %pR\n",
> +			controller_res);
> +		return PTR_ERR(al_pcie->controller_base);
> +	}
> +
> +	dev_dbg(dev, "From DT: dbi_base: %pR, controller_base: %pR\n",
> +		dbi_res, controller_res);
> +
> +	platform_set_drvdata(pdev, al_pcie);
> +
> +	ret =3D al_add_pcie_port(&pci->pp, pdev);
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id al_pcie_of_match[] =3D {
> +	{ .compatible =3D "amazon,al-pcie",
> +	},
> +	{},
> +};
> +
> +static struct platform_driver al_pcie_driver =3D {
> +	.driver =3D {
> +		.name	=3D "al-pcie",
> +		.of_match_table =3D al_pcie_of_match,
> +		.suppress_bind_attrs =3D true,
> +	},
> +	.probe =3D al_pcie_probe,
> +};
> +builtin_platform_driver(al_pcie_driver);
> +
> +#endif /* CONFIG_PCIE_AL*/
> --=20
> 2.17.1


Reviewed-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>


