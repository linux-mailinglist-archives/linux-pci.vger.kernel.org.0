Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E257C9606
	for <lists+linux-pci@lfdr.de>; Sat, 14 Oct 2023 21:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjJNTcX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Oct 2023 15:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjJNTcW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 Oct 2023 15:32:22 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7E1B7;
        Sat, 14 Oct 2023 12:32:21 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ca3a54d2c4so3915295ad.3;
        Sat, 14 Oct 2023 12:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697311941; x=1697916741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKhePuOAptoWjKe6TXhvKtMSGVzQ/bretd2U0V8ZT00=;
        b=T3MIxVqTx5OQMYUB4hqV0keslkkqN4MIbRfPvi1+BRLAOWqbOA5gTZiRBLHf2rxHDx
         Asd2LULsB6jHcauFjYx/3Fmk4EINOp+RxsnqBjZYM5XrMoUjQjfvB5vVfVn/tmdCBwjV
         yMiHLDRjubcBx7IrFPF6VSyfLMZCRlxwG/Zn8VN75J2l00hz/stDhxBB28WysW1WCDpy
         LbMf8BgFHuEvkz4IvN27Fq/1A9O6FQBTbpReF8vmnQ12YH45hqgjO9c5aq/XcT/bfHNA
         IjPlGS/UuT6DrIjMd9Jv6A5ifHv9L5E373YZv1weOTt029rd560Vixmi29hb2opa3TxC
         BbGg==
X-Gm-Message-State: AOJu0YzI/H5rh3QXUKlhNjrPQ/87/jjg1+UiH3TC49YpPR1RvV80Z4gz
        jNc0qCqZM9MUf3e2yc4fGNRRfv9TDRE=
X-Google-Smtp-Source: AGHT+IGHNZ01TW5fHze65ef5i4SbgLrlTX/HXVbOOnk7AVGwyUxulRQv9DIFy9+Zq0GJ8ZNPQmI62w==
X-Received: by 2002:a17:902:c408:b0:1c5:f0fd:51b5 with SMTP id k8-20020a170902c40800b001c5f0fd51b5mr38241398plk.40.1697311940967;
        Sat, 14 Oct 2023 12:32:20 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902d2c600b001b9be3b94d3sm5840358plc.140.2023.10.14.12.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 12:32:20 -0700 (PDT)
Date:   Sun, 15 Oct 2023 04:32:19 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lpieralisi@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, bhelgaas@google.com,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, abel.vesa@linaro.org
Subject: Re: [PATCH v4 1/3] PCI: qcom: Use PCIE_SPEED2MBS_ENC() macro for
 encoding link speed
Message-ID: <20231014193219.GA1190809@rocinante>
References: <20231004164430.39662-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004164430.39662-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

> Instead of hardcoding the link speed in MBps, use existing
> PCIE_SPEED2MBS_ENC() macro that does the encoding of the link speed for us.
> Also, let's Wrap it with QCOM_PCIE_LINK_SPEED_TO_BW() macro to do the
> conversion to ICC speed.
> 
> This eliminates the need for a switch case in qcom_pcie_icc_update() and
> also works for future Gen speeds without any code modifications.
[...]

Applied to controller/speed, thank you!

[1/3] PCI: qcom: Use PCIE_SPEED2MBS_ENC() macro for encoding link speed
      https://git.kernel.org/pci/pci/c/8da2e9af0bb5
[2/3] PCI: qcom-ep: Use PCIE_SPEED2MBS_ENC() macro for encoding link speed
      https://git.kernel.org/pci/pci/c/dc2f2a9d1cf2
[3/3] PCI: tegra194: Use Mbps_to_icc() macro for setting icc speed
      https://git.kernel.org/pci/pci/c/85e9eb3e7727

	Krzysztof
