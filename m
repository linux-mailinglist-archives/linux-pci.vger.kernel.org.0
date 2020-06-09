Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5411F4581
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 20:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388808AbgFISRD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 14:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388803AbgFISQ4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jun 2020 14:16:56 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D117C05BD1E;
        Tue,  9 Jun 2020 11:16:56 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id r9so3734094wmh.2;
        Tue, 09 Jun 2020 11:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ug8wVISZ12XWMBvX4HHfCm0Fc+Zf7t4MD5f5/8sqw/s=;
        b=aO1nwJ4j0QobhNHEzgQZPBk/MtjQ5+6OjtVmG/ySo4zqByYb+/ekvWrbJg4WzX9ZJY
         /yl3MaUYY8i+0jByrV8k5+GXrRGgSjnvFRctKbNH7aps+d97KS6NYURBz/1/C3Io6U1h
         W3rWAyB+szhELBy3FnhZZF3ILg+PGEEKLfXnR0ArptM5dYaomVp1X8QWGprM6oPG9hWe
         62odnXYw+OmDgiPQgPLig5QSs5bOC0gvs8tGXlcB/jy2ySj4gsgF1sIFqa7IwumGfTSp
         vkOQ0BKvJrSY5SD83Jx1gJ4h642264tiLIO3jkKWPDsni6NTRfxYHgY0a7INa4EyzvZ5
         IU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ug8wVISZ12XWMBvX4HHfCm0Fc+Zf7t4MD5f5/8sqw/s=;
        b=K5QIoMlADkgskwNxisWM5JGVeW3JwlBYYtIUSkZuePJR4wipPTjSFR8rFGHgnms+Me
         jlnBNm6SV4nyQZtRh9E6EcvSTLPIyhpzXGJz7mX7N/9u8oyF1DcVYs6C+0CHDtDhp9SD
         BV3AxNMHVUWHzuw6p/8ofYvuhCycVRjOfMG/3SiJuLU+t5rNDpmz79WNKQcR7W9ntZEj
         quiCUWpJi9a9Yb8/jqfulXYkca66OeyNedXGjBfiD6sZJgYS5W9FfluC3MBbugEbYLtD
         Ks4y6nJNjFUhwnN2mb1ucw73jajKCMSyZrMBw4/+Ic3v738+LJUhVgMBCjcGjQn0fZrv
         x5rw==
X-Gm-Message-State: AOAM531Czij67blz0CWIOy+xEkd1b/X+2uy/n63avrfHzIBvQnPIVp0T
        k5uio6LMW7kjOBrvaAuUyfFBjRjU
X-Google-Smtp-Source: ABdhPJxOL4Ecmn0J0+sDHkxj1gGfa8vi3rcCIlrDSLzWe0OKpWBizVJBPiBgM6xRFNZZy0uAqRJF5g==
X-Received: by 2002:a1c:544d:: with SMTP id p13mr5596028wmi.25.1591726614810;
        Tue, 09 Jun 2020 11:16:54 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id b8sm4705442wrs.36.2020.06.09.11.16.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 11:16:54 -0700 (PDT)
Subject: Re: [PATCH v2 3/9] ARM: dts: bcm2711: Add firmware usb reset node
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        f.fainelli@gmail.com, gregkh@linuxfoundation.org, wahrenst@gmx.net,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        andy.shevchenko@gmail.com, mathias.nyman@linux.intel.com,
        lorenzo.pieralisi@arm.com, devicetree@vger.kernel.org
References: <20200609175003.19793-1-nsaenzjulienne@suse.de>
 <20200609175003.19793-4-nsaenzjulienne@suse.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <1994ce6d-0599-3203-b512-a4e93528910b@gmail.com>
Date:   Tue, 9 Jun 2020 11:16:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200609175003.19793-4-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/9/2020 10:49 AM, Nicolas Saenz Julienne wrote:
> Now that the reset driver exposing Raspberry Pi 4's firmware based USB
> reset routine is available, let's add the device tree node exposing it.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
