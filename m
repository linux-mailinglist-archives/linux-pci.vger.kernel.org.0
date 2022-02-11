Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2164B285E
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 15:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351085AbiBKOxP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Feb 2022 09:53:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351083AbiBKOxO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Feb 2022 09:53:14 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F95188;
        Fri, 11 Feb 2022 06:53:13 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id t199so9755455oie.10;
        Fri, 11 Feb 2022 06:53:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MXSBtQnBN/MltHlZWjyxFSa4m/OhJirK2ciuvityBV0=;
        b=1X7HUfwEFdaYUHp3dxrGxpJecE2FOzPQcJaSY8RdjyqpT/b6YAdUEjdabLlrD1y0iR
         v5xbpsR0xk0twTDrlTm5V3MAFp85kfwtg1bKc8TyEae0/sBXSFHMlUJP3oHRcoOcpqm/
         eC644hd2NOec+X5voQRFxkcUr8ZvCsKZ+HFndX3l/xDJcBwpcLcJ2P8iHTKyS2IuNSy4
         Vu5v9eRzStBu32FbpSgqnCkUaUQul2tfUKa2Ehhr/Fv19vmxFBuE6+Y05to1fBVKZ7tv
         qbI9nb7MTMwbgN6gtbUlzqx1a6TZ9zFQnSLonxrgWPJZfXPMYMDmi5waTPdxP8wfpEVN
         O1Ng==
X-Gm-Message-State: AOAM531vs8rHPOH9uBiRAFsiw0DZRaMZILGCbQgGnznFQ6wtRAF/00YA
        bTGhx9L873Lb2ZGpA+u9EA==
X-Google-Smtp-Source: ABdhPJz1k5x6aAWyvzzS0MO090qB15MM3j2XrAzBRkeay25jdU3x9tuCOOapTuOKXtAdUZ9gNkkKaw==
X-Received: by 2002:a05:6808:d4f:: with SMTP id w15mr354135oik.42.1644591192688;
        Fri, 11 Feb 2022 06:53:12 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:20d7:a802:e6b0:6d9c:32f7:4bd9])
        by smtp.gmail.com with ESMTPSA id q16sm1728012oiv.16.2022.02.11.06.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 06:53:11 -0800 (PST)
Received: (nullmailer pid 349516 invoked by uid 1000);
        Fri, 11 Feb 2022 14:53:09 -0000
Date:   Fri, 11 Feb 2022 08:53:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     robh+dt@kernel.org, kishon@ti.com, mperttunen@nvidia.com,
        kw@linux.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, sagar.tv@gmail.com, vkoul@kernel.org,
        devicetree@vger.kernel.org, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, mmaddireddy@nvidia.com,
        krzysztof.kozlowski@canonical.com, p.zabel@pengutronix.de,
        thierry.reding@gmail.com, linux-phy@lists.infradead.org,
        jonathanh@nvidia.com
Subject: Re: [PATCH V1 03/10] dt-bindings: memory: Add Tegra234 PCIe memory
Message-ID: <YgZ4VaQuCSAPA3dr@robh.at.kernel.org>
References: <20220205162144.30240-1-vidyas@nvidia.com>
 <20220205162144.30240-4-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220205162144.30240-4-vidyas@nvidia.com>
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

On Sat, 05 Feb 2022 21:51:37 +0530, Vidya Sagar wrote:
> Add the memory client and stream ID definitions for the PCIe hardware
> found on Tegra234 SoCs.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  include/dt-bindings/memory/tegra234-mc.h | 64 ++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
