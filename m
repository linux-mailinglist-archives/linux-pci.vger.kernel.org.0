Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F00478D2D6
	for <lists+linux-pci@lfdr.de>; Wed, 30 Aug 2023 06:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbjH3Eom (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Aug 2023 00:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240449AbjH3Eo2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Aug 2023 00:44:28 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C267A1B3
        for <linux-pci@vger.kernel.org>; Tue, 29 Aug 2023 21:44:25 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-76e09202322so324676385a.3
        for <linux-pci@vger.kernel.org>; Tue, 29 Aug 2023 21:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693370665; x=1693975465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3hO9NOFaz/1mUBeECqnfoQUWjNCzDx/SB1xB5XpDqc=;
        b=a0DZtmpEoWeKTiC9JuLWrTsszJdtIXVfRs8kqxC5mMio2tz7Fi4ho4hH+ZXh3QSDZf
         DVqX2Hz2X7KxXwbzzIhJCzYf+8n8UQgKajBFrF1U47XxAWm3q9hOUsyrfPh0tXfFl7NM
         PwM3DMBdKc6SpMSIYdPkfmt8liwWv0ltz6+vnatU59lABZbRTsZx2PW1TVL8D2oSxsvN
         TU3eJpbsbnuemaz411EowTNtb59HmXkk1Vm59sOpNdrJbtk3ocOWSXdKTsbsWupK0fJo
         Kn9Qo065YrqL0R8Pqtr9x1/Tanap2BfjV4yCX8MDtl7+ztho5hiwlfzS1ZWcB3Mm+pEm
         vB2g==
X-Gm-Message-State: AOJu0Yx/NwVobGOw61/sNqClSygSffX68gztsvLC8ifFjf0tktdLtX0R
        wCOIgSiNp2v3cd9iX8CX8wc=
X-Google-Smtp-Source: AGHT+IHRQJ40E3xfgns+BhGtEhkr6haCnVY+CvPApxZtB8G9lTgAAUEkhqDqGjGI0dE0BPDe0PVSSA==
X-Received: by 2002:a05:620a:2801:b0:76d:bc1b:c491 with SMTP id f1-20020a05620a280100b0076dbc1bc491mr1412852qkp.14.1693370664875;
        Tue, 29 Aug 2023 21:44:24 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id c2-20020a639602000000b0056c52d25771sm9621090pge.69.2023.08.29.21.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 21:44:24 -0700 (PDT)
Date:   Wed, 30 Aug 2023 13:44:22 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH -next] PCI: endpoint: Use helper function IS_ERR_OR_NULL()
Message-ID: <20230830044422.GA3282224@rocinante>
References: <20230817070932.341667-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817070932.341667-1-ruanjinjie@huawei.com>
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

> Use IS_ERR_OR_NULL() instead of open-coding it
> to simplify the code.

Applied to endpoint, thank you!

[1/1] PCI: endpoint: Use IS_ERR_OR_NULL() helper function
      https://git.kernel.org/pci/pci/c/6f6a75878e64

	Krzysztof
