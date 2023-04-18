Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3EE56E6BC0
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 20:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbjDRSKr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 14:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbjDRSKq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 14:10:46 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9282718;
        Tue, 18 Apr 2023 11:10:45 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id a23so25363122qtj.8;
        Tue, 18 Apr 2023 11:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681841444; x=1684433444;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6oYJKckFIEHAYEJaNrSiZ1xS5uvliIg0yg4Yi59YX+A=;
        b=YeZFF4H/7vWKXZYg13kf0hPx0jrQef3btpRTR+PWHwpeMkCFvi2FLLg08fGvCic6Nz
         ec6FJTEGsSCRHUUg3QMd7dLTojQ4edeFdy+Y7tkTv5LopXO0zR8DrjTooVFSi71tLaB0
         hFrnOkdEA9jAga+MCym+NFswf9tchmwiUcQ3HOYB00VKG6M9/OEq+ywMfW/urwpL3eEA
         Ky5X9pUc/iq3IIdF1Hhtfah5LeY8IqNcu1CaRRsHfp39GesSEYFs/JINXEa7cft7ygG+
         N7gizmGMnhdOWXpgY9YsYa7yhejCZ9nt8uwQ0mqttbYGbw+70Et+iOyGq4UYKI9q5u+4
         4oBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681841444; x=1684433444;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6oYJKckFIEHAYEJaNrSiZ1xS5uvliIg0yg4Yi59YX+A=;
        b=hDFAgWcfkDFbcwUyKPd+6pXOwbfhvRgLwUcCSAr4lvW2PNcjbdyJDPL3CDfFWZaAt1
         dguK4ok/VPKfoE966mgPyTG9eN6mabdCEsvtx8tIBqEjSexEqXOHnRdhAF1xBidv3DM7
         XkonCUV4ucLBfyQDGTefDo2UCBlRvMeGvVFrPizMM8EZGx6fdJjVhck8bNZOG3ktQP2O
         8HY6X24Tj0MFdbqtSegL4Y8S5in4CfTQna32vZSx/M59Ad1BxAfHNgGqfd8tQLCLD0m/
         oS9e1EWs6uqE/L5XfnUjNDDDM+0OSkS3cB5qXYVxHBasFniFtv3EhE+zrfEhauYJ0QNK
         iR0A==
X-Gm-Message-State: AAQBX9eSLoXRbmOg/Ba5USvFgPv2F7KU8u9p48OkMHumw2GeVXf6FkSp
        hdHac5Ce8wZGnHvaYPxOSNE=
X-Google-Smtp-Source: AKy350bX7fZ10LT3IHF2WqgI5t+8q66bf+5lrJwWBsWcm6mezFGIqdMkNlSzKgBx7YI3IZOyeQhQgA==
X-Received: by 2002:ac8:7d0a:0:b0:3d8:2352:a661 with SMTP id g10-20020ac87d0a000000b003d82352a661mr1311849qtb.3.1681841444476;
        Tue, 18 Apr 2023 11:10:44 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id u7-20020a05622a198700b003e39106bdb2sm4236565qtc.31.2023.04.18.11.10.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 11:10:43 -0700 (PDT)
Message-ID: <cdcd04e2-13dc-3dac-daf5-ea784af75467@gmail.com>
Date:   Tue, 18 Apr 2023 11:10:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/7] PCI: meson: Add 'Amlogic' to Kconfig prompt
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Yue Wang <yue.wang@Amlogic.com>
References: <20230418174336.145585-1-helgaas@kernel.org>
 <20230418174336.145585-2-helgaas@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230418174336.145585-2-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 4/18/23 10:43, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Add the "Amlogic" vendor name to the CONFIG_PCI_MESON Kconfig prompt to
> match other PCIe drivers.  Capitalize "Meson" to match other Meson Kconfig
> prompts.

Did you mean, do not capitalize "Meson" or did you intend to preserve 
the previous hunk that had "Meson" capitalized?
-- 
Florian

