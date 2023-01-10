Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A6A664D72
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 21:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235152AbjAJU3F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 15:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235624AbjAJU2o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 15:28:44 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDDF65370
        for <linux-pci@vger.kernel.org>; Tue, 10 Jan 2023 12:27:43 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id p24so14406810plw.11
        for <linux-pci@vger.kernel.org>; Tue, 10 Jan 2023 12:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hnalCCYocdOc6dBKQJU+F9gTJfjhuUSpjSRGgEmHt6o=;
        b=j3FsT18CuY1oLPxlhL6paqVFRAsE4lhebHCM5wgJyrciHVCDEVjIeceKjPfaiPdrL7
         vURDctS+icRMDCz6pfDWbi2j5y28dPcphLdlDl4NszW4X65Xo606pcTcZinhAiHwodgs
         IDzgG0Z2AnB0kc1jmomSexK++LRyELFpB8kY/oo/+eMhTKGrSrLOdkUT1Ur8uNoo6YoJ
         a3Apx9J+TkJIEEEne7+vYjc34c8PA4ryBZFkJ5ICTToT3IkmwXkpCaF9TfcTCpcdrMg6
         E9uLSNS8ydPJV2Ohytbrs+dJySeCPS0qQznJAtEyEVgtlfKqViGSfqtcCYY4ROhLgJWR
         zm5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hnalCCYocdOc6dBKQJU+F9gTJfjhuUSpjSRGgEmHt6o=;
        b=t0YZfARfkMvpImJ/zND+/SUdhehEoTES6q1Xizdh09gGgCrTdQE7sxpMMuqQhMOXnk
         DAKA8f32mKxM9HwNu2CszVbU/tp9eYWY1lFNRnITPTVWTX3s9KNTQ1Lp+uLROUSz373/
         pxo6nDDVcW+xYflrTCuvMj57k+bXyvLUGd5JdAGeiBiK0xfEh6FvSNhiA7lh/5t+W6SH
         8JpCyANKwHmQIGCAFi/gb5g/7YfY4j+ePqyz7tdwWokbsKtMgdoxPwdnFbbyVvED6zCp
         JdFhX7NqlTbbKbWOd9AAtWYUbeaE3n4yDvCxDOhehMdgaRiOViyuCs9lpLiqfodXRCpQ
         /XIQ==
X-Gm-Message-State: AFqh2kqEzHJNGXz9x7+e033KDz6Pe36+gEgqE0dHKML7aTgE+CpozRPA
        aJq2JRCVxVAB6StzSnesLKMmZ/8M7TxXmMu5SMsaMqVbKn+/Lw==
X-Google-Smtp-Source: AMrXdXsIAS4tz4uevCVL2tigrpJ4P+6YeD9yn4mnyIF2KtgkuCXem6rSV1UwatuwgSg5FLNcEH/OwMb+u8P8QkTVXlw=
X-Received: by 2002:a17:903:2447:b0:18d:e541:8a6d with SMTP id
 l7-20020a170903244700b0018de5418a6dmr3509524pls.104.1673382462921; Tue, 10
 Jan 2023 12:27:42 -0800 (PST)
MIME-Version: 1.0
References: <20230110165638.123745-1-alvaro.karsz@solid-run.com> <20230110175528.GA1589047@bhelgaas>
In-Reply-To: <20230110175528.GA1589047@bhelgaas>
From:   Alvaro Karsz <alvaro.karsz@solid-run.com>
Date:   Tue, 10 Jan 2023 22:27:04 +0200
Message-ID: <CAJs=3_ApcsYnVxWvBKQ1rxsSCdWRX0Abh2CrPJLK23X+UjF7pg@mail.gmail.com>
Subject: Re: [PATCH v9 0/3] virtio: vdpa: new SolidNET DPU driver
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Beautiful, nice threading, thanks! :)
Sure, thanks for noticing the indentation issue in the first place :)
