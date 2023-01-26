Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B3D67D028
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jan 2023 16:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjAZP05 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Jan 2023 10:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjAZP04 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jan 2023 10:26:56 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038B383C7
        for <linux-pci@vger.kernel.org>; Thu, 26 Jan 2023 07:26:36 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id b7so2156159wrt.3
        for <linux-pci@vger.kernel.org>; Thu, 26 Jan 2023 07:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iDdaSVhd5CpA3qgDsZzi9xAHqh15/HlhGhX8YUuZLwA=;
        b=HRdDS1V/TLxjS2GGcqYHLy4Y1urFg+5UVtROC9Cioz/CF1HW8qbw0IHcrS8HcYu1ZI
         wwNTXlVC8gkCWWmjs2QHQf5Zuum5FNomWZ/xkNAx3TrYYDseEAQfxeYwp/kz8IkXgK3r
         z/UKceE9KqKqD0lpVumd64YZulgQqW4mgty0SLshKP5ljitCesUEbOOmT58UvurbP/4Q
         MFiISbBqvJJSY0Z+NfZ12/9skiEOFj3v79fZDSCmkgOQVw1N7SJ1YTr0viJGSe2E3prA
         wXLmUhdv+d+dpGifHxLcf//UGWZH38jjGIYAKU+4L9Y3QkvqZBRLQSrBlMkfM+MMkGtF
         Mw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iDdaSVhd5CpA3qgDsZzi9xAHqh15/HlhGhX8YUuZLwA=;
        b=lAq7OGr1WqwlKdKNW++cqwXFJexZhNjmljUnah2hc+q2AynQAuJaV9XujGUHQxqH+w
         2sIZ74A0v8kUqsBA4NDNbee0jnRZ54zYSBDDq0eKpddFZpo928oZJ3Pivl8YDxe0imgp
         1LUfQ+cbArE3m/zTo/sr4wpIorcGFtBOgMEgyuU9vl9EJF8RRx+qqlELexTdCSIUAmUv
         PmUnpDw8go35RQLQxR6wxKnRAyG3J95FJJu6AIBHocsL7K/cDbk73+8PIzLOhXOX7j6U
         pOyLsvAkGwYxff4VdTv6zBq9RV+fMqPcHRK5uGin3zG3K7epX8LCHeJ3kmHDe5yCf8K+
         w8iw==
X-Gm-Message-State: AFqh2koNg+1gA+iJNevlyjnCTQYm0apxz/5frFJijEBXkYJjHKolAkrJ
        Y9ZZtQNC87VZNP5bjsueuTMfrw==
X-Google-Smtp-Source: AMrXdXuP4CJtdOq/zPr2e/Xeh1e4qSoa8xWKXlc1G0/HAMne2EK5PtyYKZrwS1u4RNaZ8GVTzdWcMw==
X-Received: by 2002:adf:edd1:0:b0:2bd:c6ce:7bfc with SMTP id v17-20020adfedd1000000b002bdc6ce7bfcmr33250169wro.42.1674746794182;
        Thu, 26 Jan 2023 07:26:34 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id y17-20020adffa51000000b002238ea5750csm2032240wrr.72.2023.01.26.07.26.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 07:26:33 -0800 (PST)
Message-ID: <b2dc1a50-58d2-13a7-2773-21c649b17f1a@linaro.org>
Date:   Thu, 26 Jan 2023 16:26:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 8/8] PCI: rockchip: Fixed MSI generation from PCIe
 endpoint core
Content-Language: en-US
To:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        alberto.dassatti@heig-vd.ch
Cc:     xxm@rock-chips.com, wenrui.li@rock-chips.com,
        rick.wertenbroek@heig-vd.ch, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20230126135049.708524-1-rick.wertenbroek@gmail.com>
 <20230126135049.708524-9-rick.wertenbroek@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230126135049.708524-9-rick.wertenbroek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 26/01/2023 14:50, Rick Wertenbroek wrote:
> The generation of MSI interrupts from the RK3399 PCIe endpoint core was
> broken. The main issue came from u16 variables to be used to access u32
> registers, this would lead to shifts of more than 16 bits moving data
> out of the variable etc. Address translation for sending the MSI messages
> over PCIe has also been fixed.
> 
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>

Same comments as other fix. Missing Fixes tag, cc-stable, move to the
beginning of patchset.


Best regards,
Krzysztof

