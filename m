Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8293B788EB9
	for <lists+linux-pci@lfdr.de>; Fri, 25 Aug 2023 20:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjHYS3I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Aug 2023 14:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjHYS2w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 14:28:52 -0400
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5577E210B;
        Fri, 25 Aug 2023 11:28:49 -0700 (PDT)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-68bec3a9bdbso957168b3a.3;
        Fri, 25 Aug 2023 11:28:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692988129; x=1693592929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVPjVbkeFQW+k+rS69O04AwUmTqmPJ8iKUK95i5fNeE=;
        b=fF1w4QJ2VwB0G5XFpAfz7lf3QwohA/PJ0Z2+2/eYTlYO2TGgH0wLRD09dhp2GVs3JF
         FzYVP/VQy7QiO1bUMoPLf7pb4hJW3UVO/G94F2rIq29R4CpTh72k2VZp2pAO6fc/O0Xd
         9vqpE7SBhT4r2HXmNh00tjZjS7Jh2JHEtpNw5Yv8vsBWQ0RK38BW2vcKZFrupl0SADVH
         pcpEvBthPGiPlSWhc9/zcu+gDdEknteOkmUIeEuOj7/ffzxK/v0qvMx76D7oTvwnuvo7
         LaFX3A+5QnfJ8WhQwcz28UcvKD3gIOyzHMIofOH8YwFo5RXVSrMEWdz04YnKJuwpdDyh
         RF1Q==
X-Gm-Message-State: AOJu0YzB4mT0ZjyEUyuVFsX9hJfrzqkc4hOyMIdTXw6lIhmjTHzxBiHG
        U9DQyNsvXp5YK4R9Ym5Vm2M=
X-Google-Smtp-Source: AGHT+IGsoglscHwEIlTZ9oCa6M57NI5i3jg8ZDWq9H9QWb00TMRmROKwNFAFGhVqz2Xvhx08qVK2CA==
X-Received: by 2002:a05:6a20:244f:b0:133:215e:7230 with SMTP id t15-20020a056a20244f00b00133215e7230mr18563461pzc.55.1692988128639;
        Fri, 25 Aug 2023 11:28:48 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id bm2-20020a056a00320200b00682a61fa525sm1918298pfb.91.2023.08.25.11.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 11:28:48 -0700 (PDT)
Date:   Sat, 26 Aug 2023 03:28:46 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Improvements to Qcom PCIe EP and EPF MHI drivers
Message-ID: <20230825182846.GC131548@rocinante>
References: <20230717065459.14138-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717065459.14138-1-manivannan.sadhasivam@linaro.org>
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

> This series adds eDMA (embedded DMA) support to the Qcom PCIe EP and EPF 
> MHI drivers for offloading the transfers between PCIe bus and the EP
> memory. eDMA support makes use of the recently merged eDMA DMAEngine driver
> and its integration with DWC PCIe EP core [1].
> 
> This series also adds Qcom SM8450 SoC support to EPF MHI driver that has
> the eDMA support built-in.

Apologies, I accidentally responded to an older series:

  https://lore.kernel.org/linux-pci/20230825175729.GB131548@rocinante

This series version was applied, of course.

	Krzysztof
