Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9652A3C39DC
	for <lists+linux-pci@lfdr.de>; Sun, 11 Jul 2021 03:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhGKBvX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Jul 2021 21:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbhGKBvX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Jul 2021 21:51:23 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AE3C0613DD;
        Sat, 10 Jul 2021 18:48:36 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id k20so7283744pgg.7;
        Sat, 10 Jul 2021 18:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=j6FUklx2d93VEwoC/aTsauLvZ4Bb1dQXPxIN1KFt7ro=;
        b=NXIYwC+gMfjj6KNzCgcJTDlNp6oLaom/ykzQRdmk8//zNabcRkF9hKYPPCnn5ec8DZ
         3fUN7LIYaR/dDdtyo/r9d+5VAbtYmt8BxymSaRnJaJZ5lzCjMZC1nV6H1hjuCCLzZ/8E
         0Dal6efvtIKNa5LblGzm/LW1vtz39DwaTJYpJqmESm6TtCNJ/ISL6kFxCfB7ITD3BpUa
         xNmypbDqfyii/peNe7vyBgh2PTKSTzJHD28RfaIUxo39U1quEn5q2QcH2EZCM7C8tLW1
         2H1TRawutXsIxqTkFQREOM1GKF+ZEUwQI8GtS4IexGYoKR8Rj8CfeMH015osA5oz62gt
         o4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=j6FUklx2d93VEwoC/aTsauLvZ4Bb1dQXPxIN1KFt7ro=;
        b=f3gza9VZCtIo+sS6w8pf9SOj/uUslWL4bwLCi3Opwgo5rl+TSEGWK+eijviVb302bx
         x4lWJh7ZHCYzJMmHFeXgDX/ft6rGOYE0bBxq41Xfatpj/xCvfkclWseLMhMOUzLStP05
         aADX9j5tMqPSRYOPYVIymYPkh3ZYM8jbNaQ8Xtr6xHwtpCQmEmoK9cY53slcPPUKcbUA
         uaRiairXMwVEm2zIAAno3nXXrTTxjTAjYQROsF7PuBH7PkEd8hfcdq87dyYn73P5O2NT
         Jv1/ehDUITaSffySsNNtIgJY3uOZRugrNphYkdS2NfCOPZh/bITDVvkKOZHZCxWa9bhd
         rJ0A==
X-Gm-Message-State: AOAM5317xlHCwXJ0jMtXTxzOCz44MyKNvB1P6foFTE4umHJ8pBDy/7gR
        fEo0Gjy3IkSqzPr9WVNiRexMM2FdQBkwYP7k70CI
X-Google-Smtp-Source: ABdhPJz2NNiGHlfJpQ8t2Flv1qtaFT4+WhuG3KXJ03BhHwJY1JETcHHOsXBj37+QT1adrCKeBrXWvQ==
X-Received: by 2002:a05:6a00:b86:b029:31d:9798:bab7 with SMTP id g6-20020a056a000b86b029031d9798bab7mr37722574pfj.12.1625968115015;
        Sat, 10 Jul 2021 18:48:35 -0700 (PDT)
Received: from [10.72.0.6] ([154.16.166.162])
        by smtp.gmail.com with ESMTPSA id a23sm10792478pfn.117.2021.07.10.18.48.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jul 2021 18:48:34 -0700 (PDT)
Subject: Re: [PATCH] tools: PCI: Zero-initialize param
To:     bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        kw@linux.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210627003937.6249-1-yang.shunyong@gmail.com>
From:   Shunyong Yang <yang.shunyong@gmail.com>
Message-ID: <d4c250af-aa50-0ec0-c66a-104092646e15@gmail.com>
Date:   Sun, 11 Jul 2021 09:48:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210627003937.6249-1-yang.shunyong@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn and Kishon,

   Gentle ping. Would you please help to review and merge this tiny change?

Thansk.

Shunyong.

On 2021/6/27 8:39, Shunyong Yang wrote:
> The values in param may be random if they are not initialized, which
> may cause use_dma flag set even when "-d" option is not provided
> in command line. Initializing all members to 0 to solve this.
>
> Signed-off-by: Shunyong Yang <yang.shunyong@gmail.com>
> ---
>   tools/pci/pcitest.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
> index 0a1344c45213..59bcd6220a58 100644
> --- a/tools/pci/pcitest.c
> +++ b/tools/pci/pcitest.c
> @@ -40,7 +40,7 @@ struct pci_test {
>   
>   static int run_test(struct pci_test *test)
>   {
> -	struct pci_endpoint_test_xfer_param param;
> +	struct pci_endpoint_test_xfer_param param = {0};
>   	int ret = -EINVAL;
>   	int fd;
>   
