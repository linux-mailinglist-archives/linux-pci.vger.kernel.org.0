Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79AC5136410
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2020 00:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbgAIXzX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 9 Jan 2020 18:55:23 -0500
Received: from mail-oln040092253061.outbound.protection.outlook.com ([40.92.253.61]:4459
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729700AbgAIXzX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jan 2020 18:55:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/4Uu7o72nzChfxjT9EEoSk7chkcfhN/yzLydcB/6gS/kLzm4dVX0ldJZCS+j0Xn5wKamA72bIxGgoagkUkuYd4HcVH/f687CVPYWqGg82qaY6hcOUgqYSvuONOEHJVsFbBvwi3SHzor84jlSDnqT4nJdXuoqquIVsuAzU/NhYFw6izIKCnnDKvzEuP4G/PK/AFl9UjFa3GltAWypY35oH1FH/inWnoTGfFsLnkcuHxgstjt48zw5XIL83+sOmvjvV4SSlOO40S7gWl2aSkTeNfUSqDr+8S0b2bXOCdgu8r2gi9IjY8aSNdzzevr8TRS73mdHPUHGQRefGWiIrW80Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42HnFGg2aKRwsTw/vnd7hdbu1j3mp2yKbuW7AF+BjXE=;
 b=UyhSp6j1gPQNrVeRACLUZ4hxyTcLUDJ8LFNqlX/2+OPa0zPB1jepLtAZ4Bb+W9WQDGNC0OlMU5gAclAkFyS1FHhJ/ep6Iklo6GWpchQnDzA8nZTD4hp9r+bjYbLpKSO/58Pwmffd7Yw8ebqqkjTa8hgYX/MxpFg54nj4gIrL4KwU/cOg18bedi4LndrWHDe4/OwghG43DXvUY2O8mP4IZBaj3N+b+WP9r+F8IzcjHLUKzxz86hAvUHKXfC8WPsZVbJvm9iOBViIVvGNVm7c7oKqAFu+ehb9eI370VR0Edg3Bm7ElMzJrEU3JexVQTW581VUi8blgfrs9bdkcSsmvFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT014.eop-APC01.prod.protection.outlook.com
 (10.152.252.54) by PU1APC01HT031.eop-APC01.prod.protection.outlook.com
 (10.152.253.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11; Thu, 9 Jan
 2020 23:55:19 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.252.52) by
 PU1APC01FT014.mail.protection.outlook.com (10.152.252.224) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Thu, 9 Jan 2020 23:55:19 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2623.013; Thu, 9 Jan 2020
 23:55:19 +0000
Received: from nicholas-dell-linux (49.196.2.242) by MEAPR01CA0099.ausprd01.prod.outlook.com (2603:10c6:220:60::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.11 via Frontend Transport; Thu, 9 Jan 2020 23:55:16 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Yicong Yang <yangyicong@hisilicon.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        fangjian 00545541 <f.fangjian@huawei.com>
Subject: Re: PCI: bus resource allocation error
Thread-Topic: PCI: bus resource allocation error
Thread-Index: AQHVxqUOw0iofsw/uESP6AY8W25VP6fiIr+AgAC+64CAACF/AA==
Date:   Thu, 9 Jan 2020 23:55:18 +0000
Message-ID: <PSXP216MB0438B0DAE881F9B7F7581D3080390@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <25173a78-8927-5b2f-c248-731629bbc8ec@hisilicon.com>
 <20200109215517.GA255522@google.com>
In-Reply-To: <20200109215517.GA255522@google.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MEAPR01CA0099.ausprd01.prod.outlook.com
 (2603:10c6:220:60::15) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:7580C53B33D8356B956718FB57DF84BC0A442D46805B8FD85BEDD22CB75B834B;UpperCasedChecksum:D4E7CDE84ABCD06E8311444E3397F6AFDEAE214183227CE50825EF261AC3A733;SizeAsReceived:7678;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [DhnQ+O9Qj1mfYaFG6TzMJ6VgtZPwDT8B]
x-microsoft-original-message-id: <20200109235510.GA1596@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: e80e4c83-2fff-4382-63da-08d7955f6170
x-ms-traffictypediagnostic: PU1APC01HT031:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z1vkTInUdgDzaeU3vwyLNODwGOXdDc6rAWcNKHNxbobRnzoytB34SRljyJKjyv5ioscu+C7hgQLVzAuu0Zvhe6zIi5Vm12BYGMjS5Zl+NdwFC+NqOzWwAjv37qkNA784Nm9xDs0bAzsis8XLYLx/4v6EEgDJUi1BM4cqwjvkWxmAslysDu8lWb5TlwAljBZV
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4A2A69E5D68C6544B979B282A52397F5@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e80e4c83-2fff-4382-63da-08d7955f6170
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 23:55:19.0029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT031
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 09, 2020 at 03:55:17PM -0600, Bjorn Helgaas wrote:
> On Thu, Jan 09, 2020 at 06:31:57PM +0800, Yicong Yang wrote:
> > On 2020/1/9 12:27, Bjorn Helgaas wrote:
> > > [+cc Nicholas, who is working in this area]
> > >
> > > On Thu, Jan 09, 2020 at 11:35:09AM +0800, Yicong Yang wrote:
> > >> Hi,
> > >>
> > >> recently I met a problem with pci bus resource allocation. The allocation strategy
> > >> makes me confused and leads to a wrong allocation results.
> > >>
> > >> There is a hisilicon network device with four functions under one root port. The
> > >> original bios resources allocation looks like:
> > > What kernel is this?  Can you collect the complete dmesg log?
> > 
> > The kernel version is 5.4.0.  
> 
> Good; at least we know this isn't related to Nicholas' new resource
> code that's in -next right now.

It is not in next - it is in the release candidates, right?
> 
> > the dmesg log is like:
> 
> The below is not the complete dmesg log.  I don't know what your
> system is, but the complete log might be in /var/log/dmesg, or maybe
> you could capture it with the "ignore_loglevel" kernel parameter and a
> serial console?
> 
> > [  496.598130] hns3 0000:7d:00.3 eth11: net stop
> > ...
Yicong, please provide the full outputs of: "dmesg" and "sudo lspci 
-xxxx" and "sudo cat /proc/iomem" in a location that is publicly 
accessible so that anybody reading this email can find it.

Kind regards,
Nicholas
