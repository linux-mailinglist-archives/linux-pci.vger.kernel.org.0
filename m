Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E27378C424
	for <lists+linux-pci@lfdr.de>; Tue, 29 Aug 2023 14:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbjH2MVZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Aug 2023 08:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235555AbjH2MUx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Aug 2023 08:20:53 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A9DE48;
        Tue, 29 Aug 2023 05:20:28 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1bc83a96067so25920045ad.0;
        Tue, 29 Aug 2023 05:20:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693311597; x=1693916397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsc/eXd2ksDIWCcyZNlH1xFKFzrxkm/1iBTO1Z+j1NY=;
        b=iuMu947+GZNsclhSEtAQ2NkZ1BS6Mfe8c+vKFhagPJobg0StFz9X4vbhCOMAn2fuqN
         WNg06GxQUyrID1moe+QMgRDYQzS20TwaizxPq8fuIFt3UvMdjxZsIO0DbOqaytgLyj/k
         FByybevFTnmCUlxeRA7gTEl1yUqNjhPZbdQL6YqmaznxTZuBeif/6AzbDJHOck7IBX3n
         TpsISkKMNmlb2/K9HP1K19nlEK+iqGcbq8nXNwnjiKiE+r02DeM7u5z0k0VczSILpbEa
         lPvg7KwMOCYz0ZwYl0xcwasCYQ5R73xFJqF7JmvTxmxq3hB0WKafdvv/O1zo2J8K7Y/A
         gc+g==
X-Gm-Message-State: AOJu0YzGJh+/9TEtcnFxDXPeeRHId2eztoUvVqD46F97v4AihN/Ev6QD
        3tvFNqjCEk3wJvUB8b//ewE=
X-Google-Smtp-Source: AGHT+IGa37Zg5bbmrUSlptVeu8agDylil0icZ88PlkM04wg5jUwBmNEBRJHEMeC4wZlIV0MoD4QwkQ==
X-Received: by 2002:a17:902:7c8d:b0:1bb:59a0:3d34 with SMTP id y13-20020a1709027c8d00b001bb59a03d34mr20058975pll.30.1693311597062;
        Tue, 29 Aug 2023 05:19:57 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902e54100b001bba7aab826sm9261999plf.163.2023.08.29.05.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 05:19:56 -0700 (PDT)
Date:   Tue, 29 Aug 2023 21:19:55 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     manivannan.sadhasivam@linaro.org, helgaas@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v10 0/4] PCI: qcom: ep: Add basic interconnect support
Message-ID: <20230829121955.GA1096024@rocinante>
References: <1689751218-24492-1-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1689751218-24492-1-git-send-email-quic_krichai@quicinc.com>
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

> Add basic support for managing "pcie-mem" interconnect path by setting
> a low constraint before enabling clocks and updating it after the link
> is up based on link speed and width the device got enumerated.

Applied to controller/qcom-ep, thank you!

[1/4] dt-bindings: PCI: qcom: ep: Add interconnects path
      https://git.kernel.org/pci/pci/c/e590ad240ff0
[4/4] PCI: qcom-ep: Add ICC bandwidth voting support
      https://git.kernel.org/pci/pci/c/0c104996e6a8

	Krzysztof
