Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A38B71188E2
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2019 13:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfLJMwg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 10 Dec 2019 07:52:36 -0500
Received: from mail-oln040092253070.outbound.protection.outlook.com ([40.92.253.70]:18084
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727131AbfLJMwg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Dec 2019 07:52:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQbaM9e5uBxodnO0N2DbOzssO60ZL89Azi8rqE2BGc4dem4c1aK6t0Sncdm2wi8gvZ8SJd0mnbBL4VipdYWoVyvhUeH6V4ckD/Abx/HcJTPhQswmuImNzZ+oVUWGVMrhl5KWSDHEMLnJlZyAwKk1mMsc3qa3nbCIc2idAGnnhJIMuP7/iRHK+kcI9WmwuZ1GPXVaRHrybMijMZemnH1xcKtAe+QFvuC60heHUcciuj+Iix4CdFxRnuf6r7/F9WpLQaRaVgNw0qXtuQMoaqfYGYf0oO/FJFbAWjLsNGJqq9FatiAhlvumpXQyhINTt7S9T7XAjfTrzUJgD4UjGawvgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Udk/pGGZTG+tDX7ddrXE2H7K0bDjgFcjAYANpzoaRHs=;
 b=V4H991gOF1Oj/gV3i0OsGbV6xICBW1C7E+0lhZM6HMJt+o8MGLNG1ICcDYCNh1qOvr17KHnZ+U9pLH70SW58Z/Jg5A5Z1QETH9+rV6Tmd+ET24MLQsBe6XESm92vOvYltysTBWzxSatVwsEV6D71csJh0aBvazvS15nbjSlAGw1lapXyJ9MjSeRYetERkNd1do/54IXFOSn9pybits507u0nL0AnTUmLQarYL7M1AlHRzbtp+dNulcq6bfjrhmlQYed/jQKoPXOJyhDwOt6V3cL5lE4YMvdQLy55IOkzRIR7Z2+Hda3Y1VuNTPZHI61VJvs8+/bH3uOM5f9cSAEqOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from HK2APC01FT106.eop-APC01.prod.protection.outlook.com
 (10.152.248.55) by HK2APC01HT148.eop-APC01.prod.protection.outlook.com
 (10.152.249.170) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.25; Tue, 10 Dec
 2019 12:52:30 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.248.52) by
 HK2APC01FT106.mail.protection.outlook.com (10.152.249.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.25 via Frontend Transport; Tue, 10 Dec 2019 12:52:30 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2516.018; Tue, 10 Dec
 2019 12:52:30 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Lukas Wunner <lukas@wunner.de>
CC:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "tiwai@suse.de" <tiwai@suse.de>
Subject: Re: Linux v5.5 serious PCI bug
Thread-Topic: Linux v5.5 serious PCI bug
Thread-Index: AQHVrozxq7Q7SfMf80m5ItEmvTDCAqexx4+AgAAF4YCAASwpAIAATBAAgAAIOoCAAAZVgA==
Date:   Tue, 10 Dec 2019 12:52:30 +0000
Message-ID: <PSXP216MB04382AFE08EAC9E3D7BB190E805B0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <PSXP216MB0438BFEAA0617283A834E11580580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20191209131239.GP2665@lahna.fi.intel.com>
 <PSXP216MB043809A423446A6EF2C7909A80580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20191210072800.GY2665@lahna.fi.intel.com>
 <PSXP216MB04384F89D9D9DDA6999347CF805B0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20191210122941.zzybs4z5jphpjsu2@wunner.de>
In-Reply-To: <20191210122941.zzybs4z5jphpjsu2@wunner.de>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SY4P282CA0012.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:a0::22) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:3E776928496272AEC0437930044BFDEC396E6BFE29A1DC25F2EB446BAE08F92C;UpperCasedChecksum:BF18C1BF94ACF765AA95042115FB67E159505D19FD27059C0AA56C76D459A0AD;SizeAsReceived:7980;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [RPXDFIKaM2bbipOWDjzuehCjcYQcHz/l3gq05f1BRWhH4jxikfFS4QsT4xdvAHV+Lha5sUfQBMo=]
x-microsoft-original-message-id: <20191210125218.GA2390@nicholas-usb>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: c4f99184-0c02-48b7-0c18-08d77d6fd160
x-ms-traffictypediagnostic: HK2APC01HT148:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w5gUwVgnQhl0FmXVvVcZ3GzkvzCx4qGmsCZtVJnm7yS99xl2qIEVZ0cO4VnjMI+nlv6G1GPaKrie65bq8cFN1s3B0+8K2Bt2QTf92yBXAeBMSgc5UVylkKhTGHuXtOUhV6BZTtAAyjJz2wZB5jiK5POvj0AKfgEju7X8MMApixOA6bnFv0BqiSy4iHEEbcYZ
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7A63601F34FFC44EA9A5257000013AC0@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f99184-0c02-48b7-0c18-08d77d6fd160
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2019 12:52:30.7027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT148
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 10, 2019 at 01:29:41PM +0100, Lukas Wunner wrote:
> [cc += Alex, Takashi]
> 
> On Tue, Dec 10, 2019 at 12:00:23PM +0000, Nicholas Johnson wrote:
> > On Tue, Dec 10, 2019 at 09:28:00AM +0200, mika.westerberg@linux.intel.com wrote:
> > > On Mon, Dec 09, 2019 at 01:33:49PM +0000, Nicholas Johnson wrote:
> > > > On Mon, Dec 09, 2019 at 03:12:39PM +0200, mika.westerberg@linux.intel.com wrote:
> > > > > On Mon, Dec 09, 2019 at 12:34:04PM +0000, Nicholas Johnson wrote:
> > > > > > I have compiled Linux v5.5-rc1 and thought all was good until I 
> > > > > > hot-removed a Gigabyte Aorus eGPU from Thunderbolt. The driver for the 
> > > > > > GPU was not loaded (blacklisted) so the crash is nothing to do with the 
> > > > > > GPU driver.
> > > > > > 
> > > > > > We had:
> > > > > > - kernel NULL pointer dereference
> > > > > > - refcount_t: underflow; use-after-free.
> > 
> > The following is the culprit responsible for the issues:
> > 
> > commit 586bc4aab878efcf672536f0cdec3d04b6990c94
> > Author: Alex Deucher <alexander.deucher@amd.com>
> > Date:   Fri Nov 22 16:43:50 2019 -0500
> > 
> >     ALSA: hda/hdmi - fix vgaswitcheroo detection for AMD
> 
> Does the below fix the issue?
> 
> -- >8 --
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index 35b4526f0d28..b856b89378ac 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -1419,7 +1419,6 @@ static bool atpx_present(void)
>  				return true;
>  			}
>  		}
> -		pci_dev_put(pdev);
>  	}
>  	return false;
>  }
Yes, removing the pci_dev_put() as above solves the issue.

Thanks.

Kind regards,
Nicholas.
