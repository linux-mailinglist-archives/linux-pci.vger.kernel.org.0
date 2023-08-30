Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6573078DB5D
	for <lists+linux-pci@lfdr.de>; Wed, 30 Aug 2023 20:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjH3Si5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Aug 2023 14:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242462AbjH3IiQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Aug 2023 04:38:16 -0400
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8D51B7;
        Wed, 30 Aug 2023 01:38:13 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-68a3b66f350so4552348b3a.3;
        Wed, 30 Aug 2023 01:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693384693; x=1693989493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lso90RA8r0QFl8oNeSfyna4ggS/yqsLQ6/p/yWOBqw=;
        b=jC+d9WhzxFSu3PrSZBxfSvAjiFtJlZoSGo8LuLH2+LKJDGH9pXvS/48bca5zWBgSzS
         i8xRwDRZdHgzuA4Y3kaoUyZlib6ikyQmD+GmC4xpIH3hok3NiXk7gTBJwqK3dUh5tYDw
         LZqRMi7Q00j4+IuJhJwlPXtJ01SenF3aBEoNBauoY1FntSVoZV8uTLoTkqTCza40n9mN
         +/MNJPg46eBTNGpnYPiQlQOQI5H8Vw+lA96PpuqBBMNVV15Wc5BmyWZdwkRKKNnjlucL
         2tJJy6Cdb/oBu4NByhk2fSNYVzfvJGtzoI4DkEVF+DjngtQ9QCw6gNUqLjmhLoDkazMo
         j5jw==
X-Gm-Message-State: AOJu0YwYQ2A+8FUQC51IYJscKLYnS3x4CB9NWUDOKOwkzztw3JpGWWK8
        3nxc5KBXMzpgRC4UOACKlvQ=
X-Google-Smtp-Source: AGHT+IEESIUI4gHi3kgreJ6Pa4DcR+epwjv3ReGjUSKiNEj6O0829Ivdv1VFRDhNXqFV6lqq0Jt9SQ==
X-Received: by 2002:a05:6a00:181e:b0:68a:5395:7aaf with SMTP id y30-20020a056a00181e00b0068a53957aafmr1886059pfa.15.1693384692852;
        Wed, 30 Aug 2023 01:38:12 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id e21-20020aa78255000000b0066f37665a63sm9605076pfn.73.2023.08.30.01.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 01:38:12 -0700 (PDT)
Date:   Wed, 30 Aug 2023 17:38:10 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     korantwork@gmail.com
Cc:     nirmal.patel@linux.intel.com, linux-kernel@vger.kernel.org,
        hch@infradead.org, linux-pci@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] PCI: vmd: Clean up an indentation issue reported by
 Smatch
Message-ID: <20230830083810.GA227515@rocinante>
References: <20230627113808.269716-1-korantwork@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627113808.269716-1-korantwork@gmail.com>
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

> There is one inconsistent indenting warning:
> "drivers/pci/controller/vmd.c:1058 vmd_resume()
> warn: inconsistent indenting"
> 
> Fix it and remove the unnecessary if.

Applied to controller/vmd, thank you!

[1/1] PCI: vmd: Fix inconsistent indentation in vmd_resume()
      https://git.kernel.org/pci/pci/c/1bae18a3eeee

	Krzysztof
