Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B181BEFDF
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2019 12:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbfIZKns (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Sep 2019 06:43:48 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:60524 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725208AbfIZKnr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Sep 2019 06:43:47 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 66F39C0480;
        Thu, 26 Sep 2019 10:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1569494627; bh=mqga0snLfE12Jrt0b/qfwvU35Ivg+d/d8F62Vx4mmRE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Kr1mEQPDKInc14PeH7yM0RUDRuV2PnrDqpW5uq/gMZSx9amJGmH9wpe7Hne2HLvlo
         3+rP+Y736/HPFAtr1wn6fclTbtsMsmOqjsqVxrfm/jS02NXgQ+BIT+GXNd5xsLvobC
         51H7dv51+6wR6hRZcWi3l+WIcf2kISJeOw5oPRM9yXiD/X6qwRAhNE3lci6GFCrgBN
         ddtFam6dPU1r1MFtbNN9+E0+LELIVyAB1Q4tpWpZUKj5Vs2lATK6XRYUQg7NMnnL/D
         GYD0NSqY6cE4/pNrH3kYS5iQPv1CoRKCQCohaJ3HS56+6ocdOApHvg20Nn1J+9l7er
         HNJO6MBJPSA3g==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id A614EA0067;
        Thu, 26 Sep 2019 10:43:35 +0000 (UTC)
Received: from US01WEHTC2.internal.synopsys.com (10.12.239.237) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 26 Sep 2019 03:43:25 -0700
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 26 Sep 2019 03:43:25 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.13.134.195)
 by mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 26 Sep 2019 03:43:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=is/kprMS5faVvCz7edkkuVAp6rOYL6xczLEfwaEsHqYo8zv6tM9b2BuUcGTSssRaIiHzOtYSdzT8mTM0Wdt6sSpyD0ZCsvcQ3qwPCI9CrG/jLsMoQOI/HthgDuezwltbhfLbMV7+2Oivs2y1x9en8PuCYmPJVIJJL6ZA4nkG074ftwnWsId3X2MZ3Nlui9tjS8M5dkfElJpWVOlMb9yKNZoRZ7qYetRhYRr8R3/E06itEw0EvG6TdzK+kQftCSblzLL9v9g/CDQOZjrbgXyd9hUvs36MAVf6REX6ZhZba80XSmWZh3yK/oBmHQGGokyEqVAAGIxHHbqagPnkrVdtyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FU44I+fh9UBEcuIGGPeJ7Mqi6Gh3jjuhObAnW5l6Pc=;
 b=BfcsRD/qi8UXtU6wGmWB+PRNgkRIbbaAQbmMHhBIk1rX6vCAg9WXbjt75DRo1Y5t+b9vOyESZcs9S/pqBGGjIrcQNRNvjYxQrAfQpGVNVQS/jDB3tI1/e0nON1pjSHypISPmun/KXXlRBmf1cP4eExTO4/kvZi1eybQj69jMbf8dFq6pP4a4aiv4jKczC/y3kBUEsLMZSNrRatITmWo2gg6I4azrLyLtrinJ0ey7dvod7aKpvRma239KsKhsFXV+quAEZmDJlaTTEQzbHIEdQsKSY2qPYkyihmoQMtlFPWsEalZzatapBmQoiN8+gAnW58y92yiP5x90noa8eHcfgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FU44I+fh9UBEcuIGGPeJ7Mqi6Gh3jjuhObAnW5l6Pc=;
 b=Gy8gmfEDWxz9YwNoqOrLMwVyoSI75QIv/4mQRmztN3EhjFoECAPdJrXM5g7NqFfAu8c9n07s6LAbDQksfZWwWKb239VuNnQlQzWT/+cxkPBeLKbwubT5y94dsc4RoPMe60+ddThhl3ggdjAznfAj0OUX6e9tVKlMUTwbvEynC2A=
Received: from DM6PR12MB4010.namprd12.prod.outlook.com (10.255.175.83) by
 DM6PR12MB3561.namprd12.prod.outlook.com (20.178.199.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Thu, 26 Sep 2019 10:43:22 +0000
Received: from DM6PR12MB4010.namprd12.prod.outlook.com
 ([fe80::dd4:2e5:e564:8684]) by DM6PR12MB4010.namprd12.prod.outlook.com
 ([fe80::dd4:2e5:e564:8684%5]) with mapi id 15.20.2284.028; Thu, 26 Sep 2019
 10:43:22 +0000
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Rob Herring <robh@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Toan Le <toan@os.amperecomputing.com>,
        "Ley Foon Tan" <lftan@altera.com>,
        Tom Joseph <tjoseph@cadence.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Simon Horman <horms@verge.net.au>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Michal Simek <michal.simek@xilinx.com>,
        "rfi@lists.rocketboards.org" <rfi@lists.rocketboards.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>
Subject: RE: [PATCH 06/11] PCI: of: Add inbound resource parsing to helpers
Thread-Topic: [PATCH 06/11] PCI: of: Add inbound resource parsing to helpers
Thread-Index: AQHVcyGgfsQUUII3iES1szl1M3Fheqc9yAKA
Date:   Thu, 26 Sep 2019 10:43:22 +0000
Message-ID: <DM6PR12MB4010C707B378530452747738DA860@DM6PR12MB4010.namprd12.prod.outlook.com>
References: <20190924214630.12817-1-robh@kernel.org>
 <20190924214630.12817-7-robh@kernel.org>
In-Reply-To: <20190924214630.12817-7-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcZ3VzdGF2b1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTcyZDAzODg5LWUwNGEtMTFlOS05ODhmLWY4OTRj?=
 =?us-ascii?Q?MjczODA0MlxhbWUtdGVzdFw3MmQwMzg4Yi1lMDRhLTExZTktOTg4Zi1mODk0?=
 =?us-ascii?Q?YzI3MzgwNDJib2R5LnR4dCIgc3o9IjE2MjA3IiB0PSIxMzIxMzk2ODE5ODAx?=
 =?us-ascii?Q?NjEyNDMiIGg9IlFQSW9wSlQ2ZUVrbDNzeTY0Q0NIUWRaM3pXWT0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUJRSkFB?=
 =?us-ascii?Q?RGJIQ2sxVjNUVkFSb2s3RW12SEtHTEdpVHNTYThjb1lzT0FBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQUNrQ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBRUdJWXpRQUFBQUFBQUFBQUFBQUFBSjRBQUFCbUFHa0Fi?=
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
x-ms-office365-filtering-correlation-id: 1bb308a6-8252-40c9-977d-08d7426e5a8c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM6PR12MB3561;
x-ms-traffictypediagnostic: DM6PR12MB3561:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3561AF645B1A6EA4317B88E9DA860@DM6PR12MB3561.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0172F0EF77
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(136003)(376002)(396003)(39860400002)(199004)(189003)(99286004)(54906003)(110136005)(316002)(66066001)(33656002)(7696005)(86362001)(5660300002)(30864003)(52536014)(7416002)(305945005)(74316002)(7736002)(2906002)(186003)(76176011)(478600001)(26005)(102836004)(25786009)(6506007)(53546011)(66946007)(64756008)(76116006)(66446008)(66476007)(66556008)(6116002)(3846002)(476003)(11346002)(446003)(14454004)(486006)(71190400001)(4326008)(14444005)(256004)(2501003)(71200400001)(8676002)(81156014)(81166006)(8936002)(9686003)(229853002)(6436002)(55016002)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR12MB3561;H:DM6PR12MB4010.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: I0G6H+KG4ukO+4lQcOsCUosSzsVQsgFfGtJiaVJIp3T0N0FB8omg2TF09xLJ+NU8SQeNPhs0jV5AlP7mqBGnRqmKrm2j/TQS/A0IZ+Uz5aujyd9EC+uoefqy6jM6+DNF6K2gz80npM+Im4f9jJuuKVcga1bFFbXpNF5mCq/pzUgl2g7KSONMIAdGJOhRrGa4fU4gRcQ1v45Bj1s3zLrhLaNZoFeSjY7+RQPvlxfsyPyJYITU9LEoCn7+eRZFAwl0A4e8We27PuUPXwnzHrb0SuARsQnhhR6iZDW2FC6qaRHmdhkQaNfLNwoFnHjzAoX63UAP0cpOu5Wct0cMXCixBMO+8oqJpdJ7lwbn7Ngx6sIBQqUkuVa3wMhr6xEhtRVX+KS/t5tkqrdi0xZeS4nQlvdnejUi3K56/6TZIpb9zm8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb308a6-8252-40c9-977d-08d7426e5a8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2019 10:43:22.7024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LTsFZDlA+Ud+S99T4lWodj8QrwO77oyp1EMC97uzWO0ttylJoG9jrrX7Tk2skdy4uD+dYf1EfiGL8p54ez3O/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3561
X-OriginatorOrg: synopsys.com
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 24, 2019 at 22:46:25, Rob Herring <robh@kernel.org> wrote:

> Extend devm_of_pci_get_host_bridge_resources() and
> pci_parse_request_of_pci_ranges() helpers to also parse the inbound
> addresses from DT 'dma-ranges' and populate a resource list with the
> translated addresses. This will help ensure 'dma-ranges' is always
> parsed in a consistent way.
>=20
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Toan Le <toan@os.amperecomputing.com>
> Cc: Ley Foon Tan <lftan@altera.com>
> Cc: Tom Joseph <tjoseph@cadence.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: Ryder Lee <ryder.lee@mediatek.com>
> Cc: Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>
> Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Shawn Lin <shawn.lin@rock-chips.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: rfi@lists.rocketboards.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: linux-rockchip@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c |  3 +-
>  drivers/pci/controller/pci-aardvark.c         |  2 +-
>  drivers/pci/controller/pci-ftpci100.c         |  3 +-
>  drivers/pci/controller/pci-host-common.c      |  2 +-
>  drivers/pci/controller/pci-v3-semi.c          |  2 +-
>  drivers/pci/controller/pci-versatile.c        |  2 +-
>  drivers/pci/controller/pci-xgene.c            |  1 +
>  drivers/pci/controller/pcie-altera.c          |  2 +-
>  drivers/pci/controller/pcie-cadence-host.c    |  2 +-
>  drivers/pci/controller/pcie-iproc-platform.c  |  1 +
>  drivers/pci/controller/pcie-mediatek.c        |  2 +-
>  drivers/pci/controller/pcie-mobiveil.c        |  4 +-
>  drivers/pci/controller/pcie-rcar.c            |  3 +-
>  drivers/pci/controller/pcie-rockchip-host.c   |  3 +-
>  drivers/pci/controller/pcie-xilinx-nwl.c      |  2 +-
>  drivers/pci/controller/pcie-xilinx.c          |  2 +-
>  drivers/pci/of.c                              | 44 ++++++++++++++++++-
>  drivers/pci/pci.h                             |  8 +++-
>  include/linux/pci.h                           |  2 +
>  19 files changed, 72 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/=
pci/controller/dwc/pcie-designware-host.c
> index f93252d0da5b..0743ae64bb0f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -342,7 +342,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  		return -ENOMEM;
> =20
>  	ret =3D devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
> -					&bridge->windows, &pp->io_base);
> +					&bridge->windows, &bridge->dma_ranges,
> +					&pp->io_base);
>  	if (ret)
>  		return ret;
> =20
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controll=
er/pci-aardvark.c
> index ff3af3d34028..c00b391529f3 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -940,7 +940,7 @@ static int advk_pcie_probe(struct platform_device *pd=
ev)
>  	}
> =20
>  	ret =3D pci_parse_request_of_pci_ranges(dev, &pcie->resources,
> -					      &bus);
> +					      &bridge->dma_ranges, &bus);
>  	if (ret) {
>  		dev_err(dev, "Failed to parse resources\n");
>  		return ret;
> diff --git a/drivers/pci/controller/pci-ftpci100.c b/drivers/pci/controll=
er/pci-ftpci100.c
> index bf5ece5d9291..3e07a8203736 100644
> --- a/drivers/pci/controller/pci-ftpci100.c
> +++ b/drivers/pci/controller/pci-ftpci100.c
> @@ -481,7 +481,8 @@ static int faraday_pci_probe(struct platform_device *=
pdev)
>  		return PTR_ERR(p->base);
> =20
>  	ret =3D devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
> -						    &res, &io_base);
> +						    &res, &host->dma_ranges,
> +						    &io_base);
>  	if (ret)
>  		return ret;
> =20
> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/contr=
oller/pci-host-common.c
> index c742881b5061..183381c19ee8 100644
> --- a/drivers/pci/controller/pci-host-common.c
> +++ b/drivers/pci/controller/pci-host-common.c
> @@ -27,7 +27,7 @@ static struct pci_config_window *gen_pci_init(struct de=
vice *dev,
>  	struct pci_config_window *cfg;
> =20
>  	/* Parse our PCI ranges and request their resources */
> -	err =3D pci_parse_request_of_pci_ranges(dev, resources, &bus_range);
> +	err =3D pci_parse_request_of_pci_ranges(dev, resources, NULL, &bus_rang=
e);
>  	if (err)
>  		return ERR_PTR(err);
> =20
> diff --git a/drivers/pci/controller/pci-v3-semi.c b/drivers/pci/controlle=
r/pci-v3-semi.c
> index d219404bad92..090df766faf9 100644
> --- a/drivers/pci/controller/pci-v3-semi.c
> +++ b/drivers/pci/controller/pci-v3-semi.c
> @@ -794,7 +794,7 @@ static int v3_pci_probe(struct platform_device *pdev)
>  		return PTR_ERR(v3->config_base);
> =20
>  	ret =3D devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, &res,
> -						    &io_base);
> +						    &host->dma_ranges, &io_base);
>  	if (ret)
>  		return ret;
> =20
> diff --git a/drivers/pci/controller/pci-versatile.c b/drivers/pci/control=
ler/pci-versatile.c
> index 237b1abb26f2..211159f54b4a 100644
> --- a/drivers/pci/controller/pci-versatile.c
> +++ b/drivers/pci/controller/pci-versatile.c
> @@ -93,7 +93,7 @@ static int versatile_pci_probe(struct platform_device *=
pdev)
>  	if (IS_ERR(versatile_cfg_base[1]))
>  		return PTR_ERR(versatile_cfg_base[1]);
> =20
> -	ret =3D pci_parse_request_of_pci_ranges(dev, &pci_res, NULL);
> +	ret =3D pci_parse_request_of_pci_ranges(dev, &pci_res, NULL, NULL);
>  	if (ret)
>  		return ret;
> =20
> diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/=
pci-xgene.c
> index ffda3e8b4742..11f27c42c06a 100644
> --- a/drivers/pci/controller/pci-xgene.c
> +++ b/drivers/pci/controller/pci-xgene.c
> @@ -635,6 +635,7 @@ static int xgene_pcie_probe(struct platform_device *p=
dev)
>  		return ret;
> =20
>  	ret =3D devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, &res,
> +						    &bridge->dma_ranges,
>  						    &iobase);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controlle=
r/pcie-altera.c
> index 2ed00babff5a..fde6a3b16fb9 100644
> --- a/drivers/pci/controller/pcie-altera.c
> +++ b/drivers/pci/controller/pcie-altera.c
> @@ -801,7 +801,7 @@ static int altera_pcie_probe(struct platform_device *=
pdev)
>  	}
> =20
>  	ret =3D pci_parse_request_of_pci_ranges(dev, &pcie->resources,
> -					      NULL);
> +					      &bridge->dma_ranges, NULL);
>  	if (ret) {
>  		dev_err(dev, "Failed add resources\n");
>  		return ret;
> diff --git a/drivers/pci/controller/pcie-cadence-host.c b/drivers/pci/con=
troller/pcie-cadence-host.c
> index 97e251090b4f..a8f7a6284c3e 100644
> --- a/drivers/pci/controller/pcie-cadence-host.c
> +++ b/drivers/pci/controller/pcie-cadence-host.c
> @@ -211,7 +211,7 @@ static int cdns_pcie_host_init(struct device *dev,
>  	int err;
> =20
>  	/* Parse our PCI ranges and request their resources */
> -	err =3D pci_parse_request_of_pci_ranges(dev, resources, &bus_range);
> +	err =3D pci_parse_request_of_pci_ranges(dev, resources, NULL, &bus_rang=
e);
>  	if (err)
>  		return err;
> =20
> diff --git a/drivers/pci/controller/pcie-iproc-platform.c b/drivers/pci/c=
ontroller/pcie-iproc-platform.c
> index 5a3550b6bb29..62eee2d17f43 100644
> --- a/drivers/pci/controller/pcie-iproc-platform.c
> +++ b/drivers/pci/controller/pcie-iproc-platform.c
> @@ -101,6 +101,7 @@ static int iproc_pcie_pltfm_probe(struct platform_dev=
ice *pdev)
>  	}
> =20
>  	ret =3D devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, &resources,
> +						    &bridge->dma_ranges,
>  						    &iobase);
>  	if (ret) {
>  		dev_err(dev, "unable to get PCI host bridge resources\n");
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/control=
ler/pcie-mediatek.c
> index cea4112b5309..f3996eed152d 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -1032,7 +1032,7 @@ static int mtk_pcie_setup(struct mtk_pcie *pcie)
>  	int err;
> =20
>  	err =3D pci_parse_request_of_pci_ranges(dev, windows,
> -					      &bus);
> +					      &host->dma_ranges, &bus);
>  	if (err)
>  		return err;
> =20
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/control=
ler/pcie-mobiveil.c
> index 672e633601c7..93064faaa656 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/pcie-mobiveil.c
> @@ -875,7 +875,9 @@ static int mobiveil_pcie_probe(struct platform_device=
 *pdev)
> =20
>  	/* parse the host bridge base addresses from the device tree file */
>  	ret =3D devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
> -						    &pcie->resources, &iobase);
> +						    &pcie->resources,
> +						    &bridge->dma_ranges,
> +						    &iobase);
>  	if (ret) {
>  		dev_err(dev, "Getting bridge resources failed\n");
>  		return ret;
> diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/=
pcie-rcar.c
> index f6a669a9af41..b8d6e86a5539 100644
> --- a/drivers/pci/controller/pcie-rcar.c
> +++ b/drivers/pci/controller/pcie-rcar.c
> @@ -1138,7 +1138,8 @@ static int rcar_pcie_probe(struct platform_device *=
pdev)
>  	pcie->dev =3D dev;
>  	platform_set_drvdata(pdev, pcie);
> =20
> -	err =3D pci_parse_request_of_pci_ranges(dev, &pcie->resources, NULL);
> +	err =3D pci_parse_request_of_pci_ranges(dev, &pcie->resources,
> +					      &bridge->dma_ranges, NULL);
>  	if (err)
>  		goto err_free_bridge;
> =20
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/co=
ntroller/pcie-rockchip-host.c
> index 8d20f1793a61..093b816b9dc9 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -996,7 +996,8 @@ static int rockchip_pcie_probe(struct platform_device=
 *pdev)
>  		goto err_deinit_port;
> =20
>  	err =3D devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
> -						    &res, &io_base);
> +						    &res, &bridge->dma_ranges,
> +						    &io_base);
>  	if (err)
>  		goto err_remove_irq_domain;
> =20
> diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/contr=
oller/pcie-xilinx-nwl.c
> index 45c0f344ccd1..5c9132a02d15 100644
> --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> @@ -846,7 +846,7 @@ static int nwl_pcie_probe(struct platform_device *pde=
v)
>  	}
> =20
>  	err =3D devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, &res,
> -						    &iobase);
> +						    &bridge->dma_ranges, &iobase);
>  	if (err) {
>  		dev_err(dev, "Getting bridge resources failed\n");
>  		return err;
> diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controlle=
r/pcie-xilinx.c
> index 5bf3af3b28e6..a95faca30291 100644
> --- a/drivers/pci/controller/pcie-xilinx.c
> +++ b/drivers/pci/controller/pcie-xilinx.c
> @@ -648,7 +648,7 @@ static int xilinx_pcie_probe(struct platform_device *=
pdev)
>  	}
> =20
>  	err =3D devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, &res,
> -						    &iobase);
> +						    &bridge->dma_ranges, &iobase);
>  	if (err) {
>  		dev_err(dev, "Getting bridge resources failed\n");
>  		return err;
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index bc7b27a28795..8d31e078461f 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -257,7 +257,9 @@ EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
>   */
>  int devm_of_pci_get_host_bridge_resources(struct device *dev,
>  			unsigned char busno, unsigned char bus_max,
> -			struct list_head *resources, resource_size_t *io_base)
> +			struct list_head *resources,
> +			struct list_head *ib_resources,
> +			resource_size_t *io_base)
>  {
>  	struct device_node *dev_node =3D dev->of_node;
>  	struct resource *res, tmp_res;
> @@ -340,6 +342,42 @@ int devm_of_pci_get_host_bridge_resources(struct dev=
ice *dev,
>  		pci_add_resource_offset(resources, res,	res->start - range.pci_addr);
>  	}
> =20
> +	/* Check for dma-ranges property */
> +	if (!ib_resources)
> +		return 0;
> +	err =3D of_pci_dma_range_parser_init(&parser, dev_node);
> +	if (err)
> +		return 0;
> +
> +	dev_dbg(dev, "Parsing dma-ranges property...\n");
> +	for_each_of_pci_range(&parser, &range) {
> +		/*
> +		 * If we failed translation or got a zero-sized region
> +		 * then skip this range
> +		 */
> +		if (((range.flags & IORESOURCE_TYPE_BITS) !=3D IORESOURCE_MEM) ||
> +		    range.cpu_addr =3D=3D OF_BAD_ADDR || range.size =3D=3D 0)
> +			continue;
> +
> +		dev_info(dev, "IB MEM %#010llx..%#010llx -> %#010llx\n",
> +			 range.cpu_addr,
> +			 range.cpu_addr + range.size - 1, range.pci_addr);
> +
> +
> +		err =3D of_pci_range_to_resource(&range, dev_node, &tmp_res);
> +		if (err)
> +			continue;
> +
> +		res =3D devm_kmemdup(dev, &tmp_res, sizeof(tmp_res), GFP_KERNEL);
> +		if (!res) {
> +			err =3D -ENOMEM;
> +			goto failed;
> +		}
> +
> +		pci_add_resource_offset(ib_resources, res,
> +					res->start - range.pci_addr);
> +	}
> +
>  	return 0;
> =20
>  failed:
> @@ -482,6 +520,7 @@ EXPORT_SYMBOL_GPL(of_irq_parse_and_map_pci);
> =20
>  int pci_parse_request_of_pci_ranges(struct device *dev,
>  				    struct list_head *resources,
> +				    struct list_head *ib_resources,
>  				    struct resource **bus_range)
>  {
>  	int err, res_valid =3D 0;
> @@ -489,8 +528,9 @@ int pci_parse_request_of_pci_ranges(struct device *de=
v,
>  	struct resource_entry *win, *tmp;
> =20
>  	INIT_LIST_HEAD(resources);
> +	INIT_LIST_HEAD(ib_resources);
>  	err =3D devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, resources,
> -						    &iobase);
> +						    ib_resources, &iobase);
>  	if (err)
>  		return err;
> =20
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index d22d1b807701..790458953c54 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -582,11 +582,15 @@ of_pci_get_max_link_speed(struct device_node *node)
>  #if defined(CONFIG_OF_ADDRESS)
>  int devm_of_pci_get_host_bridge_resources(struct device *dev,
>  			unsigned char busno, unsigned char bus_max,
> -			struct list_head *resources, resource_size_t *io_base);
> +			struct list_head *resources,
> +			struct list_head *ib_resources,
> +			resource_size_t *io_base);
>  #else
>  static inline int devm_of_pci_get_host_bridge_resources(struct device *d=
ev,
>  			unsigned char busno, unsigned char bus_max,
> -			struct list_head *resources, resource_size_t *io_base)
> +			struct list_head *resources,
> +			struct list_head *ib_resources,
> +			resource_size_t *io_base);
>  {
>  	return -EINVAL;
>  }
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 82e4cd1b7ac3..d57389b86f92 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2312,6 +2312,7 @@ void pci_release_bus_of_node(struct pci_bus *bus);
>  struct irq_domain *pci_host_bridge_of_msi_domain(struct pci_bus *bus);
>  int pci_parse_request_of_pci_ranges(struct device *dev,
>  				    struct list_head *resources,
> +				    struct list_head *ib_resources,
>  				    struct resource **bus_range);
> =20
>  /* Arch may override this (weak) */
> @@ -2326,6 +2327,7 @@ static inline struct irq_domain *
>  pci_host_bridge_of_msi_domain(struct pci_bus *bus) { return NULL; }
>  static inline int pci_parse_request_of_pci_ranges(struct device *dev,
>  						  struct list_head *resources,
> +						  struct list_head *ib_resources,
>  						  struct resource **bus_range)
>  {
>  	return -EINVAL;
> --=20
> 2.20.1

Seems ok to me.


Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>


