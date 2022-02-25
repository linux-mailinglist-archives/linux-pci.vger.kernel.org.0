Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067CE4C418C
	for <lists+linux-pci@lfdr.de>; Fri, 25 Feb 2022 10:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239162AbiBYJg5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Feb 2022 04:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239155AbiBYJgz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Feb 2022 04:36:55 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462851F7699
        for <linux-pci@vger.kernel.org>; Fri, 25 Feb 2022 01:36:24 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 17E613FCAA
        for <linux-pci@vger.kernel.org>; Fri, 25 Feb 2022 09:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645781783;
        bh=mwBGuSv1vzWcEgYl2MgCXz9QnnQmXLrpGmSTa9ywwuI=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=r9eAB7z4Au066qpDSZhT/9tLha4EycFEcDpSDYbGUKhKjIf6GqDyx0qOB4yMtdJ0g
         84ewarQUNcMrY1MhjENr9hz+gZwZhthQsFtTnD8l2MUdO2beuYmflKwP1Pn8smPDxq
         ATilhUpWEAjVu80vT+V8eS3udpxyBM4152O0envOSLXto9+dUtvR1CNRWwYztBzb1O
         wyxvFAljpddatUQCLUt3LTK8FXE0MoodphirVw10CK9HYuGFqRXyvBqmzy9+kbqXYP
         RKSppOkDReF4VnmoAhKPnhqTr8mJl1Jdn05HngR7ByJe7btYmeRO/EdxDHyG0Hqlaq
         OY6Od5OYf5hbA==
Received: by mail-ed1-f72.google.com with SMTP id r11-20020a508d8b000000b00410a4fa4768so2043478edh.9
        for <linux-pci@vger.kernel.org>; Fri, 25 Feb 2022 01:36:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mwBGuSv1vzWcEgYl2MgCXz9QnnQmXLrpGmSTa9ywwuI=;
        b=yBYeNQQ3gnPu/cS6LwbyxXcw0hmDnA3PSDDKTnFYTAnwKiovX2qE6KrDQQs264djnJ
         /K8Bvb/9OBU+kSbxUKSeq+vYGwkIDJG5wS8WEGd9rIHjCq4pIVKk4eQC4DEzePwV67dC
         lGP89pduvUIC4sFLFOsdYndrjeQbLwoR8Za7Cj6hht5V9Lz8Dr6XRHKSl3dAvOd6qSuJ
         ijqf1dyvYCYym3r05/OK3yBMLnnvSV9DmugxRm44WPR6U+82PeCERwhSH1oEC0wclaqm
         07vPlvQ+rUyZrvZDAa62GSi2Lmlq/PDEVYSj0LzN+ZazXcrPJgjZhOa0nXGdXYvIGhXE
         G3xg==
X-Gm-Message-State: AOAM5300RlgKpGeEPoYZowtWMFWQq/A0175UjTXlOHiPCaM5BN0qHvTP
        QOUxovUvvSq4NSk0Z2+Uv+jMkXuAZPVeDBswj5AZhr+phF8UQIjpwrdgKEVZH/r2cPp73cYrEbx
        vtTW4OePiGcMybbTDB8psn0bdQGkHQ+gOy8FnsQ==
X-Received: by 2002:a17:906:4cca:b0:6ce:6a06:bf7 with SMTP id q10-20020a1709064cca00b006ce6a060bf7mr5644751ejt.109.1645781782637;
        Fri, 25 Feb 2022 01:36:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxvGXs5zpBbIxYfXArg3HJWTHPHMBjqJChT5RpHzF7M3/UrStNiNcxogS5o2fNS3FLp8Ip6Ag==
X-Received: by 2002:a17:906:4cca:b0:6ce:6a06:bf7 with SMTP id q10-20020a1709064cca00b006ce6a060bf7mr5644737ejt.109.1645781782424;
        Fri, 25 Feb 2022 01:36:22 -0800 (PST)
Received: from [192.168.0.130] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id bo9-20020a170906d04900b006ce6b8e05c1sm773655ejb.150.2022.02.25.01.36.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 01:36:21 -0800 (PST)
Message-ID: <0aff95ff-5b79-8ae9-48fd-720a9f27cbce@canonical.com>
Date:   Fri, 25 Feb 2022 10:36:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 05/11] pci: use helper for safer setting of
 driver_override
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
References: <20220224235206.GA302751@bhelgaas>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220224235206.GA302751@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 25/02/2022 00:52, Bjorn Helgaas wrote:
> On Thu, Feb 24, 2022 at 08:49:15AM +0100, Krzysztof Kozlowski wrote:
>> On 23/02/2022 22:51, Bjorn Helgaas wrote:
>>> In subject, to match drivers/pci/ convention, do something like:
>>>
>>>   PCI: Use driver_set_override() instead of open-coding
>>>
>>> On Wed, Feb 23, 2022 at 08:13:04PM +0100, Krzysztof Kozlowski wrote:
>>>> Use a helper for seting driver_override to reduce amount of duplicated
>>>> code.
>>>> @@ -567,31 +567,15 @@ static ssize_t driver_override_store(struct device *dev,
>>>>  				     const char *buf, size_t count)
>>>>  {
>>>>  	struct pci_dev *pdev = to_pci_dev(dev);
>>>> -	char *driver_override, *old, *cp;
>>>> +	int ret;
>>>>  
>>>>  	/* We need to keep extra room for a newline */
>>>>  	if (count >= (PAGE_SIZE - 1))
>>>>  		return -EINVAL;
>>>
>>> This check makes no sense in the new function.  Michael alluded to
>>> this as well.
>>
>> I am not sure if I got your comment properly. You mean here:
>> 1. Move this check to driver_set_override()?
>> 2. Remove the check entirely?
> 
> I was mistaken about the purpose of the comment and the check.  I
> thought it had to do with *this* function, and this function doesn't
> add a newline, and there's no obvious connection with PAGE_SIZE.
> 
> But looking closer, I think the "extra room for a newline" is really
> to make sure that *driver_override_show()* can add a newline and have
> it still fit within the PAGE_SIZE sysfs limit.
> 
> Most driver_override_*() functions have the same comment, so maybe
> this was obvious to everybody except me :)  I do see that spi.c adds
> "when displaying value" at the end, which helps a lot.
> 
> Sorry for the wild goose chase.

I think I will move this check anyway to driver_set_override() helper,
because there is no particular benefit to have duplicated all over. The
helper will receive "count" argument so can perform all checks.


Best regards,
Krzysztof
