Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1825E2D6388
	for <lists+linux-pci@lfdr.de>; Thu, 10 Dec 2020 18:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731471AbgLJR17 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Dec 2020 12:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731183AbgLJR1s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Dec 2020 12:27:48 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BABC061793;
        Thu, 10 Dec 2020 09:27:08 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id g18so4858277pgk.1;
        Thu, 10 Dec 2020 09:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pESQHKROviAabVIjRIrizpkAZ1uv3tEw2w1kIolVoaU=;
        b=EUeL7s3SOfaAGpDC1PE+x01B+P9ToQJsk+XtbSeNUBF3EmJSIK2NwuYPu3OShELxtA
         r8TeFtKaankrBxMb7fxJkuSPkwQyk5crc15zDPH4a4FS7oWHCy1qlDvVeyECkeDFCvkL
         o9tIlevHf931vx7truspSLRR5OewpDB9CcQR8CpuA/Tjbe/rRoNCYm89WQnQP7Vits05
         gu1/Pmykov5HodFMLa0kp2gnrL379RK+z42JFuawy16by8urnGkRAZAfprWjtZuxObqq
         yQgB5Et4pAHaIOa3s1eiNllonjrM5mKjWa8Hhft0EUS4divQ/T+8Gi7patm+ZWlRhyHM
         AQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pESQHKROviAabVIjRIrizpkAZ1uv3tEw2w1kIolVoaU=;
        b=hjHkkTVFjAYWHZthFPp6+b6cAMofyOu1TuvHqQ2Rfl98WkHFjZE90x0QjHq/O0q3D+
         /ytVLngzyeyzNqkRB7LMYRuNGBEizYEN/D6bwx7v/saWnjZJih9Ah8fHnZSDg4r4d4Pe
         /cxRq32oOHf3RJ93MPM485pvPK81AQ27zCw5LwdcDeiYDHbIL/uWF/vS7DrM9HODPK1c
         CrAPoytah29RUaR+8diLVSzz2qa9thQ1dTmyHIc00RO0pd22fqLIEyCYbnlOPApSrJ9t
         q9QG5jmiqiwNLOdp9/x9GG7zpY7ZFKb5g2zq7acYHfR/+l0NpN+GzyB4kKlso1HANz/c
         7hvg==
X-Gm-Message-State: AOAM533XDWw8C6mG78JpzkR8p0FYH899N5mJTdTTz1p4f/6xseSM1QsB
        3T7OpfvSrIB4SUI1qwWwEG8=
X-Google-Smtp-Source: ABdhPJxZ0vl/x2vkJiSYhJOWSaCgB6e4ZM735iLWQn4dHHOQg34pYkuxk2+WhenbdLgXJL0R6ZBG3Q==
X-Received: by 2002:aa7:9813:0:b029:19d:c82a:92e7 with SMTP id e19-20020aa798130000b029019dc82a92e7mr7616012pfl.71.1607621228217;
        Thu, 10 Dec 2020 09:27:08 -0800 (PST)
Received: from [10.230.29.166] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id h16sm6900067pgd.62.2020.12.10.09.27.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 09:27:07 -0800 (PST)
Subject: Re: [PATCH V2 2/2] PCI: brcmstb: support BCM4908 with external PERST#
 signal controller
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com
References: <20201130083223.32594-1-zajec5@gmail.com>
 <20201130083223.32594-3-zajec5@gmail.com>
 <812ab1ce-15e0-d260-97cf-597388505416@gmail.com>
 <d27eec9f-f937-d0c3-1c33-6b6210effb1a@milecki.pl>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <c74f354e-4bf4-c16f-0cf1-1cd7410eb53a@gmail.com>
Date:   Thu, 10 Dec 2020 09:27:05 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <d27eec9f-f937-d0c3-1c33-6b6210effb1a@milecki.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 12/10/2020 12:46 AM, Rafał Miłecki wrote:
>> This looks good to me now, just one nit, you probably do not support
>> suspend/resume on the 4908, likely never will, but you should probably
>> pulse the PERST# during PCIe resume, too. With that fixed:
>>
>> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> Driver already does that.
> 
> Suspend forward trace:
> brcm_pcie_suspend()
> brcm_pcie_turn_off()
> pcie->perst_set(pcie, 1)
> 
> Resume forward trace:
> brcm_pcie_resume()
> brcm_pcie_setup()
> pcie->perst_set(pcie, 0)
> 
> Correct me if I'm wrong please.

Nope, it's all good, my memory was incorrectly serving me, since
perst_set() has been moved to a callback you have it called indeed.

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks!
-- 
Florian
