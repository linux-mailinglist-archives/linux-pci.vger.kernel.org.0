Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC3A7E8E21
	for <lists+linux-pci@lfdr.de>; Sun, 12 Nov 2023 05:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjKLEGt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Nov 2023 23:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjKLEGs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Nov 2023 23:06:48 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62632D7C
        for <linux-pci@vger.kernel.org>; Sat, 11 Nov 2023 20:06:39 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c509f2c46cso47033421fa.1
        for <linux-pci@vger.kernel.org>; Sat, 11 Nov 2023 20:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699761997; x=1700366797; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kEioUYpPMF3jyWrIp8chr16JNtysZPF2LImqcZglB0o=;
        b=cryYLe3d7UkFBNpjWc7Ia97tXaf9u3YXhllPgvHGBu0SaG0K3jms1bN4ASfCGm9dZB
         e8Wm5VpT11tn4VVunTMi+6MPLXMpmyrhVx2b0a62tiSAqPIWt3eKGlI1qRb/9SqgnPr9
         rC//92RbJgNWj5jjKchXTHdCbOMsEOONoNFSzznC2vgICOhftl/d3QDnkBuZqonNqZfl
         PJzfX8UOqrCWMZbDlEEOCXzxuSedug6Em+w0P05rEtrYTp2hQ94w2HoHNscd85EP7WAb
         tHDbPNOBzptrVI7CBR4JWpo+VK00OnAYSV+KEdqH52slSRxULGjX06+mQaGVBqSX6v8L
         06ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699761997; x=1700366797;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kEioUYpPMF3jyWrIp8chr16JNtysZPF2LImqcZglB0o=;
        b=tF+IBpkmCt2pOc6YJ3jjcZUFk8Vd/Y9XHK+dMmla18mNrkHzUVV7wvgjyueZ/3ZxKg
         1dBV3MbWBxX6NFbN9dRjyNbXOVyy8FhOCu5rQ9drD3UPxFw6ocLzG1HOzTKnex0EodID
         IBCfCf3X+9rlP31SZ3bVBRjqKMKZCDCvSjv7wN/B5Ks6H5W+JzLVp3Ij/WIV9LxVXolt
         NXSkfSrLs968vLOznMJY+Cp2dnIqzob53vf0Q1lAPVkFMblFzlm4TTPSqGJNInmQqWqk
         HiL++dzV3Ybq+BnneIWXOUhk8WWipK+IZBm7IzGdKE5U2i2uot8HGwjzV/geZSo6iwBf
         +J8w==
X-Gm-Message-State: AOJu0YzqN+N7+OQjK+BRDh2fE1VUo83VLHZWObCI0ffUFH9x+5gwo36U
        6HOc9oTiBe6RwDE+J4lFzAOX6ctJCFcU5n6Imm8kGHkr
X-Google-Smtp-Source: AGHT+IH4Ocw4Hq+6n7Z6BEHcwZY2XkI5o2F16tqVNwzi67EfgKpWKjcOTaiOQt90SwVLKZkswM1Ui14Hbql0Fw79rro=
X-Received: by 2002:a2e:8e93:0:b0:2c5:3339:71d6 with SMTP id
 z19-20020a2e8e93000000b002c5333971d6mr2612438ljk.19.1699761996947; Sat, 11
 Nov 2023 20:06:36 -0800 (PST)
MIME-Version: 1.0
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Sun, 12 Nov 2023 09:36:23 +0530
Message-ID: <CAHP4M8U=yiC4bOrZ28Zx7-_Ho2-2kKWt4Y3O7nLdm7gNBwiL9w@mail.gmail.com>
Subject: Queries on pci address-ranges
To:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi everyone.

I had written a (hello-world) PCI-driver couple of years back, and was
able to read/write from/to BARs.
I might have a requirement of writing more drivers, so was revisiting
the concepts.

I have some queries (we can assume no IOMMU is in the picture) :

0.
Assertion : During PCI-enumeration, the physical-memory assigned to a
BAR is always contiguous. (Yes/No)?

1.
During ioremap() of BAR-physical memory, does the (mapped)
kernel-virtual-memory correspond to

             * one used in vmalloc(), wherein the
kernel-virtual-address => physical-address
               goes through page-tables?
             * one used in kmalloc(), wherein the
kernel-virtual-address => physical-address
               *in all likelihood* requires only adding an offset?

2.
On a related front, how does ioremap() differ from kmap()?


Will be grateful for your time.


Thanks and Regards,
Ajay
