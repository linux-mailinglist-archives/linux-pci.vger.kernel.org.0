Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98B3513686E
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2020 08:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgAJHk1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 10 Jan 2020 02:40:27 -0500
Received: from mail-oln040092253047.outbound.protection.outlook.com ([40.92.253.47]:5484
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725844AbgAJHk1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Jan 2020 02:40:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U39/yuDtHaayVUrMmNK+SwMjoh4BJRjmm4tTrMbGNmqUHIFvHP//FlJRcoOkcyxohYPJreFmMrJ/1bUjnZpEOjFgj18JYh+5/5657ENHXPJhovBNXEgtUTIz3DCluqGyS2/PD6nw3LWS5lPpOVxSNbwd1qG64U2qRxIkZlusPZq+WcPBBmlq59sSeUUnEqOOi6NXp5Mi9SSoTSWl3TEGAkrMjrf3KgDLEf7R7lGZ+JBLOFR4/PP0qA4qj3C3G+iyOk0uhOcGuOdiEVHLHBUB6QpV3FSPnwgGow65SV4B7S6pH23XDgiX7jvCsd18/SanUJ0m1CfsWuU0dHzhfsPQ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofi4QMCRWVtXfu7MUHN5gWUjNkyjjCq+TK8askGIMSc=;
 b=QGXxoXvBG1CWJguvlpm8DDyeOnKnNgtf7A80t9eAx1YSZvJ0C7Cd09BbeVVIBRV2LvTcq9TOUgRaTaTEh6UpgzhQMJpHwrRJVumSE80/s32o6PBgMWWtgl0g5exrR8BicLvRJP78ltXUlUslsJXrPdw2Y7aXdGEO5McEZZUhm8d7lbOyMwBB5Y5zY4ZlX6O9ELL4JxoH0Pd6bv4y8ApqkV8/3i/l2Z+j2oWXdmpXpSq2A+7Oh+8AtFF1jd+e/vJy1U2OVehFFN9aXvnQVH/u6amzWD5Y1ENVEsHqGuX42/OULozEUL03AUX0HKQqa/uJtkh6MLHcN37ba0g4Tnq4jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from HK2APC01FT038.eop-APC01.prod.protection.outlook.com
 (10.152.248.56) by HK2APC01HT235.eop-APC01.prod.protection.outlook.com
 (10.152.249.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11; Fri, 10 Jan
 2020 07:40:21 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.248.55) by
 HK2APC01FT038.mail.protection.outlook.com (10.152.248.243) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Fri, 10 Jan 2020 07:40:21 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2623.013; Fri, 10 Jan
 2020 07:40:21 +0000
Received: from nicholas-dell-linux (49.196.2.242) by ME4P282CA0013.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:90::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 07:40:17 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Yicong Yang <yangyicong@hisilicon.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        fangjian 00545541 <f.fangjian@huawei.com>
Subject: Re: PCI: bus resource allocation error
Thread-Topic: PCI: bus resource allocation error
Thread-Index: AQHVx4hAJYx6aq+dvkSE1wcW3LemFqfjg0+A
Date:   Fri, 10 Jan 2020 07:40:20 +0000
Message-ID: <PSXP216MB0438E92832F08A1AEC015D8180380@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <f0cab9da-8e74-e923-a2fe-591d065228ee@hisilicon.com>
 <1bcc117a-3fce-35c2-a52c-f417db3ce030@hisilicon.com>
In-Reply-To: <1bcc117a-3fce-35c2-a52c-f417db3ce030@hisilicon.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME4P282CA0013.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:90::23) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:AAA85FC285B283E2027F9F343CFC072D916B7914A8CAABD7C75B7C08A8A65571;UpperCasedChecksum:87A653F94AB95DBCEB73DB4BB7C3EE88CF434985C220BBBACEEA321283E770F8;SizeAsReceived:7691;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [Wyqys46OwHpBBRp5i2CavGSdTil43AOW]
x-microsoft-original-message-id: <20200110074011.GA1615@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: b6213d60-3e2f-4d46-6631-08d795a05808
x-ms-traffictypediagnostic: HK2APC01HT235:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: opsHJD8qH1CCpqei1QiKeYynQSKghcblj+SGvjjSrS2050+qpJWFxyMY21GSejY1qAApwSMOx3l5VJUP+UvIFli77gL1AUzhLBvYKCT/FvZpsI99jT3zC8bZZD29nWPCRRjbiJHY+dBkqDeq8V3fubJeA6CU76ltAsDxWq2uGV4nfPgGUChcYzAeLhLvv+mc
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <74CF0C5F18E8E643AD999091C0CED9DC@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b6213d60-3e2f-4d46-6631-08d795a05808
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2020 07:40:20.9252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT235
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Fri, Jan 10, 2020 at 03:33:27PM +0800, Yicong Yang wrote:
> Hi,
> 
> It seems the attachments are blocked by the server.
> The necessary console output is below.
> The kernel version is 5.4, centos release 7.6.  I didn't
> change the PCI codes.

It is very difficult for me to get the wider picture of your system 
without the full output of "sudo lspci -xxxx". Can you place them on 
PasteBin and send the links, rather than attaching them directly?

I can try to speculate based on what you sent, but I cannot be sure it 
will be enough. For example, I do not know if your computer has multiple 
root complexes, which have shown to complicate things.

Thanks!
