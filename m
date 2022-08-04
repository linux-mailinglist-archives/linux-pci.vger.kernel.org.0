Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BAA589611
	for <lists+linux-pci@lfdr.de>; Thu,  4 Aug 2022 04:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiHDCUj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Aug 2022 22:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239016AbiHDCUS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Aug 2022 22:20:18 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6100361117;
        Wed,  3 Aug 2022 19:18:32 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 15-20020a17090a098f00b001f305b453feso3861460pjo.1;
        Wed, 03 Aug 2022 19:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=1dsYc5CCG9nBj+rwfi2DNCDwXt8IjUaLCNS+n83XUDY=;
        b=YgmSq8oWeAz+cQHVwYA7934UN/e/erwNkvrnNnaXVoLMGsIUxpUGx2sHDVRtMXL0Y8
         VUEGXN2D92C7TfNQ87s9YS0G5apme5vjhrlToMaF2qx8aRC2B46LwwOih5icuoHNgc7x
         jm3qsYdVxWS8pOAcrI/79KbzYdH5CliWfVYFTuFcHXZi1bEdZUWdTrDkru6JO4JvJBXk
         XhGuWyRXe4Zz5qLf/6eidQLncbrSWvNkXbMtnEIyYgzVKQQTy4326FpqWL9OoJvKTpva
         6JJVKmIedYmG8MmMIScKgBOiQ+J+8oELEdf5sNmSAlLhkfw4FuHJnvO4jUnhwpORVk0d
         eUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=1dsYc5CCG9nBj+rwfi2DNCDwXt8IjUaLCNS+n83XUDY=;
        b=bVB1L9aS6Q/iWtWmPrWIQDJaNhq2HF2MH4eRaYPmwra7b2kw9UiHqAtPwCSvAb2EN4
         HTFGMuE9IJquQ5SCCoIX1XxRnMsUNKL7dyzlXgQEP72QW8Gk3Mg3qcrS6OalEaOYiD2U
         HIzJZb4qG9BAVrVbZ6kuRvq8gwXzYxlvu689C+neEAdnCzIEa9V9qDIrxUl/T24sEne9
         SzlB8BPKckGbBR2V7OljqG/pmqqgoRDOGLLdw5wfyAP1RcRbiMCdUOINUOHBl/Cx3JIT
         Ls5CIu3T2vmtEKeCz8a15oaJWI6AR3UYCwjQZzdKXOksteEiK7CwD/vuoXZvs8S0eSE1
         GPRg==
X-Gm-Message-State: ACgBeo3n8kzHtU7vD7J2DczEhmJ+Ri6UQuxq7kPJs735WQKtzlmRuiNb
        3DqjHGcaal1gU9pv4UPUU7Q=
X-Google-Smtp-Source: AA6agR4ZyAwkqOmwDBIOTcfsNUAteDufXkFgihVuncQD+861YXQPlsEFAkRWZ6+vDvSK9KhQJHTrWw==
X-Received: by 2002:a17:902:e884:b0:16d:87b2:657d with SMTP id w4-20020a170902e88400b0016d87b2657dmr29256131plg.2.1659579511663;
        Wed, 03 Aug 2022 19:18:31 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-2.three.co.id. [180.214.233.2])
        by smtp.gmail.com with ESMTPSA id j9-20020a17090a31c900b001ef7c7564fdsm2316855pjf.21.2022.08.03.19.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 19:18:31 -0700 (PDT)
Message-ID: <4503fbf0-aeda-8e85-432a-8808f7312152@gmail.com>
Date:   Thu, 4 Aug 2022 09:18:26 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] PCI: fix the invalid aer-inject git tree
Content-Language: en-US
To:     Huang Shijie <shijie@os.amperecomputing.com>, bhelgaas@google.com
Cc:     patches@amperecomputing.com, zwang@amperecomputing.com,
        darren@os.amperecomputing.com, corbet@lwn.net,
        yangyicong@hisilicon.com, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220804094755.1885603-1-shijie@os.amperecomputing.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220804094755.1885603-1-shijie@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/4/22 16:47, Huang Shijie wrote:
> The old tree is invalid now, fix it with the right git tree:
>     https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git
> 
<snip>
> -	     https://git.kernel.org/cgit/linux/kernel/git/gong.chen/aer-inject.git/
> +            https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git/
<snip>
> - *   https://git.kernel.org/cgit/linux/kernel/git/gong.chen/aer-inject.git/
> + *   https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git/
>   *
>   * Copyright 2009 Intel Corporation.
>   *     Huang Ying <ying.huang@intel.com>

This is essentially s:cgit:pub/scm:.

Better wording is "The aer-inject tree have been moved to <new location>.
Update the link."

-- 
An old man doll... just what I always wanted! - Clara
