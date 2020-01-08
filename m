Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6DA133F17
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2020 11:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgAHKSO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jan 2020 05:18:14 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:50347 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgAHKSO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jan 2020 05:18:14 -0500
Received: from [192.168.1.155] ([95.114.105.36]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MWAWq-1jDvbf2ieg-00XfCY; Wed, 08 Jan 2020 11:17:21 +0100
Subject: Re: [PATCH 6/6] (v3) drivers: hwmon: i5k_amb: simplify probing /
 device identification
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org, tim@buttersideup.com,
        james.morse@arm.com, rrichter@marvell.com, jdelvare@suse.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-crypto@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pci@vger.kernel.org
References: <20191210232529.GA171629@google.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <07148b8e-5b87-66ad-e52b-be2b8b22e712@metux.net>
Date:   Wed, 8 Jan 2020 11:16:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191210232529.GA171629@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:TAwu3cp8xgdnoC+QVXxTZuo1d6L730Y/hIlnNlnChNeKzUKMs/t
 vNr9OrZqijZoHde4YF3t7ezNikPhOGlTm3R3WPK2sFjTW0Ghd5q8U73Bqf/Cf638mqBacxr
 rxW5gCPbhzuRN5HCty8OClMKTVVag/UlQVZYL0GJ2GBhW/C9h/k8rH8iNTxaRPLMZo+G2+T
 SFaY74zTgfT3qK8buR+QQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UX0qjWzvj1w=:MNJwBZoBg0zHdAbLIu7jZ1
 NQ6YqkA9o0GZJBWd8Ad4X7sj60ITE703Y9e7n05lpKaAE5k4kxh/DB85CtkI7X1e4k8xYOZju
 qK7RFrKDmrWjMa7E0xlTfWdlhUMF80E7Ft/CnN2WDqFZB82yOlvrFHdDEW3AVYU0FQVAVvOu+
 YmGlw72B3Pym8MYoAVDb71/m3UmCh3k9BDSmEAjNRLbRDCF2VVgSjzJ1oEeH9x+WoP421kWi5
 Yibzza7ZuNPPOXysDmnaFlJ+GxbCHrX7w8VWIbYFTw3vaN575729znMCT2FoTnPZhukzP1dh/
 fYYEgmMZtopETatbu1oflvhY/l55FbEBlrPy0u4Wzl91jtzfmJvgE5bmDrELARWK6dxISKLko
 rptrWYwfFHMjKBsQ9ruUZGnliXn1/wOeqNvtxFkQ5qxNSGilOnQxwnWpNCB729Y8lm1ofBN3U
 14o+bKqmdkWaauabumrjuFSSKvU7c/SUXKWHBtZOokt4B1jhLIu1Pr1xtT6BfE9DITZEKEvNL
 iObWk/IDco3bI5QmqGf7qRYlCBeLsoGR03KQRp4nuIgelCd7prjiVFVB0DJ8tRsfBa60fl9eV
 jT11ZBjzj/yBOIOnx5stFSioHSAQ1CvygDOgp+DpWJ79kX/VOOV4wXTUYts9aGe2YUTA6ypVT
 /6J1nf5LJtaUhKFBTCxakheBb4RQryHo9BA0eHR/n1345Ne0yrVogVyoksPgsmFAQhJpc45OK
 jfW41Y6in+LRLl0JH8xDJqmpy/HOOzN664Cm9yV7fKSDPnfiHAhRW50ZmtyT86rLVy8E3zfbZ
 WlLquMtpmnga8pIzXT7MyITSbdmrIdww1ALX9SRXPNcMu/QxOueQBuTGUOMb2+PsngyEZbdzs
 qBetrh5ZIRf5o9ia/XdQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11.12.19 00:25, Bjorn Helgaas wrote:

Hi,

>   2) I despise the pci_get_device() interfaces because they're
>   inefficient, not hotplug-safe, they circumvent the device model
>   claim mechanism, and it's hard to do the reference counting
>   correctly.

Agreed, but for that we'd have to edac and hwmo driver together into
one (or maybe a MFD). That would be a major rewrite, and I don't have
the necessary HW to test it.

>   3) There are several things going on in this patch and it would be
>   easier to read if you could split them into separate patches:
> 
>     - Removing the redundancy between chipset_ids[] and i5k_amb_ids[].
>       This seems like a nice change.
> 
>     - The "chipset_ids[i].fbd0 + 1" thing was weird and the new
>       ".driver_data + 1" is still weird.  Those are PCI device IDs,
>       and addition is not a valid operation on those IDs.  IMHO both
>       PCI_DEVICE_ID_INTEL_5000_FBD0 and PCI_DEVICE_ID_INTEL_5000_FBD1
>       should be listed explicitly in the driver instead of trying to
>       compute PCI_DEVICE_ID_INTEL_5000_FBD1.

Ok, good point.

>     - Replacing the hard-coding of PCI_VENDOR_ID_INTEL with the vendor
>       ID from i5k_amb_ids[] seems worthwhile and should be its own
>       separate patch (if possible).
> 
>     - Changing to use pci_get_device_by_id().  This should be trivial
>       to verify, like the other patches.

Ok, I'll try to split it up more clearly, once I've got some more spare
time.


--mtx

---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
