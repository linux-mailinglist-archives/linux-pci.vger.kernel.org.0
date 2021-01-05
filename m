Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25122EAC2E
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jan 2021 14:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730332AbhAENou (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jan 2021 08:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730161AbhAENou (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jan 2021 08:44:50 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC3DC061574
        for <linux-pci@vger.kernel.org>; Tue,  5 Jan 2021 05:44:09 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id c5so36214080wrp.6
        for <linux-pci@vger.kernel.org>; Tue, 05 Jan 2021 05:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mUhdkztHJYfj4ts/wyIOknJ7qzjcn2uJGVM5qK+3CQU=;
        b=iPVTSsBwwjGyoqIbexKl5FsgUy7kU3RFisePUjWeuWQ5FG3P8Vz+NsVvcmYTJXjHU/
         RQcVKc9txFoAp7pnMkg5//gYZpls2+JnOraibK6aVfaN4wC/AlK4IkdvbcvM+jjlORLu
         ycizsWQ40v6b7fBeaQD19xfRZEMWwJb0Enwl3gTVxiwPk3sgL0vGL2Z42nx3pbse5bSd
         rAEVItjgh/1pM6gsI3Ne5RaZyzhejiXHbp6wtBY2bwJ4QFGm3x+1kERe9i30GKtHI65I
         8NJvVpfLJXuqL4PDnGrs8TUt/c9IHQ7JvJ7l3bT/gw3hCwB7J3cbralNclOoj6NvxRRB
         jKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mUhdkztHJYfj4ts/wyIOknJ7qzjcn2uJGVM5qK+3CQU=;
        b=WTewIxITqT2ECuFGOQPjQrqAb6QNSRPp9jwiwfBYrumunhdUD9vBN1RJGW7KxLaABA
         eNwcVugu6nauXC1egP1cOdUEd+kRHsaC1gKFaAOLtPF13SEY8b9ZaKywXm4vabsrCJEY
         BzRu5qjArgzpR2cmLTfhnOVa4LV/tRewNz3DIPnw5dLt/9JLkAwhJr0LCCW2s3IGAtzp
         nOswJvEEN5d932tISQnPiKsxhIKmyG+v7uoaeijf4xNOQE6VWE2vcLuAYzIjCxPqQv3w
         QfFf3yQ/do5Bqny93qxdvBmEUYi2uWr31ecBWEX0yXatlm71HuIuidcH4GcpVglFPjDZ
         02Bg==
X-Gm-Message-State: AOAM530DUvomWjP+0A3Aa6bVrCvJt2DIlguSOnTMqKbeF3daWpdFk7Q9
        xI8PdoPOVJcVBZiPCgUi3qEwimFpD4k=
X-Google-Smtp-Source: ABdhPJy6xlAThV+5qXmAyY1HeEGVnLN3jEG+J3dPe2Hvce+eVmaFPsjIPhEtJb/Kb423IPcqjcCROg==
X-Received: by 2002:a05:6000:222:: with SMTP id l2mr73339059wrz.392.1609854248788;
        Tue, 05 Jan 2021 05:44:08 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:3137:60b9:8d8f:7f55])
        by smtp.gmail.com with ESMTPSA id l20sm102191243wrh.82.2021.01.05.05.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 05:44:08 -0800 (PST)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     bhelgaas@google.com
Cc:     devspam@moreofthesa.me.uk, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
Subject: A PCI quirk for resizeable BAR 0 on Navi10
Date:   Tue,  5 Jan 2021 14:44:00 +0100
Message-Id: <20210105134404.1545-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Darren stumbled over an AMD GPU with nonsense in it's resizeable BAR capability dword.

This is most likely fixable with a VBIOS update, but we already sold quite a bunch of those boards with the problem.

The driver still loads without this, but the performance isn't the best.

Do you have any objection to merge this through the drm branch?

Thanks in advance,
Christian.


