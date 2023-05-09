Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4F26FC414
	for <lists+linux-pci@lfdr.de>; Tue,  9 May 2023 12:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbjEIKjN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 May 2023 06:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbjEIKjM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 May 2023 06:39:12 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF27B19A1
        for <linux-pci@vger.kernel.org>; Tue,  9 May 2023 03:39:11 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3f38956ffdbso15891491cf.1
        for <linux-pci@vger.kernel.org>; Tue, 09 May 2023 03:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683628751; x=1686220751;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=opeeHjTpE8hf7IkSOrjrz4V6UTxg/7z0lzjIXtvA3kY=;
        b=Ha8yslMinv6gOBVO/lcrLrH1IuvYZ1gnn7kieHBrb/XDG8/1s9ZK8Hhkv6ZeUzfCYf
         XKu0EM/s+UaNnsCV0YaViDMqZzlFfvPCda0/aG9iAgCx0ielbFEouClO1aMjz660/Os+
         5EgebudrxsBLvIWELN46weK478AkeqXJe8AXw/Aa/hikpMJ+W0RJz7884wcYHC9OkU3g
         2LXgaelQOtVs7zEOXFlBZLHyzyUrel51QrVJzdVFAV2O5SAr0ooKPR4S9q54qSs7yI5D
         1OPjIm7xi5z9oLSxRuhymL3szShLsFGu1J3wenAMafod6GZRL+j3+HUYn8WIe9Xxyiz+
         C1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683628751; x=1686220751;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=opeeHjTpE8hf7IkSOrjrz4V6UTxg/7z0lzjIXtvA3kY=;
        b=Rt7fYvN+j1RbOsgMDMjZTcBIZ6t3LW9Wn7WeDNVv12qdRHqcnTsw6EOzaZznegUsK6
         LIC670ibxTmSDmF77SrxujlhRLsBb0ndq2SzqtE0bQDwdC+Ys7VmVc7W/lc8bY8etAAt
         KN+pWmeR4+3fFmbC+mZtYsM3lbIYumCs7kEWKkqcf0TI9a5FZZtHAd9BUwqdlB9HIwvH
         wHNdMmxa7xmrjPi7PkJJmLP1v8Phgb//Lqd7beCz4JR/5GvwPDukAIz4Lwp0nN69cf1i
         HcxBMn+yroVyEKrqb+AqfXMM88j/E+Foguc3L2X0a429PDSxjRLRG+2jxqbyePvldoBw
         Gv/g==
X-Gm-Message-State: AC+VfDx3pM8YpaLNcPRatNckh6eHfHrIlgVcJ78y6Tqat1j6HqNRDr53
        XzCkcOJyYU8pUa3x50nswfY197sDKMJWFqvm4MU=
X-Google-Smtp-Source: ACHHUZ4tpxlxZU6i9SZ0ZVGoAJzHgYT/rTbM5b7ODuBKEL35zYNTQBhDE4SAoB8aLWYVnCmn3A2qbw59/TswLmk2K8k=
X-Received: by 2002:a05:622a:286:b0:3f3:8ddc:d760 with SMTP id
 z6-20020a05622a028600b003f38ddcd760mr9859421qtw.12.1683628750848; Tue, 09 May
 2023 03:39:10 -0700 (PDT)
MIME-Version: 1.0
Sender: didiekodjo@gmail.com
Received: by 2002:a05:622a:150:b0:3f2:8f3:5f76 with HTTP; Tue, 9 May 2023
 03:39:10 -0700 (PDT)
From:   Kayla Manthey <sgtkylamanthey73@gmail.com>
Date:   Tue, 9 May 2023 10:39:10 +0000
X-Google-Sender-Auth: Tw0XzwO6MP-YGbBgFI-kL7zGDpc
Message-ID: <CAB56QimTUkPER-4fN=1j2114zzvo2DvfoBCPSdQg8DN71NZE1A@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello, please did you receive my previous email?, thank you.
