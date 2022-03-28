Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBFE4E8EBF
	for <lists+linux-pci@lfdr.de>; Mon, 28 Mar 2022 09:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235920AbiC1HNp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 03:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiC1HNo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 03:13:44 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D3D52B1E;
        Mon, 28 Mar 2022 00:12:04 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id yy13so26683308ejb.2;
        Mon, 28 Mar 2022 00:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=A3bAA5yAZfqHAOyYK98ovGqRH+yACNii1ofYKDFYNqg=;
        b=SXOqE1mP/YO/ovpX34cLKYdTIcBIsutbGgPpSiFPff3k5JvrikxkLwj5Tuk5OJgtUX
         7S9dpeDWGd0j9nFdJyV+dALO1FS6c5qZ5kox1cA+yACYV/ZPsGS7Mpsk2B//PDZpEgOQ
         LcPmD7IpD8sGTqLFHgfpflMezGS2iUWVOvXNvlGdcbdMKaRpcadoT8+6V2xMbdWbhc4M
         Zbk6ACQENHNcMixiKlt1dWvyTaW8WDWJkKJMKer8iL9qzEx6wMCcK9CPaG7dztHpdVwV
         0Dj3sDlnXDfkW0h/LzE4LaaO5O8L9qgzfTVUDPWY9H4R/kyOpjT79D3LruNc4kzI+9ma
         dfgA==
X-Gm-Message-State: AOAM5300cgio2qvW4rndw/jc9ydU7TN4u8ZRYentjRa/fw3K+N3sin7V
        aqb4L+F3gLjdIBZGb9LXkME=
X-Google-Smtp-Source: ABdhPJyliJObAr4tF6MXCnCS1jZfcLUkeUAIEsIcEMEblJ5vxk1/HfCR8+JpaG+PrOtqQCO+7FboMg==
X-Received: by 2002:a17:907:7ea5:b0:6e1:13c3:e35f with SMTP id qb37-20020a1709077ea500b006e113c3e35fmr2857957ejc.99.1648451521451;
        Mon, 28 Mar 2022 00:12:01 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id j8-20020aa7c0c8000000b0041934547989sm6540772edp.55.2022.03.28.00.11.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 00:12:00 -0700 (PDT)
Message-ID: <0716d9e4-24e1-d16c-162c-00a8664296e1@kernel.org>
Date:   Mon, 28 Mar 2022 09:11:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/5] Add support for Axis, ARTPEC-8 PCIe driver
Content-Language: en-US
To:     wangseok.lee@samsung.com,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "kernel@axis.com" <kernel@axis.com>,
        =?UTF-8?B?7KCE66y46riw?= <moonki.jun@samsung.com>
References: <CGME20220328014430epcms2p7063834feb0abdf2f38a62723c96c9ff1@epcms2p7>
 <20220328014430epcms2p7063834feb0abdf2f38a62723c96c9ff1@epcms2p7>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220328014430epcms2p7063834feb0abdf2f38a62723c96c9ff1@epcms2p7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 28/03/2022 03:44, 이왕석 wrote:
> This series patches include newly PCIe support for Axis ARTPEC-8 SoC.
> ARTPEC-8 is the SoC platform of Axis Communications.
> PCIe controller driver and phy driver have been newly added.
> There is also a new MAINTAINER in the addition of phy driver.
> PCIe controller is designed based on Design-Ware PCIe controller IP
> and PCIe phy is desinged based on SAMSUNG PHY IP.
> It also includes modifications to the Design-Ware controller driver to 
> run the 64bit-based ARTPEC-8 PCIe controller driver.
> It consists of 6 patches in total.
> 
> This series has been tested on AXIS SW bring-up board 
> with ARTPEC-8 chipset.

You lost mail threading. This makes reading this difficult for us. Plus
you sent something non-applicable (patch #2), so please resend.

Knowing recent Samsung reluctance to extend existing drivers and always
duplicate, please provide description/analysis why this driver cannot be
combined with existing driver. The answer like: we need several syscon
because we do not implement other frameworks (like interconnect) are not
valid.

Best regards,
Krzysztof
