Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54DF1B8FD8
	for <lists+linux-pci@lfdr.de>; Sun, 26 Apr 2020 14:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgDZMfN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Apr 2020 08:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725972AbgDZMfN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 26 Apr 2020 08:35:13 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A8CC09B04F;
        Sun, 26 Apr 2020 05:35:12 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u16so17123732wmc.5;
        Sun, 26 Apr 2020 05:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r/1f3M+JVC/phFS63/kW43hlg/9HsWl5FIPeyR9RvA8=;
        b=UO1L5dnILMREfAA+90uoaz9zGtBOR0FF90GzcFsoubi9JNSYELrz6pxxNX9zjLGR34
         sNt0g1YJyzBa+O36oFqctLNI8/DQjDcijip+Krrtle6LYeyH8D/tqRnmyxrqgfB0WUvm
         hYECbsf33MHCIgPQEa0Vk9cT2gCZcXfnn1yn/hGV+krnDSmf1aBW7hGCkFkSKpl66J/U
         RMD7x669Cq4bI6ZNaM3GqV1lrbHVs84ZTsFp8VGWXRpe4MQZyv5i53m0mrnRnDyzD4JU
         k0VDrDGZAGh7v2D8tbZ+sPnZ4hPp5b4vEdJAiXwoSwSD2wUxJ1PswGIYrnpqDRNRfMjT
         tLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r/1f3M+JVC/phFS63/kW43hlg/9HsWl5FIPeyR9RvA8=;
        b=b6mbCglZVSpem1DmIUiLFSjBFSHOISqgF9JLhAQ+cfV9PmMXhXuId5rLB6XgCJKvlG
         jUHApv+mDDjx8c2tYlVv2ZoXx7sJll2Ue6phV170MEb3QfRVU69whD+RRS331KAoFAtc
         uTOTit58pU0OjQm0kuvOdV4vgKoLNNtymtI+3vCpoi9PuBVbHUKF+YplwMTWLiVwdGux
         QPjku6AOeQOIjH0flJPbOHbQ2axqGWsJpp9VmLceORCUF7RBiA+ZMsrfEbSrpgQJcEQt
         kQYgsSU4gXuf1LHxTLnzJueEGTMIk7J+Rs/xe04sojsPhbkpUtYKnLRAak3Zs341tCrJ
         LKyg==
X-Gm-Message-State: AGi0Puad804CWYT79wD4j94l2zDdFV6S+QX5SzS0GTX3VBZq12ZFDRIT
        Vg3TNSI1IXbg3blnDFlMYq8=
X-Google-Smtp-Source: APiQypL5FycUSP4+/zrHH/tIA5mujCFBqdgrZmBm5f8YyNjsjJOoIVDm5rlwzhecQAZ0pMIJ96xnDg==
X-Received: by 2002:a1c:9d84:: with SMTP id g126mr19481463wme.184.1587904511456;
        Sun, 26 Apr 2020 05:35:11 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
        by smtp.gmail.com with ESMTPSA id a187sm11245718wmh.40.2020.04.26.05.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Apr 2020 05:35:10 -0700 (PDT)
Subject: Re: [PATCH V3] PCI: rcar: Add the suspend/resume for pcie-rcar driver
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>,
        Gaku Inami <gaku.inami.xw@bp.renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>
References: <20200424195724.GA187563@google.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <00f200a9-ab61-a04f-a16c-09a2b0343d3f@gmail.com>
Date:   Sun, 26 Apr 2020 14:32:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200424195724.GA187563@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/24/20 9:57 PM, Bjorn Helgaas wrote:
Hi,

[...]

>> @@ -1234,6 +1295,7 @@ static int rcar_pcie_resume_noirq(struct device *dev)
>>  }
>>  
>>  static const struct dev_pm_ops rcar_pcie_pm_ops = {
>> +	SET_SYSTEM_SLEEP_PM_OPS(NULL, rcar_pcie_resume)
> 
> This causes the following warning when CONFIG_PM_SLEEP is not set:
> 
>   drivers/pci/controller/pcie-rcar.c:1253:12: warning: ‘rcar_pcie_resume’ defined but not used [-Wunused-function]
>    1253 | static int rcar_pcie_resume(struct device *dev)
> 	|            ^~~~~~~~~~~~~~~~
> 
> Most people seem to be using __maybe_unused on the suspend/resume
> functions to avoid this, e.g., 226e6b866d74 ("gpio: pch: Convert to
> dev_pm_ops").

Should be fixed by:
PCI: pcie-rcar: Mark rcar_pcie_resume() with __maybe_unused
