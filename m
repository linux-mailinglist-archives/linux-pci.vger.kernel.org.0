Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BACB1187FF
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2019 13:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfLJM3o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Dec 2019 07:29:44 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:56999 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbfLJM3o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Dec 2019 07:29:44 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 125AA100B01B2;
        Tue, 10 Dec 2019 13:29:42 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id B9112ECCD5; Tue, 10 Dec 2019 13:29:41 +0100 (CET)
Date:   Tue, 10 Dec 2019 13:29:41 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        alexander.deucher@amd.com, tiwai@suse.de
Subject: Re: Linux v5.5 serious PCI bug
Message-ID: <20191210122941.zzybs4z5jphpjsu2@wunner.de>
References: <PSXP216MB0438BFEAA0617283A834E11580580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20191209131239.GP2665@lahna.fi.intel.com>
 <PSXP216MB043809A423446A6EF2C7909A80580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20191210072800.GY2665@lahna.fi.intel.com>
 <PSXP216MB04384F89D9D9DDA6999347CF805B0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSXP216MB04384F89D9D9DDA6999347CF805B0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[cc += Alex, Takashi]

On Tue, Dec 10, 2019 at 12:00:23PM +0000, Nicholas Johnson wrote:
> On Tue, Dec 10, 2019 at 09:28:00AM +0200, mika.westerberg@linux.intel.com wrote:
> > On Mon, Dec 09, 2019 at 01:33:49PM +0000, Nicholas Johnson wrote:
> > > On Mon, Dec 09, 2019 at 03:12:39PM +0200, mika.westerberg@linux.intel.com wrote:
> > > > On Mon, Dec 09, 2019 at 12:34:04PM +0000, Nicholas Johnson wrote:
> > > > > I have compiled Linux v5.5-rc1 and thought all was good until I 
> > > > > hot-removed a Gigabyte Aorus eGPU from Thunderbolt. The driver for the 
> > > > > GPU was not loaded (blacklisted) so the crash is nothing to do with the 
> > > > > GPU driver.
> > > > > 
> > > > > We had:
> > > > > - kernel NULL pointer dereference
> > > > > - refcount_t: underflow; use-after-free.
> 
> The following is the culprit responsible for the issues:
> 
> commit 586bc4aab878efcf672536f0cdec3d04b6990c94
> Author: Alex Deucher <alexander.deucher@amd.com>
> Date:   Fri Nov 22 16:43:50 2019 -0500
> 
>     ALSA: hda/hdmi - fix vgaswitcheroo detection for AMD

Does the below fix the issue?

-- >8 --
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 35b4526f0d28..b856b89378ac 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1419,7 +1419,6 @@ static bool atpx_present(void)
 				return true;
 			}
 		}
-		pci_dev_put(pdev);
 	}
 	return false;
 }
