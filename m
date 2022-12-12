Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B0664A7E3
	for <lists+linux-pci@lfdr.de>; Mon, 12 Dec 2022 20:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbiLLTFN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Dec 2022 14:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbiLLTFK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Dec 2022 14:05:10 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE417CC1
        for <linux-pci@vger.kernel.org>; Mon, 12 Dec 2022 11:05:02 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id x25-20020a056830115900b00670932eff32so2487521otq.3
        for <linux-pci@vger.kernel.org>; Mon, 12 Dec 2022 11:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ikOi/brEDS1RRSKmqeJmcWUMDmT651JD+MszxE9reuE=;
        b=Cw0oiXQ1iV3nwKNAb2Bm0S13p6hv8dYl8gkEbj48HuTZGf12sKG/HL5sS59bGEIBUl
         XqA3yGrssoSrZknRnJm7xQoucpT0W+VDfmGm3qAjJZC+P3CgYQcDZnUkmiz0JvAaIQfc
         OCIpBi24jtzbP4CatV8Le2CPb9L4WtzYhSjQcflx1D9XWD/hDdXS3AfjsaNKoGdQvwsc
         /iOoNFXMdz0eciDKS9DCu7/fz6u6+/ie0yhouiem3BlBJlvSZxNIlc9gJir0wq3dOLMw
         FpQxRnOnPZECUWdk2cpRgrfeT0dgDxte2lv0Nq/a3u74y6jSnRe6s/0Ui3H7sxpom2BF
         sFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ikOi/brEDS1RRSKmqeJmcWUMDmT651JD+MszxE9reuE=;
        b=TPZwLh7vgUbcusvXnHryswd6rAC0e+fWPVAjCOK3gyrTguETANZg5MzvgAabR+a51F
         z5I4Gvm0xG9MuO/FmofmQIr0fSCcS3b1Gj69R1JBZ2TgP68EfsN6qCjFH4nuCSUXTHJl
         hmApHzMXvzGa7b+xVYYG9g2FktjxzkiPO3/PgKm6LZh048vwZdCkZnC5R8qBLZUQLBRg
         V659Kt3sM5uT+PgH/MzjfQB47WuwZI05cyRGm/CS+HgeUPXA5RZVWJVpg8ueoyVjeqMF
         2w6XE7/5YM18K5EKrytxRIMR2BeCRchod7FKyrz1kuHFH19ZaTk2K0qXuxm3t4kVEtC2
         oK3w==
X-Gm-Message-State: ANoB5pkRF85fUduZjP9WD5uRDroRapHlLLWW1yeoA34kDnFapxF+8Cog
        FbmbQV3ZOPyuUWuhRMQEbNw=
X-Google-Smtp-Source: AA0mqf66QD7e1pgPXpU6quuymHO4LOa340MQczZT+ccvn0dgfx9ZCe2VpS37DWiZM+q0PxNVQidlpA==
X-Received: by 2002:a9d:4b0b:0:b0:66e:c0c9:876e with SMTP id q11-20020a9d4b0b000000b0066ec0c9876emr9243456otf.38.1670871902305;
        Mon, 12 Dec 2022 11:05:02 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c7-20020a9d4807000000b0066193df8edasm268395otf.34.2022.12.12.11.05.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 11:05:01 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f02e6f0f-d144-3eed-03e2-e55f459f666c@roeck-us.net>
Date:   Mon, 12 Dec 2022 11:05:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/3 v4] virtio: vdpa: new SolidNET DPU driver.
Content-Language: en-US
To:     Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean Delvare <jdelvare@suse.com>
References: <20221212142454.3225177-1-alvaro.karsz@solid-run.com>
 <20221212142454.3225177-4-alvaro.karsz@solid-run.com>
 <848cc714-b152-8cec-ce03-9b606f268aef@roeck-us.net>
 <CAJs=3_AdgWS23-t6dELgSfz7DS4U0eXuXP_UZ3Fn21VCEwA-4w@mail.gmail.com>
 <3f83e874-3d7c-cc97-2207-a47dbcfe960f@roeck-us.net>
 <CAJs=3_D6_TayfdSz9e6P6G+axyUht4iyHnwHgPJ8sXG2a3sm2w@mail.gmail.com>
 <CAJs=3_DhEpGjgNZ6+cJiK6WVCQkBYW0V2EvF9vhTW-K6VodB_Q@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAJs=3_DhEpGjgNZ6+cJiK6WVCQkBYW0V2EvF9vhTW-K6VodB_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/12/22 09:56, Alvaro Karsz wrote:
>> Even better would be a separate CONFIG_SNET_VDPA_HWMON Kconfig option.
> 
> I prefer to wrap everything with a single Kconfig option.
> 
>> depends on HWMON || HWMON=n
> 
> Are you referring here to CONFIG_SNET_VDPA, or to the
> CONFIG_SNET_VDPA_HWMON you suggested?

Either

> Because if this refers to CONFIG_SNET_VDPA, HWMON=m  will block the driver.
> 

No, it won't. It would force SNET_VDPA to be built as module if HWMON
is built as module. Then you would not need IS_REACHABLE but could use
IS_ENABLED instead.

Guenter

