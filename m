Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67EDE590E04
	for <lists+linux-pci@lfdr.de>; Fri, 12 Aug 2022 11:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbiHLJ1s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Aug 2022 05:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiHLJ1h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Aug 2022 05:27:37 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209B6A573C
        for <linux-pci@vger.kernel.org>; Fri, 12 Aug 2022 02:27:36 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id q7-20020a17090a7a8700b001f300db8677so390620pjf.5
        for <linux-pci@vger.kernel.org>; Fri, 12 Aug 2022 02:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=LzSEVyCY0rVcjjfGUaDS5CrDNhUakD7W6pkaedXCK3M=;
        b=oCrlkqT6QEgaGNjRK3uXf1a3edsqWHkyeNSIJ7B7AZlUTVJz0vJFXLsg9PDYbD9PQ0
         zPYv1dWvc67zKrHY/O4Ygj/axQvYTd04weKewgFQMty1Cc6yHY/GNr/nyP/EKngQqiZE
         d4vAKaJ5seUIQ9hdGKGurZYmfi0quA8+aAycI0/Ey5IAHd8U6jVOI9k5Fyn8YEhAy1zE
         soaKHveguOvXckf/kra51veFM0eD0MOAAh2ijzPHM1lvVvmziI+irgm7o8pARCPtr3He
         YFI0j7nwHc2TYI8YDmi2DajVxRC52TVYVjzly0wie+KkstHxh5ooH1chAZ6GAOW9p242
         7o5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=LzSEVyCY0rVcjjfGUaDS5CrDNhUakD7W6pkaedXCK3M=;
        b=gbOfSaLeEtXQoD8h4aTPP7sL42i1lACMfA6yCJUZTWys9QuHCLzQiTm4DKAwEMdaB6
         DzBYcPg3KIChw2GPMHhYcBzIIbP9YqBbOf11ca7NM//Ihgcf30R+rX9v+WsCiYN/9jd3
         Oz5j3+F3pbJfLKFW65vW4FMLiP+Ze/GlXJn5YNNsdxoEE4hK7PpJIBeM8sc+tdwm+kro
         0YSnDhLcq6xyxcSK0giNGjNVvP4Ga+k6SMcTs9yDX7jKMrJXm+Mw+jwqxMUiYs42qoFo
         xjk5jTB2tIA0W4Hib5QBh0hBbfcGZzkDiEG0yjbGHecmo9eX5kuINpwQL5IRgBVVtjax
         n+YQ==
X-Gm-Message-State: ACgBeo2auGYq9zs7BLyKqzGGmq4hN1AlUE+CSpA13uXIU3zfjW4wjICC
        XuIRCw4Y2EYIDtghAt36fvVokA==
X-Google-Smtp-Source: AA6agR548JNzF0k/wghBss2w8gS+i/8K9JWBwwU3cusnYsQeQ9eKg4O8qjzNC9Jjm3/R7fWU64098A==
X-Received: by 2002:a17:903:11cf:b0:171:afc7:8936 with SMTP id q15-20020a17090311cf00b00171afc78936mr1017395plh.95.1660296455618;
        Fri, 12 Aug 2022 02:27:35 -0700 (PDT)
Received: from [10.2.223.68] ([61.120.150.75])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902d10300b0016d9b94ddfasm1181771plw.145.2022.08.12.02.27.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 02:27:35 -0700 (PDT)
Message-ID: <1e24242e-bb37-e15f-906a-abe5cd865a98@bytedance.com>
Date:   Fri, 12 Aug 2022 17:27:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.0
Subject: Re: [External] Re: [PATCH v3] PCI/ERR: Use pcie_aer_is_native() to
 judge whether OS owns AER
Content-Language: en-US
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     ruscur@russell.cc, oohall@gmail.com, bhelgaas@google.com,
        lukas@wunner.de, jan.kiszka@siemens.com, stuart.w.hayes@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220727035334.9997-1-chenzhuo.1@bytedance.com>
 <b5c746db-f6a0-d89e-6db5-e4a206c9237a@linux.intel.com>
 <cfd44d9c-453b-e498-2630-9057947cf3cd@bytedance.com>
 <b54b068b-fe9a-8609-3e9f-170579affc27@bytedance.com>
 <6056c6cc-9861-9c29-8e36-48e0dd36c702@linux.intel.com>
From:   Zhuo Chen <chenzhuo.1@bytedance.com>
In-Reply-To: <6056c6cc-9861-9c29-8e36-48e0dd36c702@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/3/22 6:18 AM, Sathyanarayanan Kuppuswamy wrote:
> 
> 
> On 7/27/22 2:37 AM, Zhuo Chen wrote:
>>>
>> Do you mean changing "if ((host->native_aer || pcie_ports_native) && aer)" into "if (pcie_aer_is_native(dev) && aer)" ?
>> I thought changing into "if (pcie_aer_is_native(dev))" before.
>>
>> One another doubt. Not every pci device support aer. When dev->aer_cap is NULL and root->aer_cap is not NULL in aer_root_reset(), pcie_aer_is_native() will return false and OS cannot operate root register. It's different from just using "(host->native_aer || pcie_ports_native)".
>>
>> Or we can change "if ((host->native_aer || pcie_ports_native) && aer)" into "if (pcie_aer_is_native(root))". But in this way, argument NULL pointer check should be added in pcie_aer_is_native().
> 
> Looking into it again, I think it is better to leave it as it is. Please ignore my comment.
> 

Thanks! Is there anything else to improve and what's next for
the patch v3 ?

-- 
Thanks,
Zhuo Chen
