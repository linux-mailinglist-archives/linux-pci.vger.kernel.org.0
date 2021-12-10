Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFDF470BDC
	for <lists+linux-pci@lfdr.de>; Fri, 10 Dec 2021 21:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344208AbhLJUex (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Dec 2021 15:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344211AbhLJUew (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Dec 2021 15:34:52 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37E9C0617A1;
        Fri, 10 Dec 2021 12:31:16 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id k4so7003371plx.8;
        Fri, 10 Dec 2021 12:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jw1R+y/hcHxw2PT0p++dPCEF0COGjgzOAfMrHqXYnmM=;
        b=Bj+eXpOd8SzmrJr7YedQ/prWz5Nhb/UwYzn4LYbYC36INmkJgXTghx2tdmOgL51KpZ
         /NMu5KRvGw6V/m3A81JqHlgtdx0VwVYcS1qmRcwsxnxxQ1mctQXAHoAIGvp5cplvrgLu
         oGsDF+VTRyiY7OIaz/t2SwS32w4Ab/92XtjcZ8UgvbUQIUjp9d2JJa0h1oQDDpVg0SnS
         5WcE6IcGXwGx3JcCw4uuBDKQoJ1FDnoNeYvK1/D7i5mp3wCbZIMdFTM5JrZCkKMJWavw
         v6Ig7kgp4cQxi9sQs4wAAf/gEPRhgqNdInYf9Hw6F6bEGgAPnNV8KBREpolxKgqZe2gv
         8E/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jw1R+y/hcHxw2PT0p++dPCEF0COGjgzOAfMrHqXYnmM=;
        b=HTCoyHaNSrnNgV4VO0+qe6bJynT+0tRFwgSTmb+C6NRHUKPsj6uI0O6mSzekUOpHhf
         wGoj001YXmOtQorFnJuazZMZGMIj+3w7xNrxnmbC9KQjgGzBprYl5hARqTPsUN01hU/R
         iPCTMpHj1ahx32jYRMNmcMtR/t0i6eTxB4XyblKQYhvA8WLbrrI3jROrZ4Rf558NT5TR
         IVNniGg5yac51DL1pmdWQPMA6PM2VMb8qfwPr3UneyVPqyQfmeI/+ONQ3XyEQCj7qk+t
         7umirB8Ap9BRRVNjUKDWRn5sEn7FOzU9TX4AX5ksUsP0Pv7QHsJNdeo6qBrl0Sss84gh
         3yHw==
X-Gm-Message-State: AOAM531k3nSqmID+DUYV/K2NWUF9JsZvcWQVQEoZGsM5/dTTIHhgWHBd
        doLKZk43kHunWRp2KpqMkkM=
X-Google-Smtp-Source: ABdhPJxTn8cdjm0nDrmj3G2/X5TV7UORnvYHQW3Jxaa+vjIKePL9ujp9yEQXIZ3Pnlrd8hZuQYmxdw==
X-Received: by 2002:a17:90b:1e07:: with SMTP id pg7mr26302078pjb.185.1639168276271;
        Fri, 10 Dec 2021 12:31:16 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id s19sm4434823pfu.137.2021.12.10.12.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 12:31:15 -0800 (PST)
Subject: Re: [PATCH v10 0/7] PCI: brcmstb: root port turns on sub-device power
To:     Rob Herring <robh@kernel.org>, Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Saenz Julienne <nsaenzjulienne@suse.de>
References: <20211209211407.8102-1-jim2101024@gmail.com>
 <YbOf836C58fUSmCO@robh.at.kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <d659ec6c-ddf8-87b9-ebf1-b32c3730d038@gmail.com>
Date:   Fri, 10 Dec 2021 12:31:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YbOf836C58fUSmCO@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/10/21 10:44 AM, Rob Herring wrote:
> On Thu, Dec 09, 2021 at 04:13:58PM -0500, Jim Quinlan wrote:
>> v10 -- Bindings commit example: in comment, refer to bridge under
>>        controller node as a root port. (Pali)
>>     -- Bindings commit example: remove three properties that are not
>>        appropriate for a PCIe endpoint node. (Rob)
>>
>> v9  -- Simplify where this mechanism works: instead of looking for
>>        regulators below every bridge, just look for them at the
>>        bridge under the root bus (root port).  Now there is no
>>        modification of portdrv_{pci,core}.c in this submission.
>>     -- Although Pali is working on support for probing native
>>        PCIe controller drivers, this work may take some time to
>>        implement and it still might not be able to accomodate
>>        our driver's requirements (e.g. vreg suspend/resume control).
>>     -- Move regulator suspend/resume control to Brcm RC driver.  It
>>        must reside there because (a) in order to know when to
>>        initiate linkup during resume and (b) to turn on the
>>        regulators before any config-space accesses occur.
> 
> You now have a mixture of 'generic' add/remove_bus hooks and the host 
> controller suspend/resume managing the regulators. I think long term, 
> the portdrv is going to be the right place for all of this with some 
> interface defined for link control. So I think this solution moves 
> sideways rather than towards anything common.
> 
> Unfortunately, the only leverage maintainers have to get folks to care 
> about any refactoring is to reject features. We're lucky to find anyone 
> to test refactoring when posted if done independently. There's a long 
> list of commits of PCI hosts that I've broken to prove that. So it's 
> up to Lorenzo and Bjorn on what they want to do here.

After version 10, it would seem pretty clear that we are still very much
committed to and interested in getting that set merged and do it the
most acceptable way possible. Common code with a single user is always a
little bit of a grey area to me as it tends to be developed to cater for
the specific needs of that single user, so the entire common aspect is
debatable. I suppose as long as we have the binding right, the code can
change at will.

Not trying to coerce Bjorn and Lorenzo into accepting these patches if
they don't feel comfortable, but what about getting it included so we
can sort of move on from that topic for a little bit (as we have other
PCIe changes coming in, supporting additional chips etc.) and we work
with Pali on a common solution and ensure it works on our pcie-brcmstb.c
based devices? We are not going to vanish and not come back looking at this.
-- 
Florian
