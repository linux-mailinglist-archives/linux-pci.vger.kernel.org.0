Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22AA1466D4A
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 23:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbhLBW47 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 17:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbhLBW44 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Dec 2021 17:56:56 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA6AC06174A;
        Thu,  2 Dec 2021 14:53:34 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so3673896pjc.4;
        Thu, 02 Dec 2021 14:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GOuMIQHZ6ZbFY/aDEI/F7vdwlKHdquEP2d6O5QmO4Z4=;
        b=DpP1aNTNhzUyoMO15ULD7LcqNp6QDZ5a44ujOths0vpPQWLQ/KSpsEtMK/cLPXC8Pw
         ve2h4KN3BAmOfoH31++AdFSBbAP1U0F7QY4XjPmUkYx6sahCT8V60inUek1eaIsQ1ov4
         J1r8sTm8PZwK1EJFGWU/oeW8u+iUfKUvSglb2KSR6Bnd6KFSY1Q3nOc2Wfj48NC9QfM2
         6agfdkcsmt3AyzLx7fY7HDfY8XF+ZPHyXS/2UUtAWoWIYMUNU9j0sAe1Xo6blcjUTO5u
         kba9l05MRyMMGqFrASMQx7+Ee9LVgE5cNtV8GBqY0JcaVvOsVBunrC5m2v7sYYCAFEAs
         xsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GOuMIQHZ6ZbFY/aDEI/F7vdwlKHdquEP2d6O5QmO4Z4=;
        b=p+Y+JRCjkKVU51OHui/tBoTixJGXvXHjuVDT9CXSRwINh3dG75+Zm0mXNmrt+WmLs1
         oRAWXiBc78hnjVrFs5grgHY2adpXgXfAV8zJ0qmIIGaFVxS1aZK8QoaVFHd2EzBGf6n2
         TMqXI2JwdyPLzgvztPGlcgFvH7vy5NkGxOCwWfPUdfE2mHM+n3y8wj6SvkNhCy7PBJ6l
         4QWpfe5b7tj8geBNABFq6FYY8zR+uw75GsTljIkafGz3bZwLHo8ExRHkjtUqdhzeYJE5
         X/UlVKshPv6VbzLIkjGgfDRk2ujQlgw1id9YJnmLGX17kSBuA44XglC0OAAbXkuOwBtB
         9ejw==
X-Gm-Message-State: AOAM530DYYUGqpwMxyYNtzmMfybOioC1EaMX/YjR1nXTcbhjQjBiwJf8
        yEgrA3z08fS4KfzSlal7luKYdkRLcew=
X-Google-Smtp-Source: ABdhPJxs0UAlZEUMLhYkinbXBZEpkqNHoJkLj1iOYpaYj1/QcZ8+cMmp/6BHI438GIRyht0oVXfn8Q==
X-Received: by 2002:a17:90b:4a05:: with SMTP id kk5mr9360528pjb.232.1638485613293;
        Thu, 02 Dec 2021 14:53:33 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id x6sm553906pga.14.2021.12.02.14.53.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 14:53:32 -0800 (PST)
Subject: Re: [PATCH] dt-bindings: PCI: brcmstb: compatible is required
To:     Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:BROADCOM STB PCIE DRIVER" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20211202223609.1171452-1-f.fainelli@gmail.com>
 <CAL_JsqLR=TeKFj1DO-UDcFDcuuw9VUzy9tdxmdK797ywX+fN8g@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <a72e7ef1-5630-8b9f-a6a3-bc66fe447be3@gmail.com>
Date:   Thu, 2 Dec 2021 14:53:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLR=TeKFj1DO-UDcFDcuuw9VUzy9tdxmdK797ywX+fN8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/2/21 2:41 PM, Rob Herring wrote:
> On Thu, Dec 2, 2021 at 4:36 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>> The compatible property is required, make sure the binding documents it
>> as such.
> 
> Yes, though if 'compatible' is not present and matching, the schema is
> never applied. I'll apply it later, but I wouldn't be too concerned
> fixing any others.

OK, just happened to run into that one by accident while converting the
iProc PCIe binding to YAML.
-- 
Florian
