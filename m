Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA629073A
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2019 19:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfHPRu5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Aug 2019 13:50:57 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40779 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfHPRu5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Aug 2019 13:50:57 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so4731914wmj.5;
        Fri, 16 Aug 2019 10:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=99lef+DzaRhB266B6Q8i3mJwjk2AgTNvFX1QM/K3Qmo=;
        b=PA7qHHmFNBCjoRVp58eSr0IeYw1LMldUTpadMinomLmHtFAMzbyHCC9NYe19lZQ+Kc
         CYR/nCaj+TSqQpLEgNh4WcEe8X75Lyoh9vfJZBmuY8z5zKHBkxUTHGec2GZO5JbX7T9+
         O46FXnOr/Q29XFBwkSkqTv7SfvwN3LMtu1WWx2B+uBL06M96AbDXxad1RQ3W09WhOybT
         uTX4uVW2nG5DNiUZVdU2+C6RDAq/VBofe2mdA55y31io42d3+u+8v5LwqyYuT80C2rso
         ow+XwQlGvi851SEvBEBzr76t1QjmRzW7J5ic4y7i8XJcy0GA1gAptZiFeSwgHr3FLIab
         78BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=99lef+DzaRhB266B6Q8i3mJwjk2AgTNvFX1QM/K3Qmo=;
        b=lon5YDOP+di6PQ8AqqbvhAN/k0Db+1AHoFuy0GXnGy2cthwXhzAT61whK80h9m/Cxt
         DoWLrH/SqgPZfqW8QTbWvPpya9ucr0drZj6aAqdts24iR4hTBMSzmP6192bPUmBirdxp
         EkCLACog0f42WP/Yvq9o4w4qnAA5h5QevBa2Z2QTebIZpB2AufFMiAkuZkEmy1rrQVti
         VWR7MjOZTaMNrWUPF9pQx4DxvlwnprwbRRUPo7XNhKYtt7SPY37KcT7Q/x7peWIayiF9
         NFcw3veh7fVTP6w0xhLBv1hBpNdMqbvqouZLnmAhyWBkmtCXCLIwmEZ5ucBetGGX5X1v
         gtGA==
X-Gm-Message-State: APjAAAWlWcLOHFH31OoHV1BgBDhBqQ6DMZ3DoOdAqEbX1OWGgikRbVq1
        wfARtZMwSPHXrAnnVWZbzqMIO8WIc2s=
X-Google-Smtp-Source: APXvYqzzr6VfL7xPvlvZDDbgeKXVFZ/DRRP8Igf5H2BxJmSySB9Uea4nBdkxIyzs6rfFEln+O3lUww==
X-Received: by 2002:a05:600c:292:: with SMTP id 18mr8709997wmk.51.1565977381813;
        Fri, 16 Aug 2019 10:43:01 -0700 (PDT)
Received: from [192.168.42.150] (cst-prg-94-179.cust.vodafone.cz. [46.135.94.179])
        by smtp.gmail.com with ESMTPSA id r17sm15475691wrg.93.2019.08.16.10.43.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2019 10:43:01 -0700 (PDT)
From:   Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH V3 2/3] PCI: rcar: Do not abort on too many inbound
 dma-ranges
To:     Simon Horman <horms@verge.net.au>
Cc:     linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
References: <20190809175741.7066-1-marek.vasut@gmail.com>
 <20190809175741.7066-2-marek.vasut@gmail.com>
 <20190816132305.gyyml5r3xsimmoor@verge.net.au>
 <8f1871ed-4820-1985-0090-bb9e2d8803d8@gmail.com>
 <20190816133816.4l463artoaswknj2@verge.net.au>
Openpgp: preference=signencrypt
Message-ID: <e78c29b7-fe26-5fa6-3813-11a87ac811fa@gmail.com>
Date:   Fri, 16 Aug 2019 19:41:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816133816.4l463artoaswknj2@verge.net.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/16/19 3:38 PM, Simon Horman wrote:
> On Fri, Aug 16, 2019 at 03:28:04PM +0200, Marek Vasut wrote:
>> On 8/16/19 3:23 PM, Simon Horman wrote:
>>> On Fri, Aug 09, 2019 at 07:57:40PM +0200, marek.vasut@gmail.com wrote:
>>>> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>>>>
>>>> In case the "dma-ranges" DT property contains either too many ranges
>>>> or the range start address is unaligned in such a way that populating
>>>> the range into the controller requires multiple entries, a situation
>>>> may occur where all ranges cannot be loaded into the controller.
>>>>
>>>> Currently, the driver refuses to probe in such a situation. Relax this
>>>> behavior, load as many ranges as possible and warn if some ranges do
>>>> not fit anymore.
>>>
>>> What is the motivation for relaxing this?
>>
>> U-Boot can fill the ranges in properly now, the list would be longer in
>> such a case and the driver would fail to probe (because the list is
>> longer than what the hardware can support).
> 
> Thanks, I think that would be worth adding to the changelog.

It does describe exactly what I just said -- if there are too many
ranges or they start in a way that cannot be easily fully programmed
into the HW, this patch applies.

> Regardless,
> 
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> 


-- 
Best regards,
Marek Vasut
