Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDAA11FE97
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2019 07:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfLPGrX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Dec 2019 01:47:23 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37320 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbfLPGrW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Dec 2019 01:47:22 -0500
Received: by mail-pg1-f194.google.com with SMTP id q127so3112908pga.4
        for <linux-pci@vger.kernel.org>; Sun, 15 Dec 2019 22:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YPHzDwynlmOFdAU5St+7P/aISgKvPX7+uyfwjb3J5vQ=;
        b=Q7/FsZxqSwMa+BzKGhf/87FEkHKFRHq6bnEriH4r/8faI2wq55Pf+hh6Dn/1A1L1hE
         QpDC8Tw2cEi1FMh9isaL5Wm2ZOPxXOZWcDiADyPoncHeRi4uNuQVZ3vevcMF6Zmy/s06
         xmkVNHiSNCCl1q561PMnqZFynvhDCjvRPKlbXzMKMW6IL5ryRPiH7VvsfdkMe7Zfg23b
         ZInoD7zU0DqJdxovEj9bVs8SpG+oMV7T58xRpRHQNmDSFiQ6/cgLseuSCkkXC5Tjb9Rc
         15Kg06QdQIh1L0juCm+0Wblblnt87P6qJKU6kJsjsSXtxS5uEzMSMllQ/53QAInBoJnm
         HzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YPHzDwynlmOFdAU5St+7P/aISgKvPX7+uyfwjb3J5vQ=;
        b=MYP3jgkmQ0PPl+oIEEVdKl0HpOS1e7x4iolB3y9UVnLgKvE59A/sCVfuuDN/a82egI
         rlWm5xz3FWtvJO8zeEp3MvRqK9JkfBInQqvQGu5RG0wveOFjOnI6z68vlpFbiLnJRXH3
         JZf+iiln78w/4ZCDh3ox0VLfpjb4uHrZBOj4xLD5cewyzDvc+npYbBHAxcEdaU1ur8d/
         3pnirreV+XhCYTlzF27qgi/Z644EW3rp9hZOQLPwcF44O2gGgleX9a47BagDPqXu2N2O
         InVkOT51Z3wkcOaMfn7K8NSuj/rgYSWCdGHSxcGDJSX0+wbAeLxWkr3m816JegdAUWGb
         YJrg==
X-Gm-Message-State: APjAAAU4Mj3iO8ZysbWrEbexnMcwIe5VP9KjKmeDUFwaJd/DniOkHXlh
        Y++yHDlt+WBUgrZRh3HGFPc/Vw==
X-Google-Smtp-Source: APXvYqzcXDlL9EfEPDbT8ec8JfIiOjcIeAoXu12dG22SBfYFW7LzFWn8hWSWuniHIINm1Ku+0eA7YQ==
X-Received: by 2002:a63:753:: with SMTP id 80mr15150274pgh.95.1576478842024;
        Sun, 15 Dec 2019 22:47:22 -0800 (PST)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id g7sm20758515pfq.33.2019.12.15.22.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 22:47:21 -0800 (PST)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     nsaenzjulienne@suse.de
Cc:     andrew.murray@arm.com, bcm-kernel-feedback-list@broadcom.com,
        devicetree@vger.kernel.org, eric@anholt.net, f.fainelli@gmail.com,
        james.quinlan@broadcom.com, jeremy.linton@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        mark.rutland@arm.com, maz@kernel.org, mbrugger@suse.com,
        phil@raspberrypi.org, robh+dt@kernel.org, wahrenst@gmx.net,
        linux@endlessm.com
Subject: Re: [PATCH v4 2/8] ARM: dts: bcm2711: Enable PCIe controller
Date:   Mon, 16 Dec 2019 14:46:38 +0800
Message-Id: <20191216064638.5067-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191203114743.1294-3-nsaenzjulienne@suse.de>
References: <20191203114743.1294-3-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks for your effort! System can have USB with this patch series, if the device tree is modified properly.
Here is the question: Will not the device tree "scb/ranges" in this patch conflict with commit be8af7a9e3cc ("ARM: dts: bcm2711-rpi-4: Enable GENET support")?

Jian-Hong Pan
