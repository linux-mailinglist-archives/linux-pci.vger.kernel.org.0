Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BF76F2EEB
	for <lists+linux-pci@lfdr.de>; Mon,  1 May 2023 08:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjEAGuU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 May 2023 02:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjEAGtw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 May 2023 02:49:52 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E086C10E7
        for <linux-pci@vger.kernel.org>; Sun, 30 Apr 2023 23:49:51 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-77215852592so657713241.2
        for <linux-pci@vger.kernel.org>; Sun, 30 Apr 2023 23:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682923790; x=1685515790;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T9B/XIF6WUPK5eh3ELrXiV6IvluglBk9EZbQtDgwDX8=;
        b=UdiiMRT22/jUL2FbN2SRHvo8gQ9ChAkMX6pKAz3uBmKq7cbnO8ojVcR4b9c8NQ0fSc
         m82pdinywzye/vKAhOqAGuqHp1de7iEYWYMVgCNha9Ml6Vr43UKOzGU3ioknDBmn3yg6
         I7P2mikHlKokQc3xuKjELhT4XZ/ebNBPhPN4SznJGaVW+jbl9hQbjoB7vbkQc65UsfHk
         FROMPN/bRz6jnD+wJAn3VFU2Isyu3BQthRaBEPXt1605qrofU8XoLTwX/yKLsOvSUeaR
         lGfLnp03bqJJtmx0Iyxayh9RTyIt4Jbdc/762Pm94n/7Tl3u7kOMb9okM9JH6dz9gJGO
         7dWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682923790; x=1685515790;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T9B/XIF6WUPK5eh3ELrXiV6IvluglBk9EZbQtDgwDX8=;
        b=g+Oa2C+T7L6pMRifi52mtmyjS8VBe9vgBG3RYBWB3pJYCRxcVaRpRQUHJNISF8i4CH
         kgo39EG39AaG7RswW/omkMtD0MDiR4fzWi4xoYEvJpN/vjNjCndCa0ao4sRCpIe8bY6C
         usNTw549qTPpiM9oifAyy3//aKgJ+OCrqNcD785d69JKSFiBrVdM5CT8be+Zn+/Zdgk3
         skHybtwPzrP+bY3GviFSYPp00Sj4QryM8S+u7Ehh5XuUNFqe2WoyvXVpVm5Pt7GIOqF2
         POj0QdeNXv/iVg/vaF86LFJopAz056/Bxz4c50b7l4yuobKrTsIZT+Fg2E9bonFz06HO
         norw==
X-Gm-Message-State: AC+VfDzMHld6xM5e/TZT384MDpJJD9LhSh1p07xGHRifU4sHObrqW61q
        kUFQUrsS/QnIlGpRfYjxXk8bS5SKGXeazVdfoygZx9Ddx3I=
X-Google-Smtp-Source: ACHHUZ5I8DSD0wfUu3kaKHuEQzZPEjMo8d+Nrn8zHgccT+srdHCP1/+/IlsqHffz6UQMkZmOo57Dz/l/Fpu2I4VZdx8=
X-Received: by 2002:a67:f8d8:0:b0:42c:7d66:659 with SMTP id
 c24-20020a67f8d8000000b0042c7d660659mr4723709vsp.23.1682923790625; Sun, 30
 Apr 2023 23:49:50 -0700 (PDT)
MIME-Version: 1.0
From:   Ashutosh Sharma <ashutosh.dandora4@gmail.com>
Date:   Mon, 1 May 2023 12:19:39 +0530
Message-ID: <CADOvten3LND2XnKbUuEmKni7c93DPXdP99ZbW84mouGtdBSHZw@mail.gmail.com>
Subject: How to disable Linux kernel nvme driver for a particular PCI address ?
To:     linux-pci@vger.kernel.org
Cc:     alex.williamson@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

I have multiple NVMe drives of same type (same vendor and same model)
attached to my system running Ubuntu 22.04.2 LTS with Linux kernel
version 5.19.0-35-generic.I have unbound one drive from 'nvme' driver
and bound to the 'vfio-pci' driver using "driverctl
set-override"command.

But when I perform the hot plugging on that particular drive, then
after plugged in, the drive by default binds with 'nvme' driver. So, I
want to permanently bypass/disable the 'nvme' driver only for a
particular pci address/slot. I cannot blacklist the 'nvme' driver
entirely, as other drives still need to be bound with 'nvme' driver.

So, Is there any way to disable the 'nvme' driver for a particular PCI
address/slot ?

Regards,
Ashutosh
