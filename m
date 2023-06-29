Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36C1742BEF
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jun 2023 20:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbjF2SeP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jun 2023 14:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbjF2Sd4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jun 2023 14:33:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB424681
        for <linux-pci@vger.kernel.org>; Thu, 29 Jun 2023 11:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688063530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sEw0Bsk8QlAj6U91RHWSZ/NnB5LI2BQYtqBq+pt+7JY=;
        b=f7eyJBVcOUOi5VhkHxk6U+H7gU95FJbuIDZVTBkt2aJNKdRp1Rw8/cQjooD/dch/X61NrO
        cmyzYtUucy0fFT+894/3xzaQU5F5eMgoT4d6IF83Cg53e4i5/bKRTueS7cJ0HZjrE6FkNK
        kLFc5NA+bKLbxjGvI67fmTYjgwgCgYU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-V328lp2nPfWcHTetZ-WH8Q-1; Thu, 29 Jun 2023 14:32:08 -0400
X-MC-Unique: V328lp2nPfWcHTetZ-WH8Q-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-400a393268cso12118941cf.3
        for <linux-pci@vger.kernel.org>; Thu, 29 Jun 2023 11:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688063528; x=1690655528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sEw0Bsk8QlAj6U91RHWSZ/NnB5LI2BQYtqBq+pt+7JY=;
        b=dudhtN65a7UqqESY/FUQ2Rczod2/aUIR7VONdOCARfEjgKgPaQFCcF3lQwrWuEScHF
         sAmpkSPmNpQANsFpsdIL4tSZUTU4IVmdoaD072QQq1MthGHL4sII49Inmf/gzTQSXUon
         tTidYB7pwnotngxYeFfS6MNJpHFbie1DJ/4kE3WTA1aL/VN8vzft76Ybp4AFNZ2Tv3Sf
         3PQqYYe4JxsrSFZgdv2XpI/QU3KSvI1uMFMM3tjgXRlDx0+9J1Z9WDSE1SjLkFZxX2dk
         9hI/+eR8bc54Y9Xls8lcl+1CsGUVeZf+7nwn7nUcKI/b9M7+lnxCLjovV05zqXMsfRjj
         GW+Q==
X-Gm-Message-State: AC+VfDyKbQh/7j6nJIJsmxzsDdfrrZyiOr0qHH++279Ksxn2/ojslSq5
        JPqskpQ35MJYmPQu26IpHXa2vW49YS/zLkR0PctaD9lM/c6bmzr7GjRD+iNqubofg9TG5kdXEq/
        yx75KujgauunA7+UMxbTV
X-Received: by 2002:a05:622a:492:b0:400:98e9:fd78 with SMTP id p18-20020a05622a049200b0040098e9fd78mr338502qtx.40.1688063528152;
        Thu, 29 Jun 2023 11:32:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ78TqNjd+5eMTzheDe6VAE5BvUXIN6nqFJvdd9yncJSAoVhEDPBYYWw+qBPfiybLbAn7kmw6g==
X-Received: by 2002:a05:622a:492:b0:400:98e9:fd78 with SMTP id p18-20020a05622a049200b0040098e9fd78mr338480qtx.40.1688063527891;
        Thu, 29 Jun 2023 11:32:07 -0700 (PDT)
Received: from thinkpad-p1.kanata.rendec.net (cpe00fc8d79db03-cm00fc8d79db00.cpe.net.fido.ca. [72.137.118.218])
        by smtp.gmail.com with ESMTPSA id r15-20020ac85e8f000000b00403214e8862sm2458867qtx.33.2023.06.29.11.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 11:32:07 -0700 (PDT)
From:   Radu Rendec <rrendec@redhat.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] PCI: dwc: Use regular interrupt instead of chained
Date:   Thu, 29 Jun 2023 14:30:18 -0400
Message-ID: <20230629183019.1992819-1-rrendec@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The DesignWare PCIe host driver uses a chained interrupt to demultiplex
the downstream MSI interrupts. In some circumstances, the system can get
into a state where the parent interrupt is triggered continuously, even
though reading the PCIe host registers doesn't identify any child MSI
interrupt source. This effectively locks up CPU0, which spends all the
time servicing these interrupts. This behavior has been observed on a
Qualcomm SA8540P Ride, with pcie2a and pcie3a enabled at the same time.

This is a clear example of how bypassing the interrupt core by using
chained interrupts can be very dangerous if the hardware misbehaves.
These issues are particularly hard to investigate, because the system
appears to be completely locked up.

The proposed solution is to use regular interrupts instead of chained
interrupts for the demultiplex handler in the PCI dwc driver. This
allows the interrupt storm detector to kick in and disable the faulty
interrupt. Testing showed that the interrupt storm is mitigated with no
visible impact (other than the specific log message), and the system
continues to run as expected. This is a much more desirable behavior
than a system lockup.

In a different thread [1], further advantages of regular over chained
interrupts were presented. This patch follows the guidelines set out in
that thread, and represents another real-life example of how things can
go really wrong with chained interrupts.

[1] https://lore.kernel.org/all/877csohcll.ffs@tglx/

Radu Rendec (1):
  PCI: dwc: Use regular interrupt instead of chained

 .../pci/controller/dwc/pcie-designware-host.c | 35 +++++++++----------
 1 file changed, 17 insertions(+), 18 deletions(-)

-- 
2.41.0

