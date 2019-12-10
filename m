Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02DA411877B
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2019 13:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfLJMBK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 10 Dec 2019 07:01:10 -0500
Received: from mail-oln040092254106.outbound.protection.outlook.com ([40.92.254.106]:26657
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726957AbfLJMBK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Dec 2019 07:01:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hjm/C8F6fIS9GvLzHQeLjF22/0t/DBGDdOaflWxhvZfLOZXqJtbkt631p6zIrRkdEJq7llX1N4fYYJHD3zT0/1u9gMRvIbELGn/cBOqcnUnSCWEkW81D2THwVFjRXkvyjz9U+3r2UuWZ+0COwExEoLsyQ8jPJFLT2KjQu74+VEwHkFuFtJYZe6kdo1hvAcbmBaCwJB2Hr8mtRf19/1mCgR0eHd/KuKtPpIyB7hpaFqwrKq5CQax6HkOh61nMFN8tFa0RHnHQXaZy42j+LzPEJ8F17yqoJi+bZnggHU2XsKC6EtR6xXyMpcZe0+/9RAhANQoTq8X9OEXisJU9w+rPZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7PJhKF7h1bccWxklF0ePrLbeo1o3ZNjk9P/usksGJ0=;
 b=h1ZdJ/4QOYzE57kesD+1mY8TbauIX7J7VIUV46j6ar5DVTIyZckd9gtj4vBglpy6gPAXYQbTslycCuisGPvnoT3kMs9Q9r2sb0fw/t0VZVlF0pGY3TJ5AXpCABo4K5e17AKzZ9MvflbgZlw5GzHGGKCDWXpAhsxz0j+rFrM83bNLyLvXwVym9KfwpXEHAAa3i4c5YyjQ+HQBCvFHCnqiEzL75jH56eoRvzj3CKryMERCUEZc2YIflVNUfwsrmLcL8As2qeN6/GpuAA2pAPNNcx1GVpkkfl6rCD05DDjJ43hlHMKXyx7E+2fs2uM7jYpRs9GzFheRVU28aGwMAI9cXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SG2APC01FT006.eop-APC01.prod.protection.outlook.com
 (10.152.250.54) by SG2APC01HT043.eop-APC01.prod.protection.outlook.com
 (10.152.250.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.25; Tue, 10 Dec
 2019 12:00:23 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.250.52) by
 SG2APC01FT006.mail.protection.outlook.com (10.152.250.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.25 via Frontend Transport; Tue, 10 Dec 2019 12:00:23 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2516.018; Tue, 10 Dec
 2019 12:00:23 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Linux v5.5 serious PCI bug
Thread-Topic: Linux v5.5 serious PCI bug
Thread-Index: AQHVrozxq7Q7SfMf80m5ItEmvTDCAqexx4+AgAAF4YCAASwpAIAATBAA
Date:   Tue, 10 Dec 2019 12:00:23 +0000
Message-ID: <PSXP216MB04384F89D9D9DDA6999347CF805B0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <PSXP216MB0438BFEAA0617283A834E11580580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20191209131239.GP2665@lahna.fi.intel.com>
 <PSXP216MB043809A423446A6EF2C7909A80580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20191210072800.GY2665@lahna.fi.intel.com>
In-Reply-To: <20191210072800.GY2665@lahna.fi.intel.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SY4P282CA0010.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:a0::20) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:31D4FA7B0E20B4A5F12CD9809972C86C29587ECED2EE00A2BC8BEB81ED1DBF32;UpperCasedChecksum:7D78B5B1EE5982E9DFCBF47D40C9C718E4F661FCB9A45165CBC18606695DBEEA;SizeAsReceived:7712;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [tCfVBWck0ytF2xECBnXpUOc094LKuSsXHHqqptRNXAb1pMgV7OryxDQoCLG1fMqI5fGaxq97rA4=]
x-microsoft-original-message-id: <20191210120011.GA2302@nicholas-usb>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: af0b131a-d037-4b37-bb76-08d77d6888fb
x-ms-traffictypediagnostic: SG2APC01HT043:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KLu6szqehAW0ZDCD9ZJMRzLxXjrPlGekeYXn/FQJ1XqaSHrLAY7hxkkswuq3aCkJD8rdpou+dUNi/WxWPNIvAMuzFkIS1FVRViUx9qlvlJHw2uNMpdcltlCHY1olDSk6zzNzWse+CSA6p85r76ICxXMe9qHpODfShxoTOxCfRMA3W+dlnkwJ+6xiITCFOyZS
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5DB306D412262F4BAF207230775CCDD6@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: af0b131a-d037-4b37-bb76-08d77d6888fb
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2019 12:00:23.0531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT043
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 10, 2019 at 09:28:00AM +0200, mika.westerberg@linux.intel.com wrote:
> On Mon, Dec 09, 2019 at 01:33:49PM +0000, Nicholas Johnson wrote:
> > On Mon, Dec 09, 2019 at 03:12:39PM +0200, mika.westerberg@linux.intel.com wrote:
> > > On Mon, Dec 09, 2019 at 12:34:04PM +0000, Nicholas Johnson wrote:
> > > > Hi,
> > > > 
> > > > I have compiled Linux v5.5-rc1 and thought all was good until I 
> > > > hot-removed a Gigabyte Aorus eGPU from Thunderbolt. The driver for the 
> > > > GPU was not loaded (blacklisted) so the crash is nothing to do with the 
> > > > GPU driver.
> > > > 
> > > > We had:
> > > > - kernel NULL pointer dereference
> > > > - refcount_t: underflow; use-after-free.
> > > > 
> > > > Attaching dmesg for now; will bisect and come back with results.
> > > 
> > > Looks like something related to iommu. Does it work if you disable it?
> > > (intel_iommu=off in the command line).
> > On Mon, Dec 09, 2019 at 03:12:39PM +0200, mika.westerberg@linux.intel.com wrote:
> > > On Mon, Dec 09, 2019 at 12:34:04PM +0000, Nicholas Johnson wrote:
> > > > Hi,
> > > > 
> > > > I have compiled Linux v5.5-rc1 and thought all was good until I 
> > > > hot-removed a Gigabyte Aorus eGPU from Thunderbolt. The driver for the 
> > > > GPU was not loaded (blacklisted) so the crash is nothing to do with the 
> > > > GPU driver.
> > > > 
> > > > We had:
> > > > - kernel NULL pointer dereference
> > > > - refcount_t: underflow; use-after-free.
> > > > 
> > > > Attaching dmesg for now; will bisect and come back with results.
> > > 
> > > Looks like something related to iommu. Does it work if you disable it?
> > > (intel_iommu=off in the command line).
> > I thought it could be that, too.
> > 
> > The attachment "dmesg-4" from the original email is with iommu parameters.
> > The attachment "dmesg-5" from the original email is with no iommu parameters.
> > Attaching here "dmesg-6" with the iommu explicitly set off like you said.
> > 
> > No difference, still broken. Although, with iommu off, there are less stack traces.
> > 
> > Could it be sysfs-related?
> 
> Bisect would probably be the best option to find the culprit commit.
> There are couple of commits done for pciehp so reverting them one by one
> may help as well:
> 
>   87d0f2a5536f PCI: pciehp: Prevent deadlock on disconnect
>   75fcc0ce72e5 PCI: pciehp: Do not disable interrupt twice on suspend
>   b94ec12dfaee PCI: pciehp: Refactor infinite loop in pcie_poll_cmd()
>   157c1062fcd8 PCI: pciehp: Avoid returning prematurely from sysfs requests
You are not going to believe this. The offending commit is in the SOUND 
subsystem. I thought I had messed up the bisect when only sound commits 
were showing near the end.

And yes, I double checked.

Reverted, compiled, tested that it started working.
Reapplied, compiled, tested that it stopped working.
Twice.

The following is the culprit responsible for the issues:

commit 586bc4aab878efcf672536f0cdec3d04b6990c94
Author: Alex Deucher <alexander.deucher@amd.com>
Date:   Fri Nov 22 16:43:50 2019 -0500

    ALSA: hda/hdmi - fix vgaswitcheroo detection for AMD

It is playing with PCI devices. Clearly they did not consider 
hot-removal. I am guessing it is seeing the audio PCI func of the AMD 
card in that Thunderbolt eGPU enclosure.

I will collect information, make a bugzilla report and contact the AMD 
team. If anybody wants to be cc'd in then let me know. Sorry for 
bothering you and Bjorn with something which actually has nothing 
directly to do with the PCI subsystem or Thunderbolt.

I strongly hope that the upcoming Intel Xe GPU driver allows for 
surprise-removal in Linux without any crashing of kernel or userspace. 
The amdgpu and nouveau drivers do not take to surprise removal kindly, 
even without the above sound bug applying to AMD.

Kind regards,
Nicholas
