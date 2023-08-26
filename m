Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6B07897BF
	for <lists+linux-pci@lfdr.de>; Sat, 26 Aug 2023 17:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjHZPfF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Aug 2023 11:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjHZPew (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 26 Aug 2023 11:34:52 -0400
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2D0199F;
        Sat, 26 Aug 2023 08:34:50 -0700 (PDT)
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-564b6276941so1037623a12.3;
        Sat, 26 Aug 2023 08:34:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693064090; x=1693668890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nB+FLP6Yh248ylMPPuO+dwGdbUuytVA8PwA3vFotAY=;
        b=dVXuRyVJIJU4r7soe44c7X3vdpNwG4n8V014gR4NV3UZsHonZOWRf3wdFU3hJknC94
         Fq+Poz+WangQUdhg1xwUhDbJGw8ha98Nx7Xvv+tW8XvJDBb/98USB8cK6WJIZDhw6WEk
         s107vvfQ5UkpyJIdk/7Xxm0as0fEbB/T6BeuPhpEQLU9MzKHzXSSaPsyZyIywyFrBI+J
         w3jG7JH9ddef7ksyQ0Qruy+TpzUCY9IeUC2CLUvbM5siucfQh9i3iccyJ2B18ywyEfiW
         jn5b/+io9tUXV+QhTzQbFMBi78ppxMfQH1qsT+0c6Qf/uPCBA/KNEltWhx2LtzAf1zkE
         Re/A==
X-Gm-Message-State: AOJu0YzDIAzHKbZYfIY2Kzvtk/Pg85hVKcmAf8AeeXcCPKJIlV++UQUM
        Y6ORudsuOYtgIpdqrt75u3ta6rGyAZM=
X-Google-Smtp-Source: AGHT+IGUJIyBcqlHfakdjA2urJWLmNNGRgF9/YfLRhOEdcACCZezbYMJ731lds+nTEAmjin9B8zkLQ==
X-Received: by 2002:a17:90a:cf08:b0:268:14a0:f8a with SMTP id h8-20020a17090acf0800b0026814a00f8amr19721375pju.39.1693064090258;
        Sat, 26 Aug 2023 08:34:50 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id fz23-20020a17090b025700b0026b4decfe59sm3659199pjb.31.2023.08.26.08.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 08:34:49 -0700 (PDT)
Date:   Sun, 27 Aug 2023 00:34:47 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lpieralisi@kernel.org, kishon@kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] PCI: epf-mhi: Really use "align" from EPF core
Message-ID: <20230826153447.GA774351@rocinante>
References: <20230826150626.23309-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230826150626.23309-1-manivannan.sadhasivam@linaro.org>
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

> Commit <15fe2e279c19> was supposed to make use of "align" parameter from
> the EPF core, but it incorrectly used the outbound window "page_size".
> Fix it!

Thank you!  Much appreciated.

I will apply and squash this against the patches I recently applied.

	Krzysztof
