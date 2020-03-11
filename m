Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8AEF18220C
	for <lists+linux-pci@lfdr.de>; Wed, 11 Mar 2020 20:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731013AbgCKTTP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Mar 2020 15:19:15 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:37138 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730807AbgCKTTP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Mar 2020 15:19:15 -0400
Received: by mail-pl1-f181.google.com with SMTP id f16so1543028plj.4;
        Wed, 11 Mar 2020 12:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AgA8NXVVreTrbc68nE5t9RxNm/CfbmPdVBm+V/xZGZA=;
        b=Ra5czn0cz8MQvrnhNDEap6qccGc/050Ie9lY8KvZSJx8DwxM1ldR4EKQSh5WEqaxyS
         xYF9hUZqIDIQT3/lMwdgozbCBLLtUHRKYiEbi4jw4duvuwQOtElG9/7wO44JP0eczHRM
         Dxsp6Bk+7yOQH4ZtBE0QVZM9RTqDk8Mwsn7lKwTiMqig9txszVT9Cf8hOh6jehBZkYGr
         1/1bZjX/DLPSpaaBK7DGubvYsRwUorTmARB3R/VM7r9hyt9bspIR8HkN3kcvc/DTY7Hr
         RBopIs3D719sXwKTDQ7EnjBQ3Skg3Sg35c8707QLuftGu777U7MWzc+ZUFUKozNZmMHR
         EkyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AgA8NXVVreTrbc68nE5t9RxNm/CfbmPdVBm+V/xZGZA=;
        b=OfEI5tVw70NbNwDWTNgzMKnxkresNMK6QtkayJQ2zwo3cMn8YdrIMBpr/CLCwcvki9
         vDfFQpG5KN8Nx1zhE+SVTvNHwxz9++VH7jnpOoqaIk+vF8aYU3jGFeVXlwb4uM8yYa6q
         CEIxtKCe9I4QdMRM4Uwy0qMjhaO5vZ+Gor6NUGYBBSVvJko9+jXN0QZXAdn1GXKW1A7c
         UXPInVDDJAmlpJcmoa/+gu5HixFK17/jsDZ8fOi/Xl1KTDtTj0OiIndtGWPiz7smPYSo
         TNSAF8Gy5EV6VxBQK5dTbv1i/txaIwfKAN20kO3v9JqNnYOoMTzqIgnmeObCfUwlaAkc
         p7gQ==
X-Gm-Message-State: ANhLgQ1ObXuP0kGb+m7TwprnAYsVamYHDdMGhgPSHYEwONbjm2/Eqndk
        RiKrCzVP+Slz2+iZU0HlOZM=
X-Google-Smtp-Source: ADFU+vut6cvW5Ep/5MnHwgb71GM6QOKN+GXWUmMoSF0wCH4v2hNV7CL9paPgi4pfd+r34U5ISQ9Azw==
X-Received: by 2002:a17:902:b10c:: with SMTP id q12mr4569032plr.303.1583954354047;
        Wed, 11 Mar 2020 12:19:14 -0700 (PDT)
Received: from localhost.localdomain ([103.46.201.94])
        by smtp.gmail.com with ESMTPSA id z17sm3792673pff.12.2020.03.11.12.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 12:19:13 -0700 (PDT)
From:   Aman Sharma <amanharitsh123@gmail.com>
Cc:     amanharitsh123@gmail.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH 0/5] Handled return value of platform_get_irq correctly
Date:   Thu, 12 Mar 2020 00:49:01 +0530
Message-Id: <cover.1583952275.git.amanharitsh123@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As mentioned by Bjorn Helgaas in a private mail, the return value of
platform_get_irq must be checked against the conditon of strictly
smaller than 0 and if check must return the value recieved from
platform_get_irq rather than any other macro like -ENODEV.

Aman Sharma (5):
  pci: handled return value of platform_get_irq correctly
  pci: added check for return value of platform_get_irq
  pci: handled return value of platform_get_irq correctly
  pci: handled return value of platform_get_irq correctly
  pci: added check for return value of platform_get_irq

 drivers/pci/controller/pci-aardvark.c  | 3 +++
 drivers/pci/controller/pci-v3-semi.c   | 4 ++--
 drivers/pci/controller/pcie-mediatek.c | 3 +++
 drivers/pci/controller/pcie-mobiveil.c | 4 ++--
 drivers/pci/controller/pcie-tango.c    | 4 ++--
 5 files changed, 12 insertions(+), 6 deletions(-)

-- 
2.20.1

