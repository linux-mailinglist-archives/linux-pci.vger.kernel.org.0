Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C00F41CD81
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 22:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbhI2Uls (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 16:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbhI2Ulr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Sep 2021 16:41:47 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E8DC06161C
        for <linux-pci@vger.kernel.org>; Wed, 29 Sep 2021 13:40:06 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id x124so4466996oix.9
        for <linux-pci@vger.kernel.org>; Wed, 29 Sep 2021 13:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6m3nplWrHXrMT3I5w4DGRoimq5ZGYdTxswQPq6L8Qy8=;
        b=E+7e/xrIhTvckBox0RsAIwG4kcE+vpAE4L+PShoJt2xmI6zhB8nxhzW9h7+t0+nfLq
         0mCHXEsBKUZYbN+yCU7UUqkfobnmlyVa9sHPRR70IvlsQMcArmfguEXyIhpYvGtmUTag
         G76n0w5X3olrxgYSnmzCUQfAx6Jbs0jZly7DOJsv0UCnKBmrAJBtupBGXp+V5OOLN9TN
         cSnk0MgTUCccHSJnSwH9n+up6J2rLAP5pM5INgrPDR9yBSoVCPn9zxBZccuxpez0X341
         qDOdcvJq1/oQJrWF8zHxfS0wBDJQbhjxuy+jcEyDV/RPUjRI4T+WYAXQxg58ejfp5pnD
         t2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6m3nplWrHXrMT3I5w4DGRoimq5ZGYdTxswQPq6L8Qy8=;
        b=R21NwqgqIB9kLaTKiuekBQFW3rnhwCz19WrFRaDmsXX/6ntsX+FW0/5jWUajQI1h6J
         Sy/VuYAjhLnBOJzuavZ6VofTaK3vKOfHb7ItAov8ArLmQk1iNNACBUyO65lNhRSUGC6j
         XCG8HZnmfiGl2bDRYLVfjHzJuB1zKdb8iFDzElYKo88TrFKoDgMoaduTonkFKNWdGssJ
         UnIfq0GqbrjEUuzoY9przVeClsPNLiMJCf81si2KonE1Eu04pmgEXm5ce9Ujsz2vqkm6
         K6F5q3Y+WUdZ/eDmbVgYkbLRyHvivuraHymYLBmZx1dDUWuMrJC9wBD+xhBjkbJUG4WP
         cpDg==
X-Gm-Message-State: AOAM530vP9EykcxGCQy4Zb0JOqPXPSw5tvjHHFPF94jqAIENO0FrwtjC
        vqZMZDM/sR/kAANOIAF/1c+qR/oyEmk=
X-Google-Smtp-Source: ABdhPJxp51Ca9EcnOBFjVQSVLTMyC46MdOtPvwl/BFLeuESbHnhFyWb82c4UOkjO+SC6s1VQoA1UGw==
X-Received: by 2002:aca:110e:: with SMTP id 14mr1559604oir.18.1632948005553;
        Wed, 29 Sep 2021 13:40:05 -0700 (PDT)
Received: from ?IPv6:2603:8081:2802:9dfb:5d00:b38a:cb98:331b? (2603-8081-2802-9dfb-5d00-b38a-cb98-331b.res6.spectrum.com. [2603:8081:2802:9dfb:5d00:b38a:cb98:331b])
        by smtp.gmail.com with ESMTPSA id 4sm177431ota.48.2021.09.29.13.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 13:40:04 -0700 (PDT)
Subject: Re: [PATCH 1/4] PCI: pciehp: Ignore Link Down/Up caused by
 error-induced Hot Reset
To:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Sinan Kaya <okaya@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-pci@vger.kernel.org, Russell Currey <ruscur@russell.cc>,
        Oliver OHalloran <oohall@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <cover.1627638184.git.lukas@wunner.de>
 <251f4edcc04c14f873ff1c967bc686169cd07d2d.1627638184.git.lukas@wunner.de>
From:   stuart hayes <stuart.w.hayes@gmail.com>
Message-ID: <44663bf3-efce-c40a-9013-434ab9c47513@gmail.com>
Date:   Wed, 29 Sep 2021 15:40:03 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <251f4edcc04c14f873ff1c967bc686169cd07d2d.1627638184.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/31/2021 7:39 AM, Lukas Wunner wrote:
> Stuart Hayes reports that an error handled by DPC at a Root Port results
> in pciehp gratuitously bringing down a subordinate hotplug port:
> 
>    RP -- UP -- DP -- UP -- DP (hotplug) -- EP
> 
> pciehp brings the slot down because the Link to the Endpoint goes down.
> That is caused by a Hot Reset being propagated as a result of DPC.
> Per PCIe Base Spec 5.0, section 6.6.1 "Conventional Reset":
> 
>    For a Switch, the following must cause a hot reset to be sent on all
>    Downstream Ports: [...]
> 
>    * The Data Link Layer of the Upstream Port reporting DL_Down status.
>      In Switches that support Link speeds greater than 5.0 GT/s, the
>      Upstream Port must direct the LTSSM of each Downstream Port to the
>      Hot Reset state, but not hold the LTSSMs in that state. This permits
>      each Downstream Port to begin Link training immediately after its
>      hot reset completes. This behavior is recommended for all Switches.
> 
>    * Receiving a hot reset on the Upstream Port.
> 
> Once DPC recovers, pcie_do_recovery() walks down the hierarchy and
> invokes pcie_portdrv_slot_reset() to restore each port's config space.
> At that point, a hotplug interrupt is signaled per PCIe Base Spec r5.0,
> section 6.7.3.4 "Software Notification of Hot-Plug Events":
> 
>    If the Port is enabled for edge-triggered interrupt signaling using
>    MSI or MSI-X, an interrupt message must be sent every time the logical
>    AND of the following conditions transitions from FALSE to TRUE: [...]
> 
>    * The Hot-Plug Interrupt Enable bit in the Slot Control register is
>      set to 1b.
> 
>    * At least one hot-plug event status bit in the Slot Status register
>      and its associated enable bit in the Slot Control register are both
>      set to 1b.
> 
> Prevent pciehp from gratuitously bringing down the slot by clearing the
> error-induced Data Link Layer State Changed event before restoring
> config space.  Afterwards, check whether the link has unexpectedly
> failed to retrain and synthesize a DLLSC event if so.
> 
> Allow each pcie_port_service_driver (one of them being pciehp) to define
> a slot_reset callback and re-use the existing pm_iter() function to
> iterate over the callbacks.
> 
> Thereby, the Endpoint driver remains bound throughout error recovery and
> may restore the device to working state.
> 
> Surprise removal during error recovery is detected through a Presence
> Detect Changed event.  The hotplug port is expected to not signal that
> event as a result of a Hot Reset.
> 
> The issue isn't DPC-specific, it also occurs when an error is handled by
> AER through aer_root_reset().  So while the issue was noticed only now,
> it's been around since 2006 when AER support was first introduced.
> 
> Fixes: 6c2b374d7485 ("PCI-Express AER implemetation: AER core and aerdriver")
> Link: https://lore.kernel.org/linux-pci/08c046b0-c9f2-3489-eeef-7e7aca435bb9@gmail.com/
> Reported-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v2.6.19+: ba952824e6c1: PCI/portdrv: Report reset for frozen channel
> Cc: Keith Busch <kbusch@kernel.org>

Tested-by: Stuart Hayes <stuart.w.hayes@gmail.com>

