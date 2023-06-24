Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3C373CB05
	for <lists+linux-pci@lfdr.de>; Sat, 24 Jun 2023 15:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjFXNWc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Jun 2023 09:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjFXNWc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Jun 2023 09:22:32 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210A4EA;
        Sat, 24 Jun 2023 06:22:31 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1b539d2f969so11306365ad.0;
        Sat, 24 Jun 2023 06:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687612950; x=1690204950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3yKv66Eno2nz4InrGcSa4oQjUBLxGwqmhNnMLsiD3A=;
        b=jYkxTsvCXvdaeKdXqVQ9AzAfALEpPRpkTVmi4SGzXAuk0EV2TOShEGeIcuGkPaKrlC
         L5lqfZySmeJlvGicdFswu2/ieYKwG9GtEozD6Hq8VeNlvHnn1oHlrkLRoBoKd4b9xfBH
         JGM+vGegkqn8mNTyFKZQObvtAgOruUaKjszeLL4WnVvUXmmftyLu+HSD6eTJhTKH41qa
         y4kQ7LnM6HGMF2hTL2mDKaiTq2YC3dA61uXUJHk2ClcUUTJTJVtFl6RllTOjmVJNv+q4
         oNzxUg1zY9fZ6pdjnTc0NKMFqTMOBr/tuRvSqvm3Hvc18IGx83CzbFd9jDc63vSRIbYx
         HeUA==
X-Gm-Message-State: AC+VfDxO15jhHPACi1q5aMTOnSZQnLTrE8YQH0hPbHecCIGywa9Srol+
        8r6KUnyn6CQ4U4nNi/005aI=
X-Google-Smtp-Source: ACHHUZ5ihw8DUSSxLYVpUUoG3e9mMdriSZs/bJQPkKREjBXX8vfKlG+laQQpE03dAvymfD7s6z0WyQ==
X-Received: by 2002:a17:902:c202:b0:1b5:2ca9:f71b with SMTP id 2-20020a170902c20200b001b52ca9f71bmr2234015pll.11.1687612950498;
        Sat, 24 Jun 2023 06:22:30 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id y8-20020a1709029b8800b001b23eb0b4bbsm1224596plp.147.2023.06.24.06.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 06:22:29 -0700 (PDT)
Date:   Sat, 24 Jun 2023 22:22:28 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: rcar: use proper naming for R-Car
Message-ID: <20230624132228.GA2636347@rocinante>
References: <20230607204750.27837-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607204750.27837-1-wsa+renesas@sang-engineering.com>
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

Hello,

> Neither RCar, nor Rcar, but R-Car.

Applied to controller/rcar, thank you!

[1/1] PCI: rcar: Use correct product family name for Renesas R-Car
      https://git.kernel.org/pci/pci/c/e28e75e9f589

	Krzysztof
