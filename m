Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFDC66464A
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 17:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjAJQj6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 11:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233933AbjAJQj4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 11:39:56 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CF037385
        for <linux-pci@vger.kernel.org>; Tue, 10 Jan 2023 08:39:55 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id dw9so11556481pjb.5
        for <linux-pci@vger.kernel.org>; Tue, 10 Jan 2023 08:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f2UBCvUFmYInRwn74UFvzQNsOsFN73MDnqKsik60sBs=;
        b=tnXiGnTfFPvEcLDnbZEJF/75GpBDtWxuoh7L/szv9yMKT5/bNu4l9OKkgcDSJAZ3ry
         iXREgR6aVHEh+CFzPareSVPmyC3WKJfAs9txx2bTBj5f5qNUgKjsF4Vh6rB5nIDBxXzV
         YkuDrWIWc2tZQSwrYLWIirEVDAMxzAcXqMvKvUgkp+5MANUFS9lBNvZxxMAU0lmyV56y
         V1vfYBx9teudy3IKbiEbCsNdGhaxc3NgzA0a74UdLu01W2LbQJ8l6NUaqna90PMUp2dh
         AO1pKyrrwNw0dZe/6DVFKN4Lgd7rwXUHnkDEBdLa2q5hTUlZvDHu3cXLx/8VJQDWuogr
         ycag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f2UBCvUFmYInRwn74UFvzQNsOsFN73MDnqKsik60sBs=;
        b=2Dy0zdpEGPsEm9O4BWViWuQj//Roo8Ij29Roo/8ABvmnPfNth+dcFB9d3legfVK+Di
         GSs7KbCi5ovIhcnPMZ6eDBCIQQTC1IDkCNstBtamLznkBZ0Qd4BPOrDR/51EmrZ7g33M
         YEMx71O+EoUHpdC/gpPsUKif0jY2t22pMYnKpJ3vXG9mrs00VIBRGTaw9npEl4Ges6SW
         G/63yHHCYbswA6XQZ43kmVFpQMLS8QUewCNYJOvN58n2PPJ/Vn97NqZAPLgZrj0zjztk
         cvLR19PJmf07XlvIezssnrR7aOjsFgqUS4y5HRGc3sYqH7CZfmeS2Zt6xvhesN1poD6D
         wqDg==
X-Gm-Message-State: AFqh2kq9rUlvwM/dNlVjN7ZLMqoYCdlmygkMKgRZaI8ZIPqYmvc8ETrO
        DhjpSp7drO0SIHdWzgw37GR8RgdSk7uIfRMe8Tvvu17jmOQ6NA==
X-Google-Smtp-Source: AMrXdXsTJollCDt1+PW9Sqma+EGTebP4RvX8ZMYoq/6e/0ff9vgNybAoDP2M9sGdrNtWuMXVS2pTRVM6RmJbCEJWLIY=
X-Received: by 2002:a17:903:3014:b0:189:d0d5:e75b with SMTP id
 o20-20020a170903301400b00189d0d5e75bmr6139663pla.163.1673368794845; Tue, 10
 Jan 2023 08:39:54 -0800 (PST)
MIME-Version: 1.0
References: <CAJs=3_Cx1Pxg4iwLY5eWV9RVJoJ-btZVop3rHhzFmtErMJzj1Q@mail.gmail.com>
 <20230110161241.GA1507687@bhelgaas>
In-Reply-To: <20230110161241.GA1507687@bhelgaas>
From:   Alvaro Karsz <alvaro.karsz@solid-run.com>
Date:   Tue, 10 Jan 2023 18:39:18 +0200
Message-ID: <CAJs=3_BAYYqQTFgXZbX78Un_eU+tjqM2wMzXLmYWJRhyBH2+AA@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] PCI: Add SolidRun vendor ID
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     mst@redhat.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ok, I'll send a new version
