Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC8758ABA8
	for <lists+linux-pci@lfdr.de>; Fri,  5 Aug 2022 15:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238247AbiHENbq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Aug 2022 09:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbiHENbo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Aug 2022 09:31:44 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972DB3ED65;
        Fri,  5 Aug 2022 06:31:43 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id y141so2267013pfb.7;
        Fri, 05 Aug 2022 06:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=fqcWmY1mBve1L/uK9Q+d74rl0xxAsTmgo1FtwEWwwi0=;
        b=SODgQsLFaA7548Zpjjv2VLPVl/UV/irb9dxu/w/+UjNZXjR1BeMD/bU4PhxF9c+LYZ
         1vdp8emXzb70f3ki8I3WdxH1vp6Go0YNphh2930b3OaaXAqwqHx/tvWLDEFQaFBvZawy
         TrUfn1vyWnpBHZT7qTCk4JOWF6y5ZAfBK2wEDMlYG5KKXmHpAzauLMj/wjAnR8rfS2XZ
         qT7sQ/NHML+jFqwHwMbAIcCCyxHJ2LLDrlzZcFTjM+W5VTu34UrKajSFohAH2M1Bt9/P
         CouzaEnd2CnpGoZ2VT6QzxsV6xWmF4IS7sWtJZBnPpChNwee00yrvt8VWGWGWLTmPpJ8
         47kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=fqcWmY1mBve1L/uK9Q+d74rl0xxAsTmgo1FtwEWwwi0=;
        b=V1TELQ0MGEVLYQD6xaDrEhVfmPcdkYzq30qIVMGAGRkftsQucLR7BOroHnsgRU96P3
         ZXCCJroeJuEP9iAXswVbeElQO9exHxIRXUdkJVDucozocb68u6wUV7f8LxG725P8y475
         C4siroiw3UVVUyU25HVMmSfqaLCjJJy4NXc8pDOY7E82s3103ySEwkCxwxKVFH6z1c9Y
         q3UR4Va5YgzwV0chjJIf8Kb3lgM+uMSxv8nUbiuuq1XhjQykNEijRmPTyGmlnMEaMv4M
         coIpTfLMCvPGSVLOyte62eJI6IyOlWC7uRRE5rC+i6yvotyDyKKwDbLZd5kJGCuTceLM
         WJKg==
X-Gm-Message-State: ACgBeo1SdiXLuFQzZFtYPmZn8ULxvUEsETT7su0n+AfqggTVGN4a+kuc
        Z7N2nMOtRZ8GTaSLjw74izA=
X-Google-Smtp-Source: AA6agR6KuhQSga1/p3WOwML8vH6DRegVLh9KAFWWEKI7bOc+i+Zc0lA261DTS0lb5MDl1Xf44fiPrg==
X-Received: by 2002:a05:6a00:2a7:b0:52d:7d79:b836 with SMTP id q7-20020a056a0002a700b0052d7d79b836mr7063001pfs.52.1659706302895;
        Fri, 05 Aug 2022 06:31:42 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-75.three.co.id. [180.214.232.75])
        by smtp.gmail.com with ESMTPSA id nn16-20020a17090b38d000b001efa35356besm5678374pjb.28.2022.08.05.06.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 06:31:42 -0700 (PDT)
Message-ID: <6556c478-976c-27f1-ad9b-606fe47f7ce1@gmail.com>
Date:   Fri, 5 Aug 2022 20:31:33 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3] PCI: update the links for aer-inject git tree
Content-Language: en-US
To:     Huang Shijie <shijie@os.amperecomputing.com>, bhelgaas@google.com
Cc:     patches@amperecomputing.com, zwang@amperecomputing.com,
        darren@os.amperecomputing.com, corbet@lwn.net,
        yangyicong@hisilicon.com, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220805105238.345599-1-shijie@os.amperecomputing.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220805105238.345599-1-shijie@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/5/22 17:52, Huang Shijie wrote:
> The aer-inject tree has been moved to:
>     https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git
> Update the links.
> 
> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
> ---
> v1 --> v2: Modified the commit message and the title.
> v2 --> v3: Change the commit message again.
> ---

The change log could have been before the diffstat below (so it won't be
displayed on git log when applied).

>  Documentation/PCI/pcieaer-howto.rst | 2 +-
>  drivers/pci/pcie/Kconfig            | 2 +-
>  drivers/pci/pcie/aer_inject.c       | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
> index 0b36b9ebfa4b..b31fc9a0edbc 100644
> --- a/Documentation/PCI/pcieaer-howto.rst
> +++ b/Documentation/PCI/pcieaer-howto.rst
> @@ -294,7 +294,7 @@ After reboot with new kernel or insert the module, a device file named
>  Then, you need a user space tool named aer-inject, which can be gotten
>  from:
>  
> -    https://git.kernel.org/cgit/linux/kernel/git/gong.chen/aer-inject.git/
> +    https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git/
>  
>  More information about aer-inject can be found in the document comes
>  with its source code.
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index 788ac8df3f9d..d6ea0fd9892d 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -43,7 +43,7 @@ config PCIEAER_INJECT
>  	  error injection can fake almost all kinds of errors with the
>  	  help of a user space helper tool aer-inject, which can be
>  	  gotten from:
> -	     https://git.kernel.org/cgit/linux/kernel/git/gong.chen/aer-inject.git/
> +            https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git/
>  
>  #
>  # PCI Express ECRC
> diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
> index 2dab275d252f..262b06b0dc1d 100644
> --- a/drivers/pci/pcie/aer_inject.c
> +++ b/drivers/pci/pcie/aer_inject.c
> @@ -6,7 +6,7 @@
>   * trigger various real hardware errors. Software based error
>   * injection can fake almost all kinds of errors with the help of a
>   * user space helper tool aer-inject, which can be gotten from:
> - *   https://git.kernel.org/cgit/linux/kernel/git/gong.chen/aer-inject.git/
> + *   https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git/
>   *
>   * Copyright 2009 Intel Corporation.
>   *     Huang Ying <ying.huang@intel.com>

Otherwise looks OK.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
