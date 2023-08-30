Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045EF78DB51
	for <lists+linux-pci@lfdr.de>; Wed, 30 Aug 2023 20:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbjH3Siz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Aug 2023 14:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242589AbjH3JH4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Aug 2023 05:07:56 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADD6D2;
        Wed, 30 Aug 2023 02:07:51 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1c09673b006so28386565ad.1;
        Wed, 30 Aug 2023 02:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693386471; x=1693991271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMt0K9Nx/qyWZ8nyxb9sC51keiWIwpiG27r1lMoXe+k=;
        b=cyfZgwE7JM7Ljk89aI8A53Hb/LpJPqMoI8kV2idUVpijxRIZD3YaYxiMTOI5jhlODA
         jePCpp7RQ8mHX8mLAxyfHTyumwA4XRDqsVx3RhTMvn/huEZudfvv4iFxZD7kNJAFgRJc
         YNEtmmzrzgnoG+ChbnjhX1Roi1m7b3xdsq+Sy1w5qn0V1VPlApqplZ7uN3oY60p4eXEZ
         xo19pfXUGk8vpiNX2f4SGaZVpj39Qk0zcqztUfgg608JKWu0f4aQjY3d3vMFBT6CxJVh
         bBli2ydHxNZNoyKnJ2v4YJnAw6LNxrV/07/XRCsFJqLOhZ9UeEE9sk1eKgAQgBi84ob+
         mSpg==
X-Gm-Message-State: AOJu0YysLE+CgVQPWu1EB1nGOv0ROuxtejcVKucoD3aY8vLaz5GQQ+lG
        C8CuoFT6FajzU/s25y8hBZ0=
X-Google-Smtp-Source: AGHT+IHNMP/G9HuOyP12UWEg2o746OTejatuFZZ0CbkE3esMuj0fkjJMFwGmdA2hN3yZfjNw7QOQkg==
X-Received: by 2002:a17:903:1c4:b0:1bf:728:7458 with SMTP id e4-20020a17090301c400b001bf07287458mr1617276plh.58.1693386470756;
        Wed, 30 Aug 2023 02:07:50 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id p14-20020a170902a40e00b001c1f0b3e900sm4910499plq.229.2023.08.30.02.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 02:07:50 -0700 (PDT)
Date:   Wed, 30 Aug 2023 18:07:49 +0900
From:   =?utf-8?Q?=22Krzysztof_Wilczy=C5=84ski=22?= <kw@linux.com>
To:     Li Chen <me@linux.beauty>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: cadence: remove unused cdns_plat_pcie->is_rc
Message-ID: <20230830090749.GA231187@rocinante>
References: <189258d19e1.1132188131010980.7371471641115980549@linux.beauty>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <189258d19e1.1132188131010980.7371471641115980549@linux.beauty>
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

> We already have cdns_plat_pcie_of_data->is_rc.

Applied to controller/cadence, thank you!

[1/1] PCI: cadence: Drop unused member from struct cdns_plat_pcie
      https://git.kernel.org/pci/pci/c/abc6119edfe8

	Krzysztof
