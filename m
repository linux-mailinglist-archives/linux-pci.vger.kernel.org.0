Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734731F455E
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 20:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388459AbgFISOy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 14:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732716AbgFISOs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jun 2020 14:14:48 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BEBC05BD1E;
        Tue,  9 Jun 2020 11:14:48 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b16so10400660pfi.13;
        Tue, 09 Jun 2020 11:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AS/XdckXtD5JdzBhAwpc/WtJW1ZnWelaj/7RjUzTTTY=;
        b=ofzyfTDcbSR0iVmnOlwQrNgiLJk688yu4yKaniy1FmZvGhVlPmR+qx/S/V2J7M31i7
         sBnfLijv4zGVBlM8tTHwV2tNvqMN+eDLy/8nYxIzkQtZvE6Q8X8CS9bzGYaRwW1CAcrc
         Qrcz9dMBcwoiAizOECxolgNx0k32d1nYqZuCe9ln3pCAjSHZrgAmF4lyMxqvNMX3Z+aC
         J6LVha9AtTt8375Pm2xUf/D/tE+irK0XKxAOAJsLCfkXGjeey0Wl3ZvgxB+IXUjmGal8
         XZPVk9P3DPqQ8/qQzNUA6OI0QqTJQIJe7v/gRidSRM89xL/wXCYAIBPFoRdFNRIToIs9
         eeBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AS/XdckXtD5JdzBhAwpc/WtJW1ZnWelaj/7RjUzTTTY=;
        b=adnKtZ/gvJ/HFaR4upUFiO93CY9SyzVPg5+H0XiMG6RpHlQKvcjYkCJZI6dnXhII/v
         h6VpnI0+Zo4yP130dbSiq+24Au3LS5A2CE8Y2/fdsa2CpYd3oUPboxOr/IxZ//uef5Zp
         qVEfS3NbGFp+z6TTDKOltUoDbm0HbOZt6OCIPl7M+5zC02QZ+oIUWE4ujqJXIn/aLba8
         Lx6lePCk3NoBcW1vei0etulBx72Up6m98goQdJpoRvNs/kg4cLAJuY9O54XBHluZ3hJ8
         QMZHri7NN/zfueplGLk2JD+nMofdJrG5xJfFdNC9Id+WD+ICWq9ZyYL7iZeYaKv3WKeK
         51hw==
X-Gm-Message-State: AOAM532iOUZlIK5AZrttVY8rex8/CbT0frUj033Nm5Akxi+nW5FAkjtX
        PuW0U0BgW5Zl5+2Qccnd4D0=
X-Google-Smtp-Source: ABdhPJx2SlXa0n42ZaJT1vZCe4xrRMIjnru6dBSBFP7GNH70CVg7MYDKbKWTswiYGotNLgBCKvVhAA==
X-Received: by 2002:a63:eb42:: with SMTP id b2mr25756419pgk.105.1591726488350;
        Tue, 09 Jun 2020 11:14:48 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id w12sm9688715pfn.68.2020.06.09.11.14.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 11:14:47 -0700 (PDT)
Subject: Re: [PATCH v2 6/9] Revert "USB: pci-quirks: Add Raspberry Pi 4 quirk"
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        f.fainelli@gmail.com, gregkh@linuxfoundation.org, wahrenst@gmx.net,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        andy.shevchenko@gmail.com, mathias.nyman@linux.intel.com,
        lorenzo.pieralisi@arm.com
References: <20200609175003.19793-1-nsaenzjulienne@suse.de>
 <20200609175003.19793-7-nsaenzjulienne@suse.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <59accf8f-c947-4efb-f8fc-1df821b35c3d@gmail.com>
Date:   Tue, 9 Jun 2020 11:14:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200609175003.19793-7-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/9/2020 10:49 AM, Nicolas Saenz Julienne wrote:
> This reverts commit c65822fef4adc0ba40c37a47337376ce75f7a7bc.
> 
> The initialization of Raspberry Pi 4's USB chip is now handled through a
> reset controller. No need to directly call the firmware routine trough a
> pci quirk.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
