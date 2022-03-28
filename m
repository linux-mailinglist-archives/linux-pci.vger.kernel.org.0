Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365CE4E979B
	for <lists+linux-pci@lfdr.de>; Mon, 28 Mar 2022 15:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240245AbiC1NKy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 09:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242984AbiC1NKk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 09:10:40 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D092706;
        Mon, 28 Mar 2022 06:08:45 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id z92so16817527ede.13;
        Mon, 28 Mar 2022 06:08:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zKU7dcPQqrzvad7hCDksyWL9/bxBhGy75hbbfKW8UQY=;
        b=QkoBo2QHxG2156gS/i+Z0h8Nvs4+eChijQon2rZRJzniPGV3fBlKlUM1l9GW0tcGXj
         7Hhk0Tba/Mqg++cglzSETeDioA57AdJYB3AIMyjPCUNa6gM47viVw5WVtmjcXR/DRcMO
         2kv5KlahTXTLWNXAov+vqPXbdzKqY9ceP3mNBdQ9VLOUBLP8fuecY8g0HRcxmBQ9Q0lY
         1Achb/UMDvaSxeZ2WEVWdvJV11/6zJS+0TT9IOo32svDZVlhdVqmkriePcFNP6sMd+/D
         aK9kXEhE1zf3eTIOrb/MlloN72fO+tqTcrXd+JXkBjmCT5EUTeIVrcmf7ZW53Z5HovMa
         B0og==
X-Gm-Message-State: AOAM532XJsvHTUoZPV9zvSNintDrGFd3r8oLdUkjQ2o3T+v540OD2vGY
        dvp1KKpD6SZnSKxIrMJXohY=
X-Google-Smtp-Source: ABdhPJxlgo+UgbH0M14lZEhBkIm04LSbc7VOhK2JBw82e42uIBhhCIiSHUQDD3W4GCC7jAEztHrQBg==
X-Received: by 2002:a05:6402:1c1e:b0:416:5b93:eacf with SMTP id ck30-20020a0564021c1e00b004165b93eacfmr16467238edb.302.1648472924228;
        Mon, 28 Mar 2022 06:08:44 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id d4-20020a056402000400b00412d60fee38sm7004246edu.11.2022.03.28.06.08.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 06:08:43 -0700 (PDT)
Message-ID: <da2351be-1fca-4269-cb7b-9dcd6a01b2dc@kernel.org>
Date:   Mon, 28 Mar 2022 15:08:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/5] phy: Add ARTPEC-8 PCIe PHY driver
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
References: <CGME20220328021832epcms2p6b6294b824c64404c437d0fd7f09369a4@epcms2p6>
 <20220328021832epcms2p6b6294b824c64404c437d0fd7f09369a4@epcms2p6>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220328021832epcms2p6b6294b824c64404c437d0fd7f09369a4@epcms2p6>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 28/03/2022 04:18, 이왕석 wrote:
> Add support Axis, ARTPEC-8 SoC.
> ARTPEC-8 is the SoC platform of Axis Communications.
> This is based on arm64 and support GEN4 & 2lane.
> This driver provides PHY interface for ARTPEC-8 SoC PCIe controller,
> based on Samsung PCIe PHY IP.
> 

You already sent it on 28th of January and did not respond to my comments.

Please do not resend same/similar code, but instead respond to comments
received earlier.

Best regards,
Krzysztof
