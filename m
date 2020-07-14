Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001B621E747
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jul 2020 07:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgGNFEH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jul 2020 01:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgGNFEE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2020 01:04:04 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEABEC061755;
        Mon, 13 Jul 2020 22:04:04 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id 72so6531341ple.0;
        Mon, 13 Jul 2020 22:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J6fZwVk24XGfgBxPoL5crYI+N5PiWwTfHFA65MPMVZk=;
        b=oEKPAwx4GyHC6xmDBAEPl6V7mNhsZsNcvI9zHN/ZTgEo/LqxmLpwrn73AKk2A1y76c
         /dm58xfAMsBh4IBI0KKN0Hsbz3t3etJSzmk2nmG515ZKQmCoc+dUDK9CSooz6oyZzIKx
         SXzbCSAagmBmPbfsCh1Kb7bMbpZ6/KcFKiupzPkacvdsS5DBMCg+ybo08ZLetp8vFidL
         h7YBjdths6Os4zgbxQv18jWVNzOnbxr9Dq5QP5jFMS2HOO5DPdn7tu+AVQil6ySZFxHu
         YoFLxFl2oO8iABtiukBcY8N7l4HKhBB3wILLJ74Si8sARPDPVs/XJuOKgqXzRbvQ4tws
         Qemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=J6fZwVk24XGfgBxPoL5crYI+N5PiWwTfHFA65MPMVZk=;
        b=qoDK4XwTQKoQrYYo8Fs9bsmJC5KEfyxsVepvv+hRQ/zrTulB6tm/0k7UksQVYnrXbk
         iNS/M9vV9wtCW59HIz+Z6WBrjWiYLkJcYKdiQjz1Eu4ZUf2ySqfOK+t5+5PW26Tlkstx
         koWloNASXaMlSRHao+Vgw7DI7IFdahg2yURaQ8WMRryGsGrWK+soxh1M20iKvRPEC1j2
         WGiV3j12Afby0FHzuFpop0LwZJyr5OnjgfqyczjXk3upKDKjwxjBJZHlgieCaxLtQ9w+
         d/4fvmFYgPhcpAgXSk1YrQ7uyRXr6vmm+Mt2EtjAo9dwsQ41x2eK3rXaLuCH8XEXLAeu
         fbyg==
X-Gm-Message-State: AOAM532zCGzV7rL3T+tljlxSkPYb3fWhBITbSGHxtqWmbryfrKJRCPN7
        7/IGnVq9nqzCTMPOSvtuCPvbQl81KEA=
X-Google-Smtp-Source: ABdhPJzY/MjIIbiXdL5kEjKrtA00P/bfZOiwaxsQkBIHvxJ7WssS5XHHgxxZ9rY5a3OSey7GPywAHw==
X-Received: by 2002:a17:90a:158f:: with SMTP id m15mr2719045pja.93.1594703044144;
        Mon, 13 Jul 2020 22:04:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z11sm4887461pfr.71.2020.07.13.22.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 22:04:03 -0700 (PDT)
Subject: Re: [RFC PATCH 17/35] hwmon: (sis5595) Tidy Success/Failure checks
To:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        helgaas@kernel.org, Jean Delvare <jdelvare@suse.com>
Cc:     bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20200713122247.10985-1-refactormyself@gmail.com>
 <20200713122247.10985-18-refactormyself@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <33cc25df-b34f-6bd1-5fc4-872b42369672@roeck-us.net>
Date:   Mon, 13 Jul 2020 22:04:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713122247.10985-18-refactormyself@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/13/20 5:22 AM, Saheed O. Bolarinwa wrote:
> Remove unnecessary check for 0.
> 
> Signed-off-by: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
> ---
> This patch depends on PATCH 16/35
> 
>  drivers/hwmon/sis5595.c | 13 ++++---------
>  drivers/hwmon/via686a.c | 13 ++++---------
>  drivers/hwmon/vt8231.c  | 13 ++++---------
>  3 files changed, 12 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/hwmon/sis5595.c b/drivers/hwmon/sis5595.c
> index 0ea174fb3048..91fdddaa4136 100644
> --- a/drivers/hwmon/sis5595.c
> +++ b/drivers/hwmon/sis5595.c
> @@ -825,8 +825,7 @@ static int sis5595_pci_probe(struct pci_dev *dev,
>  		pci_write_config_word(dev, SIS5595_BASE_REG, force_addr);
>  	}
>  
> -	if (0 !=
> -	    pci_read_config_word(dev, SIS5595_BASE_REG, &address)) {
> +	if (pci_read_config_word(dev, SIS5595_BASE_REG, &address)) {

Ah, there is is, and I see that others commented on it.
Single patch, please.

Guenter
