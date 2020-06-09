Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B59E1F456B
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 20:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732868AbgFISPb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 14:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388141AbgFISPO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jun 2020 14:15:14 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B16C05BD1E;
        Tue,  9 Jun 2020 11:15:14 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id i4so1755087pjd.0;
        Tue, 09 Jun 2020 11:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gHQQinCIzqEJjug0+1o/FM1FbKMIGL0TZzTmm0jtFe0=;
        b=e3AFAIm9qkdnmKstkqTej98vjlXzkrM4oxyUFCst7qAsdixmAdSgQq2gB7aGfH/qdB
         VHOBBkrRqJQmVOdDmi7tCO/XfK6BWEdt9eyRAkP617IiZ10ASUg9PLz3wTWeKe/ZOsaC
         BGKW7W7/OJO7RVHSxHmnMRwt+yNpagJVEecAqP/+FfCjE4Xfb7AlzUcguvxlPWdXlzg1
         YpDo9TYHKudPl9x+J7xex+BD05hyNiviKb/0Cy3XSrYaWD1MMGbRYA70KFE/uXfgZxFB
         NGfMM39GQ12P5V2/VxAy7ZOeh7QqQF+1TyYDeBLjSOOFNudXyewvLeeoEUTn/iFHZHy0
         tEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gHQQinCIzqEJjug0+1o/FM1FbKMIGL0TZzTmm0jtFe0=;
        b=fosO3rz8e3dy4NWBkSUGkTPmXA8DaWUhNT5HikcvFq34PL/KVoCDtKhJzfWya/TFcZ
         DxjCE7gkKL0Trt8oaCVRf4tCAOCJZTeIfJ/hw7mnyFEIImTTFqaJAnr3LJeUhJ6LL0MR
         MjL51Uj4/0345b3oDgxzvmgex5B6nEeXQFmr0qryXOZpyyFxrVNf3sRk30wkH4VzZ/tm
         e3dpphv7saN2V2QrqMiHlD7AcOBU7V0XNAl5owLvxrW0vngFeivD1I0aiWbGzEQTErVH
         gy5hEbfmA2WhwXK+vsfDinBMMleqtq7CIp0cRBN/VvQY9iitv5d7ccnQrVIhgl0CVfut
         vAWg==
X-Gm-Message-State: AOAM532BJ+dS35FWoDqrXEoMkDlrs7kwuQgBnhDlqjH1MlQhxvBQd4c/
        w7bBkQ13Yp6StYiByYC6xBM=
X-Google-Smtp-Source: ABdhPJxVHA6APINNipQ33TCWmNwWJ73EzJUJGU/KU0wvxLGZAMSGUEEFIoUuKd++Lj4a45zWrRPmfQ==
X-Received: by 2002:a17:90b:3691:: with SMTP id mj17mr5551336pjb.152.1591726514140;
        Tue, 09 Jun 2020 11:15:14 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y187sm10829920pfb.46.2020.06.09.11.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 11:15:13 -0700 (PDT)
Subject: Re: [PATCH v2 8/9] Revert "firmware: raspberrypi: Introduce vl805
 init routine"
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        f.fainelli@gmail.com, gregkh@linuxfoundation.org, wahrenst@gmx.net,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        andy.shevchenko@gmail.com, mathias.nyman@linux.intel.com,
        lorenzo.pieralisi@arm.com
References: <20200609175003.19793-1-nsaenzjulienne@suse.de>
 <20200609175003.19793-9-nsaenzjulienne@suse.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <ca1f5edf-77b8-bcc6-0e69-3ff8497782cb@gmail.com>
Date:   Tue, 9 Jun 2020 11:15:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200609175003.19793-9-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/9/2020 10:50 AM, Nicolas Saenz Julienne wrote:
> This reverts commit fbbc5ff3f7f9f4cad562e530ae2cf5d8964fe6d3.
> 
> The vl805 init routine has moved into drivers/reset/reset-raspberrypi.c
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
