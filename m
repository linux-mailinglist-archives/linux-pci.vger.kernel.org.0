Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1937DA134
	for <lists+linux-pci@lfdr.de>; Fri, 27 Oct 2023 21:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjJ0TRe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Oct 2023 15:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbjJ0TRd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Oct 2023 15:17:33 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1745186
        for <linux-pci@vger.kernel.org>; Fri, 27 Oct 2023 12:17:30 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9a6190af24aso391024066b.0
        for <linux-pci@vger.kernel.org>; Fri, 27 Oct 2023 12:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gigaio-com.20230601.gappssmtp.com; s=20230601; t=1698434249; x=1699039049; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YfXNY5+Qb2CuwFyDDH5zc72IL9f1vcKMEUozaq/s6YQ=;
        b=ScdTTsA75frR0XVHDukyQmo9IOo51/Rz7myI8iXb21GmXU0YPlCYTPaSX4+GeAXSCI
         Ww0pUAIR/BWkyupa4Jv7O4NnveE/lrQC5J1ydpqIqOTLovqNQIqsjA6Rw8Jqk+M0oiwq
         3BP8DaFSeDhiZ2yW6qSZbqKiiR6Qllt81/P8SRABX4BeeN17sbZVzpMbHlWS8Tytd8km
         nWznW6WOF4TE6TLFeiOxQH5l15IOQ1gKa80ts54NV/+DxnsgGS2K1oSBPX9zrWWWpkgD
         4yXo0vcTw0zC9bUn2+y1AzMhe9y+Gn3T+9YqGoeJPhCUo2RmZfsefntu23X0lrEKHIDN
         W4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698434249; x=1699039049;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YfXNY5+Qb2CuwFyDDH5zc72IL9f1vcKMEUozaq/s6YQ=;
        b=Qxowjg9hs739RUxpv90gLUMgkEoxvCRcTEiLODKLqqQ1PRhFXkT2JwW+whM1zQ1EV7
         dEHKjoP//h+Q8K6zieeQLlEB3yGyIsrRupmXZRnQbLRckEp3+NP9UsIb1YNRyEhrUNjT
         aeouF8MylYx6WkUTUdy5KIZ0fvFT5vuyJcxoUSr/3Jfz3EALqtIMxM+pjtoDnuDUEeO2
         HqaPqW89fp8N0Tji+k39xcV52CPiDkOZMvQ9iAI1dafqAAG3t/k9ekVnZwYo55Lx2D6K
         5Rq/0noOwMfi+gh1VJB+xKpIQ5CF/kX5qhyqPdkTxb/VY6Vb1p499KBA4E0DQDv6g9D6
         Asag==
X-Gm-Message-State: AOJu0Yxl/Hr1IGnkpDQAJQxIwN0Ieayumv4FB6afoAGwTWz5YMg/f3+P
        2w7zrMJKpX2DmqODnb6SmOeP78YXpi2ILWgEGgcTJwslWiwgITWi
X-Google-Smtp-Source: AGHT+IGb5ReXfsXF6LQQQyxWyvO9P+rw7gib+XZu1vUBzKfU6/sRg8Imq3HvjjdJf6I86ZONO/7nKbBXDyftEarLK2g=
X-Received: by 2002:a17:907:1b13:b0:9bd:ea65:7626 with SMTP id
 mp19-20020a1709071b1300b009bdea657626mr3077707ejc.20.1698434248924; Fri, 27
 Oct 2023 12:17:28 -0700 (PDT)
MIME-Version: 1.0
From:   Eric Pilmore <epilmore@gigaio.com>
Date:   Fri, 27 Oct 2023 12:17:17 -0700
Message-ID: <CAOQPn8uAWqR+0Qpk+Ua8gria06xx99ge5MnCGi4MwPOZNaXBvw@mail.gmail.com>
Subject: IOVA address range
To:     linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Eric Pilmore <epilmore@gigaio.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Need a little IOVA/IOMMU help.

Is it correct that the IOVA address range for a device goes from
address 0x0 up to the dma-mask of the respective device?

Is it correct to assume that the base of the IOVA address space for a
device will always be zero (0x0)? Is there any reason to think that
this has changed in some newer iteration of the kernel, perhaps 5.10,
and that the base could be non-zero?

I realize an IOVA itself can be non-zero. I'm trying to verify what
the base address is of the IOVA space as a whole on a per device
basis.

Thanks,
Eric Pilmore
