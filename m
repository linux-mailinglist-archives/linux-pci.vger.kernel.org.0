Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B132D2C6EDD
	for <lists+linux-pci@lfdr.de>; Sat, 28 Nov 2020 05:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732670AbgK1E60 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Nov 2020 23:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732598AbgK1E4Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Nov 2020 23:56:24 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F83C0613D1;
        Fri, 27 Nov 2020 20:56:23 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id l17so5841298pgk.1;
        Fri, 27 Nov 2020 20:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AynNNkh5VMrHwuoivbI//59qdaXTX0lKYpqD3IR09vQ=;
        b=qJwXsWuFZDukcWWX2ic/SJrEf1OmG6OT4G8oHqhDGU5SsKyoN9T5QlBd7EfTYGk2tl
         AXE9CvM6Qij2WsiqjEHgPLVverkC3gKeAj0q+TtLGFbzXvwx+sZOEZd5I+1kbUlZgTHD
         OCB+XFawjMK6DYUReqjKQKkpGAC0ycZCo5Em4vtrGtKoWSLcyICSdI0rNz5N1HWeESlh
         mQ2k104OMSpDAWKGUU1sF1ia1mI4xOqcJrDETBHupk+TfdMq2cBLSVp68Mx2NVO2qNnW
         jRLSCMao358yS38C0zqJ6fZJf7kElg+AHCiLThY4rw35FnqlJwU+jX7nZsa22xVILiHo
         KAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AynNNkh5VMrHwuoivbI//59qdaXTX0lKYpqD3IR09vQ=;
        b=EDd/56hJywmjKEJ60JoigjPEqryHpnlARX6sIfOlsnZjBuyF84C9rZKtkxBUwATmI8
         92B9g81h7cAVjLu+e8F2qSPEtbEfBvI4bDg+0m7T4OcUriZ1KlAqrEYwtRUBI5afN6i4
         MwqosVgW5YxLnpNl+m/zG8UZdzrRlLlF1L8cTK5nmoMTXA2Fioz41OJ8h6ZFAKG11nOo
         ucyvrO+j/Iq8spdyHK7HhxKtu4mGPbuvp8q1D2bNuSWynYUPnaw2/YrDnODsIzcU00yZ
         AmSqJZ62vk8HxATuf5tYv2pMq8pZ1a7NSb1fLGU3W45JkoI9AkXzuGKAKw4meBKSY86i
         Dugg==
X-Gm-Message-State: AOAM533E46i+Qcsn28NU17tEAMsLti26Mua3jokJMSNKTAyz7McR93C+
        hj6gr7rSrEhy3izI6WF8AIk=
X-Google-Smtp-Source: ABdhPJyai5WIqCy2vTOQE8AhHLgDK6b2Uk43FrLvE2tErD7V05XptsN39P1xAm5yL6Kkq6XL7kMmXA==
X-Received: by 2002:a63:6447:: with SMTP id y68mr9444390pgb.407.1606539383346;
        Fri, 27 Nov 2020 20:56:23 -0800 (PST)
Received: from [10.230.28.242] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id v23sm9313818pfn.141.2020.11.27.20.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 20:56:22 -0800 (PST)
Subject: Re: [PATCH 1/2] dt-bindings: PCI: brcmstb: add BCM4908 binding
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20201126135939.21982-1-zajec5@gmail.com>
 <20201126135939.21982-2-zajec5@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <d4de2fd7-b606-ab2e-8829-ba52a2d23d12@gmail.com>
Date:   Fri, 27 Nov 2020 20:56:20 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201126135939.21982-2-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/26/2020 5:59 AM, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> BCM4908 is a SoC family with PCIe controller sharing design with the one
> for STB. BCM4908 has different power management and memory controller so
> few tweaks are required.
> 
> PERST# signal on BCM4908 is handled by an external MISC block so it
> needs specifying a reset phandle.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
