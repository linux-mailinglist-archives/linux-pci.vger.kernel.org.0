Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763017E9981
	for <lists+linux-pci@lfdr.de>; Mon, 13 Nov 2023 10:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjKMJ4G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Nov 2023 04:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjKMJ4D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Nov 2023 04:56:03 -0500
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EACE10F0;
        Mon, 13 Nov 2023 01:56:00 -0800 (PST)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6bf03b98b9bso3820562b3a.1;
        Mon, 13 Nov 2023 01:56:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699869360; x=1700474160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nsc8vtXkUo5t3WVD7oZaxgFt8EkLh3VFaj+jDioq7Og=;
        b=fXS/Kqm/ryvjtYOYimE0ExuI3rfYftqidhBDGpjZDkfJOyMYxEGt/twy5gNYehD4Bg
         RP5EOUAePvmWeWlfPhC5qSejWOUM3AiHIRgplzZN1k48uXsAoPa6WF5B7jnALZE3l874
         AQEkWCmSAKdjd3DkTXUDIiGKHc5KkSGd4WZxIc1Wd1mMFDUw260LGHYkkMF7IuPeYl6K
         bJmIPN7+5XHxj2T83iBcp32ItWy65QPbIK0FewLeszLyyYNaqhO/1Mx5PAfrlBiwDJwi
         WrXj3ZhoQ3j/P+5LviJ4DhZv7J1RkL6ccsOARDTSBP/TWLHKw7+NsJU5hCtn0GFjbsx2
         d8Eg==
X-Gm-Message-State: AOJu0YzotAsYwKpEiw7YMUrWCDUsib4CyDueZav6G1BKUCZ0pY+Fcd69
        i/CvmsGTvAnE4cK9h20ufMc=
X-Google-Smtp-Source: AGHT+IFDhzdbozjxULojFhxvaungObdZ8MGXETq2opLG6Qt0hs5cmrxuZIDoBfJGwk5O9aGkhbp3gw==
X-Received: by 2002:a05:6a20:12c9:b0:17a:e981:817e with SMTP id v9-20020a056a2012c900b0017ae981817emr9039810pzg.3.1699869359937;
        Mon, 13 Nov 2023 01:55:59 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id t17-20020a62d151000000b006934e7ceb79sm3744791pfl.32.2023.11.13.01.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 01:55:59 -0800 (PST)
Date:   Mon, 13 Nov 2023 18:55:57 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: kirin: Use devm_kasprintf()
Message-ID: <20231113095557.GA1583963@rocinante>
References: <085fc5ac70fc8d73d5da197967e76d18f2ab5208.1699774592.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <085fc5ac70fc8d73d5da197967e76d18f2ab5208.1699774592.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

[...]
> @@ -387,9 +386,8 @@ static int kirin_pcie_get_gpio_enable(struct kirin_pcie *pcie,
>  		if (pcie->gpio_id_clkreq[i] < 0)
>  			return pcie->gpio_id_clkreq[i];
>  
> -		sprintf(name, "pcie_clkreq_%d", i);
> -		pcie->clkreq_names[i] = devm_kstrdup_const(dev, name,
> -							    GFP_KERNEL);
> +		pcie->clkreq_names[i] = devm_kasprintf(dev, GFP_KERNEL,
> +						       "pcie_clkreq_%d", i);

I think, the kirin_pcie_parse_port(), which is just below form this
function, might benefit from the same type of a nice change.  Thoughts?

	Krzysztof
