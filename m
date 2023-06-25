Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F77973D303
	for <lists+linux-pci@lfdr.de>; Sun, 25 Jun 2023 20:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjFYSfG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 25 Jun 2023 14:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjFYSfA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 25 Jun 2023 14:35:00 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1AF184;
        Sun, 25 Jun 2023 11:34:55 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1b801e6ce85so1641325ad.1;
        Sun, 25 Jun 2023 11:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687718095; x=1690310095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7KVQuIv0V8DtSvRNaFYpILs9gFNdEYiZqxK/tch1DY=;
        b=le3DMjnLTiI1tJeW5Z395WWR/8pT2tvnTmX7dJotvubkWPcDMZosjc3D/xIOxzruC9
         5zUYBUVap5CbNsRkTCAZw22tw/STOGWIA+NfFbnZ6D0GRLLucyHC0MYe3L6gNodGmJlb
         FH52LV+KANI7mf/39sbTABJNoooe2CNtWtVYB2vEoXWJeCpq3NOr6hAa51a6r9zvTopQ
         NvcY0kCJUctiUmU6l6zSQGNu76PMzp7GXg98Gewrn8o32RFtKvhfc3tPKWgr++B763PZ
         7xeMY67rZwngBQY5f3OugwDnprxbJ9a84f2tpOVZmd/9kxREECQ9/F5+X16rppJCG6+e
         33Aw==
X-Gm-Message-State: AC+VfDw90Ely0Stbl/jroM+eH6hYuZVAVEwucbk6HAM14olpjQOlHOxa
        kHyTipSgxmT5BY1VgAL20UM=
X-Google-Smtp-Source: ACHHUZ6CRTVKAAtFbxfwopL29P5NT7jjm5c8z99T4uJtIqzdlfkJtfqi9PwMu2VcDoyjYqpPn1R97w==
X-Received: by 2002:a17:902:ab05:b0:1b6:6751:95f5 with SMTP id ik5-20020a170902ab0500b001b6675195f5mr5327376plb.25.1687718095267;
        Sun, 25 Jun 2023 11:34:55 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id kp16-20020a170903281000b001b4f77d4e7csm2742744plb.115.2023.06.25.11.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 11:34:54 -0700 (PDT)
Date:   Mon, 26 Jun 2023 03:34:53 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     mani@kernel.org, lpieralisi@kernel.org, kishon@kernel.org,
        bhelgaas@google.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] PCI: endpoint: Remove redundant dev_err().
Message-ID: <20230625183453.GB2459283@rocinante>
References: <20230607093514.104012-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607093514.104012-1-yang.lee@linux.alibaba.com>
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

> There is no need to call the dev_err() function directly to print a
> custom message when handling an error from either the platform_get_irq()
> or platform_get_irq_byname() functions as both are going to display an
> appropriate error message in case of a failure.

This extra dev_err() appears to have since been removed, per:

  https://git.kernel.org/pci/pci/c/1bf5f25324f7

Nevertheless, thank you for sending the patch over!

	Krzysztof
