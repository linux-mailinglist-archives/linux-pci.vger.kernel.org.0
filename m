Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1D376533A
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jul 2023 14:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbjG0MHa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jul 2023 08:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbjG0MH1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Jul 2023 08:07:27 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6838E2D5B;
        Thu, 27 Jul 2023 05:07:26 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-63d09d886a6so6129346d6.2;
        Thu, 27 Jul 2023 05:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690459645; x=1691064445;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnC0KU6XOkUWTwawkrEv0U18JS8bB3ff8im2fzrjaTg=;
        b=N8/DkxFz3tL5pYXLLkY1KuGFeRL2dDwg5psU2g9TGEjlsWJzNLXPSqA+cGCUapdpYt
         EMVefpdRE+jPiFfst4Xuksyv8bCdjlvLDHw3/C1a01/OwcGuhr5YbJQiSoWoUY/5OPwI
         zoumO8ZuEqe1jEyhzjpKgIiTX/ro27lYOvlZjEI+KOoqhgGGpYLjHhYC+pDkYTrQfpga
         NUDJQYPFa50O4TMvfGE2JVwkfwVuFjSK3SSbTNYmqqVBiqvTTC8VFYT/8FTFFJh+Ew1N
         V5jPTP6usybJnNo4c+tD1562guFKg6yXp8BifJ3cVoiBIyI5CtDvTrIJBuTtHp13Eo61
         VW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690459645; x=1691064445;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dnC0KU6XOkUWTwawkrEv0U18JS8bB3ff8im2fzrjaTg=;
        b=E7D5kDJnDnk79mQuCCKYlmje1mISjaSxTALAImvBjnaBL6Ytwk8Ds4xVhFeYZB31SD
         U+csuLV0OnDmED0x/eQ1Kj6BnhZwHzvHicVJSBqTPwJUNutF0xUQCA3X5aV5Mzh0uq0u
         YM9oH7X4Waf2cNfdmDqHmVzviLtx1nWJpvSPcwtLqz9xAQdfQtZDwNbY1hVzH1WEivDf
         Z/Rb7PuQL8V/a2xMXlXgxEy78CfIBauCji/YLa2+FTJ6pOdbCrNbTJ3ZAIBraxloyLhj
         On7brhsveHjowvaCN4NUl5U4vRKXI8Ee3AaqWOQ2AhOF5m1TNqHkF78gl/Ivs1bSsJAB
         HzWw==
X-Gm-Message-State: ABy/qLZw2WQOyk6rhfybUoO7eIO/6565Pvl35x4iTddsWs3HpRerxhFt
        LglQrS360OCVa+pAS4ll6A==
X-Google-Smtp-Source: APBJJlHthRuDqnjjwC1LhWRkktbaKrqCADZc1Mik4EmIab/UuoDusOrZDQ2LA55xv3Ob+BYoXRkKPg==
X-Received: by 2002:a0c:c541:0:b0:628:2e08:78b7 with SMTP id y1-20020a0cc541000000b006282e0878b7mr4832675qvi.31.1690459645131;
        Thu, 27 Jul 2023 05:07:25 -0700 (PDT)
Received: from [120.7.1.38] (198-84-239-141.cpe.teksavvy.com. [198.84.239.141])
        by smtp.gmail.com with ESMTPSA id p7-20020a0ce187000000b0063d0159e1f6sm365781qvl.109.2023.07.27.05.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 05:07:24 -0700 (PDT)
Subject: Re: Kernel 6.5-rc2: system crash on suspend bisected
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     imammedo@redhat.com, bhelgaas@google.com,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        regressions@lists.linux.dev,
        "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>,
        Woody Suwalski <terraluna977@gmail.com>
References: <11fc981c-af49-ce64-6b43-3e282728bd1a@gmail.com>
 <20230720202110.GA544761@bhelgaas>
 <20230727020621-mutt-send-email-mst@kernel.org>
From:   Woody Suwalski <terraluna977@gmail.com>
Message-ID: <1d51d250-9524-33c5-9b3a-af8c33582eee@gmail.com>
Date:   Thu, 27 Jul 2023 08:07:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:91.0) Gecko/20100101 Firefox/91.0
 SeaMonkey/2.53.16
MIME-Version: 1.0
In-Reply-To: <20230727020621-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Michael S. Tsirkin wrote:
> On Thu, Jul 20, 2023 at 03:21:10PM -0500, Bjorn Helgaas wrote:
>> [+cc regressions list]
>>
>> On Wed, Jul 19, 2023 at 11:36:51PM -0400, Woody Suwalski wrote:
>>> Laptop shows a kernel crash trace after a first suspend to ram, on a second
>>> attempt to suspend it becomes frozen solid. This is 100% repeatable with a
>>> 6.5-rc2 kernel, not happening with a 6.4 kernel - see the attached dmesg
>>> output.
>>>
>>> I have bisected the kernel uilds and it points to :
>>> [40613da52b13fb21c5566f10b287e0ca8c12c4e9] PCI: acpiphp: Reassign resources
>>> on bridge if necessary
>>>
>>> Reversing this patch seems to fix the kernel crash problem on my laptop.
>> Thank you very much for all your work debugging, bisecting, and
>> reporting this!  This is incredibly helpful.
>>
>> Original report, including complete dmesg logs for both v6.4 and
>> v6.5-rc2:
>> https://lore.kernel.org/r/11fc981c-af49-ce64-6b43-3e282728bd1a@gmail.com
>>
>> I queued up a revert of 40613da52b13 ("PCI: acpiphp: Reassign
>> resources on bridge if necessary") (on my for-linus branch for v6.5).
>>
>> It looks like a NULL pointer dereference; hopefully the fix is obvious
>> and I can drop the revert and replace it with the fix.
>>
>> Bjorn
> Patch on list now:
> https://lore.kernel.org/all/20230726123518.2361181-1-imammedo%40redhat.com
Confirm works OK.
--
Tested-by: Woody Suwalski <terraluna977@gmail.com>
--

Thanks, Woody

