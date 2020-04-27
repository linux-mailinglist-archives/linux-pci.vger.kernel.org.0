Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF941BAAE4
	for <lists+linux-pci@lfdr.de>; Mon, 27 Apr 2020 19:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgD0ROj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Apr 2020 13:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgD0ROi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Apr 2020 13:14:38 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBD0C0610D5;
        Mon, 27 Apr 2020 10:14:38 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id x25so482213wmc.0;
        Mon, 27 Apr 2020 10:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iUbGEjNpgGtO2vWiDgXwqS6XKUZo7L9U0uKkXPD20wc=;
        b=MAGlHvud2x5nuYmv3mRLbCOhvrVzmKE9Hc6UYu3wwmr3QDvPoDMurQQGVmEMdHzvmm
         tr9zwVqA+fTXEiQhJp/we9wTK2pLQJKZSFP+OjdtJq210KmnVf9k1y9wO2X96ZJBzZrv
         qv3XKC1zBCPPVI8OZkCvKVD88Vji4tyYc/rbddw4U/ex87hMpwSZ2pzmWzlFyl2X2bCa
         n8MZlFVtjP9CUMK2l4108Di4TRYYkq/QskwaIsHeQ57ahEUon3hFSfpHlexSOaVVbk2l
         A1Ztnfv0DImEVfkLDPtLjkFFLDdfSm9/9DQpsZ32el+Nfm+3Wc7o4T8Hhw4MJ4U/KVPZ
         okXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iUbGEjNpgGtO2vWiDgXwqS6XKUZo7L9U0uKkXPD20wc=;
        b=U39HSYJ9KwQ+Q3yELaEjOOS/YGcUbESv5Kv/iJbELFRzCOKS8WALNxFUpOU7Hd1XE4
         NbcRGGG8L+seLnSSIkGG/+LzABMSZnYtSYWjcLz6DBzNWdRPGIaVWF8wX3IVM4bhSHlZ
         pp8FcR4aN1mPT94IG0bE5iA+ZKjhRzJuE6M1da7fEVIPZXgzMiuTi7pdBB/8RqXsWSdm
         oon8Q2ri7xGCu6TVxDHlNN4gO6AMNwknHQI63rDH8b0Q+VroHPEYUsNtM1UU+UTizj8z
         vuqgHpb14fsdq/QWsIlNmP8SNl/l0p3qRHh9+uAS04siLxxUJ/dQ9rd4VP8W6BkE9iOY
         BBzQ==
X-Gm-Message-State: AGi0Pub5DRoRno5kqZT2d8ROupknXCSdEaVOHipr4h1SYYR11yf1Dp7T
        sNvWIX1aGWbo8rliqgpahttU1IDE
X-Google-Smtp-Source: APiQypKViGrk5fcwpFqZMo4PT9BLhQSxhVkQdWaM1Mhbac1DdUEEjDZxAwXpWfDi8p4pjc6g/AjxjA==
X-Received: by 2002:a1c:3c87:: with SMTP id j129mr463186wma.157.1588007676862;
        Mon, 27 Apr 2020 10:14:36 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
        by smtp.gmail.com with ESMTPSA id a20sm22975233wra.26.2020.04.27.10.14.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 10:14:35 -0700 (PDT)
Subject: Re: [PATCH] PCI: pcie-rcar: Mark rcar_pcie_resume() with
 __maybe_unused
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
References: <20200427164452.GA207715@google.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <491cbbce-eb43-8efe-565d-7f701c51b63d@gmail.com>
Date:   Mon, 27 Apr 2020 19:14:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200427164452.GA207715@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/27/20 6:44 PM, Bjorn Helgaas wrote:
> On Sun, Apr 26, 2020 at 02:31:15PM +0200, marek.vasut@gmail.com wrote:
>> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>>
>> If CONFIG_PM_SLEEP is not set, SET_SYSTEM_SLEEP_PM_OPS() is expanded to
>> empty macro and there is no reference to rcar_pcie_resume(), hence the
>> following warning is generated:
>>
>> drivers/pci/controller/pcie-rcar.c:1253:12: warning: ‘rcar_pcie_resume’ defined but not used [-Wunused-function]
>>  1253 | static int rcar_pcie_resume(struct device *dev)
>>       |            ^~~~~~~~~~~~~~~~
>>
>> Fix this by marking this function as __maybe_unused , just like in
>> commit 226e6b866d74 ("gpio: pch: Convert to dev_pm_ops")
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
>> Reported-by: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Wolfram Sang <wsa@the-dreams.de>
>> Cc: linux-renesas-soc@vger.kernel.org
>> ---
>> NOTE: Based on git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git
>>       branch pci/rcar
>> NOTE: The driver tag is now 'pcie-rcar' to distinguish it from pci-rcar-gen2.c
> 
> I hope Lorenzo will squash this into the original commit.  I don't
> think it adds anything useful to keep it as a separate commit.

Fine by me, that's also why I added these notes, so it's obvious it's
based off the same branch where the previous patch is already.
