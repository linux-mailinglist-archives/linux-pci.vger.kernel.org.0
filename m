Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB09F788EF2
	for <lists+linux-pci@lfdr.de>; Fri, 25 Aug 2023 20:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjHYSvt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Aug 2023 14:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjHYSvo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 14:51:44 -0400
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82591BD2;
        Fri, 25 Aug 2023 11:51:42 -0700 (PDT)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-68a410316a2so1059733b3a.0;
        Fri, 25 Aug 2023 11:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692989502; x=1693594302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jK7KD8HF4PhBc+cTqfWRNS12aut4EeqmSJ9uZlCQTS4=;
        b=j8/2bG+KneD+xvHrdd6FPkex/OT2piEuvTzXIrxpFeU42ySnQHkTxkOhLWpl/LLcZs
         OjR/W2NzdZ27elBupCDR3CUiPrcEJZW2NKVUgdfoiHjlWBsExsNnsAGPQwkKc1E1YGuh
         +p643DtanWQXQaawrosc5IMEHo2SkVXStSTSE792PzPoGsb3PH7xVmWc7R8bj/stmoO8
         CdMduM82Mg3YeEbioanfed5xJWCxqzIcIBtf3LpwrHwfYdhlG0uxX3DFTsvWwabr/lcf
         kCMw1BQeDVIvki8xScO39OCoQ7a7HZxkojmqFxhFC8M5mwlQZf3H4jYroT++OdCrYY74
         ov1w==
X-Gm-Message-State: AOJu0YzsfaGQqjPhayEwb4n6khXYBLsDPrTFU86Cnh3j6ksbkCmWlY0y
        8wGEo5IWh+pnpILj1KNotLc=
X-Google-Smtp-Source: AGHT+IFmcnlS3VBsWnTplhrPL0WM6frgzGzBegYlGQBjcSUOr8KxYSgf1h8BlPYi+CSzCX3cNts1nw==
X-Received: by 2002:a05:6a21:999f:b0:14c:d5d8:9fed with SMTP id ve31-20020a056a21999f00b0014cd5d89fedmr162958pzb.54.1692989502152;
        Fri, 25 Aug 2023 11:51:42 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id t21-20020aa79395000000b0068be3489b0dsm1961572pfe.172.2023.08.25.11.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 11:51:41 -0700 (PDT)
Date:   Sat, 26 Aug 2023 03:51:40 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, mani@kernel.org,
        quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        dmitry.baryshkov@linaro.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] arm64: qcom: sa8775p: add support for PCIe
Message-ID: <20230825185140.GD131548@rocinante>
References: <1689960276-29266-1-git-send-email-quic_msarkar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1689960276-29266-1-git-send-email-quic_msarkar@quicinc.com>
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

> Update the relavent DT bindings for PCIe, add new config to the phy
> driver add pcie and phy nodes to the .dtsi file and enable then in 
> board .dts file for the sa8775p-ride platform.

Applied to controller/qcom, thank you!

[1/4] dt-bindings: PCI: qcom: Add sa8775p compatible
      https://git.kernel.org/pci/pci/c/9169e03946b9
[2/4] PCI: qcom: Add support for sa8775p SoC
      https://git.kernel.org/pci/pci/c/d60379d65d2b

	Krzysztof
