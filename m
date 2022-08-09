Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A3558DF94
	for <lists+linux-pci@lfdr.de>; Tue,  9 Aug 2022 20:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345002AbiHIS6a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Aug 2022 14:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345004AbiHIS6F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Aug 2022 14:58:05 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF128558C3
        for <linux-pci@vger.kernel.org>; Tue,  9 Aug 2022 11:29:46 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id c19-20020a17090ae11300b001f2f94ed5c6so1701381pjz.1
        for <linux-pci@vger.kernel.org>; Tue, 09 Aug 2022 11:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=163qEyrFx4Po9cMxG1NPhKW+M3ArfI4t125qk2iYlgg=;
        b=saa6zYx+Ld03TdrLPNVfj7sOs/BUYKVDXrJtkU+IPnuphRLhktKigxFfQBOa0Wswgz
         ba6knkO9aJIm+3kodJtUrLSjUWH0Iu2iQ3a9siNg+T+1lazeieEll+x38GDFlJHVl6es
         60QDxJqDVudbIZItbtkjWUP/kU0ef/b8LnoXD0YtQB6YDsReHc7B7khHyNBEevcNV+bg
         bylA2ZuX+yiur/RONkVLtGHq8B16WrcTpJOut5+AAsvMCjOrmgLAV4AZwp7vP8kpUUrB
         A156YmqRE19XYhetpPbI1pVJZB3YVkXD2NinhSasZlBm3M4za/84H7iA/aS/tH8CrsjU
         f8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=163qEyrFx4Po9cMxG1NPhKW+M3ArfI4t125qk2iYlgg=;
        b=dA4+QF/MLVwfhJ7sOPQ967GyynfQhlTuQdnyyt1f7u966cQrY0+mVzP1ge33ZD51LE
         xevPrAPaQphZFd8dMAlACykzluLIc3u7AiOXtbqucFZBalUzOwPL50R+WWKXqmuUO/IY
         zGJ2oVeIq8tNHR0DuupyPEcd/pB5cU55SJ/mbordQKkE5/nIuBotr82OltagySgAVEt6
         KMMB7+a9rVKIJqp/IXDZme5vVzBbBmjtLsZyTa5TmpK450koUQQfFDMZBiRzsk2XUXzc
         NgqAIj25QOhMO/jAsp2KumVspsjjZ6C6SujM5ndnT4C0kwF/fg2LfVjBpFWM93Id/dO8
         7o3w==
X-Gm-Message-State: ACgBeo1bIqLuAzlJtsp1jl09cRChOd0EWp5HyGK6mVrQtxF5V3WanVn1
        y/HSb1ImJG8YUhmc9wzZGsNiAeLL9gE11w==
X-Google-Smtp-Source: AA6agR4qbG06R5GumxkwuR5EDzYiLuvZ2A/P6nE82R0wq7IDpo+uo/URu2gQuZBDTMaNQKJY0XB2KQ==
X-Received: by 2002:a17:90b:3a81:b0:1f7:2103:a8d6 with SMTP id om1-20020a17090b3a8100b001f72103a8d6mr18616981pjb.105.1660069785313;
        Tue, 09 Aug 2022 11:29:45 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id g23-20020a63f417000000b0041983a8d8c2sm8395316pgi.39.2022.08.09.11.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 11:29:45 -0700 (PDT)
Date:   Tue, 9 Aug 2022 11:29:43 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        bhelgaas@google.com, gregkh@linuxfoundation.org
Cc:     linux-pci@vger.kernel.org
Subject: [REGRESSION] changes to driver_override parsing broke DPDK script
Message-ID: <20220809112943.393684af@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This commit broke the driver override script in DPDK.
This is an API/ABI breakage, please revert or fix the commit.

Report of problem:
http://mails.dpdk.org/archives/dev/2022-August/247794.html


commit 23d99baf9d729ca30b2fb6798a7b403a37bfb800
Author: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date:   Tue Apr 19 13:34:28 2022 +0200

    PCI: Use driver_set_override() instead of open-coding
    
    Use a helper to set driver_override to the reduce amount of duplicated
    code.  Make the driver_override field const char, because it is not
    modified by the core and it matches other subsystems.
    
    Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
    Acked-by: Bjorn Helgaas <bhelgaas@google.com>
    Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    Link: https://lore.kernel.org/r/20220419113435.246203-6-krzysztof.kozlowski@linaro.org
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


The script is sending single nul character to remove override
and that no longer works.

Source code to dpdk-devbind
https://github.com/DPDK/dpdk/blob/main/usertools/dpdk-devbind.py
