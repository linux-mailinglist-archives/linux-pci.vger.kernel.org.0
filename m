Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98FFDF22F6
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 00:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfKFX7b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Nov 2019 18:59:31 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33910 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbfKFX7a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Nov 2019 18:59:30 -0500
Received: by mail-wm1-f68.google.com with SMTP id v3so3513360wmh.1;
        Wed, 06 Nov 2019 15:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pYc1ZEuv8q0KG5E79mea0IAenws1iMJ4L6QA4R1lfVY=;
        b=kvK67h3fYcWBmNBhk+w65SIcEgm9PvCe2zJ3e1TJO+o52SeF8hx8GgnX1DBB/LT2SD
         j0Z5CqFHdmnXMj5sx0Tu5/dZpVKiSAMIWMl+3HsoVyrmmeFi09faiDu8OEM63Dzozlkn
         YNN1jnyWillG0L2GjgMQN3zd8oyqjkijdV+fNQia7msX8wxRR+6jMUIyyM0xzweHLG+J
         g7T1fy/i5yTLBGgg2zxLBYqJ6Ym6HUryLgrSEfB/jNuAP0/pJbIfLG4VRKffyNGYYa5Z
         TBSFPEK6Xd4fwELoaG/HOLCIPvnPyAF4ee/0rBJ7m3/dpeTVZbrQ0wH9JIZDW47VDuHJ
         SiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pYc1ZEuv8q0KG5E79mea0IAenws1iMJ4L6QA4R1lfVY=;
        b=E5fLs5myd++UfXnbcJ8E0E8z8Zl1JUwWBGSU0/GclSlvK6IhVX6hNt7BKaasGRrMQJ
         tQW929DNbTfnASTAGtsGBhdQ8aeDX2HzFyBMDPMoZPGnE/o8S9P+ksvlbt0O5CWyEKTg
         LZGKzlKIIIWR8fBqL09EsVZI5RzoOloGBhLNENBeQR8WbF2zC0fTWp05LH9Kd3dFP6dv
         bxCd05iSbuq55iILcbqVD/MR6js2i+jllzll7dwFWqLxSHW9VAOYb423pJanEFwbnEpd
         RdT1FmYPEgDytOCznuk9VtwlQtAfjx1VSSQtQnXneQIOlyUVy2IiZtuZfHJhyeC6jSqB
         Raog==
X-Gm-Message-State: APjAAAU0LrnWCNrCRhruyJA8uIuxidY5BI0efrZQc+T/5hLegm5yB9wS
        AKhfC2PSqlsTqy2enksiwGQ=
X-Google-Smtp-Source: APXvYqz4a4H5Uoy7rSYdGlqvNJE0lcHmzcfZs1JsT4P7wLXGRdWcJdrlLQZT3eQTWfwnQcTYVH7EJw==
X-Received: by 2002:a1c:2dd0:: with SMTP id t199mr181746wmt.58.1573084768367;
        Wed, 06 Nov 2019 15:59:28 -0800 (PST)
Received: from [192.168.1.4] (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
        by smtp.gmail.com with ESMTPSA id d11sm423476wrf.80.2019.11.06.15.59.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2019 15:59:27 -0800 (PST)
Subject: Re: [PATCH V3 2/3] PCI: rcar: Do not abort on too many inbound
 dma-ranges
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Simon Horman <horms@verge.net.au>, linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org, Robin.Murphy@arm.com
References: <20190809175741.7066-1-marek.vasut@gmail.com>
 <20190809175741.7066-2-marek.vasut@gmail.com>
 <20190816132305.gyyml5r3xsimmoor@verge.net.au>
 <8f1871ed-4820-1985-0090-bb9e2d8803d8@gmail.com>
 <20191021101805.GM47056@e119886-lin.cambridge.arm.com>
 <fef9502f-d51c-b922-afb3-8891267ae6c3@gmail.com>
 <20191026203627.GA47056@e119886-lin.cambridge.arm.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <9c46a2d2-00bd-3854-8060-fc7389751f3f@gmail.com>
Date:   Thu, 7 Nov 2019 00:37:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191026203627.GA47056@e119886-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/26/19 10:36 PM, Andrew Murray wrote:
[...]>> But this still leaves me with one open question -- how do I
figure out
>> what to program into the PCI controller inbound windows, so that the
>> controller correctly filters inbound transfers which are targetting
>> nonexisting memory ?
> 
> Your driver should program into the RC->CPU windows, the exact ranges
> described in the dma-ranges. Whilst also respecting the alignment and
> max-size rules your controller has (e.g. the existing upstream logic
> and also the new logic that recalculates the alignment per entry).
> 
> As far as I can tell from looking at your U-Boot patch, I think I'd expect
> a single dma-range to be presented in the DT, that describes
> 0:0xFFFFFFFF => 0:0xFFFFFFFF. This is because 1) I understand your
> controller is limited to 32 bits. And 2) there is a linear mapping between
> PCI and CPU addresses (given that the second and third arguments on
> pci_set_region are both the same).
> 
> As you point out, this range includes lots of things that you don't
> want the RC to touch - such as non-existent memory. This is OK, when
> Linux programs addresses into the various EP's for them to DMA to host
> memory, it uses its own logic to select addresses that are in RAM, the
> purpose of the dma-range is to describe what the CPU RAM address looks
> like from the perspective of the RC (for example if the RC was wired
> with an offset such that made memory writes from the RC made to
> 0x00000000 end up on the system map at 0x80000000, we need to tell Linux
> about this offset. Otherwise when a EP device driver programs a DMA
> address of a RAM buffer at 0x90000000, it'll end up targetting
> 0x110000000. Thankfully our dma-range will tell Linux to apply an offset
> such that the actual address written to the EP is 0x10000000.).

I understand that Linux programs the endpoints correctly. However this
still doesn't prevent the endpoint from being broken and from sending a
transaction to that non-existent memory. The PCI controller can prevent
that and in an automotive SoC, I would very much like the PCI controller
to do just that, rather than hope that the endpoint would always work.

> In your case the dma-range also serves to describe a limit to the range
> of addresses we can reach.

[...]

-- 
Best regards,
Marek Vasut
