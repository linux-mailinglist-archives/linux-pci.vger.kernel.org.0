Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45864782F1F
	for <lists+linux-pci@lfdr.de>; Mon, 21 Aug 2023 19:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236971AbjHURJn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Aug 2023 13:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbjHURJm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Aug 2023 13:09:42 -0400
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD80CC
        for <linux-pci@vger.kernel.org>; Mon, 21 Aug 2023 10:09:39 -0700 (PDT)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-68a3f0a7092so1331006b3a.1
        for <linux-pci@vger.kernel.org>; Mon, 21 Aug 2023 10:09:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692637779; x=1693242579;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xohQlFLsbMM6iaJXm59IxxQv3sNu5KwrM4Gnf9yJD4=;
        b=dA53yNhfE2tnOWfoAxNvn9IHZNViZ5FrbSBMguDbfoZ3nfNKcjG+VwxPVRseek+Xf4
         L6tdK/22p3MFrG02uLv+kiI7ALoc6cmGmWyZiM8WavQCF26zqM0hA5wMh87EiiEUs5ZO
         SgxyVRnrDoc13tVJo5JYaBRgAe95ZW2210YAtMleJVSjAqdqYrn+IFOVYeO/ASo22viH
         Ey5FbG47dOBnWKSORWkFl0wlqnp3YdXkjLbE6XQ7rFdSIs2OQ3XT61rP9QmSBMysYfSU
         snacsk9Iv4yhks7KubZYR763quJm71Zhgcuv6nLtgDyuzQsWJ4/QaC/i0VYdhvxISh9g
         CUPA==
X-Gm-Message-State: AOJu0YwlZrzGOBKZYEtS0WM2ZZzhRMBST/6/A7slQjbPF7GTjaMYsi6x
        DKbTfCCdpC8Fzir3XdIXQHr7plTz7b4=
X-Google-Smtp-Source: AGHT+IHQmwoeOQ2sfDWzC4O+P3ySVPg+t2VXztMBCD0WvYxhbYnVrO7wDF8iRdCxUKO39pfzToG06A==
X-Received: by 2002:a05:6a20:2591:b0:f3:33fb:a62b with SMTP id k17-20020a056a20259100b000f333fba62bmr9614400pzd.9.1692637778750;
        Mon, 21 Aug 2023 10:09:38 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id j8-20020a170902690800b001bc56c1a384sm7257289plk.277.2023.08.21.10.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 10:09:38 -0700 (PDT)
Date:   Tue, 22 Aug 2023 02:09:36 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Linux PCI <linux-pci@vger.kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: The VFIO/IOMMU/PCI MC at LPC 2023 - Accepting talk proposals
Message-ID: <20230821170936.GA749626@rocinante>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello everyone!

Time flies! The Linux Plumbers Conference will start in about three months,
so please don't to book your attendance.

The VFIO/IOMMU/PCI micro-conference is currently accepting talk proposals,
and even though the official deadline for closing the Call for Papers (CfP)
is relatively close, there will still be time to submit a proposal later.
So, if you plan to do it, you won't have to worry. We got you covered.

As usual, keep an eye on the official conference website for updates:

  https://lpc.events

Previous posts about the MC:

  - https://lore.kernel.org/linux-pci/20230620114325.GA1387614@rocinante/
  - https://lore.kernel.org/linux-pci/20230711200916.GA699236@rocinante/

See you at the LPC 2023!

	Alex, Bjorn, Jörg, Lorenzo and Krzysztof
