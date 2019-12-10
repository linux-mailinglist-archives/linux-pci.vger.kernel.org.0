Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04C75118A1E
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2019 14:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfLJNrg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 10 Dec 2019 08:47:36 -0500
Received: from mail-oln040092255059.outbound.protection.outlook.com ([40.92.255.59]:16320
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727149AbfLJNrf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Dec 2019 08:47:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqiKBTA8P1TmAfoOGbibIvH1Di+BcjGhyO5Sccf0OdNX4cLS+kPI56S5E2DaiuOn2BAq3qVTzS3tp5345NXXb6lnoopnvd4Vw7T0+oJH+BJeyTalzSibV5ltTksDhz5uDMGh2NKxEnZjg+GzWGBwl3sGKDSS62pRGGmE0g3nPcwAGx06DdSKCjn+5FU+RWhtCzUjaVBstspo/cQ96ZxNENOSDdKn18vlwWpBgyMY4BxNteiEYF2cO6DjWhv301atXWb9F19DEglSbihjBHCfmKjXrbAUGklDUsvQBq0zosycK85w3qZqfLyxbm0ykkvpndZ99mAueTQQRPXXQQnzfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBGZzt9vSdQCjqVayg2aSe8MdWc/HziCPByPtdFZpbM=;
 b=TwBz45atlAuywmmnylpDfhU+tHZ5HVNOcHJVX5LPDIcAtwys7B9ChhpWZzKgua5gOTCL2t1W5+IBYm5vlm6ybmgZA6wa0XwIniYTKdeQUKGbPzJqcLLcpnwmBq51y43IxvOqvP1PyIDVNmkzqbRjNcf4MdAyWLTQ93KAknqi2KvvOqq8W0OyqGo3QVvi8VBWFzsX5Snq1MyNFzndp8xi2eIbj6oZFYfGFE3Ih14QHbNnr7lEqLzy8KtmBtcipn92VGpZKTadyLBjazhBg1oJhFZxQqlu/yqZ7nvoFKX3mBMi4ReZZF0PFScajd3iIfkiI8E6SFmVp85iBexo0SDeDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT034.eop-APC01.prod.protection.outlook.com
 (10.152.252.55) by PU1APC01HT006.eop-APC01.prod.protection.outlook.com
 (10.152.252.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.25; Tue, 10 Dec
 2019 13:47:28 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.252.60) by
 PU1APC01FT034.mail.protection.outlook.com (10.152.252.218) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.25 via Frontend Transport; Tue, 10 Dec 2019 13:47:28 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2516.018; Tue, 10 Dec
 2019 13:47:28 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Lukas Wunner <lukas@wunner.de>
CC:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] ALSA: hda/hdmi - Fix duplicate unref of pci_dev
Thread-Topic: [PATCH] ALSA: hda/hdmi - Fix duplicate unref of pci_dev
Thread-Index: AQHVr19Qzy/shWp/fkaS3esCokOlA6ezYe+A
Date:   Tue, 10 Dec 2019 13:47:28 +0000
Message-ID: <PSXP216MB0438D2E81B187B3B2124FEBB805B0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <PSXP216MB0438BFEAA0617283A834E11580580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <77aa6c01aefe1ebc4004e87b0bc714f2759f15c4.1575985006.git.lukas@wunner.de>
In-Reply-To: <77aa6c01aefe1ebc4004e87b0bc714f2759f15c4.1575985006.git.lukas@wunner.de>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYBPR01CA0161.ausprd01.prod.outlook.com
 (2603:10c6:10:d::29) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:8822E6DDAEBCA3275E32C0B44E618128EA5A75984C0178C215BB876FA80DA0AD;UpperCasedChecksum:4C6AA7A74B019171A31612F64834CE4DE390DBEA3567843CB8A064DF9A3CB78A;SizeAsReceived:7875;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [rSOqR51/ZlJCOdU1Aomsbq7iDusPb/nJbttplY6G9V7hSOSf6rBgDiHe8esbQ6TcU+NaACFTzr0=]
x-microsoft-original-message-id: <20191210134716.GB2390@nicholas-usb>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: e55a138f-3e0c-4d62-e94d-08d77d777f1c
x-ms-traffictypediagnostic: PU1APC01HT006:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rUofl2d5uofs/ycaeu2J2Rdy3RFhQWinB+qj2a+mhM4NUuogULSOd57Rck8jrOdsLTH2WFNpkOIHrw2KELLPZkncEsMYYq8ZjTuhmeQIyX82VmwAAgyDNWr196DFzbX3Pt3dG/IZGz9AYJ7nH2xZfcBiA00BCdmf64heNkx2SQRdF2l3dgQ9CQRQhMPFCS8q
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <082416B0366C5D4983007669B103DD6C@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e55a138f-3e0c-4d62-e94d-08d77d777f1c
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2019 13:47:28.6634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT006
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 10, 2019 at 02:39:50PM +0100, Lukas Wunner wrote:
> Nicholas Johnson reports a null pointer deref as well as a refcount
> underflow upon hot-removal of a Thunderbolt-attached AMD eGPU.
> He's bisected the issue down to commit 586bc4aab878 ("ALSA: hda/hdmi -
> fix vgaswitcheroo detection for AMD").
> 
> The commit iterates over PCI devices using pci_get_class() and
> unreferences each device found, even though pci_get_class()
> subsequently unreferences the device as well.  Fix it.
> 
> Fixes: 586bc4aab878 ("ALSA: hda/hdmi - fix vgaswitcheroo detection for AMD")
> Link: https://lore.kernel.org/r/PSXP216MB0438BFEAA0617283A834E11580580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM/
> Reported-and-tested-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Alexander Deucher <alexander.deucher@amd.com>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> ---
>  sound/pci/hda/hda_intel.c | 1 -
>  1 file changed, 1 deletion(-)
> 
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
> -- 
> 2.24.0
> 
Extremely fast turnaround from bisect to patch.

If you want the bugzilla.kernel.org report then I can do that ASAP, but 
I feel that it is redundant now.

Thank you for handling my bug report.

Regards,
Nicholas
