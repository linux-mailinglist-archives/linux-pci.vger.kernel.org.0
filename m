Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868DE5F7102
	for <lists+linux-pci@lfdr.de>; Fri,  7 Oct 2022 00:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbiJFWMy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Oct 2022 18:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiJFWMx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Oct 2022 18:12:53 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FE31429B5;
        Thu,  6 Oct 2022 15:12:51 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d27so890592qtw.8;
        Thu, 06 Oct 2022 15:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YRQym+BmjNGWjvf8XZzksttuEH1tFJTiyvRpxWyrYHk=;
        b=NDl1qDq5B6tiUeqHvb4PzeUQNRpgowsl9rJsOJA9p9vFzuQxjIVA8hK+gZS02UwOI5
         Ol3oX4/3ZRw5A9h0IsFo/2kU25GmVNx8+SCK4ipjCaR9eqM5RoFfnfh3WG0A5TndnAQG
         bzo5QhGeAN1GOtiY6pE/qglIJeimIbg3GrbDN7EuPnUmsBL8odSpdT5r7Yrw/L4xhD7I
         zOJw3Y3XYLPbCH7D1qRzLIIoJf13znsJACuC6Y6QThKZ1dp+nBc+mShE7WC07L/eb+Fh
         mluKEJdgv2C3768DuePYF6Gx3RCrp+tIQixLZydEPO9rMpHFzmgoHXDj9F1wVm+DpWgp
         duTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YRQym+BmjNGWjvf8XZzksttuEH1tFJTiyvRpxWyrYHk=;
        b=mtd+wHNWd4IlWoESSDkcxtxV2FHo2SDgNhimku+gyY+r1hYLApd15ACjURk2O8DHOo
         wEcdHxNES16w9ydip0wPTNVT44xsM2i2nqtVMbMBEIWSAoUav2TOH9t3VKVF9ff236YF
         3nrPzIwxGBcCJ2Z317WSIZ1lPKgafKj0zH5acQueqel1afPzqaCok/mLC/+tzXWjDHrh
         bpk+CUuhVvxQB3sdOvR+Bo0qOyVoPrscYOMOeq58fe1vvNUyPO/JoS8kAzGTs4rOB2Bo
         KxuCJvxXMoqQz5kxaHTQxMtaQPnHUD+3WuO3ILXuKpGIjNlwvxsgKu465JMrHfhyHwBS
         k8NA==
X-Gm-Message-State: ACrzQf2jXVGUKcjpmkdDkriCjerjd+dg2uifPMLWecdN2HvLJRyOb9n5
        MjYdDdAplOf+6g7h+dvYQfYXkSI3Vz8=
X-Google-Smtp-Source: AMsMyM4fhxuRAkAaLAKjuquOsk2q0G0DC+t5TNbX7nvmKMQCZN2gr0PP2vqk+O5FV96MuPVaz1fBvA==
X-Received: by 2002:ac8:59d4:0:b0:35b:b9a4:8ff8 with SMTP id f20-20020ac859d4000000b0035bb9a48ff8mr2104125qtf.614.1665094370446;
        Thu, 06 Oct 2022 15:12:50 -0700 (PDT)
Received: from [192.168.1.102] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id fe14-20020a05622a4d4e00b0035ccd148026sm626923qtb.69.2022.10.06.15.12.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 15:12:49 -0700 (PDT)
Message-ID: <359f08db-08cf-0097-86ca-d86753fea9a8@gmail.com>
Date:   Thu, 6 Oct 2022 15:12:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v1 2/5] PCI: brcmstb: Wait for 100ms following PERST#
 deassert
Content-Language: en-US
To:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221006220322.33000-1-jim2101024@gmail.com>
 <20221006220322.33000-3-jim2101024@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20221006220322.33000-3-jim2101024@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/6/2022 3:03 PM, Jim Quinlan wrote:
> Be prudent and give some time for power and clocks to become stable.  As
> described in the PCIe CEM specification sections 2.2 and 2.2.1; as well as
> PCIe r5.0, 6.6.1.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
