Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5ED46F5EC
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 22:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhLIVdi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 16:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhLIVdi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Dec 2021 16:33:38 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A300FC061746;
        Thu,  9 Dec 2021 13:30:04 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id o14so4872091plg.5;
        Thu, 09 Dec 2021 13:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RiC7G24eWy//YmTynebfX9hiLgZoILqeHM51jdKCP6k=;
        b=CzspmICW/W3o3Kyp6lRJiRRrGWA0P+056LHBQD4WI/6ZdYk/bhUTsP1JWlH2EwYPkP
         aWekYL/8GxJ8mzwkG0jYhXpGj0j4IAchwVL5dyA+go+L+vxdvraYszk9plcztXGsVdAM
         2HZqaZ79OHj2Gl76dZ7GnKq9ph4Ne/xgvTwHl04Rad+KeLo8NXxJFxbcdey9ahGkp1as
         A/xgWKiPqXWGQlwNJD1cmo9YzmKV2CnxzDzt9iPNocIgzqx1l7FX0z1Wt85MV6MJuMZS
         E48gg7+9m101NVSClMU+hz90pn3aGMcSVcG6rp+PngquaZCNm2U/V4sTvJ8N0HOR1Iea
         QX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RiC7G24eWy//YmTynebfX9hiLgZoILqeHM51jdKCP6k=;
        b=Yde8iy5/CdaKPf5TfhMb7jytYG+z1ETnYsfFzda2K864KEaEOrTSJJ63Za/G81pmL+
         ifFTJw6Z1llwHQrW3QPkI06SqNHvKjM6LpN3nz3nw8wRBdadn+lXGwDmD3+1s0yIShm6
         6jyd7kk9ZkCtan5PD0xEkwGAK0NXD/UrcstZuuBWKCEKiMZ6gILawJL4CE1Ei1VYqsNA
         nm7LknIjMabhJLz240Fa5kBMtQUnpKytNndef4yz5kbKrXSU6dPNoT9umQGqIE9PL+Ne
         ABQnNLxQ61KOJBO9Yy4jOBbrLKez2oug//VxJXYyD+NSG2rcMyJ3mWJMchbENuzFBm70
         wEcQ==
X-Gm-Message-State: AOAM533+GbYTgsYQHtjH+Y2VyX0/46W7r1TvJnpTy445grZ192KeSqWP
        S1vR2J3i3pTCOR2xUcWWyMPySrIaIl8=
X-Google-Smtp-Source: ABdhPJw6q1SUp3qx/RZ//ts6kYrqMBWTCt8KCFxfZwjPLvBhCMyt8OQM4nLMJ7dW04ZGkA1xPr6ZYw==
X-Received: by 2002:a17:90a:300c:: with SMTP id g12mr18602577pjb.94.1639085403765;
        Thu, 09 Dec 2021 13:30:03 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 59sm541244pjz.34.2021.12.09.13.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 13:30:02 -0800 (PST)
Subject: Re: [PATCH v1 1/4] dt-bindings: PCI: Add compatible string for
 Brcmstb 74[23]5 MIPs SOCs
To:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        linux-mips@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20211209204726.6676-1-jim2101024@gmail.com>
 <20211209204726.6676-2-jim2101024@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <592b3630-864f-7616-eb0a-ae6faf6dc9d7@gmail.com>
Date:   Thu, 9 Dec 2021 13:29:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211209204726.6676-2-jim2101024@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/9/21 12:47 PM, Jim Quinlan wrote:
> The Broadcom STB Arm and MIPs SOCs use the same PCIe controller
> HW, although the MIPs version is older.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
