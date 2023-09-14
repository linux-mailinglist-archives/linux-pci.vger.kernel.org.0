Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF77F79FB4F
	for <lists+linux-pci@lfdr.de>; Thu, 14 Sep 2023 07:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235001AbjINFu7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Sep 2023 01:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234978AbjINFu7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Sep 2023 01:50:59 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8FDC1
        for <linux-pci@vger.kernel.org>; Wed, 13 Sep 2023 22:50:54 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52bcd4db4cbso565649a12.1
        for <linux-pci@vger.kernel.org>; Wed, 13 Sep 2023 22:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694670653; x=1695275453; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5XG/5w3QFt+z8j10yobgWN0JkuwWrNKT9qzjBjNv8yc=;
        b=coG1uD8T1UQhuCABBP+OnlDrwFJzd+cTZzzgbqn4NCGc2xgX0HKoi4tI1pnEQNgP1n
         M26nbNenpaweuERvbOqSnNcHVBUhq9WVP9kwtqtxwxtgZa88zYAJdAp5lZQQsekdaIhx
         v9fHbcARMacDllYn9GI3YtN54wiYyh4f8r5uxR6uWG+u5+UbFdBFQmfefD7WXtcfWSBw
         drtbcYvfv3Nb7ajQTPevV/PMwQxWWyx7qGGrdGKpYa8c6ggomFSEQLXJAxGijnoi0ben
         NeZjWm/8aA4IqTbFvX7lfPhN91/KQrH0iG/N8/4Pfe1Tx+Fm9aZHzvb4IkXZ/au/9wbP
         tRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694670653; x=1695275453;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5XG/5w3QFt+z8j10yobgWN0JkuwWrNKT9qzjBjNv8yc=;
        b=ObofMmifLkscpN35Tlse7nhB4IO4YOQ8M9KIaeTQwHLfta1g9Lw1gTJda3JJoOQlBJ
         GxV9UhTWW6lnRX40upLu0T7pIcDLXE5YFW5UzDyZkPSkPOhgsrP/OcXjtQj9aikOm2RH
         vkOaDvsiDk+XxfXx3OnlRuw/Lk9HQXYOL5jTXmzMlLD26qHtrSrFq+ECzacmaS5/bNqS
         /Tg8wAQ/uTqCukrNmL93ptGIou0O6J5HPA03lJXb52j7NhNaKAoSs8GaHzempZs64SXH
         d4ioCOn0NWidVd5PGRbksd4iECjx1U1kt3w+nls/y49NH9uNRS4WFji7N6Kfy5+ZCxnh
         oriQ==
X-Gm-Message-State: AOJu0YyAoS3NJTACy49NgwLd2mLcdN2x7l5MyEXqINZu8Zi2aUuhJ70+
        26fNtT4ZlYlxZzFwI3OdkJk/lw==
X-Google-Smtp-Source: AGHT+IHoEWeSl9KM8VgC+u3F4JGRb/ZlJ0PmN15BUKpX8vawuFV1zx4M5+saRC6YmNcJlXBGVG9J5A==
X-Received: by 2002:a05:6402:288:b0:525:58aa:6c83 with SMTP id l8-20020a056402028800b0052558aa6c83mr4211742edv.11.1694670653354;
        Wed, 13 Sep 2023 22:50:53 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id n16-20020a05640206d000b0052f3051f7d2sm436966edy.80.2023.09.13.22.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 22:50:52 -0700 (PDT)
Message-ID: <44a783f5-c4f0-e1d9-8802-7c8aeb444f08@linaro.org>
Date:   Thu, 14 Sep 2023 07:50:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V2] pci: introduce static_nr to indicate domain_nr from
 which IDA
Content-Language: en-US
To:     Peng Fan <peng.fan@nxp.com>, Bjorn Helgaas <helgaas@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "pali@kernel.org" <pali@kernel.org>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <DU0PR04MB941790B85BCDD60ACA2601A588F0A@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20230913115737.GA426735@bhelgaas>
 <DU0PR04MB94175EF2754D45D010F21F1188F7A@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DU0PR04MB94175EF2754D45D010F21F1188F7A@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14/09/2023 04:10, Peng Fan wrote:
> +DT maintainer and Jailhouse maintainer.

This does not work like this. Ccing me on some huge bunch of quoted text
without any comment is pointless. Do you expect me to read everything
just because you want? I clearly have not enough of work to do, right?

Ask specific question if you need anything from other people. Direct and
specific question, but not "what do you think?" (the same as this
quote). I am going just to ignore this email.

Best regards,
Krzysztof

