Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC367D90AD
	for <lists+linux-pci@lfdr.de>; Fri, 27 Oct 2023 10:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjJ0IGn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Oct 2023 04:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjJ0IGm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Oct 2023 04:06:42 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F661A5
        for <linux-pci@vger.kernel.org>; Fri, 27 Oct 2023 01:06:40 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-508126afb9bso2492419e87.0
        for <linux-pci@vger.kernel.org>; Fri, 27 Oct 2023 01:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698393998; x=1698998798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fgULfd/BQf3rXOb2Liur3bE6zxBSiYu9TNmtJmWbpCs=;
        b=Nr2WRBxuxdZCEyStn5AKTqJwjukjUD+Rw6WZ3yJPnrTbJ2F1L/8f3XUL57CTC/DB32
         4dRzDd4aatK4ErHKupCBaLkT3gbLSNILfQ3sbzwvcqnWgdUdNgZwEMUWNggmvkxdqr1l
         plC1t17dATm+8cCnuWl609h8NMJk4Wwu1jSj7i0Z1PdFxoYZYQyXo2DjYAJAuetRJKea
         e99nsyezk1c+uKELhkRHKLm74pybmpe+0XQmt30KMuRZRntann+Mgbj75zUwuPuc7Du4
         r+bncny7KsKAVcPK6smojdA8g4vYDvKmGCJEvHpG9UWuQ6MClwqF7VYEvScQk84pdfDb
         aOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698393998; x=1698998798;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fgULfd/BQf3rXOb2Liur3bE6zxBSiYu9TNmtJmWbpCs=;
        b=ZykTnHhlwhjtH1Of92HpIVPbu9GQoCVWY50+kAQ26vmk/0wHFh0+mJjBrt+tk2K6nb
         LEoO8oEXtU3Ug6wMBfv3mtFoqWEYxtuyAuOrnXZ7cNlR52mMcOC6gqzCNJoZXWXUErcP
         d14K9KIHrLAJ115tYgZ3u0opkY5J2jtAdNP9zuT758CGJhJY29MZ9rPkmX8OxGxA9rYM
         j79iqZMa0IR/cMuSDC08ZHflkET8NpMNi4yEcCgQAhzCPMGt11EDPZWKLGQYxB3KGL8Z
         okzl+CwTgHuYHcny5xVGvt3/kbVxbKAMhn7FL4vuRCeyM8X9e9TEQQiZRRnp6Eu4Qq1Y
         OzfQ==
X-Gm-Message-State: AOJu0YxjzwmIyOsTXrca7fibQxzHy7+SRKc2232G2ZGxQkbdS5luk7Vm
        /iKTpQ7B3bqVt+GBR1XoL96uRg==
X-Google-Smtp-Source: AGHT+IEJFfYsTI78D03/L8NvageWyWtEeZq1rR3P3kFq9t3sgonnO4xsQxqYrk7ZOTDAfXzejtcLEA==
X-Received: by 2002:ac2:5935:0:b0:503:1be5:24eb with SMTP id v21-20020ac25935000000b005031be524ebmr1190179lfi.50.1698393998333;
        Fri, 27 Oct 2023 01:06:38 -0700 (PDT)
Received: from [192.168.0.22] ([78.10.206.168])
        by smtp.gmail.com with ESMTPSA id be11-20020a056512250b00b005081a25b095sm180122lfb.246.2023.10.27.01.06.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 01:06:37 -0700 (PDT)
Message-ID: <f7b90711-015b-4261-b044-a63396e78c9f@linaro.org>
Date:   Fri, 27 Oct 2023 10:06:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: exynos: Adapt to clk_bulk_* APIs
Content-Language: en-US
To:     Shradha Todi <shradha.t@samsung.com>, jingoohan1@gmail.com,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, alim.akhtar@samsung.com
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        pankaj.dubey@samsung.com
References: <CGME20231009062222epcas5p36768b75c13c7c79965b5863521361a64@epcas5p3.samsung.com>
 <20231009062216.6729-1-shradha.t@samsung.com>
 <0b4801da08a0$18877110$49965330$@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <0b4801da08a0$18877110$49965330$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 27/10/2023 08:37, Shradha Todi wrote:
> Gentle reminder to review this patch. Thanks in advance!
> 

Please relax, and help out by reviewing other patches on the mailing
lists in order to relieve the burden of maintainers and move your
patches higher up the list.


Best regards,
Krzysztof

