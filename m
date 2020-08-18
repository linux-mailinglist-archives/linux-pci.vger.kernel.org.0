Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6CD52480CA
	for <lists+linux-pci@lfdr.de>; Tue, 18 Aug 2020 10:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgHRIiu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Aug 2020 04:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgHRIit (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Aug 2020 04:38:49 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9B1C061389;
        Tue, 18 Aug 2020 01:38:48 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id v15so9774073lfg.6;
        Tue, 18 Aug 2020 01:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J7oqilRaCWkcUcCiNiMj9W8gLZogWy/s5ah2zxk7zwk=;
        b=W1ohRVuEeAaXk2NQ9OdbNtoJsED/Qu+h3j6eGKAnN7TBz43RNxZYjqshcyviWZx3A2
         ZCe7HcP6iPYo6IoXGgQs190DWFvQfuNjqUc0KwB8jH4SAQ25ZJFwCB3l5fKqtDNd3cXY
         PnbZICRMvcHOcfFDa5ptxClE9ZAQC7gPBGZ/SnJVtuwOFo2ryOX8aC1T5vQ3WKHYBAb7
         Ubhb5GLsVKTGNqTArUpAtsVPm8SVtH5PC0RUIRJKOXRDouLRn/by0TqetayE22iKkv2x
         vwAwaiYCdhpQJIPbSXYvs+lSDGRKBNPD4voE5TYB9jko9Fh2YfrjzbQMzKCbxDXSIT2y
         unOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=J7oqilRaCWkcUcCiNiMj9W8gLZogWy/s5ah2zxk7zwk=;
        b=dHZnlFYGkQsDJEwnprRq1dKPA6GjErjKX9hRzsBjrVu6mqSSIhwRPgzgTE5igU+WZZ
         LJwX5b6WQwSlNCI4oUmTpg2eQIhx3qM7Jt9NF+6wZ8pJn1oK1hMS+2/bBC2/1n6i1oOz
         mRQduXlQZO194kqyEvkRIMP5hYg1FCUwrmQLD9cDCnC0GcxH37hqPj88+eFJQd76yGyS
         pZscmbaISVv10/EH9N0FBemhwTTm4MDDAo/w4yPApU5XY6hmrMp57kfSVOcmFUFFVos0
         VVJdctEa1N5GsGrRW2SyfCK7kLhQaRYCx5wJ3s3FZvO2PgGhufG5Vi/kZhiFLF1xtx3i
         FRrQ==
X-Gm-Message-State: AOAM5336eHqAEJIJ/6rsZJl2Pkxww7saXxBtitsLkJ+4X05p29YrjERc
        GvdLHV2LfTPTa+dRSh1DWZE=
X-Google-Smtp-Source: ABdhPJzwh9cvnyXMlQ9aVChtvQE/S56hEzNVjlvJkgr4HNPTEPiCbRVt5p7/P+6YwGw3tJQx+RutcA==
X-Received: by 2002:a19:4f5d:: with SMTP id a29mr9250904lfk.107.1597739927222;
        Tue, 18 Aug 2020 01:38:47 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:817:636:4100:222f:a00:15ca? ([2a00:1fa0:817:636:4100:222f:a00:15ca])
        by smtp.gmail.com with ESMTPSA id u14sm1455083ljg.55.2020.08.18.01.38.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 01:38:46 -0700 (PDT)
Subject: Re: [PATCH 3/5] arm64: dts: renesas: r8a774a1: Add PCIe EP nodes
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20200814173037.17822-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200814173037.17822-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <fcabccab-54fb-8b8a-7034-9b0da9d32339@gmail.com>
 <CA+V-a8v74fkzE8SYaaA5Wg=NT_mdgjNLTd0nha=UbHEC0pw0UA@mail.gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <de262150-96f1-dcf6-405c-db91c1daf0ec@gmail.com>
Date:   Tue, 18 Aug 2020 11:38:40 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CA+V-a8v74fkzE8SYaaA5Wg=NT_mdgjNLTd0nha=UbHEC0pw0UA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 18.08.2020 10:23, Lad, Prabhakar wrote:

[...]
>>> Add PCIe EP nodes to R8A774A1 (RZ/G2M) SoC dtsi.
>>>
>>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
>>> ---
>>>    arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 38 +++++++++++++++++++++++
>>>    1 file changed, 38 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
>>> index a603d947970e..50e9ed16a36d 100644
>>> --- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
>>> +++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
>>> @@ -2369,6 +2369,44 @@
>>>                        status = "disabled";
>>>                };
>>>
>>> +             pciec0_ep: pcie_ep@fe000000 {
>>
>>      Hyphens are preferred over underscores in the node/prop names.
>>
>> [...]
>> +                pciec1_ep: pcie_ep@ee800000 {
>>
>>      Ditto, should be "pci-ep@ee800000".
>>
> My bad will fix that in v2.

    Sorry, I meant to type "pcie-ep@ee800000".

> Cheers,
> Prabhakar

MBR, Sergei
