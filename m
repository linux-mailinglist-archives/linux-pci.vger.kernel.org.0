Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E77AB162B2E
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2020 17:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgBRQ5e convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 18 Feb 2020 11:57:34 -0500
Received: from mail-oln040092254083.outbound.protection.outlook.com ([40.92.254.83]:6270
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726360AbgBRQ5e (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Feb 2020 11:57:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPYCPoKe4aV6hC4Dx7VhEFyKj68N0Ojxf4LTLfEFMCSihvb3/3goAorE2knUr3Bo5m3OAjNaZ8Tt4pIR0W+Jj5lHkGbVZP8P37sFXrCAqEWmcWtUxrhVWjDGzGsFoiv0UPI6wjAA8CnsNFq0j1JyYOEegUHSy69HcBnUsCCarE2bFvofVFdtlMHCJP915Qq0Pt4ABDFqfLfZH/3xvANaGCgA/gRzWSFgINKwJ2NDNSITMs0w5HA6fBcntSTVsRQGXwE9ByEpEemJhtEPM559KrDSf9z/OLglLXmYdVzGl2MUbZX5QyXerr4Ifo05A1aiGbub9baCv8+w21xy00o3EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8miYyXtRiQk+flFADQYgPm667WHabTcrBUG/zN6zBv8=;
 b=dsHLCcyWj036kGfQlqPJlzv0a21VBxdsH55jSInyg+ip9cPx/7eL2LEGmm7d8FsD3N6WbMFGLFFm1hmXZcFOT6rfdOkbjrZJkI0JxKD7xjfUkpRFTb1j9xbyw9syz6lTUWc4yVWq2hlv8fV+fdHFqPra8KPWwpuiTEGnbZdGd8/e/RKKxSwz/PjS8fa9394LojkCSYJInfbnU1iz82jVJv6gitNF286au24pFn/TfS3eyLoFz68xsHNDAJDx6WWLc/Rd2aF8c3pdlJIKlEv2w7U7/mx63gglHNH/FVAmHzDk7rsGWrrVnt8Ku4GHB2TLTrh4/lJsm1eiraZ4YFBEHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from HK2APC01FT013.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebc::36) by
 HK2APC01HT199.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebc::278)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22; Tue, 18 Feb
 2020 16:57:30 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.248.58) by
 HK2APC01FT013.mail.protection.outlook.com (10.152.248.160) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22 via Frontend Transport; Tue, 18 Feb 2020 16:57:29 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2%7]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 16:57:29 +0000
Received: from nicholas-dell-linux (2001:44b8:605d:19:a52b:32b4:97db:591c) by ME2P282CA0002.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:4d::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17 via Frontend Transport; Tue, 18 Feb 2020 16:57:28 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Lukas Wunner <lukas@wunner.de>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Stack trace when removing Thunderbolt devices while kernel
 shutting down
Thread-Topic: Stack trace when removing Thunderbolt devices while kernel
 shutting down
Thread-Index: AQHV5mZRaprLG3S8P026BwNeB/+bQKghC8YAgAAgZ4A=
Date:   Tue, 18 Feb 2020 16:57:29 +0000
Message-ID: <PSXP216MB043813ED0773A4D7E842B3A680110@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <PSXP216MB0438220243C0097569D4B2DB80110@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20200218150124.stvsj2rozxrgxw2h@wunner.de>
In-Reply-To: <20200218150124.stvsj2rozxrgxw2h@wunner.de>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2P282CA0002.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:4d::14) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:B3B09E2AF88F9165573A5A9E08408064B44B394555A156180D18E1114A1D48D8;UpperCasedChecksum:E7029EC3C24986F9D6299ED3B4C0D82F2E15D5B398FB6B55C3CBFE6A566AE424;SizeAsReceived:7908;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [u2pNdPck2pP3YEtywLf4ax5T+YtmCgu9R7hitZL8ThMWKkHylnFZoN1XcOZe8pzr]
x-microsoft-original-message-id: <20200218165723.GA1561@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 214e0517-a7e7-4433-1a26-08d7b493a3a9
x-ms-traffictypediagnostic: HK2APC01HT199:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WIStGC8ICfYXHTk5rT7cAUCjh7khb4GlyitfgkrRBr6d/6myTIotlX3iR78p+dvigyEpSYCHOUbHc830NyrKjmtXg0suMiREpY6qHeYt6UeBo+b/V8BBOqg+KQXWc0tLhWD1xqUKBKMQzoKorV51sf066zCHmC2JywYXBfRf6lIe7Wm/dA6lNqluM6MmTVa47a9G6rlJ27aMwEJz1SC1NSVz8Aa6g8s7uENOIeCOH4s=
x-ms-exchange-antispam-messagedata: gH+v5fegLd77G3xJe60l5SwERwuGCw800BDkPGfWhuIsAaN8bEZhsPg6yye027MowVYILUMVW+2cAU1KuWUnkCog3FAhnPeIbqDCRQNerrRjaRPJj3kNE7vc3l+nUy23hLUkf7agM9f8InIQm06Y1JwxRQsF8oT2VyTUpJUhBNsY/Hv8si0kvAcoLeTyeAKbiKMudSb+9UCl+hMs2nRyLQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <28AF0E9A9D798F4AA88A109EFF30722B@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 214e0517-a7e7-4433-1a26-08d7b493a3a9
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2020 16:57:29.8583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT199
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 18, 2020 at 04:01:24PM +0100, Lukas Wunner wrote:
> On Tue, Feb 18, 2020 at 02:18:40PM +0000, Nicholas Johnson wrote:
> > If I surprise remove Thunderbolt 3 devices just as the kernel is 
> > shutting down, I get stack dumps, when those devices would not normally 
> > cause stack dumps if the kernel were not shutting down.
> > 
> > Because the kernel is shutting down, it makes it difficult to capture 
> > the logs without a serial console.
> 
> Hold a camera in front of the screen and try to capture the messages
> as an MP4 movie which can be uploaded to YouTube or something.
https://www.youtube.com/watch?v=sDcYmbz7GME

The above is unlisted and will not appear in any search, so it will not 
confuse my subscribers, but anybody with the link can view it (public).

I am still not sure I like the sound of my own voice. *cringe*

> 
> If the output moves too fast to capture it, artificially slow it down
> by adding a udelay() to call_console_drivers() in kernel/printk/printk.c.

If you cannot get anything useful out of the aforementioned video, then 
I will do this tomorrow evening. It is almost 1am now.

> 
> Thanks,
> 
> Lukas

By the way, this is not just with Linux v5.6-rcX. I have noticed this 
for some time but it has been lower down my list in terms of priority 
and urgency. I half expected it to be of no interest. I should have 
mentioned it earlier, but before I might not have had as much time to 
help investigate. I am currently looking for new kernel development 
tasks because my previous ones are done.

Thanks,
Nicholas
