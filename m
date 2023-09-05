Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B267928A0
	for <lists+linux-pci@lfdr.de>; Tue,  5 Sep 2023 18:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344563AbjIEQXi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Sep 2023 12:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344557AbjIEDsH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Sep 2023 23:48:07 -0400
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23EBCC7;
        Mon,  4 Sep 2023 20:48:04 -0700 (PDT)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-68c0d4cc3a4so1185436b3a.1;
        Mon, 04 Sep 2023 20:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693885684; x=1694490484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rkgj7j4ZbMunP/6Ha7EX02abkwO7XcucMDifM971QNU=;
        b=PA2ETLRmqaqRIkH4zJuIttf1f5E5rOOWUf0GEl4wSvg+/WXcuTuXWARJvAIsx06Lru
         /1T3I2yy6RRqNugGTwnbbNyTb0lHRcIjh/ewgcAsSklIv76RAhYH9qU3NUx8rmjtpVxP
         8lZEZvwzVPTd6DU2TjjnbZ07/3REq2UJgoU7SbKx9z+CPbD7hzKeKI/iQ2WvjqgvvJhm
         Y00dP7uRKP55Z8fJpgJRym3lFDwnYlWVTAdnWhPnB0klQSANCV043dEaAn7kB3R0g1Ik
         WrsVOVVh/GbKzKFWUKNa1IREcOBMAbmGaSR1RYsRVEagBe8BYpNLywI5fzveCub+Bb9D
         LMzg==
X-Gm-Message-State: AOJu0YwSs9uzK02ur5WBdYYqiUvYE80TFXfjNWzZvqYO0bX6ZmXY7LMn
        jXCQgWV7qghmEiZJLsTavgPqkK5zidwQ2A==
X-Google-Smtp-Source: AGHT+IEWjtGfWAnaLx1Ocj5K4L0KUBha4CgvJK1Eeo+O/EIGVIPbMHldIVaOudCB5mH+/cwAeb7awQ==
X-Received: by 2002:a05:6a20:4429:b0:130:835b:e34e with SMTP id ce41-20020a056a20442900b00130835be34emr12999327pzb.48.1693885684082;
        Mon, 04 Sep 2023 20:48:04 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d1-20020a170903230100b001b7fd27144dsm8265792plh.40.2023.09.04.20.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 20:48:02 -0700 (PDT)
Date:   Tue, 5 Sep 2023 12:48:01 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        mani@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 0/3] dt-bindings: PCI: Revise dwc and rcar-gen4-pcie
Message-ID: <20230905034801.GA1102453@rocinante>
References: <20230901131711.2861283-1-yoshihiro.shimoda.uh@renesas.com>
 <20230901-squeak-pacifism-00639bfab28a@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901-squeak-pacifism-00639bfab28a@spud>
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

> > This patch series is based on pci.git / controller/rcar branch
> > to fix dt-bindings doc patches. Krzysztof mentioned that the paches
> > will be squashed everything later [1].
> > 
> > [1]
> > https://lore.kernel.org/linux-pci/20230831140426.GA255922@rocinante/
[...]
>
> A link to the comments you were addressing would have been nice.

For posterity, so it's easier to link things together:

  - https://lore.kernel.org/linux-pci/20230825093219.2685912-14-yoshihiro.shimoda.uh@renesas.com
  - https://lore.kernel.org/linux-pci/20230825093219.2685912-15-yoshihiro.shimoda.uh@renesas.com
  - https://lore.kernel.org/linux-pci/20230825093219.2685912-16-yoshihiro.shimoda.uh@renesas.com

	Krzysztof
