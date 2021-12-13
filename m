Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9EAE47386A
	for <lists+linux-pci@lfdr.de>; Tue, 14 Dec 2021 00:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238161AbhLMXZT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Dec 2021 18:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237209AbhLMXZT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Dec 2021 18:25:19 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7A3C061574;
        Mon, 13 Dec 2021 15:25:19 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id k4so15871070pgb.8;
        Mon, 13 Dec 2021 15:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YP+ffKrUJr8QXyiTZ9/kLIKAoLrfL8wsguznBx5B2CE=;
        b=FTvwwio3LVWlE2HNchnhYWqGrbhWkezDizZqQEfCCD5IRum2S+yV5X6HAIwZ311g/e
         byqo9trpSM0a6VdhvAKq4JLKiqk9vkqvS5jvc7EX8AXqAk5loR8QLi2/uFwdD04cLQkv
         VUtdcYVD1cf88nMPnDuje/3RhuuzhYTiTxLyMJ/cX9jD7xKs+4HaIP4GY/xysOclVXjJ
         3M/pWd1GVMCZ5b67cVU4kHAYgUwwqti7byLqBr0owllsxIQ/5lpBgHBeCkKcJKnhQbMU
         avMvv65f1U9m9jWnrH1H0CrlUX40Tjtnc5VTiA1M5XlPxv/QKoCrFauyGZ+Lv2+3rBD7
         CNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YP+ffKrUJr8QXyiTZ9/kLIKAoLrfL8wsguznBx5B2CE=;
        b=rck6Ai3haBwMOtCF5BZaj4KtwQO3GRuYe2EM8Y9vS8hVyjeMjfDw5P3lMlpT4/1Oyd
         xTgbwiVEz4B0G9oYVq1lUJrTn+9VVySoKTjX4ZyyJrZZMlWI+N+i6s46y5pNy34YyBci
         XlBHkr6ySsLC4DjSBNrkdKzLEvfy9Fkjn/tfCBnt9osfOJjsKcdTgNjhvstwR2vSsZrl
         NzbqMMGDy+QF9kKQUsGdEqUEx2Xuz/QvByTmS8IeSieCGplUh9+AukB+7BwYitgzd1Sk
         77Ld93i3U72tTuHqRwBIqmwoAB7qzJHvyqCT4u9GCDVO9Vp4FmT4YhFTzjlDbbELNcUt
         ATxg==
X-Gm-Message-State: AOAM533e3LJxVBdsI6FktFVfzkyP/953x+D5kmFHai1tj3lu8DT3vnzo
        gE3impn0X8I9GmiACTVUPa8=
X-Google-Smtp-Source: ABdhPJw5vESmcF3HpqofyBeME59yBVkiKN2+K1LMyY1qJg9eTtIGd9pEbUSLP/MoM/de9KqB8LPl0Q==
X-Received: by 2002:aa7:9007:0:b0:4b1:40b9:7046 with SMTP id m7-20020aa79007000000b004b140b97046mr1181544pfo.48.1639437918708;
        Mon, 13 Dec 2021 15:25:18 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d9sm430953pjs.2.2021.12.13.15.25.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 15:25:18 -0800 (PST)
Subject: Re: [PATCH 6/6] dt-bindings: pci: Convert iProc PCIe to YAML
To:     Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>,
        devicetree@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20211213190221.355678-1-f.fainelli@gmail.com>
 <20211213190221.355678-7-f.fainelli@gmail.com>
 <1639437829.333710.1773610.nullmailer@robh.at.kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <91c2ad0d-491c-902a-4b12-d96f9cdbbab2@gmail.com>
Date:   Mon, 13 Dec 2021 15:25:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1639437829.333710.1773610.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/13/21 3:23 PM, Rob Herring wrote:
> On Mon, 13 Dec 2021 11:02:21 -0800, Florian Fainelli wrote:
>> Conver the iProc PCIe controller Device Tree binding to YAML now that
>> all DTS in arch/arm and arch/arm64 have been fixed to be compliant.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  .../bindings/pci/brcm,iproc-pcie.txt          | 133 -------------
>>  .../bindings/pci/brcm,iproc-pcie.yaml         | 184 ++++++++++++++++++
>>  2 files changed, 184 insertions(+), 133 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>>  create mode 100644 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml:97:34: [warning] too few spaces after comma (commas)
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.example.dt.yaml: pcie@18012000: 'brcm' is a dependency of 'brcm,pcie-ob-axi-offset'
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.example.dt.yaml: pcie@18012000: 'pcie-ob' is a dependency of 'brcm,pcie-ob-axi-offset'
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml

OK, so the dependencies must be quoted, but not the properties
declaration. Thanks!

> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/patch/1567483
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 


-- 
Florian
