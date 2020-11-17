Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E4A2B5970
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 06:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbgKQFox (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 00:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQFow (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Nov 2020 00:44:52 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373FDC0613CF;
        Mon, 16 Nov 2020 21:44:51 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id y22so9640751plr.6;
        Mon, 16 Nov 2020 21:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i94+E5h3prUpXJMLneKcuPsyNNdqYemplY0Whp5G7XE=;
        b=n7cbm+F7wxT7QRUDDlFn02n5oPgODXXyRwLHHU9eEXGlQ7IDZh0CcAVlQV1kATKqTw
         H58E65s+wRaxqDLSdPkxPKV68X5w31FUcQTpbtblCEZijfJe/sV3QVV8B73O9BlrVYks
         MDP3VIbPbhQckBRmsG0ljQrDpe2Q3YErgmmtkoSwRh0t6Y5iFmzt6Y70/O7kzn4iTkMy
         b+hoMUKgdetTT4nbKKS6tbhNeRZmT5HmTa/jWys0zctoIyf4XeTfACMod+EbSgmZNiam
         KtxoeSg2aXSC3EXzAmqesRG7fWr+T062rlqe0hf6ctQg9kQnytdwWvVoivqPv28Gj3mN
         dQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i94+E5h3prUpXJMLneKcuPsyNNdqYemplY0Whp5G7XE=;
        b=NDxCFbKe3thka1E0K1SPKx5cUCLqpzD7lpMi4bYXIC19UHHCvT5z3pORgCi++zRT/2
         XXoLhbVdVPsXn97IEDetGtDFk8uvkFYxwVQ0pbcWtVb4zkYID67yl/Xx7RqvOF3sb5q9
         F4WiEw530EUZOHB2qSojIkez9tEs4app4SzWyTMbmB3TTDwUePc4dMLQO16at+FPAiZ+
         Z3G2PWc0yOTa4ChAOquGHYrG21xYC1BqsF/MUjOK9yaHZW53kW3wvGvY9J1p5E+yxdpP
         Vn0o692Er5US+CaxhIV2XaAiNSZE5Q9RXAyZQuFzctx4pE0SXwsGHNVId28tJDhcK4Fk
         A2Tw==
X-Gm-Message-State: AOAM531GdYcUZdvVObHpyQ1HJyBnCd/GCEJvZk+Q6ZfjDEVOqUzRyn0s
        y7BPqdx2glc/yzZGkBuAVbfXqDdY3rY=
X-Google-Smtp-Source: ABdhPJybx6TXlKHXnkj+hcsxwuOi4RxfcHWiP/ORYDGNSK3qTLO2GPMP7ruRi+2bfSVSqd3QsgTPOw==
X-Received: by 2002:a17:902:ab98:b029:d8:c5e8:978a with SMTP id f24-20020a170902ab98b02900d8c5e8978amr15686488plr.56.1605591890348;
        Mon, 16 Nov 2020 21:44:50 -0800 (PST)
Received: from ZB-PF0YQ8ZU.360buyad.local ([137.116.162.235])
        by smtp.gmail.com with ESMTPSA id m3sm20392462pfd.217.2020.11.16.21.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 21:44:49 -0800 (PST)
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com, hch@infradead.org,
        alex.williamson@redhat.com, cohuck@redhat.com,
        Zhenzhong Duan <zhenzhong.duan@gmail.com>
Subject: [PATCH v3 0/2] avoid inserting duplicate IDs in dynids list
Date:   Tue, 17 Nov 2020 13:44:07 +0800
Message-Id: <20201117054409.3428-1-zhenzhong.duan@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

vfio-pci and pci-stub use new_id to bind devices. But one can add same IDs
multiple times, for example:

# echo "1af4 1041" > /sys/bus/pci/drivers/vfio-pci/new_id
# echo "1af4 1041" > /sys/bus/pci/drivers/vfio-pci/new_id
# echo "1af4 1041" > /sys/bus/pci/drivers/vfio-pci/new_id
# echo "1af4 1041" > /sys/bus/pci/drivers/vfio-pci/remove_id
# echo "1af4 1041" > /sys/bus/pci/drivers/vfio-pci/remove_id
# echo "1af4 1041" > /sys/bus/pci/drivers/vfio-pci/remove_id
# echo "1af4 1041" > /sys/bus/pci/drivers/vfio-pci/remove_id
-bash: echo: write error: No such device

This doesn't cause user-visible broken behavior, but not user friendly.
he has to remove same IDs same times to ensure it's completely gone.

Changed to only allow one dynamic entry of the same kind, after fix:

# echo "1af4 1041" > /sys/bus/pci/drivers/vfio-pci/new_id
# echo "1af4 1041" > /sys/bus/pci/drivers/vfio-pci/new_id
-bash: echo: write error: File exists
# echo "1af4 1041" > /sys/bus/pci/drivers/vfio-pci/remove_id
# echo "1af4 1041" > /sys/bus/pci/drivers/vfio-pci/remove_id
-bash: echo: write error: No such device


v3: add a separate patch to process dependency issue per Bjorn
    make commit log more clear per Bjorn
v2: revert the export of pci_match_device() per Christoph
    combind PATCH1 and PATCH2 into one.

v2 link:https://lkml.org/lkml/2020/10/25/347

Zhenzhong Duan (2):
  PCI: move pci_match_device() ahead of new_id_store()
  PCI: avoid duplicate IDs in dynamic IDs list

 drivers/pci/pci-driver.c | 146 +++++++++++++++++++++++------------------------
 1 file changed, 73 insertions(+), 73 deletions(-)

-- 
1.8.3.1


Zhenzhong Duan (2):
  PCI: move pci_match_device() ahead of new_id_store()
  PCI: avoid duplicate IDs in dynamic IDs list

 drivers/pci/pci-driver.c | 146 +++++++++++++++++++++++------------------------
 1 file changed, 73 insertions(+), 73 deletions(-)

-- 
1.8.3.1

