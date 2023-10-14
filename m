Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F71F7C9642
	for <lists+linux-pci@lfdr.de>; Sat, 14 Oct 2023 22:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjJNUch (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Oct 2023 16:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjJNUcg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 Oct 2023 16:32:36 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D13DCC;
        Sat, 14 Oct 2023 13:32:33 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1c9d3a21f7aso26457145ad.2;
        Sat, 14 Oct 2023 13:32:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697315551; x=1697920351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sBJs9tve+dzw59zeRIYGGpPGIGoZbfhYPdUN5Hc2EYY=;
        b=s6niFQX897nTpZ947hEvLYX7jUS8ogNIPoAG90mdcexP0isuaWprc9mn7tybd7cYmx
         AYlGVkDrCIQd6YjobztfrXWw/l9vdP2oftkdXWH23gFyBNxYET2Z4556YIkLsRkxNlY5
         QqVch+XdWrKv9AtQzLsJAaTXinw1zY/DQNj/AHX6FN/e0nQhNa3xUyJPlGTlHB85y5o8
         MUlCq24b1QdnPa/AM22ekBPkojp7fEva1bkVQGFxWxfgpXO2iYPO9S30JIlXPvEB+cVV
         +bYHhLTPDZ5sdQC1TubuuNOhgM362nOwcdxXasm8OgmJ+guioSO/LuPtu996BJn3x/Ip
         MAiA==
X-Gm-Message-State: AOJu0YxsUeQqkxA4klZWV6oh1V5FSqLJLarm+3UfrONvWcWgiXPD4fyY
        NPBT7peeXMEPx1rFlsDvV9A=
X-Google-Smtp-Source: AGHT+IHXMcN/uQSsm82dbdeOw5O8sM1OORhXBVyFfobpmQSr4z506emE8qqDXhEkii8XiIB8cn31YQ==
X-Received: by 2002:a17:902:e80a:b0:1c6:7ba:3a9a with SMTP id u10-20020a170902e80a00b001c607ba3a9amr40010536plg.14.1697315551253;
        Sat, 14 Oct 2023 13:32:31 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id g23-20020a1709029f9700b001c74876f018sm5890433plq.18.2023.10.14.13.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 13:32:30 -0700 (PDT)
Date:   Sun, 15 Oct 2023 05:32:29 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lpieralisi@kernel.org, bhelgaas@google.com, robh@kernel.org,
        gustavo.pimentel@synopsys.com, jingoohan1@gmail.com,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 0/2] PCI: qcom: Enable ASPM on host bridge and devices
Message-ID: <20231014203229.GB1246721@rocinante>
References: <20231010155914.9516-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010155914.9516-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

> This series enables ASPM by default on the host bridge and devices of selected
> Qcom platforms.
> 
> The motivation behind enabling ASPM in the controller driver is provided in the
> commit message of patch 2/2.
> 
> This series has been tested on SC8280-CRD and Lenovo Thinkpad X13s laptop
> and it helped save ~0.6W of power during runtime.

Applied to controller/aspm, thank you!

[1/2] PCI: dwc: Add host_post_init() callback
      https://git.kernel.org/pci/pci/c/a78794562fcb
[2/2] PCI: qcom: Enable ASPM for platforms supporting 1.9.0 ops
      https://git.kernel.org/pci/pci/c/9f4f3dfad8cf

	Krzysztof
