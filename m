Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A524E8EB8
	for <lists+linux-pci@lfdr.de>; Mon, 28 Mar 2022 09:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237778AbiC1HKQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 03:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiC1HKP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 03:10:15 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036083337A;
        Mon, 28 Mar 2022 00:08:34 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id o10so26684093ejd.1;
        Mon, 28 Mar 2022 00:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FDWucwCLSeg6B2/VrWxzx6DUNy87uL1eammdBoI1kdM=;
        b=dYQ8pyVSm9+R+EXJWxMHCNDAfj6yAwqVO6fgNUt7IwSgMgcbIwYLErtR4ChLn15Ntm
         1D0tgI65zsb6x9b0kWDKANgzIntxEcMQFzXu+II0XCcgMNxes3rnNgskWiFXtuicFl0Q
         S2zNenNaKhXvxXpFdINWFr09JXKXExg5bcLFOJLHetsTFO/xwEVT2vgLOAQBp6dMEK5+
         W5zwsFsKNBFXQlBaZ+E2cOnC9SCxA2lmKpY2+3kjmsrGx6uugkMV9g3IkPHq6Q+EYLbY
         ScANcl1HTyVZ3sM59xOX/1uISI7taakAUoQ6dPpRBJ/HmO8tGO/K+BbY3M7OpTct6AAJ
         Sw9A==
X-Gm-Message-State: AOAM5315XjLygVs+m3Ap/YyyzCr8FRXHoD7hr2cThoQdqOvFolHWfE9I
        6St2jrIKqKnLzjgSfPR3rfo=
X-Google-Smtp-Source: ABdhPJxq7irEY8C3KlpFiXxZm7Qn0FoqyLcOgbNAdK8lwiegOS2udiGEGpmLI4I+88u1ym9l01zSiA==
X-Received: by 2002:a17:907:72c3:b0:6df:91a4:32f4 with SMTP id du3-20020a17090772c300b006df91a432f4mr26120523ejc.638.1648451312432;
        Mon, 28 Mar 2022 00:08:32 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id y16-20020aa7d510000000b004197c1cec7dsm6614300edq.6.2022.03.28.00.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 00:08:31 -0700 (PDT)
Message-ID: <74da6d19-49cd-808b-731e-386d22fb3cb8@kernel.org>
Date:   Mon, 28 Mar 2022 09:08:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/5] dt-bindings: phy: Add ARTPEC-8 PCIe phy
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
References: <CGME20220328020947epcms2p2525f40ac5157735063927aedfbf6fc4f@epcms2p2>
 <20220328020947epcms2p2525f40ac5157735063927aedfbf6fc4f@epcms2p2>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220328020947epcms2p2525f40ac5157735063927aedfbf6fc4f@epcms2p2>
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

On 28/03/2022 04:09, 이왕석 wrote:
> Add description to support Axis, ARTPEC-8 SoC.
> 
> ARTPEC-8 is the SoC platform of Axis Communications
> 
> and PCIe phy is designed based on SAMSUNG PHY.

This email is corrupted.

Best regards,
Krzysztof
