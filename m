Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6966E5C57
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 10:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjDRImq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 04:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjDRImp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 04:42:45 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DAC35B5;
        Tue, 18 Apr 2023 01:42:42 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4edc114c716so1596786e87.1;
        Tue, 18 Apr 2023 01:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681807361; x=1684399361;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZP3AuFdp9sJnd/O9xcelaM7FQ5mQWFrmOkCIZBKH8Y=;
        b=BZOTCcYRi2KQXa/OMkwpGHEb8mS9p5qTpd1Oslp3AhCVA8nYtOZzm1Bxmpw6xYPmC/
         WhCym8+zvTQPCzLqv1J9SsMOzVQ+JYuYpWKyAFt0MDrgOm5J4N53d7Kvqx77y77J+Mb+
         qUPVKjrFwgtcBqp50Dx33Fqr6r31DF4MrpxEwcreeusNt5mji3HqghhjwjE/Xp2AJQYL
         9Xqlr0fDmodytwpIGwRlMqwdvtRiLZviyfkYcvTW1nEi1RdrSwVBzFQUNWwwdZys8ytc
         dVlsSGgZG/kKwk30fPkKkvpEh4gP+eRZ2AcHJ1Z5J0nPKeaxitQBuoaYMgyPBqEcgBcX
         MHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681807361; x=1684399361;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vZP3AuFdp9sJnd/O9xcelaM7FQ5mQWFrmOkCIZBKH8Y=;
        b=l5OclgZZLaRqqFwbwiey6iRf2kgV7uTXk+HQz67mfUjb1L9mJDy14nq7aoOeUqUaow
         Og3tR1rXxiyaAcDrmIGTXof5dnfQZp/u7GqwzHkL6IcC0V4WAOxwXjQakkzrz/7JRyVm
         YuBhNf/Ng780E+D6JtnVy/f1dnuN8k8n4y43humTpLfdO+/2sJzUNUSDggmDS6jY5+s7
         hZzae5BBtz1ykTBrNppWhQ2eTHssUABiQ3R9vQgu6vAu1em0V5as3+fJSqseXyuoH/D7
         pHk03Buot/WL2PT4PuK6+L0pDykjQ3pBc/+Rfxh26v2S4dHS5dDRl2+JacB5lI6Jdj/5
         g5hA==
X-Gm-Message-State: AAQBX9e0HuplwuIbAvwTPq7YXyGcaanjMDhVxijk69HOLwTAieV6Dxg0
        2hXHMWvUzn+0YyPIGB2w2Tk=
X-Google-Smtp-Source: AKy350a+xZVvLTmP6/Y5+OGaMEfqTgQkdT3vuvtTRZnDkbwP8XdO40ROnyHEweOAjchfMRz0Jyg+Sw==
X-Received: by 2002:ac2:53b3:0:b0:4e8:a0a3:e242 with SMTP id j19-20020ac253b3000000b004e8a0a3e242mr2196845lfh.7.1681807360756;
        Tue, 18 Apr 2023 01:42:40 -0700 (PDT)
Received: from [192.168.1.103] ([31.173.80.61])
        by smtp.gmail.com with ESMTPSA id s9-20020ac25fa9000000b004ec83bc3e2dsm2295419lfe.42.2023.04.18.01.42.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 01:42:40 -0700 (PDT)
Subject: Re: [PATCH 2/2] ata: libata-core: Apply ATI NCQ horkage to ASPEED as
 well
To:     Patrick McLean <chutzpah@gentoo.org>, linux-kernel@vger.kernel.org
Cc:     linux-ide@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Dave Airlie <airlied@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
References: <20230418011720.3900090-1-chutzpah@gentoo.org>
 <20230418011720.3900090-3-chutzpah@gentoo.org>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <e71d0891-371e-d267-879d-47b736bb12c9@gmail.com>
Date:   Tue, 18 Apr 2023 11:42:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230418011720.3900090-3-chutzpah@gentoo.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

On 4/18/23 4:17 AM, Patrick McLean wrote:

> We have some machines with ASPEED SATA controllers, and are seeing the same NCQ
> issues that ATI controllers (I am not sure if it's a rebranded ATI controller,
> or they both have some faulty implementation). This NCQ breakage is consistent
> across a few different types of drives.
> 
> Instead of maintaining a list of drives that are broken with ASPEED controllers
> as well as ATI, let's just treat ASPEED controllers like ATI ones, and disable
> NCQ on drives that have ATA_HORKAGE_NO_NCQ_ON_ATI set on them.
> 
> We have been running this patch on several machines for over a week now without
> reproducing an issue that was happening almost daily before.
> 
> Signed-off-by: Patrick McLean <chutzpah@gentoo.org>
> ---
>  drivers/ata/libata-core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 14c17c3bda4e..051492e8e9f9 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -2219,7 +2219,8 @@ static int ata_dev_config_ncq(struct ata_device *dev,
>  	}
>  
>  	if (dev->horkage & ATA_HORKAGE_NO_NCQ_ON_ATI &&
> -	    ata_dev_check_adapter(dev, PCI_VENDOR_ID_ATI)) {
> +	    (ata_dev_check_adapter(dev, PCI_VENDOR_ID_ATI) ||
> +		ata_dev_check_adapter(dev, PCI_VENDOR_ID_ASPEED))) {

   Please align the start of this line with the start of the above
line, so that it doesn't needlessly blend with the below line.

>  		snprintf(desc, desc_sz, "NCQ (not used)");
>  		return 0;
>  	}

MBR, Sergey
