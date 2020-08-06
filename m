Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C9923E093
	for <lists+linux-pci@lfdr.de>; Thu,  6 Aug 2020 20:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgHFSf5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Aug 2020 14:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728343AbgHFSfB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Aug 2020 14:35:01 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCE1C06138F;
        Thu,  6 Aug 2020 11:34:57 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id p4so2080033qkf.0;
        Thu, 06 Aug 2020 11:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jh0v02DkXyhJNo8LA2UuLAWMIN4MTJgsh7QSpkB1WKs=;
        b=L1qlYIcRDMj1ceJI2uQgrQwsnjtjYJ51ExbWDz/tiNfSzsuy/hrwPAggThbRufcFHd
         xAUBElaV8anZXCZmOBu0Diqltb83t16L3ApkuxYqWmeR5IbqEe12i8A+L40PBNcAPTJz
         kVpchS10zcicFSM5J27FSrAvyEUMfQD8hsDwRB9IlQEBM7Cst+nTxjDFVPzs+yxT2t1g
         uAbmZvyCmHJ3t3i4L9RUXHe5TbOJ+snI54ukiSsYbRhpbSxsCOVM5oddzYLBroSF0hp2
         Jd9oOXL6GMbEuuTfoIfydIJb1NjfO1yjtREM9K20xRi2EPznJudFJdK8fHhGrrNB3OS1
         zQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jh0v02DkXyhJNo8LA2UuLAWMIN4MTJgsh7QSpkB1WKs=;
        b=LlSoZOe8b2DT7ZoNaDZz6Tu8XNp8ARZyKTs1Irwc7wMKNfSBhugjtwxZlxBgCrwkBT
         BSusbXC6R0Fqg3h/gbGGw2JQiukfODTi9f+Th/BqNIplv8fM62A8t/Td4VQQ6UOKz/ZI
         kutb0AX4vsrgmSxFx4tjjdFqFCZ5Gvd3WgF1ZLcaFN6CdNUK0BoA8xQCEChXrpkMHzwE
         f/HSxi6wgPxcnsNGVnk0x3LrCdAs6WOPcwFCp6g71CgAAS2LAlCpNFx365jgU4eXG/g0
         hoLATNZ36NqQj2eIOBbINMPTQk8j10IY73y0PwmSIm1XB9gmarJ0smgwTDyroUAAaRY8
         6m1Q==
X-Gm-Message-State: AOAM530Faiw7f9JzryWNQTXx/HFllrqV4U/PhTVNATasM/1drEiwzX/4
        UM6NoVJHUJXerM5Rc7rrDkdhTbpm
X-Google-Smtp-Source: ABdhPJz9X8ObvlU7tzbg/LByZlX8nQ9cuidDXjutIiX7L1sw0jslIXMUDCaMiRqUwD52wDtQ1Uj0DQ==
X-Received: by 2002:a05:620a:889:: with SMTP id b9mr9927270qka.7.1596738896605;
        Thu, 06 Aug 2020 11:34:56 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id g129sm4857815qkb.39.2020.08.06.11.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 11:34:55 -0700 (PDT)
Subject: Re: [PATCH v4] PCI: Reduce warnings on possible RW1C corruption
To:     Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>,
        ray.jui@broadcom.com, helgaas@kernel.org, sbranden@broadcom.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200806041455.11070-1-mark.tomlinson@alliedtelesis.co.nz>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <99c090fb-125c-42b7-1ea3-6840dcfada37@gmail.com>
Date:   Thu, 6 Aug 2020 11:34:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806041455.11070-1-mark.tomlinson@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/5/2020 9:14 PM, Mark Tomlinson wrote:
> For hardware that only supports 32-bit writes to PCI there is the
> possibility of clearing RW1C (write-one-to-clear) bits. A rate-limited
> messages was introduced by fb2659230120, but rate-limiting is not the
> best choice here. Some devices may not show the warnings they should if
> another device has just produced a bunch of warnings. Also, the number
> of messages can be a nuisance on devices which are otherwise working
> fine.
> 
> This patch changes the ratelimit to a single warning per bus. This
> ensures no bus is 'starved' of emitting a warning and also that there
> isn't a continuous stream of warnings. It would be preferable to have a
> warning per device, but the pci_dev structure is not available here, and
> a lookup from devfn would be far too slow.
> 
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Fixes: fb2659230120 ("PCI: Warn on possible RW1C corruption for sub-32 bit config writes")
> Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
