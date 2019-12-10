Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47086118C96
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2019 16:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfLJPeb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Dec 2019 10:34:31 -0500
Received: from mail-mw2nam12on2063.outbound.protection.outlook.com ([40.107.244.63]:64096
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727407AbfLJPeb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Dec 2019 10:34:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFywqhqtkuan3OpDSk4j53D4yXr4wi5/FVYHIAXtVL9Rlz0uVB5ky/LEL30d3zxTkHmcSBZgan8dM5kZhj5CHP1auG4sqyKqm9OGMPAFUgXqqbNoUnCAJ19OmOwbcRhG5J+7X1flU0pOvdBEI7YdwC9DWrHzPC0jQ1PL8EEgKl55Y2V0ofWHzX5/rl7MZhlNwZ8wbkzxIV8rouraST/krWWs9adxFMNUFgPf3SATayYFqi8/95z6LegXTAaGoMXCnl4cL66NX/89c9ZbD99jV72GH3euL64yVBPa09Wmva/d0SKzFVSQnQIDBmtGl4cHy7osRIddd+t/gS7BmrN18Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EleMNlWPnGEcQxM7/lvjWRLop0GAmc/hPoYPp6c7Waw=;
 b=ODoFr5kI/FrobLAxSP+9DAXFMgHf0y3yibjpYMRHZqKxNYydCY33drNhHD8MrZkBo5X26L0r16lwRKOTqD7jKS+DfPEIyckpeVK9Z2gzpV6dR1rRV/GdjohuHkmA3Qllr+B/Z/aokuWBayAtG+2yXp9uCJBRyZFD+Qy7FBNxGxfrW8TGtEK+pMaEVtt9Qt1hCuRDwfdf9MeCVTcibt0fO4DoyA6Yo6IKumdrcn9s1H7nu6QkDgj1nYg5F9eWfrNzjuUrmWs+S0a/ed8qv0qLiM3xpC3J8Nylrh6WwoJNLkwbfH2G/P1q7Q67PGmbp2TUvTW4CpeaEHu197suEGJZpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EleMNlWPnGEcQxM7/lvjWRLop0GAmc/hPoYPp6c7Waw=;
 b=OtG+4jRNR6jKCbOOUU9LxP8qwqnLLJiM0sM3b7g6J5MPYcP4PEbAfvDTf/xP2fecyShuwLKF0IWVd331a7IakxYxDKpnRNOng2i3jjC/QuHXrnKjmqAt0OBj6BHQvReqNjkcSRCWkrOoIPwnrrptCf/LGb8jUz4eIXQYsVPn7AE=
Received: from MWHPR12MB1358.namprd12.prod.outlook.com (10.169.203.148) by
 MWHPR12MB1277.namprd12.prod.outlook.com (10.169.204.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Tue, 10 Dec 2019 15:34:27 +0000
Received: from MWHPR12MB1358.namprd12.prod.outlook.com
 ([fe80::b94d:fcd8:729d:a94f]) by MWHPR12MB1358.namprd12.prod.outlook.com
 ([fe80::b94d:fcd8:729d:a94f%3]) with mapi id 15.20.2538.012; Tue, 10 Dec 2019
 15:34:27 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Lukas Wunner <lukas@wunner.de>, Takashi Iwai <tiwai@suse.de>
CC:     Jaroslav Kysela <perex@perex.cz>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH] ALSA: hda/hdmi - Fix duplicate unref of pci_dev
Thread-Topic: [PATCH] ALSA: hda/hdmi - Fix duplicate unref of pci_dev
Thread-Index: AQHVr19R5YQIlg2NqEC5WtHx1mfv7qezf2rg
Date:   Tue, 10 Dec 2019 15:34:27 +0000
Message-ID: <MWHPR12MB1358AEEBD730A4EDA78894E6F75B0@MWHPR12MB1358.namprd12.prod.outlook.com>
References: <PSXP216MB0438BFEAA0617283A834E11580580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <77aa6c01aefe1ebc4004e87b0bc714f2759f15c4.1575985006.git.lukas@wunner.de>
In-Reply-To: <77aa6c01aefe1ebc4004e87b0bc714f2759f15c4.1575985006.git.lukas@wunner.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [165.204.11.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 29d545a7-65a9-42d7-1dc3-08d77d867113
x-ms-traffictypediagnostic: MWHPR12MB1277:
x-microsoft-antispam-prvs: <MWHPR12MB12770C7F1A5C42B790521932F75B0@MWHPR12MB1277.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:267;
x-forefront-prvs: 02475B2A01
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(13464003)(199004)(189003)(7696005)(5660300002)(53546011)(8676002)(33656002)(9686003)(55016002)(186003)(26005)(71200400001)(76116006)(81156014)(8936002)(66946007)(6506007)(4326008)(66556008)(66476007)(478600001)(52536014)(86362001)(66446008)(966005)(81166006)(45080400002)(316002)(54906003)(64756008)(2906002)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1277;H:MWHPR12MB1358.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u6n44VLSDe+iGpx8gueue1lBO1zY8uFp7JZyz3WRas+RHwTQCzWBw5Qm6L+LFKiWIx84SAG1vfSpVLoD5vuAww2pwkgHwRTOistEYtIn/Gn+1+OBiW9qsIfut147xN5IFwjjjFF0c+dUVEPO86wY2N3YfDo1Qu6XicTFJm2J9rmxJFabxufmhfySwACZOmsWjBE3ksgmH51qclprDBTtgMicVguK/EstMbsRAPsRw9GCc81jO34oVXOPQnRJ5c1J2ZEqdN/ibzJYieZlDXWlsTLybf24ui9Vd2JA+q9ZDe6ROzAYR3jSAiwOSrnGJt6WRLR3LPPTVkYATRUrd0hWW9P+PnJB1xoEfoosECEGR8OHVbHrWs0g5zvxxUYpaTcSpXZDaz2qs+CrDwRvslPUprty6uYos5OlqWNrzEM8D0p+QVX+RfJNixqRS3Ebg5CJBVdy9yONy+pmyt6W4olB4FoTqMfvZ899N562RS9bdX6syvxYFaNbxvjWxijyxU/q
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29d545a7-65a9-42d7-1dc3-08d77d867113
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2019 15:34:27.1332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ybL+Ngih2HbsR6iY/nj+DKS2KwJgv6YGXv2Nv8BCZ0fJteeERd/Dvxdbz9MZdgvfJU+DTlETZsrKQfzFg/WO0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1277
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Lukas Wunner <lukas@wunner.de>
> Sent: Tuesday, December 10, 2019 8:40 AM
> To: Takashi Iwai <tiwai@suse.de>
> Cc: Jaroslav Kysela <perex@perex.cz>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Mika Westerberg
> <mika.westerberg@linux.intel.com>; Bjorn Helgaas <helgaas@kernel.org>;
> Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>; alsa-
> devel@alsa-project.org; linux-kernel@vger.kernel.org; linux-
> pci@vger.kernel.org
> Subject: [PATCH] ALSA: hda/hdmi - Fix duplicate unref of pci_dev
>=20
> Nicholas Johnson reports a null pointer deref as well as a refcount under=
flow
> upon hot-removal of a Thunderbolt-attached AMD eGPU.
> He's bisected the issue down to commit 586bc4aab878 ("ALSA: hda/hdmi - fi=
x
> vgaswitcheroo detection for AMD").
>=20
> The commit iterates over PCI devices using pci_get_class() and unreferenc=
es
> each device found, even though pci_get_class() subsequently unreferences
> the device as well.  Fix it.

The pci_dev_put() a few lines above should probably be dropped as well.

Alex

>=20
> Fixes: 586bc4aab878 ("ALSA: hda/hdmi - fix vgaswitcheroo detection for
> AMD")
> Link:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.
> kernel.org%2Fr%2FPSXP216MB0438BFEAA0617283A834E11580580%40PSXP2
> 16MB0438.KORP216.PROD.OUTLOOK.COM%2F&amp;data=3D02%7C01%7Calex
> ander.deucher%40amd.com%7C254649b79a6240f3a8aa08d77d76715f%7C3d
> d8961fe4884e608e11a82d994e183d%7C0%7C0%7C637115819998031934&amp
> ;sdata=3DqI%2B%2FJv3Z6pvwN7gQFSnZiP31YUAvd%2BKjo0ZqMERFbYU%3D&a
> mp;reserved=3D0
> Reported-and-tested-by: Nicholas Johnson <nicholas.johnson-
> opensource@outlook.com.au>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Alexander Deucher <alexander.deucher@amd.com>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> ---
>  sound/pci/hda/hda_intel.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c index
> 35b4526f0d28..b856b89378ac 100644
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

