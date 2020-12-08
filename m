Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343B82D30CE
	for <lists+linux-pci@lfdr.de>; Tue,  8 Dec 2020 18:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730632AbgLHRTX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 12:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgLHRTX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Dec 2020 12:19:23 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0FFC0613D6;
        Tue,  8 Dec 2020 09:18:37 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id qw4so25618833ejb.12;
        Tue, 08 Dec 2020 09:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=R9W7zwZUOBsepqSWi0fNg20NbD95BC6Jpxonv559qJU=;
        b=U2iEGF08OCwPGXyrw36R2hoMaLk7yIhB9uOa1ZHyRrGfIue2BNE8kQQuATxE8CWX9A
         KW5Je2I/N6vGHQHD0v0ChaUxME9V3roPgxZZl3z2AD6Bj4qRAaIEc0dFT9keGK0OnEzi
         IaoqIFGlet2iM+JaIRh5yZPyDlauwxFuadW5jeA4DCSf9VHD1gld6y22UyhT8yt/T5+m
         eeCZHq9m7S2dVLI8XcWs4ZyxgfSCD/lYeNLqPm+dxjh2baUV8R4Or3nfbGfJA97Un1En
         gMgaHhltEPU0OeXWW6VFrkzlxu2rYZ1iur+4EKU53bgsQ/dwlv0iONvmCi5GNv7uBUYI
         X6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=R9W7zwZUOBsepqSWi0fNg20NbD95BC6Jpxonv559qJU=;
        b=k3s3l70HU1WydffZg/wTDUc9vxz34ygeKnX88OsUp+RJ665VQPKzkUWnJgiTbbvvwF
         E93Yvwk3xjAEhh8SJPMos8hYjZnwodJMdvc61CkcX0mXT0HWjmkCqiHAyMRrnqWs1ygR
         iquNy7Q6fKnoVDBryD+EB0nwsdAFKCxMi0+Eq9+MfCgQ/UrhltSaTs8yyMsrnC0QzxCm
         3iBISlh6/66ZhnGMVme6ZGBMkgV/KJ2TTQx+dGDVZ3s3SBi33WnCx30rSYLN2IgEIp1k
         4uzeDekMJ8L/6hEAD8/mn7Nfe07Rh+qXMpkz/WwPeYN6LwftL6nozf5KqnaC1CEm1xO8
         J0pg==
X-Gm-Message-State: AOAM532LSp+TLoTA59AFy3RwOoZ9+toduyuK9hFn3lzaDEmO8F8qkAJM
        SCE+/v5pRsfuLyHmUYtr3+AHfnl6DhU=
X-Google-Smtp-Source: ABdhPJzxjnRlyGOzIoA5LCzU8dcX9dcdg/CNgFvkVe7gofn/6Fkasiu+VcRkpcdepbdCtjJNcC1SsA==
X-Received: by 2002:a17:906:f1cc:: with SMTP id gx12mr23206359ejb.164.1607447916023;
        Tue, 08 Dec 2020 09:18:36 -0800 (PST)
Received: from ?IPv6:2003:ea:8f06:5500:580f:b429:3aa2:f8b1? (p200300ea8f065500580fb4293aa2f8b1.dip0.t-ipconnect.de. [2003:ea:8f06:5500:580f:b429:3aa2:f8b1])
        by smtp.googlemail.com with ESMTPSA id b19sm13961766edx.47.2020.12.08.09.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 09:18:35 -0800 (PST)
Subject: Re: [PATCH 1/2] PCI/ASPM: Store disabled ASPM states
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, bhelgaas@google.com
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20201208082534.2460215-1-kai.heng.feng@canonical.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <4212dca6-233b-4d6c-0182-1e7912a05b3f@gmail.com>
Date:   Tue, 8 Dec 2020 18:11:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201208082534.2460215-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 08.12.2020 um 09:25 schrieb Kai-Heng Feng:
> If we use sysfs to disable L1 ASPM, then enable one L1 ASPM substate
> again, all other substates will also be enabled too:
> 
> link# grep . *
> clkpm:1
> l0s_aspm:1
> l1_1_aspm:1
> l1_1_pcipm:1
> l1_2_aspm:1
> l1_2_pcipm:1
> l1_aspm:1
> 
> link# echo 0 > l1_aspm
> 
> link# grep . *
> clkpm:1
> l0s_aspm:1
> l1_1_aspm:0
> l1_1_pcipm:0
> l1_2_aspm:0
> l1_2_pcipm:0
> l1_aspm:0
> 
> link# echo 1 > l1_2_aspm
> 
> link# grep . *
> clkpm:1
> l0s_aspm:1
> l1_1_aspm:1
> l1_1_pcipm:1
> l1_2_aspm:1
> l1_2_pcipm:1
> l1_aspm:1
> 
> This is because disabled ASPM states weren't saved, so enable any of the
> substate will also enable others.
> 
> So store the disabled ASPM states for consistency.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/pci/pcie/aspm.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index ac0557a305af..2ea9fddadfad 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -658,6 +658,8 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
>  	/* Setup initial capable state. Will be updated later */
>  	link->aspm_capable = link->aspm_support;
>  
> +	link->aspm_disable = link->aspm_capable & ~link->aspm_default;
> +

This makes sense only in combination with patch 2. However I think patch 1
should be independent of patch 2. Especially if we consider patch 1 a fix
that is applied to stable whilst patch 2 is an improvement for next.

>  	/* Get and check endpoint acceptable latencies */
>  	list_for_each_entry(child, &linkbus->devices, bus_list) {
>  		u32 reg32, encoding;
> @@ -1226,11 +1228,15 @@ static ssize_t aspm_attr_store_common(struct device *dev,
>  	mutex_lock(&aspm_lock);
>  
>  	if (state_enable) {
> -		link->aspm_disable &= ~state;
>  		/* need to enable L1 for substates */
>  		if (state & ASPM_STATE_L1SS)
> -			link->aspm_disable &= ~ASPM_STATE_L1;
> +			state |= ASPM_STATE_L1;
> +
> +		link->aspm_disable &= ~state;

I don't see what this part of the patch changes. Can you elaborate on why
this is needed?

>  	} else {
> +		if (state == ASPM_STATE_L1)
> +			state |= ASPM_STATE_L1SS;
> +

I think this part should be sufficient to fix the behavior. because what
I think currently happens:

1. original status: policy powersupersave, nothing disabled -> L1 + L1SS active
2. disable L1: L1 disabled, pcie_config_aspm_link() disabled L1 and L1SS
   w/o adding L1SS to link-> aspm_disabled
3. enable one L1SS state: aspm_attr_store_common() removes L1 from
   link->aspm_disabled -> link->aspm_disabled is empty, resulting in
   L1 + L1SS being active

>  		link->aspm_disable |= state;
>  	}
>  
> 

