Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE1B7372A3
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jun 2023 19:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjFTRWE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jun 2023 13:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjFTRWD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Jun 2023 13:22:03 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D028DC;
        Tue, 20 Jun 2023 10:22:02 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-341dd309b6fso23550985ab.1;
        Tue, 20 Jun 2023 10:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687281722; x=1689873722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZzArzRV9yR1n8VbuBTY+7vvGWbg9qkwrVAJHEY9NNQk=;
        b=X0uc0P5eStFazRju5uNUCGvgoUQjEXrTuZmAbJ5cHVYeFS7vLlD4EsEUp39H7meU5I
         2TLlooNX6f+n/Gj7cN6FAQ/TlNSmcjtIiZGLur8ElRlzZEjFmeMao2Khqfe7tZKzN8/D
         638rhCj82Z3B1py9v0ShR/IzPPCgWJmk9U2UCLoma5jbcUnXfM1YxOpxvnijFuRvtKMz
         9323Q60oCuO+v415WXWvhw2kWnuJEhdGlR6u4gambwx86kVeAnuVAygepUwsRAUQGDKj
         8DbuI+wZedzmvQAsjHpEMA501LZePqCDQtkUwwGZs5ts14WXGM6qxt9niZunCG35bjAt
         pqnA==
X-Gm-Message-State: AC+VfDxfjMipe1T1bIbh2vUZmwGea9tu4DKD8CvMmD2pGQpJx7gLV5NS
        La4Qp3NsGvVT1jsI4NhZSA==
X-Google-Smtp-Source: ACHHUZ6hfk+zVOKl7DLQhfEUaoMDMo+kVVI9ImHz54JzzMg4HMzi6mdhb4jWHiyvv+6DTs38E9XflQ==
X-Received: by 2002:a92:da83:0:b0:341:da26:d2f4 with SMTP id u3-20020a92da83000000b00341da26d2f4mr12636140iln.23.1687281721777;
        Tue, 20 Jun 2023 10:22:01 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id c5-20020a92d3c5000000b0034202d05fadsm718889ilh.72.2023.06.20.10.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 10:22:01 -0700 (PDT)
Received: (nullmailer pid 3851810 invoked by uid 1000);
        Tue, 20 Jun 2023 17:21:58 -0000
Date:   Tue, 20 Jun 2023 11:21:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Simon Xue <xxm@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH v1 3/4] dt-bindings: PCI: dwc: rockchip: Update for RK3588
Message-ID: <168728171828.3851756.10954343791219685425.robh@kernel.org>
References: <20230616170022.76107-1-sebastian.reichel@collabora.com>
 <20230616170022.76107-4-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616170022.76107-4-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Fri, 16 Jun 2023 19:00:21 +0200, Sebastian Reichel wrote:
> The PCIe 2.0 controllers on RK3588 need one additional clock,
> one additional reset line and one for ranges entry.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../bindings/pci/rockchip-dw-pcie.yaml           | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

