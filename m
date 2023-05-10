Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FBB6FD7DB
	for <lists+linux-pci@lfdr.de>; Wed, 10 May 2023 09:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbjEJHIs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 May 2023 03:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236144AbjEJHIq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 May 2023 03:08:46 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049164218
        for <linux-pci@vger.kernel.org>; Wed, 10 May 2023 00:08:43 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so66133084a12.0
        for <linux-pci@vger.kernel.org>; Wed, 10 May 2023 00:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683702521; x=1686294521;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eS3uKPsHcGZIkIwsTVqRC2UstZ20/qzhnJE4KmhckrU=;
        b=mFvIMsraSpSLac8c2tS5ssp1cJyaxzreWmrSM5dgoDZ2KLfxsrTzpo0m0GX8ob3x3r
         a36SpBDjTgDS73b4J8appqeHn3S+cpHOFNRFthKUpW6Wur7qLZy6HjRhjJr6U14Ozz3b
         CK/J0N42wvsZkrFds3y7x+wQTqNR+Uw/0yKLk3rUDXRT5qqDGHkHjLzcsUfjOffg2ZWp
         CNWW/W3UslpyAXVQNka5yxtt0Pqg7g26hKp97yAR+/jbLqZrTLFZFj2fnxao0mknJJXb
         Z5fov0AUVpH1cZ+ZFGl2/LrR36hzk9xBgy6atvO5YaHH79rwccDXIgYzEzBb3r2vhEpA
         B95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683702521; x=1686294521;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eS3uKPsHcGZIkIwsTVqRC2UstZ20/qzhnJE4KmhckrU=;
        b=Yqar3ELYOEOsVmB0AvtJx71Av52P0xQS8wfquzJzR2KoUeUzJFeHWmx1XQ/SAEn25t
         EqEVBz8o3pCU2+MtKbhlXpCLaZS1k6VTkb8FevdDIHawjUd6sizfbH12uHkAkI/7uS6G
         hhGX3Rz/wMxbl6HTRBTi2utMR4hA9J6crwDpYj+XrV2llFVpwoOzjd2keidZOwf1/trb
         q2c9duMrVsBqcMWFS8zaUxdUQMZOyaEgm0HNcE5mDlaxvDt8j4KGBWBc1Y/e7nQo38t1
         GcTMk1uTK7PNj+1IkktJq8huICkYWiwZNwxG12vJGCDf0UCqow6597pTXksOWV/SUW6N
         FDqg==
X-Gm-Message-State: AC+VfDyF/gS2Gwvzd2xaSZwKgDn9UlKmYrnDubJ1uzWTB6xrmRWRQCbl
        yN4XWzdIrD1+4iZ+HyCSq+N0QQ==
X-Google-Smtp-Source: ACHHUZ4+6ytKlhUVP5y89FeW6sU98CuIgCUYoFhX3AKqeJ+z+TpD9k2DS2crnv8ssBOurHYlauHY1Q==
X-Received: by 2002:a17:907:d0e:b0:94a:57d1:5539 with SMTP id gn14-20020a1709070d0e00b0094a57d15539mr15154034ejc.5.1683702521312;
        Wed, 10 May 2023 00:08:41 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c175:a0f9:6928:8c9d? ([2a02:810d:15c0:828:c175:a0f9:6928:8c9d])
        by smtp.gmail.com with ESMTPSA id w10-20020a170907270a00b00965e9a23f2bsm2263354ejk.134.2023.05.10.00.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 00:08:40 -0700 (PDT)
Message-ID: <6a36a4ad-6d46-4e4e-1724-ed27513a72ef@linaro.org>
Date:   Wed, 10 May 2023 09:08:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/3] dt-bindings: phy: cadence-torrent: Add latency
 properties
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Dominic Rath <rath@ibv-augsburg.de>,
        krzysztof.kozlowski+dt@linaro.org, tjoseph@cadence.com,
        bhelgaas@google.com, lpieralisi@kernel.org, nm@ti.com,
        vigneshr@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        bahle@ibv-augsburg.de
References: <20230509215700.GA1277746@bhelgaas>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230509215700.GA1277746@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 09/05/2023 23:57, Bjorn Helgaas wrote:
> On Tue, May 09, 2023 at 05:31:19PM +0200, Christian Gmeiner wrote:
>>> On Thu, Apr 27, 2023 at 07:50:30AM +0200, Dominic Rath wrote:
>>>> From: Alexander Bahle <bahle@ibv-augsburg.de>
>>>>
>>>> Add "tx-phy-latency-ps" and "rx-phy-latency-ps" DT bindings for
>>>> setting the PCIe PHY latencies.
>>>> The properties expect a list of uint32 PHY latencies in picoseconds for
>>>> every supported speed starting at PCIe Gen1, e.g.:
>>>>
>>>>   tx-phy-latency-ps = <100000 200000>; /* Gen1: 100ns, Gen2: 200ns */
>>>>   rx-phy-latency-ps = <150000 250000>; /* Gen1: 150ns, Gen2: 250ns */
>>>
>>> Are these things that could/should be described in a more generic
>>> place?  They don't look necessarily Cadence-specific.
>>
>> As there is currently no generic binding, would you like to see a new
>> yaml binding
>> added (Documentation/devicetree/bindings/phy/phy.yaml) that contains just the
>> two phy properties?
> 
> The whole thing is more a question for Rob.

For which you might wait a bit currently.

If the question is only about location of the properties - device schema
or something generic - then for now you can keep it here. Moving to
generic schema is always easy later.

Better to have proper names for properties.

Best regards,
Krzysztof

