Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8A3591C3A
	for <lists+linux-pci@lfdr.de>; Sat, 13 Aug 2022 20:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239578AbiHMSQm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 13 Aug 2022 14:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239428AbiHMSQl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 13 Aug 2022 14:16:41 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A3B645C;
        Sat, 13 Aug 2022 11:16:39 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id h21-20020a17090aa89500b001f31a61b91dso11061133pjq.4;
        Sat, 13 Aug 2022 11:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=AmRTB/8gR2ig8PJCGq+w2ZIymDcFBpWMH5rqLXrLQn4=;
        b=JMtVM4ynZ7hKejPYxodRZ4RpccUzJBYB+X+2VQpzaABJNA3DA7BMrVJUUyB+M+uFtk
         P1be/l861D4OMa+gffj33PjRqCOZReKy2FMBJep3xAFXdl6cSjqMhRDbDmQa2IhZk84O
         xEStOgwkPhKMh212k6dqwxZic4I3JxbNDEmRcMx4agKp8vpOqxSJmQ7nltW3NKk9vJeP
         nqAsVdMlFgB0beoUdwnzbiyXWtJaDKrIuGp/kvXErUTG2BbgUfK6VIeknR/8cV4ogara
         2hx9RC9sM4oG4Q5XcG69oxnEznNyPJB3Ij85Cb96jBtG1kkhUJ3ab4Pe9juxbAuCBErq
         z5rQ==
X-Gm-Message-State: ACgBeo3lgsfaAznJK/APvGbNCW2itgBKtTzfYhRd/1tXPuNp4MSzPZD2
        iTKLvFjBC2/avUqKeKgmEiuMffsceHz5xg==
X-Google-Smtp-Source: AA6agR5wQaJRK0e7xQm9qfm5QxyEBBSxIl2hjDwXZPh/g0UE2k/bZWhgmYX7mgkf4jyndvNnGQFXOg==
X-Received: by 2002:a17:90a:b007:b0:1f1:d31e:4914 with SMTP id x7-20020a17090ab00700b001f1d31e4914mr19876174pjq.36.1660414599266;
        Sat, 13 Aug 2022 11:16:39 -0700 (PDT)
Received: from rocinante (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id t7-20020a634607000000b0041b5b929664sm3250038pga.24.2022.08.13.11.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 11:16:38 -0700 (PDT)
Date:   Sun, 14 Aug 2022 03:16:33 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Zhuo Chen <chenzhuo.1@bytedance.com>
Cc:     ruscur@russell.cc, oohall@gmail.com, bhelgaas@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, lukas@wunner.de,
        jan.kiszka@siemens.com, stuart.w.hayes@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] PCI/ERR: Use pcie_aer_is_native() to judge whether OS
 owns AER
Message-ID: <YvfqgWB9h+7Xj1tH@rocinante>
References: <20220802040830.28514-1-chenzhuo.1@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220802040830.28514-1-chenzhuo.1@bytedance.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Zhuo,

> Use pcie_aer_is_native() in place of "host->native_aer ||
> pcie_ports_native" to judge whether OS has native control of AER
> in aer_root_reset() and pcie_do_recovery().
> 
> Replace "dev->aer_cap && (pcie_ports_native || host->native_aer)" in
> get_port_device_capability() with pcie_aer_is_native(), which has no
> functional changes.
> 
> Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
> ---
> Changelog:
> v4:
> - Use pcie_aer_is_native() instead in aer_root_reset().
> v3:
> - Simplify why we use pcie_aer_is_native().
> - Revert modification of pci_aer_clear_nonfatal_status() and comments.
> v2:
> - Add details and note in commit log.
[...]

A similar change has been proposed in the past, and back then, Bjorn had
a few questions and concerns.  Have a look at the entire discussion:

  https://lore.kernel.org/linux-pci/1612490648-44817-1-git-send-email-tanxiaofei@huawei.com/

If you think that the proposed changes are fine and can address some of
Bjorn's concerns, then it would be great.

Thank you in advance!

	Krzysztof
