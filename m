Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE0574F02
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2019 15:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389452AbfGYNSl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 25 Jul 2019 09:18:41 -0400
Received: from mail-oln040092253038.outbound.protection.outlook.com ([40.92.253.38]:40585
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389701AbfGYNSl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Jul 2019 09:18:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJmagfiDvJfVG99Hqk2GCLpCoqjWRcAQvXowcVeLf/o9TkWLMWjZY8MyCeJJLZREU7nxUebP2cyi53CxIk0J3EWVr4LUbgKFZkyWbEENketpyPhJK3SaCgOMmXIUWDcXRF1F1qZN4v416sT50Bxe5G1AYfFO7v73TID3Uawj4/zwhnFj/Y0nbFDPti0OzBLvrItbY3Kzfp/UncCepxnYU2ruvFCTog1Tn56ng0+0j8Tl5YEdfWK/oWGAk0Uho18LnwIcWTcjl92aIYIDQbY0qepvKL5CyyZL+OIqZuARNAiB89eRdo48+plKhTtouW7YvLv1sB+6wQ6s9vDAOt8GlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZj/HLO/08vHiAId4cPga1Vpxl+B4Dc67QUZB/mA6xs=;
 b=D0W1MIbe2gx3nYduG8ICRDNtvpqfSSa6JGxYFxOpylej0AQLthxVoEiCqQfL8M3clQv/AMIDQvNYbSIr5hAyrXLFoOCD+h+aLun33n8RNxdsYz9pm6zKePfWcRgdSgQmybIBhLOfa6oIiX8/v/Q8YJ8UctxFjIqvZrEfr7GTJ8zfbSFh8wmJGt6p28YzgefidWTif1zNhG4Lw5pYkNfQH2jf53OCb+GPjUwCLzeCVGmhsu50FVIZc7Fw6xVXtv5xMnGaMft1GeSCtCcFQVYf5/dtf/7H+dNJYDL6q70D/q4j+smWedEk9yUAQMjLcfHUceLa9foT6Ggk4tzi6fn85g==
ARC-Authentication-Results: i=1; mx.microsoft.com
 1;spf=none;dmarc=none;dkim=none;arc=none
Received: from PU1APC01FT112.eop-APC01.prod.protection.outlook.com
 (10.152.252.59) by PU1APC01HT085.eop-APC01.prod.protection.outlook.com
 (10.152.253.150) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2115.10; Thu, 25 Jul
 2019 13:18:34 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.252.55) by
 PU1APC01FT112.mail.protection.outlook.com (10.152.252.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2115.10 via Frontend Transport; Thu, 25 Jul 2019 13:18:34 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::1cba:d572:7a30:ff0d]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::1cba:d572:7a30:ff0d%3]) with mapi id 15.20.2094.013; Thu, 25 Jul 2019
 13:18:34 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Logan Gunthorpe <logang@deltatee.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Possible PCI Regression Linux 5.3-rc1
Thread-Topic: Possible PCI Regression Linux 5.3-rc1
Thread-Index: AQHVQh7cG4T+gPWoEEORs36yrE7T46bZxdcAgAGMzQA=
Date:   Thu, 25 Jul 2019 13:18:34 +0000
Message-ID: <SL2P216MB0187E2042E5DB8D9F29E665280C10@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
References: <SL2P216MB01878BBCD75F21D882AEEA2880C60@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <20190724133814.GA194025@google.com>
In-Reply-To: <20190724133814.GA194025@google.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYCPR01CA0026.ausprd01.prod.outlook.com
 (2603:10c6:10:e::14) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:ECA2A109FF4DDE6F78C99B519662BC3F93D38A0BFD07691A4A5D7CF01EB3187F;UpperCasedChecksum:43663CFDB0DCF2A58A031E7097B9EAC89BB3349EFB550AAF73E99827A799FF30;SizeAsReceived:7682;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [6Va+XQz6qOwI1eQrFIgFTBU5kHt5YO8q6qawEu+0oV0G5zuDQGnfaC+AAWtTm6qO/ytMXkILXCc=]
x-microsoft-original-message-id: <20190725131823.GA2445@nicholas-usb>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:PU1APC01HT085;
x-ms-traffictypediagnostic: PU1APC01HT085:
x-microsoft-antispam-message-info: mXtqZ/spemH7CD9+UJZcZfDN4vamRWPvXGFZ7Lw17P8n+7+HGU7hLGaHa9t4mKvvOrP0z6EAgyeTHMECg7z9Pb4iUyt6+WQYqWRc2Cn+w/2yhSu1K5TRQ4x+jPY5sK+ptLEx7CTIM+bU928SU6WQY5Hc4a4vQOhTABVtZbG7a7h3zPeA9aT7sfHTttCht0Lh
Content-Type: text/plain; charset="us-ascii"
Content-ID: <97316E6967B59C4DAB506A32D9AB8AAC@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e832372e-d906-4383-8dc6-08d711029847
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 13:18:34.2445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT085
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 24, 2019 at 08:38:14AM -0500, Bjorn Helgaas wrote:
> On Wed, Jul 24, 2019 at 12:54:00PM +0000, Nicholas Johnson wrote:
> > Hi all,
> > 
> > I was just rebasing my patches for linux 5.3-rc1 and noticed a possible 
> > regression that shows on both of my machines. It is also reproducible 
> > with the unmodified Ubuntu mainline kernel, downloadable at [1].
> > 
> > Running the lspci command takes 1-3 seconds with 5.3-rc1 (rather than an 
> > imperceivable amount of time). Booting with pci.dyndbg does not reveal 
> > why.
> > 
> > $ uname -r
> > 5.3.0-050300rc1-generic
> > $ time lspci -vt 1>/dev/null
> > 
> > real	0m2.321s
> > user	0m0.026s
> > sys	0m0.000s
> > 
> > If none of you are aware of this or what is causing it, I will submit a 
> > bug report to Bugzilla.
> 
> I wasn't aware of this; thanks for reporting it!  I wasn't able to
> reproduce this in qemu.  Can you play with "strace -r lspci -vt" and
> the like?  Maybe try "lspci -n" to see if it's related to looking up
> the names?

For a second you had me doubting myself - it could have been a Ubuntu 
thing. But no, I just reproduced it on Arch Linux, and double checked 
that it was not doing it on 5.2. Also, the problem occurs even without 
the PCI kernel parameters which I usually pass.

Looking into this further, it seems that removing the Thunderbolt 
controller solves the issue, where XX is the bus after the root port:

$ echo 1 | sudo tee /sys/bus/pci/devices/0000\:XX\:00.0/remove

Removing the USB controller of the Thunderbolt controller alone can 
alleviate the problem for a few seconds, before it returns - I have no 
idea why. Removing the whole Thunderbolt controller from the root solves 
the problem indefinitely.

This is why you cannot reproduce it in QEMU - no Thunderbolt controller.

It could be a coincidence that it does it for Thunderbolt, but Mika 
Westerberg might be interested now.

Doing "lspci -n" makes no difference - it suffers the problem whenever 
the normal command does.

Doing "strace lspci -vt" unloaded a lot of information that I cannot 
summarise. But if you have access to a physical system with Thunderbolt, 
then you might be able to reproduce the issue and have a better chance 
of pinpointing the problem than I.

Thanks for looking at this.

Kind regards,
Nicholas
