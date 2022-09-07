Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC405AFA70
	for <lists+linux-pci@lfdr.de>; Wed,  7 Sep 2022 05:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiIGDKr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 23:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiIGDKq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 23:10:46 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CBF61D6D;
        Tue,  6 Sep 2022 20:10:44 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id n65-20020a17090a5ac700b001fbb4fad865so13386236pji.1;
        Tue, 06 Sep 2022 20:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=cQrGSKQ0Iug5FftXe2NjDnuh5bE0DYzIRBVMnIQGO5U=;
        b=PIRsCcxSjcV1wVuNoACJ1BGs8yLsoLAPjwkbyOItuhU2TOsXTbum9pwV+RWCTdtVW7
         czlAdSsdpaZ/IxORawAR2L9Rjjh743X84yJkNXwVg09p0Lk2/kGcGlUQMYzZPLcKIc7l
         l6JTPsaD7Pob8eyZVgJJwTSuqoKhvqpd2ixof+kSTtCAsTOzNKtj8pI9i+2Av1SjjyFd
         gXWfLgDkGNd4B5ShQlmpNC8Wonz4KyZ+Qvuvltk96H65RZ8dSJEfLXSZXSsPRVJKGiG9
         hm9LFdZlznkkTl87/Bt83FU+UWAJBNNYukQxkLXVbCwYHmuMbn2cgLsP66+YJ7osyHBm
         nLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=cQrGSKQ0Iug5FftXe2NjDnuh5bE0DYzIRBVMnIQGO5U=;
        b=PsQ8phSDMOUfAosSgmbHIcFPFgwM+/qVAsuFjfrl8Ve6kC747F9vqMLcqjpdnuqhVM
         snt6Hxjge1XSKsEzAySbIN1aD35cX9vqq13Gyu9UgOZQ6Bljzslbc0oZJYcsGse2fjca
         cVz4Gf3YxxGrcvi4/rCHUSnzpdLWujDIeuYllbKzRmsCfOQPnLOIMTxC4/mS4eKvsP3k
         TnVfKzqyTsNMszTqlW4g85sHDXFmHjSC0OQ1W4lz/X2iyQ+KECOCAHRkw4rG/zjdeSVB
         LLThghq6hGjqMUzv5I8rZ8CJ2ThgOVlsPxz+eAWNRzv3ETmOFOMBX+xRcjXgdlCVsEfZ
         mDaw==
X-Gm-Message-State: ACgBeo2uIbNahwhBQoXyqhS1WVWn+uD5nTiFcQRe8n12mmebEl5QBxS5
        idRSWiWr2OVXZXokhbj4K9Y=
X-Google-Smtp-Source: AA6agR7CH+gtBNHKXZtO3w+GuqtXo9rSEShmlqrB0QA1s0fCTfTW1y1k+PEeZYHn+8E9tJ1rgaKNXQ==
X-Received: by 2002:a17:90b:1b48:b0:1f4:f4e5:c189 with SMTP id nv8-20020a17090b1b4800b001f4f4e5c189mr27071344pjb.226.1662520243931;
        Tue, 06 Sep 2022 20:10:43 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 205-20020a6217d6000000b00537b8deef41sm11076025pfx.136.2022.09.06.20.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 20:10:43 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     helgaas@kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com, bhelgaas@google.com,
        cgel.zte@gmail.com, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lpieralisi@kernel.org,
        rjui@broadcom.com, robh@kernel.org, sbranden@broadcom.com,
        ye.xingchen@zte.com.cn, --cc=zealci@zte.com.cn
Subject: Re: [PATCH linux-next]
Date:   Wed,  7 Sep 2022 03:10:38 +0000
Message-Id: <20220907031038.340425-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906212520.GA45166@bhelgaas>
References: <20220906212520.GA45166@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=--subject='Re: [PATCH linux-next] PCI: iproc: Remove the unneeded result variable'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In fact,‘cgel.zte@gmail.com’ is our company's public mail address, and ‘ye.xingchen@zte.com.cn’is my personal mail address in the company.‘ZTE’ is the name of company, and ‘CGEL’the name of our project team in company.This patch was posted by ‘ye.xingchen@zte.com.cn’.

For some reason, the patchs needs to be reviewed by the company before it is sent out, and we have to use public mailboxes to send mails, because personal mailboxes are not allowed to send mails.

Because it is the patch I submitted, the mail about the patch will be sent to my personal mailbox through the public mailbox.

 
Thanks,
YE XINGCHEN
