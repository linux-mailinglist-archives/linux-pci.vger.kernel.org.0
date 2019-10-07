Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA13CEC23
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2019 20:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbfJGSuG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 7 Oct 2019 14:50:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58277 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbfJGSuG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Oct 2019 14:50:06 -0400
Received: from mail-pl1-f199.google.com ([209.85.214.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1iHY57-0004gM-96
        for linux-pci@vger.kernel.org; Mon, 07 Oct 2019 18:50:05 +0000
Received: by mail-pl1-f199.google.com with SMTP id o9so9177494plk.13
        for <linux-pci@vger.kernel.org>; Mon, 07 Oct 2019 11:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=j3n/ZkJyjbkCNJF6jyQHAc6ep3KG8jgIKugTOiAIquA=;
        b=HzTtrkkXvtqFIUtnJ5onjm73ci9VFn7EV1FtGCJGag44zv7Y/tdZB3IeuaiAiTHyPa
         L3O1hT4v9zwLWoFyCbO/v/PGz5vvV4yySyCPY7g5Qed7wvXNwc0avsuNoEckVe6aU+po
         SQYyzNioOGI/a1YUQRpmchGQ49DP5Jp9MI4npqlPNyBbIBq1aCKYL5fh8nvPxB9WjmYm
         /T+ryoWOitNZO+y+3IshJsvSqcFdoErFTHykBtaRmWTxT0PctfyFFiC2f4AHJz+/S1E/
         lLMEhH6X2hE7xnlPJ6KxidJUA3X1OcLM3XMZjQvDl5ASr0M/xqwzBTD7+FY2/aSiGSN8
         t5Hg==
X-Gm-Message-State: APjAAAXY45eHJXDnOQe1Vz1FndYi7gsnn7dE8C2DuaryHow6FY6bwpcN
        LPwxCrFUslEBAbvo0X5s8iPY/Hbnv+h1NXjzs4yrIxBr3KbnYADNMAjBr47YIhD7HJQhtEvqN6J
        kVeBXmST7VdVDy6qmEB1VAJqdzqF7+Y/8b2+OuA==
X-Received: by 2002:a63:cf4a:: with SMTP id b10mr31888985pgj.276.1570474203607;
        Mon, 07 Oct 2019 11:50:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxYyjrNHb+/upkDF34lQqoJHpIsoJNhShTHUYsAQiE+4k5gVsln5/4pRkvWxwYkZjhr4KZGLQ==
X-Received: by 2002:a63:cf4a:: with SMTP id b10mr31888961pgj.276.1570474203258;
        Mon, 07 Oct 2019 11:50:03 -0700 (PDT)
Received: from 2001-b011-380f-3c42-ecd4-c98e-b194-f9c1.dynamic-ip6.hinet.net (2001-b011-380f-3c42-ecd4-c98e-b194-f9c1.dynamic-ip6.hinet.net. [2001:b011:380f:3c42:ecd4:c98e:b194:f9c1])
        by smtp.gmail.com with ESMTPSA id ce16sm223338pjb.29.2019.10.07.11.50.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 11:50:02 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: [PATCH v4 2/2] ALSA: hda: Allow HDA to be runtime suspended when
 dGPU is not bound to a driver
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190925113255.25062-2-kai.heng.feng@canonical.com>
Date:   Tue, 8 Oct 2019 02:49:56 +0800
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <F3E69B3D-E11B-4D99-905A-CC5927D61D6C@canonical.com>
References: <20190925113255.25062-1-kai.heng.feng@canonical.com>
 <20190925113255.25062-2-kai.heng.feng@canonical.com>
To:     tiwai@suse.com
X-Mailer: Apple Mail (2.3594.4.19)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Takashi,

> On Sep 25, 2019, at 19:32, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> Nvidia proprietary driver doesn't support runtime power management, so
> when a user only wants to use the integrated GPU, it's a common practice
> to let dGPU not to bind any driver, and let its upstream port to be
> runtime suspended. At the end of runtime suspension the port uses
> platform power management to disable power through _OFF method of power
> resource, which is listed by _PR3.
> 
> After commit b516ea586d71 ("PCI: Enable NVIDIA HDA controllers"), when
> the dGPU comes with an HDA function, the HDA won't be suspended if the
> dGPU is unbound, so the power resource can't be turned off by its
> upstream port driver.
> 
> Commit 37a3a98ef601 ("ALSA: hda - Enable runtime PM only for
> discrete GPU") only allows HDA to be runtime suspended once GPU is
> bound, to keep APU's HDA working.
> 
> However, HDA on dGPU isn't that useful if dGPU is not bound to any
> driver.  So let's relax the runtime suspend requirement for dGPU's HDA
> function, to disable the power source to save lots of power.
> 
> BugLink: https://bugs.launchpad.net/bugs/1840835
> Fixes: b516ea586d71 ("PCI: Enable NVIDIA HDA controllers")
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Do you still have any concern on this patch?
Please merge [v5 1/2] and this patch [v4 2/2] if you think it's good.

Thanks!

Kai-Heng

> ---
> v4:
> - Find upstream port, it's callee's responsibility now.
> v3:
> - Make changelog more clear.
> v2:
> - Change wording.
> - Rebase to Tiwai's branch.
> sound/pci/hda/hda_intel.c | 8 +++++++-
> 1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index 240f4ca76391..e63b871343e5 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -1280,11 +1280,17 @@ static void init_vga_switcheroo(struct azx *chip)
> {
> 	struct hda_intel *hda = container_of(chip, struct hda_intel, chip);
> 	struct pci_dev *p = get_bound_vga(chip->pci);
> +	struct pci_dev *parent;
> 	if (p) {
> 		dev_info(chip->card->dev,
> 			 "Handle vga_switcheroo audio client\n");
> 		hda->use_vga_switcheroo = 1;
> -		chip->bus.keep_power = 1; /* cleared in either gpu_bound op or codec probe */
> +
> +		/* cleared in either gpu_bound op or codec probe, or when its
> +		 * upstream port has _PR3 (i.e. dGPU).
> +		 */
> +		parent = pci_upstream_bridge(p);
> +		chip->bus.keep_power = parent ? !pci_pr3_present(parent) : 1;
> 		chip->driver_caps |= AZX_DCAPS_PM_RUNTIME;
> 		pci_dev_put(p);
> 	}
> -- 
> 2.17.1
> 

