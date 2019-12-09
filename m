Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69DCF116D93
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2019 14:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfLINHX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 9 Dec 2019 08:07:23 -0500
Received: from mail-oln040092255071.outbound.protection.outlook.com ([40.92.255.71]:11136
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727074AbfLINHX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Dec 2019 08:07:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mue2U+lThKDgrVULp1BgFJzw/lalWRmkVD1jA3pXSWyltraathhDJjAC1JJHWQKFhiWljBu3+HjUi779FoKZlz66V7cyDAtUdJ8ETq1VhB8YYZkYbwwczkl6ocCZb188dTY6srfWlAou43AyITD4aT7Cto6QxxWKXRF7oYN83DQ0EQTX6tJw9uV0QfMaRZ6Tb02yAhV0iAxuo9QkNp0ynHsTHl9ELrwmgrqk+mePfziYF7oodzRUebLtXH41Bj1VEhJPfCmdalzUW5aSxLrrYXRy5WP6bTsH+g0gJb28Pgyds0Tc24jDjlwYPMya0WkvVQxAwpdLChkPxp6Ob+KkBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmeVqYowydBDy9xmba81wK5f2zR3Yr1BGLurLl/wGEQ=;
 b=nI2t2XxtY+q1RH1SHyb2sYfRm/tGLgHmZnvC1Fgw84JyVjWZEFMlcR/BvChHloyo89WfkT41zt3SWCkYNWWry1lo/m4AwUWJGHbDmxHtr0risAwduyIAoJS1yPogtK23rr6m/9a26gWp3dBPFENcPZqvMPHCEYrafibBvMf76IPgWb9/x98Tq7q3bxuCBJwkDrsHB9OxLnEGq+pzrcphejJAB0M2/TidTAc0KRnff847vYXbCk4SGmOHDpGvrSNrWKENqiGHQCqyK02PpPwiSTudDyHdb0wA27cLQUdprdpEcPfUO9QHcmjobLN+nEvNXbvniOTVJo+rYlvFMjXgLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT052.eop-APC01.prod.protection.outlook.com
 (10.152.252.52) by PU1APC01HT080.eop-APC01.prod.protection.outlook.com
 (10.152.253.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.25; Mon, 9 Dec
 2019 13:07:19 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.252.53) by
 PU1APC01FT052.mail.protection.outlook.com (10.152.253.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.25 via Frontend Transport; Mon, 9 Dec 2019 13:07:19 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 13:07:19 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Pavel Machek <pavel@ucw.cz>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
Subject: Re: Linux v5.5 serious PCI bug
Thread-Topic: Linux v5.5 serious PCI bug
Thread-Index: AQHVrozxq7Q7SfMf80m5ItEmvTDCAqexvccAgAAIQYA=
Date:   Mon, 9 Dec 2019 13:07:19 +0000
Message-ID: <PSXP216MB0438A01542EE28724B0FEEFF80580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <PSXP216MB0438BFEAA0617283A834E11580580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20191209123738.pp34bu7ulqp5adv6@ucw.cz>
In-Reply-To: <20191209123738.pp34bu7ulqp5adv6@ucw.cz>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYBPR01CA0008.ausprd01.prod.outlook.com (2603:10c6:10::20)
 To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:5F4DCCADD0135E9678A0C02CB8281123D8521322935CE696E11B123CBF41DC4D;UpperCasedChecksum:9C2F8AAB163FCA5BF92AB17575FE6CB02337E92EE0F2CC57DA35C181142EFE4B;SizeAsReceived:7582;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [ZdSYhLfwR8pW4Ba2V796edxDNNuQtuvPTl2RVQW3QRQ9oBg7ZSRCmEe7yMhPr2q3taWki0o3Hx0=]
x-microsoft-original-message-id: <20191209130711.GA1936@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: c09935a7-6f6e-4cb3-97dc-08d77ca8b8af
x-ms-traffictypediagnostic: PU1APC01HT080:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wIOHWhCE/tg/aHN8WpFP9kNgaltdX/B3YFjIvcUotpgP6gNotcl1G4AjTdpznXG9FChOIXWMu4hl5OXFb42yw7O5YkEoof4GeLiFUL5i6FTJAJDkG/aHylUy45J1/A+TDKA3m0H+y/3aQQLBW9LIYMshzVoJCKb1bqYEcbyg78C7B/HTmV4fguS085IWo/Gy
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A2327EB1A4A20B48B728BA795DC4C764@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c09935a7-6f6e-4cb3-97dc-08d77ca8b8af
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2019 13:07:19.4428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT080
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,
On Mon, Dec 09, 2019 at 01:37:38PM +0100, Pavel Machek wrote:
> > Hi,
> > 
> > I have compiled Linux v5.5-rc1 and thought all was good until I 
> > hot-removed a Gigabyte Aorus eGPU from Thunderbolt. The driver for the 
> > GPU was not loaded (blacklisted) so the crash is nothing to do with the 
> > GPU driver.
> 
> Obvious question is: does it work on in v5.4?
> 									Pavel
Always a good question to ask. The answer is "yes".

I would have noticed had it happened in v5.4 - I am constantly playing 
with Thunderbolt and the kernel. But I tried on v5.4 just now, just to 
be sure, and it works fine. I probably should have double checked, just 
in case, though.

Bisect to come.

Kind regards,
Nicholas
